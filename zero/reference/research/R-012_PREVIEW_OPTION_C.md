# R-012. Preview option C: a window beside the real drawing that zooms to a system and lights it up (Tim's open choice, D-297)

Written Wed 18 Nov 2026, about 18:50, by the trials chat. Tested in AutoCAD 2027 on a made-up 2,500-object drawing (`p_2500.dwg`: 2,000 pipes and 500 text labels, in a test folder), one test AutoCAD at a time, Tim's CE plugins loaded as always, closed normally with No to saving. Pictures are in `C:\CE_WORK\trials\zero\evidence\r011\`. No web addresses.

**Morning line for Tim (18 Nov, second night run): answer first.** Yes: the system can be lit up with no "Save changes?" prompt. Temporary outlines and tags, and the docked window, do not mark the drawing changed; a view change made through AutoCAD's graphics layer does not mark it either (AutoCAD closed with no prompt every time), whereas the usual zoom and the editor's own view setting do. The window also docks at the right edge with the drawing still usable beside it. **Still open:** the graphics-layer zoom lands in the wrong place (a maths fix, not a blocker), and a real mouse click on the window's OK and Cancel did not fire in my test (the keyboard did).
**Completed:** A1, A3, A4 and the docking (B) PROVEN; A2 PROVEN that the graphics route does not mark the drawing. **Not completed:** an accurate zoom through the graphics route; the mouse click on OK and Cancel (C); a check that AutoCAD does not remember the window's position in the profile.
**Next:** fix the zoom position (read the view back after each change and correct it), try the real mouse on the buttons with Tim's own hand or the other robot, and check the palette's saved state.

