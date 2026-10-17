# Claude driver run 25: Civil 3.0.53 / Manager 1.1.53 / Structural 1.0.118 (Sun 18 Oct 2026, 02:09 to 02:29 Melbourne, PC clock)

**Installed builds (nine DLLs read first with readdll.ps1):** Civil 3.0.53+b06126db (train C-42), Manager 1.1.53+b06126db, Structural 1.0.118+9a8e5d4e (S-38). Legacy, Net8 and Modern of each carry the same version text.

**Answer first.** None of the Hunt Civil E fixes I could type still fails, but **two NEW faults turned up that Tim should hear about: CD's "Existing line" refuses every plain polyline (BUG-697), and CDSYNC sets every pipe size in the schedule to 100 (BUG-698).** Of the 21 fixes, only two (the erased pit label, BUG-667, and the plain pipe erase) could be proven by typing. Most of the rest need a window button the driver will not press.

Counts: **PASS 9, STILL FAILS 0, BLOCKED 5 groups (covering about 15 of the fixes), UNPROVEN 1, NEW FAILS 2, known CEHEALTH warning 1.** AutoCAD is closed. Nothing was saved. Both test copies still equal their sources.

Driver calls (counted by a wrapper, every call): session 1 used 69 of 70 (about 12 minutes), session 2 used 68 of 70 (about 8 minutes). No forced kill. Both sessions ended with `quit` (CloseMainWindow).

## A. Setup

