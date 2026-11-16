# Stage 1 notes: how the stormwater engineering is worked out

**Made:** Mon 16 Nov 2026. **Status:** my reading of the office workbook, checked against the numbers on three issued sheets. Not yet confirmed by Tim. Values quoted are the workbook's or the sheets' own; none is proposed as a rule.

**What was read:** the main office civil workbook (tabs: rational method pipe table, Boyd's detention, Kingston Boyd's, detention storage, orifice, pipe flow, plus a trench / open channel tab), from the converted copy kept by the August 2026 study, and the Boyd's "in litres" master. **Not read yet:** the originals in the office Engineering folder (they are online-only in OneDrive), the pump, soakage, charged system, tank sizing, pipe cover, driveway slope and long section workbooks, OSD4W itself, and STORM.

## The chain of sums (in drafting words)

1. **Areas.** Site area; impervious area made up of roofs and paving, listed part by part; pervious = site less impervious.
2. **Runoff coefficient.** (impervious x 0.9 + pervious x 0.35) / site area in the workbook. The guidebook says 0.3 for pervious and that many councils fix the figure instead (0.35, 0.4 or 0.8). So the coefficient is a council input first, a sum second.
3. **Permitted site discharge.** Either given by the council, or coefficient x 5-minute 1-in-5 rainfall x site area / 3600. Rainfall comes from the Bureau of Meteorology for the site's own location.
4. **Detention volume (Boyd's).** For each storm length (5, 10, 15 ... minutes): inflow = 1-in-10 rainfall x effective area / 3600; volume in = inflow x time; storage = volume in x (1 less permitted discharge / inflow). The largest of the column is the volume required. Or: OSD4W does this step with the council's settings.
5. **Storage provided.** Each detention pipe: cross-section area x length. Each pit: plan size x (top water level less the pit's invert). Each tank: its detention litres. Add them; the total must be at least the volume required.
6. **Orifice.** Flow = 2.6 x orifice area x square root of head. Head = top water level less the centre of the orifice. Try a diameter until the flow is just under the permitted discharge.
7. **Each pipe run.** Area draining to it (running total down the line) x coefficient x rainfall / 3600 = design flow. Grade = length / (upstream invert less downstream invert). Capacity from Manning's formula for a full pipe of that size and grade (roughness 0.010 plastic, 0.013 concrete). Capacity must be at least the flow: the workbook prints OKAY or FAIL. Cover at each end = cover level less invert less pipe diameter.
8. **Pit schedule figures.** Depth to outlet = cover level less outlet invert. Pit size then follows from depth (guidebook table).

## Checked against the issued sheets (the sums really are what is on the drawings)

1. **JOB_C orifice.** Top water level 5.20, orifice centre shown at 4.82, so head 0.38: the criteria box says 380 mm. A 69 mm orifice at 0.38 head gives 5.99 l/s by the workbook's sum: the box says permitted discharge 6.00 l/s.
2. **JOB_C schedule.** P1 cover 5.35 less outlet 4.80 = 0.55; P2 5.78 less 5.25 = 0.53. Both match the schedule.
3. **JOB_B storage list.** 225 pipe, 29.5 m: 1.17 cubic metres by the sum, 1.17 in the box. 300 pipe, 3 m: 0.21 and 0.21. Pit P1, 600 x 900, water depth 0.41: 0.22 and 0.22.

## Where every number comes from

1. **From the council or permit:** method (given figures, Boyd's or OSD4W), storm events, coefficients, permitted discharge where given, minimum orifice, share of detention that must be underground, minimum grades, which tanks count.
2. **From outside sources:** rainfall for the site (Bureau), tank reuse litres and connected roof areas (STORM or sustainability report), survey levels, the discharge point and its invert (council, often assumed first).
3. **Measured off the drawing:** site area, roof and paving areas, pipe lengths, which pipe joins which pit.
4. **Chosen by the engineer:** pit positions, pipe sizes, inverts and grades, top water level, orifice size, which pipes and pits are detention.
5. **Worked out from the above:** flows, capacities, cover, depth to outlet, pit size, storage of each part, totals, pass or fail.

Groups 3, 4 and 5 are all things the drawing already holds or could hold. Group 5 is typed onto the sheet by hand today.

## Weak points seen in the workbook copy (observed, to raise with Tim)

1. **Everything on the drawing is retyped into the workbook and back.** The pipe table asks for each run's inverts, cover levels, length and size: the same figures as the plan and schedule.
2. **A slipped cell gives a false pass.** In the filled example of the second rational-method tab, one row's flow sum points at an empty rainfall cell, so that run shows 0 l/s and still prints OKAY. Later blank rows point at other wrong cells. A copied sum can go wrong without anyone seeing it.
3. **Pit water depths are typed as "top water level less a typed number"** inside the sum, so a changed invert has to be found inside the formula.
4. **Old job details sit inside the workbook tabs** (the copy carries earlier jobs' addresses and job numbers in its cells). This also means the August study's "anonymised" folder is not fully clean. It is local only; nothing from it has gone into the repository.
5. **The Kingston tab in this copy is headings only** (no sums). The original may differ; not checked.

## What this means for planning (mine, to be tested with Tim)

1. The engineering for a house or units job is **about eight short sums**. Tim's view that it is not that complex holds for this job kind.
2. The sums need only: the network as drawn (pits, pipes, tanks, levels, lengths), a few areas, and a small set of council and site inputs.
3. So "type once" has a clear shape: the council and site inputs are entered once per job; pits, pipes and tanks are placed once; flows, capacity checks, storage list, orifice, schedule and criteria box follow from them.
4. Unknown for other job kinds until read: pumps, soakage, charged lines, tank sizing, industrial runoff reduction, outfall long sections.
