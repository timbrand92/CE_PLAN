# Raft slabs and infill slabs at CE — DRAFT for Tim's correction (26 Sep 2026)

Read-only study approved by Tim (26 Sep): 7 recent structural issue PDFs (Jun-Sep 2026), the Standard Details file
names and the plugin registry at 8c077569. Anonymised (DATA-01): no jobs named. **This is a reading of the evidence,
not a Tim ruling.** Tim to correct before any UX questions.

**TIM'S CORRECTIONS, 26 Sep 2026 (these override the text below):** EB/IB confirmed. BB band beams belong to
suspended slabs in basements or concrete subfloor structures, NOT rafts on piers, screw piles or ground. Infill slabs
are thinner AND DO have internal rib beams. Raft notes are in a LEGEND, not inline. A deeper drawing review is running.

## Raft slabs

1. **Where:** the Ground Floor Footing Plan sheet; general and geotechnical notes on the first sheet.
2. **What is drawn:** slab-on-ground with perimeter edge beams and a grid of internal beams, plus rectangular
   thickenings under point loads; slab thickness noted on plan (commonly 100-150 mm).
3. **Tags:** EB1, EB2... edge beams; IB1, IB2... internal beams; thickenings called out near piers/point loads;
   BB / 1BB band beams on pier-supported (suspended) rafts (seen on one job only).
4. **Reinforcement notes:** mesh called up inline (SL62/SL82/SL92/SL102, top or top and bottom), bar chairs, cover and
   concrete grade stated in the slab note rather than a separate legend.
5. **Schedules:** an RC Beam Schedule for band beams; edge/internal beam sizes dimensioned on plan in the sample; a
   separate Footing Schedule for strips and pads.
6. **Set-downs:** wet-area and step set-downs noted on plan, referring to the architectural drawings.
7. **Piers under rafts:** on sloping, reactive or rock sites the raft is "fully suspended over bored piers", with a
   geotechnical note for pier depth and bearing.
8. **Details:** "CE On-Ground Raft Slab Details" and "CE Suspended Raft Slab Details" in the Standard Details library.
9. **Geotechnical note:** a standard block naming the site class to AS 2870 from the geotechnical report, then
   founding depths and bearing for slab beams, footings and piers.

## Infill slabs

1. **Meaning (most jobs):** a thinner, lighter slab-on-ground poured between or beside the main raft/beam elements
   (e.g. garage, ramp, lightweight zones), mesh top only, sometimes with a small edge beam.
2. **One renovation job:** "infill slab" meant an existing slab area retained.
3. **Drawn:** a thickness and mesh note on plan, no dedicated mark; hatched with the infill hatch (11IH, a coarser
   scale of the concrete hatch).
4. No infill-specific standard detail found; appears to reuse the raft slab details (not confirmed).

## What the plugin has today

1. Raft Elements: FTHC (tracked slab thickening), REB (tracked external raft beam), RIB (tracked internal raft beam),
   all needing a selected raft host (ST-06); none write to a schedule yet.
2. Footing Elements (FPFC pad, FSF strip), Piers (BP bored pier block at 300/450/600).
3. Infill: only the 11IH hatch preset; no tracked infill slab element.

## Open for Tim

1. Is EB/IB the standing edge/internal beam convention, and BB only for pier-supported rafts?
2. Should raft beams (EB/IB) go in a schedule, or stay dimensioned on plan?
3. Is "infill slab" as described (lighter slab between/beside the raft) right, and should it be a tracked element
   with its own mark?

## Deeper review after Tim's corrections (26 Sep 2026, ~55 structural issue PDFs 2020-2026, 14 read in full; anonymised)

1. **Infill slabs:** typically 100 mm (sometimes 150), single top mesh (e.g. SL82 top), on membrane and packing sand;
   they DO have rib and edge beams using the same IB / EB tags as the raft; a 200x200 mass-concrete edge beam is
   commonly noted; drawn on the same footing/slab plan; no standalone infill standard detail.
2. **Legend:** a heading "LEGEND", usually bottom-left of the footing plan near the notes: the raft slab note
   (thickness, mesh top and bottom, cover, f'c, membrane, sand) plus symbol keys (saw cuts, steps/set-downs, steel
   columns, stud walls, slab-thickness callouts) and sometimes the infill note; wording is an office template.
   A Footing Schedule (PF / EB / IB / TH / BP: width, depth, reinforcement, comments) sits beside it.
3. **Band beams:** BB1, BB2 in an "RC BEAM SCHEDULE" (type, width, depth, reinforcement), in suspended ground-floor
   slabs over basements/retention structures; notes on continuous top mesh and restricted penetrations; standards in
   the "Retention and Suspended Slab Details" folder, separate from on-ground raft details.
4. **Unverified:** the infill hatch (graphics only); whether infill ribs have their own detail.
