# DESIGN CARD L3 downpipes: Accept places all ticked downpipes at once (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** This is the last step of "CE proposes downpipes and sources". The proposal list, the dashed preview and the numbering are built, switched off and not installed. Your rulings stand: 12 m spacing, the broad symbol search with each one confirmed (INT-059 items 5 and 6).

## What you would see in AutoCAD

1. CE lists the proposed downpipes with a tick box each and shows them dashed on the plan. Nothing is drawn yet.
2. You press Accept. Every ticked downpipe is placed exactly as if you had placed it by hand, with its number, its line to the tank or pit, and its auto-join to a pipe drawn later.
3. One U removes the whole accepted set. Esc or Cancel draws nothing.

## Questions

1. **If some ticked downpipes cannot be placed, should CE place the rest?**
   - **Recommended:** yes. CE places the rest and names each one it left out, with the reason. They stay ticked so you can fix them and Accept again.
   - **Job:** 14 ticked. DP7 sits on locked layer A-PLUMB and DP9 has no tank or pit picked. CE places 12 and says "DP7 not placed: layer A-PLUMB is locked. DP9 not placed: pick its tank or pit first." If you say no, nothing is placed until all 14 can go.
2. **In "clockwise from the front left", where does a downpipe that sits on the front wall go?**
   - **Recommended:** last, as built. Front-wall downpipes are numbered right to left at the end of the circle.
   - **Job:** a house with four corner downpipes and one dead centre on the street side. DP1 is front left, then round clockwise, and the centre-front one is DP5. The other choice makes it DP1.
3. **Where do the Level 3 proposals live?** (asked 4 Oct, not answered yet)
   - **Recommended:** one "Level 3 proposals" place in Project Review, with levels, downpipes, detention and layout side by side.
   - **Job:** you open Project Review > Proposals and see "Downpipes and sources: 14 proposed" beside "Levels: 6 pits". Until you answer, it stays a hidden typed command for testing only.

## What stays safe

1. Esc or Cancel draws nothing and leaves no dashed preview behind. One Accept is one Undo.
2. A locked layer, an Xref or a reference edit is never unlocked or worked around. That downpipe is left out and named in plain words.
3. The spacing, the symbol names and the default numbering order sit on the Settings page.
4. CE warns and carries on. An unknown tank or pit is never filled in for you. A downpipe number already on the drawing is never reused.

## Once you approve

1. **Builders:** first a senior design review of how the whole accepted set goes in as one Undo (the riskiest change in this plan). Then they build it by reusing the existing one-at-a-time placement steps, not a copy of them. Codex then tests it in AutoCAD on a copy.
2. **Test that proves it:** on a copy, propose downpipes on a house with 6 corners. Tick 6, lock the layer of one, and press Accept. 5 are placed and the sixth is named. One U removes all 5. Draw a pipe to DP2: it joins exactly as a hand-placed DP does. Esc at the list draws nothing.

---
For builders (Tim need not read): plan `areas/plan-L3-SOURCES.md` slice 5 item 1 and section 8b item 3 (`PlaceMany` on `SourcePlacementService`, one outer transaction passed into the existing per-source steps, design rule 1; NOT built; needs the controller's go, then an Opus design review, then a Codex AutoCAD run). Built: #751 (slice 4 selection/ghost/contract), #755 (numbering; Opus MWF fixed @03c2bbe6, front-wall rule from build/04 run 23). The Unknown-destination refusal is built (8 item 2) and folded into question 1. Question 1 is a real design fork: "place the rest" inside one transaction means a per-item skip with the rest committed, not a whole-batch rollback. Decide this before the Opus review. Question 3 = L3_QUESTIONS_FOR_TIM_2026-10-04 Q5, absent from INT-059.
