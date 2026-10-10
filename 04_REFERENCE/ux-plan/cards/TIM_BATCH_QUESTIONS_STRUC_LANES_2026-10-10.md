# Questions for Tim: what the three builder lanes could not finish without you (Sat 10 Oct 2026, desk plan/03 planner run 2)

**How to answer.** Reply with the question number and either a number, a name, or the words "as recommended". One line each is enough. Anything you skip stays as it is now (the feature says "not set" or "Unknown" and never guesses).

**Where these came from.** The Structural lane (build/02) finished its queue at run 147 and said items 22, 28 and 29 need your tables or your layer decision. The Civil lanes (build/03 and build/04) left seven items saying "Tim's number" or "Tim's options ruling". I checked `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` (INT-074 to INT-081) first: none of these fifteen is answered there. Your 9 Oct answers that DO close things (beam layers stay BEAM / BEAM LOWER, beam linking ON, BT1 any width, lintel table on S01, strength band "as recommended") are already in the lanes' PRs and are not asked again.

---

## Structural (build/02)

1. **Retaining wall sizes by height band (S4 card question 1; PR #1102 built the layout).** Today CSRW lays out posts, sleepers and piers along a wall line but every size prints "Unknown, engineer to fill". **Recommendation:** leave it Unknown now and type the table into Settings when you next do a sleeper wall (columns: wall height band, sleeper size, post size, pier diameter, pier depth, with a "fence on top" column). Example: 0 to 600 high, 200x75 sleepers, 100UC posts, 450 piers 1200 deep. Answer: "as recommended" or type your first band.

2. **Fence post footing sizes by fence type and height (S4 card question 2; PR #1106).** Same shape as question 1: the fence footing engine runs, the sizes say Unknown. **Recommendation:** as question 1, leave Unknown until you fill the Settings table. Answer: "as recommended" or type the first row.

3. **One layer name per object (R-00 Structural items 28 and 29).** Today the same object can land on two layers depending on which command drew it: bored piers on BORED PIER or BORED PIER UNDER, joists on JOISTS or FLOOR JOISTS, stump footings on STUMP FOOTING or BORED PIER UNDER, and pads and strips both on STRIP FOOTINGS. **Recommendation:** BORED PIER UNDER, FLOOR JOISTS, STUMP FOOTING, and keep pads and strips together on STRIP FOOTINGS; every name becomes a Settings value so you can change it later without a rebuild. Example: after this, a bored pier drawn by BP and one drawn by the footing plan both sit on BORED PIER UNDER and one layer freeze hides them all. Answer: "as recommended" or the four names you want.

4. **Bracing schedule rows when a bracing block has no mark (HUNT2-S-09, BUG-503).** The bracing schedule today can print an AutoCAD handle or a layer name in the Mark column because BT1 blocks carry no mark. **Recommendation:** the schedule lists one row per wall line and bracing type (A or B) with a count, for example "Wall line 3, Type A, 2 panels", and never prints a handle. Answer: "as recommended" or say you want numbered marks (B1, B2 ...) instead.

5. **Tie-down names for TD1, TD2 and TD3.** They are placeholders (strap, bolted, proprietary). **Recommendation:** keep the placeholders until you give the real product or detail names. Answer: "as recommended" or the three names.

6. **Beam shorten distances (R-00 item 23).** The beam commands offer 45 or 100 mm when shortening a beam at a wall. **Recommendation:** keep 45 and 100 and make them a Settings list. Answer: "as recommended" or the distances you use.

7. **Floor arrow order and the legend words (re-ask of Set A question 10, which you answered "idk what this means").** On a framing plan CE can place the floor arrows for joists, bearers and subfloor in a fixed order, and the legend can read "DENOTES POST UNDER" next to the post symbol. Plain question: (a) which goes on top in the arrow stack, joists, bearers or subfloor? (b) is "DENOTES POST UNDER" the wording you want, or something else? **Recommendation:** joists on top, then bearers, then subfloor, and the wording as written. Answer: "as recommended" or your order and wording.

## Civil, numbers only you can give (build/03 and build/04)

8. **Clearance from a footing to a detention or storage pipe or tank, in metres (INT-072 item 4, still open).** Ships today as "clearance not set, not checked". Example: with 0.6 m, a storage pipe 0.4 m from a footing turns red in Checks. Answer: a number in metres.

9. **Clearance from an existing service to a detention or storage pipe or tank, in metres.** Same as question 8 for sewer, water, gas and power. Answer: a number in metres.

10. **Zone of influence angle for pipes near footings, in degrees, measured from the horizontal (INT-077 item 8).** Ships today as "angle not set, pipes near footings were not checked". Example: 45 degrees from the horizontal means a pipe 1 m below the footing base is inside the zone when it is closer than 1 m sideways. Answer: a number in degrees, and "from horizontal" or "from vertical".

11. **Minimum clearance to a crossing service on the long section, in mm (Batch 8/9 question 8).** Ships today as blank. Example: with 150, a sewer crossing P2 to P3 at 120 mm gets a red line on the long section and in Checks. Answer: one number, or one per service (sewer, water, gas, power, telecom).

12. **Markup "same place" distance between rounds, in mm on the printed sheet (Batch 8/9 question 13).** Until set, every new comment on a second markup round is listed as a new item. **Recommendation:** 15 mm. Answer: "as recommended" or a number.

13. **Office minimum cover for pipes, 300 or 600 mm (Set C question 5).** The code and your Settings file disagree; the lane built both reachable behind a switch. Answer: 300 or 600.

14. **What makes the two or three Level 3 network options different (L3-NETWORK card question 3).** build/04 has three slices waiting on this (compare, chooser rows, Accept). **Recommendation:** option A fewest pits, option B shortest total pipe length, option C your usual set-off pattern learned from your own past jobs; the chooser shows pit count, total length and deepest invert for each. Answer: "as recommended" or name the three you want.

## One-line confirmations

15. **Three things the lanes built on the recommended answer; say "as recommended" to confirm all three, or name the one to change.** (a) The job's wind class, soil class and required bracing are kept inside the drawing so a colleague or a Save As keeps them (BUG-496, PR #1024, switch OFF until you confirm). (b) A loaded markup belongs to the drawing it was loaded for; switching drawings never mixes them (PR #1068, OFF). (c) Boroondara outfall drain rule reads "within the table length means a drain is required" (PR #1097, Guidelines 2017 Table 3-2); the engine says "not decided" until an engineer confirms that reading.

---

**Not asked here, still open from earlier batches (no build waits on them):** the Azure update-channel keys and signing set-up (Tim's own actions), BUG-483 moving old install files to an OLD folder, the SPS master detail file, CDWT go or park, retiring CESTRUC and the duplicate command pairs, UX-UNIT-01 unit copy, STRUC-COMPS methods, Max Mishchenko's SharePoint access, master copy-forward, window pictures as reference, other AutoCAD versions, the rest of Set C and Batch 8/9 questions 1 to 7, 9 to 12, 14 and 15. They stay in `TIM_SET_C`, `TIM_BATCH_QUESTIONS_8_9_2026-10-09.md` and `TIM_BATCH_TESTING_AND_RELEASE`.
