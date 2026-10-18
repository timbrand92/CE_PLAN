# Corrected section list - DRAFT for Tim to review (18 Oct 2026, round 2)

File: `section-catalogue_CORRECTED_DRAFT.json` (same folder). It is a copy of the plugin's
`section-catalogue.json` with supplier numbers. It is NOT installed and NOT in the repo.
Every row says where its numbers came from. Calculated numbers are labelled `calculatedFields`.

17 types now: UB 28, UC 13, PFC 10, WB 23, WC 18, EA 46, UA 19, SHS 92, RHS 83, CHS 37,
Z purlins 16, C purlins 16, BT 23, CT 15, round bar 26, square bar 6, flat bar 66.
Every row now has a mass, Ix, Iy, Zx and Zy, except where noted below.

## What changed, type by type

- **UB (28) and UC (13):** same sizes, from InfraBuild. Root radii corrected (they were 0.9 to 2.4 mm low), 250UC90 gets its missing radius, 150UB18 and 150UB14 get the right Ix and Zx. Names use the supplier designation (530UB92.4, 310UB32.0, 100UC14.8).
- **PFC (10):** all rows replaced from InfraBuild (web and flange thickness, mass and Ix were wrong). `zy` is the smaller of InfraBuild's two weak-axis values; the larger is `zyOtherSide`.
- **WB (23) and WC (18):** from BlueScope, up from 18 and 15 rows, eight sizes added. Welded sections have no root radius, so the old radii are gone.
- **EA (46) and UA (19):** from InfraBuild. Eight equal-angle sizes added. `thickness` is now the real rolled thickness (15.8, 9.5, 7.8, 4.6) and `nominalThickness` keeps the name value. Mass fixed. `ix` is the major principal axis and `iy` the minor one, both checked against steelweb.info.
- **SHS (92), RHS (83), CHS (37):** same sizes.
  - Mass: from InfraBuild where listed, otherwise calculated from the shape.
  - Ix and Iy: from steelweb.info for 95 rows, calculated for the rest.
  - Zx and Zy: Ix or Iy divided by half the section width (calculated).
  - **The old Ix was far out on 60 rows (25 SHS, 19 RHS, 16 CHS).** The big SHS were worst: 400x400x16 SHS had 328, the real figure is about 570. The old figures are kept as `ixOld`.
  - How the calculation was checked: it uses a corner radius of 2.5 times the wall thickness. On the 95 rows that have steelweb figures it is off by 0.65% in the middle and 6.6% at worst (small tubes). CHS use the exact tube formulas.
- **Z purlins (16) and C purlins (16):** Lysaght Zeds and Cees, Z10010 to Z35030 and C10010 to C35030. `ZC400` and `C40030` are gone (Lysaght does not make 400 deep). Z has two flange widths (`width` broad, `widthNarrow` narrow). Area, Ix, Iy, Zx and Zy are read from the Lysaght properties table for all 32 rows (axes parallel and perpendicular to the web), each checked against area and radius of gyration.
- **BT (23) and CT (15), new:** tees cut from UB and UC, from steelweb.info (mass, size, Ix, Iy).
- **Round bar (26), square bar (6), flat bar (66), new:** sizes and mass from the InfraBuild catalogue (every mass matches the shape). Ix, Iy, Zx and Zy are calculated.
- **TFB:** not added. Tim does not use tapered flange beams.

## Still not done
1. **Top hats:** no source found, so none added.
2. **Drawing code:** it does not yet use `widthNarrow`, the actual angle thickness, the welded no-radius rule, the new tee and bar shapes, or the lips in the elevations. The list change must go in with the code change.
3. **Weakest numbers:** calculated hollow-section figures and anything from steelweb.info (a free site, no accuracy guarantee, last updated Dec 2020). The paid ASI Design Capacity Tables are the proper check.
4. **Hollow sections stocked by InfraBuild but missing from the list** (RHS 102x76, 127x51, 152x76, 300x200x6 and others, SHS 30x30x2.5 and others) were not added.
5. **Tee names:** steelweb rounds the mass in the name (305BT62 for 62.4 kg/m).

## Checks done
- Mass worked out from the cross-section agrees with the listed mass within 7% for every UB, UC, PFC and WB/WC row, and within 6% for every angle.
- No duplicate names.
- Not done: nobody has opened these sections in AutoCAD, and Tim has not checked the numbers.
