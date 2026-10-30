# Corrected K-series and P02 robot cases (Fri 30 Oct 2026)

Written Fri 30 Oct 2026, 12:20 to about 12:35 Melbourne (PC clock read with `date`), by the Team Opus job CE_ACAD / robot / draft / 38. Drafting only: no AutoCAD, no runner run, no driver call, no build. The only runner call was the offline `validate`, after reading its code.

## ANSWER FIRST

### FOR TIM

1. **What this is:** the robot's eight "carpark" tests (K01 to K08) all stopped before their first real check yesterday. Each fault was in the test, not in CE. I have written corrected copies; nothing has been run yet.
2. **K01, a typed pipe level is drawn exactly (BUG-025).** On a job, you type IL 1.10 at the downstream end, ask CE to work out the other end, and the plan text says IL 1.11. **Changed:** the short test pipe is now 1.9 m instead of 1 m. At 1 m CE rightly asked its "Grade mismatch" question (the 20 mm minimum drop made it 1 in 50), which stopped the robot. At 1.9 m it is 1 in 95, close enough that CE does not ask.
3. **K02, no "MIN." on a pipe label with one level typed (BUG-027).** On a job, you type only the upstream level and the label reads "225 DIA. uPVC PIPE AT 1 IN 100 MIN." against your May ruling. **Changed:** the robot now ticks the "Set second end level" box by its real name. I expect this one to go red for a real reason: the code still adds "MIN.".
4. **K03, IL text set to Above stays above a nearly level pipe (BUG-021).** On a job, a pipe falling slightly south-east had its "Above" IL text land under the line. **Changed:** the same tick box name.
5. **K04, a pit placed after CD with a turned UCS comes in square (BUG-035).** On a job, with the UCS rotated 30 degrees, a pit placed right after a pipe came in turned 30 degrees. **Changed:** the tick box name, plus a third Esc after PIT (label point, cover text, next pit).
6. **K05, "Set my own" grade on a four-point pipe route (BUG-041).** On a job, CD stopped taking points after two when you chose your own grade. **Changed:** the same tick box name.
7. **K06, Edit Pipe moves an IL text from Above to Below (BUG-078).** On a job, switching an IL text to Below on a drawn 8 m pipe did nothing. **Changed:** the same tick box name.
8. **K07, the green "Proposed" strip shows levels to 2 decimals (BUG-070).** On a job, starting a pipe on a pit shows "US 18.500 / DS 18.400" instead of 18.50 / 18.40. **Changed:** three Esc presses after PIT instead of two, and New Pipe is closed with its real button "Cancel without saving".
9. **K08, "Set my own" grade survives switching pipe type (BUG-187).** On a job, you set 1 in 100, click Existing then back to Stormwater, and the grade quietly falls back to Standard. **Changed:** the button is now "Cancel without saving" (there is no plain "Cancel").
10. **P02, moving a pasted downpipe leaves the original's DP label alone (BUG-1140).** On a job, you copy and paste a downpipe, move the copy, and the original's label jumps with it. **Changed:** one added check that the pasted copy really moved 3 m. Without it, a move that did nothing would still pass.
11. **Your part:** nothing now. The robot runs these in a free window (2:00 to 3:00 pm or after 5:30 pm). Your AutoCAD was open when I finished (started 12:23 from your desktop); I did not touch it.

---

## What was done

