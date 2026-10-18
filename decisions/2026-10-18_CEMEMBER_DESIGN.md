# CEMEMBER design session: Tim's decisions, 18 Oct 2026

**Source:** a design session Tim ran on another PC (the SBEAM design chat the desk asked for on 18 Oct), handed to the desk in Tim's own message on 18 Oct 2026. The session's files are on that PC and are not in this repository. Tim's words are in quotes. Nothing here is built, installed or tested in AutoCAD. This file records decisions only; open questions are listed separately and are NOT decisions.

## A. Decisions (Tim, 18 Oct 2026)

1. **Name: CEMEMBER.** Tim: "yep sounds good". The command replaces SBEAM. It changes because "its not only steel beams". (SBEAM and SBEAMEDIT keep working until CEMEMBER passes Tim's AutoCAD test; old names are not removed first, per the review gate and UX-NAMES-01.)
2. **Three views:** section, side elevation (looking at the web), top elevation (looking down over the web).
3. **Section view:**
   1. Outline on layer `25cont`; hatch with the existing 10H hatch (solid, colour 10, layer `HATCH 10`).
   2. Toggle "in front" or "beyond". Beyond = outline only on `9hidden2` (colour 9, hidden2 linetype), no hatch.
4. **Elevations:** extents on `25cont`. Web and flange lines on `18cont` if on the near side, `18hidden` if on the far side. Tim: "we keep flange lines on that layer and keep them".
5. **Overlap rule:** Tim: "we never put two lines on top of each other". The line closest to the viewer wins.
   1. UB and UC top elevation: no flange lines; the web is shown on `18hidden`.
   2. SHS, RHS, CHS: inside walls on `18hidden` in both elevations; the section hatch covers the wall only.
   3. Z purlin top elevation: the top flange end edge solid `18cont`, the other flange edge `18hidden`.
6. **Odd-shaped members** (PFC, angles, Z and C purlins) come in four orientations. The orientation replaces the old Toward/Away switch.
7. **Picking:** points are picked west to east. Elevations: points 1 and 2 sit on the centreline (default), top of member or bottom of member. Section: one point chosen from nine positions on the box around the section.
8. **Break lines at member ends:** the same Z-kink shape as Tim's BL command, on `18CONT`. Size follows the typed scale, not the beam: 1.5 mm overshoot and 2 mm kink on paper.
9. **Window:**
   1. Left: member and size, with a small properties box.
   2. Middle: live preview, always shown.
   3. Right: view, orientation, in front/beyond (section only), points or base point, ends (both broken / start / end / closed; greyed for a section), scale typed as a number.
   4. Buttons: Cancel, Place, Reset to default.
   5. After Place the window hides: pick point 1 then 2, or one point for a section. Enter or Space after placing reopens the window with the previous choices.
10. **Scale:** default 100, read from DIMSCALE. LTSCALE is always 10 x DIMSCALE in this plugin (20/200 or 100/1000), so it is only a check.
11. **Purlins:** Tim uses Lysaght. He does not use tapered flange beams.

## B. Findings about the plugin's section list (reported by the session; for the carpark, not decisions)

File: `Modules/Structural/Assets/Config/section-catalogue.json`. Checked by the session against InfraBuild (Hot Rolled catalogue 9th ed. 2019 and Know Your Steel V11 2025), BlueScope (Welded Beams and Columns brochure), the Lysaght Zeds and Cees guide and steelweb.info.
1. **UB/UC:** sizes right; root radii 0.9 to 2.4 mm low; 150UB18 and 150UB14 Ix/Zx about 10% low; names rounded (need 530UB92.4, 310UB32.0).
2. **PFC:** all 10 rows wrong in several fields.
3. **Equal angles:** all masses and Ix about 0.63 of real; thickness is nominal, not actual; 8 sizes missing.
4. **Welded WB/WC:** 31 of 33 rows differ; 8 sizes missing; welded sections have no root radius.
5. **Hollow sections:** old Ix 40 to 75% out on 60 rows (400x400x16 SHS had 328, real about 570); many rows had no mass.
6. **Purlins:** the list had ZC400 and C40030, which Lysaght does not make; real Z purlins have two different flange widths; the old code draws equal flanges and ignores the lips in the elevations.
7. **A corrected DRAFT list** was built with 17 types (UB, UC, PFC, WB, WC, EA, UA, SHS, RHS, CHS, Lysaght Z and C, BT and CT tees, round, square and flat bars). Calculated figures are labelled. It lives on the other PC in `CE_Reference\Corrected_Draft`. **It is a draft, Tim has not reviewed it, and it must not go into the repo yet.** Tim will copy the draft list and the supplier PDFs across if the desk asks.

## C. Open items (NOT decisions; Tim's list)

1. **Drawing-code changes needed with the list change:** second flange width on Z purlins, actual angle thickness, no radius for welded sections, purlin lips in the elevations, the new tee and bar shapes.
2. **Top hats:** no source found.
3. **ASI Design Capacity Tables** (paid) are the proper check for hollow-section properties.
4. **DIMSCALE/LTSCALE check: warn or stop?** Open. (Rule R-27 leans to warn and record; that is a recommendation, not Tim's answer.)
5. **Tim's review of the draft section list.** Open.

## D. Effect on earlier items

1. **BUG-750** (SBEAM inner flange lines) and the draft PR #1384 (switch for the inner flange lines): superseded by this design. #1384 stays OPEN and is NOT merged (D6: nothing is closed); the Structural train merge order in REVIEWLANE entry 1222 drops it.
2. **QUESTIONS_FOR_MONDAY** items on SBEAM side elevation lines: answered by section A items 4 and 5; kept, marked superseded.
3. **UX card ST8-4** (`SBEAM` workflow, `04_REFERENCE/CARDS/ST-08_SECTIONS_DETAILS.md`): the proven steel geometry and break-line options are kept in spirit; this file replaces its view and orientation rules. A proper CEMEMBER command card (per the review gate: Keep/Modify/Rebuild classification, Cancel/Esc/Undo, save/reopen, tests) still has to be written and approved by Tim before code starts.
4. **Ruling A (pause new plan items):** CEMEMBER is a new command; it stays a design record only. No build starts until Tim lifts the pause for it or approves the card. The section-list data errors are bugs (BUG-818, BUG-819) and may be fixed under ruling A once Tim has reviewed the corrected list.

## E. Update 2 (18 Oct 2026, later): the design session's own files reached the repo

The design session chat ("CE_ACAD / structural / sbeam design / 01") pushed its results. They are the detail behind section A above and replace nothing in it:
1. `areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md`: the CEMEMBER command card. **Status: DRAFT, NOT approved by Tim.** Classification for the review gate: REBUILD the dialog and the elevation rules, KEEP the section outline + 10H hatch behaviour, KEEP the BL-style break line. It replaces the old SBEAM files (`SectionDetailCommands.cs`, `StructuralDetailService.cs`, `SteelSectionPickerDialog`).
2. `areas/release-v3-colleagues-CEMEMBER_DESIGN_SESSION_RESULTS_2026-10-18.md`: the session summary, section-list problems and sources.
3. `04_REFERENCE/section_data_2026-10-18/`: `WHAT_CHANGED.md` (plain-English summary), `section-catalogue_CORRECTED_DRAFT.json` (17 types), the `differences_*.txt` reports and `round2_build_log.txt`. **Reference only: it is NOT copied into `Modules/Structural/Assets/Config/section-catalogue.json` and must not be until Tim has reviewed it.** Supplier PDFs and the steelweb.info page extracts were not pushed (third-party documents) and stay on Tim's PC.

### E1. Tim's confirmations recorded in the card (every rule was drawn back to him as a picture)
1. **Confirmed by Tim:** the I-shape rules (UB, UC, WB, WC: side elevation 25cont edges with 18cont at one flange thickness in from each edge; top elevation 25cont edges, no flange lines, web as two 18hidden lines at half the web thickness each side of the centreline); the hollow-section rules (SHS, RHS, CHS: both elevations 25cont outer edges plus two 18hidden lines one wall thickness in, CHS at the inside diameter; section hatch on the wall only); the PFC and angle pictures in four orientations (card section 3); the Z purlin TOP elevation (Tim: "yes correct": 25cont extents, 18cont where the top flange ends at the web, 18hidden for the far flange's inner edge under the top flange).
2. **NOT confirmed by Tim, inferred by the session (treat as OPEN):** the C purlin rules (inferred from the PFC and from a picture he saw without objecting) and the Z purlin SIDE elevation (shown, not called out).
3. **Tim's words kept:** "we dont use tfb so you can remove" (tapered flange beams left out); "section should offer everything" (nine base-point positions); "thats great" (the window); "steelweb.info is good for a lot fo things"; "can we finish the not done items?" (round 2 of the list).
4. **Orientation meaning (card section 3):** for PFC, "flanges right/left/up/down" is where the flange tips point in the section. For angles, "upright" is the leg standing vertical and "flat" the leg lying horizontal, with t the leg thickness; the four angle orientations are upright-left/flat-bottom, upright-right/flat-bottom, upright-left/flat-top, upright-right/flat-top. Orientation pickers appear only for PFC, angles, Z and C; UB, UC, WB, WC, SHS, RHS, CHS, tees and bars have one orientation.
5. **Window and placing details (card sections 5 and 6):** the properties box shows depth, width, web, flange, mass, Ix, Iy, Zx, Zy ("-" where there is no figure); "Points sit on" Centreline (default) / Top / Bottom; the section base point is a 3x3 grid on the box around the section (centre of the box, not the balance point); Ends: Both broken (default), Start, End, None (closed); Escape cancels at any stage; Reset to default clears the remembered choices.
6. **Break line size:** 1.5 mm overshoot each side and a 2 mm kink on paper, scaled linearly with the typed scale (150/200 at 1:100, 30/40 at 1:20), same Z-kink shape as `StructuralDetailService.DrawBLBreakLine`.
7. **No double lines:** because of Tim's rule the old command's hidden line for the PFC web's outer face (drawn on top of the 25cont edge) is no longer drawn.

### E2. Open questions (from the card; NOT decisions)
1. Warn or stop when LTSCALE is not 10 x DIMSCALE (card section 7).
2. Purlin lips (Z and C): the old command draws them in the section but not in the elevations; do the elevations need a line at the lip depth?
3. Rules for BT, CT (tees cut from UB/UC), round bar, square bar and flat bar: never discussed with Tim; do not guess.
4. Top hats: no source for the data.
5. Which section-list numbers Tim accepts: the draft needs his review; hollow-section figures are partly calculated (corner radius 2.5t; off by 0.65% in the middle and 6.6% at worst against steelweb on the 95 rows that have both) and steelweb.info figures carry no accuracy guarantee (free site, last updated Dec 2020). The paid ASI Design Capacity Tables are the proper check, and who checks the numbers before they go in is open.
6. Section-list gaps the draft left: hollow sections InfraBuild stocks but the list lacks (for example RHS 102x76, 127x51, 152x76, 300x200x6, SHS 30x30x2.5) were not added; tee names (steelweb rounds the mass in the name, 305BT62 for 62.4 kg/m).
7. The C purlin rules and the Z purlin side elevation (E1 item 2) need Tim's explicit yes or change.

### E3. What the code would need to learn when this is built (card section 8; not started)
New list fields `widthNarrow` (Zed second flange), `thickness` versus `nominalThickness` (angles), no `rootRadius` for welded WB/WC, `zyOtherSide` (PFC), and the BT / CT / RB / SQ / FB types. The list change must go in with the drawing-code change, together. The card's test proposal (unit tests of the line-rule table as the oracle, scale and break-line sizes, DIMSCALE/LTSCALE reading, a drawing-output comparison per member and view, and a Tim AutoCAD checklist not yet written) is a proposal only.

## F. Update 3 (19 Oct 2026): Tim answered the design chat's ten questions in the repo

Full text, with Tim's words: `decisions/2026-10-19_CEMEMBER_ANSWERS.md` (written by the design chat). Summary for the desk, and what it changes in section E2 above:
1. **DECIDED, warn not stop:** a DIMSCALE/LTSCALE mismatch warns, carries on and records a line in the log ("yes as per recommeneded"). (E2 item 1 closed.)
2. **DECIDED, lips shown:** purlin elevations show the lips ("yes"). The C purlin and the Z purlin side elevation show BOTH the flange line and the flange lip line ("kind of, it shows flange and flange lip if that makes sense?"; Z: "kin dof but same as per q3"), 18cont near side, 18hidden far side. Flange line one thickness in from the edge, lip line one lip depth in from the edge (lip depth from the Lysaght table; the draft list carries `lipDepth` for every purlin). **Still OPEN until Tim answers the picture shown to him on 19 Oct:** the exact lip line positions, any lip lines in the TOP elevation, and the C purlin top elevation rule (inferred from the PFC, not separately confirmed). (E2 items 2 and 7 partly closed.)
3. **DECIDED, deferred:** tees (BT, CT) and round, square and flat bars are NOT in the first release ("not for now"). Their data is kept apart in `04_REFERENCE/section_data_2026-10-18/section-catalogue_DEFERRED_tees_and_bars.json`; their line rules were never discussed. (E2 item 3 closed; E3 BT/CT/RB/SQ/FB fields are not needed for the first release.)
4. **DECIDED, no paid ASI tables:** "nope we can get from elsewhere". Tim will source hollow-section properties and top hat data from elsewhere. **OPEN until he sends them.** (E2 item 4 stays open for top hats.)
5. **DECIDED, hollow sizes added:** the 8 SHS and 23 RHS sizes InfraBuild stocks but the list lacked were added to the DRAFT ("yes"), properties calculated. The draft is now 12 types for the first release: UB 28, UC 13, PFC 10, WB 23, WC 18, EA 46, UA 19, SHS 100, RHS 106, CHS 37, Z purlins 16, C purlins 16. (E2 item 6 closed.)
6. **DECIDED, names with decimals:** supplier names such as 530UB92.4 and 310UB32.0 ("yep why not").
7. **Section numbers: plan agreed, check NOT done.** Tim accepted ("look good") the plan to check ten rows he knows by heart: 310UB32.0, 250UC72.9, 380PFC, 230PFC, 100x100x6 EA, 100x100x6 SHS, 200x100x6 RHS, 114.3 CHS, Z15015, 900WB282. The draft list still does not go into `section-catalogue.json` until that check is done and Tim says so. (E2 item 5 open.)
8. **APPROVED:** the CEMEMBER card `areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md` ("yes", 19 Oct 2026), subject to the lip line positions in item 2. **No code has started.** The Tim AutoCAD checklist is still to be written and agreed before code starts.
9. **Ruling A (pause on new plan items) is NOT lifted by this approval.** The desk reads the card approval as design approval only; whether to start building CEMEMBER now or after the 9 Nov Civil + Manager release is asked as QUESTIONS_FOR_MONDAY section H item 1. Nothing is built meanwhile.
