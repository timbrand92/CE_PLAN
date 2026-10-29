# Questions for civil engineers about the Design Guidebook v1.3 — DRAFT 29 Oct 2026

**STATUS: DRAFT. Tim has not reviewed this. Nothing here goes to an engineer until Tim says so.** (Stage 3 of `decisions\2026-10-29_TIM_ANSWERS.md` item 23.)

**How these were studied.** Each question was checked against the guidebook (page numbers below are the book's printed pages) and against CE_PLAN: `decisions\` (the 25 Sep rulings, the 29 Oct answers), `02_COUNCIL_RULES\OPEN_QUESTIONS.md`, `ENGINEERING_RULEBOOK.md`, `areas\council-rulebook.md`. A question that CE_PLAN already answers is dropped and listed at the bottom with the reason. The engineering evidence is in `GUIDEBOOK_V1_3_VS_CE_AUDIT_2026-10-29.md`.

**Wording.** Plain English, one line of context, a job example, our recommended answer. Engineers answer "yes / no / different number". Where we recommend something it is a starting point, not a decision (never turn an unanswered question into a decision).

---

## A. Pipes and pits

1. **Flattest fall for ordinary pipes.** DRAFT
   1. **Context:** The guidebook says "minimum pipe slope 1 in 100" (p48). The plugin lets bigger pipes go flatter (225 at 1 in 200, 300 at 1 in 250, 375 at 1 in 300, 450 and up at 1 in 200).
   2. **Job example:** An 18 m run of 300 pipe with 70 mm of fall is 1 in 257. The plugin passes it; the book's rule fails it.
   3. **Question:** For pipes that are not detention pipes, what is the flattest fall you accept at each size from 100 to 750?
   4. **Recommended answer:** 1 in 100 up to 150, 1 in 200 from 225 up, with a yellow warning between; then you write the sizes you actually use.
2. **Flattest fall for detention pipes.** DRAFT
   1. **Context:** The book gives 1 in 200 for detention pipes 225 and up, but only for Darebin, Banyule, Manningham and Maroondah (p41 to 45). The plugin uses 1 in 200 for every council. Manningham's own 2021 checklist says 1 in 180.
   2. **Job example:** A 450 detention pipe in Kingston laid at 1 in 250.
   3. **Question:** Is 1 in 200 your rule for every council, and is Manningham 1 in 180 or 1 in 200?
   4. **Recommended answer:** 1 in 200 everywhere (the real 2026 drawings I looked at use 1 in 194 to 1 in 203); Manningham 1 in 180 because it is the council's own newer figure.
3. **Cover by where the pipe sits.** DRAFT
   1. **Context:** The book prints the full Standard table (p19). The plugin uses one number (300) plus a council figure (Frankston 250).
   2. **Job example:** A 150 UPVC in an unpaved vehicle area at 300 cover. The table asks for 450. Under a concrete driveway the table allows 100.
   3. **Question:** Should the plugin read cover from the table by surface (garden, unpaved vehicle area, under concrete, road), instead of one number?
   4. **Recommended answer:** Yes; the drafter or the lid class picks the surface; a council figure still overrides.
4. **Shallowest pit for a given pipe.** DRAFT
   1. **Context:** The book gives a minimum pit depth for each StormPro size with 300 cover (p48): 150 = 459, 225 = 543, 300 = 622, 375 = 701, 450 = 781, 525 = 862, 600 = 939, 750 = 1083, 900 = 1236 mm.
   2. **Job example:** A 450 detention pipe into a pit 700 deep. The plugin says nothing; the book says 781.
   3. **Question:** Should the plugin warn on this for every pipe (working out the depth from the pipe's real size), or only for StormPro detention pipes?
   4. **Recommended answer:** Every pipe, from its real size and the cover that applies.
5. **Lid class on a unit driveway.** DRAFT
   1. **Context:** The book's load chart (p48) puts private driveways and unit sites in Class B and residential roads and car parks in Class C. The plugin chooses Class C for driveways. (Tim already ruled the class comes from the surface and is a Settings value; this asks which value.)
   2. **Job example:** A pit in a two-unit shared driveway.
   3. **Question:** Is that Class B or Class C at your office?
   4. **Recommended answer:** Class B for a shared residential driveway; Class C where a larger vehicle drives over it.
6. **Pipes under garages.** DRAFT
   1. **Context:** The book says no detention pipes under dwellings or garages (p16). The council checklists (p32 to 38) say pipes under the garage must be 150 UPVC SN8.
   2. **Job example:** A rear garage between the pit and the legal point of discharge.
   3. **Question:** May a plain connecting drain pass under a garage in 150 UPVC SN8 while detention pipes may not?
   4. **Recommended answer:** Yes; the plugin warns on any detention pipe under a building and on any other pipe under a garage that is not 150 UPVC SN8.
7. **Maximum water speed in a pipe.** DRAFT
   1. **Context:** The book names no maximum or minimum speed (checked). The plugin holds placeholders (UPVC 3, concrete 6, metal 4 m/s) and Tim is still waiting for an authority.
   2. **Job example:** A steep 225 UPVC leaving a pit at 4 m/s.
   3. **Question:** What maximum speed does the office design to for UPVC, concrete and steel, and what document says so?
   4. **Recommended answer:** The engineers name the figure and the document; until then the plugin warns, never blocks.

## B. Detention, rainfall and councils

8. **Which rainfall for Boyd's jobs.** DRAFT
   1. **Context:** The book's own Boyd's sheet (p11) uses site rainfall from the Bureau of Meteorology: 113 mm/h for 5 minutes at 1 in 10. The plugin uses one fixed Melbourne curve: 105. That is about 5 to 8 per cent lower, and storage changes about 2.5 times as much.
   2. **Job example:** A 746 m2 multi-unit site; the book's sheet needs 2233 L, the plugin would show a smaller number.
   3. **Question:** For Boyd's jobs, do you always take the site's own Bureau figures, or is the Melbourne curve acceptable?
   4. **Recommended answer:** Site Bureau figures for Boyd's jobs (that is what councils check); keep the OSD4W Melbourne zone for OSD4W jobs.
9. **Glen Eira underground share.** DRAFT
   1. **Context:** The book now says the entire detention may be in tanks, or tanks and pipes (p34). The plugin still demands 50 per cent underground for Glen Eira.
   2. **Job example:** A 700 m2 Glen Eira site with 3.8 m3 of storage in two tanks.
   3. **Question:** Is there any minimum underground share in Glen Eira now?
   4. **Recommended answer:** No minimum; remove the 50 per cent and record the change against the guidebook version.
10. **Maroondah (and Banyule) sites that fall to the rear.** DRAFT
    1. **Context:** The book says Maroondah sites sloping to the rear may need 1 in 20 (p45). Tim has already ruled that Banyule jobs ask once whether the site falls to the rear (UX-CR-16).
    2. **Job example:** A Maroondah site where the legal point of discharge is at the back.
    3. **Question:** What counts as "falls to the rear", and does the 1 in 20 apply to the permitted discharge, the storage, or both?
    4. **Recommended answer:** The engineer decides per job; the plugin asks once, records the answer and the storm used.
11. **Casey and the growth-area councils.** DRAFT
    1. **Context:** The book's first table (p9) says Casey uses Boyd's. Its council pages (p46) put Casey with the growth-area councils designed to the EDCM standard (reuse, MUSIC model, registration number). The plugin treats Casey as council-provided with its own orifice formula.
    2. **Job example:** A Casey 6-unit job.
    3. **Question:** Which method and which documents do you use for Casey, Cardinia, Hume, Melton, Wyndham, Whittlesea and Mitchell today?
    4. **Recommended answer:** Follow the newer council pages (growth-area EDCM) and keep Casey's own orifice formula until the council changes it.
12. **Industrial sites with an existing outlet stub.** DRAFT
    1. **Context:** The book (p8) says calculate the 1 in 10 flow; detention is needed only if the existing stub carries less; also find the 1 in 100 overland path. The plugin has no such test.
    2. **Job example:** A 3000 m2 warehouse connecting to an existing 375 stub.
    3. **Question:** How do you work out what the existing stub can carry (size, fall, roughness) and who confirms the fall?
    4. **Recommended answer:** The engineer enters the stub size and fall from the council's records; the plugin works out the capacity and warns, never blocks.

## C. Pumps and soakage

13. **Pump storm: one fixed storm or a sweep.** DRAFT
    1. **Context:** The book's pump sheet (p24) uses one 2-hour storm at 1 in 10 and 30 minutes of pumping. The plugin sweeps all storm durations and takes the worst.
    2. **Job example:** A small basement ramp pit: the book's sample sheet gets a 6.92 m3 well from the 2-hour storm; the plugin could pick a different storm and a different well size for the same site.
    3. **Question:** Is the 2-hour storm the office rule, or is the worst storm the rule?
    4. **Recommended answer:** Keep the sweep but print the 2-hour answer beside it, so the sheet matches the book's pump sheet.
14. **Bayside pump storm.** DRAFT
    1. **Context:** The plugin forces Bayside pump jobs to 1 in 20. No document in CE_PLAN gives that figure. The book says 1 in 10 in-ground and 1 in 100 basement.
    2. **Job example:** A Bayside basement carpark pump.
    3. **Question:** Does Bayside really ask for 1 in 20, and where is it written?
    4. **Recommended answer:** If nobody can point to the document, use the book's figures and drop the Bayside rule.
15. **Soakage sizing.** DRAFT
    1. **Context:** The book (p26 to 27) sizes soakage by sweeping storms to 1 in 100, with a soil factor (sand 0.5, sandy clay 1, clay 2) and set-backs from structures (sand 1, sandy clay 2, rock 2, medium clay 4, heavy clay 5 m); Kingston, Frankston and Mornington need soil of at least 100 mm/h. The plugin's soakage sizer does none of that.
    2. **Job example:** A Mornington Peninsula site in sandy soil with a geotechnical report.
    3. **Question:** Does the office design every soakage system by that sheet, and which councils want it?
    4. **Recommended answer:** Yes, by the sheet; the plugin warns on set-backs and low soil rates.

## D. The "ready to submit" list

16. **The councils' return-of-information lists.** DRAFT
    1. **Context:** The book lists what councils send drawings back for (p32 to 38): roof hatch and legend, overland arrows, pipes and pits 1 m from the splay, crossover width, spot levels near pits, tank size, sewer-quality pipe, 150 SN8 under garages, inspection openings at every bend, all pits scheduled including plastic ones, pavement section with fall, shared-asset owners' agreement, no groundwater to the kerb.
    2. **Job example:** A Kingston resubmission because the pit schedule left out a plastic pit.
    3. **Question:** Is the list complete? Which five or six items apply to every council, and which belong to one council only?
    4. **Recommended answer:** Treat splay, crossover width, spot levels, tank size, sewer-quality pipe, inspection openings at bends, and "all pits scheduled" as every-council checks; keep the rest per council.

---

## DROPPED, with the reason (do not ask again)

1. **Step iron depth.** Answered: Tim, 25 Sep (CR-A5), "LET'S DO OVER 900 DEEP", one office rule. The only follow-up is a **template fix**: the real drawing's general note says "deeper than 1200" and the junction pit detail says "900 max depth". Raise as a template card, not a question.
2. **0.30 versus 0.35 for soft ground.** Answered: Tim, 25 Sep (CR-A1): 0.35 whole site before development, 0.30 soft ground after. The book's text (0.3) and its own sheet (0.35) disagree; fix the book in stage 4.
3. **Whitehorse "orifice only above 12 L/s".** Gone in v1.3, and five real issued CE sheets drew an orifice at 4 to 12 L/s (INT-070 item 1). Left blank on the council profile.
4. **Wet well minimum 3 m3.** Answered: Tim, R-14: no fixed floor, 3 m3 is a review flag, from 10 real jobs (smallest 0.82 m3).
5. **Orifice rounding and Co.** Answered: CR-A2 (0.6 everywhere) and CR-A3 (round down to the whole mm, not below the council minimum). The book's sheet agrees on the head (to the orifice centre).
6. **What the Banyule 65% symbol means.** Banyule's own 2019 document says "greater than 65%", and Tim ruled how it is handled (UX-CR-13).
7. **Standard edition (AS/NZS 3500.3).** Answered: UX-CR-14, council edition shown quietly, CE works to the copy held.
8. **Lid class from the surface.** Answered: UX-CR-02 and UX-LID-01; only the driveway value is asked (question 5).
9. **Orifice head definition.** Answered: R-18, to the orifice centre; the book's sheet and the company's real sheet both do this.
10. **Council fees, portals and addresses.** Facts to record per council from the book; not an engineering question.

---

## TOP FIVE FOR TIM (the ones that change drawn or sized output most)

1. **Question 1/2 (flattest falls).** Tim's own item 19 asked for the guidebook to decide, but the book gives no size ladder.
2. **Question 8 (rainfall).** Moves every Boyd's storage by 5 to 8 per cent in flow, 2.5 times that in volume; Tim's BUG-866 "leave until you've checked the curve".
3. **Question 3 (cover by surface).** Changes warnings on every job with a driveway or road.
4. **Question 7 (maximum pipe speed).** Unanswered since 8 Oct; the book cannot answer it.
5. **Question 16 (ready-to-submit list).** The highest-value new check, and it needs the engineers to say which items are universal.

---

## TIM'S MARKS, 29 Oct 2026 (after the walk-through)

Tim answered all 16 himself; his exact words and my reading are in `decisions/2026-10-29_TIM_ANSWERS.md` item 24. Summary: 3 to 6 and 8 to 16 take the recommended answer; **1 and 2 are "as the guidebook says"** (1 in 100 for all ordinary pipes; 1 in 200 for detention pipes only in Darebin, Banyule, Manningham, Maroondah); 7 stays open; 14 is conditional. Whether any question still goes to engineers is Tim's call.
