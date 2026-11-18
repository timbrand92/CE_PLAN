# Current rulings: Labels and text (labels, tags, cover text, what prints, APPROX., TBC)

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Where labels sit and how they move

1. **Text and parts sit at a set distance from the object,** a setting that is normally always the same, moved only to clear a clash (D-012).
2. **Each part sits in one standard spot on every pipe kind;** the invert level slides up and down the pipe only to clear a clash (D-041).
3. **Grips let the text, invert text and arrow move perpendicular or parallel to the line; cover level text and the pit label can be moved and flipped;** all scenarios covered (D-037).
4. **A label moved by hand stays where it was put when the pipe changes;** the wording updates (D-014).
5. **When a pit is moved, its tag and cover level text go with it and a hand-moved label keeps its offset in both directions** (D-181).
6. **A flip must be discoverable,** never only on a right-click (D-049 item 5).
7. **The tank note has a leader arrow back to the tank** (D-039).

### What prints

8. **The pipe label prints the design grade as typed, for example "1 IN 75";** inverts are rounded to two decimals (D-154, replacing D-123 for the label). **Extended by D-238 (18 Nov):** the label ends "MIN." when both inverts are not given (item 17).
9. **A typed-over label keeps the wording, is flagged as no longer matching, and one click lets it follow again** (D-182).
10. **Retyping a pit tag renames the pit;** levels and grades are never changed by editing their text (D-185).
11. **An assumed figure prints "APPROX." in front,** for example "APPROX. IL 4.95", with one standing note on the sheet; APPROX. goes when confirmed (D-177).
12. **A figure not known yet prints "TBC"** (D-178).
13. **Twin detention pipes have one label** saying "2 x 225" (D-082).
14. **The criteria box prints the baffle height under "HEAD"** (D-023).
15. **Text sizes are standardised in one place** (D-013), and model text and label sizes suit a 1:100 viewport (D-194).
16. **Previews show the arrow and text as they will look on screen** (D-162).

### Added 18 Nov 2026, D-230 to D-297

17. **"MIN." on a pipe label (D-236, D-238):** "MIN. whenever both inverts are NOT given". With one invert or none the label ends "AT 1 IN 100 MIN." and the grade is a minimum; with both inverts given the grade is exact and no MIN. is printed. Automatic; it can still be ticked on or off on any pipe. (His own words on the practice: "MIN WAS SHOWN AT TIMES BECAUSE WE DESIGNED PIPES WITH INVERT LEVEL ON ONE END ONLY".)
18. **Invert level text (D-265):** "20TEXT, colour ByLayer (Recommended)".
19. **Label words by pipe kind (D-268):** three office wordings, charged, suspended and detention, each a line in the office list (full text on PIPE item 35); a better form for tight spaces is owed as a picture.
20. **The APPROX. standing note (D-248):** "Yes, that wording (Recommended)". The note reads: "LEVELS MARKED APPROX. ARE ASSUMED AND ARE TO BE CONFIRMED ON SITE BY THE BUILDER PRIOR TO THE COMMENCEMENT OF WORK. NOTIFY THE ENGINEER OF ANY DIFFERENCE." It is a notes block on the Blocks palette, and the Unfinished list reminds the drafter to place it when anything prints APPROX.
21. **When a pit is turned its text does not (D-267):** "Text stays put and upright (Recommended)": only the pit box turns; the tag and cover level stay level with the sheet at the same offset from the pit centre.
22. **The end of a system has no tag of its own (D-275):** it reads by kind in windows and lists, and is shown by a small marker on a CE no-plot layer (see OUTLET_AND_LPD item 12).
23. **The pipe label is text the Pipe tool writes, not an office label block (D-290; planning chat's call from his rulings; his to overturn):** see PIPE item 39. A typed-over wording is that text's own words, kept and flagged (D-182).
24. **Build calls on the pit's text (D-260; planning chat's call from his rulings; his to overturn):** DQ-004 plain text for numbers, levels and labels is allowed in tests only; before Tim drafts with a tool the pit number is the office's circled tag and the levels and labels are masked as the office draws them (D-039); DQ-008 plastic pit cover text as the office draws it, PP over CL on two lines, before first real use (D-039).
25. **Build calls on pipe and tank text (D-271, D-277, D-282; planning chat's call from his rulings; his to overturn):** DQ-027 a pipe's label moves with the pipe on a plain MOVE, keeping its offset, and a hand-moved label keeps its own (D-014, D-181); DQ-050 OVERTURNS the built answer: while a pipe's grade is not known the label prints TBC in its place (D-178), and while it is Wrong the label keeps the typed grade; DQ-066 the tank note is worded as the office writes it, no comma; DQ-067 commas in the windows, none on the sheet.

## Changed along the way

1. **Label grade = true grade between printed inverts (D-123, 16 Nov) was replaced by "Print what I typed: 1 IN 75" (D-154, 17 Nov).**
2. **The pipe label as the office's own label block (the planning chat's D-261 call on DQ-022, planning chat's call from his rulings; his to overturn) was corrected the same day by D-290:** it is text the Pipe tool writes.
3. **"A figure not known yet prints TBC" and the pipe label's grade (D-178) were made specific by D-277 DQ-050 (18 Nov; planning chat's call from his rulings; his to overturn):** TBC takes the place of an unknown grade.

