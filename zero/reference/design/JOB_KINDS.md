# Job kinds register (K-)

Each kind of civil job the office does, one item each: what makes it that kind, what is needed, what is decided in what order, which sums are used and what lands on the sheet. Re-filed from the evidence on Mon 16 Nov 2026. Nothing here is confirmed by the owner unless a D-number is quoted.

One job is often several kinds at once (CIV-04 is K-004 and K-005; CIV-05 is K-005 and K-010; CIV-08 is K-008 and K-009; CIV-10 is K-006, K-007 and K-012). Look up each kind that applies.

## How to add to this file

1. Take the number on the last line ("Next free number"). Never reuse or renumber.
2. Copy the ten headings below in the same order and fill every one; write "Unknown" (with the Q-number if there is one) rather than leaving one out.
3. Point to sums by S-number, limits by L-number, elements by E-number and councils by C-number. If a sum or element is new, add it to its own register first.
4. Use coded jobs only (JOB_A/B/C, CIV-01..13). No client, address, job number or staff name.
5. Finish with an "Evidence:" line and move "Next free number" on by one.

## Fixed headings for every item

1. **Trigger** (what in the council letter or site makes it this kind)
2. **Inputs needed**
3. **Decisions in order**
4. **Sums used**
5. **What the drafter is handed**
6. **What lands on the sheet**
7. **Checks**
8. **Example job code and its key numbers**
9. **Seen dates**
10. **Unknowns**
11. **Evidence** (written as the closing line)

## The common path on every kind (not repeated below)

1. **What arrives:** quote documents first (town planning drawings, sometimes a sustainability report and soil report); then the architect's CAD files; the council discharge letter (see `process\CIVIL_JOB_FLOW.md`); later drops (permit, endorsed plans, landscape plan, arborist report, survey, pit information).
2. **Order of issues:** set-up, mark-up, P1, sometimes P2, Rev A "for council approval", Rev B, C ... as the council asks, then the same drawing re-stamped "construction issue".
3. **Fixed frame on every sheet:** title block and revision list (E-043, E-045), issue stamp (E-046), warning boxes (E-037), general notes and disclaimer (E-038), legend (E-039), pit schedule (E-040), pipe bedding, junction pit and services details (E-047), plan title (E-066).
4. **How levels are set:** no single rule (D-016); the critical value governs the method (D-017); normally fixed on a tight site are the council connection invert, cover levels, and the top water level and orifice (D-018).

Evidence: STUDY_B section 1 "Common path"; ELEMENT_LIST "Across three civil jobs"; INTERVIEW items 8v, 8z, 8za.

---

## K-001 Plain house, no detention

