# Claude driver run 16, BASE_3045: the decisive A/B for BUG-558 (Saturday 10 Oct 2026, PC clock 14:04 to 14:12)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 16, Sonnet, headless. `Get-Process acad` showed nothing first. No Codex verifyW window run was active (the running Codex job was the bj24 settings-rows builder, which runs tests only; the last verifyW report was at 08:43). Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Fresh test copies in `C:\ce_rc_drv`: `CLD24_B1` (from DRV1_B1, hash 34BBE37C2EA4), `CLD24_S1` (from DRV2_S1, hash 950AFDF6E523) and `CLD24_B2` (a second untouched Civil copy from DRV1_B1, 34BBE37C2EA4). Nothing was saved. I did not go round the driver at any point.

## Installed versions (readdll.ps1, 10 Oct 14:02), BASE_3045

1. **Civil CE_CVL_SUITE 3.0.45+f34abfeb:** Legacy 4673869004D6, Net8 ABE2CD86A594, Modern 5A00452BE903.
2. **Manager CE_SUITE_MANAGER 1.1.45+f34abfeb:** Legacy F917929F67EF, Net8 1BD97D539CDC, Modern 2910C872B9A7.
3. **Structural CE_STRUC_SUITE 1.0.114+0f00f5fb:** Legacy 1483F48B2337, Net8 E0C1E50F360B, Modern 25262A382560.
4. **Recorder:** `witness check` said ok_to_load, SHA256 49E79D6D... which equals the pin inside the driver copy. `witness load` worked in 1.4 s, SECURELOAD 0, no prompt.

## Answer first

1. **REDO lost in A (the CD pipe): YES, 2 of 2.** Case A: "Nothing to redo". Case C (A repeated once): "Nothing to redo". Baseline bug is still there on 3.0.45.
2. **REDO lost in B (the control, fresh Civil copy, nothing done): NO, 0 of 2.** "Everything has been redone" both times (the second one is an extra control I ran with spare calls; one earlier repeat was spoiled by an autosave and is not counted, see below).
3. **The witness separates them exactly, as in run 10.** Both lost walks show three `VIEWBACKSTATUS` changes on each drawing between the U and the REDO (Structural and the Civil copy with the pipe). Both control walks show none.
4. **Cause still not split three ways:** it is the switch to the Civil drawing in which CD placed a pipe. I did not test whether it is the pipe object, the CD command having run, or the view CD leaves behind (see "What I could not prove").
5. **Calls: 53 of 75 counted** (wrapper counter, every call including refusals and the offline `witness check`). Time 8 minutes of the 75. AutoCAD closed with the driver's clean `quit`, lock released.

## The echoes, word for word

1. **A (CD pipe, then Structural circle `0,0 10`, U, 15 s, switch to `CLD24_B1` and back, REDO):** `Command: REDO` then **"Nothing to redo"**. U at driver time 14:07:24, REDO 14:07:47.
2. **B (control: Structural circle `0,0 15`, U, 15 s, switch to the fresh `CLD24_B2` and back, REDO):** `Command: REDO`, `CIRCLE`, **"Everything has been redone"**. U 14:08:25, REDO 14:08:45.
3. **C (A repeated: circle `0,0 20`, U, 15 s, switch to `CLD24_B1` and back, REDO):** **"Nothing to redo"**. U 14:08:57, REDO 14:09:21.
4. **Extra control B2 (circle `0,0 25`):** **"REDO must immediately follow the U or UNDO command."** This is the autosave message, not a loss: the witness shows `LockModeChanged AUTO_SAVE` (with `VERSIONGUID` changes and two Xrecord append and erase pairs) at 14:10:30 between the U and the REDO. SAVETIME is 5 and AutoCAD started at 14:04. **Spoiled by autosave, not counted.**
5. **Extra control B3 (circle `0,0 30`, repeated straight after, before the next autosave):** **"Everything has been redone"**.

## Witness lines between the U and the REDO (Structural log; Civil logs show the same three events at the switch)

1. **A:** `U` ends (seq 249), `LockModeChanged #U`, then **three `SysVarChanged VIEWBACKSTATUS`** at 14:07:46 (seq 252, 253, 254, 49 ms and 75 ms apart), then `CommandWillStart REDO` (seq 256). Count: **3**. Civil copy log at the same switch: three at 14:07:43 (seq 289 to 291). Nothing else: no command, no object event, no autosave.
2. **B:** between the U (seq 295) and the REDO (seq 299): no `VIEWBACKSTATUS`. Count: **0**. The `CLD24_B2` log holds no `VIEWBACKSTATUS` at all.
3. **C:** `U` ends (seq 363), then **three `VIEWBACKSTATUS`** at 14:09:21 (seq 366 to 368), then REDO (seq 370). Count: **3**. Civil copy log: three at 14:09:18 (seq 292 to 294). Nothing else.
4. **B3:** between the U (seq 521) and the REDO (seq 525): `LockModeChanged` only. Count: **0**. REDO then re-erased the circle, as it should (`ObjectErased ... erased=False`, `CIRCLERAD`).
5. **One more fact from the Civil copy log:** a single `VIEWBACKSTATUS` appeared at 14:06:17, straight after Start Pipe in the New Pipe window. The three-event burst then follows every switch into that drawing.
6. Logs kept (document names and timings only): `release-v3-colleagues-CLAUDE_DRIVER_RUN16_witness_S1.jsonl`, `..._witness_B1.jsonl` and `..._witness_B2.jsonl` in this folder.

