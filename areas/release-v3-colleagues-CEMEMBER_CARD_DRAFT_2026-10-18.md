# CEMEMBER command card - approved by Tim on 19 Oct 2026 ("yes"), subject to the lip lines in section 3 and the open items in section 11; no code yet (first written 18 Oct 2026)

Source: design session "CE_ACAD / structural / sbeam design / 01" with Tim. Every rule below was drawn back to Tim as a picture and he confirmed it, except where marked OPEN.
Replaces the old SBEAM command (Modules/Structural/Commands/SectionDetailCommands.cs, StructuralDetailService.cs, SteelSectionPickerDialog). Classification for the review gate: REBUILD the dialog and the elevation rules, KEEP the section outline + 10H hatch behaviour, KEEP the BL-style break line.
Nothing here is built, tested or installed. No AutoCAD test has been done.

## 1. Layers and what they mean
- 25cont: member outline and extents.
- 18cont: lines that are visible but inside the outline (web/flange junctions, flange tops, visible leg edges).
- 18hidden: the same kind of line when it is on the far side or under something (dashed).
- 9hidden2 (colour 9, linetype hidden2): the "section beyond" outline only.
- HATCH 10 (colour 10, solid, associative): the 10H hatch on a section cut in front.
- Break lines: 18CONT.
- Rule for all views: never two lines on top of each other. Where two lines would coincide the line closest to the viewer is drawn and the other is not.

## 2. Views
- Section: outline on 25cont, hatched with 10H. Toggle IN FRONT (as just described) or BEYOND (outline only on 9hidden2, no hatch). Hollow sections: hatch the wall only, leave the void empty.
- Side elevation: looking at the web side, along the member's length. Viewer is on the left of the section.
- Top elevation: looking down over the web. Viewer is above the section.
- In both elevations the member's two outer edges and both ends are 25cont. Ends are either closed (straight 25cont) or broken (see section 7).

## 3. Line rules per member, confirmed by Tim
UB, UC, WB, WC (I-shapes, symmetrical, one orientation):
- Side elevation: 25cont top and bottom edges; 18cont at one flange thickness in from each edge (where the web meets the flanges).
- Top elevation: 25cont both edges (the flange lines coincide with them, so they are not drawn); web shown as TWO 18hidden lines at half the web thickness each side of the centreline.

SHS, RHS, CHS (hollow, one orientation):
- Both elevations: 25cont outer edges plus two 18hidden lines one wall thickness in from each edge (for CHS, at the inside diameter).
- Section: outline on 25cont, hatch on the wall only.

PFC (four orientations; "up/down/left/right" is where the flange tips point in the section):
- Flanges right (web on the left): side = 25cont edges, flange toe lines at one flange thickness in from each edge are 18hidden; top = 25cont edges, the inside face of the web is ONE 18hidden line one web thickness in from the web edge.
- Flanges left (web on the right): side = toe lines 18cont (solid); top = one 18hidden line one web thickness in from the web edge.
- Flanges up (web at the bottom): side = one 18hidden line one web thickness above the bottom edge; top = 18cont lines one flange thickness in from each edge (flange tops).
- Flanges down (web at the top): side = one 18hidden line one web thickness below the top edge; top = 18hidden lines one flange thickness in from each edge.
- The old command also drew the web's outer face as a hidden line on top of the 25cont edge. Under the no-double-lines rule that line is not drawn.

Equal and unequal angles (four orientations; "upright" = the leg standing vertical in the section, "flat" = the leg lying horizontal; t = leg thickness):
- Upright left, flat bottom: side = 18hidden at t above the bottom edge; top = 18cont at t in from the upright leg's edge.
- Upright right, flat bottom: side = 18cont at t above the bottom edge; top = 18cont at t in from the upright leg's edge.
- Upright left, flat top: side = 18hidden at t below the top edge; top = 18hidden at t in from the upright leg's edge.
- Upright right, flat top: side = 18cont at t below the top edge; top = 18hidden at t in from the upright leg's edge.

Z purlin (Lysaght Zed, two different flange widths; four orientations, same idea as PFC):
- Side elevation (flanges toward the viewer): 25cont edges and 18cont at one thickness in from each edge.
- Top elevation: 25cont outer extents; 18cont line where the top flange ends at the web; 18hidden line for the far flange's inner edge running under the top flange. Tim confirmed this picture ("yes correct").

C purlin (Lysaght Cee) and Z purlin side elevation (Tim, 19 Oct 2026, asked whether they behave like the PFC: "kind of, it shows flange and flange lip if that makes sense?" and for the Z "kin dof but same as per q3"; asked about lips: "yes"):
- The elevations show BOTH the flange line and the flange lip line. They follow the same toward/away rule as the PFC: 18cont when on the near side, 18hidden when on the far side.
- Flange line = one thickness in from the edge. Flange lip line = one lip depth in from the edge (lip depth from the Lysaght table). A picture of this was shown to Tim on 19 Oct; his reply to that picture decides the exact positions. Until then this is a proposal.
- C purlin top elevation = web inner face 18hidden (inferred from the PFC, not separately confirmed). Lip lines in the TOP elevation are not yet decided.

