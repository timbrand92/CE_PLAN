# Current rulings: Detention (rainfall, runoff, orifice, head, top water level, storage)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Where it lives and what it does

1. **In the first release:** "Tank and detention sums" (D-097). **Confirmed for the one-job release by D-338 (19 Nov):** first job "A job with detention", so Detention is back in scope; it is in Stage 2 (D-347, see FIRST_RELEASE).
2. **One "Detention" window for the job:** what is fixed, the volume needed, the storage you have (tank share, pipes and pits that hold water) [the tank enters at its whole detention, D-289], the orifice, and it fills the criteria box on the sheet (D-099).
3. **Typed name DETENTION / DET** (D-101).
4. **Two answers side by side, of equal weight:** storage against what is needed, and discharge against what is permitted (D-106).
5. **Methods on day one:** Boyd's method and OSD4W / Swinburne; council-supplied figures typed in and the council's own calculator are not day one (D-098).
6. **The sums live inside the plug-in:** council figures and areas typed once, storage, orifice, depths and checks follow, and the computations sheet prints from the same numbers (D-021).
7. **Taken from the old plug-in,** each re-checked against a real job first: the orifice sums, storage in pipes, pits and tanks, the rainfall data and curve, pipe capacity sums (D-095).
8. **Detention window: "Tick: right track"** (D-114) and on the bench it looks good (D-169). **Approved with the drawing across the top by D-305 (19 Nov):** "detention window appeoved" (item 33).
9. **Reduce what is typed:** use everything the system knows to cut manual calculations and inputs, "SUCH AS HEAD AND ORIFICE AS AN EXAMPLE" (D-169), carried out by D-171 change 3 (head, orifice and pit size worked out).

### Orifice, head and top water level