## The steps I ran (driver calls 1 to 53)

1. **Setup (1 to 9):** lock acquire; `witness check`; `launch` CLD24_B1 (43 s); `witness load`; `getvar` OSMODE, SAVETIME, CLAYER; `open` CLD24_S1 writable; `open` CLD24_B1 writable. Both drawings got a witness log after the re-open.
2. **Pipe (10 to 18):** `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`: New Pipe appeared in 7.4 s, "Pipe end moved to the inside wall of P10 (was 225 mm inside the pit)". `ui tree "New Pipe"`: First Point P10, Last Point P9, no "Neither end is on a pit" banner. `ui type` 18.500 into `C2.FirstInvert` and `C2.SecondInvert`; `ui click` `C2.OkCommand`; `ui windows` showed Design Warnings and a "What's New" window; `ui click "Design Warnings" "OK"`; `ui close "Creative Engineering | What's New"` returned HARD TIMEOUT (see findings); `esc`: `esc_sent 1`, `ce_prompt_waiting true`, `command_ended true`, `cmdactive_after 0`, CE printed "[CE] Stopped. Everything placed stays; U takes back the last one."
3. **Case A (19 to 24), Case B (25 to 31), Case C (32 to 36), autosave-spoiled repeat (37 to 43), extra control (44 to 48):** six calls each at most (open, circle, U, a 14 to 15 s wait, open the other drawing, open the Structural copy, REDO).
4. **After (49 to 53):** `open` CLD24_B1, three `getvar`, `quit`.

**Deviation from the brief, on purpose:** the brief asked for each CD point as its own `type` call. That cannot work: while CD waits at a question AutoCAD rejects typed text (run 10 finding 3.1, DRIVER_TESTER_GUIDE section 4.2), and the driver refuses a bare `CD`. I used the one-call newline form that run 10 proved, and which gave the identical result (P10 to P9, same inverts, same Esc). The `answer` route is unproven and I did not use it.

## System variables

1. **Civil `CLD24_B1` before:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS. **After:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS. Unchanged. I used no `setvar` and changed no variable.
2. **Structural `CLD24_S1`:** not read before or after (call budget kept for the cases; no setvar used).
3. **Nothing saved.** `quit` closed 3 drawings without saving, `LOGFILEMODE` restored to 1, four stray log files deleted (CLD24_B1, CLD24_B2, CLD24_S1, Drawing1).

## What I found (for the tooling worker)

1. **`ui close "Creative Engineering | What's New"` hung 33 s and returned HARD TIMEOUT** while CD was waiting at its next-pipe prompt (the window was still open from the first start). `esc` then worked at once, so nothing was lost. Close "What's New" before CD, not while a CE prompt waits.
2. **The `esc` and `ui` allow-list work as in run 10:** New Pipe found, driven by `ui type` and `ui click`, Design Warnings closed, `esc` stopped the prompt.
3. **Autosave is a real spoiler:** 6 minutes into a session SAVETIME 5 hit one walk. The witness named it (`AUTO_SAVE`); the REDO message differs ("REDO must immediately follow the U or UNDO command" against "Nothing to redo"), so the two can be told apart from the echo.

## What I could not prove

1. **Which part of the CD route costs REDO:** the pipe object, the CD command having run in that drawing, or the view CD leaves behind. The next case, which the desk can send: in the Civil copy place the pipe, `U` it, then repeat the Structural circle and switch; and separately run CD then Esc at its first prompt (nothing placed) and repeat. Roughly 30 calls.
2. **Whether the Civil pit MOVE without CD stays clean on 3.0.45** (runs 6 to 9 said so on earlier builds; I did not run it).
3. **Small numbers:** A is 2 of 2, B is 0 of 2 counted. They match run 10 (2 of 2 and 0 of 1) and run 5 (4 of 4 with a pipe), and runs 6 to 9 (14 of 14 kept without one).
4. **Not tested:** Manager or Structural windows, a pipe placed by any route other than the New Pipe window, a different drawing than DRV1_B1.

## Summary

Claude ran run 16 (BASE_3045: Civil 3.0.45, Manager 1.1.45, Structural 1.0.114, recorder pinned and loaded) in one AutoCAD 2027 with 53 of 75 driver calls in 8 minutes, on fresh test copies CLD24_B1 (Civil), CLD24_S1 (Structural) and CLD24_B2 (untouched Civil), and closed AutoCAD cleanly with nothing saved. After a CD pipe from P10 to P9 (through the New Pipe window, inverts 18.500, Esc at the next-pipe prompt), a plain Structural circle, U, 15 s and a switch to the Civil copy and back lost REDO both times ("Nothing to redo", cases A and C), with three `VIEWBACKSTATUS` events on each drawing between the U and the REDO; the same steps with a switch to a fresh Civil copy kept REDO both times ("Everything has been redone") with none; one control walk was spoiled by an autosave (witness `AUTO_SAVE`, different REDO message) and is not counted. So the baseline bug is still present, and it follows the switch to the Civil drawing in which CD ran; whether the pipe, the CD command or the view CD leaves behind is the cause is still unproven. OSMODE 5375, SAVETIME 5 and CLAYER BLOCKS read the same before and after on the Civil copy.

AUTOCAD CLOSED