DEFERRED (Tim, 19 Oct 2026: "not for now"): tees (BT, CT) and round, square and flat bars are NOT in the first release. Their data is kept apart in section-catalogue_DEFERRED_tees_and_bars.json. Their line rules were never discussed.

## 4. Orientation
Only the odd-shaped members (PFC, angles, Z, C) get an orientation picker: four small pictures to click. The orientation replaces the old "flanges toward / away" switch, because it already says which way the flanges point. UB, UC, WB, WC, SHS, RHS, CHS, tees and bars have one orientation.

## 5. The window
Left column: member type, then the size list, then a small properties box (depth, width, web, flange, mass, Ix, Iy, Zx, Zy; "-" where there is no figure).
Middle: a live preview, always shown, drawn with the real line rules above, with the points marked 1 and 2 on elevations and the base point marked on sections.
Right column, top to bottom:
1. View: Section, Side elevation, Top elevation.
2. Orientation: four small pictures (odd shapes only; greyed otherwise).
3. Section: In front / Beyond (greyed for elevations).
4. Elevations: "Points sit on": Centreline (default), Top of member, Bottom of member. Section: a 3x3 grid for the base point on the box around the section (four corners, middle of each side, centre; centre of the box, not the balance point).
5. Ends: Both broken (default), Start, End, None (closed). Greyed for a section.
6. Scale 1 : [number]. Typed number, default 100.
Bottom right: Reset to default, Cancel, Place.

## 6. What happens after Place
- The window hides.
- Elevations: pick point 1 then point 2, west to east; the member stretches between them. Section: one pick.
- Escape cancels at any stage.
- Enter or Space after a member is placed reopens the window with the previous choices. Reset to default clears them.

## 7. Scale and break lines
- Scale = the drawing's DIMSCALE (default 100). LTSCALE is always 10 x DIMSCALE in this plugin (20/200 or 100/1000, see HatchCommands.ResolveScale), so it is only a check. OPEN: warn or stop when it is not 10 x.
- Break line = the same Z-kink on a straight line shape as Tim's BL command (StructuralDetailService.DrawBLBreakLine), on 18CONT. Size follows the SCALE, not the beam: 1.5 mm overshoot each side and a 2 mm kink on paper (150/200 at 1:100, 30/40 at 1:20; scale linearly for any typed scale).

## 8. Data the command needs
- A corrected section list is in 04_REFERENCE/section_data_2026-10-18/section-catalogue_CORRECTED_DRAFT.json with a plain-English summary in WHAT_CHANGED.md beside it. It is a DRAFT: Tim has not reviewed it, and it replaces Modules/Structural/Assets/Config/section-catalogue.json only after his review.
- New fields the code must learn: widthNarrow (Zed second flange), thickness vs nominalThickness (angles), no rootRadius for welded WB/WC, zyOtherSide (PFC), BT/CT/RB/SQ/FB types.

## 9. Tests to write (proposal)
- Unit tests: line-rule table per member and orientation (this document is the oracle); scale and break line sizes; DIMSCALE/LTSCALE reading.
- Drawing-output check: draw each member in each view into a test DWG and compare entity layers, counts and coordinates against the rules above.
- Tim's AutoCAD checklist (not yet written): one UB, one PFC in all four orientations, one angle in all four, one SHS, one Z purlin, section in front and beyond, break line sizes at 1:20 and 1:100, Escape, Undo, Enter-to-repeat.

## 10. Tim's answers, 19 Oct 2026 (full text in decisions/2026-10-19_CEMEMBER_ANSWERS.md)
- LTSCALE not 10 x DIMSCALE: WARN and carry on, record a line ("yes as per recommeneded").
- Purlin lips in the elevations: yes, shown (see section 3).
- C purlin and Z purlin side: flange line plus flange lip line (see section 3).
- Tees and bars: not for now.
- Paid ASI tables: not bought ("nope we can get from elsewhere"); top hats: to come from elsewhere.
- Section numbers: Tim accepted the plan to check ten rows ("look good"): 310UB32.0, 250UC72.9, 380PFC, 230PFC, 100x100x6 EA, 100x100x6 SHS, 200x100x6 RHS, 114.3 CHS, Z15015, 900WB282. Not yet done.
- Hollow sizes InfraBuild stocks but the list lacks: added to the draft ("yes"): 8 SHS and 23 RHS, properties calculated.
- Names: supplier names with decimals, e.g. 530UB92.4 ("yep why not").
- This card: approved ("yes"), subject to the lip line positions above being confirmed from the picture. No code has started. The Tim AutoCAD checklist is still to be written.

## 11. Still open
- Lip line positions (side) and any lip lines in the TOP elevation.
- The C purlin top elevation rule (inferred).
- The ten-row check of the section numbers.
- Where top hat and hollow-section property data comes from (Tim: "elsewhere").
