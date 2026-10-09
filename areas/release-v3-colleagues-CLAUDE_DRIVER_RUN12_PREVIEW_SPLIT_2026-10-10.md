# Claude driver run 12: the preview split test for BUG-558 (Sat 10 Oct 2026, PC clock 07:09 to 07:18)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 12, Sonnet, headless. `Get-Process acad` showed nothing before the start. Driver copy `acad_driver_witness.ps1` only, through a counting wrapper (59 of 60 calls, every call counted, refusals included; there were no refusals). Test copies only, hash-checked: `C:\ce_rc_drv\CLD20_B1.dwg` (34BBE37C2EA4 = DRV1_B1, Civil), `CLD20_S1.dwg` (950AFDF6E523 = DRV2_S1, Structural), and `CLD20_TGT.dwg` (D3E8FB4106D4, a blank Civil target copied from C:\ce_rc_vc7\NEWTGT_VC7.dwg, used for case B). All three were open in one AutoCAD (pid 57852, started by the driver). Nothing was saved. I did not go round the driver at any point.

## Answer first

1. **Does opening and cancelling the New Pipe window alone lose REDO? NO.** Case A: the Structural plain circle, U, 22 s, switch to the Civil copy and back, REDO printed **"Everything has been redone"**. The witness shows nothing at all between the U and the REDO on the Structural drawing (no `VIEWBACKSTATUS`).
2. **A pipe placed without the New Pipe window also keeps REDO.** Case B (the typed route that exists: COPYCLIP of 2 pits and 1 pipe from the Civil copy, PASTECLIP into the blank Civil target, then the circle/U/switch to that target/back/REDO): **kept 1 of 1 clean walk** ("Everything has been redone", about 14 s from U to REDO, zero `VIEWBACKSTATUS` on Structural). One more walk the same way was **spoiled by AutoCAD's own autosave** (see below), so it does not count.
3. **Case C, the control** (fresh session, Civil untouched, Structural circle, U, switch to Civil and back, REDO): **kept** ("Everything has been redone", 28 s from U to REDO). Zero `VIEWBACKSTATUS` between U and REDO.
4. **So the preview hypothesis is not supported by this run.** The plan preview was drawn (window open about 15 s, the 100 ms preview timer running, preview confirmed in the window tree) and cancelling it left REDO intact. What run 10 lost REDO on was a pipe PLACED through the New Pipe window by CD (2 of 2). The cause is therefore later than the preview: either the Start Pipe write path, the Design Warnings step, the "Pick the next pipe" loop and its Esc, or the leftover state of a completed CD. **Not proven either way**, because I did not place a pipe through the window in this run (the brief said no pipe placed).
5. **Side finding (BUG-560 came back on 3.0.44):** the same typed CD points as run 5 (54436.3,-69493.6 and 64028,-69576.4) now gave the window banner **"Neither end is on a pit, downpipe or outlet. Cancel and redraw the pip..."**, both ends "Unknown · IL Unknown", and the command line said "Pipe end moved to the inside wall of the pit" (no pit name P10 or P9, which run 5 and run 10 printed). So on Civil 3.0.44 the typed-points route no longer finds the pits. I did not check which build moved it.

## Versions (readdll.ps1, 10 Oct 07:09)

1. Civil CE_CVL_SUITE 3.0.44+b7eed253 (Legacy 6C9C91FA2FC4, Net8 0117F2EDD64E, Modern 37DCB42C8005).
2. Manager CE_SUITE_MANAGER 1.1.44+b7eed253 (Legacy 270EAFD07B7A, Net8 7F7BFED95C4D, Modern 762825AE390E).
3. Structural CE_STRUC_SUITE 1.0.113+2e0cf385 (Legacy 5AD4C11F5988, Net8 8E97370E6F56, Modern F72DAFEEF802).
4. Recorder: `witness check` ok_to_load, SHA256 49E79D6D... (the same as run 10); `witness load` 1.2 s, no prompt, SECURELOAD 0. It attached to each drawing opened afterwards.

## The cases in order

**C (control), 07:11 to 07:12.** Civil copy open and untouched (the Civil log holds only `DocumentAttached` until case A). Structural `_.CIRCLE 0,40000 10`, `U` (echo "CIRCLE"), switch to Civil and back (`open`), `REDO` at 07:12:21: "Everything has been redone". Structural log between the U (seq 44, 07:11:53.718) and REDO (seq 48): only `HookCounts` and `LockModeChanged` lines. **Kept.**

