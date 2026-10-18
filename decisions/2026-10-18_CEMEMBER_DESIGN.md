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
