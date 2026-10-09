# Claude driver run 4, Friday 9 Oct 2026 (PC clock 23:23 to 23:29)

**Question:** can run 2's exact order be repeated to bring back the lost REDO (Civil, U, switch drawing, switch back, REDO says "Nothing to redo")? Sonnet, headless, test copies only. Nothing saved.

## Answer first

1. **NOT REPRODUCED, again.** I repeated run 2's order on fresh copies and REDO survived the drawing switch both times on the Civil copy (and on the Structural copy). No step lost it, so there is no "first step" to isolate, and the control repeats (Structural copy, Civil after a fresh restart) were not needed.
2. **The one AutoCAD refusal I did see is the known autosave one** (step 3 below), and it is AutoCAD's own rule, as run 2 proved with a plain circle.
3. **Driver invocations: 40 of 40**, counted per individual call by a wrapper counter file. The cap was not exceeded. That left no call for a final read of OSMODE, SAVETIME and CLAYER (see "What I could not prove").
4. **AutoCAD is closed** (driver quit, 2 drawings closed without saving, CloseMainWindow, no kill, no acad process left, lock released).

## Setup

1. **Copies (hash-checked):** CLD12_B1.dwg = DRV1_B1 (34BBE37C2EA4, Civil, missing background xrefs); CLD12_S1.dwg = DRV2_S1 (950AFDF6E523, Structural). Both opened writable in one AutoCAD (explorer hand-off, 27 s, pid 54560). No "D new", no COPY.
2. **Before:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS.
3. **Pit** P3 (handle 109D56) was selected for each MOVE with the same select line as run 3: `(sssetfirst nil (ssadd (handent "109D56") (ssadd)))`.

## Run 2's sequence, step by step (Civil copy CLD12_B1 unless stated)

1. **UNDO 2 then REDO: PASS.** `_.MOVE 0,0 1000,0`, `_.MOVE 0,0 0,1000` (each printed the CE line "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is"). `_.UNDO 2` printed "MOVE MOVE". After 12 s `REDO` printed "MOVE MOVE" and "Everything has been redone".
2. **SAVETIME 1, MOVE, U, long wait with autosave, REDO: same as run 2.** `SAVETIME 1` printed "Automatic save ..." straight away. MOVE, `U` ("MOVE"), 80 s untouched. The history showed a second "Automatic save to ...CLD12_B1_...sv$" and then `REDO` printed **"REDO must immediately follow the U or UNDO command."** (AutoCAD's own refusal, not the "Nothing to redo" of the lost case.)
3. **SAVETIME back to 5: done.** Typed `SAVETIME 5`; AutoCAD printed "Enter new value for SAVETIME <1>: 5".
4. **U, switch drawing, switch back, REDO, on Civil: PASS.** `_.MOVE 0,0 1000,0`, `U` ("MOVE"), 12 s, opened CLD12_S1, opened CLD12_B1, `REDO` printed "MOVE" and "Everything has been redone". REDO echo recorded after every step above.
5. **Extra, run 2's check 3 order (Structural circle first, then Civil): PASS twice.** Structural: `_.CIRCLE 0,20000 10`, `U` ("CIRCLE"), 12 s, switch to Civil and back, `REDO` printed "CIRCLE" and "Everything has been redone". Straight after, Civil: pit MOVE, `U`, 12 s, switch to Structural and back, `REDO` printed "MOVE" and "Everything has been redone".

## Results

1. **PASS 5** (steps 1, 3 (SAVETIME restore), 4 and both halves of 5), **AutoCAD's own refusal 1** (step 2, known), **FAIL 0**, BLOCKED 0.
2. The lost REDO has now been tried in runs 3 and 4: 0 failures in 10 attempts after run 2's 3 of 3. Run 3 and run 4 both started from a fresh AutoCAD launch on fresh copies; run 2 had been in a long session that also held a blank Drawing1 and a Structural circle test with autosaves.

## What I could not prove

1. **Why run 2 failed.** Still unknown. The remaining differences from run 2 are the long session before the test and the blank `Drawing1` made by `D new` (not allowed this run). I did not test those.
2. **Final variable readback.** My 40 calls were used before I could read OSMODE, SAVETIME and CLAYER at the end. I only changed SAVETIME (to 1 and back to 5, confirmed by AutoCAD's own prompt "<1>: 5"). OSMODE and CLAYER were never changed by me. The driver's quit restored LOGFILEMODE.
3. **The pit position after each redo** was not read (reading would risk the REDO); I used the echoes only.

## Recommendation

1. **Close this question as "not reproduced in two fresh runs; do not open a CE bug."** If Tim ever sees "Nothing to redo" after switching drawings, ask what he did first (long session, autosave, a blank drawing open).
2. **If the desk still wants it closed:** one run that makes a blank Drawing1 first and sits for 30 minutes before the test, and that needs the driver to be allowed to close a blank unmodified Drawing<N>.
3. **Driver note:** the wrapper counter (a counter file in the scratchpad) worked; the driver itself should have one. `quit` removed 3 stray logs in `C:\lisp files\ce_acad_plugin` (harmless).

## Summary

Claude repeated run 2's exact order (UNDO 2 then REDO, SAVETIME 1 then 5 with an autosave in the wait, U, switch drawing, switch back, REDO) on fresh hash-checked Civil and Structural copies in one AutoCAD 2027, using exactly 40 driver calls. The lost REDO did not reproduce: REDO printed "Everything has been redone" after the switch on Civil twice and on Structural once; the only refusal was AutoCAD's own "REDO must immediately follow the U or UNDO command" after an autosave in the 80-second wait, which is known and not CE's. Because nothing failed, the control repeats were not needed; the cause of run 2's failure remains unproven and likely tied to that long session. AutoCAD was closed cleanly, nothing was saved, SAVETIME was restored to 5, and the final OSMODE/CLAYER readback did not fit in the call cap.
