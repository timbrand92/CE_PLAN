# Claude driver run 9: first driver pass on Civil 3.0.42 / Structural 1.0.111, Saturday 10 Oct 2026 (PC clock 05:21 to 05:29)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 9, Sonnet, headless. `Get-Process acad` showed nothing running first. AutoCAD 2027 (pid 44496) launched by the driver, closed cleanly by the driver `quit` (nothing saved). Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only: `C:\ce_rc_drv\CLD17_B1.dwg` (hash 34BBE37C2EA4 = DRV1_B1) and `CLD17_S1.dwg` (hash 950AFDF6E523 = DRV2_S1), both writable in one AutoCAD. I did not go round the driver at any point.

## Answer first

1. **REDO survived in every case on the new build: 5 of 5 PASS.** No drawing-switch loss, with CE 3.0.42 / 1.0.111 loaded. This matches runs 6 to 8 and not run 5.
2. **Structural 1.0.111 typed probes: 4 of 4 PASS** (CSREOBAR, FEDIT size, C1, TS1). Each: one U took the whole command, REDO said "Everything has been redone".
3. **CEHEALTH: PASS on both drawings.** Both print "CE Civil Suite v3.0.42", "CE Structural Suite v1.0.111", "All checks passed".
4. **The new Civil 3.0.42 features: 0 tested, all SKIPPED with reasons** (section 3). Three of the four new settings are OFF by default, one change is a guard test, and the privacy fix writes into the real office IT folder.
5. **System variables unchanged** (OSMODE 5375, SAVETIME 5; CLAYER unchanged on both).
6. **Driver calls: 58 counted by the wrapper** (cap 60), no cancel, no BLOCKED call, no wedge. Total about 7 minutes.
7. **Witness: zero `VIEWBACKSTATUS` events on either drawing** for the whole run (run 5 had three per drawing at each switch).

## 0. Installed versions (readdll.ps1, 10 Oct 05:20)

1. **Civil CE_CVL_SUITE 3.0.42+f8ce1594:** Legacy 114429D00566, Net8 801EC8A47BE6, Modern 0171E0F0C497.
2. **Manager CE_SUITE_MANAGER 1.1.42+f8ce1594:** Legacy 52B767FDC5DD, Net8 6E7B12D1614B, Modern 402D61A0FC23.
3. **Structural CE_STRUC_SUITE 1.0.111+cecdef7c:** Legacy 7ED84C46FCF9, Net8 72A985C6FF3A, Modern 7F41BCF55E1F.
4. The five bundles were back (run 8 had them renamed off); CEHEALTH proves both suites loaded.

## 1. The REDO regression set (edit, U, 15 s, REDO)

1. **PASS, plain circle on Structural, no switch:** U echo "CIRCLE", REDO "CIRCLE" / "Everything has been redone".
2. **PASS, plain circle on Structural, switch to Civil and back (two `open` calls):** U "CIRCLE", REDO "CIRCLE" / "Everything has been redone".
3. **PASS, typed MOVE of pit P3 (handle 109D56, `sssetfirst` then `_.MOVE 0,0 0,1000`), no switch:** MOVE printed "1 found" and CE's own line `[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border").` U echo "MOVE", REDO "MOVE" / "Everything has been redone".
4. **PASS, same MOVE (`0,0 1000,0`), U, 15 s, switch to Structural and back, REDO:** "MOVE" / "Everything has been redone".
5. **PASS, PIT with a typed point then Cancel, then a Structural circle, U, switch, REDO:** `type "PIT`n10000,-90000" -ExpectWindow "New Pit"` (window appeared, 13.5 s), `ui click "New Pit" "Cancel without saving"` (ok), history: "PIT command cancelled." Then circle, U, 15 s, switch to Civil and back, REDO: "CIRCLE" / "Everything has been redone".
6. The Civil copy has missing background xrefs (CE prints "Background not found: XW2626-Title Block ..." lines); they made no difference.
7. **Not run:** a CD pipe placed through the New Pipe window (the only thing run 5 had that later runs lacked; the brief forbids driving that window), and a PIT that places a pit.

## 2. What the witness shows

1. **No `VIEWBACKSTATUS` event at any switch on either drawing** (0 and 0 in the files).
2. **Structural log, between each U and its REDO:** only the U's lock change, then the REDO's own start. Nothing else (no command, no sysvar change, no autosave).
3. **Old recorder DLL** (SHA AD8A22D3...), loaded in 1.7 s, SECURELOAD 0, no prompt. It has no object events, so as before "nothing seen" means no command, sysvar or view event only.
4. **One autosave fell inside the TS1 step** (before its U, not between U and REDO), and REDO still worked.
5. Logs kept beside this report: `release-v3-colleagues-CLAUDE_DRIVER_RUN9_witness_B1.jsonl` and `..._S1.jsonl`.

## 3. New things in 3.0.42 that need only typed commands: all SKIPPED

1. **#864 (fault report / CEMANAGERDIAG uses coded names): SKIPPED on purpose.** The command writes a real file into the office IT folder, and CEHEALTH on this PC says that folder "can be reached", so it would write into Tim's real office share. The PR itself says never to run it against Tim's real office folder. Needs the desk: a test folder or a decision.
2. **#835 hand-placed pipe label stays: SKIPPED.** The Settings key is OFF by default and I must not edit Tim's settings; the move only shows the behaviour with the key on.
3. **#833 Pit Schedule natural order (P1, P1A, P2; SPS2 before SPS10): SKIPPED.** OFF by default; this drawing has no P1A or SPS pits; it is a window check.
4. **#834 record a pipe end pulled off a pit: SKIPPED.** Engine only, nothing on screen yet, no command prints it.
5. **#845 every pipe keeps its own label (no "TYP."): SKIPPED.** The check needs two CD pipes, and CD opens the New Pipe window, which this run must not drive.
6. **Not driven:** New Pipe and New Pit windows with typed values (as instructed); no click-pick items.

