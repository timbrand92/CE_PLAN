# DESIGN CARD L3 network layout: learned options, chooser, Accept (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** This is the rest of "CE proposes the full network layout". Your rulings stand (INT-059 items 7 and 8): option A has the fewest pits, B the shortest pipe and C your usual set-off, and CE offers nothing until 5 networks have been learned. The list of missing pits and pipes, and the measuring of a hand-drawn network, are built, switched off and not installed.

## What you would see in AutoCAD

1. On a site with a boundary, an outlet and some pits already drawn, CE shows 2 or 3 layouts side by side, dashed, for the missing pits and pipes only. Each one is checked for sizes, levels, cover and clashes before it is offered.
2. You pick one and press Accept. The new pits and pipes are drawn. Any change to a pit or pipe already on the drawing is a separate row that is unticked unless you tick it.
3. One U removes everything accepted. Until 5 networks have been learned, CE says "Not enough learned yet" and offers nothing.

## Questions

1. **Whose drawings does CE learn layouts from?**
   - **Recommended:** each person's own networks first, kept as numbers only on their own PC (your 28 Sep privacy rule). The window says "from your own past drawings". Office-wide learning comes later, as its own step.
   - **Job:** a drafter who has drawn 5 networks with learning on gets option C with their usual 1.0 m set-off from the house. A new starter sees "Not enough learned yet", even though the office has drawn hundreds.
2. **May a layout propose changing a pit or pipe already drawn?**
   - **Recommended:** yes, but only as a separate unticked row that you must tick.
   - **Job:** to reach the outlet, option B needs existing P4 lowered by 150 mm. It shows as "Lower existing P4 by 150 mm" with no tick. Accept without ticking it leaves P4 exactly as drawn.
3. **Does the layout see a downpipe or detention proposal you have not accepted yet?**
   - **Recommended:** no. It works only from what is drawn.
   - **Job:** you looked at a tank option, then cancelled. The layout does not route a pipe to that tank, because it is not on the drawing.

## What stays safe

1. Esc or Cancel draws nothing and leaves no dashed preview. One Accept is one Undo, covering the new work and any ticked changes.
2. A locked layer, an Xref or a reference edit is never unlocked or worked around. CE names it in plain words.
3. The 5-network bar, the option count and the on/off switch sit on the Settings page. Set-offs and spacing come only from what was learned, never from a number fixed in the plugin.
4. A layout that fails sizes, levels or a clash is never offered as good. CE says how many it dropped and why. A drawn pit or pipe is never moved without your tick.

## Once you approve

1. **Builders:** record a finished hand-drawn network as numbers for that person, build the 2 or 3 options, feed them into the same side-by-side chooser the detention proposal uses, then the Accept step. A senior review and a Codex AutoCAD run on a copy come before it is switched on.
2. **Test that proves it:** on a copy with learning on and 5 networks drawn by hand, run the proposal on a site with only a boundary and an outlet. Three different layouts appear and none moves a drawn pit. Accept B, then press U once: everything goes. With learning off, it says "Not enough learned yet" and draws nothing.

---
For builders (Tim need not read): plan `areas/plan-L3-NETWORK.md` slices 3, 4, 5 and 6, plus section 8 (run 20). Built: slice 1 (#693), slice 4 measuring half (#754, `networkLayoutProposal.turnToleranceDeg` = 10, a starting value to confirm). Not built: slice 3 (needs options), slice 4 store (new "network seen" event in `LearningService`; question 1 decides per person vs office-wide), slice 5 (engine), slice 6 (accept + window contract). Shared pieces: clash #699, chooser contract #708. Question 1 source: plan slice 4 item 3; privacy ruling "numbers only, on the person's own PC" = decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md line 149; office-wide suggestions anonymous = UX-LEARN-02. Questions 2 and 3 = plan slice 6 items 1 and 3 (card §7 Q4 recommended, not ruled). The footing/service clash distances are on the detention card.
