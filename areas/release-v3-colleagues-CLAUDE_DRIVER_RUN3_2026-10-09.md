# Claude driver run 3, Friday 9 Oct 2026 (PC clock 23:05 to 23:10)

**Question:** is "U, switch to another drawing, switch back, REDO says Nothing to redo" (Civil, 3 of 3 in run 2) CE's doing or AutoCAD's own? Sonnet, headless, test copies only. Nothing saved. No real drawings or settings touched.

## Answer first

1. **UNPROVEN. I could not reproduce it.** On fresh copies, REDO survived the switch every time: **5 of 5 PASS** (3 Civil pit/circle cases plus the Structural control, plus the 4-second-gap case). Run 2 got 0 of 3 on Civil.
2. **So the evidence does not point at CE, and it does not point at AutoCAD either.** Something about the run 2 session state was different, and I cannot say what. The Civil drawing with its four missing background xrefs did not lose REDO this time.
3. **Driver invocations: 39 of 40.** Counted by a wrapper that writes every single call to a counter file (so batching cannot hide any). The cap was not exceeded.
4. **AutoCAD is closed** (driver `quit`, closed 2 drawings, no kill, no acad process left, lock released). All system variables were only read, never changed: OSMODE 5375, SAVETIME 5, CLAYER BLOCKS.

## Setup

1. **Copies (hash-checked):** CLD11_B1.dwg = DRV1_B1 (34BBE37C2EA4), CLD11_S1.dwg = DRV2_S1 (950AFDF6E523). Both opened in one AutoCAD (launched by explorer hand-off, 38 s, pid 54848, no What's New window). Opened with `-Writable`. No `D new`, no COPY.
2. **Each experiment:** the edit, `U`, 12 s wait, `open` the other copy, `open` the first copy again, `REDO`.

## The experiments

1. **Experiment 1, plain circle on the Civil copy (no CE command): PASS.** `_.CIRCLE 0,0 10`, `U` (echo "CIRCLE"), 12 s, switch to S1 and back, `REDO` printed "CIRCLE" and "Everything has been redone". So the missing xrefs did not stop it.
2. **Experiment 2, CE MOVE of pit P3 (handle 109D56) on the Civil copy: PASS, twice.** I selected the pit with `(sssetfirst nil (ssadd (handent "109D56") (ssadd)))`, then `_.MOVE 0,0 1000,0`, `U` (echo "MOVE"), 12 s, switch and back, `REDO` printed "MOVE" and "Everything has been redone". Repeated with `_.MOVE 0,0 0,1000`: same result. Repeatable: the pass is repeatable, the fault was not.
3. **Experiment 3, Pit Schedule never opened:** this was already the case in experiments 1 and 2 (it was never opened in the whole run), so it is covered by them. No separate call spent.
4. **Experiment 4, plain circle on the Structural copy: PASS.** `_.CIRCLE 0,20000 10`, `U`, 12 s, switch to B1 and back to S1, `REDO` printed "CIRCLE" and "Everything has been redone".
5. **Extra, run 2's fast form on Civil: PASS.** `_.CIRCLE 60000,-20000 50`, `U`, 4 s gaps between each step, `REDO` printed "CIRCLE" and "Everything has been redone". This is exactly the case that failed in run 2 (c).
6. **Experiment 5 (read the history if Redo is lost): not needed**, since Redo was never lost. I read the command history once anyway. Every REDO is there. Lines seen on the Civil copy: the pit MOVE prints "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border")" and four "[CE] Background not found: XW2626-Title Block / XW2614-Arch Survey / Ground / Site" lines. Between each `U` and the next command the history shows only empty "Command:" lines (the switches) and no CE line, no "Automatic save" line, no error. The history is that one drawing's log only, so it cannot list events in the other drawing.

## What differed from run 2 (candidates, none proven)

1. **Run 2 had done more on the Civil drawing first:** `UNDO 2`, and two autosaves (SAVETIME set to 1, then back to 5). An autosave or SAVETIME change before the test could have left state that run 3's fresh copy did not have.
2. **Run 2 may have had a blank Drawing1 open** (made later, but the session state was different).
3. **Fresh launch vs a long session:** this run was a brand new AutoCAD with new copies.
4. **I did not test these.** Testing them needs a run that repeats run 2's exact order (UNDO 2, SAVETIME 1 then 5, then the switch). Not attempted, to stay inside the budget and the brief's list.

## What I could not prove

1. **Why run 2 failed.** Not CE-proven, not AutoCAD-proven. It is possible run 2's 3 failures shared one cause that run 3 did not recreate.
2. **Whether CE logs anything at drawing activation.** No CE line appeared in the history at any switch, but the history only shows one drawing's log, and I did not look for a separate CE log file.
3. **The pit position after the redo** was not read (reading is a command and would not harm Redo, but I kept to the echoes only).

## Recommendation

1. **Treat the Civil REDO-after-switch as NOT reproduced; do not open a CE bug.** Keep the note in PENDING_TESTS: if Tim ever loses REDO after switching drawings, note whether an autosave or UNDO 2 came first.
2. **If the desk wants it closed:** one more run repeating run 2's order exactly (UNDO 2 then REDO, SAVETIME 1 then 5, then the switch on the same Civil copy).
3. **Driver notes:** the wrapper counter worked well; the driver should have one. `quit` this time worked cleanly and removed 8 stray logs in `C:\lisp files\ce_acad_plugin` (harmless).

## Summary

Claude ran 39 individual driver calls (cap 40) on fresh Civil and Structural test copies in one AutoCAD 2027 to find out whether Civil's lost REDO after switching drawings is CE's or AutoCAD's. It did not happen: a plain circle, a CE pit MOVE (twice), the fast-gap case and the Structural circle control all kept their REDO ("Everything has been redone"), 5 of 5, so the answer is unproven; the run 2 failure is probably tied to that session's earlier steps (UNDO 2, SAVETIME changes, autosave) rather than to the missing xrefs or a CE command, but that was not tested. AutoCAD was closed cleanly, nothing was saved, no system variable was changed, and the repeat of run 2's exact sequence is the only thing left to try.
