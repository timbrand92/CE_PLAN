# Tim: 15 quick questions, surface levels and long sections (1-8) and checking against the markup (9-15), 9 Oct 2026

Answer by number, e.g. "1 yes, 3 no, 12 b", or "all recommended". Builders are already going on the **Rec** answers (INT-073); your
answer changes the default afterwards. Cards: `BATCH6_SURFACE_LEVELS_AND_LONG_SECTIONS_CARD_2026-10-09.md` ("card 8" = Batch 6) and
`BATCH15_STRUC_MARKUP_QA_ROOF_DOWN_CARD_2026-10-09.md` ("card 9" = Batch 15). Written by design run 9.
**Questions 8 and 13 need YOUR OWN NUMBER: nobody fills those for you.** Question 10 is a privacy one: please answer it first.

**Surface levels and long sections (Civil)**

1. **How far may CE reach for a survey level?** Today, past the edge of the survey, a new pit is offered the nearest survey spot level
   however far away it is (even 40 m), and the window just says "nearest spot (37.2 m)". Rec: use a spot level only up to **3 m** away;
   further than that the level stays blank (Unknown) and CE says "No survey level within 3 m of this point". A different distance is fine:
   give me the metres. Example: a pit in the back yard 15 m past the last survey point gets no level instead of the front kerb's level.
2. **Design levels first.** Rec: where a pit sits in a CE slab or paved area, or near one of your proposed spot levels (CDSL), CE offers
   that design level first, with the existing ground level shown under it; the architect's levels come later. Example: a pit in the
   driveway slab is offered the slab level 12.60, with "existing ground 12.21" underneath.
3. **No survey yet: a note on the drawing?** With no survey you can set assumed levels (pick a point, type 100.00, give a fall); the levels
   are marked "assumed" and the CE panel says the job is on assumed levels. Rec: CE also offers, unticked, the drawing note "LEVELS ARE
   ASSUMED AND SUBJECT TO SURVEY". Example: a concept plan sent before the surveyor has been out.
4. **The survey arrives later.** Rec: CE lists every pit whose level would change; assumed and blank levels are ticked, levels you typed
   are not ticked (CE never overwrites your typed level unless you tick it); Apply is one U; anything that now fails (cover, grade) goes to
   Checks with a fix. Example: day 3 the survey comes in; 9 assumed pits are updated and Checks says "P3-P4 cover now 240 mm".
5. **One bad survey point.** Today one survey spot that disagrees with the survey surface stops the WHOLE survey loading ("Intake
   blocked"). Rec: load the survey, skip just that point, and list it in Checks with Show where / Use it anyway / Keep skipping. Example: a
   level typed 23.45 among neighbours at 22.80 no longer stops the job; only that point is ignored until you say.
6. **How far off is "suspect"?** Rec: more than **100 mm** from what its neighbouring survey points give (100 mm is today's figure). Give a
   different number if you like. Example: a spot 0.62 m above its neighbours is flagged; one 40 mm off is used.
7. **Long section rows.** Today the section has PIPE SIZE, PIPE GRADE, pipe speed full, pipe flow full, INVERT LEVEL, SURFACE LEVEL,
   CHAINAGE. Your outfall layout has DATUM LEVEL R.L., PIPE SIZE, PIPE GRADE, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE. Rec: use
   your office rows (with INVERT DEPTH); the two speed rows stay available but off. Example: P1 to the outfall shows invert depths 0.62 /
   0.85 / 1.10 and no speed rows.
8. **YOUR NUMBER: minimum clearance to a crossing service (mm).** On the long section CE will mark each surveyed service crossing the run
   (sewer, water, gas, power, telecoms) with its clearance, red if too close. I will not guess the minimum. Until you type it, every mark
   says "clearance not set, not checked". Is it one number for all services, or different for sewer / water / gas? (This is not the same as
   the two detention clearances still waiting from 8 Oct, unless you say it is.) Example: a sewer crossing P2-P3 with 120 mm clearance turns
   red if your minimum is 150.

**Checking against the engineer's markup (Structural; roof first, footings last)**

9. **Order of the list.** Rec: the markup list is grouped by round (newest first), then by sheet in drafting order: roof, upper floors,
   ground floor, footings last. Example: in round P2 the roof sheet's "R1 to 240x45" is at the top and the footing comments at the bottom.
10. **PRIVACY (please answer first).** I found that today's "Read Markup PDF", in its default Hybrid mode, sends the WHOLE markup PDF,
    title block and all, to OpenAI (not Claude) whenever an OpenAI key is set on that PC. Your 25 Sep rule was Claude only, one page at a
    time, title block blanked, or not sent. Rec: switch that OpenAI reading off now (a small fix ahead of everything else); until the proper
    Claude sender is built, CE reads only the typed Bluebeam comments and says "Handwriting was not read". Example: a colleague with an
    OpenAI key reads a markup: nothing leaves the PC.
11. **Lining up the faded markup.** Rec: when the markup is a print of the same sheet, CE lines it up by the sheet border (your A1 and A3
    title blocks); when it cannot, it asks you to click two matching points on the markup and on the drawing. Example: a scanned markup
    that is slightly rotated gets two clicks each side and sits on top of the plan.
12. **Where the faded markup lives.** Rec: CE puts the markup page under your plan as a faded PDF on a CE layer that never plots, and
    takes it out when you close the markup list and before any plot. Example: you plot while reviewing; the PDF shows no markup and no
    highlight.
13. **YOUR NUMBER: how close is "the same place" between rounds?** You chose "place and meaning" on 5 Oct: a P2 comment replaces a P1
    comment when it is in the same place, about the same member, saying the same kind of thing. CE needs the distance on the printed sheet
    (mm). Suggestion to start from: 15 mm. Until you type it, every P2 comment is listed as a new item (nothing is replaced wrongly).
    Example: P1 "B1 250PFC" and P2 "B1 to 300PFC" 8 mm apart: with 15 mm, P1's item shows "superseded by P2".
14. **Clarification list.** Rec: the "Needs clarification" items become a PDF (markup snippet and plan snippet side by side, your question
    under each) saved in the job's `Markups` folder and opened for you; CE never emails or uploads it. Example: three unclear comments on
    P2 become "Clarifications P2 2026-10-09.pdf" ready to attach to your email.
15. **The engineer drafted changes himself.** Rec: CE compares CE objects (marks, sizes, posts, footings) with the latest saved copy, not
    a picture; it lists added, removed, size changed, and moved more than **100 mm**; if there is no saved copy it uses the last issue and
    says so. Example: the engineer changed B1 to 300PFC and deleted a post: two items appear in round "ENG 9 Oct".
