# Claude driver run 17 (NARROW): what a placed pipe changes that an opened-and-cancelled CD does not. BUG-558, Saturday 10 Oct 2026 (PC clock 21:19 to 21:28)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 17, Sonnet, headless. Before the first call `Get-Process acad` showed nothing; the Codex runner's last entry was `END bj25_cesettings_rows_civil` at 18:42, so no verifyW window run was active. Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only. Nothing was saved. I did not go round the driver.

## Installed versions (readdll.ps1, 10 Oct 21:19; identical to run 16)

1. **Civil CE_CVL_SUITE 3.0.46+2388c329:** Legacy 63804716F6C2, Net8 55602FDA2981, Modern 214E8E193EEE.
2. **Manager CE_SUITE_MANAGER 1.1.46+2388c329:** Legacy F30FA61E4595, Net8 2791C1DD69BE, Modern 562C5DBD5BC2.
3. **Structural CE_STRUC_SUITE 1.0.114+0f00f5fb:** Legacy 1483F48B2337, Net8 E0C1E50F360B, Modern 25262A382560.
4. Recorder pin SHA256 49E79D6D... matched on every `witness load`.

## Answer first

1. **No case keeps REDO. All four placed-pipe cases LOST it ("Nothing to redo"): A, B, C and D.** Nothing I tried on the Civil copy removes the loss.
2. **(A) Baseline, inverts 18.500 / 18.500 (Design Warnings window opens): LOST.**
3. **(B) A real fall, inverts 18.500 / 18.400, flow P10 to P9, no flat warning and NO Design Warnings window: LOST.** So the Design Warnings window is NOT the cause. Candidate (1) is ruled out. Case (E) in the brief only applied if B was kept, so I did not run it.
4. **(C) Pipe placed, then `_.ZOOM _E` typed on the Civil copy (it ran; the prompt showed "_E"), then the walk: LOST.** A zoom on the Civil copy first does not remove the loss.
5. **(D) Pipe placed, then `REGEN` typed on the Civil copy, then the walk: LOST.** Caveat: D was the second walk on the same Civil copy after C (call budget; see section 5), so it is a weaker test than a fresh copy would be.
6. **The pipe placement itself changes the view.** On the Civil copy VIEWSIZE went from 24097.8 to 3801.1 (A) and 3784.1 (B), VIEWCTR from (67981.7, -64738.3) to (59232.1, -69535.0), and **VIEWBACKSTATUS from 0 to 1** (a "previous view" now exists). So candidate (3), a view change made by CD, is real. But undoing it with ZOOM EXTENTS (C) did not help, so it is not a plain "the view is different" effect. Candidate (2), the pipe, text and flow arrow written to the drawing (DBMOD 1 to 17 in A and B), is still the leading one, together with whatever CD does to the view-back list as it writes the pipe. I have not separated those two.
7. **Witness, identical in every lost walk:** exactly **three `SysVarChanged VIEWBACKSTATUS` events on the Structural drawing between the U and the REDO**, 24 to 65 ms apart, all at the moment the Civil copy was switched to and back (sections 3 and 4). Nothing else sat between (HookCounts 1, LockModeChanged 2, one walk 4).
8. **A new finding, separate from BUG-558: on a Civil drawing that is not the first one opened in an AutoCAD session, CD does not find the pits.** On CLD26_B2 (opened second, after the launch drawing and the Structural copy) the same typed points gave "Pipe end moved to the inside wall of the pit" with no name, and the New Pipe window said "Neither end is on a pit, downpipe or outlet", with Start Pipe disabled. The same points on the launch drawing give "P10" and "P9". I cancelled and restarted AutoCAD with the case drawing as the launch drawing. Not investigated further; Tim should know it in AutoCAD terms: a second Civil drawing opened in the same session may not recognise its pits for CD. This may be run 16's "typed points drift" (BUG-560) or a separate fault.
9. **System variables:** DBMOD 1 to 17 on the Civil copy after a pipe (A, B); UNDOCTL 53 and UNDOMARKS 0 unchanged throughout; CMDACTIVE 0 after every call. No `setvar` used (OSMODE, SAVETIME and CLAYER were not read this run: my 80-call budget went on the cases; run 16 read them on the same drawings with no change, and nothing here wrote to them).
10. **Driver calls: 80 of 80, counted by my wrapper** (section 5). Hard stop was 80 minutes; the run took about 9 minutes of PC clock.
11. **AutoCAD closed cleanly** with the driver `quit` (not killed), 2 drawings closed without saving, lock released, `Get-Process acad` shows nothing.

## 1. Copies

1. All from the source drawings, hash-checked before the first call: `CLD26_B1` to `CLD26_B5` from DRV1_B1 (34BBE37C2EA4) and `CLD26_S1` from DRV2_S1 (950AFDF6E523). All six matched.
2. Used: B1 (case A, session 1), B2 (the failed second-drawing attempt, cancelled, nothing placed), B3 (case B, session 2), B4 (cases C and D, session 3), B5 unused.