1. **Folder:** `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_carpark_30oct\`, 17 files. These are the 15 K files from `drafts_carpark_29oct` and the two P02 files from `drafts_pilot_29oct`, each corrected. The originals were not edited; their SHA-256 still match the triage report (K01 `6F52143CEBB9`, K02 `2069DBE0F2F2`, P02 `0F5D48A216B1` and the rest).
2. **Every corrected file** starts with one comment line, "CORRECTED COPY (CE_ACAD / robot / draft / 38 ...)", saying what changed and why. Everything below it is the 29 Oct text with only the listed edits.
3. **Ids and file names unchanged, no "b" suffix.** No id had to differ: every ledger row for K02 to K06 and P02 carries its case SHA-256, and the runner's gate (`case_runner.ps1` lines 266 to 270) counts passes and fails only for the same hash. No K twin and no P02 twin has a ledger row, so no old twin red can be counted for the new texts.
4. **The edits, file by file:**
   1. **K01 and K01_BROKEN:** pipe B's end `151000,-100000` became `151900,-100000` (the typed CD point and the IL text search); the tick box name in the reset pipe. K01 also has its header numbers and EXPECTED text updated to 1.9 m.
   2. **K02:** the tick box name, twice (off for the test pipe, on for the reset pipe). K02 has no twin, by design: its red is the real "MIN." fault.
   3. **K03, K05, K06 and their twins:** the tick box name, once each.
   4. **K04 and K04_BROKEN:** the tick box name, and `esc-prompt -> $pit_e3` after `$pit_e2`.
   5. **K07 and K07_BROKEN:** `esc-prompt -> $pit_e3` after `$pit_e2`; `ui-press "New Pipe" "Cancel without saving"`.
   6. **K08 and K08_BROKEN:** `ui-press "New Pipe" "Cancel without saving"`.
   7. **P02 and P02_BROKEN:** `field $dpB x -> $bx0` and `field $dpB y -> $by0` after the copy's handle; `select $n3 "handle~^{$hB}$" -> $dpB1` and `dist $dpB1 "{$bx0},{$by0}" -> $db1` after the original's distance; in ASSERT, `count $dpB1 = 1` and `number $db1 = 3000 +- 1` before `$d1 < 1`. Each twin still fails only on the check it was built to fail.
5. **Spec:** `C:\ce-fx\retest\spec_carpark_30oct.txt` (SHA-256 starts `BEE650E66468`). Seven lines, tag|folder|only, the only column holding exact file basenames (no `.case.txt`):
   1. **aK1:** K01, K01_BROKEN, K02, K03, K03_BROKEN.
   2. **aK2:** K04, K04_BROKEN, K05, K05_BROKEN, K06.
   3. **aK3:** K06_BROKEN, K07, K07_BROKEN, K08, K08_BROKEN.
   4. **aK4:** P02.
   5. **aK5:** P02_BROKEN alone: it is the only case with SETTING lines (the two `linking.` switches off).
   6. **bK1:** K01, K02, K03, K04, K05.
   7. **bK2:** K06, K07, K08, P02.
6. **Spec checked:** a read-only script (`C:\ce-fx\draft38\check_spec.ps1`) applied the runner's own -Only rule (`case_runner.ps1` line 425, copied) to the folder. Every line matched exactly the files it names. Each plain case appears once on an a line and once on a b line; each twin once, on an a line. Each pack holds one SETTING group.

## Where the facts came from

1. **The tick box name:** `PipeOnePageLayout.ReplaceToggleWithTick` on `origin/claude/rel-20261029a` = `5888ee757244` (Civil 3.0.86), lines 84 and 271 to 284. It hides the old toggle (the one with id `C2.SecondInvertEnabled`) and adds a tick box with no id, named "Set second end level". The robot's own screen map shows the same name (`ui_map\w2_edit_pipe.txt` line 91; `UI_MAP_2026-10-03.md` line 52). The driver finds a control by exact name when no id matches, and sets a tick box on or off (`acad_driver_witness_v2.ps1` Invoke-V2Set, lines 2640 to 2665).
2. **A claim in my brief that was wrong (RULES 6.2):** the brief said R32 and N23 already tick this box. They do not. Both only type the two levels and rely on the box being ticked already. No case in `cases\` ticks it by any name.
3. **The 1.9 m pipe:** `CdCommand.Grade.cs` lines 233 to 260 ask the Grade mismatch question only when the true grade is more than 10 % off the typed one. With 1.9 m and the 20 mm minimum drop, the true grade is 1.9 / 0.02 = 1 in 95, 5 % off. At 1 m it was 1 in 50, 50 % off.
4. **The third Esc:** accepted case N23 places a pit with three `esc-prompt` steps; K07's run showed "Pit placed. Pick the next pit, or press Esc to stop." after two.
5. **"Cancel without saving":** the New Pipe press list (`acad_driver_v3.allowlist.json` line 23) and the screen map (`ui_map\w2_edit_pipe.txt` line 54).
6. **Validate is offline:** `case_runner.ps1` validate (lines 422 to 425) only reads and checks files. The driver library it loads with `-Library` only defines functions and loads Windows types (`acad_driver_v3.ps1` line 1154 runs nothing in that mode). Result: "17 file(s) checked, 0 invalid".

## What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** No corrected case has been through the robot, so none is "tested".
2. **The tick box by name** has never been pressed by the robot. The driver code supports it, but the first run is the proof.
3. **The other New Pipe fields:** K01's runs got past `C2.CreatePipeText`, `C2.IsGradeCustom`, `C2.CustomGrade`, the work-out toggles and `C2.KnownInvert`, so those names work. `C2.FirstInvertIsAbove` and `C2.SecondInvertIsAbove` (K03, K06) are on the 3 Oct screen map only, not yet seen in a run on 3.0.86.
4. **Your Grade mismatch tolerance:** I did not read your own setting. The 1.9 m figure assumes the shipped 10 %; if you have set 5 % or less, K01 would stop at the question again.
5. **K01's old fault (1.11):** the fix has no on/off switch, so I cannot show the old build would draw 1.11 on a 1.9 m pipe. K01_BROKEN proves only that the checks read the drawn text.
6. **K02's real fault** is from the code, not a drawn label.
7. **K07 and K08 after "Cancel without saving":** the `esc-prompt` that follows was kept from the 29 Oct text; whether CD is still asking anything then is not known.
8. **Remembered New Pipe values:** no K case has yet reached its reset pipe. If a run stops early, the remembered values may need putting back by hand, as each K header says.

## Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_carpark_30oct\` (17 case files, new folder).
2. `C:\ce-fx\retest\spec_carpark_30oct.txt`.
3. Scratch: `C:\ce-fx\draft38\fix_cases.ps1` (the edits, each with an exact-count check) and `check_spec.ps1`.
4. This report.

## Summary

All eight K cases and P02 are corrected as copies in `drafts_carpark_30oct`: the real tick box name, a 1.9 m pipe for K01, a third Esc for K04 and K07, "Cancel without saving" for K07 and K08, and a "copy really moved" check for P02. All 17 pass offline validate, and the spec resolves exactly. Nothing has been run in AutoCAD.
