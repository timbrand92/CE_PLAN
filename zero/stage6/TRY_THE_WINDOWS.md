# Try the windows: a ten-minute list for Tim

**Status, 18 Nov 2026, about 6:30 am: READY FOR TIM.** An independent tester (one that did not build them) drove all seven windows by real mouse and keyboard three times overnight. Third run: no wrong figure found; every figure checked by hand was right; 155 of 155 steps passed; every step on this page was followed and corrected. Written by the planning chat for checklist step 16 (Tim, D-087: "i cant give you full answer until using"). Built and tested only: nothing is installed, nothing is accepted.

## What this is

Seven real program windows on a test bench. They run on the real brain, so every figure is worked out, not drawn in. It is NOT AutoCAD: the picture on the left is a simple stand-in for the drawing, and OK does not draw anything. Nothing on your PC changes.

## How to open them

1. In File Explorer go to `C:\CE_CIVIL\bench\CeCivil.Bench\bin\Debug\net10.0-windows\`.
2. Double-click `CeCivil.Bench.exe`. A small chooser opens.
3. Pick a window. Cancel, the X or Escape closes it.

## Ten minutes, in this order

1. **Pipe (2 min).** Type a new grade: the downstream invert, the fall and the label follow. Now click the padlock beside the GRADE to let it go, hold the downstream invert, and type a new upstream invert: the grade becomes the one worked out. Then hold all three and read the red "out by" line. Look for: does it say what else changed, in words you would use?
2. **Pit (1 min).** Type a deeper depth until the step-irons line shows (deeper than 1.0 m). Pick a pit size from the list, then type one that is not on the list and read what it says.
3. **Levels along a run (2 min).** Type 5.15 at the connection, then press "Flatten all grades to 1 in 200". Then hold the invert out of P3 at 5.40 and work uphill: it must say "out by 0.22 between P3 and the connection" and must not change any grade. Look for: is it clear what is held and what is worked out along the whole run?
4. **Inlets (1 min).** Change the kind (downpipe, overflow, floor waste). Type a roof area, then let it go back to the measured one with the padlock.
5. **Tank (1 min).** Pick 3,000 L, then 10,000 L. Look for: the note text, the top water level, and the plain-words warning when the tank is too small. Then type your own diameter and height and read what it says.
6. **Detention (2 min).** Change the paved area. Watch the two answers side by side, Storage and Discharge. Switch between Boyd's and OSD4W on card 1. Make the storage short and read what it says.
7. **Pit schedule (1 min).** Type over one cover level: the cell is held, shows a padlock, and the depth follows. Click the padlock to let it follow the pit again.

Then try to break one. A comma instead of a point, or letters: it refuses in plain words and keeps the old figure. A negative or silly-large number: it takes it and marks it red "Wrong" or amber "Needs a look".

## What I need from you afterwards (five answers)

1. Is the order of the cards the order you think in? (yes / no, which window)
2. Is "hold what is fixed, the rest is worked out" clear from the padlocks alone? (yes / no)
3. Is anything on a window that you would never use, or missing that you use on every job?
4. Are the warnings in words you would say to a drafter?
5. Which window is furthest from right?

## Known cautions (so you do not report them twice)

**Update 7:20 am:** after the third trial the build chat fixed cautions 1 to 7 (commit 8c3dc05; its own reviewer passed them, 1,240 of 1,240 click steps). The independent tester has NOT re-checked those fixes, so they stay listed: if you still see one, say so.

1. **Levels, when over-held:** trust the "out by" words, not the long section. The drawing still puts the whole gap on one pipe, which your ruling D-125 says not to do. Being fixed.
2. **Levels:** card 1 has a small scroll bar and card 4's list of held figures is cut off. Your rule is no scrolling inside a window. Being fixed.
3. **Pit:** typing "350" alone is refused; "350 x 350" works. Being fixed.
4. **Pit window pipe labels** say UPVC whatever the material. The Pipe window is right.
5. **Detention:** the storage tile stops at the amount needed, so it does not show how much spare you have.
6. **Schedule:** a typed-over invert below zero is only amber, and a long remark runs past the table edge.
7. **When two warnings show at once,** the small sketch on the card shrinks to tiny type.
8. **Not in these windows by design, yours to decide:** a "what is over it" box in Pipe (so cover under a driveway cannot be tried yet), and a pipe size box in Detention.
9. **Pipe length cannot be typed:** in AutoCAD it comes from what you draw.
10. **Not checked by anyone:** the Boyd's "storage needed" figure (the tester had no rainfall table to check it by hand), and the tab order through the boxes.

## Changed 18 Nov 2026 afternoon: the Detention window (rainfall and council minimum runoff)

Not driven by the independent click tester yet. Not accepted.
1. **Six small boxes on the Storage tile** are the made-up job's own site rainfall, marked "given". The plug-in has no rainfall of its own.
2. **Empty all six:** storage reads unknown and card 3 says "Cannot work out yet: site rainfall not entered".
3. **Type your own estimate** (try 112, 85, 69.4, 51.5, 45.5, 40.9): the boxes go amber, read "assumed", and a line says "Rainfall assumed (APPROX.): replace it with the site's Bureau table". Storage never goes green on an estimate. Pick "given" under each box to make it the site's table.
4. **Council minimum runoff cannot be tried in the window yet** (there is no council box). A picture shows it: `C:\CE_CIVIL\bench\shots\bench_detention_1080_dark_D19_council_min_c.png` (Darebin, C 0.80, "Council minimum C governs").
5. **Known cautions on these new parts:** with no rainfall the Tank row's "unknown spare" is cut off; the Storage tile names the wrong reason; card 2 shows "419 / 600 = 0.80" when the council minimum governs; no APPROX. sits beside the needed figure; a non-number in a rainfall box goes amber with no words; you empty a box to let it go (no padlock). All with the build chat.
6. **Earlier caution 10 is out of date:** the Boyd's storage needed has now been checked by hand on two worked cases (2.65 m3 and 2.29 m3). Tab order is still unchecked.
