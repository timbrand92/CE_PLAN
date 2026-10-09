# Claude driver run 7, Saturday 10 Oct 2026 (PC clock 04:24 to 04:37)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 7, Sonnet, headless. Goal: settle BUG-558 "a CD / New Pipe / PIT use in the Civil drawing makes a later drawing switch lose REDO". Driver: `acad_driver_witness.ps1` only (through a counting wrapper). `esc` was tried once on a test copy. Test copies only, nothing saved. `Get-Process acad` showed nothing running first. Tim's drawings and settings were not touched. I did not bypass the driver (no own UI Automation, no SendKeys, no PostMessage, no allow-list edit).

## Answer first

1. **Unproven. The test that matters (CD, then the New Pipe window, then a drawing switch) could NOT be run, because the driver refuses to touch the New Pipe window.** `ui tree` and `ui close` both answered: "REFUSED: window 'New Pipe' is not allowed (title is not on the CE window allow-list)". The driver now FINDS the window (`ui windows` lists it: source win32, owned_window true, on the second monitor), so the run 5 gap is fixed, but the window is not on the allow-list, so no control can be read or typed. Per the rules I stopped that journey. That is a finding for the tooling worker and the desk (one allow-list line, a reviewed change).
2. **The lighter cases did NOT lose REDO.** On the Structural plain circle, U, 15 s, switch to Civil and back, REDO:
   1. **Control, no CE command used on Civil (witness loaded): REDO kept.** The REDO changed CIRCLERAD (the sign of a REDO that worked).
   2. **After a PIT used on Civil (New Pit window opened with a typed point, then closed with "Cancel without saving", nothing placed): REDO kept.** AutoCAD printed "Everything has been redone".
   3. **So a PIT window opened and cancelled does not cause the loss.** A PIT that actually places a pit was NOT tested: the "Continue placement" button goes on to ask in the drawing and the UI map says never to press it on a test run.
3. **The witness shows no `VIEWBACKSTATUS` at any switch in this run** (0 on both drawings), the same as run 6, and unlike run 5 (three per drawing). Run 5 remains the only run that lost REDO and the only one that had a CD pipe placed through the New Pipe window.
4. **Journey 3 (REGEN spoiler): PASS.** The witness shows the REGEN between the U and the REDO, AutoCAD says "Nothing to redo", and the reader says FAIL naming the REGEN at 5.87 s after the U (the wanted answer).
5. **Journey 1 (calibration): C4 FAILS. The recorder is blind to a real change.** C4 really changed the circle (the LISP reply showed colour 62 = 1 added) and the log has NO ObjectModified line, only LispWillStart and lock lines. There are also no object events for the circle being drawn or undone. By the pilot's own rule: stop, the recorder cannot see object changes in this build. **So "the witness saw no CE change between U and REDO" (runs 5 and 6, and this run) only means no command, no system variable and no view event. It does not prove CE moved nothing.**
6. **Counts:** journey 5 (CD, New Pipe, switch): BLOCKED twice (see below). Step 2 (repeat with PIT): the PIT variant ran (cancelled window only). Journey 3: PASS. Journey 1: C1 to C3 ok, C4 FAIL (recorder blind). **Driver calls: 71 counted by the wrapper, of which 70 touched AutoCAD and 1 was the offline `witness check`** (cap was 70 in total; I am one over if the offline check counts). Per journey: first CD attempt 17, second CD attempt 16, journey 3: 10, journey 1: 4 (run inside the journey 3 session), control 6, PIT variant 9, after-reads and quit 8, setup 1.
7. **AutoCAD is closed and the lock is released** (see the last line).

## Versions (readdll.ps1, 10 Oct)

1. Civil CE_CVL_SUITE 3.0.41+660487d1 (Legacy 571ADF2A58D1, Net8 4AD251C985D4, Modern D48BE73F9D31). Manager CE_SUITE_MANAGER 1.1.41+660487d1 (286B5BDF8125, 042A61133B2A, 974024840468). Structural CE_STRUC_SUITE 1.0.110+9babe787 (C892E20339E0, 586F6ECB6734, 755D88C401CD). The same as run 5.

## The CD and New Pipe journey, step by step

