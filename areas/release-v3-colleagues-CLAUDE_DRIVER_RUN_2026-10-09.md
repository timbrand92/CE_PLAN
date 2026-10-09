# Claude driver run 1, Friday 9 Oct 2026 (PC clock 21:59 to 22:07)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, Sonnet, headless. Driver: `C:\Lisp Files\_ACAD_DRIVER\acad_driver.ps1`. Test copy only: `C:\ce_rc_drv\CLD9_B1.dwg` (a fresh copy of DRV1_B1, hash 34BBE37C2EA4 equals the original). Tim's real drawings and settings files were not touched. Nothing was saved.

## Answer first

1. **Counts: PASS 3, FAIL 0, BLOCKED 1, SKIPPED 5 groups (not started).**
2. **The run stopped after 8 minutes because of my own mistake.** I typed `_.COPY 0,0 0,3000` as one complete line. AutoCAD's COPY is in "Multiple" mode, so after the second point it asks for another point. I left that question open. AutoCAD took about 1.3 cores, refused every later call, and the driver refused `cancel` (its alarm rule). The wedge rule says stop, so I stopped.
3. **AutoCAD was ended with `quit -Kill`** (allowed: it was the AutoCAD the driver launched). It is not running now and the lock is released. Nothing was saved. The PC is free for Codex at 00:15.
4. **No product fault was found.** The three checks that ran all passed on Civil 3.0.41.

## Versions read (readdll.ps1, 9 Oct 21:59)

1. **Civil:** CE_CVL_SUITE 3.0.41+660487d1 (Legacy 571ADF2A58D1, Net8 4AD251C985D4, Modern D48BE73F9D31).
2. **Manager:** CE_SUITE_MANAGER 1.1.41+660487d1 (Legacy 286B5BDF8125, Net8 042A61133B2A, Modern 974024840468).
3. **Structural:** CE_STRUC_SUITE 1.0.110+9babe787 (Legacy C892E20339E0, Net8 586F6ECB6734, Modern 755D88C401CD).
4. **AutoCAD:** 2027, R26.0s. AutoCAD took 39 seconds to start by the driver's explorer hand-off.

## System variables

1. **Read before, changed by me: none.** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS, PICKFIRST 1, CMDECHO 1, UNDOCTL 53. I never ran setvar or typed a variable change, so nothing needed putting back.
2. **Layer:** CLAYER stayed BLOCKS (it was not read again after the kill; no command I typed changes it).
3. **Driver clean-up** deleted its own stray log files in `C:\lisp files\ce_acad_plugin` (60 files named `Drawing<N>_<hex>.log`, plus `CLD9_B1_...log`). That is the driver's normal `quit` clean-up. Note that the list was longer than one session would normally make, so the driver may be deleting older `Drawing1_*.log` files too. It only touches that folder and only that file pattern.

## The checks

1. **CEHEALTH: PASS (Civil/Manager item a).** Typed `CEHEALTH` with `-Force`, because the driver refuses it as a bare word (it is not on the bare list) even though the source (`PluginManagerCommands.cs` line 161) shows it asks no question. AutoCAD printed: "[CEHEALTH] Checking the CE tools on this PC...", "[OK] CE Civil Suite v3.0.41", "[OK] CE Structural Suite v1.0.110", "[OK] The office IT folder (where CE updates come from) can be reached.", "[CEHEALTH] All checks passed." CMDACTIVE 0, no alarm. Note the line "CE Manager" is not listed, which matches Day 1 step 2.
2. **PIT with typed coordinates: PASS (item a).** Typed `PIT` then a line break then `10000,-90000` in one string, `-ExpectWindow "New Pit"`. AutoCAD printed "Specify pit insertion point: 10000,-90000". The window "New Pit" opened in about 11 seconds, no alarm. `ui close "New Pit"` closed it (WindowPattern.Close), `ui wait -Gone` confirmed, `wait` showed CMDACTIVE 0, and the history ended "PIT command cancelled." Nothing was placed. This was NOT a pit placement, so Day 1 step 3's "Pit placed successfully" and the label and cover text were not tested.
   1. **Also seen in `ui windows`:** a window "Creative Engineering | What's New" was open the whole time on the first start of Civil 3.0.41. That is Day 1 step 1's What's New window, now seen on 3.0.41. `quit` could not close it with Esc ("STILL OPEN"), so it needed the kill anyway.
3. **U then REDO after MOVE of a pit: PASS (REDO safety route d, and Day 1 item a "U then wait 12 s then REDO").** Pit P3 (handle 109D56) was at (53777.7, -25569.9). Selected it (`SELECTED 1`), typed `_.MOVE 0,0 1000,0`. AutoCAD printed "Specify second point ... 1000,0" and "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border")." (an informational CE line, no error). Then `U`, waited 12 seconds touching nothing, `REDO`. U echoed "MOVE". REDO printed "MOVE" and "Everything has been redone". Read after REDO: pit at (54777.7, -25569.9), object count 1054 (unchanged). Then one `U` echoed "MOVE" and the pit was back at (53777.7, -25569.9), count 1054. One U took the pit and everything CE moved with it, one REDO brought it back. DBMOD stayed 1 throughout (it was already 1 on opening, from CE's open-time pipe upgrade).
4. **U then REDO after COPY: BLOCKED (my error).** Last command typed: `_.COPY 0,0 0,3000` after selecting the pit. Screen state: AutoCAD printed "Current settings: Copy mode = Multiple", "Specify base point or [Displacement/mOde] <Displacement>: 0,0", "Specify second point or [Array] <use first point as displacement>: 0,3000" and then waited for the next point. Driver result: `alarm = true`, `needs_input = true`. Three later calls (U, REDO, a read) were refused "BUSY: AutoCAD rejected the text four times". Three `cancel` calls were each refused by the driver ("cancel is refused: the last call raised the alarm"). `wait` said "still busy (command active)". `perf cpu` for 10 seconds: 1.34 cores, Responding True. This matches the earlier wedges in HANG_CAPTURE.md. I did not run the hang capture: the cause was certain (my chain), the capture holds drawing data and would have used 10 minutes of the free window for nothing new.
   1. **Lesson for the next run:** `_.COPY` must carry its own end: `_.COPY 0,0 0,3000 `+ a line break + `X` (or `_.COPY 0,0 0,3000` followed by an Enter that answers the second "Specify second point or [Array/Undo/Exit]" question). Or use `_.COPY` with `_M` `_S` first (single mode). I did not try it, because the run was already stopped. MOVE is safe because it ends after one point.

