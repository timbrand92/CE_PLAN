# Sums register (S-)

Every sum the office uses on a civil job, one item each. Re-filed from the evidence on Mon 16 Nov 2026. No sum here is new, and none is confirmed by the owner as the office rule unless a D-number is quoted.

## How to add to this file

1. Take the number on the last line ("Next free number"). Never reuse or renumber.
2. Copy the seven headings below, in the same order, and fill every one. Write "Unknown" (with the Q-number if `OPEN_QUESTIONS.md` has it) rather than leaving a heading out.
3. Carry the real numbers of one real job (coded JOB_A/B/C or CIV-01..13) in the worked example. No client, address, job number or staff name.
4. If two pieces of evidence disagree, write both under "Conflict:" inside the item and do not choose, unless a decision settles it ("Settled by D-0xx").
5. Finish the item with an "Evidence:" line, then move the "Next free number" line on by one.

## Fixed headings for every item

1. **Purpose**
2. **Inputs** (name, unit, where it comes from)
3. **The sum in words and as a formula**
4. **Output and where it is shown on the sheet**
5. **Worked example from a real job code**
6. **Known slips in the office workbooks**
7. **Evidence** (written as the closing line)

Short names of evidence files are listed in `reference\README.md`.

---

## S-001 Runoff coefficient and effective area