1. **Trigger:** The council discharge letter is typed "single unit development", gives options for the discharge point and NO permitted discharge figure. No figure in the letter means no detention sum.
2. **Inputs needed:** Discharge letter and its options (kerb by gravity or pump; existing council pit in the nature strip; on-site infiltration subject to soil); underground services plans (ordered by the office on CIV-01); architect's CAD; survey levels; tank size and roof area to tank from the planning / sustainability side.
3. **Decisions in order:** (1) Choose the discharge option (CIV-01: council pit at the front). (2) Tank size and roof area to tank taken from the planning side. (3) Pits. (4) 100 pipes at 1 in 100. (5) Inverts back from the connection.
4. **Sums used:** Settled by D-019: levels and cover only are worked out; pipe capacity is not checked. So S-008 (grade), S-010 (cover), S-011 (depth to outlet), S-012 (pit size). No computations PDF was found on disk for CIV-01.
5. **What the drafter is handed:** CIV-01: two dated mark-up folders (engineer's mark-up, then drafting) one day apart, holding a drawing file and a "roof catchment area to water tank" sketch. Not viewed as pictures. Small house jobs are often done straight in the drawing by one person (D-025, D-030).
6. **What lands on the sheet:** Pipes and labels (E-001, E-006), flow arrows (E-007), pits with tags, cover and invert levels (E-008, E-012, E-013, E-014), downpipes (E-015), connection note "connect to council pit at approx IL 1.14 to council satisfaction, builder to confirm" (E-058), existing council drains labelled "depth to be confirmed" (E-005), a 3,000 litre underground reuse tank with its installation diagram (E-019, E-047), the council's standard notes (E-038), a note about the 1 in 100 year storm / overland flow (E-026), pit schedule (E-040). No detention criteria box.
7. **Checks:** Grade (L-001), cover (L-004), pit size by depth (L-006), clearances (L-013). Owner's list before issue: levels and falls; plan matches the numbers; against council's rules; drafting look-over.
8. **Example job code and its key numbers:** CIV-01 (Kingston): connection at approx IL 1.14; 3,000 litre underground reuse tank; 100 pipes at 1 in 100.
9. **Seen dates:** Discharge letter 20 Jun 2023; services plans 5 Jul; mark-ups 6 to 7 Jul; P1 11 Jul; Rev A 30 Nov 2023.
10. **Unknowns:** What changed between P1 and Rev A (not compared). Whether downpipe numbers are checked. The sums for a plain house are waiting on study D (Q-104). One guidebook council asks for detention on a single house once the site is 65% impervious (then the job becomes K-002); the council is not named. Superseded by STUDY_D section 5.1, 16 Nov 2026.
11. **What the folder really contains (CIV-01):** No calculation of the drainage. Only the eight blank template workbooks every job is seeded with, the council's discharge letter, the before-you-dig replies, two scanned hand mark-ups and one small PDF: an upper-floor plan with part of the roof hatched and "57m2 OF ROOF CATCHMENT AREA TO WATERTANK SHOWN HATCHED". No pipe check, no downpipe count, no computations PDF, and nothing sent to council as sums. So on a house with no detention the pipes are by rule (100 dia. at 1 in 100) and the only number worked is a roof area to the tank. The principal should still confirm (STUDY_D section 5.1 items 1 to 3)

Evidence: STUDY_B section 1a, 1b item 7, section 6 item 1; INTERVIEW items 8c, 8zb; DECISIONS D-019; STUDY_D section 5.1.

## K-002 House with detention

1. **Trigger:** The discharge letter for a single house carries a line such as "the permissible site discharge is restricted to 5 L/sec". The figure triggers the whole detention chain even for one house. Another trigger in the guidebook: one council asks for detention once the site is 65% impervious.
2. **Inputs needed:** As K-001, plus the permitted discharge; rainfall for the site (Bureau); site and impervious areas (D-020); tank total and reuse litres (STORM or sustainability report, D-024).
3. **Decisions in order:** (1) Permitted discharge from the letter. (2) Volume required (S-003). (3) Split the storage between a short detention pipe, pits and the tank. (4) Top water level and plate height. (5) Orifice size by trial. (6) Levels back from the connection.
4. **Sums used:** S-001, S-003, S-004, S-005, S-006, S-007, S-024, S-025, then S-008, S-010, S-011, S-012.
5. **What the drafter is handed:** Not read for CIV-02. See `process\CIVIL_JOB_FLOW.md` for the mark-up forms seen.
6. **What lands on the sheet:** Everything in K-001, plus the criteria box (E-041), orifice pit on the plan and its detail (E-010, E-047), the detention pipe with its metres (E-004), tank note and tank detail with a 30 mm tank orifice (E-020, E-047), roof catchment to tank area (E-021), connection note with approximate invert (E-058).
7. **Checks:** Storage total at least the volume required (S-006); orifice flow under the permitted discharge (S-007); top water level below every cover (L-011); detention pipe grade (L-001); cover (L-004, L-005).
8. **Example job code and its key numbers:** CIV-02 (Kingston): permitted discharge 5.0 l/s; orifice 67 mm; top water level 1.31; volume required 1.49; pit P1 0.11, pit P2 0.05, tank 1.00 (of a 3,000 litre slimline: 2,000 reuse, 1,000 detention), a 225 Stormpro pipe 9 m long at 1 in 150 (0.36); total 1.52; roof catchment to tank 118.6 square metres; connection at approx IL 0.96.
9. **Seen dates:** Letter 23 Aug 2023 (issued to the building designer); Rev B for council submission 20 Jan 2025. Earlier issues not read.
10. **Unknowns:** The computations file was not on disk (results are from the sheet). How the top water level is first chosen (Q-001). Sums for a house with detention are waiting on study D (Q-104). Superseded by STUDY_D section 5.2, 16 Nov 2026.
11. **Sums read in full (CIV-02, Kingston):** Three pages: (1) required storage on Boyd's sheet (see S-003: 1,492 litres); (2) storage provided: 9 m of 225 pipe 0.36 m3, pits 0.11 and 0.05, tank contribution 1.00 m3 (L-010), total 1.52 m3 > 1.49 m3; (3) orifice 67 mm (S-007). The computations are a Word document of pasted spreadsheet pictures with three typed lines, printed to PDF. What went to council: the sheet, this PDF and a declaration form (STUDY_D section 5.2 items 1 to 5)

Evidence: STUDY_B section 1b items 1 to 5 and 7; STUDY_D section 5.2.

## K-003 Units, detention in tanks only

1. **Trigger:** Two or more units; the letter and the permit condition give a permitted discharge; the council lets tanks carry the storage and the volume is small enough for the tanks.
2. **Inputs needed:** Permitted discharge (letter and permit); discharge point (kerb or council pipe at the front); kerb connection rule (1 m clear of the crossing splay); council standard drawings for kerb and pipe connections; site, impervious and pervious areas; Bureau rainfall (1 in 10, 5 to 30 minutes); tank sizes and reuse litres; roof area to each tank; "pit information" sheet.
3. **Decisions in order:** (1) Boyd's on the council's copy for the volume required. (2) Storage: detention litres in each tank. (3) Orifice size and plate height. (4) Orifice pit levels and the run to the connection.
4. **Sums used:** S-001, S-003, S-006, S-007, S-024, S-025, S-008, S-011, S-012.
5. **What the drafter is handed:** CIV-03: typed red notes over the first draft print, one day before issue: every pipe's size, class and grade ("150 dia UPVC SN8 1 in 100", "1 in 23"), tank notes, the council pipe size, the connection note with its invert, lid classes and pipe sizes on the orifice pit detail, tank orifice 30 mm.
6. **What lands on the sheet:** Criteria box (E-041: 6.00 l/s, top water level 5.20, orifice 69, head 380, required 1.66, each tank 1.00, total 2.00); two roof-to-tank areas of 164 (E-021); two-row pit schedule (E-040); orifice pit detail with this job's levels (E-047); council notes (E-038); charged pipes to the tanks (E-002); tank notes (E-020).
7. **Checks:** As K-002. On JOB_C the same fact is typed many times: the control pit's inlet invert 5 times, outlet invert 3, cover level 3, orifice size, head and top water level twice each, each tank's litres 3 to 4 times.
8. **Example job code and its key numbers:** CIV-03 (Kingston; JOB_C carries the same sheet figures): site 650.3; impervious 375.6; pervious 274.7; coefficient 0.65; effective area 420.45; permitted discharge 6 L/s; required 1.66; two tanks at 1.00 = 2.00; orifice 69 mm at plate height 380 (head 0.3455, 5.84 l/s). JOB_C schedule: P1 cover 5.35, outlet 4.80, depth 0.55; P2 cover 5.78, outlet 5.25, depth 0.53.
9. **Seen dates:** Quote documents 24 Apr 2025; CADs 29 Apr; final CADs 12 May; on 13 May the discharge letter (dated 4 Apr, issued to another firm), notice of decision and pit information; council issue 15 May (P1 and Rev A carry the same date); endorsed plans 25 Jun, after the council issue. 21 days from quote documents to council issue; 2 working days from the last documents.
10. **Unknowns:** The council pipe size on the sheet (225) does not match the discharge letter's words (375); a pit information sheet may explain it (a picture, not read). Whether JOB_C and CIV-03 are the same job is not stated in the evidence; their figures match.

Evidence: STUDY_B section 1c, section 5 items 3 and 10; ELEMENT_LIST "Seen as a picture" item 7 and "Across three civil jobs" item 1; ENG_NOTES "Checked against the issued sheets" items 1 and 2.

## K-004 Units, detention in pipes, pits and tanks

1. **Trigger:** Units where the council wants a share of the storage underground (L-010), or the tanks alone cannot hold the volume.
2. **Inputs needed:** As K-003, plus the council's underground share and tank rule; the maker's detention pipe diameters; lengths available for detention pipe clear of dwellings and garages (L-012).
3. **Decisions in order:** (1) Volume required (S-003, S-026 or the council's figure). (2) Lay out detention pipes and pits by trial near the low end of the site and the discharge point. (3) Tank detention litres. (4) Tune pipe lengths, tank split and plate height until the total meets the volume and the underground share. (5) Orifice. (6) Levels.
4. **Sums used:** S-001, S-003 or S-026, S-004, S-005, S-006, S-007, S-013, S-023, S-024, S-025, S-008, S-010, S-011, S-012.
5. **What the drafter is handed:** The guidebook's mark-up example: blue pen over a print of the survey and architect's plan: pits drawn and hatched, detention pipes drawn with a note such as "2 x 450 Stormpro, 9.5 m, for detention", pipe notes with size and grade, handwritten inverts and cover levels at each pit, "to match existing levels", crossover notes. Bigger jobs go by mark-up and a drafter (D-025).
6. **What lands on the sheet:** Detention pipe runs labelled with size, grade and metres of detention, twin pipes as two bands side by side (E-004); a longer pit schedule (E-040); a criteria box listing every storage by name: each pit, each detention pipe by size and length, each tank, then a total (E-041); orifice pit detail (E-047); tank details.
7. **Checks:** Storage total (S-006); underground share (S-023, L-010); orifice (S-007, L-008); top water level (L-011); no detention pipes under dwellings or garages (L-012); detention pipe grade and cover (L-001, L-004, L-005).
8. **Example job code and its key numbers:** JOB_B: twin 225 detention pipes at 1 in 200 and a 300 detention pipe, eight pits, two pairs of tanks; 6.36 provided against 5.35 required; 225 pipe 29.5 m = 1.17; 300 pipe 3 m = 0.21; pit P1 600 x 900, water depth 0.41 = 0.22. CIV-04 Rev D: 41 m of 225 = 1.63, four pits 0.59, two tanks at 1.1 = 4.42 against 4.41 (50% underground). CIV-06: 11.5 m of 225 and 24 m of 300, four 600 x 600 pits, two tanks at 0.875 = 4.37 (60% underground).
9. **Seen dates:** See K-005 (CIV-04) and K-006 (CIV-06).
10. **Unknowns:** How the top water level is first chosen (Q-001). How pipe capacities are checked on these jobs (Q-002). JOB_B's storage list has "32 m of 225 = 1.27" in the CIV-09 sums and "29.5 m = 1.17" in the check of JOB_B's sheet; the evidence does not say whether JOB_B and CIV-09 are the same job.

Evidence: STUDY_B section 1d items 4 and 5, 1f items 2 and 3; ELEMENT_LIST "Across three civil jobs" item 2 and moving part 1; ENG_NOTES "Checked against the issued sheets" item 3 and "Added later" item 4; STUDY_A section 6 item 4; GUIDEBOOK_NOTES "The job in the guidebook's order" item 4.

## K-005 OSD4W job (a council that requires the Swinburne method)

1. **Trigger:** The council's discharge advice or the office guidebook says the council accepts OSD4W only, or the letter gives OSD4W settings (coefficients before and after, time of concentration, travel time, storm years, rainfall zone).
2. **Inputs needed:** Site area; existing and proposed areas with their coefficients; time of concentration and travel time; rainfall zone; storm years for outflow and storage; storage type; then everything in K-004.
3. **Decisions in order:** (1) Confirm the council's accepted method BEFORE design (the two methods can give different answers). (2) Run OSD4W with the council's settings. (3) Type the result in: permitted discharge and storage. (4) Then as K-004.
4. **Sums used:** S-026, then S-004, S-005, S-006, S-007, S-023, S-024, S-025 and the level sums.
5. **What the drafter is handed:** As K-004.
6. **What lands on the sheet:** As K-004, with council standard drawing references. CIV-04 sheet: permitted discharge 7.87, orifice 79, top water level 2.15, required 4.41; detention pipe runs labelled 19 m, 8 m, 6 m; roof areas to tanks 188.2 and 221.9; tank "1100 lt for detention" with 30 mm orifice.
7. **Checks:** As K-004; plus the council's own settings (it may re-run the sums and quote its own figures).
8. **Example job code and its key numbers:** CIV-04 (Mornington Peninsula): first attempt Boyd's 6.17 l/s and 3.27, storage 1.64 + 2.00, orifice 70; then OSD4W: site 937, zone Red Hill, outflow 1 in 2, storage 1 in 10, 10 and 5 minutes: 7.87 l/s, storage 4.41, critical storm 15.1 minutes; orifice 79 mm at plate height 390 (7.71 l/s). CIV-05 (Darebin): 5.93 l/s, storage 5.84. CIV-11 (Greater Dandenong): see K-011.
9. **Seen dates:** CIV-04: discharge advice Dec 2022; documents 10 Apr 2025; P1 28 Apr; Boyd sums 6 May; OSD4W 25 Jun; Rev A and B 27 Jun to 2 Jul; Rev C 11 Jul; Rev D 15 to 18 Jul; construction issue 18 Jul; then Rev H (Apr 2026) and Rev I (Jun 2026) after "as built mark-ups". Nine revisions in 14 months.
10. **Unknowns:** Why the method changed on CIV-04 is not shown in the files. Who confirms Boyd's or OSD4W with the council, and where the rainfall zone and times come from when the letter is silent (Q-006). The office's duty when as-built mark-ups arrive (Q-010). The last line of the CIV-04 computations about a water-quality contribution "on the balance 5%" is not explained.

Evidence: STUDY_B section 1d, 1e items 1 and 2, section 5 item 7, section 6 items 6 and 7; GUIDEBOOK_NOTES "The job in the guidebook's order" item 3.

## K-006 Council supplies the permitted discharge and storage

1. **Trigger:** The council (Monash, Bayside) works both figures itself. The office emails the site area and impervious area; the council replies with the permitted discharge and the storage.
2. **Inputs needed:** Site and impervious areas to send; the council's two figures; the council's minimum orifice and underground share; then as K-004.
3. **Decisions in order:** (1) Measure and email the areas early (one council "usually takes 3 to 4 days, so plan ahead"). (2) On reply, lay out storage to meet the figure and the underground share. (3) Orifice and plate height. (4) Levels.
4. **Sums used:** No S-002 or S-003. S-004, S-005, S-006, S-007, S-023, S-024, S-025 and the level sums.
5. **What the drafter is handed:** Not read for these jobs (CIV-10's hand mark-up is described in K-012).
6. **What lands on the sheet:** As K-004. The computations PDF quotes both figures as the council's.
7. **Checks:** As K-004. CIV-06 was tuned to land exactly on the council's limits (60% underground, 65 mm minimum orifice, total 4.37 against 4.37).
8. **Example job code and its key numbers:** CIV-06 (Monash): permitted discharge 5.27 l/s and storage 4.37; 2.62 underground + two tanks at 0.875; orifice 65 mm at plate height 390: 5.27 l/s exactly. CIV-09 (Bayside): 7.48 l/s; total 6.36 (sheet shows 5.35 required); orifice 77 mm at plate height 410: 7.4 l/s. CIV-10 (Bayside): 8.52 l/s and storage 9.72.
9. **Seen dates:** CIV-06: P1 26 May 2025; Rev A to council 29 Jul; resubmitted Rev B 13 Aug; approved 15 Aug 2025; then a planning amendment: Rev C 23 Apr 2026, Rev D 19 May, approved again 21 May 2026. CIV-09: documents 23 Feb 2024; set-up 4 Mar; P1 14 Mar; council figures 2 Apr (19 days after P1); P2 3 Apr; Rev A to council 8 Apr; approved 18 Apr; construction issue 4 Jun 2024.
10. **Unknowns:** CIV-09 is only partly read (files would not download). What P1 was designed on before the council's figures arrived is not shown (design often starts on assumptions: D-030).
11. **Paper look (CIV-06):** Nothing new in kind: the standard sheet with "ORIFICE PIT P1 DETAIL", "WATER TANK DETAIL", "TYPICAL TRENCH ADJACENT TO FOOTING DETAIL" and the detention criteria box. The council's figures only change the numbers. Read by text only (STUDY_D section 4.6 item 1)
12. **What the council supplied (CIV-09):** The discharge letter says discharge must not exceed the pre-development peak and tells the applicant to e-mail the council for the "storage volume and permissible site discharge". A separate e-mail reply ("PSD and SSR parameters") supplied them; permissible site discharge 7.48 l/s, storage required 5.35 m3. The e-mail itself was not opened. There is NO required-storage page in the office's sums (STUDY_D section 5.5 items 1 and 2, Still unknown item 4)

Evidence: STUDY_B section 1f, section 0 item 5; STUDY_D section 4.6, 5.5.

## K-007 Pumped system (low site)

1. **Trigger:** The site cannot fall to the discharge point by gravity. (Where the council requires the kerb connection to be gravity fed, a pump station lifts to a receiving pit and the last length runs by gravity.)
2. **Inputs needed:** Discharge report and its conditions; effective catchment; Bureau rainfall for the 1 in 10 (or 1 in 100) 2 hour storm; permitted discharge; discharge invert; inlet invert at the pump pit; cover level; well shape and size; rising main size and length; pump duty from the supplier.
3. **Decisions in order:** (1) Decide it cannot drain by gravity. (2) Permitted discharge and detention volume (S-002, S-003 or given). (3) Pump rate = permitted discharge. (4) Wet well volume (S-014). (5) Well shape and the level stack (S-015). (6) Rising main to the receiving pit, then gravity to the kerb.
4. **Sums used:** S-001, S-002, S-003, S-014, S-015, and S-007 where an orifice is also used.
5. **What the drafter is handed:** Not read for CIV-07. On CIV-10 the hand mark-up wrote the static rise into the pump box.
6. **What lands on the sheet:** Pump specification box (dual alternating pumps, rate, static rise, rising main, minimum wet well, comply with the standard), pump station section with the level names, "fully tanked pump pit, no groundwater into the pump system", control panel and alarm note, the standard's pump clauses as notes (E-059); rising main to pit "SPS" outlet then 100 pipe to the kerb; tanks (E-019); agricultural drain connected (E-024); schedule row for the pump station (E-040).
7. **Checks:** L-015 (pumps); L-023 (groundwater); wet well at least the largest of the three figures; council's gravity-at-kerb rule.
8. **Example job code and its key numbers:** CIV-07 (Glen Eira): site 746, impervious 414, coefficient 0.66; permitted discharge 7.90 l/s (Rev B), storage 2,233 litres; effective catchment 472.2; 2 hour runoff 17.09; pumped in 30 minutes 14.22; wet well 4.72; discharge invert 38.99, inlet 38.32, static rise 0.67, rising main 6 m of 50 dia, cover 39.18, 2,000 dia fibreglass well, total depth 2.86; tanks of 3,000 (1,000 detention, 2,000 reuse).
9. **Seen dates:** Discharge report 26 Feb 2024; STORM 24 Apr; sums 29 Apr; Rev B 30 Apr; council "no objection" letter 1 May 2024.
10. **Unknowns:** Which pump workbook version is current, and when a well under 3 cubic metres is acceptable (Q-003). Why the rainfall changed between Rev A and Rev B. The paper look of pump sheets is waiting on study D (Q-106). Superseded by STUDY_D section 4.1, 16 Nov 2026.
11. **Paper look (CIV-07):** See E-059: pump box, pump station detail, pump notes, plan symbols. One sheet, vertical title, for council approval, 1:100 and 1:20 (STUDY_D section 4.1 items 1 to 6)

Evidence: STUDY_B section 1g, section 3 item 15, section 5 item 6; DIGEST section 2 item 1; STUDY_D section 4.1.

## K-008 Soakage (soak on site)

1. **Trigger:** The discharge letter says "soak on site" or on-site absorption (no council drain to connect to, or the council's advice for a rural lot).
2. **Inputs needed:** Discharge letter; permeability report (soil rate per test hole, soil profile, groundwater seen or not); catchment split; Bureau rainfall table to 7 days; soakage module size and void share from the supplier; distances to footings, boundaries and tree zones.
3. **Decisions in order:** (1) Commission the soil test. (2) Split the site into catchments, each to its own soakage pit at a low point. (3) Each roof to a tank first; driveway to a raingarden where there is one. (4) Silt pit before each soakage pit. (5) Size each pit for every storm length (S-016). (6) Emptying time (S-017).
4. **Sums used:** S-001, S-016, S-017, S-027 where there is a STORM report.
5. **What the drafter is handed:** Not read for CIV-08.
6. **What lands on the sheet:** Each soakage pit titled with its module count and grid, wrapped in geotextile, a typical section per pit, silt pit inverts (E-060); tank details; the sewer main labelled with offset and depth (E-032); a soakage assumptions note. On JOB_A: a soakage pit of modular units discharging overflow to a dam, silt pits, existing agricultural drains.
7. **Checks:** L-016 (soil rate at least 100 mm/h, distances, silt trap, overflow for the 1 in 100); OK or Inadequate for every storm length.
8. **Example job code and its key numbers:** CIV-08 (Frankston, four units): soil 259 mm/h and 124 mm/h; pit 1 catchment 647, effective 426.5; factor 0.5; 2.448 x 7.535 x 0.88 = 16.2; worst storm 90 minutes, 15.37 needed against 15.42 provided; empties in 4.4 hours; pits 16.2, 9.8 and 7.4; 60, 40 and 30 double modules. CIV-13 (Bass Coast, rural house; sheet read as JOB_A in the Stage 1 element list): on-site absorption through a tank and a soakage line or pit to the council's standard drawing; no detention; its sums were not on disk.
9. **Seen dates:** CIV-08: letter Dec 2021; quote documents Feb 2023; CADs 27 Jul 2023; set-up 31 Jul; soil test 10 Aug; P1 29 Aug; P2 15 Sep; sums and STORM 2 Oct; Rev A to council 3 Oct 2023; Rev B 25 Jan 2024; Rev C 23 Apr 2024. Nine months and three submissions.
10. **Unknowns:** Whether the 1 in 100 storm with the moderating factor is the starting point for every council (Q-013). Sums for the rural house (Q-104). Paper look of soakage sheets (Q-106).
11. **Paper look (CIV-08) and sums (CIV-13):** CIV-08, two sheets: sheet 1 plan across the top, pit schedule below, legend moved to the bottom left, three soakage details and the tank detail in the middle, general notes lower right; sheet 2 "PAVEMENT PLAN AND DETAILS" with "DRIVEWAY DETAIL" and "PERMEABLE PAVING DETAIL"; a "PERMEABLE DRIVEWAY" area labelled in pink. CIV-13 (Bass Coast): soakage workbook read cell by cell (S-016, S-017): module count 14 x 13, emptying time 608 hours, overflow to a dam; also a pit schedule workbook and PDF, and a small drawing "soakage.dwg" (STUDY_D section 4.2 items 1, 7, section 5.4 items 1 to 5)

Evidence: STUDY_B section 1h, 1b item 6, section 3 item 16, section 4 item 9; ELEMENT_LIST "Across three civil jobs" item 3; STUDY_D section 4.2, 5.4.

## K-009 Raingarden / STORM report job

1. **Trigger:** The permit or the council asks for a STORM rating (100% for two dwellings or more at several councils), and the sustainability report meets it with tanks plus a raingarden for paved areas.
2. **Inputs needed:** STORM / sustainability report: roof area to each tank, tank litres, reuse, raingarden area and type, areas left untreated, rating.
3. **Decisions in order:** (1) Read the report. (2) Place the tanks and the roof lines to them. (3) Place the raingarden where the driveway can fall to it. (4) Overflow from the raingarden to the system.
4. **Sums used:** S-027 (outside program); S-024 (tank split).
5. **What the drafter is handed:** Not read.
6. **What lands on the sheet:** Raingarden outline with fill and area (E-025); the raingarden section with 500 filter media layer, transition layer and overflow pipe with grated cap, and the filter specification, as pasted detail blocks (E-047); tank notes (E-020); roof-to-tank areas (E-021, E-061); permeable paving hatch where used (E-033).
7. **Checks:** Sheet against the report: Frankston sent back "raingarden too small for its catchment".
8. **Example job code and its key numbers:** CIV-08: 34 of driveway to a raingarden of 1.0 square metre in the report; the final sheet labels 3.5 square metres. CIV-09: a 1.0 square metre raingarden (100 mm ponding) treating 49.8 of paving; two 6,000 litre tanks; rating over 100%. JOB_B: raingarden shape drawn by hand, no block.
9. **Seen dates:** CIV-08 STORM report 2 Oct 2023. CIV-09: see K-006.
10. **Unknowns:** How a raingarden's area is chosen and what fixes its position (Q-005). A raingarden job read end to end was not achieved (Q-104). Which of CIV-08's two raingarden areas is right. Superseded by STUDY_D section 5.5, 16 Nov 2026.
11. **End to end (CIV-09 = JOB_B):** Council gave the figures (7.48 l/s, 5.35 m3). Sums sent to council: two pages (storage list and orifice; then the STORM report); total storage 6.36 against 5.35. STORM report by the office dated 13 Mar 2024: rating 103% (S-027). The report is redone after the layout is drawn. Other files: three dated versions of the detention workbook (one prefixed with a second person's initials), an older orifice workbook, and the architect's sustainability report (not read) (STUDY_D section 5.5 items 2, 4, 5, 7 and 9)

Evidence: STUDY_B section 1h items 6 and 7, 1f item 3, "Kinds not found" item 1, section 3 item 18, section 4 item 7; STUDY_A section 6 item 25; DIGEST section 2 item 6; STUDY_D section 5.5.

## K-010 Outfall drain in the road reserve, with a long section

1. **Trigger:** The council's letter says the developer must build a new drain along the nature strip to the existing council pits, or asks for a long section of an outfall. Long sections are drawn only when the council asks (D-030).
2. **Inputs needed:** Extra survey levels along the route; footing probe; service scan and service locations; flood level certificate where there is one; council standard drawings (side entry pit, bedding and backfill, property connection); offsets from the title boundary.
3. **Decisions in order:** (1) Route and offsets. (2) New council pit position (1 m clear of the crossover). (3) Pipe size, class and grade (concrete, not the plastic detention pipe, in the road). (4) Design flow and velocity (S-022, S-009). (5) Long section rows (S-021). (6) Service crossings and clearances.
4. **Sums used:** S-008, S-009, S-021, S-022.
5. **What the drafter is handed:** Not read.
6. **What lands on the sheet:** A second sheet (C02): outfall plan at 1:100 with offsets; a new side entry pit; the pipe to the existing council pit; a two-row pit schedule (new side entry pit, existing council pit); the long section; a 1:20 cross-section of the property connection over a gas pipe with 150 clearances; a locality plan; three council standard drawings pasted on; a council notes block (E-062, E-040, E-038).
7. **Checks:** L-002 (outfall minimum size and class), L-013 (clearances), L-021 (scales and datum), L-022 (pipe class in the road).
8. **Example job code and its key numbers:** CIV-05 (Darebin): 225 class 2 rubber-ring-jointed concrete pipe at 1 in 200; design flow 31.75 l/s; velocity 0.8 m/s; datum RL 44.00; horizontal 1:250, vertical 1:25. Site sums: 5.93 l/s, storage 5.84; 18 m of 375 pipe = 1.99; pits 1.86; two tanks at 1.00; total 5.85; orifice 63 mm at plate height 520 (5.79 l/s).
9. **Seen dates:** 2022 letter; P1 May 2024; Rev A to council 5 Dec 2024; amended letter and outfall added Feb 2025; Rev C 16 Sep 2025; approved Rev E 8 Oct; construction 10 Oct 2025; a further "outfall drain services clash" issue 3 Mar 2026. About 17 months from P1 to approval.
10. **Unknowns:** Long-section examples and their fixed row set are waiting on study D (Q-102, Q-106). The OSD4W run is dated 26 Nov 2024 but uses the settings of the amended letter of Feb 2025; the evidence does not explain the order. Superseded by STUDY_D section 2.6 and 4.3, 16 Nov 2026.
11. **Paper look (CIV-05, sheet 2):** "OUTFALL DRAINAGE PLAN AND DETAILS", scale "AS SHOWN", construction issue at revision E, with its own plan, locality plan, short pit schedule, long section, section A-A and council notes (see E-062) (STUDY_D section 4.3, section 2.6 items 15 and 16)

Evidence: STUDY_B section 1e, section 3 items 2 and 21; DIGEST section 1 item 8, section 2 item 7; INTERVIEW item 8b; STUDY_D section 2.6, 4.3.

## K-011 Industrial / warehouse

1. **Trigger:** An industrial or warehouse site; the discharge letter gives an industrial coefficient and storm (0.9, 1 in 20) and restricts flow to pre-development.
2. **Inputs needed:** Planning permit; discharge letter (discharge to the existing internal system or an outfall); existing and proposed areas; the existing outlet stub size; the 1 in 100 overland path; lid classes; any permit condition for a 25% cut in yearly runoff by reuse; treatment devices.
3. **Decisions in order:** (1) Check the existing outlet stub against the 1 in 10 flow (detention only if it is too small). (2) Permitted discharge and storage (OSD4W on CIV-11). (3) Storage: a modular underground tank, detention pipe, tanks. (4) Orifice. (5) Overland path. (6) Yearly runoff reduction where the permit asks (S-019).
4. **Sums used:** S-026 (or S-002, S-003), S-004, S-006, S-007, S-019, S-009 for the stub check.
5. **What the drafter is handed:** On CIV-11 a set of civil drawings and computations by an outside designer arrived, and a "mark-up for council" on 5 May 2026.
6. **What lands on the sheet:** Two sheets (C01, C02): criteria box; a modular underground tank; a 225 detention pipe 26.64 m at 1 in 190; three 3,000 litre tanks; a litter basket; class D lids; suspended pipes under the slab (E-003); carpark slab and infill slab hatches, garden strips (E-033).
7. **Checks:** The council's letter settings (it changed time of concentration to 7 minutes and the storms); pipe joins upstream or downstream of the control pit the same on every sheet; the system must be shown reaching a council drain; a standard pipe size at the orifice pit; lot name in the title.
8. **Example job code and its key numbers:** CIV-11 (Greater Dandenong): site 2,281; first sums 24.02 l/s, storage 18.2, orifice 101 mm at head 1.28; second sums 34.53 l/s, storage 17.9, orifice 121 mm. Rev D sheet: 32.53 l/s, orifice 100 mm, top water level 24.11, total required 17.90, modular tank 18.2.
9. **Seen dates:** Discharge letter 7 Feb 2026; set-up 3 Mar; P1 2 Apr; mark-up for council 5 May; Rev A lodged 11 May; queries 21 and 28 May; Rev B 9 Jun; Rev C 7 Jul; third assessment 8 Jul; Rev D 13 Jul; approved plan 14 Jul 2026. Four council rounds in nine weeks.
10. **Unknowns:** The sheet's discharge (32.53) and orifice (100) do not match the computations of 8 Jun (34.53 and 121); which is right is not shown. Where the outlet stub check is kept and whether the 25% is argued by letter each time (Q-014). Paper look of industrial sheets (Q-106).
11. **Paper look (CIV-11, three sheets):** Horizontal title strip along the bottom, "for council approval" revision D. Sheet 1: plan two-thirds of the sheet, legend and general notes top right, pit schedule right, criteria box and slab legend under the plan title. New on plan: boundary sides labelled "SITE 35670 (350 deg 37'20")"; car park slab with every space, kerb lines and accessible bays; a grid of red pavement levels (E-071); suspended pipes; tanks RWT1 to RWT3; a modular underground detention tank; a proprietary treatment device; LPD and OG pit tags. Sheet 2: "P6 CONTROL PIT DETAIL", spoon drain, kerb, joint and slab specification details. Sheet 3: almost no text (a picture sheet); not read closely (STUDY_D section 4.4 items 1 to 6)

Evidence: STUDY_B section 1k, section 5 item 10; DIGEST section 2 item 9; STUDY_D section 4.4.

## K-012 Basement job

1. **Trigger:** The building has a basement: its drainage cannot fall to the street and needs its own plan and a pump.
2. **Inputs needed:** Basement levels and ramp from the architect; the council's subterranean drainage guideline where it has one; pump inputs as K-007; driveway levels at six points for the ramp grade (S-020).
3. **Decisions in order:** (1) Basement drainage plan: perimeter spoon / strip drains, floor wastes, agricultural drains. (2) Pump rate = permitted discharge (or the standard's floor on a house). (3) Wet well and level stack; the detention may sit in the same well above the pump band. (4) Rising main. (5) Outfall pipe check where needed.
4. **Sums used:** S-014, S-015, S-007, S-009, S-020, S-027.
5. **What the drafter is handed:** CIV-10: a hand mark-up in pen over the Rev A print: slab and surface levels written at about 30 points, schedule figures struck out and rewritten (inverts, cover levels, depth, silt pit levels), the static rise written into the pump box, a note that floor waste and strip drain water goes to the reuse system and must be treated first. So a mark-up at this stage is mostly levels.
6. **What lands on the sheet:** A separate "basement stormwater drainage plan" sheet; spoon and strip drains (E-023), floor wastes (E-017), agricultural drains (E-024), "drop to basement / from above" notes (E-018); pump box and section (E-059); "basement to be fully tanked watertight"; retaining walls shown (E-053).
7. **Checks:** L-015, L-023; the council's guideline (Bayside: pump designs must follow it).
8. **Example job code and its key numbers:** CIV-10 (Bayside, units, three civil sheets): council figures 8.52 l/s and 9.72; site 1,147, impervious 890, effective 878.1; 2 hour runoff 31.79; wet well 16.45 in a rectangular well 9.6 m x 1.5 m; static rise 3.11; 18 m rising main of 80 dia; cover 16.65; total depth 2.35; orifice 80 mm at plate height 430: 8.34 l/s; outfall check 300 dia, 68.39 l/s at 0.97 m/s; 696 of roof to a 15,400 litre tank. CIV-12 (Glen Eira, single house): dual 2.5 l/s pumps, 3.00 static rise, about 20 m of 50 dia rising main, minimum 3.00 wet well.
9. **Seen dates:** CIV-12: issue path preliminary, tender, construction (Rev C, 11 Feb 2026); no council approval stage seen. CIV-10 dates not listed in the evidence.
10. **Unknowns:** CIV-12's sums were not on disk; sums for the basement house are waiting on study D (Q-104). Who owns driveway and ramp grades and their limits (Q-012). Retaining walls and earthworks were not found as civil sums. Paper look of basement sheets (Q-106). Superseded by STUDY_D section 5.3 and 4.5 (sums read in full; basement sheets seen as pictures for CIV-10 only), 16 Nov 2026.
11. **Paper look and sums (CIV-10, CIV-12):** A separate basement-level sheet ("BASEMENT STORMWATER DRAINAGE PLAN" CIV-10; "BASEMENT DRAINAGE PLAN" CIV-12), then "GROUND FLOOR STORMWATER DRAINAGE PLAN" and an outfall sheet (CIV-10). New items: E-068 and E-074; pump sums S-014, S-015 and the combined outlet check S-028; shared drainage notes L-027. CIV-12 pit schedule kept as its own workbook and PDF (STUDY_D section 4.5 items 1 to 6, section 5.3)
12. **Conflict (CIV-12 pump figures):** The earlier study's CIV-12 figures (static rise 3.00; about 20 m of 50 dia rising main; minimum 3.00 wet well) against the sums read in full (static rise 3.14; 18 m of 50 dia rising main; 3.00 m3 wet well selected). Both kept (STUDY_D section 5.3 item 3)

Evidence: STUDY_B section 1l; DIGEST section 2 item 2; STUDY_D section 4.5, 5.3.

## K-013 Other kinds seen but not studied, and the "civil site job"

1. **Trigger:** Not studied. Kinds seen in folder names and the job records sheet: childcare centres (one with an outfall drain design), a school, sports pavilions and a netball court, apartments, a small job outside Victoria with a stormwater management plan and proprietary treatment devices, pools. From the older study: flood-affected sites; fill / earthworks sheets; easement jobs.
2. **Inputs needed:** Unknown.
3. **Decisions in order:** Unknown.
4. **Sums used:** Unknown. Pavement thickness design, road design and pipe load workbooks exist in the reference folder (industrial pavements, heavy / light traffic), but no job read used them.
5. **What the drafter is handed:** Unknown.
6. **What lands on the sheet:** From the older study: flood-affected site: open undercroft, overland-flow arrows, ground level distinct from minimum floor level; fill / earthworks: cut-fill sheet or "fill to RL" zones; easement: protected strip with clearance dimensions and "no pits in easement" notes.
7. **Checks:** Unknown.
8. **Example job code and its key numbers:** None coded.
9. **Seen dates:** None.
10. **Unknowns:** "Civil site job": Conflict: the files do NOT show a separate job type (every civil job read is one drawing set titled "stormwater drainage and pavement plan and details"; from the files a "civil site job" is the same sheet with more pavement and levels on it), against the owner's answer that a civil site job apart from the stormwater and pavement sheet exists "sometimes". Settled by D-029 as to existence ("sometimes"); which kinds is still open (Q-011). Childcare / school / apartment jobs are waiting on study D (Q-106). The office's own categories (job records sheet): residential or commercial; single dwelling, two unit, multi unit; basement, tanked basement, no basement; gravity, pump or infiltration; discharge to council pit, pipe connection, kerb and channel, or soak on site; site sloping to the front or to the back. The owner's end goal is to support all job types and situations (D-005). Superseded by STUDY_D section 4.7, 4.8 and 4.9 (childcare read by text, sports pavilion seen; no apartment folder found; school not opened), 16 Nov 2026.
11. **Earthworks drawn by civil (found):** The earlier "fill / earthworks" kind is confirmed on a public building job: CIV-15 sheet 3 is a cut and fill plan with named bench zones and no volumes (E-067). First issued alone at tender stage (STUDY_D section 4.8 item 6, section 7 item 6)
12. **Apartments:** Not found: no folder from 2023 to 2026 in the job index is named as apartments; the nearest kind is CIV-10 (units over a shared basement). A school was not opened once a sports job was found (STUDY_D section 4.9 item 1, Still unknown item 2)

Evidence: STUDY_B section 1m, "Kinds not found" items 2 and 3; DIGEST section 2 items 8, 10 and 11; INTERVIEW item 8zk; STUDY_D section 4.8, 4.9, 7 item 6.

## K-014 Public pavilion job led by pavements (CIV-15)

1. **Trigger:** A public building client (the council is the client); sports pavilion with paths, access pavement, tree zones and an underground tank for detention.
2. **Inputs needed:** Survey contours and levels; arborist requirements for tree protection zones; architect's building; structural drawings for slabs; pavement design vehicle. Who supplies the design vehicle statement: Unknown.
3. **Decisions in order:** Unknown (sheets read as pictures; sums not read).
4. **Sums used:** Detention criteria box rows (permitted site discharge, head 1230mm, orifice, top water level, volume required, underground water tank, total). Pavement and earthworks levels. Sums file: Unknown.
5. **What the drafter is handed:** Unknown.
6. **What lands on the sheet:** Three sheets, vertical title strip, "AS SHOWN" scale. Sheet 1 "STORMWATER DRAINAGE AND PAVEMENT PLAN": plan fills the sheet, legend top right, pit schedule and criteria box bottom centre inside the plan area; pavement legend with four coloured specification swatches (E-073); tree zones (E-031); retaining wall note; grid of levels (E-071); a small second plan "STRATCO SHED SLAB / SCALE 1:100 - LOCATED OFF PLAN"; red clouds. Sheet 2: asphalt, silt pit, construction joint and kerb ramp details plus the standard set. Sheet 3 "SITE CUT AND FILL PLAN" at 1:100 (E-067).
7. **Checks:** Unknown.
8. **Example job code and its key numbers:** CIV-15. Head 1230mm; underground tank 15,000 litre.
9. **Seen dates:** Issue stages P1 to P3, T1 to T4, then A (E-046). Dates: Unknown.
10. **Unknowns:** Sums; who owns the crossfall and grade limits (L-025); sheet 2 looked at as a picture for text only.

Evidence: STUDY_D section 4.8 items 1 to 7.

## K-015 Staged job (CIV-14, childcare centre)

1. **Trigger:** A project built in stages; each stage has its own plan sheet.
2. **Inputs needed:** Unknown.
3. **Decisions in order:** Unknown.
4. **Sums used:** Unknown; a pump station (1800 dia.) with the same pump boxes as K-007 appears on sheet 3.
5. **What the drafter is handed:** Unknown.
6. **What lands on the sheet:** Three sheets. Sheet titles "STAGE 1 - STORMWATER DRAINAGE AND PAVEMENT PLAN" and "STAGE 2 - ..."; a legend line "DENOTES EXTENT OF STAGE 1 WORKS" (E-069). New labels: "ROOF CATCHMENT TO RAINGARDEN", "TO VEGETABLE RAINGARDEN", "RAINGARDEN DETAIL", "PROPOSED RAMP" with a pavement level, "150 HIGH KERB", "KERB & CHANNEL TO ...", "INVERT OF CONCRETE KERB", "TYPICAL EXTERNAL PAVING DETAIL", retaining wall notes.
7. **Checks:** Unknown.
8. **Example job code and its key numbers:** CIV-14. No numbers read.
9. **Seen dates:** Issued through revision E as "CVL ... STAGE 1 & 2". Dates: Unknown.
10. **Unknowns:** Everything except the sheet text; the job was read by text only, not as pictures.

Evidence: STUDY_D section 4.7 items 1 and 2.

---

Next free number: K-016
