# R-010 Pit lid class by where the pit sits (revision 1)

Written 18 Nov 2026 (Melbourne). Read-only research. Nothing built, nothing installed, AutoCAD not touched. No job names, addresses or job numbers: jobs are coded JOB-A to JOB-G, and CIV-xx are the reference library's own sheet codes.

## The short answer for Tim

1. **You are right.** The class follows where the pit sits and what can drive over it, not the job. "Once for the job" is wrong for any job with a garden pit and a driveway pit.
2. **The standard** (AS 3996) has A for pedestrians only, B for light vehicles, C for slow commercial vehicles, D for roads and heavy vehicles. The office's own sheets agree with that order.
3. **The office's practice:** 17 pits on 4 jobs: Class A 6 (houses and a unit block), Class C 7 (an industrial slab), Class D 4 (an industrial carpark slab). No Class B pit on any issued sheet I could read.
4. **One list can drive both:** the "what is over it" list that sets pipe cover (D-133) can set the lid class too, with about four lines added. The drafter says it once; both follow; typing over always wins.
5. **Cannot be read reliably from the drawing:** a closed driveway or slab outline says "a vehicle can drive here", but not which class. Garden is only "no outline found", never proof.
6. **Three things to put to Tim** are in section E. The rest the evidence already answers.

## A. The rule in one sentence

The lid class of a pit comes from the situation it sits in (what can reach or drive over it), taken from a short list that is the same list the pipe cover uses; a council's own figure or a class typed by the engineer replaces it, and where a pit could be in two situations the higher class governs (the same "larger governs" habit as D-144 and D-145).

## 1. What the classes mean (the standard)

1. **What I could read.** AS 3996 (access covers and grates) is paid-for, so I could not read the standard itself. I read supplier and council pages that reproduce its table. Sources: "Mascot Engineering AS3996 Load Ratings" (Mascot Engineering, a 2015 sheet quoting the 2006 edition); "Mascot LoadRatings v1" (Mascot Engineering, 2020, quoting the 2019 edition); "Load Ratings Explained: Class A, B, C & D Grates Under AS3996" (Buda, Australian supplier); the AS 3996 page of ACO Drain (images only, no readable table); Port Phillip City Council standard drawings "Stormwater modified grated side entry pit at vehicle crossing" and "Stormwater property drain inspection opening pit"; Banyule City Council "standard drawings pit details" and Geelong City Council infrastructure design notes on plastic pit lids (the last two read through search extracts only).
2. **Class A, about 10 kN design load (about a 330 kg wheel).** 2006 wording as quoted: areas, including footways, accessible only to pedestrians and cyclists and closed to other traffic. Suppliers: foot traffic only, garden beds, patios.
3. **Class B, about 80 kN (about a 2,670 kg wheel).** 2006 wording as quoted: areas, including footways and light tractor paths, accessible only to vehicles (excluding commercial vehicles) or livestock. Suppliers: light vehicles, carparks, residential driveways. Banyule uses B for off-road ("medium duty") covers.
4. **Class C, about 150 kN (about a 5,000 kg wheel).** 2006 wording as quoted: areas, including pedestrian malls, open to slow-moving commercial vehicles. Suppliers: commercial driveways, delivery zones, light industrial. Port Phillip uses C for a footpath pit that is not trafficable by design.
5. **Class D, about 210 kN (2006 table).** Carriageways of roads and areas open to commercial vehicles. Port Phillip uses D for a pit in the road at a vehicle crossing. Banyule: D for "trafficable" locations.
6. **E, F, G.** Higher again: E about 400 kN (freeway carriageways, docks); F and G for docks, wharves and aircraft pavements (G about 900 kN). F and G figures UNVERIFIED.
7. **Do the sources agree?** On order and on A, B, C figures, yes. They disagree on D: 210 kN in the 2006-based tables, 240 kN in a 2019-based extract and in an Auckland specification (New Zealand, so not ours). Two figures per class appear in tables (a lower service load and the higher ultimate load, roughly two thirds). The class letters and their order are the same in every source.
8. **The reference's own one-line list** (L-019: A foot traffic, B driveways, C car parks, D warehouses and docks, from a "Guidebook picture") is looser than the standard: the standard puts slow commercial vehicles in C and roads in D, and a council reading will follow the standard.
9. **AS 3500.3 and Melbourne councils.** I found nothing in AS 3500.3 (not read in full, UNVERIFIED) and nothing in the councils held in our reference that sets a cover class for private stormwater pits. The only council line in the reference is Frankston's sent-back list: "class C solid covers on both orifice pit chambers" (reference C-007, item 3 of the sent-back list). Council standard drawings for council-owned pits do name a class by location (Port Phillip: road D, footpath C), which is council practice, not the plumbing standard.

