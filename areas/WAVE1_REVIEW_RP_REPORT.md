# Wave 1 paper review, job RP: cases by writers P1, P2, P3 (Sat 31 Oct 2026)

Reviewer: Opus paper reviewer, job letter RP, brief `C:\CE_PLAN\desk_jobs\WAVE1_REVIEW_BRIEF.txt`. Code read at commit `3fbb9da5` (Civil 3.0.88). Nothing run in AutoCAD, no driver, no case_runner run (only `validate` and `check_ids`). No case, setup, spec, driver or settings file edited. No slip written. Nothing committed.

## ANSWER FIRST

1. **Counts (12 cases, each with its twin, 24 files):** READY TO RUN 11. FIX FIRST 1 (W210). NOT RUNNABLE 0. NEEDS A CODEX LOOK 0 as a verdict (Codex look items listed per case).
2. **The one fix, W210 and its twin:** Edit Pit is opened with typed PITEDIT after picking the pit. PITEDIT ignores a picked pit, so AutoCAD stops at "Select pit block to edit:" and the case stalls with the prompt left open.
3. **Exact fix:** `W210_copy_pit_onto_erased_junction.case.txt` line 63 and `W210_BROKEN.case.txt` line 60, replace `type "PITEDIT" -Force -ExpectWindow "Edit Pit" -TimeoutSec 120 -> $pe` with `type "CDEDIT" -Force -ExpectWindow "Edit Pit" -TimeoutSec 120 -> $pe`.
4. **Why CDEDIT:** CDEDIT takes a picked pit and opens the pit editor directly. The robot has already seen this window ("Creative Engineering | Edit Pit", with a "P11 → P12 · LEAVING" row) in `ui_map\w1_edit_selected_pit.txt`.
5. **Riskiest 1, W210 (even after the fix):** the Edit Pit route has never run in a case. The "188 connections: 183 Connected" count after erasing P8 was last seen on 3.0.83, not 3.0.88.
6. **Riskiest 2, W244:** its deciding check is an absence (no uphill record line). CDSYNC never touches a CE pipe object (it handles only plain polylines), so the CDSYNC part proves nothing. If CE does not rewrite the record after a MOVE, the case passes with or without the fix.
7. **Riskiest 3, W667:** PITDELETE picks the pit by a typed point on its outer wall (150000,-79675), worked out from the code and never driven. If the pick misses, the fixed build FAILS on a check (it does not stall: an Esc follows).
8. **Next most risky, W234:** four hand-numbered pits, a flat pipe and the "Flow: P93 → P94" header have never run together. The arithmetic and the words all check out.
9. **Offline checks:** validate gave 49 files, 0 invalid. check_ids says "every control id is known". No ent-read on a handle that may be missing, except W665 (lines 38 and 52), which stalls only on a build without the fix.
10. **Arithmetic re-done:** every level, length, position and count in the 12 cases matches my own working (details below). No 20 m level map is used on a pipe of a different length.
11. **Leaves no window open:** every case closes what it opens (Continue placement plus three Esc for New Pit, Start Pipe plus Esc for New Pipe, Cancel for Edit Pipe and Edit Pit). The one exception is W210 before the fix.
12. **Same fault elsewhere (not mine, not edited):** `drafts_next40_a_30oct\N46_old_names_still_work.case.txt` line 32 types PITEDIT after a pick. It will stall the same way; its writer should look.

---

## DETAIL (per case; main-file line numbers)

### Writer P1

1. **W248 + W248_BROKEN: READY TO RUN.**
   1. **Prompts:** CDPERIMETER is R37b's string word for word, followed by esc-prompt (line 25 on). ERASE, OOPS and U open nothing.
   2. **Words:** line 72 `[BUG-258] OOPS: PD text {tag} brought back with drain {drain}` and line 73 `... {n} PD text(s) brought back with their drains` match `LinkService.SurfaceDrainTags.cs` 329 and 345 (both Info). The handle and position checks are sound because line 326 `tag.Erase(false)` brings back the same object. The forbidden words are in `SurfaceDrainTagPolicy.cs` 76-80. OOPS only: line 91.
   3. **Numbers:** a 2.000 m drain falling 0.100 is 1 in 20. It is a perimeter drain, so no Grade mismatch window. The PD text position is compared with itself, not with a fixed value.
   4. **Proves the bug:** yes. On the old build the PD text stays erased, so the counts and both log lines fail. The twin types REGEN in place of OOPS (line 43) and fails on checks; no step reads a missing handle.
   5. **Derived:** that U echoes OOPS and takes both away (commit 4ce19d82). Codex look: the text's style and height after OOPS.
