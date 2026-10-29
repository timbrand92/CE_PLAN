# Tim's own accepted everyday tools, by name (written Fri 30 Oct 2026 06:21 Melbourne by CE 03, the hand-testing partner)

Source: C:\CE_PLAN\areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md, items 27 and H1 to H57 (Thu 29 Oct 2026, Tim's own AutoCAD, Civil 3.0.85 / Manager 1.1.85 / Structural 1.0.125, scratch drawings). Only Tim's own words are listed as acceptance. Tim's rule: his testing counts if he chooses to do it (RULE 16).

## WHOLE: 25 tools Tim accepted by hand (count each once)
1. **D01 PIT and CD keep placing until Esc.** PIT half H1 (his words read as pass), CD half H2 ("pass").
2. **D02 pit catch.** H9b "passed" (90 mm caught, 110 mm free; the exact 100 mm line itself not tried).
3. **D03 a new pipe joins the pit at its end.** H15 "yes".
4. **D04 Esc at CD's third point cancels the pipe.** H24 "pass".
5. **D06 Show grade in pipe text can be turned off.** H20 "d06 pass" (the tickbox lives under More...; Tim dislikes that, design change approved).
6. **D07 downpipe and raingarden before any pipe exists.** H30 "pass d07" (tag numbers not shown on the plan: BUG-1242).
7. **D09 pit label and cover text.** H15 "yes".
8. **D10 pipe label reads "100 DIA. UPVC PIPE AT 1 IN 200".** H15 "yes".
9. **D11 short pipe label on a leader.** H25 "d11 pass".
10. **D12 one IL text at each pipe end.** H15 "yes".
11. **D14 ERASE a pit keeps its pipes, U restores.** H5 "pass".
12. **D15 COPY a pit gets its own number.** H6 "pass".
13. **D16 EXPLODE a pit leaves the schedule, U restores.** H4 ("p11 no longer in pitschedule after explode then u brings it back. pipes remained unharmed").
14. **D17 CDEDIT keeps the selection.** H17 "yes" (from his own use).
15. **D18 CE never saves the drawing.** H27 "d18 pass" (close with an unsaved change: AutoCAD asked about saving).
16. **D20 CDRENUMBER.** H14 "passed" (preview, Yes and U; the No path was optional and not reported).
17. **D21 Pit Schedule natural order.** H16 "yes".
18. **D23 Excel export of the Pit Schedule with a Checking sheet.** H26 "pass" (Checking sheet read by CE 03 from his file).
19. **D24 office layers, current layer never changes.** H16 "yes".
20. **D26 CDSL shows the survey level, asks the proposed level.** H17 "yes"; again with the stored survey H51 "pass".
21. **D27 CDSYNC and CDREBUILD each warn first.** H11 "passed" (warn-first half; U not typed).
22. **D28 CDCHECKDWG summary line and results list.** H23 "cdcheckdwg passed".
23. **D29 CDFEEDBACK Cancel prints one line.** H17 "yes" (from his own use).
24. **D30 own ribbon tab on selecting a pit or pipe.** H18 "d30 - pass".
25. **Recover Inverts (spec card C38).** H3 "pass" (the one-end-only warning not seen).

## HALF: kept out of the whole count
1. **D19 every CE step undoes under its own command name.** U after PIT (H7) and after MOVE (H10) passed; the CD [Undo] sentence half is NOT tested (needs its Undo switch ON). Tim has not passed the whole card.

## REFUSED OR NOT PASSED by Tim: do not count
1. **D08 OF and FO use one symbol with their own tags.** NOT passed (H12): the FO symbol reads OF (BUG-1236). Tim's later answer: FO gets its own label and tag.
2. **D05 recent diameters, materials and inverts as one-click buttons.** Tim "no" (H16), BUG-1238.

## NOT COUNTED (no pass word, open, or not testable yet)
1. **D22 long Pit Schedule.** Tim ruled one table that keeps growing (decisions item 89): the card changes, so no pass.
2. **D13 hand-placed label stays, Tidy labels, D19's CD [Undo] half:** need a Settings switch turned ON (not run).
3. **D25 existing and demolished layers:** not built.

## Which of the 25 later had a bug found on it (Tim has NOT withdrawn any acceptance)
1. **D10:** BUG-1239, the label sits about 450 units off the middle of the pipe ("450 is wrong im telling you"), found after his "yes".
2. **D07:** BUG-1242, the DP, OF, FO and RG tags show no number on the plan.
3. **D14, D15, D16:** BUG-1231, eight repeated "Pit schedule cell for C1 not updated" lines after each of these commands (they worked as the card says).
4. **D15 and the copied downpipe:** BUG-1246 is a different object (CR of a downpipe keeps its tag DP2), not the pit copy Tim accepted.
5. **D20, D27:** halves noted above (No path and U not reported).
Nothing else: no accepted tool was later refused by Tim.

## Plan items Tim also passed (NOT among the 40)
Manager Status tab, CEHEALTH, Support Bundle, Diagnostics, Open Logs, Move + Rotate and Copy + Rotate on an ordinary object, CDSURVEY with Survey Review, quick MOVE of a pit (card C41). Settings tab and the five other Manager tabs "look right / all good" (no pass word). Not passed: Updates & Rollback (BUG-1247), Refresh (BUG-1244), Inspector on a pit (half passed: BUG-1249, BUG-1240), Move + Rotate on a raingarden (BUG-1245), the Version window (skipped, being retired).