## 2. The steps, as typed

1. **Pipe (every case):** `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`, then `ui type "New Pipe" "C2.FirstInvert" "18.500"`, `ui type ... "C2.SecondInvert" "<18.500 or 18.400>"`, `ui click "New Pipe" "C2.OkCommand"`, then (A only) `ui click "Design Warnings" "OK"`, then `esc`. The pipe was P10 to P9 each time; the echo ended "[CE] Pipe placed ... [CE] Stopped. Everything placed stays; U takes back the last one." In B and C the text read "Inserted flow arrow. Flow: P10 -> P9" and there was no flat warning; in A "Pipe is essentially flat  no measurable fall".
2. **Walk:** `open CLD26_S1 -Writable`, `type "_.CIRCLE 0,0 10" -Enter`, `type "U" -Enter` (echo "CIRCLE"), sleep 15 s, `open <Civil copy> -Writable`, `open CLD26_S1 -Writable`, `type "REDO" -Enter`.
3. **REDO echo in every case: "Nothing to redo".**
4. **Case C extra step:** `type "_.ZOOM _E" -Enter` on the Civil copy, before the walk. **Case D extra step:** `type "REGEN" -Enter` on the Civil copy, before the second walk.

## 3. System variables before and after the pipe (typed getvar on the Civil copy)

1. **A before:** VIEWCTR (67981.656, -64738.255, 0), VIEWSIZE 24097.777, VIEWBACKSTATUS 0, DBMOD 1, CMDACTIVE 0, UNDOCTL 53, UNDOMARKS 0.
2. **A after:** VIEWCTR (59232.110, -69534.999, 0), VIEWSIZE 3801.145, VIEWBACKSTATUS 1, DBMOD 17, CMDACTIVE 0, UNDOCTL 53, UNDOMARKS 0.
3. **B before:** not read again (same untouched copy of the same drawing as A, so the A "before" values apply; I spent the calls elsewhere). **B after:** VIEWCTR (59232.110, -69534.999, 0), VIEWSIZE 3784.132, VIEWBACKSTATUS 1, DBMOD 17, CMDACTIVE 0, UNDOCTL 53, UNDOMARKS 0.
4. **C and D:** no before/after reads (budget). The only view read in C is the effect of the zoom itself, which I did not read back; the echo showed the Extents option was taken.
5. **VIEWBACKSTATUS is a real, readable variable here** (the typed getvar returned 0 and 1). Its 0 to 1 change on pipe placement, with no switch at all, is the first sign of the pipe's view effect. (In run 16 the single VIEWBACKSTATUS at the Start Pipe click was already seen.)

## 4. The witness, between U and REDO on the Structural drawing (my own reader on the logs after `quit`)

1. **A:** U seq 249 at 21:21:15, REDO seq 256 at 21:21:36. Between: HookCounts 1, LockModeChanged 2, **SysVarChanged 3 (VIEWBACKSTATUS at 21:21:34, seq 252, 253, 254, about 110 ms from first to last)**. LOST.
2. **B:** U seq 249 at 21:24:28, REDO seq 258 at 21:24:50. Between: HookCounts 1, LockModeChanged 4, **SysVarChanged 3 (VIEWBACKSTATUS at 21:24:49, seq 252, 253, 254, 30 ms apart)**. LOST.
3. **C:** U seq 249 at 21:26:16, REDO seq 256 at 21:26:36. Between: HookCounts 1, LockModeChanged 2, **SysVarChanged 3 (VIEWBACKSTATUS at 21:26:35, seq 252, 253, 254)**. LOST.
4. **D:** U seq 298 at 21:26:51, REDO seq 305 at 21:27:12. Between: HookCounts 1, LockModeChanged 2, **SysVarChanged 3 (VIEWBACKSTATUS at 21:27:10, seq 301, 302, 303)**. LOST.
5. Nothing else between any U and REDO: no command, no object event, no autosave.
6. **What I did not read:** the Civil copies' own logs. In session 3 the lock hiccup (section 5.2) made `witness load` come after the pipe was placed, so B4's pipe placement is probably not recorded; the Structural logs, which carry the U-to-REDO window, are complete. I read only the Structural logs.
7. Logs: `C:\ce_rc_scratch\witness\CLD26_S1_20261010-212008-497.jsonl` (A), `...212425-121.jsonl` (B), `...212613-124.jsonl` (C and D), plus `CLD26_B2_*`, `CLD26_B3_*` and `CLD26_B4_*`.

## 5. Driver findings and the call count

