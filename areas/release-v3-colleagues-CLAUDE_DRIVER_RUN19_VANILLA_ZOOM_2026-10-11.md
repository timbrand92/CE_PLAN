# Claude driver run 19 (vanilla AutoCAD zoom test): VANILLA LOSES REDO. BUG-558, Sunday 11 Oct 2026 (PC clock 22:56 to 23:01)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 19, Sonnet, headless. Before the first call `Get-Process acad` showed nothing. The five CE bundles were `.bundle.off_ctrl` (the controller's rename; I changed nothing and restored nothing). Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only: `CLD28_B1` (hash 34BBE37C2EA4 = DRV1_B1) and `CLD28_S1` (950AFDF6E523 = DRV2_S1), both writable in one AutoCAD (pid 47252, launched by the driver through Explorer, B1 as the launch drawing). Nothing was saved. I did not go round the driver.

## Answer first

1. **YES. Vanilla AutoCAD (no CE bundle loaded) loses REDO after a zoom in the other drawing.** `_.ZOOM _W` on the Civil copy: "Nothing to redo". `_.ZOOM _E`: "Nothing to redo". The `_.ZOOM _W` repeat: "Nothing to redo". Three of three zoom walks lost it.
2. **The control kept REDO.** Civil copy untouched, same circle / U / 15 s / switch to Civil and back / REDO: "CIRCLE / Everything has been redone".
3. **So BUG-558 is not caused by CE.** It is AutoCAD's own behaviour: changing the view in the Civil drawing makes the Structural drawing's redo history vanish when you switch back. CE can only avoid it (or restore the view); it cannot be fixed in CE code as a CE defect.
4. **The witness shows the same signature as the CE-loaded runs (10, 16, 17, 18):** exactly three `SysVarChanged VIEWBACKSTATUS` events on the Structural drawing between the U and the REDO in every lost walk, and none in the control.
5. **CEHEALTH answered `Unknown command "CEHEALTH".  Press F1 for help.`:** CE really was off.
6. **Driver calls: 49 of 50** (wrapper count, every individual call). Run time about 5 minutes of the 45 allowed. **AutoCAD closed cleanly** with the driver `quit` (CloseMainWindow, not killed, 2 drawings closed without saving, lock released, `Get-Process acad` empty).

## 1. The four cases (each: Structural plain circle, U, 15 s, switch to Civil and back, REDO)

1. **Case 3, control (X = nothing), radius 10:** U echo "CIRCLE / Everything has been undone". REDO echo: "CIRCLE / **Everything has been redone**". **KEPT.**
2. **Case 1, X = `_.ZOOM _W 54000,-70000 64500,-69000`, radius 15:** U echo "CIRCLE". REDO echo: "**Nothing to redo**". **LOST.**
3. **Case 2, X = `_.ZOOM _E`, radius 20:** U echo "CIRCLE". REDO echo: "**Nothing to redo**". **LOST.**
4. **Case 4, repeat of case 1, radius 25:** U echo "CIRCLE". REDO echo: "**Nothing to redo**". **LOST.**

## 2. View variables on the Civil copy (typed getvar, before then after X)

1. **Case 1:** VIEWCTR (74649.58, -64738.26, 0) to (59250.0, -69500.0, 0). VIEWSIZE 24257.92 to 3184.52. VIEWBACKSTATUS 0 to 1.
2. **Case 2:** VIEWCTR (59250.0, -69500.0, 0) to (82629.81, -107463.94, 0). VIEWSIZE 3184.52 to 254979.81. VIEWBACKSTATUS 1 to 1 (already 1 from case 1).
3. **Case 4:** not read (budget; X only). The case 1 and 2 reads are enough to show the view really changed.
4. **Control (case 3):** no X, so no before and after read.
5. **Not read:** OSMODE, SAVETIME and CLAYER (I changed none of them: no setvar was used; `quit` restored LOGFILEMODE to 1 as it was).
6. The Civil start view differs a little from run 18 (VIEWCTR x 74649 here, 67981 there; the window shape differs between launches). That does not change the answer.

## 3. The witness (recorder log `CLD28_S1_20261011-225731-912.jsonl`, events between each U and its REDO on the Structural drawing)

