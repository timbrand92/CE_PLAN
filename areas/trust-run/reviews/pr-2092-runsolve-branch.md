# Review: PR 2092 `claude/trust04-b1355-runsolve-branch` (BUG-1355: CDRUNSOLVE follows whichever pipe is listed first at a branch), head `0f496074`

**Reviewer:** trust-review helper. **Written:** Fri 13 Nov 2026, 22:46 PC clock. **Base:** `cf059dcf` (installed Civil 3.0.90); one commit on top. The three product files it touches are byte-identical between `cf059dcf` and the trial build on Tim's PC (`9714ffdd`, Civil 3.0.90.2). Draft. Read only: no build, no test run, no AutoCAD. **Lane that owns the branch:** trust-safety-fixes (its 11:47 line: built, 79 of 79 unit tests, broken twin 2 of 5 fail).

**Verdict: FIX FIRST.** The fault is real and the change stops CDRUNSOLVE guessing on the plain case it was written for (no LPD, one branch reaches the pit you pick). But the line it prints tells the drafter to do something CDRUNSOLVE never lets them do whenever the drawing has an LPD, it can contradict itself on the very next line, and the preview window (where the drafter actually decides) still says the run reached a council connection. Four fixes below.

---

# FOR TIM

1. **The fault is real.** At a pit with two pipes leaving it (a split, an overflow, a bypass), CDRUNSOLVE solves invert levels down whichever pipe happens to be first in CE's list. Nothing tells you. On a job that means new inverts written down the wrong leg.
2. **What the change does:** it now follows the leg that leads to the end pit. If it cannot tell (both legs lead there, or no end pit), it stops at the split and says "The run stops at pit P5: 2 pipes leave it ... Run CDRUNSOLVE again and pick an end pit on the branch you want."
3. **The catch:** when your drawing has an LPD, CDRUNSOLVE never asks for an end pit; it always stops at the LPD. So that advice cannot be followed. Run it again and it stops at the same pit, every time.
4. **Two smaller faults:** if the split is at the pit you started from, the next line says that pit "has no outgoing pipe", straight after saying two pipes leave it. And the preview window calls the split pit a "connection pit" and says "council assets untouched", so a part-run solve looks like a full one.
5. **My recommendation:** at the split, ask you which pipe the run follows (Esc cancels, nothing changes). That works with or without an LPD. The bug entry already offers this as the right answer.

---

# Findings (file and line at `0f496074` unless marked `9714ffdd`)

## 1. Is the fault real in the installed code, and by which path

1. **Confirmed by reading, two levels deep.** `Commands/RunSolveCommand.cs` (`9714ffdd`) line 96 calls `ProposalApplyService.WalkDownstreamRun(startPitId, allPipes, endPitId)`. In `Services/ProposalApplyService.PlanBuilders.cs` (`9714ffdd`) the walk takes `allPipes.FirstOrDefault(p => p.From == currentPit)`: the first pipe in CE's stored list leaving each pit, with no look at the other.
2. **Where the run goes next:** the walked pipes become the run (RunSolveCommand.cs `9714ffdd` 96 to 116), `BuildRunInputs` anchors the solve on the last pipe's downstream pit (PlanBuilders `9714ffdd` 569 to 581), and Apply writes the solved inverts (RunSolveCommand.cs `9714ffdd` 196). So a wrong leg means real invert changes on the wrong pipes, behind a preview that looks normal.
3. **No other product code calls the walk:** `git grep` finds only `RunSolveCommand.cs` and the tests.

## 2. Does the fix close it on every path

1. **Closed for the plain case:** no LPD, the drafter picks an end pit, exactly one leg leads to it: the walk follows that leg (PlanBuilders 505 to 517, reach search 538 to 561). A pit with one pipe leaving it is walked as before.
2. **Open: the drawing has an LPD.** `TryResolveEndPit` (RunSolveCommand.cs 244 to 253) takes the LPD and returns without asking. With an LPD, the walk stops at a split when both legs lead to the LPD (a loop that rejoins, two pipes side by side) or neither does (the start pit is on a network the LPD is not on). The stop line (PlanBuilders 564 to 568) says "Run CDRUNSOLVE again and pick an end pit on the branch you want". No end pit question will come. The run stops at the same pit forever, and the line printed a moment earlier says "LPD found at ... - the run will stop there" (line 251). PR 2058 (step 7) makes the confirmed LPD win the same way, so this stays true after both land.
3. **Open: two pipes from the same pit to the same next pit** (side by side, or a copied record). Both "reach" any end pit, so the walk always stops there, and no end-pit pick can ever settle it. Before the change the run carried on. No test covers it.
4. **Still a guess at one kind of pit:** a pit with one real pipe and one pipe whose far end is blank or "-" still takes whichever is listed first (PlanBuilders 499 to 504). If the blank one is first, the run stops there silently. This is today's behaviour, not new; worth knowing, not blocking.