1. **Purpose:** One weighted figure for how much of the rain on the site runs off; and the "effective area" (the area that behaves as fully running off).
2. **Inputs:**
   1. Site area, square metres. Measured job by job (architect's figures, off the CAD, engineer or drafter): D-020.
   2. Impervious area (roofs and paving, listed part by part), square metres. Same sources.
   3. Pervious area = site less impervious.
   4. Impervious coefficient 0.9 (see L-017).
   5. Pervious coefficient 0.30 or 0.35 (see L-017; conflict).
   6. Or a coefficient fixed by the council (0.35, 0.4, 0.8, 0.9 seen): council letter or permit.
3. **The sum in words and as a formula:** Coefficient = (impervious x 0.9 + pervious x pervious coefficient) / site area. Effective area = impervious x 0.9 + pervious x pervious coefficient (= coefficient x site area). "So the coefficient is a council input first, a sum second."
4. **Output and where it is shown on the sheet:** Not on the plan itself. It is on the computations PDF and feeds S-002, S-003, S-014, S-016. Site areas are boxed on the sheet only "where a council asks".
5. **Worked example from a real job code:** CIV-03: site 650.3; impervious 375.6; pervious 274.7; (375.6 x 0.9 + 274.7 x 0.35) / 650.3 = 0.65; effective area 420.45. CIV-07 (pump sum): 414 x 0.9 + 332 x 0.3 = 472.2. CIV-07 (Boyd's): site 746, impervious 414, coefficient 0.66. CIV-04 (OSD4W): existing 471 at 0.90 and 466 at 0.35 (weighted 0.63); proposed 519 at 0.90 and 418 at 0.30 (weighted 0.63).
6. **Known slips in the office workbooks:** Conflict: pervious 0.3 (guidebook, pump and soakage workbooks) against 0.35 (Boyd's masters and job sums). CIV-04 uses both in one run (0.35 existing, 0.30 proposed). Not settled; needs the owner's ruling Q-004. The Kingston tab in the copy of the main workbook read first is headings only (no sums).
7. **More worked examples:** CIV-02 (Kingston): catchment 561 m2; impervious 305, pervious 256; runoff coefficient 0.65; effective area 364.1 m2. CIV-12 (Glen Eira): site 919 m2; existing impervious 568; proposed 577 ("pool area not considered"); coefficient 0.70. CIV-13 (Bass Coast): impervious 365 m2 x 0.9 = 328.5, taken as catchment 329 m2 with coefficient 1; pervious 0. CIV-12 pump catchment: 132 m2, coefficient 1 (STUDY_D section 5.2 item 1, section 5.3 items 1 and 3, section 5.4 item 1)
8. **Plain house:** CIV-01 holds no calculation of the drainage: the folder has only the eight blank template workbooks every job is seeded with (all still at their 2014 to 2021 template dates), the council's discharge letter, the before-you-dig replies, two scanned hand mark-ups and one small PDF. The only number worked is a roof area to the tank (57 m2) (STUDY_D section 5.1 items 1 and 2)

Evidence: ENG_NOTES "The chain of sums" items 1 and 2; STUDY_B section 1c item 3, 1d item 3, 1g items 3 and 4, section 3 item 17, section 5 item 1; STUDY_D section 5.1 to 5.4.

## S-002 Permitted site discharge by the rational method

1. **Purpose:** The most the site may send to the council system, in litres a second, when the council does not give the figure.
2. **Inputs:**
   1. Runoff coefficient (S-001) or the council's fixed pre-development coefficient.
   2. Rainfall for the discharge storm, mm/h: Bureau of Meteorology table for the site's own location. Usual storm: 5 minute, 1 in 5 (see L-017 for the council variations).
   3. Site area, square metres.
3. **The sum in words and as a formula:** Permitted discharge (l/s) = coefficient x rainfall (mm/h) x site area (m2) / 3600. If the council gives the figure (letter, permit or email reply), no sum is done.
4. **Output and where it is shown on the sheet:** First row of the detention criteria box, "PERMITTED SITE DISCHARGE ... l/s" (E-041). Also the pump rate on a pumped job (S-014).
5. **Worked example from a real job code:** CIV-07: site 746, coefficient 0.66; Rev A used 113 mm/h (5 minute, 1 in 5): 8.20 l/s. Rev B, one day later, used 95.3 mm/h: 7.90 l/s. CIV-04 first attempt (Boyd's): 6.17 l/s. Given figures, no sum: CIV-02 5 l/s; CIV-03 6 l/s; CIV-06 5.27; CIV-09 7.48; CIV-10 8.52.
6. **Known slips in the office workbooks:** CIV-07's rainfall changed between Rev A and Rev B with no reason shown. Every job's civil folder is seeded with about 15 blank or stale sum files (Boyd's in four versions), so file names cannot tell which sums a job really used.
7. **More worked examples:** CIV-02: "1:5 PSD" at 83 mm/hr gives 5.17 l/s; restricted outflow taken as 5.00 l/s. CIV-12: the permissible discharge is taken from the EXISTING site: 16.13 l/s at the 5-minute 1 in 5 intensity 94.3 mm/hr, coefficient 0.70. CIV-09: the council's e-mail reply ("PSD and SSR parameters") supplied 7.48 l/s; the e-mail itself was not opened (STUDY_D section 5.2 item 1, section 5.3 item 1, section 5.5 item 1)

Evidence: ENG_NOTES "The chain of sums" item 3; STUDY_B section 1g item 3, 1d item 2, section 5 item 11; STUDY_D section 5.2, 5.3, 5.5.

## S-003 Detention volume required by Boyd's method

1. **Purpose:** The storage the site must hold so that the storage storm leaves no faster than the permitted discharge.
2. **Inputs:**
   1. Effective area, square metres (S-001).
   2. Rainfall for the storage storm at each storm length, mm/h: Bureau table. Usual storm 1 in 10, lengths 5, 10, 15, 20, 25, 30 minutes.
   3. Permitted discharge, l/s (S-002 or given).
3. **The sum in words and as a formula:** For each storm length: inflow (l/s) = rainfall x effective area / 3600; volume in (litres) = inflow x time in seconds; storage = volume in x (1 less permitted discharge / inflow). The largest of the column is the volume required.
4. **Output and where it is shown on the sheet:** "VOLUME REQUIRED" row of the detention criteria box (E-041); the Boyd's page of the computations PDF.
5. **Worked example from a real job code:** CIV-03 (Kingston copy): effective area 420.45; 1 in 10 rainfall 98.6 / 73.6 / 60.1 / 51.5 / 45.5 / 40.9 mm/h for 5 to 30 minutes. At 5 minutes: inflow 11.52 l/s, volume in 3,455 litres, storage 3,455 x (1 - 6.00 / 11.52) = 1,656 litres. Largest of the column: 1.66 cubic metres. CIV-07: Rev A 2,144 litres; Rev B 2,233 litres. CIV-04 first attempt: 3.27 (later redone in OSD4W: 4.41, S-026).
6. **Known slips in the office workbooks:** The two methods (Boyd's and OSD4W) can give different answers, so the council's accepted method must be confirmed first; CIV-04 was designed in Boyd's and redone in OSD4W. Boyd's exists in four template versions in every job folder. The workbooks hold earlier jobs' addresses in their cells.
7. **More worked examples:** CIV-02 (Boyd's sheet): 1 in 10 year storms of 5 to 30 minutes (98.6 down to 40.9 mm/hr) each give inflow, outflow, volume in and storage; the largest storage is 1,492 litres at 5 minutes: "Detention Required 1492 L". CIV-12: storage required 1,125 litres. CIV-09 has NO required-storage page because the council supplied it (storage required 5.35 m3) (STUDY_D section 5.2 item 1, section 5.3 item 1, section 5.5 items 1 and 2)
8. **Owner's ruling on methods in the first release:** Boyd's method is ticked (D-098)

Evidence: ENG_NOTES "The chain of sums" item 4; STUDY_B section 1c item 3, 1d items 2 and 3, 1g item 3, section 5 items 7 and 11; GUIDEBOOK_NOTES "The job in the guidebook's order" item 3; STUDY_D section 5.2, 5.3, 5.5; D-098.

## S-004 Storage of a detention pipe

1. **Purpose:** The volume one length of detention pipe adds to the storage list.
2. **Inputs:**
   1. Pipe diameter, mm: engineer's choice (225, 300, 375, 450 seen).
   2. Length, metres: measured off the drawing.
3. **The sum in words and as a formula:** Volume (m3) = cross-section area x length = 3.1416 x (diameter / 2) squared x length.
4. **Output and where it is shown on the sheet:** A named line in the detention criteria box (pipe by size and length). The plan label carries the metres as a second line, e.g. "9m DETENTION" (E-004).
5. **Worked example from a real job code:** CIV-02: 225 pipe 9 m = 0.36. CIV-04 Rev D: 41 m of 225 = 1.63. CIV-05: 18 m of 375 = 1.99. CIV-06: 11.5 m of 225 = 0.46; 24 m of 300 = 1.70. CIV-09: 32 m of 225 = 1.27; 3 m of 300 = 0.21. JOB_B (checked against the sheet): 225 pipe 29.5 m = 1.17 by the sum and 1.17 in the box; 300 pipe 3 m = 0.21 and 0.21.
6. **Known slips in the office workbooks:** Storage is worked from the nominal, not the internal, pipe diameter (the maker's 225 is 226 inside, 259 outside: S-013). Drawing total against calculation differed by 0.01 to 0.02 cubic metres on real jobs.
7. **More worked examples:** CIV-02: 9 m of 225 pipe = 0.36 m3. CIV-09: 32 m of 225 (1.27 m3) and 3 m of 300 (0.21) = 1.48 (STUDY_D section 5.2 item 2, section 5.5 item 2)
8. **Owner's ruling on twin pipes:** A detention pipe with a number-of-pipes box ("2 x 225") has the storage sum count both pipes (D-082)

Evidence: ENG_NOTES "The chain of sums" item 5 and "Checked against the issued sheets" item 3; STUDY_B section 1b item 3, 1d item 5, 1e item 3, 1f items 2 and 3; DIGEST section 3 items 8 and 10; STUDY_D section 5.2, 5.5; D-082.

## S-005 Storage of a pit

1. **Purpose:** The volume a pit holds below top water level, for the storage list.
2. **Inputs:**
   1. Pit plan size, metres: engineer's choice (see L-006).
   2. Top water level, metres: engineer's choice (how it is first chosen: Unknown, Q-001).
   3. Pit invert, metres: engineer's choice.
3. **The sum in words and as a formula:** Volume (m3) = plan length x plan width x (top water level less the pit's invert).
4. **Output and where it is shown on the sheet:** A named line per pit in the detention criteria box (E-041).
5. **Worked example from a real job code:** JOB_B: pit P1, 600 x 900, water depth 0.41 = 0.22 by the sum and 0.22 in the box. CIV-02: pit P1 0.11, pit P2 0.05. CIV-05: three 1200 x 900 pits and two 600 x 600 pits, each plan area x water depth (0.39 to 0.52) = 1.86 in total. CIV-06: four 600 x 600 pits 0.46. CIV-04 Rev D: four pits 0.59. CIV-09: four pits 0.88.
6. **Known slips in the office workbooks:** In three jobs' storage tables the pit label does not match the numbers typed: a pit labelled 600 x 600 is worked as 0.6 x 0.9, one labelled 450 x 450 as 0.6 x 0.6, one labelled 900 x 900 as 0.6 x 0.9 and one labelled 900 x 600 as 0.9 x 0.9; the volumes follow the typed numbers. Pit water depths are typed as "top water level less a typed number" inside the sum, so a changed invert has to be found inside the formula.
7. **More worked examples:** CIV-02: pit P1 (0.6 x 0.6, 0.31 deep) 0.11 m3 and pit P2 (0.45 x 0.45, 0.23 deep) 0.05 m3; "IN PIPES AND PITS = 0.52 m3". CIV-09: four pits by plan size and storage depth = 0.88 (two more pits listed at zero depth) (STUDY_D section 5.2 item 2, section 5.5 item 2)
8. **Pit labels against numbers:** CIV-09 pits labelled 600x600, 900x900, 900x600, 600x600 are worked as 0.6 x 0.9, 0.6 x 0.9, 0.9 x 0.9, 0.6 x 0.9. The drawn state and the typed size can also disagree (see E-008) (STUDY_D section 5.5 item 3, section 3.1 item 4)
9. **Owner's ruling on which pits count:** "Only pits I tick": a pit counts as storage only when ticked; volume = plan size times water depth, the depth worked out from the top water level (D-105)

Evidence: ENG_NOTES "The chain of sums" item 5, "Checked against the issued sheets" item 3, "Weak points" item 3; STUDY_B section 1b item 3, 1e item 3, 1f item 2, section 5 item 4; STUDY_D section 3.1, 5.2, 5.5; D-105.

## S-006 Storage total and comparison with the volume required

1. **Purpose:** Prove the storage provided is at least the volume required.
2. **Inputs:**
   1. Each detention pipe volume (S-004).
   2. Each pit volume (S-005).
   3. Each tank's detention litres (S-024).
   4. The wet-well share on a pumped job (S-015).
   5. Volume required (S-003, S-026, or the council's figure).
3. **The sum in words and as a formula:** Total = sum of all the named storages. Total must be at least the volume required. Reuse volume is never counted.
4. **Output and where it is shown on the sheet:** The last rows of the detention criteria box: each storage by name, then the total, against the volume required (E-041). The storage list page of the computations PDF.
5. **Worked example from a real job code:** CIV-03: two tanks at 1.00 = 2.00 against 1.66. CIV-02: 0.11 + 0.05 + 1.00 + 0.36 = 1.52 against 1.49. CIV-04 Rev D: 1.63 + 0.59 + 1.1 + 1.1 = 4.42 against 4.41. CIV-05: 3.85 underground + two tanks at 1.00 = 5.85 against 5.84. CIV-06: 2.62 + 1.75 = 4.37 against 4.37 exactly. CIV-09: total 6.36 (the sheet shows 5.35 required). JOB_B: 6.36 provided against 5.35 required.
6. **Known slips in the office workbooks:** The detention workbook's example leaves one pipe with minus 50 cover and no warning is carried to the total. Drawing total against calculation differed by 0.01 to 0.02 on real jobs. CIV-06 shows the tank split, pipe lengths and plate height all tuned to land exactly on the council's limits.
7. **More worked examples:** CIV-02: pipes and pits 0.52 plus a typed line "Water Tank contribution for tanks 2500L or above = 1.00m3": "TOTAL = 1.52m3 > 1.49m3". CIV-09: pipes 1.48, pits 0.88, tanks WT1 and WT2 at 2 m3 each: "TOTAL STORAGE 6.36" against 5.35 required (STUDY_D section 5.2 item 2, section 5.5 item 2)
8. **Owner's rulings on the answer shown:** One Detention window for the job (D-099); "Both, side by side": storage against what is needed, and discharge against what is permitted, as two answers of equal weight (D-106)

Evidence: ENG_NOTES "The chain of sums" item 5; STUDY_B section 1b item 3, 1c item 4, 1d item 5, 1e item 3, 1f items 2 and 3, section 5 item 5; ELEMENT_LIST "Across three civil jobs" moving part 1; DIGEST section 3 items 4 and 8; STUDY_D section 5.2, 5.5; D-099, D-106.

## S-007 Orifice size

1. **Purpose:** Find the orifice diameter that lets out just under the permitted discharge at top water level.
2. **Inputs:**
   1. Permitted discharge, l/s.
   2. Plate (baffle) height above the orifice invert, mm: engineer's choice.
   3. Trial orifice diameter, mm: engineer's choice, not below the council's minimum (L-008).
   4. Coefficient 0.6 (L-009).
3. **The sum in words and as a formula:** Flow = 0.6 x orifice area x square root of (2 x 9.81 x head). Head = plate height less half the orifice diameter (the head to the orifice centre). Try a diameter until the flow is just under the permitted discharge.
4. **Output and where it is shown on the sheet:** "DIA. OF ORIFICE" and "HEAD" rows of the criteria box (E-041), the orifice pit detail (E-047), and the orifice page of the computations PDF. Settled by D-023: the criteria box keeps printing the baffle (plate) height under "HEAD", as now; the sum keeps using the head to the orifice centre.
5. **Worked example from a real job code:** CIV-03 (JOB_C figures): 69 mm orifice, plate height 380: head 0.3455, flow 5.84 l/s, under 6.00. CIV-04: 79 mm at plate height 390: head 0.3505, 7.71 l/s under 7.87 (Rev B had 70 mm). CIV-05: 63 mm at 520: head 0.4885, 5.79 under 5.93. CIV-06: 65 mm at 390: 5.27 exactly. CIV-09: 77 mm at 410: 7.4. CIV-10: 80 mm at 430: 8.34 under 8.52. CIV-11: head = pit top 24.11 less orifice invert 22.83 = 1.28: 101 mm for 24.02 l/s; second sums 121 mm for 34.53 l/s.
6. **Known slips in the office workbooks:**
   1. Conflict (constant): the older orifice sheet writes "2.6 x area x root head" with gravity 9.8 (0.6 x root 19.6 is 2.66); the newer sheet uses 9.81 properly. A second older copy saved under one council's name uses coefficient 0.8 and 3.54 and still holds an earlier job's address and a 45 l/s example. Not settled by a decision.
   2. Conflict (head): ENG_NOTES checked JOB_C with head 0.38 and got 5.99 l/s; the job's own sum uses 0.3455 and gives 5.84 (STUDY_B corrects the earlier note). Settled by D-023 as to what prints and what the sum uses.
   3. On real jobs: orifice 55 against 56, and 40 against 38 or 39, between drawing and calculation. CIV-11: the sheet (100 mm, 32.53 l/s) does not match the latest sums (121 mm, 34.53 l/s); which is right is not shown.
7. **More worked examples:** CIV-02: coefficient 0.6, gravity 9.81; 67 mm at plate height 310 mm, head 0.2765 m (plate height less half the orifice); 4.93 l/s < 5.00; "Adopt 67 mm diameter orifice". CIV-09: 77 mm at plate height 410 mm, head 0.3715 m; 7.4 l/s < 7.48; this older sheet prints "= 2.6 Ao root h" with gravity 9.8 (STUDY_D section 5.2 item 3, section 5.5 item 2)

Evidence: STUDY_B section 1c item 5, 1d item 6, 1e item 4, 1f items 2 and 3, 1k items 2, 4 and 5, 1l item 1, section 3 item 9, section 5 items 2 and 3; ENG_NOTES "The chain of sums" item 6 and "Checked against the issued sheets" item 1; DIGEST section 3 items 8 and 10; STUDY_D section 5.2 item 3, 5.5 item 2.

## S-008 Pipe grade

1. **Purpose:** The fall of a pipe run, written "1 in x".
2. **Inputs:**
   1. Length of the run, metres: measured off the drawing.
   2. Upstream invert and downstream invert, metres: engineer's choice.
3. **The sum in words and as a formula:** Grade (1 in x) = length / (upstream invert less downstream invert). The newer detention workbook works the grade from the two pits' inverts, and has a small "invert calculator" the other way (type the lower pit's inlet invert and the wanted grade: S-025).
4. **Output and where it is shown on the sheet:** In the pipe label, "... PIPE AT 1 IN 100" (E-006); the pipe-grade row of a long section (E-062).
5. **Worked example from a real job code:** Labels seen: 1 in 100 (most), 1 in 23 (CIV-03 mark-up), 1 in 150 (CIV-02 detention pipe), 1 in 190 (CIV-11), 1 in 200 (JOB_B twin 225; CIV-05 outfall). The inverts and lengths behind those labels were not listed in the evidence: Unknown.
6. **Known slips in the office workbooks:** The pipe table asks for each run's inverts, cover levels, length and size again: the same figures as the plan and schedule, retyped.
7. **Owner's rulings on grade:** The Grade box is pick-or-type (any grade, such as 1 in 75, can be typed) (D-079). When the downstream invert is typed over, the grade is worked out from the two inverts and the length (working rule, owner to confirm) (D-080). The pipe label shows the true grade between the two printed inverts: "What the inverts give: 1 in 59" (D-123)

Evidence: ENG_NOTES "The chain of sums" item 7, "Weak points" item 1, "Added later" item 1; STUDY_B section 1c item 6, section 3 item 1; D-079, D-080, D-123.

## S-009 Pipe capacity by Manning's formula

1. **Purpose:** Check a pipe of a given size and grade can carry its design flow.
2. **Inputs:**
   1. Pipe size, mm, and grade (S-008).
   2. Roughness: 0.010 plastic, 0.013 concrete (workbook values).
   3. Design flow, l/s (S-022).
3. **The sum in words and as a formula:** Capacity = Manning's formula for a full pipe of that size and grade. Capacity must be at least the design flow: the workbook prints OKAY or FAIL. The formula itself is not written out in the evidence (the Manning's workbook was dumped but not read line by line).
4. **Output and where it is shown on the sheet:** Not on a house or units sheet. On an outfall long section as the rows "pipe design flow" and "velocity" (E-062).
5. **Worked example from a real job code:** CIV-10 outfall pipe check: 300 dia, 68.39 l/s at 0.97 m/s. CIV-05 long section: 225 class 2 concrete at 1 in 200, design flow 31.75 l/s, velocity 0.8 m/s.
6. **Known slips in the office workbooks:** In the filled example of the second rational-method tab, one row's flow sum points at an empty rainfall cell, so that run shows 0 l/s and still prints OKAY; later blank rows point at other wrong cells. Settled by D-019 for the plain house only: pipe capacity is not checked there. How capacities are checked on detention or bigger jobs: Unknown (Q-002); no pipe table was in any job folder read.
7. **Pipe capacity check on a gravity outlet (CIV-12):** A real pipe capacity check exists on one job, one line long: outlet pipe 150 dia. at 1 in 100, roughness 0.01 (as printed), gives 19.80 l/s at 1.12 m/s; "12.99 < 19.80, therefore OK". Nothing is checked on a plain house (CIV-01), where pipes are by rule (100 dia. at 1 in 100) (STUDY_D section 5.3 item 2, section 5.1 item 3, section 7 item 12)

Evidence: ENG_NOTES "The chain of sums" item 7 and "Weak points" item 2; STUDY_B section 1e item 5, 1l item 1, section 6 item 8, section 0 item 3; STUDY_D section 5.1, 5.3, 7 item 12.

## S-010 Pipe cover at each end

1. **Purpose:** The depth of ground over the top of a pipe, to compare with the minimum cover (L-004).
2. **Inputs:**
   1. Cover (surface) level at the pipe end, metres.
   2. Invert at that end, metres.
   3. Pipe diameter, mm.
3. **The sum in words and as a formula:** Cover = cover level less invert less pipe diameter. (For detention pipe with the maker's real diameters see S-013.)
4. **Output and where it is shown on the sheet:** Not printed on the plan. It is a check (the detention workbook prints OK / NOT OK for pipe cover).
5. **Worked example from a real job code:** No worked job figures for this sum are given in the evidence: Unknown. (The detention workbook's own example leaves one pipe with minus 50 cover.)
6. **Known slips in the office workbooks:** The minus 50 cover in the workbook example carries no warning to the total. The minimum to compare against has four different values (L-004).
7. **Settled by Tim, D-133, 16 Nov 2026:** Minimum cover is "The standard's table, by situation": each pipe has a "what is over it" choice and the cover needed follows the table (L-004); detention pipe keeps 300 (D-133)

Evidence: ENG_NOTES "The chain of sums" item 7 and "Added later" item 1; STUDY_B section 5 item 5; D-133.

## S-011 Depth to outlet (pit schedule)

1. **Purpose:** The pit depth printed in the schedule.
2. **Inputs:**
   1. Pit cover level, metres.
   2. Pit outlet invert, metres.
3. **The sum in words and as a formula:** Depth to outlet = cover level less outlet invert. Worked by hand today.
4. **Output and where it is shown on the sheet:** "DEPTH TO OUTLET" column of the pit schedule (E-040).
5. **Worked example from a real job code:** JOB_C: P1 cover 5.35 less outlet 4.80 = 0.55; P2 5.78 less 5.25 = 0.53. Both match the schedule.
6. **Known slips in the office workbooks:** The pit schedule workbook was read but no slip in it is recorded in the evidence. On the CIV-10 hand mark-up, schedule depths were struck out and rewritten after levels changed.

Evidence: ENG_NOTES "The chain of sums" item 8 and "Checked against the issued sheets" item 2; ELEMENT_LIST "Seen as a picture" item 7; STUDY_B section 1l item 2.

## S-012 Pit size from depth

1. **Purpose:** Choose the pit plan size that suits its depth.
2. **Inputs:**
   1. Depth to outlet (S-011).
   2. The pit size table (L-006).
3. **The sum in words and as a formula:** A look-up: the smallest size whose maximum depth is not less than the pit depth. The detention workbook prints OK / NOT OK for pit depth against the size's maximum.
4. **Output and where it is shown on the sheet:** "PIT SIZE" column of the schedule (E-040); the pit symbol's look on the plan (E-008).
5. **Worked example from a real job code:** JOB_C: P1 depth 0.55 and P2 depth 0.53 (the sizes printed for them are not stated in the evidence: Unknown). A second, deeper junction pit detail (900 to 1200) appears only when a pit is that deep.
6. **Known slips in the office workbooks:** Conflict: two tables (guidebook; detention workbook) give different maximum depths (L-006). One of the copied depth-check sums points at the wrong list cell on rows P3 to P5. Not settled; needs the owner's ruling Q-004.
7. **Settled by Tim, D-135 and D-136, 16 Nov 2026:** Pit size by depth follows the guidebook table (350 to 0.45, 450 to 0.60, 600 to 0.90, 600 x 900 to 1.20 with step irons, 900 x 900 deeper than 1.20; a council condition overrides), and step irons are needed deeper than 1.0 m (L-006) (D-135, D-136)

Evidence: ENG_NOTES "The chain of sums" item 8 and "Added later" items 1 and 2; STUDY_B section 3 item 6, section 5 item 5; ELEMENT_LIST "Across three civil jobs" moving part 2; D-135, D-136.

## S-013 Detention pipe cover with the maker's real diameters

1. **Purpose:** Check cover over a detention pipe using the real outside size of the pipe brand, and find the least pit depth that goes with it.
2. **Inputs:**
   1. Ground level and pipe invert, metres.
   2. Maker's diameters: for the 225 pipe, 259 outside and 226 inside (pipe cover workbook).
   3. Minimum cover (L-004; the guidebook thumb rule over detention pipe is 300).
3. **The sum in words and as a formula:** Cover = ground level less invert less (inside diameter + wall). Minimum pit depth = (inside diameter + wall) + 300.
4. **Output and where it is shown on the sheet:** Not printed. A check before the levels are fixed.
5. **Worked example from a real job code:** None with job figures in the evidence: Unknown.
6. **Known slips in the office workbooks:** None recorded for this workbook. Elsewhere storage is worked from the nominal diameter (S-004).

Evidence: STUDY_B section 3 item 5, section 0 item 3; DIGEST section 3 item 10.

## S-014 Pump wet well volume

1. **Purpose:** The least volume of the pump well, to AS/NZS 3500.3 section 8 as copied in the office workbook.
2. **Inputs:**
   1. Effective catchment, square metres (S-001, with pervious at 0.3 in the pump workbook).
   2. Rainfall of the 1 in 10, 2 hour storm, mm/h: Bureau (1 in 100 where a basement carries habitable risk).
   3. Pump rate, l/s: office practice sets it equal to the permitted discharge.
3. **The sum in words and as a formula:** Runoff of the 2 hour storm (m3) = effective catchment x rainfall / 1000 x 2. Pumped in 30 minutes (m3) = pump rate x 1800 / 1000. Extra storage = runoff less pumped. 1% rule = effective catchment x 0.01. Wet well volume = the largest of (extra storage, 1% of catchment, 3 cubic metres).
4. **Output and where it is shown on the sheet:** "Minimum wet well" in the pump specification box (E-059), with pump rate, static rise and rising main.
5. **Worked example from a real job code:** CIV-07: 472.2 x 18.1 / 1000 x 2 = 17.09; pump rate 7.90 l/s; pumped in 30 minutes 14.22; extra storage 2.87; 1% of catchment 4.72; wet well 4.72. CIV-10: site 1,147, impervious 890, effective 878.1; 2 hour runoff 31.79; pump rate 8.52; pumped 15.34; extra 16.45; 1% rule 11.47; wet well 16.45 (rectangular well 9.6 m x 1.5 m). CIV-12: dual 2.5 l/s pumps, minimum 3.00 wet well (the standard's floor); sums not on disk.
6. **Known slips in the office workbooks:** A "small pumps" tab lets the wet well be typed below the standard's 3 cubic metres (1.5 to 3 by a rule of thumb written beside it). Page 2 headers still carry other jobs' numbers. Which version is current, and when under 3 is acceptable: Unknown (Q-003). On real jobs: pump pit size differing between documents.
7. **Worked example CIV-12:** Basement catchment 132 m2, coefficient 1; 1 in 10, 2-hour rain 18.1 mm/hr; volume 4.78 m3; pump 2.50 l/s; pumped in 30 minutes 4.50 m3; extra storage 0.28 m3; "1% catchment" 1.32 m3; "therefore select 3.00 m3 wet well". Page 2 also states "DETENTION = 3m3 (minimum as per AS 3500.3)" against the pump wet well volume (STUDY_D section 5.3 items 2 and 3)
8. **Errors on the CIV-12 pump pages:** The later pump print carries another job's number in its page-2 header; one line reads "12.99 L/d" (STUDY_D section 5.3 item 4)

Evidence: STUDY_B section 1g item 4, 1l items 1 and 3, section 3 item 15, section 5 item 6; DIGEST section 3 item 8; STUDY_D section 5.3.

## S-015 Pump level stack (the named levels in the well)

1. **Purpose:** Set every level in the pump well from the inlet invert down, and the static rise.
2. **Inputs:**
   1. Inlet invert at the pump pit, metres.
   2. Discharge invert (where the rising main lets out), metres.
   3. Wet well volume (S-014) and the well's plan area.
   4. Detention volume, where the detention sits in the same well.
   5. Pump rate (for "one minute of pumping").
3. **The sum in words and as a formula:** High level alarm at the inlet invert; top working level 100 below; pump 2 start 100 below that; pump 2 stop one minute of pumping lower; then the detention volume as a band; pump 1 start; all pumps stop at top working level less wet well volume / plan area; bottom 400 lower. Static rise = discharge invert less the pump level it is measured from (the workbook versions differ on which level: see heading 6).
4. **Output and where it is shown on the sheet:** Pump station section with the level names (seven named levels); static rise, rising main length and size in the pump specification box (E-059).
5. **Worked example from a real job code:** CIV-07: discharge invert 38.99, inlet at pump pit 38.32, static rise 0.67, rising main 6 m of 50 dia, cover 39.18, 2,000 dia fibreglass well; detention band 2.23; all pumps stop 36.72; bottom 36.32; total depth 2.86. CIV-10: static rise 3.11; 18 m rising main of 80 dia; cover 16.65; total depth 2.35; the 9.72 of detention sits in the same well above the pump band. CIV-12: 3.00 static rise, about 20 m of 50 dia rising main.
6. **Known slips in the office workbooks:** Conflict: one version sets top working level 100 below the inlet and takes static rise from it; another takes static rise from the inlet level itself. Bottom level is 400 below pump stop in one tab and 300 in another. Not settled: Q-003. On real jobs: rising main 50 against 80 and 4 m against 50 m between documents.
7. **Worked example CIV-12:** Discharge invert 31.6, inlet at pump pit 28.46, static rise 3.14 m, rising main 18 m of 50 dia, cover 28.97. Level ladder: high level alarm 28.56, top working level 28.36, pump 2 start 28.26, pump 1 start 26.76, all pumps stop 26.66, bottom 26.26, total depth 2.71 m, 1,500 dia. well (STUDY_D section 5.3 item 3)
8. **Conflict (CIV-12 figures):** JOB_KINDS K-012 (from the earlier study, sums not on disk) gives CIV-12 static rise 3.00 and about 20 m of 50 dia rising main; the sums read in full give static rise 3.14 and 18 m. Both kept; not settled (STUDY_D section 5.3 item 3)

Evidence: STUDY_B section 1g item 5, 1l items 1 and 3, section 5 item 6; DIGEST section 3 item 8; STUDY_D section 5.3.

## S-016 Soakage balance (storage needed against storage provided, per pit, per storm length)

1. **Purpose:** Size a soakage pit of plastic modules so that every storm length from 5 minutes to 7 days is held.
2. **Inputs:**
   1. Effective catchment of that pit, square metres (S-001, pervious at 0.3).
   2. Rainfall for each storm length, mm/h: full Bureau table to 7 days; 1 in 10 at first, 1 in 100 after the council asked (whether 1 in 100 is the start for every council: Unknown, Q-013).
   3. Soil rate, mm/h: permeability report (falling-head tests).
   4. Moderating factor: 0.5 sand, 1.0 sandy clay (L-016).
   5. Pit width, length and depth, metres: from the module grid (module 408 x 685, 450 single or 880 double high).
   6. Void share 0.95.
3. **The sum in words and as a formula:** Volume in = rainfall x effective catchment x minutes / 60. Volume out during the storm = (base area + half the perimeter x depth) x soil rate x moderating factor x time. Storage needed = in less out. Storage provided = width x length x depth x 0.95. The sheet prints OK or Inadequate for every storm length.
4. **Output and where it is shown on the sheet:** The soakage pit title with its module count and grid, and its typical section (E-060); the soakage page of the computations.
5. **Worked example from a real job code:** CIV-08 pit 1, final: catchment 647 (387.3 impervious, 259.7 pervious), effective 426.5; soil 259 mm/h; factor 0.5; modules 6 wide x 11 long, double height: 2.448 x 7.535 x 0.88 deep = 16.2 gross; 1 in 100 rainfall; worst storm 90 minutes needs 15.37 against 15.42 provided (1.003: only just OK). History: Rev A (1 in 10, factor 1) pit 1 was 6.9; Rev C pit 1 16.2, pit 2 9.8, pit 3 7.4; the pits on the sheet went to 60, 40 and 30 double modules.
6. **Known slips in the office workbooks:** None recorded for the soakage workbook itself. The council asked to "double check the computations for the soakage pits", which led to the change of storm and factor.
7. **Worked example CIV-13 (check table):** Inputs: catchment 329 m2, coefficient 1, soil permeability 0.325 mm/hr (from the percolation report in the job's folder), moderating factor 2, 1 in 10 year. Module 0.408 wide x 0.685 long; 14 x 13 modules gives 5.712 x 8.905 m; storage depth 0.45 m; porosity 0.95; infiltration area 81.0 m2, perimeter 29.2 m, volume 22.9 m3. Check table: for each storm from 5 minutes up: intensity, volume in, volume out by soakage during the storm, storage needed, storage provided as a ratio, "OK" or "Inadequate". At 5 minutes: 3.04 m3 in, 0.005 out, ratio 11.4 (STUDY_D section 5.4 items 1 to 3)

Evidence: STUDY_B section 1h items 1 to 5, section 2 inputs item 10, section 3 item 16; STUDY_D section 5.4.

## S-017 Emptying time of a soakage pit

1. **Purpose:** How long a full soakage pit takes to drain away.
2. **Inputs:**
   1. Stored volume, cubic metres (S-016).
   2. Outflow rate into the soil (S-016: wetted area x soil rate x moderating factor).
3. **The sum in words and as a formula:** Emptying time = stored volume / outflow rate.
4. **Output and where it is shown on the sheet:** Computations only; not seen on the sheet.
5. **Worked example from a real job code:** CIV-08 pit 1: empties in 4.4 hours.
6. **Known slips in the office workbooks:** None recorded. No limit for the emptying time is given in the evidence: Unknown.
7. **Worked example CIV-13:** Emptying time worked out as 608 hours (25 days). Nothing on the sheet flags it; this job's overflow goes to a dam (Stage 1 notes). Still no limit for the emptying time in the evidence: Unknown (STUDY_D section 5.4 item 4, section 7 item 14)

Evidence: STUDY_B section 1h items 3 and 4; STUDY_D section 5.4, 7 item 14.

## S-018 Charged line head check

1. **Purpose:** Prove a charged (full, under head) roof line to a tank can pass the design roof flow with the head available.
2. **Inputs:**
   1. Roof area to that line, square metres.
   2. Rainfall: 1 in 20 year, 5 minute.
   3. Head from gutter sole to tank inlet, mm (at least 300: L-014).
   4. Pipe size and length; Hazen-Williams roughness 150; fitting losses with a total factor of 4.5.
3. **The sum in words and as a formula:** Design flow from the rain on the roof area; friction loss by the Hazen-Williams formula; fitting losses by the total factor; the head left must pass more than the design flow. The formula lines themselves are not written out in the evidence.
4. **Output and where it is shown on the sheet:** Not printed as numbers. The sheet carries the charged system notes and diagram and the label "100 DIA. UPVC PIPE CHARGED TO WATER TANK" (E-002).
5. **Worked example from a real job code:** None with job figures in the evidence: Unknown.
6. **Known slips in the office workbooks:** None recorded.

Evidence: STUDY_B section 3 item 14, section 0 item 3; GUIDEBOOK_NOTES "Rules of thumb" item 7.

## S-019 Yearly runoff reduction and month-by-month tank balance

1. **Purpose:** Show how much of a year's runoff is taken out by reuse, against a 25% target some growth-area permits ask for (industrial).
2. **Inputs:**
   1. Site area and yearly rainfall (Bureau, yearly and monthly).
   2. Reuse demand: litres per flush x flushes per person per day x people x working days.
   3. Roof area to the tank and tank size.
3. **The sum in words and as a formula:** Yearly runoff = site area x yearly rainfall x 0.9. Target = 25% of it. A month-by-month tank balance (roof runoff in, demand out, overflow above tank size) shows how much is really reused.
4. **Output and where it is shown on the sheet:** Not on the sheet; a computations page or a letter. Whether the 25% is argued by letter each time: Unknown (Q-014).
5. **Worked example from a real job code:** Water tank sizing workbook: 6 x 8 x 8 people x 4 warehouses = 1,536 litres a day, 251 days. Guidebook worked examples: one reached only 11% and argued that as acceptable; the other reached 9.3%. No coded job figure given.
6. **Known slips in the office workbooks:** Only three of the workbook's six tabs were read; none recorded.

Evidence: STUDY_B section 1k items 7 and 8, section 0 item 3.

## S-020 Driveway grade

1. **Purpose:** The grade of each length of a driveway or ramp between the boundary and the garage.
2. **Inputs:**
   1. Garage level, boundary level and site levels at six points along the drive, metres: architect, survey.
   2. Distances between the points.
3. **The sum in words and as a formula:** Each segment's grade (1 in x and %) = rise / length; and the average.
4. **Output and where it is shown on the sheet:** Not stated in the evidence. Fall arrows (E-027) and pavement levels (E-029) are the related sheet items.
5. **Worked example from a real job code:** None in the evidence: Unknown.
6. **Known slips in the office workbooks:** No limits are written in the workbook. Who owns driveway and ramp grades and their limits: Unknown (Q-012).

Evidence: STUDY_B section 1l item 4, section 6 item 18.

## S-021 Long-section rows

1. **Purpose:** The rows of figures under an outfall long section.
2. **Inputs:**
   1. Chainage along the pipe, surface level and invert level at each point: survey and engineer.
   2. Pipe size, grade, design flow (S-022) and velocity (S-009).
   3. Datum level.
3. **The sum in words and as a formula:** Invert depth = surface level less invert level at each chainage. The other rows are carried from S-008, S-009 and S-022. The outfall long section workbook was read; its formulas are not written out in the evidence.
4. **Output and where it is shown on the sheet:** Long section on the outfall sheet (E-062), rows: pipe size, pipe grade, pipe design flow, velocity, invert depth, invert level, surface level, chainage, datum.
5. **Worked example from a real job code:** CIV-05: 225 class 2 rubber-ring-jointed concrete pipe at 1 in 200; design flow 31.75 l/s; velocity 0.8 m/s; datum RL 44.00; horizontal 1:250, vertical 1:25.
6. **Known slips in the office workbooks:** None recorded. Across the 30-job August study only 2 jobs had a long section; "rows and scales differed; no fixed row set recorded".
7. **Structure of the rows on worked examples:** Nine worked long sections: the fullest example's rows, top to bottom, are DATUM LEVEL, PIPE SIZE, PIPE GRADE, Vp - PIPE VELOCITY PART FULL, Qf - PIPE FLOWING FULL, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE; variants carry PIPE CAPACITY or units in the titles (see E-062). Row lines are 1,500 apart; the exaggeration is 2 (1:100 horizontal, 1:50 vertical) on seven examples (STUDY_D section 2.6 items 2, 4 and 5)

Evidence: STUDY_B section 1e item 5, section 3 item 21; DIGEST section 1 item 8; STUDY_D section 2.6.

## S-022 Pipe design flow (rational method, running total down the line)

1. **Purpose:** The flow each pipe run must carry.
2. **Inputs:**
   1. Area draining to the run (a running total down the line), square metres: measured off the drawing.
   2. Coefficient (S-001) and rainfall, mm/h (Bureau).
3. **The sum in words and as a formula:** Design flow (l/s) = area x coefficient x rainfall / 3600.
4. **Output and where it is shown on the sheet:** "Pipe design flow" row of a long section (E-062). Not on a house or units plan.
5. **Worked example from a real job code:** CIV-05 outfall: 31.75 l/s. CIV-10 outfall check: 68.39 l/s.
6. **Known slips in the office workbooks:** The slipped rainfall cell that gives 0 l/s and a false OKAY (S-009). Settled by D-019 for the plain house: not worked there. For other jobs: Unknown (Q-002).
7. **Plain house:** On a house with no detention the pipes are by rule (100 dia. at 1 in 100); no running total of flow is worked (CIV-01). The principal should still confirm (STUDY_D section 5.1 item 3)

Evidence: ENG_NOTES "The chain of sums" item 7 and "Weak points" item 2; STUDY_B section 1e item 5, 1l item 1; STUDY_D section 5.1.

## S-023 Share of detention underground

1. **Purpose:** Show the part of the storage held in pipes and pits (not tanks) meets the council's minimum share (L-010).
2. **Inputs:**
   1. Storage in pipes and pits (S-004, S-005).
   2. Total storage (S-006).
3. **The sum in words and as a formula:** Share underground = (pipes + pits) / total storage.
4. **Output and where it is shown on the sheet:** Not printed as a percentage; it shows in how the storage list is made up.
5. **Worked example from a real job code:** CIV-04: Rev B 1.43 underground of 4.43 = 32%; Rev D 2.22 of 4.42 = 50% (the council's minimum in the guidebook). CIV-06: 2.62 / 4.37 = 60% (that council's minimum).
6. **Known slips in the office workbooks:** None recorded; the share is not a line in the workbooks described.

Evidence: STUDY_B section 1d items 4 and 5, 1f item 2, section 3 item 10.

## S-024 Tank split and tank detention credit

1. **Purpose:** How many litres of a tank count as detention and how many are reuse.
2. **Inputs:**
   1. Tank total litres: architect, sustainability report.
   2. Reuse litres: STORM or sustainability report.
   3. The council's tank rule, where it has one (L-010).
   4. Roof area connected to the tank and impervious area, for the "dispensation" rule.
3. **The sum in words and as a formula:** Settled by D-024: reuse volume comes from the STORM or sustainability report; the rest of the tank is detention; the 30 mm tank orifice is the office standard. Council rules seen: one council counts 500 litres of every 2,000 with no orifice, at least 1,000 above 2,500 litres with an orifice, and at least 50 square metres of roof to each tank; another counts a third of a reuse-connected tank; another a "dispensation" of 0.25 x storage x (roof connected / impervious area).
4. **Output and where it is shown on the sheet:** The tank note on the plan (E-020: total / detention / reuse litres), the tank line in the criteria box (E-041), the tank detail with its litres and 30 mm orifice (E-047).
5. **Worked example from a real job code:** CIV-02: 3,000 litre slimline, 2,000 reuse, 1,000 detention. CIV-03: each tank 1.00 detention. CIV-04: Rev B two tanks at 1.5; Rev D "1100 lt for detention". CIV-06: two tanks at 0.875. CIV-07: 3,000 (1,000 detention, 2,000 reuse). CIV-09: two 6,000 litre tanks, 2.00 detention each.
6. **Known slips in the office workbooks:** The detention workbook's tank line says "minimum storage for each unit 2,000 litres" with no source. On real jobs: tank splits differing between plan and detail on the same stamped sheet. Each tank's litres are typed 3 to 4 times on one sheet.
7. **Flat tank credit seen (CIV-02):** A typed line in the Kingston job's sums: "Water Tank contribution for tanks 2500L or above = 1.00m3" (a flat 1.00 m3 credit for any tank of 2,500 litres or more; source not stated on the page). Whether it is an office rule or a council rule: Unknown. See L-010 (STUDY_D section 5.2 item 5, section 7 item 13, Still unknown item 5)
8. **CIV-09 tanks:** Two 6,000 litre tanks WT1 and WT2 at 2 m3 each in the storage list (STUDY_D section 5.5 item 2)
9. **Owner's ruling on the split:** "Worked out from the volume needed": the detention part of a tank is what the sums say is needed; re-use takes the rest of the tank (D-100)

Evidence: STUDY_B section 1b item 3, 1c item 4, 1d items 4, 5 and 7, 1f items 2 and 3, 1g item 6, section 3 item 10, section 5 item 5; DIGEST section 3 items 5, 6 and 8; ELEMENT_LIST "Seen as a picture" item 7; INTERVIEW item 8zf; STUDY_D section 5.2, 5.5, 7 item 13; D-100.

## S-025 Orifice pit invert stepping and the invert calculator

1. **Purpose:** Step the inverts inside the orifice pit and the detention pits in fixed amounts, and work a pit's invert from the next pit's invert and a wanted grade.
2. **Inputs:**
   1. Orifice pit outlet invert, metres: typed. (The council connection invert is normally fixed on a tight site: D-018.)
   2. For the invert calculator: the lower pit's inlet invert and the wanted grade.
3. **The sum in words and as a formula:** Orifice invert = outlet invert + 20 mm. Orifice pit inlet invert = orifice invert + 20 mm. Each detention pit's inlet invert = its outlet invert + 10 mm. Invert calculator: "type the lower pit's inlet invert and the wanted grade" (its formula is not written out in the evidence). The workbook also prints OK / NOT OK for at least 100 clear to the baffle.
4. **Output and where it is shown on the sheet:** Invert texts on the plan (E-014), the inlet and outlet invert cells of the schedule (E-040), the levels in the orifice pit detail (E-047).
5. **Worked example from a real job code:** None with job figures in the evidence: Unknown. (JOB_C control pit: outlet invert 4.80 and orifice centre shown at 4.82.)
6. **Known slips in the office workbooks:** "Pit numbering to be only from P1 to P5." Everything in the workbook is still typed onto the drawing again. No single rule says which level holds when a pit moves: D-016, D-017 (the critical value governs).
7. **Owner's ruling on the standard steps:** The drop across a pit and the steps in the orifice pit are an "Office standard, can be typed over" (D-084)

Evidence: ENG_NOTES "Added later" items 1 to 3 and "Checked against the issued sheets" items 1 and 2; STUDY_B section 3 item 7; D-084.

## S-026 OSD4W result (outside program; the result is typed in)

1. **Purpose:** Permitted discharge and storage by the Swinburne method, for councils that require the OSD4W program.
2. **Inputs:**
   1. Site area; existing and proposed areas with their coefficients.
   2. Time of concentration and travel time, minutes (10 and 5 unless the council says otherwise; one council said 7).
   3. Rainfall zone (Red Hill, Melbourne, Dandenong seen).
   4. Storm years for outflow and for storage; storage type (pipe).
   5. Where the zone and times come from when the letter is silent: Unknown (Q-006).
3. **The sum in words and as a formula:** Worked inside the OSD4W program, not in an office sheet. The office types the settings and reads the result. OSD4W itself was not read.
4. **Output and where it is shown on the sheet:** Permitted discharge and volume required in the criteria box (E-041); the OSD4W print in the computations PDF.
5. **Worked example from a real job code:** CIV-04: site 937; existing 471 at 0.90 and 466 at 0.35; proposed 519 at 0.90 and 418 at 0.30; 10 and 5 minutes; zone Red Hill; outflow 1 in 2, storage 1 in 10; pipe: permitted discharge 7.87 l/s, storage 4.41, critical storm 15.1 minutes. CIV-05: site 707 all at 0.40 existing and 0.80 proposed; zone Melbourne: 5.93 l/s, storage 5.84. CIV-11 first: site 2,281; existing 0.36, proposed 0.77; 10 and 5; 1 in 20 both: 24.02 l/s, storage 18.2. CIV-11 second: whole site at 0.90; time 7; discharge 1 in 10, storage 1 in 20: 34.53 l/s, storage 17.9.
6. **Known slips in the office workbooks:** Not a workbook. The council guidebook workbook says Boyd's for a council the guidebook lists as OSD4W only (CIV-04 was redone). Councils re-run the sums and quote their own figures.
7. **Owner's ruling on methods in the first release:** "OSD4W / Swinburne" is ticked, with the result typed in. Not ticked, so not day one: council-supplied figures typed in; the council's own calculator (D-098)

Evidence: STUDY_B section 1d item 3, 1e items 2 and 6, 1k items 2 and 4, section 3 item 17, section 5 item 7; ENG_NOTES "What was read"; D-098.

## S-027 STORM rating (outside program)

1. **Purpose:** The water-quality rating that sets the tank reuse volume, roof area to each tank and any raingarden; several councils ask for 100% (L-018).
2. **Inputs:**
   1. Roof area to each tank, tank litres, reuse (toilets, laundry, irrigation), bedrooms or occupants.
   2. Raingarden area and type; paved areas treated and left untreated.
3. **The sum in words and as a formula:** Worked inside the STORM calculator, usually by the sustainability consultant; the office reads the report. STORM itself was not read. How a raingarden's area is chosen: Unknown (Q-005). Superseded by STUDY_D section 5.5 item 6 (answered in part: no separate sizing sum exists; the owner's rule is still Unknown), 16 Nov 2026.
4. **Output and where it is shown on the sheet:** Tank note (E-020), roof-to-tank areas box (E-021), raingarden with its area (E-025). The STORM report is sent beside the drawing; the computations PDF ends with a "WSUD" page.
5. **Worked example from a real job code:** CIV-08: each dwelling's roof (125 to 140) to a 3,000 litre tank; 34 of driveway to a raingarden of 1.0 square metre; 136 of driveway untreated; rating at least 100%. CIV-09: two 6,000 litre tanks, a 1.0 square metre raingarden (100 mm ponding) treating 49.8 of paving; rating over 100%. CIV-10: 696 of roof to a 15,400 litre tank.
6. **Known slips in the office workbooks:** Not a workbook. CIV-08: the final sheet labels a 3.5 square metre raingarden against 1.0 in the report; the sheet and the report differ.
7. **Worked example CIV-09 (STORM report by the office, 13 Mar 2024):** Inputs: municipality and rainfall station (Bayside), development type "Residential - Multiunit", site 1,031 m2, one row per impervious area: "Roof 1 to RWT" 243 m2 -> rainwater tank 6,000 L, 5 bedrooms; "Roof 2 to RWT" 184 m2 -> tank 6,000 L, 4 bedrooms; "Balcony to storm" 10.5 m2, "Roof 2 to storm" 15.2 m2, "Driveway 1" 35 m2 -> no treatment; "Roof 1 to storm" 49.8 m2 -> "Raingarden 100mm", area 1.00 m2. Outputs: treatment 111.8% and 119.6% for the two tanks (tank supply reliability 97.9%), 128.15% for the raingarden, 0 for untreated rows; overall "STORM Rating 103%" (100 is the pass mark) (STUDY_D section 5.5 items 4 and 5)
8. **What changed between the architect's report and the office's:** The office split the roof into what really reaches each tank and what goes straight to the drain, split the tank into two of 6,000 L, and moved the raingarden from the driveway to a piece of roof. The architect's earlier report (May 2023) had 1.00 m2 for 61.76 m2 of driveway and paths (1.6%) with one 12,000 L tank on 506 m2 of roof, scoring 101%. The inputs follow the drainage layout, so the report is redone after the layout is drawn. CIV-08's sheet says "3.5m2 raingarden, min. 1m2 required to treat driveway" (STUDY_D section 5.5 items 6 and 7)

Evidence: STUDY_B section 1h item 6, 1f item 3, 1l item 1, section 2 inputs item 8, section 3 item 18, section 5 item 10; GUIDEBOOK_NOTES "The job in the guidebook's order" item 5; INTERVIEW items 8a and 8f; STUDY_D section 5.5.

## S-028 Combined outlet check with a pump (permissible discharge against site flow plus pump flow)

1. **Purpose:** Show that the flow leaving the site by gravity and by pump together stays under the permissible site discharge, and that the outlet pipe can carry it.
2. **Inputs:**
   1. Permissible site discharge, l/s (S-002; on CIV-12 taken from the existing site).
   2. Flow from the other impervious areas at the 1 in 5 intensity (areas, coefficient, intensity).
   3. Pump flow rate, l/s (S-014).
   4. Outlet pipe size and grade; roughness (S-009).
3. **The sum in words and as a formula:** As typed on CIV-12 page 2: "1 in 5 ARI flow from other impervious areas 445 x 0.9 x 94.3 / 3600 = 10.49 l/s"; "Pump flow rate (basement) = 2.5 l/s"; "Total 12.99 l/s < 16.13 l/s (permissible site discharge), therefore OK". Then the outlet pipe: 150 dia. at 1 in 100 gives 19.80 l/s at 1.12 m/s (S-009); "12.99 < 19.80, therefore OK". Then the 3 m3 minimum detention (AS 3500.3) against the pump wet well volume (S-014), therefore OK.
4. **Output and where it is shown on the sheet:** Computations only (three lines of text on page 2); not on the sheet.
5. **Worked example from a real job code:** CIV-12 (Glen Eira): 10.49 + 2.5 = 12.99 l/s against 16.13 l/s permissible; pipe 19.80 l/s.
6. **Known slips in the office workbooks:** One line on the later pump print reads "12.99 L/d" (units slip). Whether this three-line argument is an office method or a one-off for this council: Unknown.

Evidence: STUDY_D section 5.3 items 2 and 4, section 7 item 12.

---

Next free number: S-029