2. **W210 + W210_BROKEN: FIX FIRST** (line 63 / twin line 60, see answer 3).
   1. **Why it stalls:** `Commands/PitEditCommand.cs` 41 registers PITEDIT as `CommandFlags.Modal` only, with no UsePickSet. Without that flag AutoCAD clears the picked set as the command starts, so `SelectImplied` (line 73) finds nothing. The step then waits at "Select pit block to edit:" (line 95) and the expected window never appears. `HubCommands.cs` 75 gives CDEDIT UsePickSet, and lines 154-155 hand the pit to `PitEditCommand.EditPit()`.
   2. **Prompts after the fix:** New Pit (lines 28-35) is closed by Continue placement plus three Esc. Each CDCHECK has an Esc after it. The COPY string ends idle (R34 chain). Edit Pit is closed by "Cancel without saving" (C2.CancelCommand, `w1_edit_selected_pit.txt` line 83).
   3. **Words:** the erase line comes from `PitEraseFreeEndsMessagePolicy.cs` and was seen in R19v87. The copy line is `CopiedLevelsRule.cs` 28. LEAVING is `PitConnectedLevelsViewModel.cs` 323.
   4. **Fix timing:** `LinkService.Utilities.cs` 446-466 queues the copied pit into the same command's pit relink. That is why CDCHECK straight after the COPY can read 189 / 184.
   5. **Numbers:** 189 / 184 was seen on 3.0.88. 188 / 183 with P8 erased was seen on 3.0.80 and 3.0.83 (x83a3, x83b3). The lone pit adds no connection. Twin: a copy at 150000,-79000 has its opening edge at y -79225 and its wall at -79325. The pipe end at 150225,-80000 is 675 mm past the wall, beyond the 100 mm catch (`PitOutline.cs` 163). So the twin fails on y, CDCHECK and LEAVING.
