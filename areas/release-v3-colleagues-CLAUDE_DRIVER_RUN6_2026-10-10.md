# Claude driver run 6, Saturday 10 Oct 2026 (PC clock 03:08 to 03:14)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 6, Sonnet, headless. Four separating cases for the lost REDO after a drawing switch. Test copies only: `C:\ce_rc_drv\CLD14_B1.dwg` (Civil, hash 34BBE37C2EA4 = DRV1_B1) and `C:\ce_rc_drv\CLD14_S1.dwg` (Structural, hash 950AFDF6E523 = DRV2_S1), both open and writable in one AutoCAD 2027 (pid 2240, started by the driver; `Get-Process acad` showed nothing running first). Nothing was saved. Tim's drawings and settings were not touched. No CE window or CE prompt command was driven. The driver was not bypassed (no own UI Automation, no SendKeys, no PostMessage).

## Answer first

1. **No case lost REDO. Cases (a), (b) and (c) all kept it ("Everything has been redone"); case (d) was NOT RUN (call budget).** The REDO loss seen in run 5 did not happen here, with the Civil copy untouched, with one MOVE on Civil, or with no switch at all.
2. **The witness shows no `VIEWBACKSTATUS` event anywhere in this session: 0 on the Structural log, 0 on the Civil log.** In run 5 the same recorder showed three of them per drawing at each switch. So the three events are NOT an automatic part of switching drawings. They appeared in run 5 and not here, and run 5 is the one that lost REDO.
3. **What differed from run 5 is the Civil copy's history.** In run 5 the Civil copy had a pipe placed with CD and the New Pipe window (DBMOD 17, driven partly outside the driver). Here Civil had at most one typed MOVE. This points at "something done in the Civil drawing by the CD / New Pipe path leaves the session in a state where a switch loses REDO", but it is a hypothesis: I was told not to drive CD or New Pipe, so I could not test it.
4. **Counts:** (a) PASS, (b) PASS, (c) PASS, (d) NOT RUN. **Driver calls: 28 of 30** (counted per call with a wrapper). AutoCAD closed cleanly, lock released.

## Setup

1. **Copies:** both hash-checked (34BBE37C2EA4, 950AFDF6E523). `witness check` ok_to_load (pin AD8A22D3...). `launch` of the Civil copy 66 s, no What's New window. Structural copy opened writable. `witness load` returned in 1.7 s, SECURELOAD 0, no prompt. The recorder attached to both drawings (one log each).
2. **Odd but harmless:** DBMOD on the Civil copy read 1 straight after launch, before any command of mine (it loads with missing background xrefs). DBMOD on the Structural copy read 0 right after `open` and 1 after `witness load`. NETLOAD is a command in the log, which is probably what flagged it. Not investigated.
3. **Each case:** the edit, `U`, a 15 s wait, switch with `open` (other copy, then this copy), `REDO`. Same switch method as runs 3 to 5.

## System variables

1. **Before:** OSMODE 5375, SAVETIME 5, CLAYER "0" (Structural, the active drawing). Civil CLAYER was not read (see "what I could not do").
2. **After (read on the Structural copy before quit):** OSMODE 5375, SAVETIME 5, CLAYER "0". Unchanged. I changed none of them (no `setvar`).
3. **Civil CLAYER before and after: NOT READ.** `getvar` reads only the active drawing and I did not spend a call on it. Civil received one MOVE of a pit, which cannot change the current layer, but it is not proven by a read.

## The cases, with every REDO echo

1. **(a) Switch to Civil and back, Civil untouched: PASS.** `_.CIRCLE 0,40000 10`, `U` (echo "CIRCLE"), 15 s, `open` Civil, `open` Structural, `REDO` printed "CIRCLE" and "Everything has been redone". U at 03:10:06, REDO at 03:10:35 (29 s, because the two switch calls and the sleep add up).
2. **(b) After one typed MOVE on Civil: PASS.** First tried `_.MOVE (handent "109D56") 0,0 1000,0` in one line to save a call: the driver REFUSED it (nothing pre-selected, `-Force` does not override; nothing was sent, a call was spent). Then the run 3 way: `(sssetfirst nil (ssadd (handent "109D56") (ssadd)))` with `-AllowLisp` ("1 found" after), then `_.MOVE 0,0 1000,0` on pit P3. AutoCAD and CE printed "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border")." Then switched to Structural, `_.CIRCLE 0,50000 10`, `U`, 15 s, `open` Civil, `open` Structural, `REDO`: "Everything has been redone". U at 03:11:41, REDO at 03:12:06.
3. **(c) No switch, witness loaded: PASS.** `_.CIRCLE 0,60000 10`, `U`, 15 s, `REDO`: "Everything has been redone". U at 03:12:43, REDO at 03:13:01. No `VIEWBACKSTATUS` event, as expected with no switch.
4. **(d) Civil PIT MOVE, U, 66 s, switch, REDO: NOT RUN.** It needs 7 driver calls (switch, select, move, U, two switches, REDO) and only 2 were left after reserving the sysvar read and `quit`. This is the case run 2 lost on Civil, so it is still untested at 66 s.