(First night run, earlier: Yes, the real drawing can do option C. The plug-in can remember the view, zoom AutoCAD's own drawing to a chosen set of pipes with a margin, light them up with temporary outlines and put small figure tags beside them, none of it saved in the drawing, in about 10 to 15 milliseconds on 2,500 objects (the limit was 300). It keeps working while the window is open, and on OK or Cancel it removes every temporary thing and puts the view back exactly. **One catch:** any zoom marks the drawing as "changed", so AutoCAD asks "Save changes?" when it is closed, as it does after any ordinary zoom. Also not yet shown: the window docked at the right (it floated).
**Completed:** (a) to (d) PROVEN, (e) PROVEN for a floating window, (f) PROVEN for the view and the temporary graphics, NOT PROVEN for the "drawing unmodified" check. **Not completed:** docking the window at the right side; a real click on the window's OK and Cancel buttons (they were closed by command). **Next:** try the docking settings and the button click; test an approach that moves the picture without marking the drawing changed.)

## Result for each point

1. **(a) Remember the current view: PROVEN.** The plug-in read the view (centre, height, width, twist) before doing anything. Log: `P (a) view remembered: centre 4380.3711,1240.3782 height 8.8821 width 31.3732 twist 0; DBMOD before = 0; objects in drawing = 2500`.
2. **(b) Zoom AutoCAD's own model space to a chosen set with a margin: PROVEN.** 20 chosen pipes in one block of the drawing; the view became centre 1434.5,859, height 217.76, width 769.17 (a 12 per cent margin round the set). Picture `p2_during.png`. The chosen set is found by scanning all 2,500 objects in the same step.
3. **(c) Light them up with temporary graphics that are not saved and change no object: PROVEN.** Each lit pipe got a thick blue outline copy drawn on top as temporary graphics (AutoCAD's transient graphics). The real pipes are untouched: the "changed" flag showed no object or table bits, only the view bit (see (f)). Picture `p2_during.png`: 20 blue-outlined pipes among the plain white ones.
4. **(d) Small temporary tags with a figure each: PROVEN.** A cyan figure ("1.2 L/s", "1.3 L/s" and so on) sits beside each lit pipe; they are temporary graphics too (same picture).
5. **(e) Keep working while the window is open: PROVEN for a floating window; docked at the right NOT PROVEN.** The window (an AutoCAD palette with a short summary and OK and Cancel buttons) opened and I panned and zoomed the drawing while it was open; the view changed and all 40 temporary graphics stayed (log `P (e) panned and zoomed in a little while the palette is open ... temporary graphics alive = 40`; picture `p2_pan_floating.png`). The palette opened floating at the top left and a command moved it to the right; the "dock right" setting reported "None", so docking was not achieved. A screen capture of it floating, with its OK and Cancel buttons, was seen but not saved as a file.
6. **(f) On OK or Cancel remove every temporary thing and put the view back exactly: PROVEN. Leave the drawing unmodified: NOT PROVEN.**
   1. **Removed and restored:** on OK all 40 temporary graphics were erased and the view put back: `view put back: centre 4380.3711,1240.3782 height 8.8821 width 31.3732 twist 0; same as remembered: True`, 0 ms. A first run on a different set (108 graphics) also restored exactly, in 2 ms.
   2. **The catch:** the "drawing changed" flag (DBMOD) went from 0 to 16 as soon as the view was changed, and stayed 16 after the view was put back; the tab shows a star and **AutoCAD asked "Save changes to ...?" when I closed it** (picture `p_quit_prompt.png`; I answered No). 16 is the view bit only; objects (bit 1) and tables (bit 2) were not touched. A plain AutoCAD zoom does the same. The changed flag cannot be set back to 0 (the setting refused). **A way round was not tried:** moving the picture without AutoCAD's own view change.
7. **Speed on 2,500 objects: PROVEN, well inside 0.3 of a second.** Start of command to the screen update with zoom, 20 lit outlines and 20 tags: **10 ms** (15 ms in the first run, 54 lit); Cancel or OK: 0 to 2 ms. This includes scanning all 2,500 objects.

## Second night run: can it avoid the save prompt, docking, a real click (18 Nov 20:20 to 21:05, test AutoCADs one at a time, all closed normally, test copy `p_2500.dwg`)

Pictures in `C:\CE_WORK\trials\zero\evidence\r011\`; logs `zt_run17_nosave.log`, `zt_run18_gs2.log`, `zt_run19_gs3.log`, `zt_run20_gs4.log`. The same test file opened directly each time, so the "drawing changed" flag (DBMOD) starts at 0. No setting, profile or registry value was written by me.

### A. The "Save changes?" catch

1. **A1. Temporary outlines and tags with NO view change: PROVEN not to mark the drawing.** 40 temporary graphics drawn: DBMOD before 0, after 0. With all 40 still alive and the window open, **AutoCAD closed with no "Save changes?" prompt** (the log `zt_run17_nosave.log`). The limit: with no view change the lit pipes are only visible if they are already in the current view.
2. **A2. Routes for the view change:**
   1. **The usual zoom (ZOOM command) and the editor's own current-view setting: both mark the drawing** (DBMOD 0 to 16, the tab shows a star, and AutoCAD asks "Save changes?" on close; picture `p_quit_prompt.png`, measured the night before).
   2. **The graphics-layer route: PROVEN not to mark the drawing.** The plug-in reads the live view into a graphics view, changes that and writes it back to the viewport with AutoCAD's own supported calls. DBMOD stayed 0 after the change and after putting the view back, the tab showed no star, and **AutoCAD closed with no prompt** after the lit set, the docked window, the zoom and the restore. It took 7 to 11 ms. The display did change (`q_gs2_view.png`: the whole drawing with the 20 lit pipes in blue; `q_gs3_during.png`, `q_gs4_during.png`: a zoomed-in part).
   3. **Putting the view back through the same route returns the original picture** (`q_gs3_back.png` matches `q_gs3_before.png`, both the plain start view). The editor's own readout of the view stayed at "centre 0,0" afterwards, so an exact figure comparison was not made: restore is PROVEN by picture only.
   4. **Zoom to the chosen set through this route: NOT PROVEN.** The zoom landed in the wrong place and at the wrong scale: asked for centre 1434.5,859, it showed a block centred near 2100,540 at about 1.5 times the intended scale (`q_gs3_docked.png`, `q_gs4_during.png`); the whole-drawing zoom of `q_gs2_view.png` worked. The way the graphics view maps to the drawing is not understood yet; reading the view back after each change and correcting it is the next step.
3. **A3. Setting the changed flag back to 0: not allowed.** AutoCAD refused to write DBMOD (`eInvalidInput`); no other route was tried. It is not needed with the graphics route.
4. **A4. What a user sees on close if the editor route is used:** the standard "Save changes to ...?" box with Yes, No and Cancel (picture `p_quit_prompt.png`), the same as after any zoom.

### B. Docking: PROVEN
The palette docked at the right edge with the drawing still usable and fully drawn beside it (`q_palette_dock.png`, `q_gs3_docked.png`), by two of the palette's own properties (the allowed sides set to Right, then Dock set to Right). Its "Dock" readout printed an odd "Left, Top, Right, Bottom" although the window sat at the right. **Saved state:** AutoCAD may remember where a palette sits; a read-only search of the profile area of the registry for the palette's name found nothing (0 matches), but a palette can be stored under a number instead of its name, so "nothing saved" is NOT proven. I changed no setting.

### C. A real mouse click on OK and Cancel: NOT PROVEN
With AutoCAD in front and the palette docked, three mouse clicks and one press and release on OK and Cancel only focused the button (it showed its focus outline, `q_palette_dock.png`); the plug-in's click handler did not run. Pressing the space bar on the focused OK did run it (log `Q C the OK button was clicked`). So the buttons work from the keyboard; whether Tim's own mouse clicks work was not tested, and my mouse tool may not reach this kind of window.

## What I could not do

1. Dock the window at the right edge (the dock setting stayed "None"); the docking settings of AutoCAD's palette were not explored.
2. Click the window's OK and Cancel with the mouse (I finished by command).
3. Run it on a drawing with xrefs or several viewports, or in paper space.

## Evidence

`p_before.png`, `p2_before.png`, `p2_during.png`, `p2_pan_floating.png`, `p2_after.png`, `p_after.png`, `p_quit_prompt.png`; logs `zt_run12_preview1.log`, `zt_run13_preview2.log`; test code `C:\CE_WORK\trials\zero\core2\Preview.cs`.
