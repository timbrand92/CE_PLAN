# Seven design cards: questions for Tim (7 Oct 2026)

These are the last items the builders cannot start without you. Each card is a draft and nothing is built from it until you approve. Full cards are in this folder, named DESIGN_..._CARD_2026-10-07.

## A. Pipe label grade after a level typed in the Pit Schedule (BUG-351 b)
Your ruling stands: only that end moves.

1. **A pipe set to take its grade from its levels: should the label grade update when you type a level?** Recommend yes. Job: 1 IN 133 becomes 1 IN 100 after you type 19.80 at the low pit.
2. **How far off may a held-grade label be before CE warns?** Recommend 10 %, on Settings. Job: 1 in 95 against 1 IN 100 gives no warning; 1 in 67 gives a warning on both pit rows.
3. **Warning on the plan too?** Recommend no: the Pit Schedule window and the command line only, so issued sheets stay clean.

## B. Pit Schedule cells left old by a locked layer (BUG-246)

4. **May Refresh in the Pit Schedule window change drawn schedule text?** Recommend yes, out-of-date cells only, and U undoes it. Job: unlock on Monday, press Refresh, and P4's IL and depth update.
5. **Look at the cells each time the window opens, or save a list in the drawing?** Recommend look each time. Job: closed Friday, opened Monday, and the window still says OUT OF DATE for P4.

## C. Downpipes: Accept places all ticked ones (Level 3)

6. **Some ticked downpipes cannot be placed: place the rest?** Recommend yes, and name each one left out with the reason. Job: 14 ticked, 12 placed, "DP7: layer A-PLUMB locked", "DP9: pick its tank or pit first".
7. **Clockwise numbering: a downpipe on the front wall goes first or last?** Recommend last. Job: the centre-front one is DP5, not DP1.
8. **Where do the Level 3 proposals live?** Recommend one "Level 3 proposals" place in Project Review. Job: Project Review > Proposals shows "Downpipes: 14 proposed" beside "Levels: 6 pits".

## D. Detention: Accept draws the chosen system (Level 3)

9. **Where does the on-site detention block go?** Recommend beside the orifice pit, on the existing block's layer, unticked until you tick it. Job: shown 1 m east of the orifice pit.
10. **Footing and service clearances: please type the two distances in metres.** No recommended number, because this is your engineering call. Until you type them CE says "clearance not set". Job: with 0.5 m, a pipe 0.4 m from F3 shows "Clash: footing F3, 0.4 m".
11. **A council wanting only part underground (Glen Eira 50 %): which tank first?** Recommend a fully underground tank first; the split option comes later. Job: 15 m³ proposed as one underground tank.

## E. Network layout: learned options, chooser, Accept (Level 3)

12. **Learn layouts from whose drawings?** Recommend each person's own first, numbers only on their own PC; office-wide later. Job: a new starter sees "Not enough learned yet" until they have drawn 5 networks.
13. **May a layout propose changing a pit already drawn?** Recommend yes, only as a separate unticked row. Job: "Lower existing P4 by 150 mm" is left alone unless you tick it.
14. **Does the layout see an un-accepted downpipe or tank proposal?** Recommend no, only what is drawn. Job: a cancelled tank option is never routed to.

## F. Imported consultant pipes in pieces (BUG-061)

15. **Please send one consultant drawing where a run still comes in as several pipes, with the two pit numbers.** Or reply "061 gone" if it no longer happens since the July fix.
16. **Which pieces should CE join?** Recommend same size, end to end, in a straight line, no pit between. At a bend with no pit, keep them separate and list the spot. Job: 3 straight DN225 pieces become one 42 m pipe.

## G. Kingston commercial jobs (BUG-251)

17. **Where is the Kingston K02 PDF (Part A, version 5)?** Tonight's search of your PC folders did not find it. Reply with the folder.
18. **Commercial lot under 1000 m²: is Tc 7 minutes?** Recommend yes, on Settings, once K02 page 14 is read. At 1000 m² and over: Unknown, you set it.
19. **Commercial pre-development C?** Recommend the lower of the existing site C and 0.7. CE asks for the existing C and shows Unknown until you type it, never assuming 0.7. Job: a car park at 0.9 gives 0.7; a house lot at 0.5 gives 0.5.

---

Reply **"approve all recommended"** (and send the drawing, the K02 folder and the two clearance distances), or list the changes by number.
