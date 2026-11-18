# R-012. Preview option C: a window beside the real drawing that zooms to a system and lights it up (Tim's open choice, D-297)

Written Wed 18 Nov 2026, about 18:50, by the trials chat. Tested in AutoCAD 2027 on a made-up 2,500-object drawing (`p_2500.dwg`: 2,000 pipes and 500 text labels, in a test folder), one test AutoCAD at a time, Tim's CE plugins loaded as always, closed normally with No to saving. Pictures are in `C:\CE_WORK\trials\zero\evidence\r011\`. No web addresses.

**Morning line for Tim (fourth night run): answer first.** Lighting up the parts where they are, with no view change, works in every case I tried: off the edge of the screen, switched off or frozen layers, a turned UCS, a layout viewport and paper space; it takes 1 to 9 ms on 2,500 objects and never marks the drawing. The "Zoom to it" button (AutoCAD's own zoom with a margin, 40 ms) then marks the drawing as changed, so AutoCAD asks "Save changes?" when it is closed, and AutoCAD's own ZOOM Previous puts the old view back exactly and keeps working. The one-byte profile difference is AutoCAD re-saving its own palette positions: the same thing happens in a plain session, and nothing in the profile mentions my window.
**Completed:** items 1, 2 and 4 (PROVEN as below; one case NOT TESTED). **Not completed:** paper space with no viewport at all.
**Next:** build the preview on this plan: light up in place, "Zoom to it" does an ordinary zoom only on request.

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

## Fourth night run (19 Nov 23:50 to 00:20): light-up where it is, "Zoom to it", the profile byte

Test copy `p_2500.dwg` (2,500 objects) with a docked panel; three test AutoCADs one at a time (a plain session, then the main session), closed normally with No to saving. No function keys or shortcuts were used (one stray typed word is disclosed under item 3 in R-011). Pictures in `C:\CE_WORK\trials\zero\evidence\r011\`; logs `zt_run26_item1a.log`, `zt_run27_items123.log`; profile text copies in `evidence\profile_snap\text\`.

**Morning line for Tim (fourth night run): answer first.** Lighting up the parts where they are, with no view change, works in every case I tried: off the edge of the screen, switched off or frozen layers, a turned UCS, a layout viewport and paper space; it takes 1 to 9 ms on 2,500 objects and never marks the drawing. The "Zoom to it" button (AutoCAD's own zoom with a margin, 40 ms) then marks the drawing as changed, so AutoCAD asks "Save changes?" when it is closed, and AutoCAD's own ZOOM Previous puts the old view back exactly and keeps working. The one-byte profile difference is AutoCAD re-saving its own palette positions: the same thing happens in a plain session, and nothing in the profile mentions my window.
**Completed:** items 1, 2 and 4 (PROVEN as below; one case NOT TESTED). **Not completed:** paper space with no viewport at all.
**Next:** build the preview on this plan: light up in place, "Zoom to it" does an ordinary zoom only on request.

### Item 1. Light-up with no view change, as it will be used (each case: 20 pipes lit with outlines and tags)

1. **On screen (reference): PROVEN.** 7 ms, the changed flag unchanged. Picture `s1a_onscreen.png`.
2. **Partly off the edge of the screen: PROVEN.** 2 ms. The outlines and tags are cut cleanly at the edge of the drawing area (a tag reads "L/s" where its start is off the left edge); nothing odd or stray at the edges (`s1b_partly_offscreen.png`).
3. **Wholly off screen: PROVEN.** 3 ms; nothing visible, no error (`s1c_fully_offscreen.png`).
4. **A layer frozen or switched off: PROVEN, with a point to decide.** Half the pipes were moved to a layer of their own (the layer change itself is a drawing edit, the flag went 16 to 17 there). With that layer **frozen or off, the real pipes vanish but the light-up still draws their outlines and tags** (`s1e_layer_frozen.png`, `s1f_layer_off.png`; 9 ms and 2 ms): ghost outlines where the hidden pipes are. A build must choose: show them (as tested) or skip hidden layers.
5. **UCS turned 30 degrees: PROVEN.** The outlines and tags stay on the pipes (world coordinates, not the turned UCS), 1 ms (`s1g_ucs30.png`; the UCS command changed the drawing's flag to 21, not the light-up).
6. **In a layout viewport with model space active: PROVEN.** In Layout1 with a floating viewport the lit set shows inside the viewport at the right place (cyan tags at the centre of the picture, `s1h3_layout_plain.png`), 2 ms.
7. **In paper space, with the viewport on the sheet: PROVEN.** Switching to paper space and lighting again, the lit set again shows inside the viewport at the right place (`s1i2_crop.png`), 4 ms; Layout2 with its viewport did the same (screen capture, not saved: the window picture tool stalled on that layout).
8. **Paper space with no viewport at all: NOT TESTED** (both layouts had a viewport).
9. **2,500-object drawing:** every case above ran on it; the slowest was 9 ms.
10. **Side effect to know:** the changed flag in this session was already 16 or more from my own set-up (zoom windows, layer move, UCS), so "the light-up did not change it" is shown by before and after readings on each line of the log (`DBMOD before 29, after 29`).

### Item 2. "Zoom to it"

1. **Zoom to the set with a margin: PROVEN.** AutoCAD's own ZOOM window with a 12 per cent margin round the lit set: 40 ms; the view became centre 1434.5, 859, height 217.76 (picture `i2_after_zoomto.png`).
2. **Putting the previous view back: PROVEN with AutoCAD's own ZOOM Previous.** After the zoom, ZOOM Previous returned exactly the view before (centre 400, 200, height 200.2528, identical to the reading before the zoom; `i2_after_zoom_previous.png`). A second ZOOM Previous went one step further back to an earlier view (centre 1473.7, 889.6): AutoCAD's own view history still works afterwards.
3. **What the user sees on close:** the drawing's flag goes up on the first ordinary zoom and AutoCAD asks "Save changes to ...?" with Yes, No and Cancel, the same as after any zoom (pictures `i2_save_prompt_on_close.png` and the earlier `p_quit_prompt.png`; I answered No). **Putting the view back does not clear it** (the flag stays raised, as measured before).

### Item 4. The one-byte profile difference, read only

1. **How:** text copies of `Profiles\tim\profile.aws` in my own folder: before anything (P0, 88,332 bytes), after a plain session with the plug-ins loaded and no window of mine (P1, 88,333), after the main session with the docked panel, lit sets, layouts and tests (P2, 88,334). Nothing was written to the profile.
2. **What the difference is:** a character-level comparison shows the changes are all in AutoCAD's own palette layout: the dock position numbers of the Tool Palettes and Properties bars (for example `Left="3079518"` becoming `"3079513"`, then `"3081413"`; `Top="283848"` becoming `"284269"`) and the order of a few property-palette entries. The plain session (P0 to P1) makes the same kind of change, and the docked session (P1 to P2) another. The extra byte is a longer or shorter number, not an entry.
3. **My window:** the word "ZT" appears **0 times** in P2: no entry for my panel in the profile file. **PROVEN: the byte is AutoCAD re-saving its own dock numbers, also in a plain session; the docked panel left no entry.** The registry tree was already shown unchanged (0 lines) the night before.

## Third night run (18 Nov 23:15 to 23:45): zoom arithmetic, profile files, panel and events

Test copy `p_2500.dwg` (2,500 objects), one test AutoCAD at a time, all closed normally with No to saving. Pictures in `C:\CE_WORK\trials\zero\evidence\r011\`; logs `zt_run22_cal.log`, `zt_run23_item3.log`; snapshots of the registry and profile files in `C:\CE_WORK\trials\zero\evidence\profile_snap\`.

**Morning line for Tim (third night run): answer first.** The zoom arithmetic is fixed for the lights and tags (they land centred, to within 2 pixels, on three different sets, in 1 to 7 ms, with the drawing still unmarked), but **the drawing's own picture does not follow that view change**, so the real pipes do not line up with the lit outlines: the graphics-layer route cannot show the system on its own. The ordinary zoom (which marks the drawing) lines up correctly. With a narrow docked panel open, the lit pipes and tags stay correct through pan, zoom and REGEN and vanish on Escape, on closing the panel, on switching drawing tab and on closing the drawing, with no leftovers. Docking did not change the registry (0 lines) and the profile file holds no entry for my window.
**Completed:** items 2 and 3 (PROVEN as below), item 1 arithmetic. **Not completed:** getting the drawing's own picture to follow the graphics-layer zoom (NOT PROVEN, probably not possible this way); the 1-byte change in one profile file (cause not known).
**Next:** use AutoCAD's own zoom (and accept the save prompt), or move the view by another supported route, or keep the preview inside the window (option B); read the profile file content before and after a docked session.

### Item 1. Zoom arithmetic on the graphics route (three sets)

1. **What was wrong and what fixed it:** the earlier code took the proportions and orientation of the view from the editor's view record, which does not match the live graphics view. Taking them from the graphics view itself (its own up direction, back distance and field proportions) and reading the view back after each change fixed the lights.
2. **Result, three sets (A a block of 20 pipes near x 1200, B 20 near x 120, C 25 near x 2300):** two marks placed at the intended centre and 100 units to the right landed on the middle of the drawing area within 0.5 to 2 pixels of the centre, and at the intended scale within 2 per cent after at most two corrections (set B needed 1.02 times and a 2 unit shift; A and C needed none). 1 to 7 ms. DBMOD stayed 0 throughout. Pictures `r_A_0.png`, `r_B_0.png` to `r_B_2.png`, `r_C_0.png`.
3. **The catch: the drawing's own picture did not follow.** In all three pictures the real pipes and labels shown are a different part of the drawing (for example "PIPE 785" to "PIPE 635" for set A, "PIPE 1245" to "PIPE 1395" for set C) and the lit outlines are not beside the marks. The graphics-layer change moved only the temporary graphics; the drawing itself drew from another view. **So "the chosen set lands centred with a margin on the real drawing through this route": NOT PROVEN.** Using AutoCAD's ordinary zoom the lit outlines and pipes line up (`i3_1_panel_lit.png`) but that marks the drawing as changed.
4. **Closing:** with the graphics-layer change and the lit set alive, AutoCAD still closed with no "Save changes?" prompt (earlier run).

### Item 2. Where AutoCAD keeps the dock state, read only

1. **Where I looked:** the whole registry tree `HKCU\Software\Autodesk\AutoCAD\R26.0` (exported to a file in my folder, 1,311 lines) and the profile and support files under both AutoCAD 2027 folders of the user profile (64,676 files, sizes and times). Nothing was written to either.
2. **Three snapshots:** before anything (S0), after a plain control session with the plug-ins loaded and no window (S1), after the session with the docked windows, the lit sets, the tab switch, the drawing close and the double-click tests (S2).
3. **Registry: PROVEN UNCHANGED.** S0 to S1 and S1 to S2 both differ by **0 lines**.
4. **Profile files:** in both sessions AutoCAD itself rewrote the same five files at exit (the start-up file, `acad.CUIX` and its backup, `FixedProfile.aws`, `Profiles\tim\profile.aws`) and one recent-blocks file. So **a plain session with no window of mine also rewrites them.** `profile.aws` (a text file, the profile's own settings) changed by one byte after the docked session (88,333 to 88,332 bytes; the plain session had changed it too). I did not keep a copy of its text, so **whether that byte is the window's doing is NOT PROVEN**. A text search of the current `profile.aws` for my windows' names found nothing, and a search of the registry snapshot found nothing, so **the window's dock position is not stored under its name in either place: PROVEN for names, NOT PROVEN for any other form.**
5. **What changed in the profile, plainly:** nothing that I wrote; AutoCAD's own exit rewrite. If Tim wants certainty, the next run should keep a copy of the text of `profile.aws` before and after.
6. **A slip, disclosed:** while looking for AutoCAD's text window I pressed the F2 key; in Tim's workspace it started AutoCAD's CLEAN command ("CLEAN Nested items = Off Orphaned data = Off") on the test copy. I pressed Escape at once and the command line showed "*Cancel*"; no command was left running. The drawing's changed flag read 4 afterwards (a drawing variable); the registry snapshot taken after shows no change.

### Item 3. Narrow docked panel and the events: PROVEN

A panel was docked at the right (AutoCAD's smallest allowed width, 279 pixels, not the 180 asked for), 20 pipes lit with blue outlines and 20 cyan tags (`i3_1_panel_lit.png`, the drawing still usable and aligned beside the panel, zoomed with AutoCAD's ordinary zoom). Counting the cyan tag pixels in pictures:

1. **Pan: stays** (2,087 then 2,095 pixels). **Zoom in 1.3 times: stays** (1,671). **REGEN: stays** (1,671). Pictures `i3_2_after_pan.png` to `i3_4_after_regen.png`. (The blue outline count by colour failed because AutoCAD draws the highlight in a lighter blue; the tag counts and the log are the evidence.)
2. **Escape key: removed.** Log "cleared 40 temporary graphics because: the Escape key was pressed"; the tag pixels went to 0 (`i3_5_after_escape.png`).
3. **Closing the panel: removed** (log "because: the panel was closed", pixels 0, `i3_7_panel_closed.png`). The panel was closed by the same property the close button sets (hidden), not by clicking its close button.
4. **Switching drawing tab: removed.** A second drawing was opened into the same AutoCAD; log "because: the drawing tab was switched away"; after switching back the picture was clean (`i3_8_after_tab_switch.png`).
5. **Closing the drawing: removed.** Log "because: the drawing was closed; temporary graphics alive = 0" and the other drawing showed none.
6. **No leftovers in any case:** the plug-in's own count of temporary graphics read 0 each time.

## What I could not do

1. Dock the window at the right edge (the dock setting stayed "None"); the docking settings of AutoCAD's palette were not explored.
2. Click the window's OK and Cancel with the mouse (I finished by command).
3. Run it on a drawing with xrefs or several viewports, or in paper space.

## Evidence

`p_before.png`, `p2_before.png`, `p2_during.png`, `p2_pan_floating.png`, `p2_after.png`, `p_after.png`, `p_quit_prompt.png`; logs `zt_run12_preview1.log`, `zt_run13_preview2.log`; test code `C:\CE_WORK\trials\zero\core2\Preview.cs`.
