# Known problems and what to do instead

**DRAFT, Thu 22 Oct 2026.** This page is the honest list for Civil 3.0.70 / Manager 1.1.70. It comes from two independent reviews of 22 Oct 2026, one on engineering numbers and one on recent changes, plus the open bug list. Some items will be fixed before 9 Nov. The desk updates this page at the freeze. [CHECK: re-check every item against the frozen build]

**The one rule:** work on a copy of a job until Tim says otherwise. If a number looks wrong to you as an engineer, trust yourself and tell Tim.

---

## A. Double-click and editing

1. **Double-clicking a downpipe (DP1) does not open the Edit window yet** (BUG-859). AutoCAD's attribute editor opens instead, or nothing happens.
   - **Do this instead:** select the downpipe, type `CDEDIT`. The small Edit source window opens.
2. **Double-clicking a pit's number label opens AutoCAD's attribute editor,** not Edit Pit (BUG-430).
   - **Do this instead:** type `PITEDIT` or `CDEDIT` and pick the pit. Do not change the number in AutoCAD's editor.
3. **Double-clicking the green downpipe label opens plain text editing** (BUG-860).
   - **Do this instead:** select the downpipe symbol and type `CDEDIT`.
4. **REDO can be lost after you pick a pit,** seen in a freshly opened drawing (BUG-861; cause not yet found).
   - **Do this instead:** after `U`, type `REDO` straight away, before you click anything. Do not rely on REDO after switching drawing tabs (known AutoCAD limit).
5. **Renumber pits only in Edit Pit,** never in the Pit Schedule window (Tim's ground rule).

## B. Numbers to check by hand (engineering)

6. **CDRULES and CDCHECKS measure a pipe's grade pit centre to pit centre,** not along the drawn route. A bent pipe, or a pipe with a same-plan break, can show steeper than it really is and pass when it is too flat.
   - **Do this instead:** on any bent or broken pipe, check the grade on the drawn label against the minimum yourself.
7. **CDRUNSOLVE and the network redesign size every pipe as UPVC,** whatever material is drawn. A concrete line can be offered a size one step too small (about 23 per cent short at DN375).
   - **Do this instead:** do not accept proposed sizes for concrete pipes without a hand check.
8. **CDDESIGN's note says the office rainfall curve reads "7 to 9 per cent high".** On two real Glen Eira jobs it read 6 to 8 per cent low, so storage came out about 18 per cent short (2.12 m³ against 2.58 m³ on the issued sheet).
   - **Do this instead:** for OSD storage, use the site's own rainfall and check the figure against the office method before anything is issued.
9. **Cover is measured to the inside top of the pipe, and only at the two pits.** The pipe wall is ignored: about 20 mm on UPVC 225 and about 45 mm on concrete 375. A low spot between pits (such as a garden bed or driveway) is never checked.
   - **Do this instead:** add the wall thickness, and check cover where the surface dips between pits.
10. **The Pit Schedule measures depth to the outlet pipe, not the pit floor.** Tim ruled pit floor on 20 Oct, and the fix is queued (BUG-869). The schedule can say no step irons when CDRULES says they are needed.
    - **Do this instead:** for step irons, go by CDRULES, or work the depth from the pit floor yourself.
11. **Moving a pit on a pipe with a held grade can make the pipe slightly flatter** (1 in 100 becomes 1 in 102).
    - **Do this instead:** after moving a pit, read the grade label. If it is flatter than intended, retype the downstream level in CDEDIT.
12. **The pit drop check compares inverts only.** A 150 into a 300 can pass while the 300's top sits higher than the 150's top.
    - **Do this instead:** where the pipe gets bigger at a pit, match the pipe tops (obverts) yourself.
13. **The Inspector palette and CDRULES can disagree on the same pipe** (different minimum grade and cover).
    - **Do this instead:** go by CDRULES and tell Tim about the difference. [CHECK: Tim to confirm which one is right]
14. **CDTWL on a drawing set in metres** counts pipe storage 1,000 times too small. On any drawing it can count a little water twice (about 4 per cent).
    - **Do this instead:** use millimetre drawings for CDTWL, and check the storage total by hand.
15. **CDCALC's Boyd's tab and CDDESIGN use different hard-ground runoff C,** so the same site gives two storage figures.
    - **Do this instead:** note which one you used, and tell Tim if they differ.
16. **The CDDESIGN storm list jumps from 5 to 10 minutes,** so storage can come out 2 to 3 per cent low.
    - **Do this instead:** add a small margin, or check a 6 to 8 minute storm by hand.
17. **The grade label ignores which way the levels fall.** A pipe running uphill still reads "1 IN 100". Only CDRULES says "flows uphill".
    - **Do this instead:** run CDRULES before issue.
18. **A drawing with no units set is read as millimetres.** A unitless drawing drawn in metres gives nonsense grades.
    - **Do this instead:** type `UNITS` and set the drawing units before you use CE.
19. **X-Civil import drops levels above RL 250 m.**
    - **Do this instead:** on a high site, check the imported levels against the source.
20. **CDCALC number boxes read "0,35" as 35.**
    - **Do this instead:** always use a full stop for decimals.

## C. Labels and display

21. **"No clear spot" labels are left where they are.** Move them by hand. Tim ruled this on 20 Oct.
22. **Some start-up lines look like errors:** "Menu item failed to load: CE_..._MENU" and "; error: syntax error". They are harmless and the CE tabs still work. [CHECK: whether they still appear on 3.0.70 on a clean PC]

## D. Keyboard and AutoCAD habits

23. **In a CE drawing, F2 runs the CE command CLEAN, not the text window.** Do not press F2 expecting to save or read history. Save with Ctrl+S. To read the whole command line, type `TEXTSCR`, then `GRAPHSCR` to come back. [CHECK: still true on 3.0.70]
24. **Anything you type between `U` and `REDO` ends REDO.** That is AutoCAD's own rule. A zoom or REGEN also takes its own Undo step, so read the U line.

## E. Manager buttons to leave alone

25. **Roll Back Release:** do not press it. Go back by hand (page 02, section 7).
26. **Get update ready, or any update button:** do not press it. Updates come by hand for now (page 02, section 5).
27. **Set up CE administrator, and any "become administrator" question:** always answer No. Only Tim is the CE administrator.
28. **The Manager fault report and diagnostic buttons:** use `CESUPPORT` instead (page 05). [CHECK: whether BUG-488 coding is complete in 1.1.70]

## F. Things only Tim sees (no action for you)

29. **The new "Command outcome" log line says "cancelled"** for a PIT, CD or DP run that worked and was finished with Esc. It only affects the log, not your drawing. Tim's tools read around it.
30. **CDCHECKIGNORE** is switched off. If you type it, it says "Nothing was changed", but it still re-saves CE's record in the drawing. Do not use it.
