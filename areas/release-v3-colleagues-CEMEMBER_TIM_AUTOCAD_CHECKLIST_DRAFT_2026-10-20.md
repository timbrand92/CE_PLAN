# CEMEMBER: Tim's AutoCAD checklist (DRAFT for Tim to approve, written 20 Oct 2026, build/02)

**Status: NOT RUNNABLE YET.** Nothing here can be tested today. So far only the line rules and the placing maths are built and unit-tested (draft PRs #1487, #1488, #1489, #1490). There is no CEMEMBER command, no window and no Settings page rows yet. This list is what Tim will be asked to run once the command exists, written now so he can approve or change it first (the card says no AutoCAD test is asked until the checklist is agreed). Test on a COPY of a drawing, never a real one.

Before starting: type `DIMSCALE` and `LTSCALE`. Normal for a 1:100 sheet is DIMSCALE 100 and LTSCALE 1000. Write the two numbers down.

## A. One UB (side and top, ends both broken)

1. **Run it:** type CEMEMBER, choose Universal Beam, pick 310UB32.0, View = Side elevation, Ends = Both broken, Points sit on = Centreline, Place.
2. **Pick:** click point 1, then point 2 about 3 m to the right.
3. **Expect:** two long solid lines on layer 25cont, 298 mm apart (use DIST). Two more solid lines on 18cont, each 8 mm inside an outer line. A Z-kink break line at each end on 18CONT, sticking out about 150 mm past the beam at 1:100. Nothing drawn twice on top of itself (select one line, press Delete, and check no second line is hiding under it, then Undo).
4. **Repeat** with View = Top elevation: two 25cont lines 149 mm apart; two dashed 18hidden lines 5.5 mm apart on the centreline; NO 18cont flange lines.

## B. One PFC in all four orientations (380PFC, side and top for each)

1. **Flanges right (web on the left):** side shows two dashed 18hidden lines 17.5 mm inside each edge. Top shows one dashed 18hidden line 10 mm in from the web edge.
2. **Flanges left (web on the right):** side shows the same two lines SOLID on 18cont. Top shows one dashed line 10 mm in from the web edge.
3. **Flanges up (web at the bottom):** side shows one dashed 18hidden line 10 mm above the bottom edge. Top shows two SOLID 18cont lines 17.5 mm in from each edge.
4. **Flanges down (web at the top):** side shows one dashed line 10 mm below the top edge. Top shows two DASHED lines 17.5 mm in from each edge.
5. **Check in all four:** there is no line sitting on top of an outer 25cont edge. One thing to look at in particular: in the Top elevation, which side of the picture the web line is on. The plan is that the section's left edge is the bottom of the top view. Tell me if it is the wrong way round on your drawing.

## C. One angle in all four orientations (100x100x6 EA, side and top for each)

1. **Upright left, flat bottom:** side one dashed line 6 mm above the bottom edge; top one solid line 6 mm in.
2. **Upright right, flat bottom:** side one solid line 6 mm above the bottom edge; top one solid line 6 mm in from the upright leg's edge.
3. **Upright left, flat top:** side one dashed line 6 mm below the top edge; top one dashed line 6 mm in.
4. **Upright right, flat top:** side one solid line 6 mm below the top edge; top one dashed line 6 mm in.
5. **Also one unequal angle** (for example 150x90x8): side uses the upright leg, top uses the flat leg.

## D. One SHS (100x100x6) and one RHS and one CHS

1. **Both views:** 25cont outer edges plus two dashed 18hidden lines one wall thickness (6 mm) in from each edge. CHS: lines at the inside diameter.
2. **Section view:** the outline is 25cont and ONLY the wall is hatched with the 10H hatch (the hollow middle is empty).

## E. One C purlin (Lysaght Cee) and one Z purlin

1. **C purlin, side:** a flange line one thickness in AND a lip line one lip depth in, from each edge. Solid 18cont when the flanges point toward you, dashed 18hidden when they point away.
2. **C purlin, top:** one dashed web line only. No lip lines (you said they interfere).
3. **Z purlin: NOT BUILT.** The card does not say how the four Z orientations are named. See the question in the TEAMLANE2 log. This line stays open until you answer.

## F. Section views

1. **In front:** pick a UB section with Base point = Centre of the box. Expect the outline on 25cont, hatched with the 10H hatch on layer HATCH 10, and the picked point on the middle of the box around the section (not the balance point).
2. **Beyond:** same member, Section = Beyond. Expect the outline only, on 9hidden2, no hatch.
3. **Nine base points:** place the same section nine times, once for each corner, side-middle and centre; the pick point must land on that corner or middle of the box each time.

## G. Break lines at 1:20 and 1:100

1. **At DIMSCALE 100:** break line sticks out about 150 mm each side of the member and the kink is about 200 mm.
2. **At DIMSCALE 20 (and LTSCALE 200):** about 30 mm and 40 mm.
3. **Any other scale** (for example 50): about 75 mm and 100 mm.
4. **Warning, not a stop:** set LTSCALE to 100 with DIMSCALE 100, run CEMEMBER again. It should say in plain words that LTSCALE is not 10 times DIMSCALE and carry on drawing.

## H. Escape, Undo, repeat

1. **Escape** at the window, at point 1, and at point 2: nothing is drawn each time.
2. **Undo:** place one member, press U once: the whole member (all lines and both break lines) goes in one step. Press REDO: it comes back whole.
3. **Enter or Space** right after a member is placed: the window reopens with your last choices. Reset to default clears them.
4. **Locked layer:** lock 25cont, run CEMEMBER. It must not unlock the layer; it should tell you plainly and leave the drawing unchanged.
5. **Points picked east to west:** the member must still come out the same as picked west to east.

## What cannot be proven without you

1. The look of the window and the live preview (Codex builds the window; Tim or a Codex run looks at it).
2. Which way round the top elevation is on the drawing (B5).
3. Whether the Z purlin picture is right (once built).
4. The section list numbers: still the draft list, not loaded, ten rows checked by Tim on 19 Oct.