## 2. What this office actually does

### 2a. The reference library

1. **Rule written down (L-019):** "A pit lid or grate is chosen by the load over it", council first where it asks, then the guidebook. Seen on jobs: B and C on houses and units, D on industrial.
2. **Sheet wording seen (reference):** CIV-08 silt pit "Class B Grate", plastic pit "Class A Grate"; CIV-11 eight pits "Class D Solid Lid With Step Irons" and "Class D Grated Lid With Step Irons"; CIV-10 basement: "300(W) TRENCH WITH CLASS C GRATE" across a ramp and "600 x 600 WITH CLASS C GRATE" sump pits; CIV-07 pump box "SOLID CLASS C LID"; grated class C trafficable cover on the pump station detail.
3. **The old template pump box** reads "SOLID CLASS B LID" as a placeholder; it is unedited on three sheets, so it is not a decision.
4. **Schedule wording (D-112/D-113):** column "TYPE OF LID AND REMARKS"; standing note "ALL GRATED COVERS TO BE HEEL SAFE UNLESS NOTED OTHERWISE. ALL COVERS TO BE PROFILED AND POSITIONED TO SUIT EXISTING SURFACE LEVELS, PAVING LAYOUTS, SPOON DRAINS, KERB CHANNELS AND OTHER FEATURES AS DETAILED ON ARCHITECTURAL DRAWINGS."

### 2b. The old-job drawing copies (231 DXF files read as text; 387 DWG-only files could not be read)

