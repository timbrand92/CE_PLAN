# Tables and boxes on a civil sheet

What each table, box and notes block holds and how it is built today. Re-filed from the evidence on Mon 16 Nov 2026. Measured facts, not confirmed by the owner. Each part points to its element item in `ELEMENTS.md`.

## How to add to this file

1. Add a new numbered item at the END of the section it belongs to (never renumber), or a new section at the end of the file for a new kind of table or box.
2. Give rows or columns in the order they print, with a real example of each from a coded job.
3. If two pieces of evidence give different rows or wording, record both under "Conflict:" and do not choose.
4. End every section with an "Evidence:" line and name the E-number of the element.

## 1. Pit schedule (E-040)

1. **Build:** NOT an AutoCAD table (there are no table objects anywhere). The dynamic block "Pit Schedle" (spelt that way) on BLOCKS: 13 lines and 4 polylines on SCHEDULE, 12 heading MTEXTs (250, on 35TEXT), a 500-high title, a 180 note. 17,200 wide.
2. **Rows:** one dynamic distance "ROW NUMBERS" with a stretch and an array action adds rows 1500 apart.
3. **Cells:** loose MTEXTs lying on top of the block: layer 25TEXT, height 250, middle-centre, no mask, each in a text box 1000, 1500 or 2000 wide (4200 for remarks, 1100 for pit number). JOB_C has 26 such cells for 2 pits.
4. **Columns, in order:** pit no.; pit size; inlet (from, dia, invert level); outlet (dia, invert level); cover level; depth to outlet; type of lid and remarks.
5. **A pit with two or more inlets** uses a second row with the repeated cells left empty.
6. **What goes in "from":** downpipes, overflows, floor wastes and paved pipes appear as "from" sources, not as pits.
7. **Remarks** carry lid class and silt pit levels.
8. **Three standing notes** sit under it (the same on all three jobs; their wording is not quoted in the evidence: Unknown).
9. **Depth to outlet** = cover level less outlet invert, worked by hand (S-011). JOB_C: P1 5.35 less 4.80 = 0.55; P2 5.78 less 5.25 = 0.53.
10. **Length:** 2 rows to 20-odd rows. All pits scheduled, plastic pits included (a council request).
11. **Outfall sheet:** its own two-row schedule (new side entry pit, existing council pit).
12. **Other routes to the same schedule today:** a LISP helper brings a civil pit schedule in from a CSV file; the present plug-in has a pit schedule command; a pit schedule workbook exists.

Evidence: STUDY_A section 6 item 40; ELEMENT_LIST "Seen as a picture" item 3 and "Across three civil jobs"; DIGEST section 1 item 6; STUDY_B section 1e item 5; STUDY_C section 2A item 14, section 3 item 8; GUIDEBOOK_NOTES "Elements" item 2.

## 2. Detention criteria box (E-041)

1. **Build:** a rectangle polyline on DRAINAGE; a heading MTEXT "ON SITE DETENTION CRITERIA" (350, layer HATCH 11, colour forced to 3, prints green); ONE body MTEXT (250, 25TEXT) with a line per quantity and tab characters between the name and the value. All typed.
2. **Rows, in order:**
   1. Permitted site discharge (l/s): "PERMITTED SITE DISCHARGE <tab> 6.00 l/s".
   2. Head (mm): "HEAD ... 380mm". Settled by D-023: this keeps printing the baffle (plate) height; the sum uses the head to the orifice centre.
   3. Diameter of orifice (mm): "DIA. OF ORIFICE ... 69mm".
   4. Top water level: "TWL ... 5.20m".
   5. Volume required.
   6. Each storage by name: each pit, each detention pipe by size and length, each tank.
   7. Total.
3. **Real examples:** JOB_C / CIV-03: 6.00 l/s, top water level 5.20, orifice 69, head 380, required 1.66, each tank 1.00, total 2.00. CIV-02: 5.0 l/s; orifice 67; top water level 1.31; required 1.49; P1 0.11, P2 0.05, tank 1.00, pipe 0.36; total 1.52. CIV-04: 7.87, orifice 79, top water level 2.15, required 4.41. JOB_B: 6.36 provided against 5.35 required. CIV-11 Rev D: 32.53 l/s, orifice 100, top water level 24.11, total required 17.90.
4. **Order of rows, two readings:** the older study lists "permitted discharge, storage required, storage by member, total, top water level and orifice"; the picture reading of JOB_C lists permitted discharge, head, orifice, top water level, volume required, storages, total. Conflict: recorded, not settled.
5. **Not present** on a job with no detention (JOB_A has no criteria box at all).

Evidence: STUDY_A section 6 item 41; ELEMENT_LIST "Seen as a picture" item 4 and "Across three civil jobs" moving part 1; DIGEST section 1 item 7; STUDY_B section 1b item 3, 1c item 7, 1d item 7, 1k item 5; DECISIONS D-023.

## 3. Roof-area box and site-area box (E-021, E-042)

1. **Roof-to-tank areas box:** one loose MTEXT ("ROOF 1 DISCHARGE TO WATER TANK 1 = 164m2" per line) with a rectangle polyline round it (JOB_C).
2. **Site info box:** the civil template parks a "SITE INFO AND CALCULATIONS" sample (site area, total impervious area, and more not read). Used where a council asks.
3. **Roof hatch legend (E-061):** a hatch legend giving roof area in square metres per dwelling, asked for by one council's list.
4. **Real values:** 164 and 164 (CIV-03); 118.6 (CIV-02); 188.2 and 221.9 (CIV-04).

