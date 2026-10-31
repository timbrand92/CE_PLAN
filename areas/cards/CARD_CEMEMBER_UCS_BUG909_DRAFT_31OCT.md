# DRAFT FOR TIM. CARD CEMEMBER-A1: the member follows the UCS (BUG-909)

**Status:** DRAFT FOR TIM. Tim said yes to the fix ("yes to all four", decision 185, Sat 31 Oct 2026); this card is the written shape of it and needs his approval before any code. Nothing is built, tested or installed. Written 31 Oct 2026 (job n20).
**Classification:** MODIFY. Keep every CEMEMBER question, line rule and layer. Change only where the lines land when a UCS is in use.
**Source:** BUG-909 (C:\CE_PLAN\BUG_CARPARK.md, ledger F-055). Code read on the installed Structural line, origin/claude/rel-20261026s (Structural 1.0.125, head 204dfad2): the CEMEMBER command, its placement and section steps. Parent card: release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md (approved 19 Oct).

## 1. What works now
1. **Type CEMEMBER** (typed command only; it is not on the ribbon yet). Questions: View [SIde/Top/SEction/Reset]; section name (for example 310UB32); how it sits (channels, angles, purlins only); Points sit on [Centreline/Top/Bottom]; Break lines at [Both/Start/End/None]; then point 1 and point 2. A section asks Front/Beyond and a base point on the box instead.
2. **In the World UCS everything is right:** the member runs between the two picks, line rules as approved on 19 Oct.
3. **Elevations already follow the direction of the picks:** pick along a 30 degree line and the member lies along it.
4. **Locked layers, Xrefs and REFEDIT:** CE says so and draws nothing. One U removes the whole run.

## 2. What is wrong or missing (read in the code, not yet seen in AutoCAD)
1. **The height is thrown away.** CE keeps only the across and up position of each pick; the height (Z) becomes 0. Pick on a slab outline drawn at RL 3000 and the member lands at 0, under it. In plan this looks fine; in 3D or with an elevated UCS it is wrong.
2. **A section ignores a rotated UCS.** The section is always drawn square to the World axes. Rotate the UCS 30 degrees to draw along a skewed wall and the 310UB section still stands upright to World, so it looks tilted 30 degrees on your screen.
3. **"West to east" is judged in World, not in your UCS.** CE reads the member left to right by World X. In a UCS turned 90 degrees, left-to-right on your screen is not World X, so CE can swap your two picks. My reading: the side that should be the top of the member (Points sit on Top, the 18cont flange line nearest the top) can then come out on the bottom side on your screen. UNCONFIRMED: not seen in AutoCAD.

## 3. Tim's words
1. "yes to all four" (decision 185, 31 Oct 2026), covering BUG-909: the section follows the UCS.
2. Not recorded: anything about a tilted (3D) UCS. See question 2.

## 4. Full experience (proposed)
1. **Trigger:** unchanged. Type CEMEMBER.
2. **Prompts:** unchanged. No new question.
3. **Selection and picks:** points are read in your current UCS, including their height.
4. **Preview:** none today (the window and preview are a later slice of the parent card). Not changed here.
5. **Drawing output:**
   1. Elevations: the member lies in the plane of your UCS, at the height of point 1. Left to right is judged in your UCS, so "Top" means the top as you see it on screen.
   2. Sections: the section stands upright in your UCS. Rotate the UCS 30 degrees and the 310UB section is upright on your screen, turned 30 degrees in World.
   3. Hatch (HATCH 10, solid) follows the outline. Solid fill has no pattern angle, so nothing else changes.
6. **Two points at different heights** (elevation): CE warns in one line ("point 2 is 450 higher than point 1; the member is drawn level at point 1's height") and carries on (warn, never block, R-27). Recommendation; see question 3.
7. **Cancel / Escape:** unchanged. Nothing drawn.
8. **Undo:** unchanged. One U removes the whole run; Redo brings it back.
9. **Save and reopen:** ordinary lines and hatch; nothing new is stored.
10. **Locked layers, Xrefs, REFEDIT:** unchanged. Never unlocked.
11. **Dependencies:** none new. No new system variable is changed; CE only reads the UCS (REDO-safe).
12. **Performance:** no change.
13. **Discoverability:** the CEMEMBER help text gains one sentence: "CEMEMBER draws in your current UCS, at the height of your first pick."
14. **Settings switch:** "CEMEMBER draws in the current UCS", shipped ON. OFF gives today's result exactly (height 0, sections square to World).

## 5. Example drawings and expected results (made-up drawings, no client data)
1. **World UCS, 310UB32 side elevation from 0,0 to 6000,0.** Expected: identical to today, line for line.
2. **UCS rotated 30 degrees, 310UB32 section, base point Centre.** Expected: the section is upright on screen; its 25cont outline edges run at 30 degrees in World.
3. **UCS rotated 90 degrees, 380PFC side elevation, Points sit on Top, picks left to right on screen.** Expected: the member's top edge is on the top side as seen on screen, and swapping the pick order gives the same lines.
4. **UCS origin moved to Z 3000 (flat), 250UC72.9 top elevation.** Expected: every line at Z 3000.
5. **Switch OFF, example 2 again.** Expected: today's result, square to World.

## 6. Guard tests and the AutoCAD checklist (proposal)
1. **Guards without AutoCAD:** placement keeps the height of point 1; west-to-east is decided in the UCS (a 90 degree UCS gives the same lines whichever way you pick); a section in a 30 degree UCS has its box edges at 30 degrees; switch OFF reproduces today's coordinates exactly; the switch reads ON through both Settings start-up reads.
2. **Robot case (Claude-acceptable, nothing to see):** S909_cemember_ucs. Types UCS Z 30, then CEMEMBER, SEction, 310UB32, Front, Centre, picks 1000,1000; reads back the outline's longest edge angle (expect 30 or 120 degrees, not 0 or 90) and every vertex Z. Control: the same with the switch OFF gives 0 or 90. Second case S909_cemember_height: UCS origin 0,0,3000, side elevation; checks every line at Z 3000.
3. **Codex look:** example 3, because "top as you see it" is a picture.
4. **Not provable without AutoCAD:** how it looks in a 3D view.

## 7. Open questions for Tim (each with a recommendation)
1. **Approve this card?** Recommendation: yes.
2. **A tilted UCS (not flat, for example drawing on a wall face in 3D):** follow it the way AutoCAD's own LINE does, or refuse with one plain line? Recommendation: follow it, like LINE. Real-world: a drafter detailing a sloping rafter in a tilted UCS gets the member on the rafter plane.
3. **Points at two different heights in an elevation:** draw level at point 1's height with a warning, or draw sloping in 3D? Recommendation: level at point 1 with a warning. Your elevations are 2D details; a sloped 3D member would look foreshortened in plan.
4. **SBEAM (the old command) has the same fault?** Not checked. Recommendation: leave SBEAM alone; CEMEMBER replaces it.