3. **W234 + W234_BROKEN: READY TO RUN.**
   1. **Prompts:** four New Pit windows, each closed by Continue placement plus three Esc. New Pipe is closed by Start Pipe plus Esc. Two Edit Pipe windows are closed by Cancel. ZOOM and STRETCH (line 86) end by themselves.
   2. **No Grade mismatch window:** with a pit at the first point, CE picks Set my own 1 in 100. A flat pipe still never opens the window, because `CdCommand.Grade.cs` 249 has `if (fall <= 1e-6) return false;`. No other flat-pipe question exists in CdCommand or CdViewModel.
   3. **Words:** `ProjectDataService.Mutations.cs` 1587 is Info, and the pipe Id is its handle (`CdCommand.Schedule.cs` 75-80). The "Flow: P8 → P11" header is in `ui_map\w2_edit_pipe.txt` line 43. The dump becomes JSON text before the `matches` check, and `Flow: P93 .{1,8}P94` fits " → ".
   4. **Arithmetic:** the ends sit at 150225 and 159775 (9.550 m). After the MOVE they are at y -72000, on the P93 and P94 walls. The STRETCH window 159600..159950 holds the east end but not P94's insertion at 160000. The new length is √(9.550² + 6.000²) = 11.278 m, still flat, so `count $il18 = 2` holds.
   5. **Proves the bug:** yes, by REGRESSION_LOG BUG-234 item 2 (keep a stored pit's side, else the side proven from the released pits). Twin: the pits are 1 m south, so the end at y -72000 is 675 mm past the walls (wall at -72675) and nothing links. It fails on the checks at lines 104-109; no stall.
   6. **Codex look:** a real grip drag in place of the STRETCH, and the Pit Schedule cells.
4. **W244 + W244_BROKEN: READY TO RUN (weak proof).**
   1. **Prompts:** same as R32v87, which passed twice on 3.0.88 (New Pipe; Edit Pipe Save, then sleep and Esc; Edit Pipe Cancel).
   2. **Numbers:** 20.000 m falling 0.200 is exactly 1 in 100. No pit, so Standard grade and no window. After the STRETCH the pipe is 21.000 m, and 18.000 - 0.210 = 17.790 (recorded only). There is exactly one IL 18.000.
   3. **Words:** `Mutations.cs` 1458 Info `Pipe inverts updated: {Id} from={FromInvert} ...`. Edit Pipe's own Save does not go through `UpdatePipeInvertsByHandle`; only relink and repair paths do (the caller list I checked). So `from=17.` should appear only from the old fault.
   4. **Weak spots:** `LinkCommands.cs` 147-183 (line 173 `ent is Polyline`): CDSYNC registers pits and plain polylines only, never a CE pipe object, so the CDSYNC branch (line 70) proves nothing. The arrow checks are sanity checks only. The twin flips line 100 to `has`, so it fails on that check alone.
5. **Faults noticed, not edited:** N46 (answer 12).

### Writer P2

6. **W267 + W267_BROKEN: READY TO RUN.** No windows; each CDCHECK has an Esc. `OopsBackSummary.cs` 115-143 and 196-200 build exactly `[CE] OOPS brought back pit P3 with its 2 labels, and re-linked it.` (one part with " with ", so the comma; one object, so "it"). 1040 - 3 = 1037, then + 3 = 1040; the old build gives 1038. The twin expects 1038, a one-check fail. Derived: "2 labels" depends on CE reading both owner notes.
7. **W285 + W285_BROKEN: READY TO RUN.** No windows. The 6 new objects and their layers were measured. 1040 - 5 = 1035, then back to 1040; the old build gives 1036. The pipe name "from P8" comes from `OopsBackSummary.cs` 150-158, and the regex allows for a different item list. After P8 moves 0,-1000, the low corner is about -81000 - 112.4 = -81112.4, below -80500 (the old build stays at -80112.5). The twin expects 1036.
8. **W325 + W325_BROKEN: READY TO RUN.** The N80 route (pitLabelOnEsc ON, three Esc) passed on 3.0.87. `PitCommand.cs` 500 gives the exact label line. The pipe is 19.775 m falling 0.200, which is 1 in 98.9: 1.1 per cent off 1 in 100, under 10 per cent, so no window. Two parts give "..., and pipe from P8 with its ..., and re-linked them." (`OopsBackSummary.cs` 136-142); the greedy `[^.]+` backtracks correctly. Picking two handles in one pick-first has run before (`"109D56,{$labh}"`). The twin expects 0 OOPS lines.
9. **W667 + W667_BROKEN: READY TO RUN (pick risk).**
   1. **Prompts:** LINE ends on the automatic Enter, so the U is typed at an idle Command line. PITDELETE (line 48) is followed by esc-prompt, so a missed pick never stalls.
   2. **Pick point:** `PitOutline.cs` 143-144 says the opening is 450 square and the wall is drawn 100 mm outside it. So the outer north line is at -80000 + 225 + 100 = -79675, with ZOOM C 2000 first. Fallback: the opening line at -79775.
   3. **Words:** `LinkCommands.cs` 109 and 114. `[ERR]` never showed in 2,263 earlier case logs, so line 63 is a clean check. The twin expects the old error line, a one-check fail.

### Writer P3

10. **W665 + W665_BROKEN: READY TO RUN.** It uses the ROTATE Copy chain of R34so (passed twice): wait, sleep 8, then Esc to clear the repeated command. `RotateScaleCopyRule.cs` 39-47 is driven by linking.rotateScaleCopyLikeCopy (`LinkService.CloneRegeneration.cs` 280-284), so pinning the older tick OFF is right.
    1. **Positions:** ROTATE 90 about (58777.7,-25569.9) sends (-5000, 0) to (0, -5000), so the copy lands at 58777.7,-30569.9 (bB5 read 58777.68,-30569.87). SCALE 1.5 about (53777.7,-15569.9) sends -10000 to -15000, so the copy lands at 53777.7,-30569.9. The two copies are 5 m apart.
    2. **Regex:** `P(?!3.,)(?!8.,)[0-9]+` correctly rejects P3 and P8.
    3. **Twin:** expects the ROTATE label to read P3, a one-check fail.
    4. **On an unfixed build:** `ent-read {$hro}` (line 38) would stall rather than fail. That is acceptable: it cannot pass.
11. **W665p + W665p_BROKEN: READY TO RUN.** A half turn about (160000,-72500) maps (x, y) to (320000 - x, -145000 - y). So 150225,-80000 goes to 169775,-65000 and 170000,-80000 goes to 150000,-65000, inside the empty ground. The copy brings no pieces with it, so all four are missing (`CopyCleanUpCompletenessRule.cs` 37-38) and all four are drawn. The twin turns the switch OFF: nothing is reconciled, the counts fail, and there is no ent-read.
12. **W671 + W671_BROKEN: READY TO RUN.** The COPY string ends idle. The copy runs 150225,-65000 to 170000,-65000. With the switch ON, a copied label of known role leaves the first level, last level and arrow missing (lines 39-48). With it OFF (the twin), nothing is missing and `CloneRegeneration.cs` 111-117 returns early, so the IL and arrow counts fail.
13. **W672 + W672_BROKEN: READY TO RUN.**
    1. **Layer names with spaces:** R33 shows that `-LAYER _LOCK STORMWATER PIT LABEL` is taken as one name.
    2. **Words:** both lines match `CloneCleanupMessages.cs` 159-171 word for word (the "label" or "cover text" choice comes from `RotateScaleCopyRule.cs` 53-58).
    3. **Copy rule:** `CloneRegeneration.cs` 296-316 names the kind, skips the locked piece and carries on. U brings the count back to the start count each time.
    4. **Twin:** with the switch OFF, copying stops at the first protected piece and the line falls back to "label or cover text", so the checks fail. There is no ent-read.