Evidence: STUDY_A section 6 items 21 and 42; ELEMENT_LIST "Tables and boxes" item 2; GUIDEBOOK_NOTES "Elements" item 14; STUDY_B section 1b item 4, 1c item 7, 1d item 7.

## 4. Pump specification box and pump section (E-059)

1. **Box title:** "Stormwater pump system specifications".
2. **Rows seen (CIV-07):** dual alternating pumps 7.90 l/s; static rise 0.67; rising main 6 m; minimum wet well 4.72; comply with the standard.
3. **Pump station section:** seven named levels: high level alarm; top working level; pump 2 start; pump 2 stop; pump 1 start; all pumps stop; bottom. The detention volume sits as a band between pump 2 stop and pump 1 start.
4. **Notes with it:** "fully tanked pump pit, no groundwater into the pump system"; control panel and alarm note; the standard's pump clauses as notes.
5. **Build (objects, layers, heights):** not measured: Unknown (Q-106). A pump placeholder is parked on JOB_C.

Evidence: STUDY_B section 1g items 5 and 6, section 2 outputs items 2 and 3; ELEMENT_LIST "Tables and boxes" item 4; STUDY_A section 9 item 10.

## 5. Long-section rows (E-062)

1. **Rows seen (CIV-05):** pipe size; pipe grade; pipe design flow (31.75 l/s); velocity (0.8 m/s); invert depth; invert level; surface level; chainage; datum RL 44.00.
2. **Scales:** horizontal 1:250, vertical 1:25 (one council).
3. **Councils ask** for existing services to be shown on it.
4. **No fixed row set:** only 2 of the 30 jobs in the August study had a long section; rows and scales differed.
5. **Build:** not measured: Unknown (Q-102).

Evidence: STUDY_B section 1e items 5 and 6, section 3 item 21; DIGEST section 1 item 8.

## 6. Legend (E-039)

1. **Build:** block "CIVIL LEGEND", inserted on BLOCKS at scale 1, 9250 x 30,190, 224 objects: sample pipes (polylines of width 150 and 225 on the real pipe layers), lines, 40 texts (250 / 200 / 180), small nested symbols.
2. **Identical on all three jobs; not edited per job.** A symbol in it does not mean the item is on the job.
3. **Items only in the legend on the three jobs:** suspended pipe; PAVEMENT LEVELS; KERB & CHANNEL.
4. **A second legend:** the structural layer-legend block ("LAYERS") is parked in every civil job.

Evidence: STUDY_A section 6 item 39, section 2 civil layers 3, 23 and 42, section 8 item 8; DIGEST section 1 item 11.

## 7. Notes blocks (E-038)

1. **Build:** each is ONE block holding one long MTEXT (250 or 280) plus a shadow box, inserted on BLOCKS. To change a word the drafter edits inside the block.
2. **Kinds:** general notes (stormwater under slabs, neighbour permission note, and others not read in full); council notes; the disclaimer ("CVL DISCLAIMER NOTE"); the before-you-dig block (on BYDA, scale 0.5); charged system notes; the standard's pump clauses on pump jobs.
3. **Council notes:** the council's own block; one council alone had at least 27 different note blocks depending on the job's conditions. The council notes say the invert at the discharge point is assumed.
4. **Job-dependent notes:** tree protection note; neighbour's footing note; retaining wall note; soakage assumptions note; a note about the 1 in 100 year storm (overland flow).
5. **Known error:** the standard quoted with three different years on real jobs.

Evidence: STUDY_A section 6 item 38; ELEMENT_LIST "Details on the sheet" item 6, "Seen as a picture" item 8 and "Across three civil jobs" moving part 3; MODEL_NOTES "What it teaches" item 8; DIGEST section 3 item 8; STUDY_B section 1a item 5, 1g item 6.

## 8. Warning boxes (E-037)

1. **Build:** each is its own machine-named block inserted on STORMWATER at scale 0.967: a solid hatch on HATCH 51, an outline on HATCHOUTLINE, one MTEXT (250 to 300), and a nested dynamic "shadow box" (two polylines on 35CONT, one of width 150 forming the drop shadow, stretchable).
2. **Where:** a row along the top edge of the sheet (warning / read-with boxes). On paper: yellow box, black shadow.
3. **Risk notes on the plan:** boxed, often red, placed at the spot they concern.
4. **Unknown:** why colour 250 prints yellow (Q-103); the wording of each box is not quoted in the evidence.

Evidence: STUDY_A section 6 item 37, section 10 item 3; DIGEST section 1 items 1 and 10; ELEMENT_LIST "Seen as a picture" item 1.

## 9. The computations sheet that goes beside the drawing (E-048)

1. **Pages (two to four):** required figures; storage list; orifice sum; then "WSUD".
2. **Sent with it:** the discharge letter; the council's form (declaration, checklist) where it has one; STORM report; sometimes pump specifications and the permeability report.
3. **The office sheet for it** is a separate small drawing (6 blocks, 2 fields, no tables), not examined further.
4. **Settled by D-021:** the sums live inside the plugin and the computations sheet prints from the same numbers.

Evidence: STUDY_B section 1 "Common path" item 4, section 2 outputs item 4; STUDY_A section 6 item 48; DECISIONS D-021.