## Still open on this subject

1. **The standing note wording for APPROX.** (D-177). Waits on: Tim. **Closed by D-248 (18 Nov):** "Yes, that wording (Recommended)" (item 20).
2. **The legend line and label wording for detention pipes** (D-153, D-156). Waits on: Tim. **Label wording answered by D-268 (18 Nov);** the legend line wording is still open.
3. **Label wording for each pipe kind** (SITUATIONS, DRAFTS_pipe 8). Waits on: Tim. **Answered by D-268 (18 Nov),** with a tight-space form owed.
4. **A checker working from the printed inverts may get a slightly different grade from the printed label** (consequence stated in D-154); no note or check for it is decided. Waits on: Tim.
5. **MIRROR and ROTATE: label side, turned text and readability** (SITUATIONS C4, C5). Waits on: a test. **Answered for a turned pit by D-267 (18 Nov):** text stays put and upright; MIRROR and pipe labels are not covered.
6. **Warn about hand notes that name old pit numbers after a renumber** (SITUATIONS D3). Waits on: the build chat.
7. **Labels clear of pits, pipes and each other at every angle** (R-007 lesson 5, about 28 old bugs; OBSTACLE_COURSE OC-10). Waits on: a test.
8. **Text heights: SITUATIONS H1 and H2 assume heights fixed for 1:100 ("250 at 1:100");** to be re-checked against D-194 and D-217 (metre drawings) (SITUATIONS document conflicts; `text_heights.csv` gaps DRAFT). Waits on: the build chat.
9. **The joint label "learning" for CJ and SSC** (TQ-09). Waits on: Tim.
10. **A short form and a two-line stack for each pipe label,** for small tight spaces on plan and in CAD, owed as a picture (D-268). Waits on: the planning chat.

**Closed (D-230 to D-297):** the APPROX. standing note wording (D-248); label wording by pipe kind, in part (D-268); how text behaves when a pit is turned (D-267); whether the pipe label is a block or text (D-290).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-236, D-238, D-248, D-260, D-265, D-267, D-268, D-271, D-275, D-277, D-282, D-290.

1. `DECISIONS.md` D-012 to D-014, D-023, D-037, D-039, D-041, D-049, D-082, D-123, D-154, D-162, D-177, D-178, D-181, D-182, D-185, D-194.
2. `reference\drafting\ELEMENTS.md`; `reference\drafting\TABLES_AND_BOXES.md`.
3. `stage6\OBSTACLE_COURSE.md` OC-10; `design\SITUATIONS.md` sections C and F.