## What I did NOT test (not started)

1. **CDCHECK complete chain** (`CDCHECK` + line break + `Problems`): SKIPPED. The README says the whole line is untested and may leave a "Jump to item number" question open. I would have tested it last for that reason, so it was never reached.
2. **PIT placement with a label and cover text, then U and REDO:** SKIPPED. It needs "Continue placement" in the window, then two more point answers at the prompts while a call is open. That is Codex's.
3. **Structural items (CSREOBAR, FEDIT size U/REDO, C1 and TS1, BT1 prompts):** SKIPPED, not reached. Most have complete chains in TYPED_FORMS_S8_C9.md. They were planned for after the Civil items, on `DRV2_S1.dwg` (I had made `CLD9_S1.dwg`, hash 950AFDF6E523, unused).
4. **Remaining REDO safety routes:** U after PIT or CD (needs the New Pit window and clicks, Codex), UNDO with a count then REDO (not reached), autosave in the wait with SAVETIME (not reached; the driver only allows setvar on FILEDIA, CMDECHO and UNDOCTL, so a typed `SAVETIME` change may be refused: I did not find out), U then switch drawing then back then REDO (not reached; a Structural drawing would be the second drawing).
5. **Everything that needs a mouse pick or window click:** SKIPPED as the brief said, and noted as Codex's.

## What a Claude driver can reliably cover, and what needs Codex or Tim

1. **Reliable:** one-line commands that end by themselves (MOVE with a pre-selection, CEHEALTH, U, REDO), reading the answer back, reading system variables, and opening and closing a window by title. Each call took about 1 to 2 seconds. Opening a test copy took 39 seconds.
2. **Not reliable without care:** any command with a repeating question (COPY, ARRAY, STRETCH in older versions). The driver has no way to answer a question once it is open, and it refuses `cancel` once the alarm is set, so one wrong chain costs the whole night's run. Every chain must be checked against the command's full prompt list before it is typed.
3. **Needs Codex:** anything that needs a click or a pick (PIT placement, Edit Pit, CD, the Pit Schedule), and screenshots.
4. **Needs Tim:** whether a result is right as engineering (cover levels, grades, labels). The driver only shows what AutoCAD printed and where objects went.

## Recommendation for daily use of this tester

1. **Use it for short, safe nightly checks:** CEHEALTH, PIT open and cancel, and U/REDO of MOVE or STRETCH with a complete one-line form. This run proves those take about two minutes and need no clicks.
2. **Before each run, put the exact command lines in a file and check each one against its prompt list** (a second reader, or a dry read of the source). Add COPY to the driver's "never bare, needs its Exit" list so the driver warns, or have it refuse `_.COPY` without an end.
3. **Do not run the Structural part or CDCHECK in the same night as a new chain.** Prove the chain in the core console first, as the README says.
4. **Ask the desk to approve a driver change:** a "cancel" that works when the alarm is set only because a command is waiting for a point (it does not today). Without it a single typo costs the AutoCAD session. This needs Tim's approval as a driver change; I did not touch the driver.
5. **Next Claude run (suggest tonight after Codex, or Saturday):** Structural chains on a fresh copy (CSREOBAR, FEDIT, STR), with one `_.COPY` chain written with its exit.

## Evidence kept

1. **Driver transcripts:** `C:\Lisp Files\_ACAD_DRIVER\transcripts\` (latest session file).
2. **My call log:** about 46 driver calls out of the 80 allowed (including 3 refused cancels).
3. **Copies left:** `C:\ce_rc_drv\CLD9_B1.dwg`, `CLD9_B1_PRE_C7_20261009_220003.dwg` (CE's own open-time backup) and `CLD9_S1.dwg`. Safe to delete.

## Summary

Claude ran CEHEALTH, PIT (typed point, window opened and cancelled cleanly) and a pit MOVE with U, a 12-second wait and REDO on Civil 3.0.41 in real AutoCAD 2027 on a test copy: all three passed, REDO printed "Everything has been redone" and the pit returned to its moved position. Then I typed a COPY command that stays open for more points, AutoCAD waited at that question at 1.3 cores, the driver refused cancel, and I stopped under the wedge rule and ended the AutoCAD session with the driver's kill (nothing saved, lock released, no system variable changed). The cause was my command, not CE. CDCHECK, the Structural chains, the remaining Undo/Redo routes and everything needing a click or a pick were not tested. A Claude driver is good for short one-line checks and bad at commands with repeating questions, so the recommendation is to use it nightly for safe one-line checks with every chain verified first.
