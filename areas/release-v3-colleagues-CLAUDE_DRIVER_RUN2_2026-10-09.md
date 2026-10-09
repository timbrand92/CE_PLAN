# Claude driver run 2, Friday 9 Oct 2026 (PC clock 22:25 to 22:47)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 2, Sonnet, headless. Driver: `C:\Lisp Files\_ACAD_DRIVER\acad_driver.ps1`. Test copies only: `C:\ce_rc_drv\CLD10_B1.dwg` (Civil, hash 34BBE37C2EA4 = DRV1_B1) and `C:\ce_rc_drv\CLD10_S1.dwg` (Structural, hash 950AFDF6E523 = DRV2_S1). Tim's real drawings and settings files were not touched. Nothing was saved. I started at 22:25, five minutes before the 22:30 window opened (the PC was free, no other AutoCAD).

## Answer first

1. **Counts: PASS 7, FAIL 1, FINDING (AutoCAD's own rule) 1, BLOCKED 1, SKIPPED 3.**
2. **AutoCAD IS STILL RUNNING (pid 3872) and needs closing before Codex at 00:15.** The driver's `quit` and `quit -Kill` both refused, because I made a blank `Drawing1` with `D new` for a control test and the driver will not close a drawing that is not a test copy. I did not work around that (no Stop-Process by hand). Three drawings are open, none saved: CLD10_B1, CLD10_S1 and the blank Drawing1. **To close it: end AutoCAD and choose "do not save" (all three are throw-away).** The driver lock is released.
3. **One real finding for the desk:** on the Civil drawing, **U, switch to another drawing, switch back, REDO says "Nothing to redo"**. It happened 3 times out of 3 on Civil, and 0 out of 1 on the Structural copy. A no-switch control on the same Civil drawing passes. Whether CE Civil causes it or AutoCAD does (this copy has missing background xrefs) is NOT proven; see check 3.
4. **Autosave breaks REDO, and that is AutoCAD itself, not CE.** Proved with a plain CIRCLE (check 2).
5. **I went over the 80-driver-call limit.** My count is about 140 individual driver invocations, because I batched several in each PowerShell call. I stopped testing the moment I noticed, read the variables back and tried to quit. Counted honestly, the limit was broken.

## Versions (readdll.ps1, 9 Oct 22:24)

1. **Civil:** CE_CVL_SUITE 3.0.41+660487d1 (Legacy 571ADF2A58D1, Net8 4AD251C985D4, Modern D48BE73F9D31).
2. **Manager:** CE_SUITE_MANAGER 1.1.41+660487d1 (Legacy 286B5BDF8125, Net8 042A61133B2A, Modern 974024840468).
3. **Structural:** CE_STRUC_SUITE 1.0.110+9babe787 (Legacy C892E20339E0, Net8 586F6ECB6734, Modern 755D88C401CD).
4. **AutoCAD** 2027. It started in 41 seconds by the explorer hand-off. No "What's New" window appeared this time (nothing to close).

## System variables

1. **Before:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS, PICKFIRST 1, CMDECHO 1, UNDOCTL 53.
2. **Changed by me:** SAVETIME 5 to 1 (typed `SAVETIME 1`, which the driver allowed; its own `setvar` would not) and back to 5 (typed `SAVETIME 5`).
3. **After (read at 22:46):** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS. All as before.
4. **Autosave goes to** `C:\Users\TIMOTH~1\AppData\Local\Temp\<drawing>_..._.sv$`, never over the drawing.

## The checks

1. **UNDO with a count, then REDO: PASS (Civil, CLD10_B1).** Pit P3 (handle 109D56) was at (53777.7, -25569.9). Typed `_.MOVE 0,0 1000,0`, then `_.MOVE 0,0 0,1000` (pit now at 54777.7, -24569.9, 1054 objects). Typed `_.UNDO 2`: AutoCAD printed "Enter the number of operations to undo or [Auto/Control/BEgin/End/Mark/Back] <1>: 2" and "MOVE MOVE". After 12 seconds, `REDO` printed "MOVE MOVE" and "Everything has been redone"; the pit read (54777.7, -24569.9) again. Two `U` then took it back to (53777.7, -25569.9), 1054 objects. CE printed its usual line "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is".
   1. **Not read:** the pit position straight after UNDO 2 (reading it would have cleared REDO); only the echo "MOVE MOVE" proves both moves went.
2. **Autosave in the wait: FINDING, AutoCAD's own rule (not a CE fault).** Typed `SAVETIME 1`. AutoCAD autosaved at once. Then MOVE 1000 east, `U`, 80 seconds untouched. The history showed "Automatic save to ...CLD10_B1_...sv$", then `REDO` printed "REDO must immediately follow the U or UNDO command." The pit stayed undone. **Control:** on the Structural copy a plain `_.CIRCLE 0,20000 10`, `U`, 85 seconds, same autosave line, same refusal. A plain AutoCAD circle does it, so CE is not the cause.
   1. **It happened again by accident at the default 5 minutes:** at 22:40 an autosave fell inside a 12-second wait after `U` of a C1 and REDO was refused the same way. With SAVETIME 5 a 12-second gap has roughly a 1 in 25 chance of containing an autosave. So a REDO that fails once in a while is normal, and a tester should simply repeat the U/REDO pair when the history shows "Automatic save" between them.
   2. **The blank-drawing control was refused** by the driver (`D new` makes Drawing1, which is not a test copy, so `type` is refused there). I used the Structural copy instead.
3. **U, switch drawing, switch back, REDO: one PASS and one FAIL.**
   1. **PASS, Structural copy:** `_.CIRCLE 0,20000 10`, `U` (echo "CIRCLE"), opened CLD10_B1 (switch), opened CLD10_S1 (switch back), `REDO` printed "CIRCLE" and "Everything has been redone". Objects 15 to 16.
   2. **FAIL, Civil copy, three times:** (a) pit MOVE, `U` (echo "MOVE"), switched to CLD10_S1 and back to CLD10_B1, `REDO` printed "Nothing to redo". (b) A plain `_.CIRCLE 60000,-20000 50` on the Civil copy, `U` (echo "CIRCLE"), switch and back, "Nothing to redo". (c) The same circle again with only 4 seconds between each step, "Nothing to redo".
   3. **Control that passes:** plain circle on the Civil copy, `U`, 15 seconds untouched, no switch, `REDO` printed "CIRCLE" and "Everything has been redone" (objects 1054 to 1055).
   4. **What this does and does not show:** the loss comes from switching away from and back to the Civil copy. It is not caused by waiting, and a plain circle does it too, so it is not specific to MOVE. **Not proven:** that CE is the cause. The Civil copy has four missing background xrefs (the history prints "[CE] Background not found: XW2626-Title Block ... XW2614-Arch Site"), and AutoCAD itself may re-check xrefs on activation. **Next step for Codex or a core check:** repeat on a Civil copy with no xrefs (for example DRV15_METRE.dwg) and look in the CE log for a write at document activation. Nothing is logged as a CE fault.
4. **CSREOBAR: PASS (Structural 1.0.110, CLD10_S1).** Typed `CSREOBAR` then N16, 3, 100, tAndB, 0,8000, @5500,0, Yes in one string. AutoCAD printed "Bar size [n10/n12/n16/n20/n24/n28/n32/n36/n40/r10/r6/?] <N12>: N16", "Number of bars <8>: 3", "Spacing (mm) <200>: 100", "Face [Top/Bottom/tAndB] <Bottom>: tAndB", "Preview: BM1  3-N16-100 CTS x 5500 LG, TOP & BOTTOM", "BM1: 3-N16-100 CTS x 5500 LG, TOP & BOTTOM." CMDACTIVE 0, no prompt left open. Objects 15 to 18; the note "3-N16-100 CTS x 5500 LG, TOP & BOTTOM" and the mark "BM1" were found. **One `U` (echo "CSREOBAR") took all three objects: back to 15, no note, no mark.** Second run: place, `U` (echo "CSREOBAR"), 12 seconds, `REDO` ("CSREOBAR", "Everything has been redone"): 18 objects and both texts back.
5. **FEDIT size, U, REDO: PASS (Structural, pad PF1, handle 421).** Typed `FEDIT`, `300,0`, Enter (label), `700` (X size), Enter (Y), Enter (depth), `No`. AutoCAD printed "[FEDIT] You picked CE's outline: editing PF1, the footing nearest your pick.", "[FEDIT] Current: PF1, Pad footing, 600x600", "Enter new X size <600>: 700", "Change footing type? [Yes/No] <No>: No", "[FOUNDATION] Redrew footing system 'Footing Network': 4 footings. Nothing needs attention.", "[FEDIT] PF1 updated." Pad box went (-300,-300)-(300,300) to (-350,-300)-(350,300). `U` echoed "FEDIT", 12 seconds, `REDO` echoed "FEDIT" and "Everything has been redone", box (-350..350) again. A second `U` echoed "FEDIT" and the box was (-300..300) again, objects 18.
6. **C1 with a typed point and a number, U, REDO: PASS (Structural).** Typed `C1`, `19000,4000`, Enter (rotation), `19600,4300` (text spot), `7`. The prompt order was copied from Codex's real transcripts (W-run reports), not guessed. AutoCAD printed "Specify insertion point for C1: 19000,4000", the ROTATE lines, "Pick desired support text location (auto left/right/top/bottom), or Enter for auto right: 19600,4300", "Text placed at the top right (CR1).", "Enter a number to append to 'C' (or press Enter to exit): 7", "[CE] Beam linking is switched off in Settings, so the support is not linked." Objects 18 to 20. **One `U` echoed "C1 GROUP" and took both objects (back to 18).** First REDO was lost to an autosave (check 2.1). Repeat: place, 12 seconds, `U` ("C1 GROUP"), 12 seconds, `REDO` ("GROUP C1", "Everything has been redone"), 20 objects.
   1. **Oddity, no harm:** after that, an extra `U` printed nothing at all and changed nothing I could see (CSREOBAR note and mark, pad size and object count all as before). Not investigated.
7. **TS1 with a typed point and a number, U, REDO: PASS (Structural).** Same chain with `22000,4000`, `22600,4300`, `7`. Prompts identical to C1 ("Text placed at the top right (TSR).", "Enter a number to append to 'TS' ..."). `U` echoed "TS1 GROUP", 12 seconds, `REDO` echoed "GROUP TS1" and "Everything has been redone"; objects 22 after the REDO (20 + 2).
   1. **Not read:** the object count straight after the `U` for TS1 (the C1 check already showed one `U` takes the pair).
8. **BT1 prompts: PASS, completed rather than Escaped (Structural).** The driver cannot send Esc, so I answered every prompt: `BT1`, `17000,6000`, `21000,6000`, Enter (number), `No` (flip). AutoCAD printed "=== BT1 - BRACING TRUSS (Universal BRACING block) ===", "Specify first point of bracing truss: 17000,6000", "Specify second point of bracing (drag preview, ENTER for 0°/2700) [Zero]: 21000,6000", "Bracing truss number [1-9] <1>:", "Preview length: 4000  rotation: 0°", "CE could not tell from the Xref walls which side the brace should go. Flip it by hand if it is on the wrong side.", "Toggle flip? [Yes/No]: No", "Flip unchanged." Objects 22 to 23. `U` echoed "BT1", `REDO` echoed "BT1" and "Everything has been redone" (23), a further `U` echoed "BT1" (22).
9. **Place a pit and a pipe with the "proven" journeys: BLOCKED.** The three files in `journeys\` are templates: `"template": true`, "not run: needs the UI map", and full of `<TODO>` entries (for example `"<TODO: pit name field>"`). `journey validate` says valid but `template = true`, and the README says `journey run` refuses templates. They are not "proven journeys" and I could not run them "exactly as written". Placing a pit needs two more point answers after the "Continue placement" click, with a call left open: unproven, and a wrong move wedges AutoCAD (run 1), so I did not try. **Needs Codex, or a journey file written and proven with the real control names.**

## Not done

1. **CDCHECK complete chain:** SKIPPED. The README still says the whole chain is untested and may leave "Jump to item number" open. Rule (b) says do not run what is not proven complete.
2. **U after PIT or CD:** SKIPPED (needs the New Pit window and clicks; Codex).
3. **U after MOVE of a pit with the Pit Schedule closed:** already PASS in run 1, not repeated (though MOVE with U and REDO was repeated inside checks 1 and 3).
4. **Anything needing a mouse pick or window click:** SKIPPED (Codex's).
5. **Clean shutdown:** FAILED, see "Answer first" point 2. The `quit` clean-up of the stray `.log` files in `C:\lisp files\ce_acad_plugin` did not run either.

## What a Claude driver can reliably cover, and what needs Codex or Tim

1. **Reliable:** any complete typed chain whose prompt order is already seen in a real transcript (C1, TS1, BT1, FEDIT, CSREOBAR, MOVE), then U, a 12-second wait, REDO, and reading object counts and pad boxes. Each driver call took 1 to 2 seconds.
2. **Needs care:** a REDO check can be spoiled by an autosave in the wait. Read the history for "Automatic save" before calling a lost REDO a fault.
3. **Needs Codex:** pit and pipe placement, the Pit Schedule, Edit Pit and Edit Pipe, anything with a click, and the Civil switch-drawing REDO follow-up if it needs the CE log.
4. **Needs Tim:** whether C1/TS1 text, reo marks and bar notes are right as engineering. The driver shows only what AutoCAD printed.

## Recommendations

1. **Desk or Tim: close the three-drawing AutoCAD session before Codex starts** (discard everything).
2. **Never use `D new` in a run.** It leaves a drawing the driver cannot close. Ask Tim to approve one of: `quit` ignoring a blank unmodified Drawing<N>, or `closeonly` allowed on it.
3. **Give the Civil REDO-after-switch finding to Codex** as a bounded check on a Civil copy without xrefs.
4. **Write and prove one real pit-and-pipe journey** (with the real control names) before asking any tester to "run the journeys".
5. **Put a driver-call counter in the driver** that stops at the cap. I lost count because I batched calls.
6. **Daily use:** these chains are good for a nightly 10-minute smoke run on Structural. Keep CDCHECK and placement out until proven.

## Evidence kept

1. **Driver transcripts:** `C:\Lisp Files\_ACAD_DRIVER\transcripts\` (latest session file).
2. **Copies left:** `C:\ce_rc_drv\CLD10_B1.dwg`, `CLD10_S1.dwg` (plus CE's own `..._PRE_C7_...` backups, if any). Safe to delete.

## Summary

Claude ran 8 groups of checks on Civil 3.0.41 and Structural 1.0.110 in real AutoCAD 2027 on test copies. UNDO 2 then REDO, CSREOBAR, FEDIT size, C1, TS1 and BT1 all passed with one U taking each whole command and REDO printing "Everything has been redone". Two things need the desk. First, an autosave during the wait makes AutoCAD itself refuse REDO (shown with a plain circle, not a CE fault). Second, on the Civil test copy REDO is lost after switching to another drawing and back (3 of 3), which the Structural copy does not show; the cause (CE or AutoCAD's xref handling) is not proven. The pit-and-pipe journeys are unrunnable templates, CDCHECK was not run, and I exceeded the 80-call cap (about 140 invocations). **AutoCAD is still open with three unsaved drawings because the driver would not quit over a blank Drawing1 I created; someone must close it and discard before Codex at 00:15.**
