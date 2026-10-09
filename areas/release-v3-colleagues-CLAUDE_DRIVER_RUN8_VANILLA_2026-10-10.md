# Claude driver run 8: the vanilla control, Saturday 10 Oct 2026 (PC clock 05:07 to 05:11)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 8, Sonnet, headless. AutoCAD 2027 (pid 52120), launched by the driver after `Get-Process acad` showed nothing running. The five CE bundles were `.bundle.off_ctrl` (controller's rename; I changed nothing). Test copies only: `C:\ce_rc_drv\CLD16_B1.dwg` (Civil, hash 34BBE37C2EA4 = DRV1_B1) and `C:\ce_rc_drv\CLD16_S1.dwg` (Structural, hash 950AFDF6E523 = DRV2_S1), both open writable in one AutoCAD. Nothing was saved.

## Answer first

1. **NO. Vanilla AutoCAD does NOT lose REDO at a drawing switch.** Not reproduced in vanilla: 2 of 2 switch cases kept REDO ("Everything has been redone"), and the no-switch control also kept it.
2. **So the lost REDO (4 of 4 in run 5) only appears with the CE bundles loaded.** That points at CE (or something CE sets up on a drawing switch), not at AutoCAD's own switch handling. One caveat below: this run did not have a CE command run on either copy, and CE objects were proxies.
3. **The witness shows no `VIEWBACKSTATUS` events at the switch in vanilla.** In run 5 (CE loaded) there were three per drawing at every switch. In vanilla the log between the U and the REDO is empty. That flag change is a CE-session signature, not an AutoCAD one.
4. **Driver calls: 30 counted by the wrapper, plus 1 final `quit` call** (the wrapper would have refused a 31st; I ran `quit` directly because AutoCAD had to be closed). No cancel, no blocked step, no wedge.

## The three REDO echoes (each: edit, U, about 15 s, switch = `open` the other copy then `open` this one, REDO)

1. **Case 1, plain `_.CIRCLE 0,30000 10` on the Structural copy, switch to Civil and back: "Everything has been redone".** U at 05:08:59, REDO at 05:09:19 (20 s).
2. **Case 2, after one typed MOVE on the Civil copy** (`_.CIRCLE 0,30000 10` then `_.MOVE _L  0,0 0,2000`, "1 found", completed), then a plain circle `0,30050` on Structural, U, switch to Civil and back, REDO: **"Everything has been redone".** U at 05:09:38, REDO at 05:09:58 (20 s).
3. **Case 3, plain circle `0,30100`, U, 15 s, NO switch, REDO: "Everything has been redone".** U at 05:10:05, REDO at 05:10:22.

## CE-off proof

1. **`CEHEALTH` answered: `Unknown command "CEHEALTH".  Press F1 for help.`** (typed with -Force; nothing else happened).
2. **The start-up log showed "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager"**: the CE menus are not there.
3. **ce_suite_startup.lsp printed nothing that I could see.** The history I read starts at 05:08:39 (the log has no earlier lines, because the driver switches logging on after AutoCAD starts), so a message printed in the first seconds of start-up would not be in it. I can say it printed nothing visible after 05:08:39 and in the menu lines above; I cannot prove it printed nothing at the very start. No APPLOAD or `(arx)` list was run (the driver refuses APPLOAD and LISP needs -AllowLisp; I kept to the call budget).
4. The CE drawing objects showed no proxy or missing-application dialog; the driver never reported a modal window.

## What the witness shows

1. **Recorder load: PASS**, `witness load` 0.7 s, SECURELOAD 0, no prompt (old pinned DLL AD8A22D3, the one with the object-event bug; I used only command, lock, sysvar events).
2. **Structural log, between each U and its REDO: nothing.** U writes `CommandWillStart`, `CIRCLERAD` changed, `CommandEnded`; the next event is the REDO's own `CommandWillStart` 18 to 20 s later. **No `VIEWBACKSTATUS` event at the switch**, no autosave line, no lock events at the switch. The switch itself (`open` of the other copy and back) wrote no event on the Structural drawing.
3. **Civil log:** the CIRCLE and MOVE, then nothing until close. It also shows no event from the switch.
4. **Caveat:** the recorder listens for a fixed set of events, so "no event" is not "nothing happened". But the same recorder did catch three `VIEWBACKSTATUS` changes per drawing in run 5, so it can see that flag, and it saw none here.
5. Logs kept in `C:\ce_rc_scratch\witness` (`CLD16_S1_20261010-050852-444.jsonl`, `CLD16_B1_20261010-050852-443.jsonl`).

## System variables (S1 = Structural copy; Civil copy NOT read, no call budget left)

1. **Before (S1):** OSMODE 5375, SAVETIME 5, CLAYER "0".
2. **After (S1):** OSMODE 5375, SAVETIME 5, CLAYER "0". Unchanged. I changed none (no `setvar`). The driver's own LOGFILEMODE was restored by `quit` ("1 (reads back 1)").
3. **Civil copy: OSMODE, SAVETIME and CLAYER not read before or after.** The witness shows no sysvar change on it other than the MOVE's internal `*COMPLETABLESTATE`.

## What I could not prove, and deviations

1. **Run 5's lost REDO had a CE command run on the Civil copy; here none had.** Vanilla cannot run one. The result is the decisive part: with CE absent the loss does not happen even with a typed MOVE on the Civil copy in between. It does not say which CE component does it.
2. **I did not repeat each case.** One run each, so "2 of 2 passed" is small, but run 5 lost 4 of 4, so the contrast is clear.
3. **Civil CLAYER and the full APPLOAD list were not read** (budget).
4. **Driver `quit` closed both drawings without saving; two stray logs removed; the lock was released.** No bypass of the driver at any point.

## Summary

Claude ran run 8 on fresh Civil and Structural test copies in AutoCAD 2027 with all CE bundles renamed off, 30 counted driver calls plus the closing `quit`. Vanilla AutoCAD kept REDO in all three cases: a plain circle then U, a switch to the Civil copy and back, then REDO answered "Everything has been redone", the same after a typed MOVE on the Civil copy, and the no-switch control also redone, so the loss of REDO seen in run 5 only appears with CE loaded. CE was shown off by `CEHEALTH` answering "Unknown command" and the CE menus failing to load; the startup LISP printed nothing I could see, though the log only begins after AutoCAD starts. The witness recorded no `VIEWBACKSTATUS` events at the switch (run 5 had three per drawing), and OSMODE 5375, SAVETIME 5, CLAYER "0" were unchanged on the Structural copy; the Civil copy's variables were not read.

AUTOCAD CLOSED
