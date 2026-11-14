# Review: draft 2092 at 45119e00 (CDRUNSOLVE reads each pipe's Q from Pipe Edit)

**Sat 14 Nov 2026, about 17:05. Read-only review by a helper (opus) for the controller, of `git diff d686e787 45119e00`. Nothing was run: no build, no test, no AutoCAD.**

**Verdict: GO for the no-window proof and a trial build. Two things to fix first so the evidence does not overclaim.**

## To fix
1. **The no-window proof claims more than it tests** (`RunSolveFlowChecks.cs` about lines 114 and 127). It writes the flow straight into records in memory and calls the inner steps; it never goes through Pipe Edit, the drawing sync, the record hold or the command. "Changes nothing" is not checked, only the refusal words. Reword to "the solve inputs and the solver give each pipe its own Q"; leave "Pipe Edit to CDRUNSOLVE" to real AutoCAD.
2. **Two tests read source text, not behaviour** (last two in `Trust04B1355RunFlowTests.cs`). They do not prove the refusal comes before any write.
3. **Rounding** (`PlanBuilders.cs` about 692, 725, 774): 0.04 L/s is used but shown as "0.0 L/s"; 5.04 then 5.01 is refused as "5.0 ... 5.0". Show two decimals or round before both check and display.
4. **A negative or broken Q** is reported as "no design flow" (safe, misleading).
5. **A Q with no recorded source** is reported as "typed in Pipe Edit".

## Read and found correct
Single line of pipes (no double count, nothing negative); side branch joining; pipe drawn against the run (refused); two pipes arriving at a pit; units L/s throughout; refusals return inside the hold and write nothing; `BuildRunInputs` has no other production caller; plain wording.

## Suspected, not verified (real AutoCAD settles these)
1. Whether the drawing sync keeps a pipe's Q on its record. If it drops it, every run is refused.
2. A run that loops back to a pit already visited.
3. **Limit for Tim:** where flow splits at a pit (overflow or bypass) the lower pipe rightly carries less; that run is always refused. Safe, but a limit.
