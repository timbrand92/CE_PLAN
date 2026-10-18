> **Where the files in this note live (added when it was pushed to this repo, 18 Oct 2026):**
> - The precise rules are in `areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md` (read that first).
> - `CE_Reference\Corrected_Draft\...` means `04_REFERENCE/section_data_2026-10-18/` in this repo.
> - The `...differences.txt` reports are in the same folder, renamed `differences_*.txt`.
> - Supplier PDFs and the raw steelweb.info page extracts were NOT pushed (third-party documents, size). They stay on Tim's PC.
> - Nothing here has been built, installed or tested in AutoCAD.

# CEMEMBER design session results (18 Oct 2026)

Written by the "CE_ACAD / structural / sbeam design / 01" chat for Tim to hand to the ideas 03 chat.
Nothing here is built, installed or tested in AutoCAD. Tim's words are in quotes.

## 1. What CEMEMBER is
- Replaces the old SBEAM command. Tim: the name "should change because its not only steel beams". Name agreed: CEMEMBER ("yep sounds good").
- Draws a member in three views: section, side elevation (looking at the web), top elevation (looking down over the web).

## 2. Drawing rules Tim confirmed
- Section: outline on 25cont, hatch with the existing 10H hatch (solid, colour 10, layer HATCH 10). A toggle for "in front" or "beyond". Beyond = outline only on 9hidden2 (colour 9, hidden2 linetype), no hatch.
- Elevations: extents on 25cont. Flange / web-to-flange lines on 18cont when on the near side, 18hidden when on the far side. Tim: "we keep flange lines on that layer and keep them".
- "we never put two lines on top of each other": the line closest to the viewer wins. UB/UC top elevation: no flange lines (they sit under the 25cont edges), web shown on 18hidden.
- SHS/RHS/CHS: inside walls on 18hidden in both elevations. Section hatch covers the wall only. Z purlin top elevation: top flange end edge solid 18cont, other flange edge 18hidden. Tim confirmed both pictures.
- Odd-shaped members (PFC, angles, Z and C purlins) come in four orientations. The orientation replaces the old Toward/Away switch. Tim confirmed the PFC and angle pictures.
- Points are picked west to east. Elevations: points 1 and 2 sit on centreline (default), top of member or bottom of member. Section: one point, chosen from nine positions on the box around the section (corners, middle of each side, centre). Tim: "section should offer everything".
- Break lines at the member ends: same Z-kink shape as Tim's BL command, on 18CONT. Size depends on the typed scale, not the beam size (1.5 mm overshoot and 2 mm kink on paper).

## 3. The window (Tim: "thats great")
- Left: member type and size, with a small properties box (depth, width, web, flange, mass, Ix, Iy, Zx, Zy).
- Middle: live preview, always shown.
- Right: view, orientation, in front/beyond (section only), points or base point, ends (both broken / start / end / closed; greyed for a section), scale as a typed number.
- Scale: default 100, read from the drawing's DIMSCALE. LTSCALE is always 10 times DIMSCALE in this plugin (20/200 or 100/1000), so it is only a check.
- Cancel, Place, and a Reset to default button. After a member is placed, Enter or Space reopens the window with the previous choices.
- After Place the window hides: pick point 1 then 2 for elevations, one point for a section. Escape cancels.

## 4. Section list problems found (the list is Modules/Structural/Assets/Config/section-catalogue.json)
Reports and extracted tables are in this folder tree:
- InfraBuild\section_list_vs_InfraBuild_differences.txt (UB, UC, PFC, EA, UA)
- InfraBuild\hollow_list_vs_InfraBuild_mass_differences.txt (SHS, RHS masses)
- BlueScope\welded_list_vs_BlueScope_differences.txt (WB, WC)
- Metroll\purlins_list_vs_Metroll_differences.txt and Lysaght\purlins_list_vs_Lysaght_differences.txt (purlins)

