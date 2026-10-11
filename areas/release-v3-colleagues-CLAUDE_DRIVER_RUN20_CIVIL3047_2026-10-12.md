# Claude driver run 20: Civil 3.0.47 / Manager 1.1.47 (C-37) + Structural 1.0.115 (Monday 12 Oct 2026, PC clock 03:47 to 03:59)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 20, Sonnet, headless. The brief said about 00:30; it actually started at 03:47. `Get-Process acad` showed nothing before the first call. Codex processes were present on the PC but none had AutoCAD open, so I went ahead. Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only: `CLD40_B1` (hash 34BBE37C2EA4 = DRV1_B1), `CLD40_S1` (950AFDF6E523 = DRV2_S1) and `CLD40_B1R` (a third copy of DRV1_B1, opened read-only). One AutoCAD (pid 53324), launched by the driver through Explorer. Nothing was saved. I did not go round the driver.

## Answer first

1. **FAIL: 0. PASS: 9. BLOCKED: 1. INCONCLUSIVE: 1. SKIPPED: the rest (listed in section 3 with a reason each).**
2. **REDO regression: all four walks PASS** ("Everything has been redone" each time): plain circle on Structural, plain circle on Civil, typed MOVE of pit P3 (109D56), and UNDO 2 then REDO of two pit MOVEs. No view change and no drawing switch sat between any U and its REDO.
3. **One real finding: CEHEALTH prints a WARN on both drawings.** "CE_SUITE_MANAGER is installed in two places, so AutoCAD may load both ... Remove one." The old copy is a stale **Manager 1.0.0 (build cac19768, 8 July 2026)** in `C:\ProgramData\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle`. The live one is 1.1.47 in Tim's Roaming folder. The Manager window shows 1.1.47, so the new one is what ran. The desk should decide whether to remove the ProgramData copy.
4. **The locked-layer promise holds:** with the pipe layer locked, a pit MOVE printed the plain sentence and one U took it back.
5. **The C-32 "locked pit label layer" checks (#882) could not be driven:** the buttons that finish a pit placement and an Edit Pit are on the driver's never-press list. That is a driver refusal, not a CE fault.
6. **Driver calls: 88 of 90** (wrapper count, every call including refusals). Run time 12 of 90 minutes. **AutoCAD closed cleanly** with the driver `quit` (CloseMainWindow, not killed, 3 drawings closed without saving, lock released, `Get-Process acad` empty).

## 1. Versions read before the first call (nine DLLs, `readdll.ps1`)

1. **Civil:** Legacy / Net8 / Modern all `3.0.47+74248c1d` (hashes 818BDB669055, 33CEA1137B7C, 3CD2B267E9C0).
2. **Manager:** all three `1.1.47+74248c1d` (B751893310CC, 4389B17127E0, 5BC18BD864CE).
3. **Structural:** all three `1.0.115+4e17dd50` (3B2B22EF9AF5, CF06D3A9D014, EA52757FA9A7).
4. The Manager window read the same three versions back (1.1.47, 3.0.47, 1.0.115), "3 of 3 installed CE tools running · 507 commands ready".

## 2. Results, in the order of the brief

### Step 1: REDO regression (CD lane, BUG-256 area)

1. **PASS, plain circle on the Structural copy.** `_.CIRCLE 0,0 10`, `U` (echo "CIRCLE"), 15 s, `REDO`: "CIRCLE / Everything has been redone".
2. **PASS, plain circle on the Civil copy.** Same steps: "Everything has been redone".
3. **PASS, typed MOVE of pit P3 (handle 109D56) on the Civil copy.** Selected with `(sssetfirst nil (ssadd (handent "109D56") (ssadd)))` (-AllowLisp, from a file because the quotes get lost on the command line), `_.MOVE 0,0 1000,0`, `U` (echo "MOVE"), 15 s, `REDO`: "MOVE / Everything has been redone". CE printed its usual line on the MOVE: `[CE Civil] pipe P3 -> P2 label: no clear spot among its usual positions, left where it is (on "the block Drawing Border").` That is a note, not an error.
4. **PASS, UNDO 2 then REDO on the Civil copy.** Two pit MOVEs (`1000,0` then `0,1000`), then `_.UNDO 2`: "MOVE MOVE". After 12 s `REDO`: "MOVE MOVE / Everything has been redone".
5. **Witness:** the recorder logs show **zero `VIEWBACKSTATUS` events** in all three drawings' logs (B1 3,951 lines, B1R 225, S1 354). That is what BUG-558 runs 18 and 19 predict: no drawing switch between U and REDO, so no REDO loss and no view events.
6. **Not tested here (not asked):** a drawing switch between U and REDO. BUG-558 stays recorded as AutoCAD native (runs 18 and 19).

### Step 2: typed-only checks of the C-32 PRs

1. **#881 Pit Schedule on a read-only drawing: PASS (controls), sentence NOT SEEN.** `CLD40_B1R` opened read-only, `PITSCHEDULE`. Buttons `Relink and recalculate`, `+ Add Row`, `− Remove Row`, `↑`, `↓`, `Reset Sort`, `Continue to Place / update`, the remarks box and the `Row has an override` tick were all **disabled**. Control on the writable copy: `Relink and recalculate`, `+ Add Row` and `− Remove Row` are **enabled**. The sentence "This drawing is read-only, so the schedule can be viewed but not changed." was **not found** in the window tree on either the first tab or the Link tab (the tree is capped at 400 nodes of 657, so it may be below the cut). So: the controls are right; the wording is unproven. The REFEDIT half of #881 is skipped (REFEDIT needs a dialog and a pick).
2. **#882 locked pit label layer (PIT and Edit Pit): BLOCKED.** I locked `STORMWATER PIT LABEL` (typed `-LAYER` lock through LISP, flag read back 4), then `PIT` with a typed point opened `New Pit`: the only way on is `Continue placement`, which the driver never presses. `CDEDIT` on pit P3 opened `Edit Pit`, I typed plan length 1200 into the box, then `ui click "Save pit and close"` was refused word for word: `REFUSED: control name 'Save pit and close' contains 'Save'; nothing was pressed`. Both windows were closed with Cancel; the layer was unlocked (flag 0). Nothing was placed or saved. The refusal sentences "Pit not inserted - layer 'STORMWATER PIT LABEL' is locked ..." and "The pit label is on locked layer ..." are therefore **not seen**. Codex or Tim has to press the button.
3. **#900 Boyd's tab starts blank: INCONCLUSIVE, not a fail.** CDCALC opened; the `10. Boyd's Method` tab showed 746 / 414 / 332 / 7.9 and a status "Results need checking: the drawing or council settings changed since t...". That status means DRV1_B1 already holds a saved Boyd's draft, and a saved draft restores its own figures (by design). To test the blank start a job that never saved CDCALC is needed.
4. **Protection (locked-layer rule, native): PASS.** Locked `STORMWATER PIPE`, selected pit P3, `_.MOVE 0,0 1000,0`. CE printed: `[CE] Layer "STORMWATER PIPE" is locked, so CE left the pipes P3 -> P2, IO8 -> P3, WT9 -> P3, P4 -> P3 and 2 more as they were, labels included (the pit moved, the pipes did not). CE never unlocks a layer. U undoes the move.` One `U` (echo "MOVE") took the move back. Layer unlocked afterwards (flag 0).
5. **Manager window (Manager stack): PASS.** `CEMANAGER` opened `CE Suite Manager`. Buttons: Admin Dashboard, Refresh, Send waiting reports, Send a fault report. **No Roll Back button** on the plain window. Footer: "3 of 3 installed CE tools running · 507 commands ready".
6. **Start-up lines (C-37 entry "no [CE Manager] line prints"): PASS.** The command-line history from launch has **no `[CE Manager]` line**. MENUBAR reads 1. It does show the two AutoCAD lines "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "...CE_SUITE_MANAGER_MENU:CE Manager"; the desk's own run 60 (BUG-435) traced these to Tim's acad.cuix, not to CE, and the menus still load. Whether the pull-down is on the menu bar cannot be seen through the driver: **not proven**.
7. **CEHEALTH on both drawings: ran, no error, one WARN.** Both printed: Civil 3.0.47 OK, Structural 1.0.115 OK, Manager 1.1.47 OK, "matching pair" OK, **WARN two Manager copies**, office IT folder reachable OK, "1 issue(s) found". On the Structural drawing a "Regenerating model." line followed. Nothing printed an error.

### Step 3 also: the driver event worth knowing

1. **A self-made false alarm.** I guessed the CDCALC window title ("Calculations") and the real title is `Creative Engineering | CDCALC`. The window opened, the driver waited for the wrong name and raised its prompt alarm (22 s). It cleared by itself at the next `wait` (AutoCAD idle). Not a wedge, not a CE fault; my mistake, one wasted call.
2. **Autosave** ran at about 03:52 (the history shows an "Automatic save to ...sv$" line) while the Edit Pit window was open. It did not fall inside any U to REDO wait, so no walk was spoiled.
3. **CE made its own backup on opening** the Civil copy: "49 pipe(s) upgraded to CE pipe objects, 49 given their CE identity. Backup: C:\ce_rc_drv\CLD40_B1_PRE_C7_20261012_034744.dwg" (the normal CE behaviour on first open; this file now sits in the test folder).

## 3. Skipped, with the reason (nothing here was tried and failed)

1. **#880 refuse during REFEDIT, #881 REFEDIT half:** REFEDIT is a dialog plus a pick; no complete typed form.
2. **#883 CDRULES / CDCHECK end sentences:** the failing case needs a read-only log folder, and a CDCHECK chain is unproven (README: may leave a question open).
3. **#884, #885 New Pipe grade question, Pit Schedule decimals:** need a CD pipe and a Yes/No question whose prompt is unproven; wedge risk.
4. **#888 coded Windows login in the drawing:** needs a pipe confirmation or CDDESIGN sign-off, then reading an attribute.
5. **#891 Esc at the pit label, Edit Pit world-point fix, #903 flows curve, #905 hard-ground C:** each needs a Settings-file key set to true (Tim's real settings file, not allowed) and/or PIT or Edit Pit placement (blocked as in 2.2).
6. **#894 grade 1:N, #909, #913, #915 CDDESIGN sentences:** `CDDESIGN` asks command-line questions (storm report, council offers) before its window opens, so a bare command could wedge AutoCAD.
7. **#896 / #897 layer colours (CDRG, CDSPOONDRAIN):** prompt order not proven as a one-line form.
8. **#901 right-click Edit pit / Edit pipe:** a click (the brief said skip).
9. **#908, #911, #912, #914, #916, #917, #918, #920, #922:** window figures or Settings values; at the defaults they equal today's (pinned), and #912 has no setter yet. Typing into CDCALC's boxes is also blocked: the four number boxes have no accessible name, so the driver cannot pick one.
10. **Drawing switch between U and REDO, SAVETIME autosave walks:** not part of this run.

## 4. System variables

1. **Civil copy before:** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". **After:** 5375, 5, "BLOCKS". Unchanged.
2. **Structural copy before:** OSMODE 5375, SAVETIME 5, CLAYER "0". **After:** 5375, 5, "0". Unchanged.
3. I used no `setvar`. I locked and unlocked two layers (`STORMWATER PIT LABEL`, `STORMWATER PIPE`) on the unsaved Civil copy; both read back flag 0 afterwards. `quit` put LOGFILEMODE back to 1.

## 5. Driver notes

1. **Refusals:** one, the `Save pit and close` click (word for word in 2.2). No other refusal.
2. **Quoting:** a LISP line with double quotes typed on the command line loses its quotes (AutoCAD said "too many arguments", one call spent). Putting the text in a file and using `-InputFile` works.
3. **`quit` removed 7 stray logs** (`CLD40_B1`, two `CLD40_B1R`, `CLD40_S1`, three `Drawing1`), harmless.
4. **Not seen / not proven:** the real pull-down menu bar, the read-only sentence, any #882 sentence, any CDDESIGN sentence.

## Summary

Claude ran run 20 on the new build (Civil 3.0.47 / Manager 1.1.47 / Structural 1.0.115, all nine DLLs read first) in 12 minutes using 88 of 90 driver calls on fresh test copies CLD40_B1, CLD40_S1 and a read-only CLD40_B1R. All four REDO walks passed (plain circle on each drawing, typed MOVE of pit P3, UNDO 2 then REDO), and with no drawing switch the recorder showed no view events. Of the C-32 items, the typed ones that could be driven passed (Pit Schedule edit buttons off on a read-only drawing, the locked-pipe-layer MOVE sentence, the Manager window with no Roll Back button, no "[CE Manager]" start-up line), the locked pit label layer checks (#882) were blocked by the driver's own never-press rule on `Continue placement` and `Save pit and close`, the blank Boyd's start was inconclusive because that drawing already holds a saved Boyd's draft, and the rest were skipped for stated reasons. CEHEALTH printed no error but one real warning: a stale Manager 1.0.0 (8 July) is still installed in `C:\ProgramData\Autodesk\ApplicationPlugins`, next to the live 1.1.47. OSMODE, SAVETIME and CLAYER were identical before and after on both drawings and nothing was saved.

AUTOCAD CLOSED
