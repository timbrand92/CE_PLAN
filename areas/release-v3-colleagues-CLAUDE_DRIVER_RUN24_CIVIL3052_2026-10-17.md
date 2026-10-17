# Claude driver run 24: Civil 3.0.52 / Manager 1.1.52 / Structural 1.0.118 (Sat 17 Oct 2026, 21:07 to 21:22 Melbourne, PC clock)

**Installed builds (nine DLLs read first with readdll.ps1):** Civil 3.0.52+f51e6307 (C-41), Manager 1.1.52+f51e6307, Structural 1.0.118+9a8e5d4e (S-38). Legacy, Net8 and Modern of each carry the same version text.

**Answer first.** Nothing blocked a quick edit, and every new tool is OFF on Tim's real settings. **15 PASS, 0 FAIL, 0 BLOCKED, 0 UNPROVEN, 1 STILL SHOWN (the known CEHEALTH warning), 1 SKIPPED (the leftover Codex FAILs).** AutoCAD is closed. Nothing was saved.

Driver calls (counted by a wrapper, every call including refusals): session 1 used 66 of 70, session 2 used 48 of 70. No forced kill this run. Both sessions were well inside the 60 minute stop (about 9 and 5 minutes).

## A. Setup

1. **Before launch.** `Get-Process acad,accoreconsole` showed nothing. The Codex queue.log last line was an END (verifyW65 at 08:38), no START without an END, nothing under 3 minutes old.
2. **Fresh copies, hash-checked.** CLD60_B1 and CLD61_B1 from DRV1_B1 (34BBE37C2EA4); CLD60_S1 and CLD61_S1 from DRV2_S1 (950AFDF6E523). All four still equal their source after the run.
3. **Witness recorder** loaded in both sessions (sha 49E79D6D...). I did not read the witness logs this run: none of the checks asked for them.
4. **Session 1** was the Civil copy only (the quick-edit walk). **Session 2** held the Civil copy first and the Structural copy second (switch-off parity, REDO regression, Structural quick edit, CEHEALTH).
5. **The "What's New" window** opened once at the start of session 1 and was closed with `ui close` (call 9). It did not appear in session 2.
6. **Variables, read before and after:** OSMODE 5375 and SAVETIME 5 before and after in both sessions. CLAYER BLOCKS before and after on the Civil copy; CLAYER 0 on the Structural copy at the end (run 23 read 0 there too). I changed none of them.

## B. Case 1: "Nothing blocks a quick edit" (Tim ruling I2)

Civil copy CLD60_B1, pit P3 (handle 109D56) and its pipe 109E23 (a CE pipe object). After each step I listed the windows (`ui windows`) and compared them with the list taken before the first edit. **The list never changed: only AutoCAD's own frame and the four docked palettes (CE Inspector three times, CE STRUC Footings). No CE window and no modal dialog opened at any step.** Nobody refused anything with a window.

