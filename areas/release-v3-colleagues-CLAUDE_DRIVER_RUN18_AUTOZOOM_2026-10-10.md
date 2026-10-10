# Claude driver run 18 (AUTOZOOM hypothesis): a plain zoom, with no pipe, loses REDO. BUG-558, Saturday 10 Oct 2026 (PC clock 21:38 to 21:44)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 18, Sonnet, headless. Before the first call `Get-Process acad` showed nothing and run 17's report (21:28) had ended; no Codex window run was active (only the idle Codex app processes). Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only. Nothing was saved. I did not go round the driver.

## Installed versions (readdll.ps1, 10 Oct 21:38, identical to runs 16 and 17)

1. **Civil CE_CVL_SUITE 3.0.46+2388c329:** Legacy 63804716F6C2, Net8 55602FDA2981, Modern 214E8E193EEE.
2. **Manager CE_SUITE_MANAGER 1.1.46+2388c329:** Legacy F30FA61E4595, Net8 2791C1DD69BE, Modern 562C5DBD5BC2.
3. **Structural CE_STRUC_SUITE 1.0.114+0f00f5fb:** Legacy 1483F48B2337, Net8 E0C1E50F360B, Modern 25262A382560.
4. **Recorder:** `witness check` ok_to_load, SHA256 49E79D6D... (matches the pin); `witness load` took 0.8 s, SECURELOAD 0, no prompt, both sessions.

## Answer first