**A (open New Pipe, preview, cancel), 07:13 to 07:14.**
1. `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`: window appeared in 7 s. CD printed "Select point 3 (or Enter for straight pipe):" then "[CE] Pipe end moved to the inside wall of the pit (was 225 mm inside the pit)."
2. Waited 5 s, then `ui tree "New Pipe" -Depth 6` (97 nodes): the window had its PLAN PREVIEW group with two ends ("Unknown · IL Unknown" twice), a caption "Real plan, north up...", the banner above, and the button `Cancel without saving` (`C2.CancelCommand`). So the preview was built.
3. `ui click "New Pipe" "C2.CancelCommand"` (InvokePattern, 1 match). `wait`: idle. History: "[CE] CD command cancelled." No pipe placed, no Design Warnings window.
4. Structural `_.CIRCLE 0,40100 10`, `U`, 13 s sleep, `open` Civil, `open` Structural, `REDO` at 07:14:39: **"Everything has been redone"**. Witness (Structural): `CommandEnded U` seq 112 at 07:14:15.727, `LockModeChanged #U`, then `LockModeChanged REDO` at 07:14:39.236 and `CommandWillStart REDO`. **No `VIEWBACKSTATUS` on either drawing in this window of time.** (VIEWBACKSTATUS appeared only at other times: three when each newly opened drawing loaded, and the Civil log's single one at 07:15:37 came from my own `_.ZOOM` in case B.)
5. The Civil witness log of the CD itself: `CommandWillStart CD` 07:13:13, a few `ObjectOpenedForModify` / `ObjectModified` (CD opens and edits some objects while it runs even when later cancelled), OSMODE changed twice (CD's own snap changes, put back: OSMODE read 5375 after), `CommandEnded CD` 07:13:46. DBMOD stayed 1 on the Civil copy after the cancel.

**B (a pipe with no New Pipe window), 07:15 to 07:17.**
1. **Is there a typed route?** Yes: the one in TYPED_FORMS section 3 (the #550 paste route). CD itself always opens New Pipe, so it is not one. COPYCLIP then PASTECLIP needs LISP (`-AllowLisp`, allowed) and is a real Windows clipboard copy.
2. On the Civil copy, one LISP line: `_.ZOOM _W` onto the two-pit window, `ssget` the window, report handles, `COPYCLIP`. Printed `SEL 45` (TYPED_FORMS says 46; one object less), `109D56 IN`, `109768 IN`, `109E23 IN`, `109835 out`, `10A98D out`; "45 found". DBMOD went to 17 on the Civil copy (the zoom).
3. `open` the blank target, then `(progn (command "_.PASTECLIP" (list 0 0 0)) (princ))`: "[CE] 2 pits and 1 pipe just pasted are not in the schedule yet: run CDREPAIR." No window, no prompt left open. So a CE pipe now exists in a Civil drawing that never saw the New Pipe window.
4. **Walk 1 (spoiled):** Structural circle `0,40200 10`, U (07:16:14), 18 s, `open` target, `open` Structural, `REDO`: **"REDO must immediately follow the U or UNDO command."** The witness explains it: `LockModeChanged AUTO_SAVE` at 07:16:31.364 on the Structural drawing, 17 s after the U, with a burst of about 60 object events, then `LockModeChanged #AUTO_SAVE`, then REDO at 07:16:32. That is AutoCAD's autosave (SAVETIME 5, the session was 5 minutes old), exactly the spoiler run 2 measured. **Not a BUG-558 data point.** No `VIEWBACKSTATUS` in this window either.
5. **Walk 2 (clean):** circle `0,40300 10`, U (07:16:54), switch to the target and back, `REDO` at 07:17:08 (14 s after the U): **"Everything has been redone".** Between U (seq 289) and REDO (seq 293): only `HookCounts` and lock lines. **Kept.** (This walk was 14 s, not 15, because I shortened the sleep after the autosave scare; the loss in runs 5 and 10 did not depend on time.)

## System variables (read with the driver)

1. **Structural before:** OSMODE 5375, SAVETIME 5, CLAYER "0". **After:** 5375, 5, "0".
2. **Civil before:** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". **After:** 5375, 5, "BLOCKS".
3. I used no `setvar`. The very first read of the three variables on each drawing was lost to my own output trimming (I printed two lines of each result), so I read them again before the first command. Nothing was saved: all three drawings were closed without saving.
4. `quit` restored LOGFILEMODE (1, reads back 1), closed 3 drawings, ended AutoCAD with CloseMainWindow (killed false), released the lock and deleted five stray logs (`CLD20_*` and two `Drawing1_*`).

## What I could not prove

1. **Which step of a placed pipe costs REDO.** Candidates left: the Start Pipe write path, the Design Warnings window, the "Pick the next pipe's first point" loop and its Esc, or CD's leftover view change. Next case (about 25 calls): place a pipe through the window as in run 10, and U the pipe, then U and switch; and separately CD, Start Pipe, Esc, then the circle walk with a Design Warnings OK in between versus none.
2. **Only one clean walk per case for A and B**, plus one control. Run 10 lost 2 of 2 with a pipe; run 5 lost 4 of 4; this run kept 3 of 3 clean walks. The pattern holds but the sample is small.
3. **The Civil target in case B stayed clean of CD**, so "a pipe that is in a drawing but not placed by CD in that session" is the thing that kept REDO. It does not say whether a pipe pasted into a drawing that was then edited through CD would lose it.
4. **15 s exactly:** walks were 22 s (A), 28 s (C) and 14 s (B). Run 10's loss was at 15 s each time and run 5's at 15 to 67 s, so I judge time irrelevant, but I did not test A at exactly 15 s.
5. **The BUG-560 return on 3.0.44** was seen once; I did not click anything on the pit bodies and did not compare with 3.0.43.

## Recommendations

1. **Desk:** drop the plan-preview hypothesis from BUG-558 (item 1 of `BUG-558_REDO_SWEEP`). Cancelling the New Pipe window after a preview does not cost REDO. Keep the Start Pipe, Design Warnings, "Pick next pipe" and CD leftover-view paths as the suspects; the witness's three `VIEWBACKSTATUS` events at the switch point at a view change, which a placed pipe's zoom or pan could cause.
2. **Desk:** BUG-560 may have regressed in 3.0.44 (typed centres no longer find P10 and P9). Worth one look before the next build.
3. **Tooling:** the paste route (COPYCLIP, PASTECLIP) is a good "pipe without CD" fixture and needs no window; add it to the journeys folder. Add an autosave guard: read `SAVETIME` and the minutes since the last save, and avoid any U-to-REDO window that crosses the next autosave (or set SAVETIME to 0 for the run; the driver cannot set it today).
4. Logs kept in `C:\CE_PLAN\areas`: `release-v3-colleagues-CLAUDE_DRIVER_RUN12_PREVIEW_SPLIT_2026-10-10_witness_S1.jsonl`, `..._B1.jsonl`, `..._TGT.jsonl` (document names and timings only; the TGT log is large because the paste raised many object events).

## Summary

Claude ran run 12 in about 9 minutes with 59 of 60 driver calls on three test copies in AutoCAD 2027 (Civil 3.0.44, Manager 1.1.44, Structural 1.0.113), and closed AutoCAD cleanly. Opening the New Pipe window, letting its plan preview draw for about 15 s, and cancelling it did NOT lose REDO: the Structural circle, U, switch to the Civil copy and back, REDO printed "Everything has been redone" with no `VIEWBACKSTATUS` event between U and REDO, so the preview hypothesis is not supported. A pipe placed without the window (copy and paste of 2 pits and 1 pipe into a blank Civil copy) also kept REDO on one clean walk (a second walk was spoiled by AutoCAD's own autosave, "REDO must immediately follow the U or UNDO command", with an AUTO_SAVE event in the witness), and the control kept REDO too, so what costs REDO is something in a pipe actually placed through the window and CD's finish, which this run did not exercise. Also, the typed-points New Pipe window on 3.0.44 showed "Neither end is on a pit, downpipe or outlet" for the same points that worked in runs 5 and 10. System variables (OSMODE 5375, SAVETIME 5, CLAYER BLOCKS on Civil and 0 on Structural) were the same before and after, and nothing was saved.

AUTOCAD CLOSED