1. **Walk 1 (control), U seq 25, REDO seq 51:** CIRCLERAD change, command / lock / object events, **no VIEWBACKSTATUS**. KEPT.
2. **Walk 2 (case 1), U seq 96, REDO seq 125:** the same plus **three `SysVarChanged VIEWBACKSTATUS` (seq 121, 122, 123, at 22:59:09, inside the switch)**. LOST.
3. **Walk 3 (case 2), U seq 145, REDO seq 174:** plus **three VIEWBACKSTATUS (seq 170, 171, 172)**. LOST.
4. **Walk 4 (case 4), U seq 194, REDO seq 223:** plus **three VIEWBACKSTATUS (seq 219, 220, 221)**. LOST.
5. **Nothing CE-related is in play:** no CE command, no bundle, no CE log line. The events come from AutoCAD itself at the drawing switch. The Civil log shows the same three events at every switch (seq 15 to 17 and 18 to 20) and the ZOOM's own single VIEWBACKSTATUS event.
6. The object events in the walk (9 ObjectModified, 10 ObjectOpenedForModify, 1 ObjectErased) are the same in all four walks including the control, so they do not separate the cases.

## 4. Other things recorded

1. **`ce_suite_startup.lsp` printed nothing I could see.** The start-up history held only "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" (the menus have no bundle behind them, which is expected with CE parked), then "AutoCAD menu utilities loaded". I did not find any line from the lsp itself.
2. **No proxy dialog was seen.** The driver never reported a modal window, and `quit` found no known pop-up. CE objects are proxies without CE; I did not look at the drawing itself and the driver cannot see an AutoCAD-native dialog, so "no dialog reported" is the most I can say.
3. **Driver:** no refusals. `type "_.ZOOM _W ..."` and `"_.ZOOM _E"` accepted. Lock, launch, `witness check` (ok_to_load, pin 49E79D6D... matches), `witness load` (1.3 s, SECURELOAD 0, no prompt) all fine. Strays removed by `quit`: three logs (CLD28_B1, CLD28_S1, Drawing1).
4. **Order used:** control first on the untouched Civil copy, then case 1, then case 2, then case 4, all in one session. Unlike run 18 I did not restart AutoCAD for the extents case, so case 2 ran on a Civil drawing already zoomed by case 1; it still changed the view (VIEWSIZE 3185 to 254980).

## 5. What this says, and what it does not

1. **It says:** in plain AutoCAD 2027, zooming the Civil drawing, then drawing and undoing something in the Structural drawing and switching to Civil and back, loses the redo. A drawing switch with an unchanged Civil view does not.
2. **It does not say:** why. I did not test `ZOOM _P` back to the start view (run 18 saw that keep REDO with CE loaded), a pan, or a real mouse-wheel zoom. I did not test whether CE makes it worse (run 18 and this run give the same result with and without CE, so no difference is visible). One walk of each kind per session only; three lost walks and one kept control, not a statistical result.
3. **Counts so far:** vanilla 3 of 3 zoom walks lost, 1 of 1 control kept. With CE loaded (run 18) 2 of 2 typed zooms lost, 1 of 1 control kept, plus 12 of 12 placed-pipe walks lost.

## 6. Recommendation

1. **Desk:** BUG-558 stays open but is reclassified as **AutoCAD's own behaviour on a view change in the other drawing**, reproduced with no CE code loaded. Do not mark it fixed. Record the trigger as any view change in the other drawing (typed zoom is enough).
2. **The only CE-side choice left** is whether CD's AutoZoom should be kept as is (it triggers AutoCAD's behaviour after every pipe), or avoided. That is a product decision for Tim; a cheap test is a pipe placed with AutoZoom off in CE Settings, which was never run.
3. **No further CE code hunt** (handlers, Idle, DocumentActivated) is justified by this evidence. Add the vanilla result to the user-facing note so nobody wastes time hunting a CE fault.

## Summary

Claude ran run 19 on a vanilla AutoCAD 2027 (all five CE bundles parked by the controller; CEHEALTH answered "Unknown command") with the recorder loaded and fresh copies CLD28_B1 and CLD28_S1, using 49 of 50 driver calls in about five minutes. The answer is yes: vanilla AutoCAD loses REDO after a zoom in the other drawing. The untouched control kept it ("Everything has been redone"), while `_.ZOOM _W`, `_.ZOOM _E` and a repeat of `_.ZOOM _W` on the Civil copy each gave "Nothing to redo" after the Structural circle, U, 15 s and a switch to Civil and back, with exactly three VIEWBACKSTATUS events between the U and REDO in every lost walk and none in the control. BUG-558 is therefore AutoCAD's own zoom-history behaviour, not a CE fault; I did not read OSMODE, SAVETIME or CLAYER (nothing wrote them), the proxy-dialog check is only "none reported by the driver", and nothing was saved or committed to any drawing.

AUTOCAD CLOSED
