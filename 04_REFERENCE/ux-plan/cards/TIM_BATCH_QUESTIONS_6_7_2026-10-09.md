# Tim: 15 quick questions, layers and right-click (1-8) and the Structural schedules (9-15), 9 Oct 2026

Answer by number, e.g. "1 yes, 3 no, 12 b", or "all recommended". Builders are already going on the **Rec** answers (INT-073); your
answer changes the default afterwards. Cards: `BATCH5_LAYERS_AND_AROUND_THE_OBJECT_CARD_2026-10-09.md` ("card 6" = Batch 5) and
`BATCH14_STRUC_SCHEDULES_ROOF_DOWN_CARD_2026-10-09.md` ("card 7" = Batch 14). Written by design run 8. Questions 8, 10 and 14 need your own
numbers or files: nobody fills those for you.

**Layers, right-click, Ctrl+1, the other discipline**

1. **CE recolours your layers.** Today if you change STORMWATER PIPE to colour 5, the next CD turns it back to 150 by itself. Rec: CE
   never changes a layer that already exists; Checks lists "STORMWATER PIPE is colour 5, office 150" (not ticked) and you fix it or leave
   it. Example: a job where the client wants pipes in red keeps them red.
2. **A CE label moved to the wrong layer.** Today Edit Pipe just refuses ("put the label back on the pipe-text layer"). Rec: Checks lists
   it, ticked: "P3-P4 label is on layer 0. Fix: move it back"; one U undoes the fix. Example: a colleague drags a label onto layer 0; you
   press Fix once.
3. **Existing and to-be-removed pits and pipes: layer names.** Rec: existing pipes keep EX DRAIN HATCH / EX STORMWATER; existing pits on
   "EX STORMWATER PIT" (grey); removed items on "STORMWATER DEMOLISH" (grey, dashed) with "TO BE REMOVED" beside them, like your
   "WALLS DEMOLISH" in the typical file. If the office already uses other names, tell me them. Example: Edit Pit > Status Existing turns
   the old pit grey.
4. **Existing and removed pits in the Pit Schedule?** Rec: no, the schedule is new work only; existing pits still count in the network
   checks; removed ones do not. Example: an existing council pit you connect to shows on plan with its number but not as a schedule row.
5. **Right-click on a pit.** Rec: Edit pit · Show in Pit Schedule · Tidy labels · Select this run · Select whole network; on a pipe the same
   without "Show in Pit Schedule"; command names in brackets during the transition. Example: right-click P4 > Show in Pit Schedule opens
   the schedule on P4's row.
6. **Ctrl+1 (Properties).** AutoCAD's own Properties can only show CE values after extra work in the AutoCAD 2027 module. Rec: first make
   CE's Civil Properties palette editable (all versions), then add a CE section to Ctrl+1 on 2027. Example: select a pipe, type 300 in the
   Civil Properties palette, Enter: pipe and label go to 300, U takes it back.
7. **Pipe near a footing: where are the footings on your Civil drawing?** Rec: CE reads them from the Structural footing plan Xref'd into
   the Civil drawing (read only), and from the job folder later. Do your Civil drawings usually Xref the footing plan? Example: C01 with
   the S03 footing plan attached; CE flags P4-P5 near PF2.
8. **Zone of influence angle (your engineering number).** Rec: you type it once in Settings, and say whether it is measured from the
   horizontal; until then CE says "angle not set, pipes near footings were not checked". I will not guess it. Example: once your angle is set,
   a deep pipe 1 m from a footing edge that falls inside the zone shows "deepen PF2 or move the pipe".

**Structural schedules (roof first, footings last)**

9. **"Beam schedule table":** on the office framing sheets the beam sizes are in the MEMBER SCHEDULE, and I found no separate beam table on
   six jobs. Rec: no separate beam table; the member schedule carries the beams. Example: the roof sheet's "ROOF MEMBER SCHEDULE" lists RB1
   to RB3.
10. **Where does the office masonry lintel table live?** It is on all six jobs I read, but no block in the typical file has that name. Rec:
    you tell me the block or drawing once; CE copies it exactly and never types spans or specifications itself. Example: "it is in the
    typical file as the NOTES block" or "copy it from job 24-0xx S05".
11. **Wall schedule: which walls?** Rec: block and concrete walls with a W / BW mark, not timber stud walls; CE fills mark, type and
    thickness, you type reinforcement, starter bars and fire rating once and CE keeps them. Example: W1 190 block, W2 150 block, the rest
    of the row typed by you.
12. **Bored piers: their own schedule?** Today they are columns inside the footing schedule. Rec: their own sideways "BORED PIER SCHEDULE
    (F'c = 40MPa)" with the capping beam, like your office drawings (switch, off until you say). Example: S03 shows the footing schedule
    and, beside it, BP1, BP2, CB1.
13. **The old STRSCHEDCREATE pier table** prints LAYER and HANDLE columns, and a second run makes three more tables. Rec: keep the command,
    print the office pier schedule instead, update instead of copying, one U. Example: type STRSCHEDCREATE twice and you still have one
    set.
14. **Concrete strength band.** Rec: a footing can carry its own strength (blank = the title's); columns that differ sit under a band like
    "40 MPa CONCRETE"; CE never invents a strength. Example: PF2 at 40 under a band, title still "(F'c = 25MPa) U.N.O.".
15. **Footing mark prefixes.** Rec: one Settings list: today's PF, SF, EB, IB, TH, BP, SP, ST plus CF, PC, CB, W, BW, RC. Your office
    drawing also shows GEB, GIB and GPF: what does the G stand for, and should CE offer them? Example: FSF offers CF1 for a continuous
    footing.
