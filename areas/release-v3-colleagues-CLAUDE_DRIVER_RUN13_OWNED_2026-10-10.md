# Claude driver run 13: the owned-drawing prediction (Sat 10 Oct 2026, PC clock 07:21 to 07:26)

**Run:** desk plan/03, Sonnet, headless. Test copies only: `C:\ce_rc_drv\CLD21_CVL_B1.dwg` and `C:\ce_rc_drv\CLD21_B1.dwg`, both copies of DRV1_B1 (hash 34BBE37C2EA4 for all three, checked). One AutoCAD 2027 (pid 60340, started by the driver at 07:21 after `Get-Process acad` showed nothing). Driver `acad_driver_witness.ps1` only, witness loaded (load PASS, 1.1 s, SECURELOAD 0). Nothing saved.

## Answer first

1. **Does a U in a CVL-named Civil drawing lose REDO without any switch? NO. 4 echoes, 4 times "Everything has been redone".** The prediction did not hold on the installed Civil 3.0.41.
2. **The likely reason: the installed build already has the fix, and the sweep read a stale master.** The installed Civil is commit `660487d1` (Version: Civil 3.0.41). Its `LinkService.Reactors.cs:899-912` already says "BUG-192 v2 (Codex pass 18, 'Nothing to redo' straight after U) ... reads through open-close transactions (lightReads) ... a transaction-manager read here threw Redo away", and calls `RebuildRuntimeCaches(db, state, "undo/redo", lightReads: true)`. `ProjectDataService.Persistence.cs` in that commit reads with `StartOpenCloseTransaction` at lines 140, 717 and 837. The master checkout (650c0c19) has none of that (no "lightReads", no "BUG-192" in the Reactors file) and commit 660487d1 is NOT an ancestor of master. So the 07:08 "measured" REDO killer chain in BUG-558 sweep section 3 item 1 is real on master but is already fixed in what Tim has installed. Do not hand builders the "four lines" job until it is checked against the release branch that holds 660487d1.
3. **That is a code reading, not a second measurement.** I did not run the master build in AutoCAD.

## The four cases (every echo, with the witness lines between U and REDO)

All cases: U then 15 s then REDO. The witness read after AutoCAD closed (its logs only flush at close).

1. **Case 1, CVL copy, `_.CIRCLE 0,70000 10`, U, 15 s, REDO:** U echo "CIRCLE". REDO echo "CIRCLE" then **"Everything has been redone"**. U at 07:22:53, REDO at 07:23:10 (17 s). Witness between U end and REDO start: 1 HookCounts line and 2 LockModeChanged lines (the writes lock handing over). No object, command, sysvar, view or autosave event.
2. **Case 2, CVL copy, pit P3 (handle 109D56) selected with `(sssetfirst nil (ssadd (handent "109D56") (ssadd)))`, `_.MOVE 0,0 0,1000`, U, 15 s, REDO:** MOVE printed "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is" (so CE's link code was running on this drawing). U echo "MOVE". REDO echo "MOVE" then **"Everything has been redone"**. U 07:23:25, REDO 07:23:42. Witness between: HookCounts, one `ObjectModified` on handle 2430 (a DrawOrderTable, the drawing's own bookkeeping after the move), 2 LockModeChanged. No transaction-type events exist to log (not logged).
3. **Case 3, plain copy (control), `_.CIRCLE 0,70100 10`, U, 15 s, REDO:** **"Everything has been redone"**. U 07:23:57, REDO 07:24:14. Witness between: HookCounts and 2 LockModeChanged only.
4. **Case 4, CVL copy again, `_.CIRCLE 0,70200 10`, U, 15 s, REDO:** this time the drawing had just been re-activated and CE printed four "[CE] Background not found: XW26xx..." lines after the CIRCLE (the missing-background notice, as in earlier runs). REDO echo **"Everything has been redone"**. U 07:24:29, REDO 07:24:44. Witness between: HookCounts and 2 LockModeChanged only.
5. **No VIEWBACKSTATUS events appeared in either log in this run**, including in cases 1 to 3 where there was no switch between U and REDO (the switches in this run were before the CIRCLE, not between U and REDO). That fits run 5: those events belong to a switch that happens between U and REDO.

