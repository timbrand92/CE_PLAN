# R-007 The bug carpark, sorted once (revision 1)

**Why:** Tim, 18 Nov 2026: "WE HAVE OVER 1200 BUGS AND MILLIONS OF IDEAS ON THE CARPARK I FEEL IT WOULD BE IMPOSSIBLE TO RESOLVE ALL OF THIS HENCE THE NEW PLAN", then "RUN THE SWEEP" (D-206).
**What was done:** read-only. Every open or in-progress entry in `C:\CE_PLAN\BUG_CARPARK.md` (1,295 of 1,410 entries) was cut down to its title, area, symptom, expected behaviour and cause, split into six parts, and each part sorted by a separate helper (Sonnet) into one of five piles. Nothing in the carpark was changed, closed or deleted by the sweep. The line-by-line results are in `C:\CE_WORK\scratch\zero_study\BUG_sweep\result_1.txt` to `result_6.txt` (local only).
**How far to trust it:** the sorting was done from cut-short text, by judgement, once. Most lines are marked medium confidence. The pile sizes are a fair picture; any single bug's pile may be wrong. Nobody re-checked the sorting.

## 1. The count

1. **A, would happen again in the new plug-in unless designed or tested against:** 597 (46 in every 100).
2. **B, dies with the old build** (the special pipe object, facts held in several places, the old installer and updater, old windows and names, AutoCAD 2022 to 2026): 256 (20 in every 100).
3. **C, about something outside the new first release** (mostly structural-only tools, the import tools, title block, council calculators): 399 (31 in every 100).
4. **D, stops daily work now in the installed plug-in:** 15.
5. **E, not a product bug** (test or paperwork entries): 28.
Total 1,295.

## 2. What that says

1. The new design removes about one bug in five by itself. Not most of them. That is less than the planning chat expected and it is said plainly.
2. Nearly half the open bugs are about real use and would come back in ANY plug-in that did not design for them. They are the most useful thing the old plug-in has left behind: 597 worked examples of how drafting breaks a drainage tool.
3. About a third are parked with the tools they belong to (structural, imports) and stay parked.
4. Only 15 genuinely stop work today.

## 3. The lessons that keep recurring (pile A, merged across the six parts; counts are approximate because the helpers worded lessons differently)

1. **Drawing units, scale and paper against model:** every distance and size respects the drawing's units and the sheet's scale; metre and millimetre drawings both tested. About 44 bugs.
2. **Plain words:** messages, help and results say exactly what happened in drafting words, never a handle, a code or a file path, and never claim "done" when it was not. About 53 bugs.
3. **One value, one place, read by every tool:** council and office figures come from one list with their source; a check that cannot run says so. About 46 bugs.
4. **AutoCAD's own protections and behaviour:** locked layers, xrefs, reference editing, paper space; refuse before writing anything and name the layer; never change shared layers, styles or settings and leave them changed. About 35 bugs.
5. **Labels:** sit clear of pits, pipes and each other at every angle; a label moved by hand stays where it was put. About 28 bugs.
6. **Unknown stays unknown:** never zero, never an invented default, never a false green tick. About 26 bugs.
7. **Move, copy, paste, mirror, array, Save As:** parts stay with their object; a copy has its own identity and never takes the original's labels. About 22 bugs.
8. **Undo, redo, cancel:** one action is one undo step; redo survives; Cancel, Escape and the window X change nothing. About 25 bugs.
9. **Typed and held values are never silently overwritten, rounded or switched.** About 21 bugs.
10. **Levels and the long section:** keep the pit drop, use the lowest arriving pipe, warn on back-fall, draw each pipe's own size and grade. About 22 bugs.
11. **Pit schedule:** rows keyed to the pit, in order, no false "changed", across drawings and xrefs. About 19 bugs.
12. **Engineering sums use the real geometry and the real material.** About 10 bugs.
13. **Windows fit the screen, remember where they were, and double-click opens ours only on our objects.** About 11 bugs.
14. **Privacy:** fault reports, logs and drawings carry no login, PC name or file path. About 8 bugs.
Most of these are already rules of the new design (the foundation, the UI plan, `design\SITUATIONS.md`, Tim's rulings D-162 to D-196). The ones not yet written down anywhere in the new plan: item 1 (units and scale as a test on every tool), item 14 (privacy of fault reports), and "never change a shared layer, style or setting and leave it changed" in item 4.

## 4. The 15 that stop work now (as sorted; each needs a look before anyone acts)

1. BUG-1456: Help and Settings overwrite another job's stored CE data.
2. BUG-1457: CLEAN and FASTSAVE overwrite the office template file.
3. BUG-1276: no backup written for hours; risk of lost work.
4. BUG-411: the F2 key runs CLEAN and rewrites the open drawing.
5. BUG-1278 and BUG-1461: native hatches cannot be edited normally with the plug-in loaded (two entries, possibly one fault; cause not proven to be the plug-in, see R-006).
6. BUG-224: AutoCAD closed after Save As (whether CE causes it was never established).
7. BUG-1275: AutoCAD closes when placing a steel beam section.
8. BUG-866: rainfall note claims the curve is high; storage about 18 per cent short on issued sheets.
9. BUG-1095: council minimum runoff figure ignored; tank undersized by about a quarter.
10. BUG-965: schedule refresh changes "2/375" twin tanks to "375".
11. BUG-561: changing a pit number swaps grated and solid cover on the sheet.
12. BUG-756: long section top line drawn one pipe size too big before a size increase.
13. BUG-668: moving or rotating a run puts pipe callouts in the wrong place (from reading code, not seen in AutoCAD).
14. BUG-1459: pipes vanish for people without CE (a fix is built, not installed).
Items 8 and 9 are wrong engineering figures on sheets that go out, the most serious kind. Several entries already say a fix is built or installed; that has not been checked here.

## 5. What is proposed (not yet ruled by Tim)

1. Freeze the carpark as the old plug-in's list; in the old plug-in fix only the list in section 4, after each is confirmed real.
2. Turn the lessons of section 3 into the new plug-in's standing tests, one test family per lesson, so each new tool is run against all of them.
3. Keep pile C with the tools it belongs to, to be read when those tools are designed.
4. Start the new plug-in's own bug list empty, with ID numbers (D-205) and the rule that nothing new is built while a ribbon tool is broken (D-090).
5. Sort the ideas inbox the same way, later.
