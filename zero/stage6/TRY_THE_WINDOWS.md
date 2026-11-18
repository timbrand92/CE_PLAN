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

## Changed 18 Nov 2026 evening (the fix-first round; not yet driven by the independent click tester; not accepted)

Do not judge the LOOK of these windows any more: the approved look is `design\STYLE_APPROVED_18NOV.md` and the windows are brought to it as each is next touched. These lines are about the figures.
1. **Detention opens at** "Storage 1.70 m3 of 1.64 needed, 0.06 spare" (tank 1.00 + pipes 0.56 + P1 0.08 + P2 0.06). The spare is the site's, shown once; the tank row has no spare of its own. When short it says "Short" with the amount.
2. **Empty all six rainfall boxes:** Storage reads 1.70 "of Not known needed", and the tile, card 3 and the strip say "Cannot work out yet: site rainfall not entered."
3. **Type your own rainfall estimate:** "1.70 of APPROX. 2.33 needed, Short 0.63"; card 3 "Needed APPROX. 2.33".
4. **Council minimum runoff governing:** card 2 shows "419.00 / 600.00 = 0.70" plus "Council C 0.80 governs". Known: at 1080 that extra line pushes the card's bars off; to be moved.
5. **Boyd's now rounds the inflow first,** as the office sheet does: the measured job gives 1.66.
6. **Pipe:** a grade of -50 or 0 shows red Wrong; the fall and downstream invert read not known; no "Moves" line. While held levels clash, card 3 lists the two levels with no sum.
7. **Levels:** grade 1 in 0 says "Cannot draw the long section ... a grade must be above 0." Known: the big answer still shows a cover figure there.
8. **Inlets:** a 150 inlet on a 100 pipe leaves the label at 100 DIA. and shows amber "Check: 150 inlet on a 100 pipe."
9. **Tank:** a diameter and height that do not hold the size show amber "cannot say the tank holds the 1,000 L needed ... out by 4,123 L", never green; the note never shows a negative figure.
10. **Schedule:** a typed level below 0.00 is amber "check the datum"; the depth worked from it is ringed amber with a "Check" line. Known: the sheet preview still prints that depth plain (Tim's call whether the sheet gets a mark).
11. **Pit:** lid class lines on card 1 ("Over it", "Lid class", "Lid on the schedule"); a junction pit reads Solid; pump kinds read "SPS grated" and "SPS solid". The Match button and the Turned box are hidden in the AutoCAD tools until built; the bench still shows them.
12. **Earlier cautions 4, 5 and 6 on this page are fixed** (pit labels read the right material; the tank counts at its full room; below-zero levels are amber).

## Stale lines above, noted 18 Nov 2026, 8:39 pm (round 43, not yet committed by the build chat; this page is rewritten when the windows are next offered to Tim)

1. **Tank steps:** "Pick 3,000 L, then 10,000 L" and "type your own diameter and height" are out of date. The Tank window now opens as a 5,000 L slimline, 3.10 by 1.02 m; the size list is the office's own tanks, 2,500 to 6,000 L; a size off the list reads Shape "Not known"; the round "out by" case needs Round picked and a diameter and height typed.
2. **Wording:** every "unknown", "not known" and "unknown spare" on this page now reads "Not known" on the windows (Tim's screen rule 24).
3. **Detention:** the rainfall line shows once, not twice. **Pit:** "Lid on the schedule" reads "Not known" until a situation or class is given.
4. **Step 3 of the ten-minute list is wrong (found by the Codex live test, 19 Nov):** "out by 0.22 between P3 and the connection" belongs to the window as it OPENS. After "Flatten all grades to 1 in 200" the same hold at 5.40 gives about 0.11 (0.115). Read the step as: hold the invert out of P3 at 5.40 before flattening and expect 0.22; after flattening expect about 0.11. Known fault there, being fixed: clicking the Uphill button when it is already on drops the held level.