1. **How many jobs.** Seven civil jobs had a readable pit schedule or pit data. Four have an office-chosen class on their pits (JOB-A to JOB-D), one has a schedule with no lid column and the classes only in typical details (JOB-E), one is an import design file with class labels I could not tie to pits (JOB-F), one is a drawing made by the old plug-in from an imported design whose lids are the importer's default Class A (JOB-G, not an office choice). Three copies of one job (original, revision A, council issue) are counted once.
2. **Counts, pits with a class on the schedule.** JOB-A (unit block with basement and pump): P1 "Class A Lid + Grate", P2, P3, P4 "Class A Grate" = 4 pits, all A; the sump, silt, pump station and council pit carry no class. JOB-B (industrial slab): 7 pits, all "Class C Grated Lid With Step Irons", 900 x 900. JOB-C (industrial carpark slab): 4 pits, all "Class D Grated Lid" (one with step irons). JOB-D (house): 2 plastic pits "Class A Grate". Total 17 pits: A 6, B 0, C 7, D 4.
3. **Trench grates on the same sheets** (not pits, but the same decision): JOB-C "300, 200, 100 WIDE TRENCH WITH CLASS C GRATE" and one "200 WIDE x 100 DEEP TRENCH WITH CLASS D GRATE"; JOB-D four notes "150 WIDE TRENCH WITH CLASS C GRATE" and one "300 WIDE" across a driveway or garage; the library and details carry "TRENCH WITH CLASS C GRATE" as the standing note. Trench grates are Class C even on a house, which is higher than the standard's B for a residential driveway.
4. **Typical details (the office's detail library and JOB-E).** Orifice pit details come in A, B, C solid and grated variants (counted by note lines in the library file, roughly: A about 50, B about 30, C about 20, D only 2, the D being "CLASS D GATIC LID", a proprietary trafficable lid). JOB-E details: "Class C Grate - Silt Pit with Heel Safe Cover", "Class C Solid Lid + Step Irons with Heel Safe Cover", "Class D Grate with Heel Safe Cover". Tank details: "CAST IRON CLASS B COVER (6.5 TON MAX. LOADING)", "CAST IRON CLASS A COVER", "TRAFFICABLE TANK COVER TO MATCH FFL", "HEAVY DUTY CLASS C LID". These are library copies, so they show what the office draws, not how often it is chosen.
5. **Notes that state a rule.** Only one, on the orifice pit detail (in the library and three copies): "PIT COVER TO BE HEAVY DUTY GRATED TYPE IF IN COMMON OR TRAFFICABLE AREA." I found no sheet note of the form "ALL PITS IN TRAFFICABLE AREAS TO HAVE CLASS ... COVERS".
6. **Class by location.** The DXF cannot say it directly, so I tested each plan pit's insertion point against the driveway-slab hatch (layer HATCH 21) and the slab perimeter line. JOB-B: of 9 pit blocks on the plan 8 sit inside the slab (the ninth just outside it; the 7 scheduled Class C pits are among them). JOB-C: of 5 pit blocks 3 sit inside the slab perimeter and 2 are outside; I cannot say which block is which scheduled pit, so the four Class D pits are NOT individually located. JOB-A and JOB-D: pit blocks are anonymous or on other layers; location NOT readable, counted separately: 6 pits (A 4, A 2) with location unknown. Reliability: inside or outside a slab outline is good; what lies outside it (garden, path, nature strip, road) is not drawn on the layers I could test, because driveway, footpath and landscape lines sit in a background file I did not combine.
7. **Classes on one job.** One class on every job's pit schedule (JOB-A A, JOB-B C, JOB-C D, JOB-D A). Two classes on one job appear only where the reference shows a silt or plastic pit beside others (CIV-08: A and B) and in JOB-E's details (C and D).
8. **Grated against solid in the same location.** Same class every time I can compare: CIV-11 (D solid and D grated), JOB-E (C solid and C grate), the old plug-in importer (A solid and A grated), the orifice detail library (solid and grate variants in every class). No case of a different class for solid against grated in the same spot. Four comparisons.
9. **Plug-in made job (JOB-G):** 7 pits, all Class A (6 grated, 1 solid), 5 of them plastic 350 pits. Not an office decision; it is the importer's default.

### 2c. The old plug-in's own data (commit 2c8b7b1a)

1. **Default for a new pit:** "Class C Grated Lid", and a lid strength letter "C" (the Pit window had a "lid class" text box defaulting to C; the plastic pit preset also kept C; the parts catalogue gave every pit C).
2. **Importers defaulted to Class A:** pits read from an imported design (XCivil or LandXML) became "Class A Grated Lid" or "Class A Solid Lid"; a control (orifice) pit read from a schedule became "Class A Solid Lid".
3. **No list of situations and no rule by location.** One letter per pit, set once, never derived. Tanks, AGI drains and trench grates were changed to carry no lid at all (26 Sep 2026 rulings).

## 3. What Tim has already ruled

1. **D-133:** pipe cover from a table by "what is over it": single dwelling no traffic 100; other site no pavement 300; under traffic no pavement 450; under reinforced pavement 100; under light pavement 75; detention pipe keeps 300. D-144: larger of council and standard. D-145: larger of kind and situation. D-146/D-152: slab by what is over it; the planning chat's path 0.10, driveway 0.125, crossover 0.15 are its own guesses, not Tim's.
2. **D-104:** pit kinds on day one are junction, grated, plastic, orifice (control), pump and bought-in units. A junction pit is the solid-lid state of the office pit block (the cross), a grated pit the grated state.
3. **D-112/D-113:** the schedule's "TYPE OF LID AND REMARKS" column and standing notes as in 2a.
4. **D-229 / R-009:** the office pit is the master drawing's pit block with states GRATED PIT, SOLID PIT, DETENTION PIT (two chambers), pump grated and solid; R-009 already lists an optional "orifice pit with both lids solid" state for the council that asked for it.
5. **What the new Pit window holds today:** the lid choice is only "Grated or Solid"; there is no class field. The schedule's lid cell is a typed text ("Class C Lid + Grate", "Class A Lid", "Class A Grate" on the bench job), held as a chosen word.
6. **The disagreement found on the bench (P3):** the Pit window says "Junction pit, Grated lid" while the schedule says "Grated pit, Class C Lid + Grate". Cause: kind and lid are two separate choices in the window and a third typed text in the schedule. One of them must drive the others. Proposed in C below.
7. **Wording on issued sheets** is "Class C Grated Lid" and "Class A Grate", not "Lid + Grate": "Class X Grated Lid" or "Class X Solid Lid" is by far the commonest form (JOB-B, JOB-C, CIV-11, plug-in made sheets); "Class A Lid + Grate" appears once, on JOB-A.

## B. The situations list, with the class for each

Evidence figures are pits (or sheet lines) counted in section 2. "Standard" means the minimum the AS 3996 tables as quoted give. Where the office goes higher than the standard I have kept the office's.

1. **Garden, lawn or landscape, no vehicle can reach it: Class A.** Evidence: 6 pits on 2 jobs (JOB-A 4, JOB-D 2; location of the JOB-A four unread), plus 2 library plastic and tank details. Standard: A (pedestrians only). Source: office sheets and library. Status: office practice equals the standard.
2. **Footpath or paved path, pedestrians only: Class A.** Evidence: none from the office. Standard: A (footways closed to other traffic). Council practice differs (Port Phillip uses C on a footpath pit). Status: UNKNOWN for the office; A is the standard's minimum, Tim to say whether a path takes A or the council's C.
3. **House driveway or crossover, cars only: Class C.** Evidence: no issued pit on a house driveway found; the trench grate across a house driveway or garage is C on 5 note lines of one job, and the old plug-in default for every pit was C. Standard: B. The office is HIGHER than the standard here, so keep C for grates and use C as the pit proposal. Status: office practice by analogy (thin), flagged for Tim.
4. **Common driveway, carpark or hardstand for units, bins and light trucks: Class C.** Evidence: JOB-B 7 pits C (industrial hardstand, so applies only by analogy to units); the note "HEAVY DUTY GRATED TYPE IF IN COMMON OR TRAFFICABLE AREA" supports a heavy-duty grated lid. Standard: C (slow commercial vehicles open). Status: supported.
5. **Basement carpark or ramp, including sumps and ramp trench grates: Class C.** Evidence: CIV-10 only (sump pits C, ramp trench C, pump lid solid C): 3 lines, 1 job. Status: thin but consistent; keep C.
6. **Commercial or industrial hardstand with trucks: Class D.** Evidence: JOB-C 4 pits D and CIV-11 8 pits D (2 jobs, 12 pits), against JOB-B 7 pits C on a similar slab (1 job). Standard: D for areas open to commercial vehicles (2006 table). Status: office split, D on the majority; flagged for Tim (E1).
7. **Council road or nature strip: Class D.** Evidence: none from the office (these pits are the council's). Standard and council drawings: D. Status: UNKNOWN for the office; do not fill beyond "Class D, council".
8. **Not by situation: tank and pump access covers.** They keep their own cover words ("CAST IRON CLASS B COVER", "TRAFFICABLE TANK COVER TO MATCH FFL"). Out of the pit list; unchanged.
9. **A council's own request** (for example class C solid covers on both orifice pit chambers, Frankston) overrides any line above; the pit shows a typed-over mark like every other typed value, and the larger of the council and the situation governs (D-144 logic).

## C. How it joins what is already ruled

1. **Same situation, both follow.** Yes. The D-133 list is five lines: single dwelling no traffic, other site no pavement, under traffic no pavement, under reinforced pavement, under light pavement. It can drive the lid class as a second column: no traffic gives A; under traffic no pavement gives C; under reinforced pavement gives C; under light pavement gives A or B (UNKNOWN, light pavement is a path or a paved yard). "Other site, no pavement" does not say whether a vehicle can reach it, so it needs the answer Tim gives to line 3 above.
2. **The list needs about four more lines** that pipe cover also needs and that the draft slab table already hints at (path, driveway, crossover): house driveway or crossover, common driveway or carpark, basement, council road. Each new line carries one cover figure and one lid class, so the drafter gives the situation once. The planning chat's path, driveway and crossover slab figures are still its guesses.
3. **Pit against pipe.** A pit takes the situation of the surface at the pit; where the pipes that meet at the pit have different situations the higher lid class governs.
4. **Grated against solid.** The class is the same; kind decides grated or solid. Fix for the P3 disagreement: kind drives the lid style (junction pit = solid, grated pit = grated, plastic pit = grated, D-104), class drives the letter, and the schedule cell is built from both ("Class C Grated Lid", "Class C Solid Lid") with step irons or heel safe added as remarks. The window's separate Grated or Solid lid choice goes away for ordinary pits; typing over the schedule cell still wins and shows its padlock (D-103).
5. **Orifice (control) pit, two chambers.** One council asked for exactly this, quoted from the Frankston sent-back list: "class C solid covers on both orifice pit chambers". The office's own orifice detail already carries "PIT COVER TO BE HEAVY DUTY GRATED TYPE IF IN COMMON OR TRAFFICABLE AREA". Proposal: each chamber takes the situation's class; a council request sets both chambers (R-009's optional both-solid state); the grated chamber stays grated unless the council asks otherwise.

## D. How the plug-in would know the situation without asking each time

1. **From the last pit placed.** Simple and right on most runs of pits in one area, wrong the moment the run crosses from garden to driveway. Use as the starting value, shown as a proposal, not a silent fact.
2. **From a closed outline or hatch the pit sits inside.** Office layers (layers.csv): HATCH 21 (driveway slab fill, colour 49 in jobs), SLAB PERIMETER and the slab joint layers, HATCH 150 (permeable paving), DRIVEWAY and A-SURVEY (driveway lines, crossover, footpath) which live in the background file, A-LANDSCAPE (trees), KERB & CHANNEL, HATCH 141 (building footprint). Inside HATCH 21 or SLAB PERIMETER means a vehicle can drive there; the pit then proposes the "driveway or hardstand" line.
3. **Honest reliability.** Good for "inside a driveway or slab outline" (JOB-B: 8 of 9 pit blocks inside the slab; JOB-C: 3 of 5 inside). Poor for the class itself (a slab outline cannot tell a house driveway from an industrial truck yard from a basement) and useless for "garden": no outline found must read "not known", never "garden". HATCH 21 is also used for a single slab covering the whole site on the industrial jobs, so a pit inside it is trafficable almost by definition. The background file would have to be read too for footpath, crossover and nature strip.
4. **Asked once per pit** when neither of the above gives an answer, as one quiet line with the proposed value ready to accept, never a blocking window.
5. **Proposed order:** a typed value; else the outline the pit sits in; else the last pit placed; else ask once. Whatever is used shows where it came from, in plain words ("from the driveway outline").

## E. What should be put to Tim next (at most three)

1. **The list.** "Lid class follows the same 'what is over it' list as pipe cover, with these lines: garden or landscape A; paved path A; house driveway or crossover C; common driveway or carpark C; basement carpark or ramp C; industrial hardstand with trucks D; council road or nature strip D. A council's own request overrides." Evidence: 17 office pits (A 6, C 7, D 4) on 4 jobs, plus the standard. Real-world example: a unit block's common driveway pit takes C and its garden pit takes A, from one choice each. Two lines flagged for his word: house driveway pit C against the standard's B (office trench grates and the old default are already C), and industrial trucks D against one job that used C.
2. **How the plug-in learns it.** "Inside a driveway or slab outline it proposes the driveway class and shows 'from the driveway outline'; outside any outline it carries on from the last pit and says so; you can type over any of them." Evidence: 8 of 9 plan pits on the industrial slab job fell inside the slab outline; no outline means "not known", never "garden". Example: a plastic pit in a lawn beside a slab stays Class A until you place the next one inside the paving.
3. **The wording on the sheet and the P3 fix.** "The pit's kind decides grated or solid, the situation decides the letter, and the schedule prints 'Class C Grated Lid' or 'Class C Solid Lid' (as issued sheets do), with 'With Step Irons' added where the depth needs it." Evidence: 11 issued rows use that form; the bench's "Class C Lid + Grate" appears on 1 row (JOB-A, as "Class A Lid + Grate"). Example: pit P3 can no longer be a junction pit in one window and a grated pit in the schedule.

**Not to ask, because the evidence or the standard already answers it.**
1. Whether the class is set once for the job (no: every issued job holding more than one place has the choice by pit).
2. What classes A to D mean (the standard and four sources agree on order and on A to C loads).
3. Whether grated and solid pits in the same place share a class (four comparisons, always the same).
4. Whether a council's request beats the table (D-022 order and D-144: the larger governs; typed value wins).
5. Whether orifice pit chambers are treated separately (the office detail and Frankston already give the answer in C5).
6. Whether to carry the heel-safe note (it is already a standing note, D-113).
7. Whether AS 3500.3 sets a class (not found; the table is by situation as in D-133, nothing to ask).

## F. What I could not verify

1. **AS 3996 itself.** Paid-for. The class wording above is from supplier tables quoting the 2006 edition; the 2019 edition may word the classes differently (one 2019-based extract puts D at 240 kN and E on freeway carriageways). Class F and G figures UNVERIFIED. Wording quoted from memory of the 2006 table where I give "closed to other traffic" and "slow-moving commercial vehicles" is as the search extracts gave it, not from the standard.
2. **AS 3500.3's own text** on covers and any Victorian plumbing rule for pit covers: not read, UNVERIFIED; nothing found.
3. **Councils.** Only Frankston is in the reference and it speaks only of orifice pits. Port Phillip, Banyule and Geelong were seen through search extracts, not read in full; no Melbourne council's rule for private stormwater pits found.
4. **The drawing copies.** Only the 231 DXF files could be read; 387 DWG files were not opened, so jobs are the seven DXF jobs, four with a class. Pit location is readable for 2 jobs only and then only inside or outside a slab outline; the four Class D pits cannot be tied to their scheduled numbers. Some pits sit in a background file or an anonymous block I did not combine.
5. **Whether JOB-B and JOB-C are truly industrial.** The reference and slab notes say so (industrial ground floor footings, carpark slab); I did not see the architectural plans.
6. **The "Guidebook picture"** behind L-019 was not opened.
7. **Counts in 2b item 4** (note lines per class, approximate) include repeated copies of the same detail, so they show what is drawn, not how often it is chosen.