## 3. Cancel, Escape, locked layers

1. **Unchanged and sound.** The walk is pure (memory only). The stop line is printed before the preview. Cancel or Escape at the preview still puts the held record back (`refreshHold.Dispose`, line 217) and prints "Cancelled - drawing unchanged". Apply is untouched, so locked-layer and Xref handling are as installed.

## 4. One code path per behaviour

1. **Kept.** One walk; the old three-argument version now hands on to the new one (PlanBuilders 468 to 470). The reach search is new but there is no other downstream-reach helper in Civil to reuse (searched).
2. **Side effect of the hand-on:** the old version now also stops silently at a split. Only tests call it, so nothing a drafter runs is affected.

## 5. Settings and hard-coded values

1. **No new setting, no engineering value.** The change decides only which pipes are in the run.

## 6. Wording the drafter sees

1. **The stop line is plain** and names the pit and both pipes by their pit numbers. Its advice is wrong whenever there is an LPD (section 2 item 2).
2. **Contradiction at the start pit:** if the split is at the start pit the run is empty, so line 101 prints the stop line ("2 pipes leave it") and line 104 then prints "Pit 'P1' has no outgoing pipe - nothing to solve."
3. **The preview window hides the stop:** when the run stops at a split, the anchor is the split pit, which is not the end pit. Lines 159 to 163 then label it "connection pit" and add "run ends at the connection - council assets untouched." The stop line is on the command line, behind the modal window. A drafter who reads only the window applies a part-run solve anchored on the split pit's present invert, thinking it reached the LPD.
4. **Same root, failure path:** if the split pit has no invert level, the failure line (PlanBuilders 655 to 659) says "set the connection IL first (e.g. the council connection invert from the drawing)", which is the wrong advice for a split pit.

## 7. Tests

1. **Real:** the three split tests fail on the old walk by reading (it returns P5, P6 every time), and the "ordinary run" test pins the unchanged case. The existing walk tests are untouched and still fit (checked `WalkDownstreamRun_BranchingNetwork_*` and `*_BlankOrDashTo_*` against the new walk).
2. **Thin where the faults are:** no case with an LPD, no split at the start pit, no two pipes to the same pit, nothing on the preview words. The command test only checks that two lines of source text exist.
3. **Only AutoCAD can prove:** that the line shows before the window, that the preview covers only the part run, and how CE stores real drawings' pipes at a split (order in the list against drawing order).

## 8. Risk to normal use

1. **Low on a plain tree network** with one outlet and no LPD: as before, or better.
2. **Medium with an LPD:** any job where a split's legs both meet again before the LPD, or the start pit is on a network the LPD is not on, used to solve (down a guessed leg) and now cannot be solved past the split at all, with advice that cannot be followed.

---

# FIX FIRST

1. **`RunSolveCommand.cs` around line 98 to 101, with `PlanBuilders.cs` 505 to 517 and 564 to 568: make the split stop followable with or without an LPD.** Recommended: at the split, ask which pipe the run follows, naming each pipe by its pits (for example "Which way from P5? [to P6 / to P9]"), with Esc cancelling and nothing written (the record hold already covers it). Keep the stop line only for Enter. Smallest acceptable alternative: words chosen by case, so that with an LPD, and with two pipes to the same pit, the line never says "pick an end pit".
2. **`RunSolveCommand.cs` lines 101 to 106:** when the walk stopped at a split, do not print "has no outgoing pipe". When the split is at the start pit, the stop line alone is the answer.
3. **`RunSolveCommand.cs` lines 159 to 167:** when the walk stopped at a split, put the stop line into the preview's warnings, and name the anchor "P5, where the run stops (2 pipes leave it)", not "connection pit", without "council assets untouched". If the split pit has no invert, say that, not "set the connection IL first".
4. **`Trust04B1355RunBranchTests.cs`:** add cases for (a) an LPD as end pit with both legs reaching it, and with neither; (b) a split at the start pit; (c) two pipes from P5 to P6; (d) the preview warning when the run stops. Each must fail on today's head.

# Worth knowing (not blocking)

1. **Blank-ended pipe at a pit** (section 2 item 4): if a pit has exactly one pipe with a real far end, follow that one rather than the first listed. The existing blank-end test still passes with that change.
2. **Merge joins:** PR 2058 rewrites the top of `TryResolveEndPit` in the same file; PR 2065 edits the preview words in `PlanBuilders.cs` 105 to 112. Text conflicts likely, no clash of behaviour by reading.
3. **The PR's AutoCAD steps** cover only the no-LPD case. The robot case list should add the LPD case and the start-pit split once the fixes land.

# Could not verify

1. The build and the 79 tests (no build or test run, by rule).
2. Whether real CE drawings hold two pipe records with the same From and To (twin barrels may be one record with two drawn lines; not traced).
3. Behaviour on AutoCAD 2022 to 2024 (net48); the change is pure code, so no difference is expected.