1. **Calls: 80, every individual call counted, including 2 wasted on the lock (below).** The per-call lines are in `C:\Lisp Files\_ACAD_DRIVER\transcripts\` (session logs of 21:19 to 21:28).
2. **Lock hiccup, twice:** (a) I forgot `-Who Claude` in my wrapper at first, so `launch` and `witness load` were refused "LOCKED by Claude ... you gave no -Who" (2 calls wasted, my fault, fixed by setting ACAD_DRIVER_WHO). (b) In session 3 `lock acquire` after the previous `quit` returned no OK line, `launch` still ran, `witness load` was refused, and `esc` said "esc needs the shared lock held by you; the lock is none". I re-acquired and carried on. I believe the previous `quit` was still releasing the lock when the next `lock acquire` ran, but I did not prove it. Advice: leave a few seconds between `quit` and `lock acquire`, and read the `lock acquire` result before launching.
3. **The second-drawing pit failure (finding 8) cost 5 calls** (open, CD, two typed inverts, a refused Start Pipe click, ui windows, ui tree, cancel) and a restart.
4. Nothing refused by the driver's deny list. `type "_.ZOOM _E"` and `type "REGEN"` were accepted as complete commands.

## 6. What this says, and what it does not

1. **What it says:** the loss of REDO follows a pipe being placed, whatever the inverts, whatever the Design Warnings window does, and it survives a ZOOM EXTENTS or a REGEN on the Civil copy beforehand. The same three VIEWBACKSTATUS events fire at the drawing switch every time. An opened-and-cancelled CD or PIT window (run 16) did not lose REDO and did not fire them, so the difference is in what a placed pipe leaves behind: the objects written (DBMOD 1 to 17) and a change to the drawing's view-back list (VIEWBACKSTATUS 0 to 1 before any switch).
2. **For the code side:** look at what `CD` does to the view when a pipe is placed (it zooms to the pipe: VIEWSIZE falls by about 6.3 times and the previous view is stored), and at the three VIEWBACKSTATUS notifications that fire on a document switch when the pipe drawing is involved. That is a lead, not a proven cause; I have not shown that those notifications are what clears the redo history.
3. **Not proven:** whether the objects or the view-back push is the trigger. Pipe then `U` of the pipe (does VIEWBACKSTATUS return to 0 and REDO survive?), a plain `_.ZOOM _W` on a drawing with no pipe (does it make VIEWBACKSTATUS 1 and lose REDO?) and a `_.MOVE` of a pit with no view change are the three cheap splits for the next run. The second is the most informative: if a plain zoom with no pipe, and no CE, loses REDO after a switch it is AutoCAD's own behaviour that CE's pipe placement merely triggers.
4. **Not run:** E (the brief's repeat of A, only if B had been kept); PIT placed through the New Pit window (still BLOCKED by the driver, as in run 16); OSMODE, SAVETIME and CLAYER reads (budget, nothing wrote them).
5. **Counts:** with runs 5, 10 and 16, REDO is now lost in every case with a pipe placed (12 of 12 on this build family) and kept in every case without one.

## 7. Recommendation

1. **Next run (one session, about 25 calls):** the three splits in 6.3, each from a fresh launch drawing, with `witness load` BEFORE the first drawing opens (use `launch` then `witness load`, as in run 16, and read the `lock acquire` result before launching).
2. **Desk:** BUG-558 stays open on Civil 3.0.46. Do not mark it fixed. A pipe placed anywhere in the drawing still costs the Structural redo history after a drawing switch.
3. **Separate carpark item to raise:** a second Civil drawing opened in the same session may not recognise its pits for CD (finding 8). Needs a one-line entry in the bug file: what Tim does (opens two Civil drawings, runs CD in the second), what he expects (the pipe snaps to the pits, names shown), what happens ("Neither end is on a pit"), and the test (open a second Civil copy after the first, type the same CD points, read the New Pipe banner).

## Summary

Claude ran run 17 in about nine minutes using all 80 driver calls on fresh test copies of AutoCAD 2027 (Civil 3.0.46, Manager 1.1.46, Structural 1.0.114). REDO was lost in all four cases with a pipe placed: the baseline with equal inverts (Design Warnings opens), a pipe with a real fall (no Design Warnings window, so that window is not the cause), a pipe followed by ZOOM EXTENTS on the Civil copy, and a pipe followed by REGEN (this one as a second walk on the same copy). Each lost walk shows exactly three VIEWBACKSTATUS events on the Structural drawing between the U and the REDO. Placing the pipe itself changes the Civil view (zoom in about 6 times, VIEWBACKSTATUS 0 to 1, DBMOD 1 to 17), which is the most concrete lead; whether the objects or the view change is the trigger is not yet separated. A second finding: a Civil drawing opened second in a session did not recognise its pits ("Neither end is on a pit"), so I restarted AutoCAD for each case. OSMODE, SAVETIME and CLAYER were not read this run; nothing was saved.

AUTOCAD CLOSED