## What the witness shows (the logs are in this folder)

1. **Files:** `release-v3-colleagues-CLAUDE_DRIVER_RUN6_witness_S1.jsonl` and `..._witness_B1.jsonl` (document names and timings only). The files cannot be read while AutoCAD runs through the reader scripts (they are held open), so I read them with a shared read stream. The reader scripts `Show-WitnessLog.ps1` and `Test-WitnessRedo.ps1` were not usable during the run for that reason: **finding for the tooling worker.**
2. **Structural log, every walk:** `CommandWillStart CIRCLE`, `CommandEnded`, then `U` (CommandWillStart, `CIRCLERAD` changed, CommandEnded), then silence, then `REDO` (CommandWillStart, `CIRCLERAD` changed, CommandEnded). Between each U and REDO there is **no event at all**: no `VIEWBACKSTATUS`, no object change, no autosave, no CE line. The `CIRCLERAD` change on the REDO is the signature of a REDO that worked.
3. **Civil log:** `DocumentAttached`, then lock-mode lines, the LISP selection line, and the MOVE (CommandWillStart, CommandEnded with DBMOD 1). It records **nothing at all when the switches happen** (no event at 03:10:23, 03:11:41 to 03:11:56 or 03:12:04).
4. **So the drawing switch on its own produces no recorded event in this session.** In run 5 it produced three `VIEWBACKSTATUS` per drawing. This is the strongest clue so far: the loss is tied to those events, not to the switch.

## What I could not prove or do

1. **Why run 5 lost REDO.** Not reproduced. The only difference I can name is Civil having been worked on by CD and the New Pipe window in run 5. Not tested (rule 1 forbids it in this run).
2. **Whether `VIEWBACKSTATUS` is the cause or a symptom.** I only know it was absent when REDO survived and present when it was lost (runs 5 and 6 together). Two runs, not a proof.
3. **Case (d), and any time above 15 s on Civil with a switch.** Not run. 66 s was not tested in this run on either copy.
4. **Civil CLAYER read** (see above).
5. **Whether a longer or busier session matters.** This session was 5 minutes old; run 2's session was long.

## Recommendation

1. **Next run, bounded:** repeat case (a) after placing ONE pipe on the Civil copy with CD (typed points, as run 5 did), because that is the one thing run 5 had and this run did not. That needs a driver that can see the New Pipe window on the second monitor and send the CD Esc (both open findings from run 5). Until then do not start CD, PIT or New Pipe from a Claude run.
2. **Put the three-way fact into BUG-558:** REDO survived 3 of 3 here (Civil untouched, Civil after a MOVE, no switch) with no `VIEWBACKSTATUS`; run 5 lost it 4 of 4 with three `VIEWBACKSTATUS` per drawing at the switch. Ask what the Civil drawing had been through.
3. **Tooling:** the driver should allow `MOVE` of a pre-selected object in one line or offer a "select by handle" call (it cost 2 extra calls here), and the witness reader should read a log that AutoCAD still holds open.
4. **Driver note:** `quit` closed 2 drawings without saving, killed nothing, and deleted 3 stray logs (`CLD14_B1`, `CLD14_S1`, `Drawing1`): harmless.

## Summary

Claude ran the four separating cases for the lost REDO in one AutoCAD 2027 on fresh Civil and Structural test copies, using 28 of 30 driver calls, and closed AutoCAD cleanly with nothing saved and OSMODE, SAVETIME and CLAYER unchanged (Civil CLAYER was not read). REDO survived in all three cases that were run: a Structural plain circle with the Civil copy untouched (a), after one typed MOVE of pit P3 on Civil (b), and with no drawing switch at all (c), each answering "Everything has been redone"; case (d), the 66 s Civil pit MOVE, was not run because of the call budget. The witness recorder showed no event of any kind between the U and the REDO in any case, and in particular none of the three `VIEWBACKSTATUS` changes per drawing that run 5 saw at each switch, so those events are not an automatic part of switching and seem to go with run 5's lost REDO, whose Civil copy had a pipe placed with CD and the New Pipe window; that is a lead, not a proof, and testing it needs a driver that can handle that window and the CD Esc. I did not drive any CE window, did not bypass the driver, and the only refusal was the one-line MOVE-by-handle form, which cost one call.
