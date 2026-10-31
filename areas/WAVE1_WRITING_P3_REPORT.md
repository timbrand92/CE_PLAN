# Wave 1 case writing, job P3: COPY, ROTATE Copy, SCALE Copy of pits and pipes, locked layers (Sat 31 Oct 2026)

Writer: Opus case writer P3, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Bugs: BUG-665, BUG-666, BUG-671, BUG-672. Source: installed build Civil 3.0.88, commit `3fbb9da5` (read with `git show`, nothing built). Nothing was run except the offline validate and the control-id check. No existing case, setup, driver or settings file was edited. Nothing committed or pushed.

## ANSWER FIRST

1. **Answer:** 3 of my 4 bugs have robot cases: BUG-665, BUG-671 and BUG-672. That is 4 cases plus 4 "must fail" twins, all in `drafts_wave1_31oct`. BUG-666 has no case.
2. **Why BUG-666 has no case:** the robot cannot build a same-plan-break pipe or a split rising main. That needs a tick in the New Pipe window whose control name the robot has never seen. A grip copy needs a mouse drag. It goes to a probe or a Codex look (item 6 below).
3. **BUG-665, pits (W665):** ROTATE Copy and SCALE Copy of pit P3, each landing 5 m from any pit. Each copy must get its own number (the first reads P8), its own label and cover text. P3 must still read P3.
4. **BUG-665, pipes (W665p):** ROTATE Copy of a new 20 m pipe. CE must say "1 pipe copied and numbered as new." and draw the copy's own label, IL 18.000, IL 17.800 and flow arrow.
5. **BUG-671 (W671):** COPY a pipe with only its size label. CE must draw the copy's two IL texts and its arrow, and not a second label.
6. **BUG-672 (W672):** COPY P3 twice: once with the cover-text layer locked, once with the label layer locked. Each time the piece on the open layer must come across, and CE must name only the missing piece. One U takes each copy back.
7. **Twins:** W665p, W671 and W672 each turn their fix's switch OFF. W665's twin instead expects the copy to read P3. A switch-off twin there would stop at a step, not fail a check (item 3 of Detail).
8. **Checks:** validate printed "0 invalid" (11 files, mine plus other writers'). The id check printed "every control id is known". No "print", no street names, and every level matches the 18.000 / 17.800 pipe.
9. **Settings:** every case pins its switches with SETTING lines, so Tim's real settings file is put back by the guard.
10. **Already proven elsewhere (not repeated):** R33 (COPY with 25TEXT locked) and R33m (its wording) PASS on 3.0.88. R34sn PASSES on 3.0.88 with the older tick ON.
11. **Not proven by any case here:** grip Ctrl-drag copies, PITDELETE on a copy, the copy's schedule row, and how the copies look.
12. **Nobody has run these yet.** Each needs an Opus paper review, then a robot pair, then Codex.

---

## DETAIL

### 1. Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\W665_rotate_scale_copy_pit_own_number.case.txt` and `W665_BROKEN.case.txt`
2. `...\W665p_rotate_copy_pipe_own_compound.case.txt` and `W665p_BROKEN.case.txt`
3. `...\W671_copy_pipe_with_only_its_label.case.txt` and `W671_BROKEN.case.txt`
4. `...\W672_copy_pit_one_text_layer_locked.case.txt` and `W672_BROKEN.case.txt`
5. This report.

### 2. Facts that apply to all four cases

1. **Shipped switches at 3.0.88** (`Models\UserSettings.cs`): `linking.cleanUpGripRotateScaleCopies` default false (942-943); `linking.rotateScaleCopyLikeCopy` default true (953-954); `linking.pitCopyLineNamesOnlyWhatIsMissing` default true (961-962); `linking.copyCleanUpKeepsEveryPiece` default true (1225-1226). None is in Tim's file, so the guard adds the key and puts the file back by hash.
2. **Which commands make copies** (`Services\ExternalMutationCommandPolicy.cs` 111-114): COPY always; ROTATE and SCALE only when `rotateScaleCopyLikeCopy` is on (`Rules\RotateScaleCopyRule.cs` 27-30). Grips only with the older tick.
3. **The copy line** (`Rules\CopiedLevelsRule.cs` 23-29): "1 pit copied and numbered as new. Check levels: ..." or "1 pipe copied and numbered as new. Check levels: ...".
4. **Twins must not stop on a step.** The driver refuses `ent-read` with no handle (`acad_driver_v3.ps1` 1072), and the runner then skips every check (`case_runner.ps1` 156-158). `dist` also throws on an empty list (`case_runner_lib.ps1` 353-354). So no twin reads a handle of a piece that may be missing. Distances use `select ... "near=x,y,r"`, which never fails.
5. **Fixture facts used** (from earlier runs, not guessed): DRV1_B1 holds 1034 objects; pit P3 is block 109D56 at 53777.7,-25569.9; P3's label is 109E08 and reads P3 (R34a); the pit numbers are P1 to P7, P9, P10 and C1, so the first copy is P8 (R34so, R34sn, R33). The pipe cases use SETUP-R47v (new pit P8 at 150000,-80000 and a CD pipe to 170000,-80000, levels 18.000 and 17.800, PASS on 3.0.88).

### 3. BUG-665: W665 (pits) and W665_BROKEN

1. **In AutoCAD terms:** open the test drawing. Select pit P3. ROTATE, base point 58777.7,-25569.9, C (Copy), 90. Then select P3 again. SCALE, base point 53777.7,-15569.9, C, 1.5. At the end, two new pits must exist, each with its own number label and cover text, and P3's label must still read P3.
2. **Checks:** two "pit copied and numbered as new" lines. The ROTATE copy: one pit block within 1 mm of 58777.7,-30569.9, one PIT LABEL reading P8, one CL text. The SCALE copy: one pit block at 53777.7,-30569.9, one PIT LABEL reading neither P3 nor P8, one CL text. P3's label still reads P3 before and after. No CE window is left open, and the drawing file is unchanged.
3. **Arithmetic:** ROTATE 90 degrees anticlockwise about (58777.7,-25569.9). P3 sits at (-5000, 0) from the pivot, and that becomes (0, -5000), so the copy lands at 58777.7,-30569.9. The 3.0.86 run bB5 read 58777.68,-30569.87 on this exact route. SCALE 1.5 about B = (53777.7,-15569.9). P3 sits at (0, -10000) from B; times 1.5 that is (0, -15000), so the copy lands at 53777.7,-30569.9. B was chosen as 3 times P3 minus 2 times the target. The two copies are 5 m apart, and neither lands on a pit, so the BUG-1227 route is not touched.
4. **Code:** `RotateScaleCopyRule.cs` 37-47 (a turned copy gets its label and cover text); `LinkService.CloneRegeneration.cs` 280-284 (where that is used); `CopiedLevelsRule.cs` 28.
5. **Derived, not seen on a run:** that the SCALE copy reads P11 (only "not P3, not P8" is checked; P11 is recorded); that both copies come out right with the older tick OFF (R34so and R34sn ran with it ON).
6. **The twin breaks one thing:** it expects the ROTATE copy's label to read P3 (the "twin of the original" symptom). On a fixed build that check fails, and every other check passes. A switch-OFF twin was rejected because the copy would have no label and the `ent-read` step would be refused. The switch-OFF red is the existing control `cases\controls\C34_rotate_copy_switch_off.case.txt` (no ent-read; it fails on its checks). It could be re-run on 3.0.88.
7. **For a Codex look:** the scaled pit block is drawn 1.5 times bigger. Whether its label and cover text sit sensibly beside it is a look.

### 4. BUG-665: W665p (pipes) and W665p_BROKEN

1. **In AutoCAD terms:** after the setup's new pipe (P8 to a loose end, 18.000 to 17.800), select only that pipe. ROTATE, base point 160000,-72500, C, 180. The copy must be a pipe of its own: CE says so and draws its own label, two level texts and arrow.
2. **Checks:** "1 pipe copied and numbered as new." (once); one new CE pipe object; one label text containing " DIA. "; two IL texts: "IL 18.000" within 1 m of 169775,-65000 and "IL 17.800" within 1 m of 150000,-65000; one ARROW block. No CE window is left open, and the drawing file is unchanged.
3. **Arithmetic:** the pipe runs 150225,-80000 to 170000,-80000 (P8's 225 mm wall move; 19.775 m long; the fall of 0.200 m is 1 in 98.9, steeper than 1 in 100, so no Grade mismatch window). A half turn about (160000,-72500) sends (x,y) to (320000 - x, -145000 - y). The start goes to 169775,-65000 and the end to 150000,-65000. That is inside the empty ground 148000 to 172000 by -82000 to -58000, and 15 m from P8. The 1000 mm radius is R03's 800 mm plus the 225 mm wall move.
4. **Code:** `ExternalMutationCommandPolicy.cs` 111-114; `LinkService.Utilities.cs` 800-866 (`RemapClonePipe`: attachments not copied with the pipe are dropped, 846-860); `LinkService.CloneRegeneration.cs` 141-210 (label 145, first level 163, last level 177, arrow 200); `CopiedLevelsRule.cs` 23-29.
5. **Derived, not seen on a run:** the exact copy texts "IL 18.000" and "IL 17.800" (drawn from the copied record; the regex accepts 18.0 to 18.000), and that the arrow block name contains ARROW (as R32).
6. **The twin breaks one thing:** `linking.rotateScaleCopyLikeCopy false`. The copy keeps the original's identity, and no line, label, levels or arrow appear, so the line and count checks fail. No step depends on the missing pieces.
7. **For a Codex look, and not driven:** the BUG-665 text's "a later MOVE of the original's label is refused as conflicting"; the copy's Pipe Schedule row; SCALE Copy of a pipe (it changes the length and grade, so it was left out).

### 5. BUG-671: W671 and W671_BROKEN

1. **In AutoCAD terms:** after the setup's new pipe, select the pipe and ONLY its size label (what a crossing window that misses the level texts would catch). COPY from 0,0 to 0,15000. The copy must end up complete: its own IL 18.000 and IL 17.800 and flow arrow drawn by CE, and still only one label.
2. **Checks:** "1 pipe copied and numbered as new."; one new pipe object; exactly one " DIA. " label (no second one); two IL texts, IL 18.000 within 1 m of 150225,-65000 and IL 17.800 within 1 m of 170000,-65000; one ARROW block. No window is left open, and the file is unchanged.
3. **Arithmetic:** the copy is the original moved 15 m north: 150225,-65000 to 170000,-65000, with the same 1 in 98.9 fall and the same ground as W665p.
4. **Code:** `LinkService.Utilities.cs` 846-860 (only copied labels stay in the copy's list); `Rules\CopyCleanUpCompletenessRule.cs` 34-47 (each missing role, label, first level, last level and arrow, is listed) and 56-63 (switch, ON); `LinkService.CloneRegeneration.cs` 110-117 (the BUG-671 branch) and 141-210 (label only if missing); `Models\PipeAttachmentSemantics.cs` 11-14 (role names); `PipeCreationService.cs` 333, 410, 546 (a new CD pipe records those roles, so the copy can tell what is missing).
5. **Derived, not seen on a run:** as W665p item 5. Also that picking the pipe and label by handle gives AutoCAD the same selection as a crossing window would.
6. **The twin breaks one thing:** `linking.copyCleanUpKeepsEveryPiece false`. Once any piece came with the pipe, nothing is missing (`CopyCleanUpCompletenessRule.cs` 40-41), so CE returns early (`CloneRegeneration.cs` 110-117). The copy has no IL texts and no arrow, and those counts fail.
7. **Not driven:** the other branch (levels copied, label missing). How the drawn pieces look is a Codex look.

### 6. BUG-666: no case (Codex or a probe first)

1. **What it needs:** a same-plan-break pipe or a split rising main. Copy one half, ERASE the copy, and check the original's breakline symbol, outline or twin barrels survive (and that a MOVE of the copy does not drag them).
2. **Why the robot cannot do it today:** the break is made from the New Pipe window's same-plan-break choice (`CdCommand.cs` 1188-1194, `CdViewModel.PipeType.cs` 364, `IsSamePlanBreak`). Then CE asks for two typed break points ("Pick first break point on the drawn pipe: ", `CdCommand.SamePlanBreak.cs` 241 and 250) and the real total length (267). The typed part is fine, but the window control's id is in no ui_map file, no probe report and no past OK step. Brief check 5 forbids an unknown id. The "grip-copied pipe after U" route needs a mouse drag.
3. **The fix being tested:** `LinkService.Utilities.cs` 838-844 (`RemapClonePipe` clears the copy's breakline symbol, second breakline, linked half and same-plan partner unless they were copied with it, via `CloneLinkHandles.RemapOrClear`).
4. **Next step, my recommendation:** one read-only probe of the New Pipe window to read the same-plan-break control's id (as PRB_newpipe_ids did). Then a case: CD 20 m pipe with that tick, break points 6 m and 8 m along, Enter for the length, COPY the first half 15 m away, ERASE the copy, and count the breakline blocks (must still be 2). Until then, a Codex look can do it by hand.

### 7. BUG-672: W672 and W672_BROKEN

1. **In AutoCAD terms:** (A) lock layer 25TEXT. COPY pit P3 5 m south. The copy keeps its number label, has no cover text, and CE says "no cover text" and names 25TEXT. U, then unlock. (B) Lock layer STORMWATER PIT LABEL. The same COPY. The copy gets its cover text but no label, and CE says "no label" and names that layer. U, then unlock.
2. **Checks, A:** "1 pit copied and numbered as new."; the exact line "1 copied pit(s) got their own number but no cover text: layer 25TEXT is locked, and CE does not draw on it. Undo (U), unlock layer 25TEXT, then copy again."; never "no label"; one pit block on STORMWATER PIT; one PIT LABEL on STORMWATER PIT LABEL; no CL text; U brings the count back.
3. **Checks, B:** the copy line; the exact line "1 copied pit(s) got their own number but no label: layer STORMWATER PIT LABEL is locked, and CE does not draw on it. Undo (U), unlock layer STORMWATER PIT LABEL, then copy again."; never "no label or cover text"; one pit block; no PIT LABEL; one CL text on 25TEXT; U brings the count back. No window is left open, and the file is unchanged.
4. **Why both ways round:** the old code stopped at the FIRST locked annotation in the pit's list (`LinkService.CloneRegeneration.cs` 314-316), and the order of label and cover text is not known from outside. Doing A and B means one of them shows the old fault whatever the order.
5. **Code:** `LinkService.CloneRegeneration.cs` 296-316 (the kind is named, 304-307; skip and carry on, 311-312); `Services\CloneCleanupMessages.cs` 134-172 (the line, 170-171; the old fallback `NothingCopied`, 149-152); `Rules\RotateScaleCopyRule.cs` 53-58 (the word "label" or "cover text"); `CopyCleanUpCompletenessRule.cs` 53.
6. **Derived, not seen on a run:** the whole B sentence (A's wording is seen in R33m on 3.0.85 and 3.0.88); that the PIT LABEL is recognised as a label, so B says "label".
7. **The twin breaks one thing:** `linking.copyCleanUpKeepsEveryPiece false`. Whatever the order, A or B loses the piece on the open layer (a label or cover count fails), and both lines fall back to "no label or cover text" (both long checks fail). No `ent-read` is used, so no step can be refused.
8. **For a Codex look:** none needed for the behaviour. The copy's number is read by R33, not here.

### 8. Could not write, and faults noticed (names only, nothing edited)

1. **BUG-666:** see section 6.
2. **R34sn (main cases folder):** its TITLE and NOT_AUTOMATED still say the ROTATE Copy "adds no label". That is stale since 3.0.85: run aL-s2 on 3.0.88 recorded a PIT LABEL for the ROTATE copy. It does not change a check (the B8 review already noted it).
3. **R34s:** its EXPECTED names "the shipped new switch linking.rotateScaleCopyLikeCopy ON" while pinning only the older tick. A pass there cannot tell which switch did the work. W665 pins the older tick OFF to settle that.
4. **Brief lesson 4** says "'field' on an empty selection fails the step". At `case_runner_lib.ps1` 349-351 it returns empty and succeeds. It is `ent-read` of the resulting empty handle and `dist` on an empty list that fail. Worth correcting in the next brief.