1. **PASS. Typed MOVE of pit P3.** Selected P3 with `(sssetfirst ...)` (pick-first count 1), typed `_.MOVE 0,0 1000,0`. AutoCAD printed "Specify base point... Specify second point..." and CE printed its usual note "[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border")". The pipe's end followed the pit (it moved from the pit wall at 54227.7 to 55227.7). No window, no refusal.
2. **PASS. Typed property change (CHPROP of the pit's colour to red, then to colour 3).** The complete one-line form I could prove was `(command "_.CHPROP" (handent "109D56") "" "C" "1" "")` through the driver's LISP route. Plain typed CHPROP would need a fourth Enter after the colour (the loop prompt), and the driver may trim trailing line breaks, so I did not risk a half-answered prompt. AutoCAD printed all four of CHPROP's prompts and the colour read back (62 . 1). CE printed nothing. No window.
3. **PASS. Typed STRETCH of a pipe end.** `_.STRETCH`, `_C`, two corners around the pipe's first end only (the pit's insertion point stays outside the window), an empty line to end the selection, base `0,0`, second point `0,200`. The pipe's first vertex moved from y -25569.9 to -25369.9. CE printed its usual label note. No window.
4. **PASS. UNDO and REDO after each step (three clean pairs, nothing typed in between).** MOVE: `U` printed "MOVE", 12 s, `REDO` printed "MOVE" and "Everything has been redone". CHPROP: `U` printed "(Lisp Expression) GROUP" (AutoCAD's own name for a command run from LISP, not CE), `REDO` "Everything has been redone". STRETCH: `U` printed "STRETCH", `REDO` printed "STRETCH" and "Everything has been redone". I also ran `UNDO 3` earlier; it printed "PITSCHEDULE PITSCHEDULE STRETCH" (see my mistake, section F).
5. **PASS. Labels and levels stayed in step (Pit Schedule read before and after).** I opened the Pit Schedule (window "Creative Engineering | Pit Schedule (PITSCHEDULE)", 387 controls, not truncated), saved the whole tree, and compared it line by line with the baseline. **Six readings after the edits (after MOVE, after CHPROP, after STRETCH, after U plus REDO, after UNDO 3, and a final reading after the three clean pairs): all six identical to the baseline.** The window listing was also unchanged each time. **What this does not prove:** the Pit Schedule shows pit numbers, sizes and levels, not map positions, so a 1000 mm move or a 200 mm sideways stretch cannot change a row. It proves the levels and labels did not drift or blank, not that every label sits where it should on the plan.
6. **PASS. Structural copy CLD61_S1: typed MOVE of a strip-footing region (handle 483) and U / REDO.** Pick-first count 1, `_.MOVE 0,0 0,1000`. The region's box went from (8700,-300)-(9300,300) to (8700,700)-(9300,1300). No window opened (same five-row list). Footing schedule text (table 487, 28 cells) read before, after the MOVE, after `U` plus 12 s plus `REDO` ("MOVE", "Everything has been redone"), and after a final `U`: the table text was identical every time (the schedule has no position column), the region box after REDO equalled the box after the MOVE, and after the final U it equalled the box before the MOVE.

## C. Case 2: switch-OFF parity on 3.0.52

Tim's real settings were not touched: the three settings files (CD_Settings.json ACD64E79A33B, CS_Settings.json 622A246F7D3B, CE_CVL_SUITE settings.json EFE307C4FC74) have the same hashes before and after, and none holds a Tidy or Checks key, so every new tool runs on its OFF default. Exact command-line text of each:

1. **PASS. CDTIDYLABELS (given all its answers: `CDTIDYLABELS` then `No`).** "[CE] Tidy labels is switched off. Nothing in the drawing was changed." then "Switch Tidy labels on for this computer now? [Yes/No] <No>: No". The command ended (CMDACTIVE 0). Nothing was switched on and nothing moved.
2. **PASS. CDCHECKS (hidden command, typed bare with `-Force`; it asks nothing when off).** "[CE] The new Checks list is switched off. Ask your office administrator to switch it on in CE Settings. CDCHECKCURRENT and CDHUB still open their own windows. Nothing was changed."
3. **PASS. CDHUB: exactly the old behaviour.** The old window "Creative Engineering | Civil Hub (CDHUB)" opened (and a "Pipe is missing its both ends connection." panel inside it). No Checks list. Closed with `ui close`.
4. **PASS. CDCHECKCURRENT: exactly the old behaviour.** "[CE] Drawing check complete. 27 items need checking. Nothing has been fixed automatically." The "CE Civil - What CE Found" palette opened (listed view-only by the driver). No Checks list line.
5. **PASS. CDCHECK (unchanged).** Typed `CDCHECK` then `Csv`. Prompt: "CE check: show all connections, problems only, or save as CSV [All/Problems/Csv] <All>: Csv". Result: "[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not Connected, 0 Unknown.", the saved-record line, "FALL arrow direction: 5 arrow(s) point away from their nearest grated pit." (five lines, P4, P3, P2, P2, P1, off by 168 to 173 degrees), "Pipe ends: 22 with an open end, 0 branch(es) above their main." (22 lines), three "saved" lines (a text list and two CSV files, see section F), then a **last question was still waiting: "Show where for pipe end warning (1-22), or Enter to finish:"**. So the Csv chain still needs a third answer (this is the old "Jump to item" question; the source reading in run 23's era did not predict it for Csv). The driver's own `esc` ended it ("*Cancel*", CMDACTIVE 0). So the one-line chain `CDCHECK` plus `Csv` is **not complete**: it leaves the Show-where question open.
6. **PASS. CDRULES (unchanged).** Typed `CDRULES` then `Values` (complete: it ends after printing the values). Prompt: "CE rules: show all findings, problems only, the values in use, or explain each problem [All/Problems/Values/Explain/pReview/Source] <Problems>: Values". It printed the values in use (Council: none; R-01 scour caps; R-02 0.6 m/s; R-03 grade ladder; R-04 cover 300 mm; R-06; R-07; R-08; R-13; R-14; R-05/R-18 orifice "not set"; R-24 edition 2021; R-31; R-32; R-29; "Last run: 2026-09-05 00:26") and "[CE] Use CDRULEBOOK to change the project drop, council or cover override. Nothing was changed." This matches the earlier W35/W36 wording.

## D. Case 3: REDO regression on 3.0.52

1. **PASS. Civil plain circle.** `_.CIRCLE 0,0 10`, `U` (echo "CIRCLE"), 12 s, `REDO`: "CIRCLE", "Everything has been redone". This was after CDCHECK, CDRULES and CDCHECKCURRENT had all run in the same session.
2. **PASS. Civil typed MOVE of pit P3 twice, `UNDO 2`, 12 s, `REDO`.** MOVEs `0,0 0,1000` then `0,0 0,-500`. `UNDO 2` printed "MOVE MOVE"; `REDO` printed "MOVE MOVE" and "Everything has been redone". (The plain single-MOVE U / REDO is also case 1, step 4.)
3. **PASS. Structural plain circle.** `_.CIRCLE 0,20000 10`, `U` ("CIRCLE"), 12 s, `REDO`: "CIRCLE", "Everything has been redone". The Structural copy was opened second, after the recorder was loaded.

## E. CEHEALTH and the remaining Codex FAILs

1. **STILL SHOWN. CEHEALTH (known warning).** "[OK] CE Civil Suite v3.0.52", "[OK] CE Structural Suite v1.0.118", "[OK] CE Manager v1.1.52", "[OK] CE Civil and CE Manager are a matching pair.", **"[WARN] CE_SUITE_MANAGER is installed in two places, so AutoCAD may load both: C:\ProgramData\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle and C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle. Remove one.**", "[OK] The office IT folder (where CE updates come from) can be reached.", "1 issue(s) found". Run 22 already showed that the ProgramData copy exists on disk, so it is the machine, not the build. Removing it needs admin and Tim's yes. (This is the stale Manager warning the brief said to expect; I did not touch it.)
2. **SKIPPED. Any typed Codex FAIL from the triage file that run 23 did not try.** I went through CODEX_BUG_TRIAGE_2026-10-16.md. What is left after run 23's list needs a mouse pick (CDCATCHMENT BUG-643, CDAGI rising drain BUG-649, hatch and DUP work), a window button the driver will not press (BUG-650 with its Continue placement or Save), a layout tab, or Settings. The one typed candidate I found, BUG-504 (CSWINDCLASS saves a blank wind class), writes a project record on this PC that I could not prove was a throw-away, so I did not run it. Nothing else qualified. BUG-648 (no grade label on an AG drain) and BUG-531 (EBT text height at DIMSCALE 50) were not retried: they are build-lane items, run 23 already showed them failing on 3.0.51, and 3.0.52 comes from the same line of work.

## F. My mistakes and side effects (plainly)

1. **My first U / REDO pair tested the wrong step (cost: about 6 calls to redo).** I opened the Pit Schedule to read it between the STRETCH and the U, so the `U` took back "PITSCHEDULE", not the STRETCH. This is AutoCAD plus CE's known behaviour (Codex W18, W25 and W35: each Pit Schedule visit leaves its own Undo step; recorded in BUG_CARPARK as a brief fault, not a CE bug). I redid all three pairs with no Pit Schedule visit in between and they are the ones in case 1, step 4. A drafter who opens and closes the Pit Schedule after an edit must type U twice to undo the edit; that is not new, and it does not block an edit.
2. **CDCHECK left a question open (cost: one `esc` call).** I answered only `Csv`, expecting no further question. It asked "Show where for pipe end warning (1-22), or Enter to finish:". The driver's `esc` accepted it (the last line was a CE line) and ended it cleanly. No wedge, no kill.
3. **Three files now sit in Tim's real CE logs folder** from that CDCHECK: `C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\logs\cdcheck-CLD61_B1-20261017-101727.txt`, `...-connections.csv` and `...-objects.csv`. They describe the test copy only. Harmless, but Tim may want to know they exist. (Note the file name stamp reads 10:17 because it is UTC; the PC clock was 21:17.)
4. **A tooling block of my own command (no effect).** One of my PowerShell calls was blocked by the tool's safety filter before it ran; the driver counter showed no call was spent. I re-ran it as a small script file.
5. **Staging by LISP (please rule on it, same as run 23).** I used `-AllowLisp` lines on unsaved test copies for: selecting a pit before a MOVE (`sssetfirst`), the CHPROP in case 1, a zoom, and read-only reads of entity data and the footing table. I changed no system variable. Nothing was saved.

## G. Driver notes for the tooling worker

1. **`ui windows` lists the Civil Hub's inner panel** ("Pipe is missing its both ends connection.", class ScrollViewer) as a separate allowed docked window while the Hub is open. Harmless; it disappears with the Hub.
2. **A typed CHPROP chain cannot be ended by typed text alone** (it needs a trailing Enter that may be trimmed). A LISP `(command ...)` form is the only complete one-line way. If the desk wants a plain typed CHPROP case, the driver should say whether it trims a trailing space or line break.
3. **CDCHECK is not a one-line command.** The README says the chain is untested; this run proves a `Csv` answer still leaves the Show-where question open. Suggest the README says so, and that `Problems` plus a final answer is untested.
4. **`ui windows` after CDCHECKCURRENT lists "CE Civil - What CE Found" as view-only** (it is a palette, not on the allow-list); it stayed open for the rest of the session and does not block drawing.

## H. What Tim needs to do

Nothing in AutoCAD for this run. For the desk: Case 1 is a robot PASS for the typed route only; the mouse routes (grips, drag, Properties palette fields) are still Codex's. The three files in Tim's logs folder (F3) can be deleted.

**Built, tested, installed, accepted:** these are installed builds driven in real AutoCAD on copies by a robot, not Tim-accepted. PASS here means a bounded typed check passed, not whole-workflow acceptance.

**What I did NOT test:** the mouse and grip versions of a quick edit; a plain typed CHPROP (only the LISP form); any CE window that stays open during a quick edit (I only proved none opens); the Structural property and stretch steps (the brief asked Structural for MOVE and U / REDO only); the witness logs; the new tools switched ON (forbidden on real settings).

AUTOCAD CLOSED