## What the file name does (read from the code, LinkService.cs:1158-1174)

1. `GetEffectiveDiscipline` reads the explicit tag first, then `DrawingDisciplinePolicy.ParseFilenameDiscipline`. The token form is **`_CVL_` with underscores on both sides**, case-insensitive (regex `_(STR|CVL)_`). `CLD21_CVL_B1.dwg` matches it (the folder `C:\ce_rc_drv\` has no token). The plain copy `CLD21_B1.dwg` has no token and no CE project record in it.
2. If Civil, `state.IsCeOwned = true` at registration. **I could not read that flag directly.** Indirect evidence the CVL copy was CE-owned and CE was active: the "[CE Civil] pipe P3 -> P2 label" message on the MOVE and the "[CE] Background not found" notices. I did not see the same CE messages on the plain copy, but I only ran a CIRCLE there.

## System variables

1. **Before:** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS" (on the CVL copy, active when read).
2. **After (3 reads, just before the quit):** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". Unchanged. I changed none.

## What I could not prove

1. That `IsCeOwned` was true on the CVL copy (no way to read it from the driver; only the indirect CE messages above).
2. That the 660487d1 code is what is really installed and running: the version text from the earlier runs (Civil 3.0.41+660487d1) says so, and I did not re-read the DLLs this run. Case 1 to 4 behaviour agrees with it.
3. That master would lose REDO. The 07:08 console measurement says a read-only transaction in CommandEnded of U does; I did not run master in AutoCAD.
4. Anything about BUG-558 (the loss across a drawing switch). This run has no switch between U and REDO, by design. It stays open.
5. Case 2 used one pit move only. Cases 5 onward (a New Pipe placed first, then U) were not part of this run.

## Recommendations for the desk

1. **Correct the BUG-558 sweep section 3 item 1 and section 4:** say the chain is already fixed in the release build 660487d1 (BUG-192 v2), and that it is only live on the stale master. Check whether the release branch still has every other fix item (item 2, Project QA at 3 s; `BlockService.cs:227`; the XREF notice reader) before spending builder time: those may also differ on the release branch.
2. **Item 4 (XREF reader on every activation) is a live suspect for BUG-558 on the installed build:** this run's CVL copy printed the "[CE] Background not found" lines after the CIRCLE that followed a switch, so the notice runs on activation of this copy.
3. A Codex run that repeats this on a NEW pipe placed in the drawing (CE-owned by the writer path) would close the last gap.

## Counts and clean-up

1. **Driver calls: 27 of 40**, counted with a wrapper (lock 1, launch 1, open 6, witness load 1, getvar 6, type 12 including one LISP selection, quit 1). Run time about 5 minutes against the 45-minute stop.
2. **AutoCAD closed cleanly** by the driver `quit` (CloseMainWindow, not killed, 2 drawings closed without saving), lock released, `Get-Process acad` shows nothing. Stray logs removed by the driver: CLD21_B1, CLD21_CVL_B1 and Drawing1 logs.
3. Witness logs (document names, handles and timings only) are in `C:\ce_rc_scratch\witness\CLD21_*.jsonl`; not copied here (193 KB for the CVL copy).
4. I did not touch Tim's drawings or settings; the only files I made are the two test copies and this note.

## Summary

Run 13 tested the owned-drawing prediction on fresh copies of DRV1_B1: one named `CLD21_CVL_B1.dwg` (carries the `_CVL_` token) and a plainly named control, both writable in one AutoCAD 2027 with the witness loaded, 27 of 40 driver calls. A plain circle then U then 15 s then REDO, and a typed MOVE of pit P3 then U then REDO, all kept REDO ("Everything has been redone") on the CVL copy and on the control, 4 of 4, with only lock-handover lines between U and REDO in the witness. So a U in a CVL-named Civil drawing does NOT lose REDO on the installed Civil 3.0.41; the reason found in the code is that installed commit 660487d1 already reads through open-close transactions at the end of U (BUG-192 v2), which the stale master the sweep read does not. I could not read the CE-owned flag directly (CE messages on that copy suggest CE was active), did not run master, and this run says nothing about BUG-558's drawing switch. SAVETIME, OSMODE and CLAYER were unchanged.