## 4. Structural 1.0.111 typed probes

1. **CSREOBAR: PASS.** `CSREOBAR`, `N16`, `3`, `100`, `tAndB`, `0,8000`, `@5500,0`, `Yes`. Printed "Preview: BM1  3-N16-100 CTS x 5500 LG, TOP & BOTTOM" and "BM1: 3-N16-100 CTS x 5500 LG, TOP & BOTTOM." After 12 s: U echo "CSREOBAR", then REDO "CSREOBAR" / "Everything has been redone".
2. **FEDIT size 700 on PF1: PASS.** `FEDIT`, `300,0`, Enter, `700`, Enter, Enter, `No`. Printed "[FEDIT] You picked CE's outline: editing PF1...", "Current: PF1, Pad footing, 600x600", "Enter new X size <600>: 700", "[FOUNDATION] Redrew footing system 'Footing Network': 4 footings. Nothing needs attention.", "[FEDIT] PF1 updated." U "FEDIT", REDO "FEDIT" / "Everything has been redone".
3. **C1: PASS.** `C1`, `19000,4000`, Enter, `19600,4300`, `7`. U echo "C1 GROUP", REDO "GROUP C1" / "Everything has been redone". **Wording changed since 1.0.110:** the line "Text placed at the top right (CR1)." is now "Label at the top right: enter its text, it goes at the spot you picked." then "Enter a number to append to 'C' ...". Same prompts, so the chain still works; recorded in case a test list quotes the old line.
4. **TS1: PASS.** Same chain with `22000,4000`, `22600,4300`, `7`; same new wording ("... append to 'TS'"). U "TS1 GROUP", REDO "GROUP TS1" / "Everything has been redone". Both C1 and TS1 print "[CE] Beam linking is switched off in Settings, so the support is not linked."
5. Not read this run: object counts after U (the echoes and REDO text were the evidence); no `z:n` helpers loaded, to save calls.

## 5. CEHEALTH

1. **Structural copy: PASS.** `[CEHEALTH] Checking the CE tools on this PC...`, `[OK] CE Civil Suite v3.0.42`, `[OK] CE Structural Suite v1.0.111`, `[OK] The office IT folder (where CE updates come from) can be reached.`, `[CEHEALTH] All checks passed.`
2. **Civil copy: PASS,** the same five lines.
3. Typed with `-Force` (a bare command word).

## 6. System variables (read with one LISP line per drawing, `-AllowLisp`)

1. **Before:** Civil OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". Structural OSMODE 5375, SAVETIME 5, CLAYER "0".
2. **After:** Civil 5375, 5, "BLOCKS". Structural 5375, 5, "0". **Unchanged.** I used no `setvar`.
3. Driver `quit` restored LOGFILEMODE (reads back 1), closed 2 drawings without saving, removed 3 stray logs, released the lock (the extra `lock release` call said none held).

## 7. Other observations

1. **A "What's New" window opened on the first start of 3.0.42.** It did not block anything this run; `quit` closed it with WindowPattern.Close.
2. **The MOVE chain with the pit pre-selected** was accepted because `pickfirst_count` was 1 (as in runs 3 to 6).
3. **The MOVE prints CE's "label: no clear spot" line on this drawing.** It comes from the Drawing Border block under the label; it is not an error, and it appeared on each MOVE.

## 8. What I could not prove

1. Whether a CD pipe placed through the New Pipe window loses REDO at a switch (run 5's one unexplained case): not run.
2. Anything about the new 3.0.42 features: none can be driven by typed commands alone without editing Tim's settings or writing into the real office folder.
3. Object-level changes between U and REDO (the recorder still has no object events).
4. One run of each case; 5 of 5 is small, but run 5's loss was 4 of 4.

## 9. Recommendations

1. **Desk:** decide a safe folder for CEMANAGERDIAG (a test office folder or a way to point it at a scratch folder); until then #864 can only be checked by Tim or Codex.
2. **Desk:** the new settings (#835, #833, #834) need either a test copy of the settings file or Tim's yes to switch them on before a driver run can show anything.
3. **BUG-558 note:** run 9 kept REDO 5 of 5 on the new build; runs 6, 7, 8 and 9 all kept it; only run 5 (with a CD pipe through New Pipe) lost it.

## Summary

Claude ran run 9 on fresh Civil and Structural test copies in AutoCAD 2027 with Civil 3.0.42 / Manager 1.1.42 and Structural 1.0.111 loaded, using 58 counted driver calls in about seven minutes. All five REDO cases passed on the new build, including the drawing-switch variants after a plain circle, a typed MOVE of pit P3, and a cancelled PIT, and the witness showed no `VIEWBACKSTATUS` events. The Structural typed probes CSREOBAR, FEDIT size 700, C1 and TS1 each took a single U and redid cleanly (C1 and TS1 print new wording), CEHEALTH passed on both drawings, and OSMODE, SAVETIME and CLAYER were unchanged. The new Civil 3.0.42 features were skipped, because the settings are off by default, the CD pipe check needs the New Pipe window, and CEMANAGERDIAG would write into the real office IT folder.

AUTOCAD CLOSED