1. **YES: a plain zoom on the Civil drawing, with no pipe and no CE command typed, loses the Structural REDO after a drawing switch.** Both `_.ZOOM _W` (case 1) and `_.ZOOM _E` (case 2) gave "Nothing to redo".
2. **The control (case 4, Civil copy untouched) kept REDO:** "CIRCLE / Everything has been redone".
3. **Case 3 (`_.ZOOM _P` after case 1's zoom) KEPT REDO** ("CIRCLE / Everything has been redone"). That `ZOOM _P` took the Civil view back to exactly where it started (VIEWSIZE 24097.78, VIEWCTR 67981.66, -64738.26), although VIEWBACKSTATUS still read 1.
4. **What this means in AutoCAD terms:** the loss does not need a pipe, CD, AutoZoom or any CE code to trigger it. Changing the view of the Civil drawing is enough. CD's AutoZoom is therefore just one way of changing the view, and the placed pipe was a red herring for the trigger. **The caveat:** CE's plugins were loaded in this AutoCAD the whole time. I did not park the bundles (a vanilla AutoCAD), so I cannot yet say the behaviour is AutoCAD's alone; the brief's next step is the vanilla run.
5. **Rule 4 of the brief applies:** (1) and (2) LOST, so the cause is in the view/zoom handling and the next run goes vanilla. CD AutoZoom does nothing extra that I could see: SetCurrentView was not tested separately, only that a typed zoom gives the same loss.
6. **A side finding that corrects run 17:** a zoom alone moved **DBMOD from 1 to 17** (case 1 and case 2 both). Run 17 put DBMOD 1 to 17 down to the pipe objects being written. It was the view change. `ZOOM _P` took it to 21. So DBMOD is no evidence of objects written.
7. **Witness, same signature as runs 10, 16 and 17:** three `SysVarChanged VIEWBACKSTATUS` events on the Structural drawing between the U and the REDO in both lost walks (cases 1 and 2), and none in the control or in case 3.
8. **Driver calls: 60 of 60, counted by my wrapper** (section 5). Hard stop was 60 minutes; the run took about 6 minutes of PC clock.
9. **AutoCAD closed cleanly** with the driver `quit` (not killed), 2 drawings closed without saving, lock released, `Get-Process acad` shows nothing.

## 1. Copies

1. All from the source drawings, hash-checked before the first call: `CLD27_B1`, `CLD27_B2`, `CLD27_B3` from DRV1_B1 (34BBE37C2EA4) and `CLD27_S1`, `CLD27_S2`, `CLD27_S3` from DRV2_S1 (950AFDF6E523). All six matched.
2. Used: B1 and S1 for session 1 (cases 4, 1, 3 in that order), B2 and S2 for session 2 (case 2, after an AutoCAD restart). B3 and S3 unused.

## 2. The steps, as typed (each walk the same)

1. **Walk:** `open <Structural copy> -Writable`, `type "_.CIRCLE 0,0 <r>" -Enter` (radius 10, 15, 20, 25), `type "U" -Enter` (echo "CIRCLE" every time), sleep 15 s, `open <Civil copy> -Writable`, `open <Structural copy> -Writable`, `type "REDO" -Enter`.
2. **Case 4 (control, session 1, Civil copy untouched):** nothing done to the Civil copy, then the walk (radius 10). REDO echo: "CIRCLE" then "Everything has been redone". KEPT.
3. **Case 1 (session 1, on the same Civil copy, after the control):** `type "_.ZOOM _W 54000,-70000 64500,-69000" -Enter` (prompt echo showed both corners taken), then the walk (radius 15). REDO echo: "Nothing to redo". LOST.
4. **Case 3 (session 1, straight after case 1):** `type "_.ZOOM _P" -Enter`, then the walk (radius 20). REDO echo: "CIRCLE" then "Everything has been redone". KEPT.
5. **Case 2 (session 2, fresh launch with CLD27_B2 as the launch drawing, witness loaded):** `type "_.ZOOM _E" -Enter` (prompt echo showed `_E`), then the walk (radius 25). REDO echo: "Nothing to redo". LOST.
6. **Order matters and I chose it on purpose:** control first on a clean Civil copy, then 1, then 3 (which needs case 1's zoom), and 2 in a fresh session so it did not run on an already zoomed Civil drawing.

## 3. System variables on the Civil copy (typed getvar)

1. **Case 1 before (CLD27_B1, untouched):** VIEWCTR (67981.656, -64738.255, 0), VIEWSIZE 24097.777, VIEWBACKSTATUS 0, DBMOD 1.
2. **Case 1 after `_.ZOOM _W`:** VIEWCTR (59250.0, -69500.0, 0), VIEWSIZE 3796.460, VIEWBACKSTATUS 1, DBMOD 17. (This is the same view AutoZoom gave a pipe in run 17: VIEWSIZE about 3800, VIEWBACKSTATUS 1, DBMOD 17. So the typed zoom reproduces what the placed pipe did to the view.)
3. **Case 3 before:** VIEWBACKSTATUS 1 (read once; the other three I did not re-read, budget). **Case 3 after `_.ZOOM _P`:** VIEWCTR (67981.656, -64738.255, 0), VIEWSIZE 24097.777, VIEWBACKSTATUS 1, DBMOD 21. The view is exactly the original again.
4. **Case 2 before (CLD27_B2, fresh):** VIEWCTR (67981.656, -64738.255, 0), VIEWSIZE 23920.948 (not 24097.777: the same drawing in a freshly launched window differs by about 0.7%, the launch window shape), VIEWBACKSTATUS 0, DBMOD 1. **After `_.ZOOM _E`:** VIEWCTR (82629.807, -107463.943, 0), VIEWSIZE 254998.380, VIEWBACKSTATUS 1, DBMOD 17.
5. **Not read:** OSMODE, SAVETIME and CLAYER (my 60-call budget went on the cases; no `setvar` was used and nothing wrote them; the one status read at the start showed OSMODE 5375, SAVETIME 5, FILEDIA 1, CMDECHO 1, LOGFILEMODE 1, and `quit` restored the driver's own variables).

## 4. The witness, between U and REDO on the Structural drawing (my own reader on the logs after `quit`)

1. **Case 4 (control), log CLD27_S1 walk 1:** U seq 246, REDO seq 250. Between: HookCounts 1, LockModeChanged 2. No VIEWBACKSTATUS. KEPT.
2. **Case 1, CLD27_S1 walk 2:** U seq 317, REDO seq 324. Between: HookCounts 1, LockModeChanged 2, **SysVarChanged VIEWBACKSTATUS 3 (seq 320, 321, 322)**. LOST.
3. **Case 3, CLD27_S1 walk 3:** U seq 364, REDO seq 368. Between: HookCounts 1, LockModeChanged 2. **No VIEWBACKSTATUS.** KEPT.
4. **Case 2, CLD27_S2 walk 1:** U seq 249, REDO seq 256. Between: HookCounts 1, LockModeChanged 2, **SysVarChanged VIEWBACKSTATUS 3 (seq 252, 253, 254)**. LOST.
5. **Nothing else sat between any U and REDO:** no command, no object event, no autosave, no LISP.
6. **A point worth the next run's attention:** in case 3 VIEWBACKSTATUS was still 1 on the Civil drawing and the three events did NOT fire at the switch, and REDO survived. In cases 1 and 2 the Civil drawing differed from the Structural one in its view, the events fired and REDO was lost. So the events do not follow the number 1 in VIEWBACKSTATUS; they follow the view actually being different from where it was at open. That is an observation, not a proven cause.
7. Logs: `C:\ce_rc_scratch\witness\CLD27_S1_20261010-213940-974.jsonl` (cases 4, 1, 3), `CLD27_S2_20261010-214254-645.jsonl` (case 2), and the Civil logs `CLD27_B1_*` and `CLD27_B2_*` (B1's log opened before the recorder was loaded, so it holds only part of the session).

## 5. Driver findings and the call count

1. **Calls: 60 of 60, every individual call counted by the wrapper**, including the 4 getvars per before and after, the lock, launch, `witness check`, `witness load`, status and the two `quit`s. I kept the last call for the final `quit`.
2. **Budget shortfalls, honestly:** the case 3 before read was one variable (VIEWBACKSTATUS) not four, and I did not re-read OSMODE, SAVETIME or CLAYER. The control was not read before and after, since nothing was done to the Civil copy.
3. **No driver refusals.** `type "_.ZOOM _W ..."`, `"_.ZOOM _E"` and `"_.ZOOM _P"` were accepted as complete commands. The lock took over cleanly after the first `quit` (I waited 12 s before `lock acquire`, as run 17 advised) and the second session started first time.
4. **Two sessions were needed:** case 2 had to start from a fresh drawing, so AutoCAD was restarted once; the launch drawing opened before the witness was loaded (as in runs 16 and 17), so its own log is partial; the Structural logs carry every U to REDO window and are complete.

## 6. What this says, and what it does not

1. **What it says:** on AutoCAD 2027 with Civil 3.0.46, Manager 1.1.46 and Structural 1.0.114 loaded, any change of the Civil drawing's view (a window zoom or a zoom to extents) makes a later REDO in the Structural drawing say "Nothing to redo" after a switch to Civil and back. A zoom that goes back to the original view (`ZOOM Previous`) does not. A placed pipe does it only because CD's AutoZoom changes the view.
2. **What it does not say:** that this is AutoCAD alone, because the CE plugins were loaded. The decisive step is the vanilla run (the same case 1 with the bundles parked, as in run 8). If vanilla also loses REDO, BUG-558 is AutoCAD's own zoom-history handling at a drawing switch, and CE can only avoid it (no zoom, or restore the view). If vanilla keeps REDO, something in CE reacts to the three VIEWBACKSTATUS notifications or to a view difference at activation, and the next run should log every CE Idle and DocumentActivated handler.
3. **Not proven:** the case 3 difference. The cause could be the view being back at its original, or the order of events (a zoom after a zoom, history state), or the earlier lost walk on the same Structural drawing. I did not repeat case 3 on a fresh session (budget).
4. **Not run:** `SetCurrentView` itself (the exact call CD AutoZoom makes) separate from a typed ZOOM; `_.PAN` (interactive, skipped as the brief said); AutoZoom switched off in CE Settings with a pipe placed (round 3 split 3); the vanilla run.
5. **Counts:** the loss now follows a changed Civil view in every case tried (2 of 2 typed zooms, plus the 12 of 12 placed-pipe walks of runs 5, 10, 16 and 17), and REDO survives when the Civil view is unchanged or put back (control; case 3; runs 16 D and E, opened-and-cancelled windows).

## 7. Recommendation

1. **Next run (about 20 calls, one fresh launch):** vanilla AutoCAD, bundles parked as in run 8, `witness load` after launch, then control and case 1 only (typed `_.ZOOM _W` on a Civil copy, then the walk), then case 3. This answers whether CE has any part in it.
2. **Desk:** BUG-558 stays open on Civil 3.0.46. Do not mark it fixed. Record in the bug file that the trigger is any view change on the other drawing, including a plain typed zoom, so it reproduces with no CE command; and that DBMOD 17 after a pipe is the view, not the objects.
3. **A cheap CE-side test for the code worker:** with a pipe placed and AutoZoom switched off in Settings (round 3 split 3), run the same walk; if REDO survives the cause is confirmed as the view change.

## Summary

Claude ran run 18 in about six minutes using all 60 driver calls on fresh test copies in AutoCAD 2027 (Civil 3.0.46, Manager 1.1.46, Structural 1.0.114, witness pin matching). With no pipe and no CE command, a plain typed `_.ZOOM _W` on the Civil copy and a plain `_.ZOOM _E` on a second fresh Civil copy both lost the Structural REDO after a plain circle, U, 15 s and a switch to Civil and back ("Nothing to redo"), each with three VIEWBACKSTATUS events between the U and the REDO; the untouched control kept REDO, and `_.ZOOM _P` after the first zoom (which put the view back exactly) also kept it. So the cause is the view or zoom history of the other drawing, not the pipe or CD AutoZoom as such; a typed zoom reproduces what AutoZoom did to the view (VIEWSIZE about 3800, VIEWBACKSTATUS 1, DBMOD 1 to 17, and DBMOD 17 is the view, not the pipe objects as run 17 assumed). The CE plugins were loaded the whole time, so the next run should be vanilla; OSMODE, SAVETIME and CLAYER were not re-read and nothing was saved.

AUTOCAD CLOSED
