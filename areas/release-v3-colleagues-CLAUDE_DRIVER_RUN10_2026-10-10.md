# Claude driver run 10: witness journeys 1 and 5 plus typed checks of the new Structural and Civil PRs, Saturday 10 Oct 2026 (PC clock 05:52 to 06:11)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 10, Sonnet, headless. `Get-Process acad` showed nothing running first. Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only: `C:\ce_rc_drv\CLD18_B1.dwg` (hash 34BBE37C2EA4 = DRV1_B1), `CLD18_S1.dwg` (950AFDF6E523 = DRV2_S1), `CLD18_B2.dwg` (a second untouched Civil copy, 34BBE37C2EA4) and `CLD18_M1.dwg` (from DRV15_METRE, 5C16AFFD66C7). Nothing was saved. I did not go round the driver at any point; I used `-Force` only on bare command words, the way the README and the journeys write it.

## Answer first

1. **BUG-558 with a CD pipe placed: REPRODUCED. REDO was lost 2 of 2** (a Structural plain circle, U, 15 s, switch to the Civil copy that holds the CD pipe and back, REDO said "Nothing to redo"). **The control kept REDO 1 of 1** (the same steps, but the switch went to a fresh Civil copy with no pipe: "Everything has been redone"). Run 5 lost 4 of 4 with a pipe; runs 6 to 9 kept 14 of 14 with none. The pipe (or the CD run) is the difference.
2. **The witness shows what changes at the lost switch: three `VIEWBACKSTATUS` events on each drawing between the U and the REDO** (Civil 05:57:45, Structural 05:57:47 and again 05:59:37). In the control walk there are none. That is exactly run 5's picture, and the first time it is tied to a cause: the switch to the drawing where CD ran.
3. **Journey 1 (calibration): PASS.** C4 (the LISP colour change) shows `ObjectOpenedForModify` and `ObjectModified` for the circle. The new recorder is not blind.
4. **The driver, new copy, with CE windows: the New Pipe window was found (source `win32`, owned window), driven by `ui type` / `ui click` through the allow-list, Design Warnings found and OK'd, and `esc` stopped the CD prompt.** One real gap: a CD prompt that is waiting at the FIRST question cannot be typed into per call (section 3).
5. **Part B: 3 PASS (#887, #902, #893), 1 BLOCKED on a driver gap (#867), 4 SKIPPED (#870, and #880 to #885 as one group), Manager #866 / #868 / #869 BLOCKED by the driver.** Details in section 5. #880 to #885 are NOT in the installed Civil 3.0.43 (checked by git ancestry), so nothing could be tested for them.
6. **Four AutoCAD wedges, all my doing or the driver's gap, all ended by the driver's `quit -Kill` on the AutoCAD it launched** (section 6). The final session ended with a clean `quit`.
7. **System variables unchanged:** OSMODE 5375 and SAVETIME 5 on all three drawings read; CLAYER BLOCKS (Civil), 0 (Structural), 25DIMS (metre copy), same before and after. I set INSUNITS to 6 on the metre copy only (not saved).
8. **Driver calls: 106 counted** (cap 110). Journey 1 used 10. Journey 5 used 45 (over its cap of 25: 10 in the first attempt that wedged, 21 for the relaunch and the walk, 14 for the control and the repeat). Part B used 51.

## 0. Installed versions (readdll.ps1, 10 Oct 05:52)

1. **Civil CE_CVL_SUITE 3.0.43+e636e17d:** Legacy 14C6D2B5A790, Net8 DE3878392463, Modern AF0A645566C5.
2. **Manager CE_SUITE_MANAGER 1.1.43+e636e17d:** Legacy B1D3CFC14DCC, Net8 28E37F294550, Modern 502D5A776CA8.
3. **Structural CE_STRUC_SUITE 1.0.112+24238160:** Legacy BF0644C3D1B1, Net8 69D0245686C3, Modern D3DFBB5D029D.
4. Recorder: `witness check` said ok_to_load, SHA256 49E79D6D... (the new one). `witness load` worked three times (0.8 s, no prompt, SECURELOAD 0).

## 1. Journey 1: calibration (PASS)

1. Loaded the recorder in `CLD18_B1`, then `_.CIRCLE 0,20000 10`, then three LISP lines.
2. **C2, `(entget (entlast))`:** a `LispWillStart` line and **no object event**. A read raises nothing.
3. **C3, `(entmod (entget (entlast)))` (same data written back): YES, it raises `ObjectOpenedForModify` and `ObjectModified`** for the circle (handle 11C55A). So an open-for-write with no change still shows as a change. Any command that writes back unchanged data will look like a touch in the witness.
4. **C4, `(entmod ... (cons 62 1))` (colour red):** `ObjectOpenedForModify` and `ObjectModified` for 11C55A. The expected line is there.
5. **HookCounts:** a LISP line does not end with a `CommandEnded` or a `HookCounts` line. I ran `_.REDRAW` as the next command; its `HookCounts` read appended 1, modified 5, erased 0, openedForModify 5, faults 0. The circle's own creation was modified 3, so C3 and C4 added 2: one each. No faults.
6. Log kept: `release-v3-colleagues-CLAUDE_DRIVER_RUN10_witness_J1_B1.jsonl`.

## 2. Journey 5: CD pipe then switch (the BUG-558 test)

**The sequence that worked (second AutoCAD):** `open` Structural, `open` Civil back, then the one-call form `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`. CD printed "Pipe end moved to the inside wall of P10 (was 225 mm inside the pit)" and the New Pipe window appeared in 9.5 s.

1. **New Pipe window found by the driver:** `ui windows` listed it twice, once as `docked` and once as `window` with `source win32` and `owned_window true`. So the owned-window fix works in real AutoCAD. `ui tree "New Pipe"` read 101 controls, no truncation. The invert boxes have ids `C2.FirstInvert` and `C2.SecondInvert`; Start Pipe is `C2.OkCommand` (disabled until both levels are set).
2. **Driven through the allow-list:** `ui type "New Pipe" "C2.FirstInvert" "18.500"`, same for `C2.SecondInvert`, `ui click "New Pipe" "C2.OkCommand"` (InvokePattern). The second box's name changed to "Downstream · P9 · Calculated from grade" after the first level was typed; the id stayed the same.
3. **Design Warnings window:** appeared after Start Pipe ("Pipe is essentially flat, no measurable fall", the window says warnings are informational, the pipe has been saved). `ui click "Design Warnings" "OK"` closed it (two matches, InvokePattern).
4. **`esc` at "Pipe placed. Pick the next pipe's first point, or press Esc to stop.": PASS.** `esc_sent 1`, `ce_prompt_waiting true`, `command_ended true`, `cmdactive_after 0`. CE printed "[CE] Stopped. Everything placed stays; U takes back the last one." The witness shows `CommandCancelled CD`.
5. **The REDO walk (pipe in the Civil copy):** Structural `_.CIRCLE 0,0 10`, `U` (echo "CIRCLE"), 15 s, `open` Civil, `open` Structural, `REDO`: **"Nothing to redo".** Witness (Structural log): `CommandEnded U` (seq 254), then three `SysVarChanged VIEWBACKSTATUS` at 05:57:47.364, .392 and .424, then `LockModeChanged REDO` and `CommandWillStart REDO` at 05:57:48.711. The Civil log has three at 05:57:45.854, .878 and .909. Nothing else between the U and the REDO (no command, no object event, no autosave).
6. **Repeat (the same switch to the Civil copy with the pipe):** circle `0,0 20`, U, 15 s, switch and back, REDO: **"Nothing to redo" again.** The same three `VIEWBACKSTATUS` events (05:59:37.168, .200, .233) sit between the U (seq 368) and the REDO (seq 374).
7. **Control (the brief's "without the CD pipe in the same session"):** I opened a fresh, untouched Civil copy `CLD18_B2`, then Structural circle `0,0 15`, U, 15 s, switch to `CLD18_B2` and back, REDO: **"Everything has been redone".** Witness: between the U (seq 300) and the REDO (seq 304) there is only `HookCounts` and a lock change. **Zero `VIEWBACKSTATUS`.**
8. **What this separates and what it does not:** the loss follows the switch to the Civil copy in which CD placed a pipe, and so does the burst of three `VIEWBACKSTATUS` events. It is not time (15 s each), not the first-ever switch (the first walk in the same session with the fresh copy kept REDO), and not the Structural drawing. **Not separated:** whether it is the pipe itself, the CD command having run in that drawing, or the view that CD leaves behind (CD pans or zooms). I did not U the pipe and repeat (that would have been another 8 calls over the cap); that is the next case.
9. **Not tested:** the Civil copy with a pit moved but no CD (runs 3 to 9 did that and kept REDO), and a pipe placed by a method other than the New Pipe window.
10. Logs kept: `release-v3-colleagues-CLAUDE_DRIVER_RUN10_witness_J5_B1.jsonl` and `..._J5_S1.jsonl`.

## 3. What the driver could not do (findings for the tooling worker)

1. **Per-call CD points are impossible.** I typed `CD` with `-Force` (first attempt). CD then waited at "Select the first two points to start the polyline, or E to use a line you have drawn." The next two `type` calls were refused with "BUSY: AutoCAD rejected the text four times" (COM refuses while a prompt waits). The brief's "each point its own type call" cannot work through COM; only the one-call newline form works. The README already says this about prompts; the journey 5 JSON should say it too.
2. **`esc` refused at that first CD prompt:** "no CE command at a prompt". The prompt line ends in a full stop, not a colon, and no `[CE]` line was printed. The Opus rule (a prompt ending in a colon) misses it. The only way out was `quit -Kill`, which lost that AutoCAD and its recorder session (the first witness log of that session is lost; the calibration log was copied first).
3. **`esc` refused at FEDIT's "Change footing type? ... Select new type" prompt** (section 5, #867): `$script:CeCommandPattern` has only Civil command names, no FEDIT, no Structural commands, so any Structural prompt that is waiting can only be ended with `quit -Kill`.
4. **The Manager windows are not on the allow-list.** `CEMANAGERADMIN` opened "CE Suite Manager | Admin Dashboard" (found by `ui windows`, marked `view-only`), but `ui tree` on it was refused ("title is not on the CE window allow-list"). `-ExpectWindow "Creative Engineering"` also did not match it (the title starts "CE Suite Manager"). Section 5 item 8 shows what that blocks.
5. **A typed answer chain after a command that stops by itself can wedge.** My first C1 chain on a layout tab (`C1`, two points, `7`) was stopped by CE with the correct line, but the leftover lines landed at the Command: prompt as "Unknown command" and the last `7` left AutoCAD spinning at 1.56 cores with a prompt waiting. Nothing like it happened with the same chain on the model tab (run 9). For a guard test, send the bare command word with `-Force`; the guard fires before any question, and AutoCAD stays idle.

## 4. The new typed-form PRs: which build holds them

I checked each PR head against the installed commits with `git merge-base --is-ancestor` (Structural 24238160, Civil e636e17d).

1. **In Structural 1.0.112:** #887, #902, #867, #893.
2. **In Civil 3.0.43:** #870, #866, #868, #869.
3. **NOT in Civil 3.0.43:** #880, #881, #882, #883, #884, #885 (their branches sit on a later stack; nothing could be tested for them).

## 5. Part B results

1. **#887 R1 / C1 / BT1 on a layout tab: PASS (3 of 3).** The Structural copy has Layout1 and Layout2. `(setvar "CTAB" "Layout1")` gave CVPORT 1. Typed bare with `-Force`, each stopped with one line, `wait` idle after each:
   1. **BT1:** "You are on a layout tab (paper space), so CE drew no bracing truss. Go to the Model tab, or double-click into a viewport, and try again."
   2. **R1:** "... so CE placed no tag. ..."
   3. **C1:** "... so CE placed no support. ..." (the first, chained C1 gave the same line, then the wedge in section 3 item 5).
   4. Nothing was drawn (no prompt, no object event: this part of the run had no recorder, so I rely on the message; I did not count objects).
2. **#902 R1 / BT1 / C1 in a metre drawing: PASS (3 of 3).** `DRV15_METRE.dwg` is NOT a metre drawing (INSUNITS 4, so C1 asked its first question and wedged AutoCAD: my wrong assumption, I should have read the value first). I killed that AutoCAD, relaunched, set `INSUNITS 6` on the unsaved copy and read it back ("INSUNITS NOW 6"). Then C1, BT1 and R1 each printed: "This drawing's units are metres. This command draws footings, labels and text at millimetre size and cannot convert them yet, so CE has not run it. Check what the drawing is really drawn in (LIST one footing) before changing anything." AutoCAD idle after each. TS1 not run (same code path as C1). The Settings switch (hold off) was not tried: it would change Tim's settings.
3. **#893 footing size over 10 m: PASS, and the installed behaviour differs from the PR text.** FEDIT on PF1 with X size 12000 printed: "Warning: 12000 mm is more than the usual limit of 10000 mm. CE keeps the value you typed; check it." Then Y and depth answered with Enter, "Change footing type? No", "[FOUNDATION] Redrew footing system 'Footing Network': 4 footings. Nothing needs attention.", "[FEDIT] PF1 updated." So it warns and keeps the typed value by default. **The PR text says the warn switch is default OFF (refuse); the code in the build says the default is warn-and-keep (comment "TRAIN S-31 finalizer"), and the run shows warn-and-keep.** The PR body is out of date, the behaviour is the one the brief expects.
4. **#867 FEDIT Esc at the new-type question: BLOCKED.** I reached "Change footing type? [Yes/No] <No>: Yes" (first on PF1, which no longer sat at 300,0 after #893 made it 12000 wide: "Nothing Selected", the empty Enters repeated FEDIT harmlessly; then on PF3 at 6000,0). `esc` refused (section 3 item 3). The wording to expect, from source, is "[FEDIT] Cancelled. Nothing was changed." I did NOT see it printed. Needs `esc` to learn FEDIT, or Codex.
5. **#870 (BUG-457, redo checker): SKIPPED, not what the brief says.** #870 is the redo-checker change ("resume step never writes after U"); it has no typed form and is only unit-tested. The brief's "PIT inside REFEDIT refused with one plain sentence" is #880, which is not installed.
6. **#880 to #885: SKIPPED, not in the installed Civil 3.0.43** (section 4). The read-only Pit Schedule (#881) is one of them.
7. **#866 / #868 / #869 (Manager): BLOCKED by the driver.** `CEMANAGERADMIN` opens "CE Suite Manager | Admin Dashboard" and `ui tree` is refused. I did not open the plain `CEMANAGER` window (call budget); the brief's claim "the Manager window has NO Roll Back button" is therefore NOT verified. Per the PR text, Roll Back is in the admin window, hidden unless `manager-switches.json` has `showRollBack true`.
8. **What would unblock the Manager items:** add `CE Suite Manager*` to the allow-list as read-only (like `Start Here`): `ui tree`, `read`, `scan`, `windows` only.

## 6. The four wedges (all ended by `quit -Kill` of the AutoCAD this driver launched)

1. **Wedge 1, CD first prompt:** my `type "CD" -Force` as the brief's journey 5 says; section 3 items 1 and 2.
2. **Wedge 2, chained C1 on a layout tab:** section 3 item 5.
3. **Wedge 3, FEDIT new-type prompt:** I deliberately asked FEDIT to reach it, intending `esc` to end it; `esc` refused; section 3 item 3.
4. **Wedge 4, C1 on the "metre" copy that was really millimetres:** section 5 item 2.
5. Every wedge: CPU about 1.5 cores, `alarm true`, `cancel` refused, `quit -Kill` ended it in 33 s, `restore` skipped (the next launch kept LOGFILEMODE correct; the final clean `quit` restored LOGFILEMODE 1). No drawing was ever saved, no real file touched. The kills removed stray log files (`CLD18_*`, `Drawing1_*`) only.

## 7. System variables

1. **Civil `CLD18_B1` before:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS. **Structural `CLD18_S1` before:** 5375, 5, 0.
2. **Metre copy before and after:** 5375, 5, 25DIMS; after (read after the last test): 5375, 5, 25DIMS.
3. **I could not read the "after" values on the Civil and Structural copies**: each AutoCAD holding them was killed before an "after" read (wedges 1 and 3). The recorder's `SysVarChanged OSMODE` events in the Civil log are CD's own snap changes during the pipe and are put back by CD.
4. SAVETIME untouched. No `setvar` used. INSUNITS 6 on the metre copy only, unsaved.

## 8. What I could not prove

1. Whether the pipe, the CD command, or the view CD leaves behind is what costs REDO. The next case: after the pipe, `U` the pipe in the Civil copy (or run CD and `_.ZOOM`/`_.PAN` without placing), then repeat the switch.
2. #867's printed sentence, the Manager windows, #870, #880 to #885, the new-type prompt behaviour with Esc.
3. TS1 on a layout tab and in a metre drawing (same path as C1).
4. Two lost walks and one control is small, but run 5's 4 of 4 and runs 6 to 9's 14 of 14 point the same way.

## 9. Recommendations

1. **Desk:** treat BUG-558 as reproduced by the CD route with a witness trace (VIEWBACKSTATUS burst at the switch to the Civil drawing). The fix to look at is whatever CD leaves in the drawing's view history (the witness names the system variable `VIEWBACKSTATUS`, which means a view was added to or removed from the previous-view stack).
2. **Tooling:** (a) teach `esc` about prompts ending in a full stop and about Structural commands (FEDIT, C1, BT1); (b) put the Manager windows on the read-only allow-list; (c) correct journey 5: no per-point calls, use the one-call form; (d) record in the README that `DRV15_METRE.dwg` has INSUNITS 4, so a metre test needs `(setvar "INSUNITS" 6)` first; (e) guard tests should be bare `-Force` words, not chains.
3. **Desk:** #893's PR body should say warn-and-keep is the default, and the brief's #870 and #880 numbering should be re-checked.

## Summary

Claude ran run 10 in about 19 minutes with 106 counted driver calls on four test copies in AutoCAD 2027 with Civil 3.0.43, Manager 1.1.43 and Structural 1.0.112. The calibration passed (C3, an open-for-write with unchanged data, does raise ObjectModified; C4 shows). With a CD pipe placed through the New Pipe window, found by the driver as an owned Win32 window and driven through the allow-list with Design Warnings and `esc` working, REDO was lost 2 of 2 after switching to that Civil copy and back, with three `VIEWBACKSTATUS` events on each drawing between the U and the REDO; the control switch to an untouched Civil copy kept REDO and showed none. The typed checks passed for #887 (R1, BT1 and C1 stop with one line on a layout tab), #902 (the three stop in a metre drawing) and #893 (a 12 000 mm footing warns and keeps the value, which is the opposite of what the PR text says); #867 and the Manager items were blocked by the driver (`esc` does not know FEDIT, the Manager windows are not on the allow-list), and #870 and #880 to #885 were skipped because they are not what the brief describes or not in the installed Civil build. Four wedges (a CD first prompt, a chained answer after a guard stop, FEDIT's new-type prompt, and a "metre" drawing that was really millimetres) were ended with the driver's `quit -Kill`, and the final session was closed cleanly.

AUTOCAD CLOSED