1. **Setup:** `CLD15_B1` from DRV1_B1 (34BBE37C2EA4) and `CLD15_S1` from DRV2_S1 (950AFDF6E523), hash-checked. `witness check` ok (pin AD8A22D3...). `launch` 24 s, no What's New window. `witness load` 1.1 s, SECURELOAD 0, no prompt. S1 opened writable in the same session.
2. **First attempt (the journey's own line) FAILED to open the window:** `type "CD 54436.3,-69493.6 64028,-69576.4" -Enter -Force -ExpectWindow "New Pipe"`. The space acts as an Enter in AutoCAD, so the first point took the space and the final Enter went to the second point. CD then sat at "Select point 3 (or Enter for straight pipe)" and nothing could answer it. The call returned at 32 s with the ALARM, and `window_appeared false`. **That is a fault in the draft journey line, not in CE.**
3. **`esc` refused (as designed):** "the newest command-line lines show no CE prompt waiting, so this is not a CE command ... No key was sent." The point-3 prompt is not printed as a `[CE]` line, so the rule that `esc` only works at a `[CE]` prompt does not cover it. `cancel` was not usable (alarm). I used `quit -Kill` on the AutoCAD the driver launched (allowed, killed true). **Finding:** this form leaves a prompt that only a bare Enter can answer, and the driver has neither a bare Enter nor an `esc` that covers it.
4. **Second attempt with newlines (this works):** `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`. Printed: "Select point 3 (or Enter for straight pipe):" then "[CE] Pipe end moved to the inside wall of P10 (was 225 mm inside the pit)." and the window appeared in about 10 s, no alarm. **Use this form in the journey file.**
5. **Then step D2 stopped:** `ui tree "New Pipe"` and `ui close "New Pipe"` both refused (title not on the allow-list). `ui windows` lists it: `source win32, owned_window true, bounds 2016,50 1728x972, allowed false`. `ui windows` is the answer to "was the New Pipe window found by the driver": **yes, by the Win32 list, as an owned window**. `esc` could not be used for it (the main window is disabled while the window is up, and `esc` refuses that case).
6. **Ended with `quit -Kill`** (second time). Nothing was placed on that copy. `quit -Kill` skips `restore`, so the driver's FILEDIA / LOGFILEMODE restore was skipped for those two sessions; the final clean `quit` at the end of the run restored LOGFILEMODE (reads back 1) and nothing else was recorded as changed.

## The separating cases (Structural plain circle, witness loaded, one AutoCAD, both drawings writable)

Same method as runs 3 to 6: `_.CIRCLE`, `U`, 15 s, `open` Civil, `open` Structural, `REDO`.

1. **Control (no CE command used on Civil in this step):** U at 04:34:07, REDO at 04:34:27. REDO printed "CIRCLE" and the witness shows `CIRCLERAD` changed on the REDO. Kept. (The Civil copy had one LISP selection and entmod from journey 1, no CE command.) The echo line "Everything has been redone" was cut off by my line limit in this case; the CIRCLERAD change on the REDO is in the witness log and CIRCLE was echoed, so I count it as kept, but I did not read the history to see the exact sentence.
2. **After PIT on Civil:** `type "PIT`n10000,-90000" -Enter -ExpectWindow "New Pit"` (window appeared), `ui click "New Pit" "Cancel without saving"` (InvokePattern, 1 match, ok), then the Structural circle, U at 04:35:09, REDO at 04:35:30: **"CIRCLE" and "Everything has been redone". Kept.** The Civil witness log shows `CommandWillStart PIT` then `CommandEnded PIT` 15 s later and nothing else, and no `VIEWBACKSTATUS` on either drawing.
3. **Not run (no calls left, or blocked):** the case after a CD pipe actually placed; a PIT that places a pit; the Civil circle (journey 5's own T1); a 66 s wait.

## What the witness shows

1. **Structural log, control and PIT cases:** CIRCLE, U (CIRCLERAD changed), then nothing at all, then REDO (CIRCLERAD changed). No `VIEWBACKSTATUS`, no autosave, no CE line between U and REDO. The Civil log at the switches also shows nothing.
2. **Journey 3, Civil log:** U ends 04:32:46; `REGEN` starts 04:32:52 (5.87 s after the U); REDO at 04:33:00. The reader (`Test-WitnessRedo.ps1`, exit 1): "FAIL: walk 1 of 1 at 04:32:52 (5.87 s after U ended): LockModeChanged (command 'REGEN', Write -> NotLocked), so REDO did not follow straight after the undo. first offending event: seq 17". It names the lock line before the CommandWillStart (seq 18); that is the line the pilot expected to be ignored or accepted. **The reader flags the REGEN, but through its lock-change line, not the command-start line.** Whether that is the wanted wording is for the tooling worker.
3. **Journey 1:** C2 (entget) shows LispWillStart and no ObjectModified (as expected). **C3 (entmod writing back the same data): no ObjectModified.** **C4 (a real change, colour added): no ObjectModified either.** Event counts for the whole log: CommandEnded 6, CommandWillStart 5, DocumentAttached 1, LispWillStart 3, LockModeChanged 19, SysVarChanged 3. There is not a single object event. This also means the recorder shows nothing when the circle is drawn or undone, only the command and the system variable.
4. **The reader can read a log AutoCAD still holds open** (the fix from run 3 works): I read both logs during the run.
5. **Logs kept** (names and timings only): `release-v3-colleagues-CLAUDE_DRIVER_RUN7_witness_B1.jsonl` (journey 3 and 1 session, then PIT) and `..._witness_S1.jsonl` (the control and PIT cases) in this folder, plus `pilot_keep_WIT3_B1.jsonl` in `C:\ce_rc_scratch\witness`. Both copies in this folder were taken after the run, so the PIT lines are in the Civil copy.

## System variables

1. **Before (read with the driver, first session):** Civil OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". Structural OSMODE 5375, SAVETIME 5, CLAYER "0". Read again in the second session before the CD attempt: the same values.
2. **After (clean final session, both drawings read before quit):** Civil OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS"; Structural OSMODE 5375, SAVETIME 5, CLAYER "0". **Unchanged.** I used no `setvar`.
3. **Caveat:** the "after" reads were taken in the last session, after journeys 3 and 1 and the PIT cases, not in the two sessions that ended with `quit -Kill`. The first two sessions were killed before an after-read, but nothing was placed or changed in them.

## Driver could not (findings for the tooling worker)

1. **New Pipe is not on the `ui` allow-list.** The window is now found (win32, owned), but `ui tree`, `ui type`, `ui click`, `ui close` all refuse it. To run the CD pipe journey, one reviewed allow-list entry (`New Pipe*`, with the Save/Delete deny list unchanged) is needed. I did not add it.
2. **The journey 5 line for D1 is wrong** (space-separated points leave CD at point 3). Use the newline form above.
3. **No Enter and no `esc` for CD's point-3 prompt.** `esc` refuses because that prompt is not a `[CE]` line. A one-line CD chain that ends the pipe with an Enter is the workaround.
4. **`quit -Kill` skips `restore`.** A killed session leaves the driver's recorded FILEDIA, LOGFILEMODE and CMDECHO unrestored until the next clean quit. Harmless here (the last `quit` restored LOGFILEMODE), but worth knowing.
5. **Recorder blind to object changes** (journey 1, C3 and C4).
6. **A `type` result is cut short by `Select -First N` in my wrapper**: my own doing; it cost me the exact "Everything has been redone" sentence in the control case.

## What I could not prove

1. **Whether a CD pipe placed through the New Pipe window makes a later switch lose REDO.** Not run (the driver refuses the window). The lighter variant (PIT window opened and cancelled) does not.
2. **Whether PIT that actually places a pit does.** Not run (placing needs "Continue placement", which asks in the drawing; the UI map forbids it).
3. **Whether run 5's loss was something else in its session** (it also had the CD Esc sent by SendKeys, focus changes and a second Claude session on the PC). Not testable now.
4. **Whether the recorder would have seen a CE object change** between U and REDO: it would not (journey 1).

## Recommendation

1. **Desk:** decide whether `New Pipe*` goes on the driver's `ui` allow-list (reviewed, with the deny list unchanged). Without it the one case that separates run 5 from runs 6 and 7 cannot be run safely by a Claude tester.
2. **Fix journey 5's D1** to the newline form, and decide what ends the CD command (CD asks for the next pipe after one is placed; `esc` should be allowed there, which it is, because that one IS a `[CE]` line).
3. **BUG-558:** add "run 6: REDO kept 3 of 3 (untouched, after a MOVE, no switch); run 7: kept after control and after a cancelled PIT; run 5 (lost 4 of 4) is the only run with a CD pipe placed through the New Pipe window and three VIEWBACKSTATUS per drawing; the recorder cannot see object changes".
4. **Recorder:** add object events (ObjectModified, ObjectAppended, ObjectErased) before relying on it as a witness for "nothing touched the drawing".

## Summary

Claude ran run 7 with the witness driver copy only, using 71 counted calls (70 into AutoCAD plus the offline `witness check`, one over the cap if that counts), and closed AutoCAD with nothing saved and OSMODE, SAVETIME and CLAYER unchanged on both drawings. The CD and New Pipe journey could not be completed: the draft's one-line CD form left CD waiting at its third-point prompt (fixed with a newline-chained form that opens the window), and then the driver found the New Pipe window but refused `ui tree` and `ui close` because "New Pipe" is not on its allow-list, so the controls could not be typed and I stopped that journey as instructed without bypassing the driver. The lighter cases did not lose REDO: a Structural circle, U, 15 s, switch and back kept it both as a control and after a PIT window was opened and cancelled on Civil, with no `VIEWBACKSTATUS` event, so the hypothesis is not settled and the only unexplained loss remains run 5's, the only run with a CD pipe placed through the New Pipe window. Journey 3 passed (the witness and reader show the REGEN between U and REDO), while journey 1 found that the recorder shows no object changes at all (C4's real colour change left no ObjectModified line), so "the witness saw nothing" is weaker evidence than runs 5 and 6 assumed.

**AutoCAD is closed and the lock is released: you can install Civil 3.0.42 / Structural 1.0.111 now.**