10. **The top of the orifice pit baffle (plate) is the top water level:** plate height = top water level less the orifice invert; head = that less half the orifice; neither is typed (D-172).
11. **The criteria box keeps printing the baffle height under "HEAD",** as now; the sum uses the head to the orifice centre (D-023).
12. **Orifice size put on the drawing is rounded down to a whole mm,** never over the permitted discharge (D-173).
13. **The top water level and the orifice are normally fixed on a tight site** (D-018).
14. **The tank orifice is 30 mm, office standard** (D-024). **Refined by D-282 DQ-063 (planning chat's call; his to overturn):** 20, 25, 30, 40 and 50 offered, 30 first, any figure typed. This is the tank orifice; D-285 DQ-076's 'no pick list' is the control pit orifice.

### Storage

15. **Tank split worked out from the volume needed;** re-use takes the rest (D-100). (CONFLICT with D-024, see Still open.) **Superseded by D-278 (18 Nov; planning chat's call from the old jobs; his to overturn):** re-use is typed from the report and detention is tank less re-use (item 30).
16. **Pits count as storage only when ticked;** volume = plan size times water depth, the depth worked out from the top water level (D-105).
17. **Twin detention pipes count both pipes** in the storage sum (D-082).
18. **Head, orifice, storage and flows run only on a run that reaches the outlet,** and otherwise say what is missing (D-176).

### Areas, runoff and rainfall

19. **Site areas: picked off the drawing (and then linked to the outline), typed, or given in a council document;** each shows where it came from; the first release marks a council figure "given" (D-107, D-108).
20. **Site and impervious areas are measured by a mix, job by job** (D-020).
21. **No site rainfall entered:** by default no storage figure is shown ("cannot work out yet: site rainfall not entered"), and the drafter may type his own rainfall estimate to get a figure for now (D-218).
22. **Old council figures:** only sourced figures come across, with their source; assumed ones are dropped and filled in from the first real council letter (D-096); a council figure without a document on file stays blank (D-148).
23. **When rules disagree:** council, then AS 3500.3, then the office guidebook (D-022).

### Added 18 Nov 2026, D-230 to D-297

24. **Pervious runoff coefficient (D-283):** the Detention window opens with "0.35 Boyd's, 0.30 OSD4W (Recommended)", shown with its source and typed over per job. **"not sure need more research" (D-315, 19 Nov), then refined by D-331 (19 Nov):** "Council's figure, else 0.35 (Recommended)": where the picked council states a garden figure (mostly 0.30) the tool opens with it and shows where it came from; where the council says nothing, 0.35 for Boyd's as the office sheet has it; always changeable. D-331 does not mention OSD4W (item 35).
25. **Rounding in Boyd's (D-284, not the recommended answer; changes the build):** "Match the office sheet (round first)". The inflow is rounded to two places before the volume is worked, as the office Boyd's sheet does, so the plug-in gives the sheet's figure (1.66 on the measured job, not 1.65).
26. **How a site's rainfall figures arrive (D-249):** "A mix, depends on council". Some councils state the intensities to use, otherwise the Bureau's table. The Job window takes either: figures given by the council (held with the council, source recorded) or the Bureau table pasted or typed for the site; each figure marked with where it came from.
27. **An orifice pit detail per council (D-253, not the recommended answer):** "The pits really differ by council", so Detention fills this job's figures into the orifice pit detail that belongs to the job's council (see PIT item 36).
28. **Pump well sums are on the pump pit, not here (D-247):** "On the pump pit (Recommended)"; they print in the same council computations PDF as the detention sums (FP-013 stands).
29. **The old rainfall, design and calculation commands fold into a window or a tool (D-246, D-245, D-281):** Tim is not using the old plug-in's CDRAINFALL, CDDESIGN, CDCALC "and all that other jazz" and cannot trust even its main tools; the scattered commands built at different times are to be CONSOLIDATED into a window or a tool, scalable and able to be built upon. On the BUG-866 rainfall risk he answered "Seen, I will follow that" (D-245), and it stays on the board until the old plug-in is fixed or replaced. How CDRAINFALL and the others come into the main plan is owed as a published artifact page (D-281).
30. **Tank litres and the one storage total (D-278, D-285 DQ-073, D-289; D-278 is the planning chat's call from the old jobs and the other two the planning chat's call from his rulings; his to overturn):** re-use is typed once from the report and detention is tank less re-use and can be typed lower; every store enters at its full room and the total is compared with the volume needed once, "provided, needed, spare" or "Short" with the amount; the Detention window suggests the next tank size up when short and the engineer decides (TANK items 10 to 12).
31. **Build calls on the sums (D-282; planning chat's call from his rulings; his to overturn):** DQ-067 commas in the windows, none on the sheet; DQ-069 "3.5 per cent"; DQ-072 orifice coefficient 0.6 with gravity 9.81, and the older sheet's "2.6 x area x root head" is the same sum rounded (0.6 x root of 2 x 9.8 = 2.66), so the two do not disagree, the 0.8 on one old copy is not used.
32. **More build calls on the sums (D-285; planning chat's call from his rulings; his to overturn):** DQ-074 a pit's plan size for storage is the size the pit is drawn at, a typed figure stands; DQ-075 garden is what is left of the site after roofs and paving, a typed garden stands with an amber note when the areas do not add to the site; DQ-076 CHANGES the build: no orifice pick list, the orifice is worked out from the permitted discharge and head and rounded down to a whole mm (D-172), and can be typed over; DQ-077 no tolerance on the discharge check **[see the clash list in INDEX: D-318 "Allow a small tolerance" for checks; D-321 sets it for levels and cover]**; DQ-079 no pipe size box in Detention, detention pipes are drawn with the Pipe tool and read off the drawing, each listed with its size and length (one fact in one place, D-171); DQ-080 a rainfall typed as your own estimate is assumed: amber, APPROX., on the Unfinished list, never green (D-218, D-177); DQ-081 all six storm durations before any storage figure; DQ-082 a council with no minimum runoff on file shows one grey line "no council minimum on file", never amber, never silent; DQ-083 when the council minimum governs it shows amber with both figures; DQ-084 the larger of the worked-out C and the council minimum governs.

### Added 20 Nov 2026, D-298 to D-383

33. **The Detention window, drawing across the top (D-298 to D-301, D-305):** "i think the horizontal preview on top of the detention stuff is better"; "Top for Detention only"; "About a third of the window (Recommended)"; "Both: top preview in the window, and the real drawing lights up (Recommended)"; then the mock-up `pictures\detention_top_preview_mockup.html`: "detention window appeoved". Approved: the top band showing the system zoomed in across the full width with the storage parts outlined and their figures on the drawing, a small "Where on the plan" locator, then the status band, step 1 across, steps 2 and 3 side by side; the band at 240 high stands as shown (see SCREENS_AND_STYLE).
34. **One council's detention conditions (D-327):** "Yes, as that council's check (Recommended)". When that council is picked in the Job window, the tool checks at least 60 per cent of storage underground and an orifice no smaller than 65 mm.
35. **Garden runoff (D-315, D-331; evidence `reference\research\R-014`, checked at source):** "Council's figure, else 0.35 (Recommended)". The picked council's stated figure (mostly 0.30) with its source; otherwise 0.35 for Boyd's. Correction recorded: the planning chat's earlier statement that the office sheet needs 0.30 was wrong; the office litres sheet has 0.35 in its formula.
36. **The allowed discharge is worked out (D-332):** "Work it out; typed is a hold (Recommended)". The office Boyd's sheet had 4.70 L/s typed where its own inputs give 5.75; the tool works the allowed discharge out from the inputs and an engineer can type over it to hold a council's figure.
37. **The order of the detention chain (D-343, the design `design\DETENTION_CHAIN.md`: the chain follows the water through the recorded joins, never the position on the plan):** three calls, all "Recommended": a ticked pit no pipe reaches: "Leave it out, say so (Recommended)", reading "Not joined: P3, its 0.04 m3 is left out until it is joined" (this changes a sum); pipes on the main run: "One row per size (Recommended)", each length still listed in the printed working; too many warnings: "Join like warnings (Recommended)", pits with the same fault share one line. The one rebuild may start.
38. **What counts as underground for the 60 per cent check (D-345; the planning chat's DRAFT call, Tim's to confirm or overturn):** below finished ground: detention pipes, pits and a tank marked buried or underground; an above-ground tank and an underdeck tank do not count; the window shows the two totals and the share. To ask him: whether an underdeck tank counts.
39. **Twin barrels of a detention pipe (D-349):** "Keep barrels matched"; a TRIM of one barrel: "Both become 7 m (Recommended)"; the storage follows (see PIPE item 46). This overturns the design note's "count each barrel as drawn and flag it".
40. **A detention pipe into an orifice or pump pit** is smaller downstream on purpose and must not raise the size warning; for later, not Stage 1 (D-379 item 2).

## Changed along the way

1. **OBSTACLE_COURSE OQ-04 recommended option A (amber and APPROX. when no rainfall is entered); Tim chose no figure by default, with his own estimate allowed (D-218, 18 Nov).**
2. **INPUT_AUDIT question 1 (is the baffle top at the top water level) was answered yes by D-172 and question 3 (orifice rounding) by D-173 (18 Nov);** the document still lists them as open.
3. **Tank split worked out from the volume needed (D-100) was replaced by "re-use typed from the report, detention is the rest" (D-278, 18 Nov; planning chat's call from the old jobs; his to overturn).**
4. **The built Boyd's inflow (1.65, unrounded) was replaced by "round first" so it matches the office sheet's 1.66 (D-284, 18 Nov).**
5. **The orifice pick list in the build was replaced by an orifice worked out and rounded down (D-285 DQ-076, 18 Nov; planning chat's call from his rulings; his to overturn).**
6. **"0.35 Boyd's, 0.30 OSD4W" (D-283) was refined by "Council's figure, else 0.35" (D-331, 19 Nov).**
7. **The typed 4.70 L/s allowed discharge on the office sheet gave way to a worked-out figure, typed being a hold (D-332, 19 Nov).**
8. **The design note's twin-barrel count was overturned by D-349 (20 Nov).**

## Still open on this subject

1. **CONFLICT: tank re-use from the STORM or sustainability report (D-024) against worked out from the volume needed (D-100).** Neither marks the other. Waits on: Tim. **Settled by D-278 (18 Nov; planning chat's call from the old jobs; his to overturn):** D-024 stands; D-100 survives only as the next-size-up suggestion.
2. **How the top water level is first chosen** (Q-001; INPUT_AUDIT question 2); the four "work it out from the system" questions were not answered and must not be re-asked in the same form (D-175). Waits on: the planning chat (to find a new way to ask).
3. **Whether the orifice pit is always the last pit before the council connection** (INPUT_AUDIT question 6; item 15 says nothing ties the orifice pit to P1). Waits on: Tim.
4. **A typed rainfall estimate:** the planning chat's reading, not yet put back to Tim, is that it is marked assumed, prints APPROX., stays on the unfinished list until the site's table replaces it, and the plug-in never supplies a curve of its own (D-218). Waits on: Tim. **Taken in part by D-285 DQ-080 (planning chat's call from his rulings; his to overturn):** assumed, amber, APPROX., on the Unfinished list, never green (item 32).
5. **How each site's Bureau rainfall table arrives, and whether one table per job is right** (INPUT_AUDIT question 5, section 1 item 8; FM-050). Waits on: Tim. **Answered in part by D-249:** a mix, depends on council; whether one table per job is right is not said.
6. **OSD4W inputs are not in the reference;** the window shows only two typed results (D-114; THE_PLAN section 7 item 3); where the OSD4W rainfall zone and times come from when the letter is silent (Q-006). Waits on: Tim.
7. **Pervious coefficient 0.30 or 0.35** (Q-004; INPUT_AUDIT section 1 item 9). Waits on: Tim. **Settled by D-283:** 0.35 for Boyd's, 0.30 for OSD4W.
8. **Council minimum C:** which councils and which documents; engineering judgement, needs Tim's word (OBSTACLE_COURSE OQ-05, OC-24). Waits on: Tim.
9. **Council minimum orifice for most councils** (INPUT_AUDIT section 9, L-008). Waits on: Tim.
10. **Orifice invert step of +0.020 is not yet in the brain** (INPUT_AUDIT section 1 item 17, S-025). Waits on: the build chat.
11. **Plate, top water level and orifice invert not yet tied together; two different "top water levels" share a name; council invert held twice** (INPUT_AUDIT section 2 items 3, 6, 16). Waits on: the build chat.
12. **The new plug-in's data would repeat both wrong-figure bugs (rainfall note and council minimum C)** unless designed against them; OC-24 is the test (R-008, D-212). Waits on: the build chat.
13. **Candidate top water levels list** waits on D-175 (FUNCTION_MAP section 4A, FM-023). Waits on: Tim.
14. **Who confirms Boyd's or OSD4W with the council before design starts** (Q-006). Waits on: Tim.
15. **The computations sheet:** D-021 says it prints from the same numbers, but no first-release tool prints it (FM-047, D-220); recommendation in FUNCTION_MAP is to build it straight after release and keep the old CDCALC meanwhile. Waits on: Tim.
16. **Whether site area figures are read out of a council document by the plug-in or typed and marked "given":** first release marks it given; later not said (D-108). Waits on: Tim (later).
17. **Whether a detention pipe must sit fully below the top water level to count full volume** (INPUT_AUDIT section 9). Waits on: Tim.
18. **Selecting several pipes and making them detention** (SITUATIONS E8). Waits on: the build chat.
19. **Full verdict on the Detention window waits on real use** (D-087, D-114). Waits on: Tim.
20. **The plan of how every old calculation command lands in the new plug-in** (D-246, D-281): `design\FUNCTION_PLAN.md` proposes 31 tools and must be re-read against "few tools, each a window, the old scattered commands folded inside" and shown as the drafter's picture, with the artifact page owed. Waits on: the planning chat.
21. **With two or more tanks, how one typed re-use figure is shared:** see TANK Still open item 11. Waits on: Tim.
22. **Whether an underdeck tank counts as underground storage** for the 60 per cent check (D-345 DRAFT). Waits on: Tim.
23. **Whether OSD4W keeps 0.30 for garden** where no council figure is given (D-283 against D-331, which names Boyd's only). Waits on: the planning chat (to confirm with Tim).
24. **Tolerance on the discharge check:** D-285 DQ-077 (none) against D-318 (a check may pass within a small tolerance); see the INDEX clash list. Waits on: Tim.

**Closed (D-298 to D-383):** the pervious coefficient's source (D-331); the allowed discharge on the office sheet (D-332); the chain order and the left-out pit (D-343); the minimum orifice for one council (open item 9 in part, D-327: no smaller than 65 mm for that council).

**Closed (D-230 to D-297):** the pervious coefficient (D-283); where the pump well sums sit (D-247); how a site's rainfall figures arrive, in part (D-249); the conflict on tank re-use (D-278; planning chat's call from the old jobs; his to overturn); Boyd's rounding (D-284); which tank litres are typed (D-278).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-298 to D-301, D-305, D-315, D-327, D-331, D-332, D-338, D-343, D-345, D-347, D-349, D-379; `reference\research\R-014`; `design\DETENTION_CHAIN.md` (in `C:\CE_CIVIL` branch design/detention-chain).

Added 18 Nov 2026: `DECISIONS.md` D-245 to D-247, D-249, D-253, D-278, D-281 to D-285, D-289.

1. `DECISIONS.md` D-018, D-020 to D-024, D-095 to D-100, D-105 to D-108, D-114, D-148, D-169, D-171 to D-173, D-176, D-218.
2. `design\INPUT_AUDIT.md` sections 1, 2, 5, 9; `reference\design\SUMS.md`; `reference\councils\`.
3. `reference\research\R-008_TWO_WRONG_FIGURE_BUGS.md`; `stage6\OBSTACLE_COURSE.md` OC-24.