Summary:
- UB and UC: depth, width, flange and web all match InfraBuild. Root radii are 0.9 to 2.4 mm low on nearly all; 250UC90 has none. 150UB18 and 150UB14 have Ix and Zx about 10% low. Names are rounded (530UB92 should be 530UB92.4, 310UB32 should be 310UB32.0).
- PFC: all 10 rows differ in several fields (web and flange thickness, mass, Ix). Replace from InfraBuild.
- Equal angles: all 38 masses and Ix are about 0.63 of the real value. Thickness is nominal (16, 10, 8, 5) where the real thickness is 15.8, 9.5, 7.8, 4.6. Eight sizes are missing (55x55x6/5, 30x30x6/5/3, 25x25x6/5/3).
- Unequal angles: thickness nominal not actual, 75x50 radii differ.
- Tapered flange beams: Tim does not use them, so they are left out ("we dont use tfb so you can remove").
- Welded beams and columns: 31 of 33 rows differ from BlueScope (depth, flange, web). The list gives them root radii; welded sections have none. Eight sizes are missing (1200WB249, 1000WB215, 900WB175, 800WB122, 700WB115, 500WC228, 400WC144, 350WC197).
- SHS/RHS/CHS: 101 rows had no mass although InfraBuild lists it; about 27 of 35 comparable masses differed by 3 to 6%. steelweb.info then filled Ix and Iy on 95 rows and mass and Ix on 11 CHS rows. Three Ix values (200x200x5 SHS, 150x150x5 SHS, 200x100x5 RHS) were wrong in the list. The gaps that remained after that were filled in round 2 (next bullets).
- A corrected DRAFT list is in Corrected_Draft\section-catalogue_CORRECTED_DRAFT.json with a plain-English summary in Corrected_Draft\WHAT_CHANGED.md. It is not in the repo and not installed.
- Purlins: Tim uses Lysaght. Lysaght sells Zeds and Cees as Z/C10010 to Z/C35030 (16 catalogue numbers, 100 to 350 deep). The list has ZC400 and C40030, which are not in Lysaght's table, and its widths and lips differ from Lysaght. Z purlins have unequal flanges (e.g. 102 deep, 53/49, lip 12.5). The old code draws equal flanges, and the lips are ignored in the elevations.
- Round 2 (Tim: "can we finish the not done items?"): the draft list now has every row filled. Hollow sections: the old Ix was 40 to 75% out on large SHS (400x400x16 had 328, real about 570); 60 rows replaced by steelweb figures or a checked calculation (corner radius 2.5t, off by 0.65% in the middle and 6.6% at worst against steelweb). Lysaght purlin properties read for all 32 rows. PFC weak-axis zy, angle Iy, tees cut from UB and UC (BT, CT), round, square and flat bars added. Top hats: no source found. Details in Corrected_Draft\WHAT_CHANGED.md.

## 5. Sources used (all downloaded by this chat with Tim's go-ahead)
- InfraBuild Hot Rolled and Structural Steel Products, 9th edition, Oct 2019.
- InfraBuild Know Your Steel V11, April 2025 (stock mass tables).
- BlueScope Welded Beams and Columns brochure.
- Metroll Standard Purlins and Girts guide, Feb 2018 (not Tim's brand).
- Lysaght Zeds and Cees Purlins and Girts User Guide.
- steelweb.info (Tim's link): free site, "no guarantees", last updated Dec 2020. One page per section with mass and Ix and DXF/DWG downloads. Tim: "steelweb.info is good for a lot fo things". All 142 hollow section pages were read (saved as steelweb_hollow_pages_extract.json) and used for hollow section Ix, Iy and some masses; the angle, channel, beam, Tee and purlin pages were not read. steelweb.org asks for a login.
- Not found: a current official table for SHS/RHS/CHS properties (Ix, Z). The ASI Design Capacity Tables are paid.

## 6. Still open
- Whether the DIMSCALE/LTSCALE check should warn or stop.
- Which extra member types to add (T bars, flats, round, square, top hat).
- Where the corrected section list should come from for hollow sections (properties), and who checks the numbers before they go in.
- C:\CE_PLAN and C:\TimOS were not on this PC, so none of the above is in the plan repo yet.
