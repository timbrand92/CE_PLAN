# Guidebook v1.3 versus CE's engineering: audit, 29 Oct 2026 (stage 1 of decisions\2026-10-29_TIM_ANSWERS.md item 23)

**Read-only audit.** Nothing was changed in code, Settings, the live bundle or the guidebook. Nothing here is a decision; every "who is probably right" is my reading, and engineering calls stay Tim's (RULES 4.5).

**What was read.** The guidebook PDF (all 53 pages rendered and checked against the .docx text; every table and picture looked at: cover table, pit and pipe tables, grate classes, Boyd's, OSD4W, orifice, pump, soakage, thumb rules, council pages). CE side: `ENGINEERING_RULEBOOK.md`, `SETTINGS_ROWS_PLAN_2026-10-08.md`, and the Civil code **exactly as installed on Tim's PC** (build 3.0.85, commit 09126560, read from git, not the old `master`).

---

## 0. ONE-PAGE ANSWER (read this and stop if you like)

1. **CE already matches the guidebook on most council numbers.** Kingston, Frankston, Mornington, Monash, Darebin, Whitehorse, Boroondara and Bayside agree on method, storm frequency, minimum orifice and share underground. The pit-size-by-depth table matches exactly.
2. **Eleven places CE differs and the book is probably the one to trust or needs an engineer's call:**
   1. **Minimum pipe grade.** The book says 1 in 100 for everything (page 48) and 1 in 200 only for detention pipes 225 and up in four councils. CE uses a size ladder: 1:100 up to 150, 1:200 at 225, 1:250 at 300, 1:300 at 375, 1:200 for 450 to 750, and 1:200 detention everywhere. A 300 pipe at 1 in 250 passes CE but breaks the book. (Tim's item 19: the book decides; the book gives no figure by size above 1 in 100.)
   2. **Cover.** The book prints the whole AS/NZS 3500.3 cover table (page 19, 100 / 300 / 450 / 600 / 750 by surface). CE holds one office number (300) plus a council override.
   3. **Minimum pit depth by pipe size** (page 48) is **missing** in CE. A 450 detention pipe needs a pit at least 781 deep; nothing warns.
   4. **Banyule 65% rule** (page 42, single dwelling needs detention over 65% impervious) is probably **not built** in CE. The symbol in front of "65%" is blank in the book itself; Banyule's own document says "greater than 65%". Tim already ruled it (UX-CR-13).
   5. **Rainfall.** The book's own Boyd's sheet uses BOM site rainfall that is **5 to 8 per cent higher** than CE's fixed Melbourne curve (storage moves about 2.5 times as much). CE's curve is about 4 to 6 per cent higher than the OSD4W "Melbourne" zone the company actually prints. So CE sits between the two.
   6. **Glen Eira.** The book says the whole detention may sit in tanks; CE still carries a 50 per cent underground rule.
   7. **Banyule underground share.** Book 50 per cent "good practice"; CE 100 per cent (from the council's own 2019 document: CE is probably right).
   8. **Step irons.** Three numbers in play: CE 900 deep, the book "600 x 900 pit, up to 1200, step irons required", and the real company drawing's general note says deeper than 1200.
   9. **Pumps.** CE sweeps storm durations; the company pump sheet uses one fixed 2-hour storm. The book says wet well minimum 3 m3; CE only warns below 3 m3 (company jobs go as low as 0.82 m3).
   10. **Grate class on driveways.** The book's load chart puts residential driveways in Class B; CE's pit chooser puts driveways in Class C.
   11. **Maroondah 1 in 20** for sites falling to the rear is warning text only, not a calculation.
3. **The biggest gap is not a number, it is a check.** The book's RFI lists (page 32 to 38) are the reasons councils bounce drawings. CE checks **none** of them as a "ready to submit" test (splay offsets, roof hatch legend, overland arrows, IO at every bend, all pits scheduled, SN8 under garages).
4. **The book contradicts itself in six places** (section 2). Engineers must settle those before we copy any number from them.
5. **Computations sheet.** CE's sheet is a tidy two-page-plus draft with a "figures not settled" warning and a where-it-came-from block. The company's real package is the OSD4W printout plus the detention and orifice spreadsheet page (pipe by pipe, pit by pit, tanks, orifice head). CE shows less working than the company sheet and more honesty about unknowns. I could not find a CE sheet from a fully filled real job, only two synthetic test sheets.
6. **A stale line in the Settings plan:** the 8 Oct "check as Settings values" note ("orifice only above 12 L/s"; "1:200 for 225 and greater") came from v1. The 12 L/s rule is **gone** in v1.3 and 1:200 is **four councils only**. Corrected in section 6.
7. **Five questions Tim most needs to answer** are at the end of the questions file.

---

## 1. GAP LIST

**How to read each line.** Classes: **MATCH** (CE agrees), **DIFFERS** (CE and book disagree), **BOOK SILENT** (CE holds a value the book does not give), **CE MISSING** (book states it, CE does not do it). Page numbers are the book's printed pages (same in the PDF).

### A. Pipes, cover and pits

1. **Minimum pipe grade (p16, p48) | DIFFERS.**
   1. **CE:** 90/100/150 = 1:100; 225 = 1:200; 300 = 1:250; 375 = 1:300; 450 to 750 = 1:200 (Settings `minGradeByDiameter`, "AS/NZS 3500.3 Table 7.2 seed"). Detention pipes 225 and up: 1:200, every council (`minDetentionPipeGradeRatio`).
   2. **Book:** "Minimum pipe slope 1 in 100" (thumb rules, p48; "min 1:100 for gravity pipes", p16). 1:200 for detention pipes 225 and up only in Darebin, Banyule, Manningham, Maroondah (p41 to 45). The book cites clause 6.3.4 for gradients; CE's code comment cites "Table 7.2". I cannot check the Standard (the copies on file are the 2003 edition), so I cannot say which citation is right.
   3. **Likely right:** unclear. The real 2026 company drawing I looked at draws detention pipes at 1 in 194 and 1 in 203 and downpipes at 1 in 100 to 1 in 107, which supports CE's 1:200 for detention and the book's 1:100 for small pipes. For 300 and larger **gravity** pipes the book's 1:100 is steeper than CE and the book gives no size ladder. Needs an engineer.
   4. **Drafter sees:** a 300 UPVC at 1 in 250 passes CE and would fail a 1:100 check.
2. **Manningham detention grade (p44) | DIFFERS.** CE 1:180 (council's 2021 checklist), book 1:200. CE is probably right (the council's own document is newer and steeper). Book probably stale.
3. **Cover (p19 table, p37 Frankston) | DIFFERS.**
   1. **CE:** one office number, 300 mm (Settings; the rulebook text that still says "seeded 450" is out of date), council value overrides (Frankston 250). Cover is to be measured to the outside top of the pipe (Tim item 17).
   2. **Book:** AS/NZS 3500.3 Table 6.2.5, "finished surface to top of pipe". Plastics: 100 (single dwelling, no vehicles), 300 (other buildings, no vehicles), 450 (vehicles, no pavement), 100 or 75 below reinforced or plain concrete, 600 sealed road, 750 unsealed road or construction loading. Frankston adds "all pipes min 250".
   3. **Likely right:** the book (it is the Standard's table). CE's single 300 is the right figure for a unit-development garden and the wrong one in a driveway (450 unpaved) or road reserve (600).
   4. **Drafter sees:** a pipe under a driveway slab with 120 cover passes CE and is correct (100 under concrete); a pipe under an unpaved vehicle area at 300 passes CE and fails the table.
4. **Minimum pit depth by pipe size (p48) | CE MISSING.**
   1. **Book values** (300 cover, StormPro): 150 = 459, 225 = 543, 300 = 622, 375 = 701, 450 = 781, 525 = 862, 600 = 939, 750 = 1083, 900 = 1236 mm.
   2. **Check I made:** every figure equals 300 plus the pipe's outside diameter minus its wall (outside diameter minus inside diameter, halved), from the StormPro table on p18. So CE can calculate it from pipe data, not hold a list.
   3. **Drafter sees:** a 450 detention pipe in a 700-deep pit is shown as fine; the book says it cannot have 300 cover.
5. **Pit size by depth (p16) | MATCH** (350 to 450 deep, 450 to 600, 600 to 900, 600 x 900 to 1200, 900 x 900 over). CE's pit chooser uses exactly these. **Not a gap with the book; a gap with R-00:** the table is built into the code, not on Settings.
6. **Pit size by pipe size (p16 "refer Fig 09") | BOOK SILENT.** The book gives no pipe-to-pit table; CE has one (to 100 = 350, to 150 = 450, to 375 = 600, to 450 = 600 x 900, over 450 = 900 x 900) of unknown source.
7. **Step irons (p16, drawing note) | DIFFERS.** CE: deeper than 900 (CR-A5). Book: 600 x 900 pits (900 to 1200 deep) "step irons required". The company's general drawing note: "deeper than 1200". Same job, two depths printed.
8. **Minimum pipe size 100 (p48) | MATCH.**
9. **Sewer-quality / SN8 pipes, and "all pipes under the garage 150 UPVC SN8" (p32 to 38 RFI) | CE MISSING** as a check. CE knows "UPVC SN8" as a material only.
10. **No detention pipes under dwellings or garages (p16) | CE MISSING.** The book contradicts itself: the RFI lists then say what to use "under the garage" (150 UPVC SN8).
11. **Pipes and pits 1 m clear of the splay; sewer ties 1 m offset (p16, RFI) | CE MISSING.**
12. **Grate and lid class (p48 chart) | DIFFERS.** Book: A pedestrian only, **B private driveways and unit sites (low speed)**, C residential roads and car parks, D roads, E freeways. CE: default C, and "trafficable or driveway" maps to C. A unit-development driveway is B by the chart.

### B. Detention, orifice, water tanks

13. **Orifice head, constant, rounding (p20, p21 sheet) | MATCH in direction, one trap.**
    1. Book sheet: head measured to the **centre** of the orifice (plate height minus half the diameter), Co 0.6, g 9.8, "adopt" 57 mm for 4.27 L/s. The company's real sheet does the same (65 mm, plate 510, head 0.4775).
    2. CE: head to centre (R-18), Co 0.6, round **down** to whole mm (CR-A3). g: the code constant is 9.8 but a Settings switch (default ON) uses 9.81; 0.1 per cent, no change to a whole-mm answer in the cases I checked.
    3. **Trap:** CE's code comment gives a "worked anchor" using the plate height (0.428 m) as the head and gets 55 mm; the book's sheet for the same flow gets 57 mm. I did not run the live path, so I cannot say whether the live path uses the centre head everywhere (rulebook B11 said four engines once disagreed).
14. **Lid-to-baffle clearance 100 mm; two 600 x 600 chambers; 100 walls, 150 base (p20, councils) | MATCH** (CE office default 100; council warning text).
15. **Minimum orifice (council pages) | MATCH** where the book states one: Monash 65, Mornington 65, Whitehorse 90. **BOOK SILENT:** CE also holds Darebin 30, Banyule 40, Manningham 40, Maroondah 40, Casey 50, Maribyrnong 40, Yarra Ranges 40 from the councils' own documents.
16. **Share of detention underground (council pages) | MIXED.**
    1. **MATCH:** Frankston 50, Mornington 50, Monash 60, Bayside 50, Darebin 50, Boroondara 100, Kingston none.
    2. **DIFFERS, Banyule:** book "good practice 50", CE 100 (council 2019 document says all below ground). CE probably right.
    3. **DIFFERS, Glen Eira:** book now says the **entire** detention may be tanks; CE still says 50. CE stale.
    4. **BOOK SILENT:** CE holds Manningham 50.
17. **Method, storm frequency, coefficients by council | MATCH** for Kingston (council gives PSD, 1 in 5, C 0.4 fixed, Tc 5 under 1000 m2), Glen Eira (OSD4W), Mornington (OSD4W, 1 in 2 PSD, 1 in 10 storage), Darebin (OSD4W, 0.4 to 0.8, Tc 10, Tso 5, 1 in 5 and 1 in 10), Whitehorse (1 in 5 and 1 in 10), Frankston (Boyd's, C 0.35, 1 in 5, 5 min), Banyule/Maroondah (OSD4W). **DIFFERS or unclear:**
    1. **Casey:** book v1.3 moves Casey to the growth-area EDCM group (MUSIC model, reuse), yet its own Table 1 (p9) still lists Casey under Boyd's. CE has "Casey = council-provided, 50 mm, own formula". Cannot tell which is current.
    2. **Port Phillip:** book Table 1 says Boyd's; CE says council-provided; p47 says most Port Phillip jobs need no detention.
    3. **Cardinia, Hume, Melton, Wyndham, Whittlesea, Mitchell:** CE has one "growth-areas" profile; I did not find a Cardinia entry or the "professional registration number" submission item.
    4. **Brimbank, Dandenong, Hobsons Bay, Nillumbik, Merri-bek:** no profile in CE (generic default only). **CE MISSING.**
18. **Banyule 65% impervious trigger (p42) | ALREADY KNOWN TO CE_PLAN, build status not checked.** The symbol before "65%" is blank in the book (PDF and .docx), but Banyule's own 2019 document says "greater than 65%" (`COUNCIL_BANYULE_2019.md`) and Tim ruled UX-CR-13 (Design states the trigger at the start). I found no 65% rule in the installed code, so it is probably not built.
19. **Maroondah 1 in 20 for rear-falling sites (p45) | PARTLY.** CE carries it as warning text on the Maroondah profile only (no calculation). Tim ruled UX-CR-16 for the same kind of rule on Banyule jobs ("ask once"); I did not check whether that is built.
19a. **Industrial sites (p8) | CE MISSING as a test.** Calculate the 1 in 10 flow from the site's impervious area; detention is needed only if the existing outlet stub carries less than that; also find the 1 in 100 overland path. CE has no "does the stub cope" check.
20. **Kingston tank rules (p32) | MATCH** (500 L off every 2000 L; over 2500 L needs an orifice and 1000 L minimum; 50 m2 roof). **Manningham reuse 0.25 x SSR x roof ratio (p44) | MATCH.**
21. **Charged system, 300 mm head, 135 degree bends not 90 (p22, p48) | PARTLY.** CE has the 300 head check (Settings, default ON). No 135 degree preference check. The book says "300 mm between the top of the gutter and the top of the tank" (p48) while the company drawing's charged-system note says "sole of the rainhead to the invert of the tank entry". I did not check which datum CE measures from.
22. **Pervious runoff coefficient (p10, p11 sheet) | DIFFERS INSIDE THE BOOK.** Text says 0.3; the book's own Boyd's sheet works with 0.35 (414 impervious, 332 pervious gives 488.8 effective area only at 0.35). CE follows Tim's CR-A1 ruling (0.35 whole site before development, 0.30 soft ground after). No change recommended; engineers should fix the book's sentence.
23. **Rainfall curve (p10 sheet, p15 OSD4W) | DIFFERS.** Book Boyd's sheet (BOM revised IFD, per site): 1 in 5 for 5 min 95.3 mm/h; 1 in 10 for 5, 10, 15, 20, 25, 30 min = 113, 85.3, 69.7, 59.4, 52, 46.5. CE fixed Melbourne curve: 88.8 (1 in 5, 5 min); 105.0, 78.7, 64.6, 55.6, 49.2, 44.4. So the book is **5 to 8 per cent higher**. The OSD4W Melbourne zone printout (company report, book p15 screenshot): 1 in 5 for 10 min = 63.0; CE = 66.7 (6 per cent higher); 1 in 10 at 18.7 min: OSD4W 55.2, CE 57.7. **Likely right:** for Boyd's, the book's method (BOM per site); for OSD4W jobs, the software's own zone. This answers the "check the curve against the guidebook" part of item 16 (no curve value changed).

### C. Pumps, soakage

24. **Pump wet well (p23 to 25) | DIFFERS.** Book: 1 in 10 in-ground, 1 in 100 basement, 3 m3 minimum, flow not above PSD, **one fixed 2-hour storm** and 30 minutes pumped (sheet p24). CE: sweeps storm durations (like Boyd's), 30 minutes, 1% of catchment term, **no fixed floor** (R-14, warns under 3 m3), and Bayside forced to 1 in 20 from an unsourced rule. Company evidence: median wet well 5.1 m3, smallest 0.82 m3.
25. **Soakage (p26 to 27) | PARTLY.** CE has a sizer built on "one storm, soil K in L/s per m2, Atlantis module". Book: sweep of storm durations to 1 in 100, soil Kh in mm/h with a **moderation factor** (sand 0.5, sandy clay 1, clay 2), **set-back from structures by soil** (sand 1, sandy clay 2, rock 2, medium clay 4, heavy clay 5 m), Kingston/Frankston/Mornington minimum Kh 100 mm/h. CE has none of the set-backs or factors.

### D. Drafting and the "ready to submit" check (p28, p32 to 38)

26. **RFI lists | CE MISSING.** Items the book says councils ask for: roof hatch and hatch legend in m2 per dwelling (Kingston, Monash, Frankston); overland flow arrows and legend (same three); distance of pipes and pits at least 1 m from splay; crossover width; spot levels at corners and near pits; tank size and dimensions; all pipes sewer quality; 150 UPVC SN8 under garages; permeable paving detail; IOs at every change of direction; all pits scheduled including plastic (Kingston); pump wet well impervious (Kingston); soakage set-backs; owners agreement for shared assets (Bayside); no groundwater to kerb (Bayside); pavement cross-section 125 thick, 1 in 30 (Frankston). CE draws the overland flow symbol and the pit schedule but checks no list.
27. **Drawing contents list (p28) | PARTLY.** CE places the OSD criteria table and pit schedule; the other nine items are standard details CE's detail selector holds. The real 2026 drawing carries all of them.
28. **Council submission facts (fees, portal, endorsed plans, declaration) | CE MISSING** as data. Guidebook v1.3 changed Glen Eira and Bayside from email and no fees to portal and fees.
29. **Guidebook version on the job | CE MISSING** (Glen Eira, Mornington and Whitehorse changed method between versions).

### E. Things the book is silent on that CE holds

30. **Velocities, roughness, Manning's n, surcharge, freeboard | BOOK SILENT.** The book names no maximum or minimum speed and no roughness. CE holds 0.6 m/s minimum, 3 / 6 / 4 / 6 m/s maximums by material and n 0.013 as placeholders. So the guidebook cannot settle the UPVC 3 versus 6 m/s question (Settings plan Q1); Tim has asked for an authority.

---

## 2. WHERE THE BOOK CONTRADICTS ITSELF (engineers must settle before we copy)

1. **Version:** the cover says 1.3, every page header says 1.2.
2. **Casey** is Boyd's in Table 1 (p9) and EDCM growth-area in the council pages (p46). **Banyule** is "council gives PSD" in Table 1 but "use OSD4W" on its own page (p42). **Manningham** sits in two Table 1 groups. Dandenong's email address in Table 1 is misspelt ("coucnil@").
3. **Pervious C:** 0.3 in the text, 0.35 in the worked sheet.
4. **Detention minimum grade:** 1 in 100 for all pipes (p48), 1 in 200 for four councils (p41 to 45).
5. **Under the garage:** "no detention pipes under garages" (p16) versus RFI "all pipes under the garage 150 UPVC SN8".
6. **Banyule** "65%" has a missing symbol. **Whitehorse** is Boyd's in Table 1 but has no method named on its own page.

---

## 3. THE COMPUTATIONS SHEET (rule 5.1: opened and looked at)

**What I opened.** (a) A real CE CDCALC export from a test copy, 18 Oct 2026, 3 pages (synthetic job, nothing filled in). (b) The company's blank sheet template, one page. (c) The package the company sent for one real 2026 two-unit job in an inner south-east council (job details withheld): the OSD4W printout, the detention and orifice spreadsheet page, and the A1 drawing sheets that carry the criteria table and pit schedule. Client material was read and rendered in a temporary folder outside every repository, deleted at the end of this session; nothing client-named is in C:\CE_PLAN.

**CE sheet, in plain words.**
1. Page 1: Creative Engineering logo top left; "CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS" top right in blue; a blue rule; a job strip (job number, site, council, engineer, revision, date, page, issue state) reading "not stated" where nothing was entered.
2. A dark red line: "THIS SHEET HAS FIGURES THAT ARE NOT SETTLED".
3. Four blue-headed blocks: Basis of design; On-site detention; Storage provided; Where these figures came from. Plain sentences, "not known" with the reason, storage shortfall in litres and cubic metres.
4. Pages 2 and 3: plain grey-bordered tables (pipe flow with Manning's n, 300 at 1 in 100 giving 96.7 L/s and 1.37 m/s; rational method catchment, total 6.88 L/s). **They carry no logo or job strip, only a footer** ("Job number not stated | DRAFT NOT FOR CONSTRUCTION | Page 2 of 3"). Page 3 still begins a line with "Note:".
5. Footer on every page; page 1 is half empty.
6. **Not seen:** the pipe-by-pipe and pit-by-pit volume tables and the orifice block that the test list says appear on a filled job. The test job had no storage, so they did not print.

**Company sheet, in plain words.**
1. Page 1 is the OSD4W printout, plain monospaced text, nine numbered blocks: client, job reference, areas and runoff coefficients (existing 169 m2 at 0.90 and 520 m2 at 0.30, weighted 0.45; proposed weighted 0.67), catchment times (Tc 10, Tso 5), storm frequencies (1 in 5 outflow, 1 in 10 storage), permitted discharge 6.18 L/s, storage 3.82 m3, time to fill and empty, critical duration 18.7 min, rainfall used.
2. Page 2 is the office spreadsheet printed: logo, page / job / date / designer strip; pipes by diameter with length and volume; pits by size with depth and volume; water tanks WT1 and WT2; total storage 4.01 m3 against 3.82 required; then a yellow "Discharge control, orifice" band: PSD 6.18, formula, Co 0.6, g 9.8, orifice 65 mm, plate height 510 mm, head 0.4775 m, flow 6.0 below 6.18, "Adopt 65 mm".
3. The same figures are repeated on the A1 drawing in the "On-site detention criteria" box (PSD, head, orifice, TWL, volume required, the breakdown, total) and the pit schedule.
4. The blank template (grid paper, page / project / engineer / date, project address, company footer) is what handwritten or Word calculations go on.

**What the company sheet shows that CE does not.**
1. **The OSD4W input sheet** (areas, coefficients, Tc, Tso, frequencies). CE says "storm frequency not known" where the job has none, and prints no coefficient breakdown on the first page.
2. **Pipe-by-pipe and pit-by-pit volume working** and tank volumes in one table (CE only on a filled job, not seen).
3. **Orifice working with the plate height and head** on the same page as the storage.
4. **Consistency with the drawing:** the same numbers sit in the drawing's criteria box. CE has a draft-versus-drawing check planned; not seen working.

**What CE shows that the company sheet does not.**
1. A "figures not settled" warning, issue state, draft banner, and a "where these figures came from" block.
2. Council named on the sheet; engineer and revision strip with "not stated" rather than blank.
3. Separate pipe-flow and rational-method pages.

**What I could not find or check.** A CE sheet from a fully filled real job; the Boyd's or Kingston printout for a job (this job used OSD4W); a council declaration or checklist form in the package (none in the folder I looked at); the pump and soakage sheets for a real job.

---

## 4. PLUGIN CHANGES NEEDED (plain list; nothing implemented; each needs a card and Tim's approval before code)

**Grouped like production commands.** Every value below goes on Settings first (R-00); every check warns and records, never blocks (R-27).

### Pipes and pits (CD, PIT, Edit Pipe, CDRULES)
1. **Minimum grade table.** Replace the size ladder with the guidebook rule once engineers answer question 1: new Settings rows "Minimum grade, all gravity pipes" and "Detention pipe minimum grade by council". Today's ladder stays as the fallback until then.
2. **Cover table by surface and material.** New Settings table from Table 6.2.5; the pipe strip picks the row from the pit's lid class or surface use. Needs Tim's sign-off on the profile shape (already open in the council integration spec).
3. **Minimum pit depth check.** New warning: pit depth must be at least 300 cover plus the pipe's outside diameter minus wall; pipe data supplies the sizes. Cover comes from change 2.
4. **Pit size by depth table to Settings** (same values).
5. **Grate class chart** on Settings (A to E, by use); driveway default pending question.
6. **Step iron rule** one number, shown with its source.
7. **New Settings group "Drafting checks":** pipe-under-building check, splay offset (1 m), sewer-tie offset (1 m), SN8 under garages.

### Calculations (CDCALC, CDTWL, CDRAINFALL)
8. **Banyule 65% trigger** and **Maroondah / Banyule 1 in 20 rear-fall** as council profile fields (both already ruled by Tim: UX-CR-13, UX-CR-16; build status to be checked before a card).
9. **Glen Eira:** remove the 50 per cent underground default once confirmed; mark Banyule 100 with its source.
10. **Guidebook version on the job** and "profile last checked against version" on every council profile.
11. **Rainfall source note** on every sheet; optional site-specific BOM intensities for Boyd's jobs (a new card, because it changes storage by up to about 20 per cent).
12. **Sheet content:** show the OSD4W-style input block (areas, coefficients, Tc, Tso, frequencies) on page 1; put the logo and job strip on every page; remove "Note:" from the rational-method page; one orifice block with plate height and head.
13. **Pump card:** decide fixed 2-hour versus sweep, 3 m3 floor versus warning, and the Bayside 1 in 20 source (Area H owns it).
14. **Soakage card:** add moderation factor, set-back table and 1 in 100 sweep to the soakage sizer.

### Council data and submission
15. **New profiles:** Cardinia (with registration number item), Brimbank, Dandenong; confirm Port Phillip and Casey.
16. **Submission block per council:** portal or email, fees, endorsed plans, declaration, the council's address.

### "Ready to submit" check (new command card)
17. **RFI checklist per council** from pages 32 to 38 as a list the drafter ticks or the plugin checks from the drawing, with the five shared items for every council. This is the highest-value new card.

---

## 5. WHAT I CORRECTED IN THE EARLIER CE_PLAN NOTES

1. **SETTINGS_ROWS_PLAN_2026-10-08.md, update item 4 ("from the guide: minimum detention pipe grade 1:200 for pipes 225 and greater; an orifice is required only above 12 L/s")** is from v1. In v1.3: the 12 L/s rule is **removed** (Whitehorse), and 1:200 is **Darebin, Banyule, Manningham and Maroondah only**. CE already keeps 12 L/s blank on the council profile, which is now right. CE's 1:200 detention rule applies to every council, which the book does not say.
2. **CE_DESIGN_GUIDEBOOK_RULESET.md** (v1) row "Glen Eira Boyd's C 0.35" is superseded (already noted); additionally its "Darebin, Banyule, Manningham, Maroondah 1:200" is right for v1.3 but Manningham's own 2021 checklist says 1:180.
3. **CE_GUIDEBOOK_V1_3_SUPERSEDES.md** said the minimum pit depth table "sits alongside" the pit-size table; I confirmed every value is derivable (section 1, item 4) and that the book prints **"Version 1.2" on every page header** while the cover says 1.3.
4. **ENGINEERING_RULEBOOK.md R-04** still reads "office standard seeded 450 mm"; Settings holds 300 (Tim 24 Sep).
5. **COUNCIL_DIFF_V1_TO_V1_3.md** is right on method changes; it did not note that Casey and Whitehorse Table 1 entries were not updated to match their own pages.

## 6. NOT CHECKED

1. I did not run AutoCAD or the plugin; every CE value is read from the code at commit 09126560.
2. I could not read AS/NZS 3500.3 (no current copy), so I cannot say which table number is right for grades.
3. I did not check which of CE's draft pull requests since 28 Oct change any of these values.
4. Boroondara's baffle plan-and-section, Darebin outfall scales (1:250 and 1:25) and Mornington standard drawings were not looked for in CE.
5. The council websites were not checked; the book's council pages are a summary, not the council's own text.