1. **Before launch.** `Get-Process acad,accoreconsole` showed nothing. Codex queue.log last line was an END (verifyW65 at 08:38), no START without an END.
2. **Fresh copies, hash-checked.** CLD70_B1 and CLD71_B1 from DRV1_B1 (34BBE37C2EA4); CLD70_S1 and CLD71_S1 from DRV2_S1 (950AFDF6E523). All four still equal their source after the run.
3. **Witness recorder** loaded in both sessions (sha 49E79D6D...). I did not read the witness logs: none of the checks asked for them.
4. **Session 1** was the Civil copy only. **Session 2** held the Civil copy first and the Structural copy second. The "What's New" window opened in session 1 only (closed with `ui close`).
5. **Variables.** Civil copy, read before: OSMODE 5375, SAVETIME 5, CLAYER BLOCKS. Read again at the end of each Civil session: unchanged. The Structural copy's three variables were NOT read back (my filter hid the values), so for Structural I can only say I did not change them.
6. **Test conditions staged by LISP (please rule on this, same as runs 23 and 24).** I used `-AllowLisp` for: selecting a pit before a MOVE (`sssetfirst`), a zoom, and answering three pick prompts with `(handent "...")` or `(entlast)` (CD's "Pick the drawn polyline", CDPROPAGATE's "Select anchor pit", PITDELETE's "Select pit block"). No system variable was changed and nothing was saved.

## B. The Hunt Civil E fixes (highest severity first)

1. **NEW FAIL (BUG-697). CD, answer E, pick a drawn line: refused every time. (This is the BUG-684 repro; it could not be reached.)** I drew a closed rectangle (handle 11C558), another closed rectangle (11C55A) and an open three-point line (11C55B), all plain polylines on layer BLOCKS. For each, typed `CD`, `E`, then the line. AutoCAD printed "Specify first point or [Existing line] [Existing]: E", "Pick the drawn polyline to use as the pipe route:", then **"[CE] That line is already a CE pipe. Double-click it to change it. Nothing was changed."** and "[CE] CD command cancelled." No pipe window opened. Tried with `(entlast)` and with `(handent "11C55A")`: same. Source reading (not a run): `CdCommand.ExistingLine.cs:125` takes `TryResolvePipe(...)` returning true as "already a pipe", and `PipePickService.TryResolvePipe` returns true for any polyline. **What I do not know:** whether it ever worked, and whether a real mouse pick differs (the picked object is the same). **So BUG-684 (closed line kept, one plain sentence) is BLOCKED by this fault.**
2. **NEW FAIL (BUG-698). CDSYNC sets every pipe size to 100.** Typed `CDSYNC` (it asks nothing). AutoCAD printed "[CE] CDSYNC will re-link every pit and pipe in this drawing... One U undoes it." and "CDSYNC complete. Pits relinked: 11, Pipes relinked: 49". I opened the Pit Schedule before (baseline, saved) and after: **30 pipe-size cells changed, every one to 100** (the 450, 375, 150 and 225 mm pipes). No pit number, FROM, level, cover or depth cell changed. I proved it was CDSYNC and not my U/REDO: the first reading was after U and REDO of CDSYNC; then I undid it (UNDO 2: the Pit Schedule visit and CDSYNC), the schedule matched the baseline with 0 differences, and a fresh CDSYNC with nothing in between gave the same 30 changed cells. **What I have not verified:** the cause (the 49 pipes were converted to CE pipe objects at open; that may be why), or whether 3.0.52 did the same.
3. **PASS. BUG-667 (Hunt C3): erasing a pit's own label no longer breaks the link memory.** On pit P3 (handle 109D56), erased its label block (109E08, "P3") with typed `_.ERASE` (pick-first count 1). Then: (a) typed `_.MOVE 0,0 0,1000` of the pit: the pit, its cover text (109E0F) and the pipe end all moved up 1000, CE printed no error; (b) `U` (echo "MOVE"); (c) a second typed MOVE `0,0 0,-800`: pit, cover text and pipe end all moved down 800 together (the hunt's bad result was "labels stop following"); (d) `PITDELETE` with the pit as the answer: "Pit deleted (block + label/cover)." and "[CE Civil] The pit was erased and the schedule is updated. 6 pipes now have ends that are Not connected yet. U restores everything." (the hunt's bad result was "Error during PITDELETE"); (e) `U` (echo "PITDELETE"), 12 s, `REDO` ("PITDELETE", "Everything has been redone"), then `U` again: pit and cover text back. I did not read the CE log for erased-object lines.
4. **PASS. Typed ERASE of a pipe, then U (regression for the copy-erase fixes, plain pipe only).** Selected pipe 109E23, typed `_.ERASE`: objects went 1054 to 1049 (the pipe and four of its labels). No CE line, no window. `U` (echo "ERASE") brought back all five: 1054. **What this does not prove:** the hunt's actual case (ERASE of a COPIED half of a rising main), which needs COPY.
5. **UNPROVEN. BUG-659 (Hunt B1): a pipe drawn from its low end is not turned round by a re-link.** CDSYNC is the typed route that runs the re-link (it calls `UpdatePipeEndpointsFromProjectData`). After it, no FROM cell changed anywhere in the schedule. But I looked at where each main-line pipe starts (109E23, 109835, 10A98D, 10A9C9, 1135E9): every one starts at its upstream pit, so none is drawn from the low end. The fixture has no case for the bug, so "nothing turned round" proves nothing here.
6. **BLOCKED. The cascade fixes (BUG-652, 654, 655), the brief's "10.00 to 10.20 gives 10.15".** Typed `CDPROPAGATE`, anchor P7 (answered with `(handent "10A4BB")`), new level 17.85. The Cascade Preview window opened (title "Creative Engineering | Cascade Preview"), I read it and cancelled it (nothing written; command-line says "CDPROPAGATE cancelled."). It was an **upstream** cascade, "2 pipes, 3 pits": WT8 to P7 and WT7 to P7 each went from 18.40 / 18.15 to 18.60 / 18.35 (+0.20 at both ends), and the pit row said "P7 17.65 to 17.85, drop 0.50 preserved". That is the upstream path, which the hunt said was already right. The path the fix changed (downstream, which runs only from a pit with no pipe arriving) cannot be reached on this drawing: every pit with pipes has one arriving, and the one other anchor I tried (downpipe block 10A7D8) is not a CE pit ("No upstream OR downstream pipes from anchor - nothing to cascade."). Edit Pipe's Save is a window button: BLOCKED for Codex.
7. **BLOCKED. BUG-653 (blank level read as 0.00).** Needs a typed pipe with a blank level; CD opens the New Pipe window and the only way on is its "Continue placement" button, which the driver never presses.
8. **BLOCKED. BUG-675 (ROTATE a pit, then CD into its short side).** I read the source: the "Upsize / Continue / Cancel" question comes after the New Pipe window is accepted ("Continue placement"), so it cannot be reached.
9. **BLOCKED. The copy clean-up family (BUG-665, 666, 670, 671, 672, Hunt C2).** All need COPY of a pit or pipe. TYPED_FORMS has no complete COPY form, and the brief says no COPY through the driver otherwise.
10. **BLOCKED. Metre drawing (BUG-663, 695, 696).** Needs a downpipe placed 12.5 m along a pipe (a pick) or CDREPAIR (a window). I did not open a metre copy.
11. **Not tried, so nothing to say about them:** BUG-668 (callouts after MOVE or ROTATE of a whole run), 669, 660, 661 (needs a mouse pick), 662, 673 (internal, no drawing symptom), 674 to 683 and 687 to 694 (Edit Pit, CDEDIT, Pit Schedule or Edit Pipe window work). BUG-668 could be typed; I ran out of calls in session 1 and spent session 2 chasing the CDSYNC fault.

## C. Nothing blocks a quick edit, again on 3.0.53

Civil copy CLD71_B1, pit P3 (109D56) and pipe 109E23. I listed the windows (`ui windows`) before the first edit and after each edit: **the list never changed (AutoCAD's frame and the four docked palettes only); no CE window and no dialog opened at any step.**

1. **PASS. Typed MOVE of pit P3** (`_.MOVE 0,0 1000,0`, pick-first count 1). The pit moved from x 53777.7 to 54777.7, its cover text and the pipe end followed. CE printed its usual note "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is". No window. `U` (echo "MOVE"), 12 s, `REDO` ("MOVE", "Everything has been redone").
2. **PASS. Typed STRETCH of the pipe end** (`_.STRETCH`, `_C`, two corners around the pipe's first end, an empty line, base `0,0`, second `0,200`, each on its own line, after zooming to the area). The pipe's first vertex moved from y -25569.9 to -25369.9. Same CE note, no window. `U` (echo "STRETCH"), 12 s, `REDO` ("STRETCH", "Everything has been redone").
3. **PASS. Pit Schedule unchanged.** I read the Pit Schedule before any edit (baseline, 391 lines, 27 rows) and after the MOVE, STRETCH, U and REDO pairs: **0 differences, line for line.** What this does not prove: the schedule shows numbers, sizes and levels, not map positions, so it shows labels and levels did not drift or blank, not that every label sits where it should.

## D. REDO regression on 3.0.53

1. **PASS. Civil plain circle** (`_.CIRCLE 0,0 10`, `U`, 12 s, `REDO`): "Everything has been redone". Session 1, after the label-erase, MOVE and PITDELETE steps.
2. **PASS. Civil typed MOVE of pit P3 twice, `UNDO 2`, 12 s, `REDO`:** MOVEs `0,0 0,1000` then `0,0 0,-500`. `UNDO 2` printed "MOVE MOVE"; `REDO` printed "MOVE MOVE" and "Everything has been redone".
3. **PASS. Structural plain circle** on CLD71_S1, opened second with the Civil copy still open: `_.CIRCLE 0,20000 10`, `U` ("CIRCLE"), 12 s, `REDO`: "CIRCLE", "Everything has been redone".
4. **PASS. U and REDO after PITDELETE and after CDSYNC** (both "Everything has been redone"; the CDSYNC pair is the one that carried the BUG-698 damage, so REDO restored the damage faithfully).
5. No autosave fell inside a 12 s wait this run, so no pair was spoiled.

## E. CEHEALTH

1. **STILL SHOWN (known warning).** "[OK] CE Civil Suite v3.0.53", "[OK] CE Structural Suite v1.0.118", "[OK] CE Manager v1.1.53", "[OK] CE Civil and CE Manager are a matching pair.", **"[WARN] CE_SUITE_MANAGER is installed in two places, so AutoCAD may load both: C:\ProgramData\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle and C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle. Remove one.**", "[OK] The office IT folder ... can be reached.", "1 issue(s) found". Same as run 24: the machine, not the build.

## F. My mistakes and side effects (plainly)

1. **A python command on stdin hung my shell for about two minutes** (the driver rules say no python on stdin). It had nothing to do with AutoCAD; I stopped it. Cost: two minutes.
2. **One LISP helper was over the 500-character limit and was rejected** (two calls wasted); I split it.
3. **My first two STRETCH attempts did nothing** (cost 4 calls). The first used spaces between answers, the second selected 0 objects because the pipe end was outside the screen. A zoom first fixed it. The two stray answers ("0,0", "0,200") landed at Command: as "Unknown command", harmless.
4. **My first U after a Pit Schedule visit undid the visit, not the CDSYNC** (known behaviour: each Pit Schedule visit leaves its own Undo step). I redid it with UNDO 2. Cost: about 4 calls.
5. **The driver raised its prompt alarm after both CDSYNC calls although CDSYNC had finished** (completed true, CMDACTIVE 0, the "complete" line printed). One `wait` cleared it. Same false alarm as CDFW in runs 22 and 23.
6. **Files left on disk.** CE wrote its usual pre-upgrade backups next to the test copies when each Civil copy opened: `C:\ce_rc_drv\CLD70_B1_PRE_C7_20261018_020947.dwg` and one for CLD71_B1. Harmless. AutoCAD also made an autosave in the temp folder during session 1. The three test polylines (11C558, 11C55A, 11C55B) and the circles exist only in unsaved copies.
7. **I did not re-hash Tim's real settings files this run.** Nothing here writes them (no Settings window, no switch turned on), but I did not prove it as run 24 did.

## G. Notes for the tooling worker

1. **The false prompt alarm after CDSYNC** (F5). It sets `alarm` and `warning: prompt may be left pending` when the command has completed.
2. **A typed STRETCH needs each answer on its own line** and the area zoomed first; the README could say so. It also needs the empty line in the middle (a trailing one would be trimmed).
3. **`ui tree` of the Cascade Preview window lists grid rows by their internal names** ("CE_CVL_SUITE.ViewModels.PropagationPipeRow", "PropagationPitRow") and the column-index leak "Item: ...Column Display Index...". The plain-English scan would flag these; I did not run `ui scan`.
4. **`getvar` with `-Text` printed only the variable name through my filter**; I did not look at its raw output, so I do not know whether it prints the value on a second line.

## H. What Tim needs to do

Nothing in AutoCAD for this run. For the desk: two new bugs are filed OPEN in `C:\CE_PLAN\BUG_CARPARK.md`: **BUG-697** (CD Existing line refuses every plain polyline) and **BUG-698** (CDSYNC sets every pipe size to 100). Both need a decision on priority; BUG-698 matters most if a drafter can reach CDSYNC (it is a typed command; I did not check whether it is hidden from the ribbon). For Codex: the Edit Pipe Save cascade, the CD pit-fit question, the blank-level pipe, the COPY and grip family, and the metre-drawing items (section B items 6 to 10).

**Built, tested, installed, accepted:** these are installed builds driven in real AutoCAD on copies by a robot, not Tim-accepted. PASS here means a bounded typed check passed, not whole-workflow acceptance.

**What I did NOT test:** the Edit Pipe window route, anything that needs Continue placement or Save, COPY, grips, ROTATE and SCALE copies, the metre drawings, callouts after a run is moved (BUG-668), the witness logs, the Structural system variables after the run, and the CE log for erased-object lines.

AUTOCAD CLOSED
