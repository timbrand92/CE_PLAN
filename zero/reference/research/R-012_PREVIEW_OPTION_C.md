# R-012. Preview option C: a window beside the real drawing that zooms to a system and lights it up (Tim's open choice, D-297)

Written Wed 18 Nov 2026, about 18:50, by the trials chat. Tested in AutoCAD 2027 on a made-up 2,500-object drawing (`p_2500.dwg`: 2,000 pipes and 500 text labels, in a test folder), one test AutoCAD at a time, Tim's CE plugins loaded as always, closed normally with No to saving. Pictures are in `C:\CE_WORK\trials\zero\evidence\r011\`. No web addresses.

**Morning line for Tim: answer first.** Yes, the real drawing can do option C. The plug-in can remember the view, zoom AutoCAD's own drawing to a chosen set of pipes with a margin, light them up with temporary outlines and put small figure tags beside them, none of it saved in the drawing, in about 10 to 15 milliseconds on 2,500 objects (the limit was 300). It keeps working while the window is open, and on OK or Cancel it removes every temporary thing and puts the view back exactly. **One catch:** any zoom marks the drawing as "changed", so AutoCAD asks "Save changes?" when it is closed, as it does after any ordinary zoom. Also not yet shown: the window docked at the right (it floated).
**Completed:** (a) to (d) PROVEN, (e) PROVEN for a floating window, (f) PROVEN for the view and the temporary graphics, NOT PROVEN for the "drawing unmodified" check. **Not completed:** docking the window at the right side; a real click on the window's OK and Cancel buttons (they were closed by command). **Next:** try the docking settings and the button click; test an approach that moves the picture without marking the drawing changed.

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

## What I could not do

1. Dock the window at the right edge (the dock setting stayed "None"); the docking settings of AutoCAD's palette were not explored.
2. Click the window's OK and Cancel with the mouse (I finished by command).
3. Run it on a drawing with xrefs or several viewports, or in paper space.

## Evidence

`p_before.png`, `p2_before.png`, `p2_during.png`, `p2_pan_floating.png`, `p2_after.png`, `p_after.png`, `p_quit_prompt.png`; logs `zt_run12_preview1.log`, `zt_run13_preview2.log`; test code `C:\CE_WORK\trials\zero\core2\Preview.cs`.
