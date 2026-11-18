# Current rulings: Pipe

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### What a pipe is

1. **Its own element:** a pipe and its pits work together but are not one element (D-031, replacing the reading of D-011).
2. **Kinds in the first release:** new stormwater, charged, suspended and detention, with twin pipes as one pipe (THE_PLAN section 3, built on D-082 and D-083); trench grate, AG and perimeter drains are also in (D-223; see OTHER_DRAINS).
3. **All pipes behave alike:** each part (invert level text and the rest) sits in one standard spot on every pipe kind, and slides along the pipe only to clear a clash (D-041).
4. **Bends on every kind of pipe,** gravity included (D-189).
5. **Typed name:** PIPE / CD, keeping today's CD as the one exception to "old names are gone" (D-057, D-101).

### Where it starts and stops

6. **Drawn from exactly where you click on the pit wall,** in line with the click (D-034).
7. **Stops at the inner wall line:** the pipe passes the dashed outer line and stops at the solid inner wall, which differs from old sheets at pit edges (D-102).
8. **A branch joining a pipe with no pit is always allowed;** an inspection opening is offered, never forced, when the join is at a bend in the main pipe, the main line has no inspection opening and the run is long (D-081); the offer at a bend stands now that every pipe can bend (D-189).
9. **Loose pipes are allowed and are not an error:** what it cannot know reads "not known yet"; it shows quietly as "not joined yet" in grey; when its end is brought to a pit or pipe it joins and what can be worked out fills in (D-176, D-175).

### Its figures

10. **Material is pick-or-type,** and so is grade (D-079); pipe size is pick-or-type (D-080).
11. **Both invert levels can be typed over** (D-080), and under the foundation any held pair works out the third: hold upstream invert and grade, or downstream invert and grade, or both inverts (D-086).
12. **A new gravity pipe starts at 1 in 100,** which can be typed over (D-143). **Settled by D-263 (18 Nov):** a pipe starting from nothing opens at the office default (100 dia at 1 in 100); a pipe drawn off another opens with the size it continues (item 32).
13. **A new pipe opens at 100 mm everywhere;** it can always be changed and a council figure would raise it (D-174). **Refined by D-263 (18 Nov):** a pipe drawn off an existing pipe or pit opens with the size it continues, never smaller downstream (item 32).
14. **Flatter than 1 in 200 on an ordinary gravity pipe is flagged amber** (D-142).
15. **Cover less than the minimum shows red "Wrong" in every window and never blocks** (D-140); the minimum cover follows a "what is over it" choice on each pipe (D-133; see LEVELS_AND_STANDARDS). **Carried into D-287 (18 Nov):** the choice is now one list of ten presets, a guide only that the engineer can change on any pipe.

### Detention pipe

16. **Detention is its own kind of pipe,** on its own layer, in a slightly different blue, with a line in the legend (D-083).
17. **Colour 160, deeper blue** (option A) (D-156, which replaced colour 152 of D-153).
18. **Layer STORMWATER DETENTION PIPE, linetype DASHED** like the ordinary pipe: shown to Tim with the colour pick and not objected to, but not separately ruled (D-153, D-156).
19. **Twin detention pipes:** one pipe that says "2 x 225", with a number-of-pipes box, two bands drawn, one label, and the storage sum counting both (D-082).
20. **Minimum grade for detention pipes:** 225 at 1 in 200, 300 at 1 in 250, larger at 1 in 300; a council figure overrides (D-134); a detention pipe smaller than 225 gets 1 in 200 flagged amber (D-147).
21. **Detention pipe cover:** keeps 300 (D-133), and under a driveway the larger figure, 0.45, governs (D-145). **POSSIBLE CONFLICT: detention pipe under a driveway.** D-145 says the larger, 0.45; D-287's presets say detention keeps 300 everywhere (driveway lines 100). Neither marks the other. Waits on: Tim.

### Label and editing

22. **The label prints the design grade as typed** ("1 IN 75"); inverts are still rounded to two decimals (D-154, which replaced D-123 for the label).
23. **A label moved by hand stays where it was put** when the pipe changes; the wording updates (D-014).
24. **The Pipe tool writes its own label;** the office's pipe description label blocks are dropped (D-229, "Drop them"). Confirmed by D-290: the label is text, not a block (item 39).
25. **A pipe label typed over by hand keeps the wording,** goes on the unfinished list as no longer matching, and one click lets it follow the pipe again (D-182).
26. **Placing:** type CD, the window opens every time already filled in, then draw (D-060, D-058); editing through Properties or double-click (D-061). **Refined by D-234 and D-263 (18 Nov):** the window opens when the name is typed, filled in as in item 32, one window per run, then pick after pick.

### The Pipe window

27. **Approved structure and look,** wide (horizontal) preview style (D-067, D-068, D-070) **[superseded by D-296 (18 Nov): the preview sits at the left in every window, Pipe included; its size and form are OPEN under D-297; the look is the approved style of D-295]**; hands-on test: closing the padlock on the downstream invert, typing 5.14 and "Work uphill" all worked, and "padlock = held, open = worked out" reads clearly (D-128); on the bench "PIPE LOOKS GOOD" (D-162).

### Added 18 Nov 2026, D-230 to D-297

28. **Drawing a run of pipes (D-237):** "Like PLINE and LINE: it carries on". Click to click; a click between ends is a bend; reaching a pit ends that pipe and starts the next from it; clicking on an existing pipe makes a junction; Enter finishes; one undo steps back one pipe.
29. **A pipe may have an invert level at both ends, at one end only, or at neither (D-236):** "MIN WAS SHOWN AT TIMES BECAUSE WE DESIGNED PIPES WITH INVERT LEVEL ON ONE END ONLY SHOW WE SHOW THE GRADE LIKE THIS. WE NEED THE ABILITY TO ONLY INSERT ONE INVERT LEVEL OR NONE AS WELL, YOU KNOW THIS RIGHT?"
30. **When "MIN." prints (D-238):** "MIN. whenever both inverts are NOT given". One invert or none: the label ends "AT 1 IN 100 MIN." and the grade is a minimum; both inverts given: the grade is exact and no MIN. is printed. Automatic; it can still be ticked on or off on any pipe.
31. **Material follows the size (D-239):** "Follow the size: 150 becomes UPVC SN8". The material follows the size by an office list, shown as "standard", and can be typed over.
32. **What the window opens with (D-234, refined and settled by D-263):** the window opens when the short name is typed, filled in, then each click places and numbers one and Enter finishes, one window per run, not per object (D-234: "When I type the name; then pick after pick"). Tim on pipes (D-263): "IF I DRAW ONE SINGULAR 375 DIA. AND THE REST IS STILL 100 DIA. THEN I THINK IT WOULD BE EASIER TO START FROM THE DEFAUL EACH TIME OR YOU DONT THINK SO?" and then, on the proposal, "Smart: pipe follows what it joins (Recommended)". A pipe drawn off an existing pipe or pit opens with the size of the pipe it continues (never smaller downstream); a pipe starting from nothing opens on the office default (100 dia at 1 in 100); a setting lets anyone switch any tool to "always office default" or "always last used". This settles D-060 against D-143 and D-174.
33. **How a pipe is drawn (D-264):** "Band plus edge lines, as now drawn": the wide dashed band with the two thin edge lines, matching the office look; the edge lines move with the pipe as one thing (how that is done with ordinary objects is the build's to prove).
34. **Invert level text (D-265):** "20TEXT, colour ByLayer (Recommended)".
35. **Label words by pipe kind (D-268):** Tim: "THOSE THREE OFFICE WORDINGS UNLESS YOU HAVE BETTER SUGGESTIONS FOR READIBILITY ON PLAN AND USABILITY IN SMALL TIGHT SPACES AND ON CAD". Charged: "100 DIA. UPVC PIPE CHARGED TO WATER TANK" (no grade); suspended: "150 DIA. UPVC SUSPENDED PIPE AT 1 IN 100 MIN."; detention: size, material and grade, then length and DETENTION on a second line ("2 x 225 DIA. STORMPRO PIPES AT 1 IN 200 / 9m DETENTION"). Each is a line in the office list. A better form for tight spaces is owed as a picture (a short form and a two-line stack per label), not decided.
36. **Cover check by kind (D-269):** "Charged as buried; suspended no check (Recommended)": a charged line gets the ordinary cover check by what is over it; a suspended pipe shows "no cover check: suspended" in grey.
37. **A resized pit and a dragged pipe end (D-256, D-270):** pipe ends follow a resized pit's wall (PIT item 33); an end let go on or inside a pit's outer wall line joins and is trimmed to the wall (PIT item 39).
38. **Tim wants the same on-cursor live preview for the Pipe tool as for turning a pit (D-266):** the Pipe tool gets a preview at real width with label and grade, starting on the pit wall; designed, not built (D-267).
39. **The pipe label is text the Pipe tool writes, not a block (D-290; planning chat's call from his rulings; his to overturn):** the office's PT250 to PT600 LABEL blocks have a fixed tag inside ("PT300"), one block per size, no attribute, so they are not the pipe description; the label is masked text as the office draws it, a typed-over wording is that text's own words kept and flagged (D-182), and its flip and slide grips are our own drawn grips, proven to paint on text and click safely (R-011). What the PT labels are for is not known and is not guessed.
40. **Build calls on the pipe (D-260; planning chat's call from his rulings; his to overturn):** DQ-010 a resized pit moves the pipe end and the end keeps its angle from the pit centre; an end placed by hand or not on the old wall is left and said.
41. **More build calls on the pipe (D-261; planning chat's call from his rulings; his to overturn):** DQ-022 a test-only label position of 0.3 along and 75 clear stands, but the part of the call that said the final label is the office's own label block is superseded by D-290 (item 39); DQ-024 pipes are named by their two pits, "free end" for a loose end.
42. **And on batch 3 and 5 (D-271, D-277; planning chat's call from his rulings; his to overturn):** DQ-027 a pipe's label moves with the pipe on a plain MOVE, keeping its offset, as pit labels do (D-181), and a hand-moved label keeps its own offset (D-014); DQ-028 direction is "as drawn, not settled" until the run reaches an outlet, then it follows the outlet, with a quiet "Turn round" offer where levels disagree (FP-018, D-176); DQ-049 a pipe's length is never typed, it is measured from the pipe as drawn; DQ-050 OVERTURNS the built answer: while a pipe's grade is not known the label prints TBC in its place (D-178), and while it is Wrong the label keeps the typed grade and the window shows Wrong.

## Changed along the way

1. **Label grade = the true grade between the printed inverts (D-123, 16 Nov) was replaced for the label by D-154 (17 Nov):** print what was typed.
2. **Detention layer and blue "not said" (D-083) became "You propose, I approve on a sheet" (D-118, 16 Nov), then colour 152, dark steel blue (D-153, 17 Nov morning), then colour 160, deeper blue (D-156, 17 Nov evening).**
3. **The planning chat's rule for a typed-over downstream invert, with "Put back" (D-080, 16 Nov) was replaced by the foundation (D-086, 16 Nov):** every number has a value, a source and a hold.
4. **Ordinary gravity pipes kept to two points with an IO offer at a bend (SITUATIONS Q13 recommendation) was replaced by D-189 (18 Nov):** bends on every kind.
5. **NAMING_DRAFT's PIPE / PI was replaced by PIPE / CD (D-057, D-101, 16 Nov).**
6. **"The window opens every time already filled in" (D-060, 16 Nov) became "when I type the name, then pick after pick" (D-234) and then "smart: pipe follows what it joins" (D-263, 18 Nov).**
7. **The pipe label as the office's label block (the planning chat's D-261 call on DQ-022, planning chat's call from his rulings; his to overturn) was corrected the same day by D-290:** it is text the Pipe tool writes.
8. **The wide preview style for a thing along a line (D-067) was replaced for where the preview sits by D-296 (18 Nov);** size and form are open (D-297).
9. **"Label wording for each pipe kind" (open since SITUATIONS) was answered by D-268,** three office wordings, with a better tight-space form owed.

## Still open on this subject

1. **How long a run is before an inspection opening is offered:** not said; to come from the office list or AS 3500.3, and the figure was not found online (D-081, THE_PLAN section 7 item 1). Waits on: Tim.
2. **D-189 points to "the D-079 area" for the inspection opening offer;** the offer is D-081. Waits on: the planning chat (wording fix only).
3. **CONFLICT: the figures a new pipe opens with.** D-060 says the window opens filled in with what was used last; D-143 says a new gravity pipe starts at 1 in 100 and D-174 says a new pipe opens at 100 everywhere. Neither marks the other. Waits on: Tim. **Settled by D-263 (18 Nov):** a pipe from nothing opens at the office default; a pipe drawn off another follows what it joins.
4. **Whether kind and other lists are also pick-or-type:** kind was not ruled (D-079 asked, D-080 answered size and lid only). Waits on: Tim.
5. **Detention layer name STORMWATER DETENTION PIPE:** not separately ruled (D-153). Waits on: Tim.
6. **Printed pen width of colour 160, legend line wording and label wording for detention:** unknown; not yet seen on a real plot (D-156, Q-103). Waits on: Tim.
7. **Label wording for each pipe kind** (SITUATIONS, DRAFTS_pipe 8). Waits on: Tim. **Answered in part by D-268:** three office wordings; the tight-space form is item 19 below.
8. **Pen width of the new layers** (SITUATIONS, DRAFTS_pipe 12). Waits on: Tim.
9. **INPUT_AUDIT question 10, pipe sizes 100 from a downpipe and 150 between pits:** answered in part by D-174 ("100 everywhere"); the planning chat has not marked it answered. Waits on: the planning chat.
10. **How pipe capacity is checked on bigger jobs with detention:** not known (Q-002); pipe sizes come from the standard until Tim says otherwise. Waits on: Tim.
11. **Crossing clearance between pipes:** office figure not known (SITUATIONS B5). Waits on: Tim.
12. **Junction on a pipe (a branch into a pipe) has no join type yet,** and stops a job (SITUATIONS B6). Waits on: the build chat.
13. **Flow direction from the outlet with a "Turn round" offer** (SITUATIONS B3, FM-013): recommended, not decided. Waits on: Tim. **Taken in part by D-271 DQ-028 (planning chat's call from his rulings; his to overturn):** "as drawn, not settled" until the run reaches an outlet, then it follows the outlet with a quiet "Turn round" offer (item 42).
14. **Pipe passing over or through a pit** (SITUATIONS B4). Waits on: the build chat.
15. **Charged, downpipe, tank and AG ends as proper ends** so charged lines are not reported "loose" (SITUATIONS B11, stops a job). Waits on: the build chat.
16. **Exploding a pipe loses its note** (midday run CETEST, 1 FAIL). Waits on: the build chat.
17. **Pipe window content** not gone through line by line (D-070). Waits on: Tim.
18. **Whether a detention pipe must sit fully below the top water level to count its full volume** (INPUT_AUDIT section 9). Waits on: Tim.
19. **A better label form for small tight spaces** (a short form and a two-line stack per label), owed as a picture (D-268). Waits on: the planning chat.
20. **The Pipe tool's on-cursor live preview** at real width with label and grade, starting on the pit wall: designed, not built (D-266, D-267). Waits on: the build chat.
21. **How the band and its two edge lines move as one thing with ordinary objects** is the build's to prove (D-264). Waits on: a test.
22. **What the PT250 to PT600 LABEL blocks are for** is not known and not guessed (D-290). Waits on: the planning chat.

**Closed (D-230 to D-297):** the conflict on what a new pipe opens with (closed by D-263); the invert text layer (closed by D-265); the pipe edge lines (closed by D-264); whether the label is an office block or text (closed by D-290, text); how a run is drawn (closed by D-237).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-234, D-236 to D-239, D-256, D-260, D-261, D-263 to D-265, D-268 to D-271, D-277, D-287, D-290, D-295 to D-297; `reference\research\R-011` (label blocks).

1. `DECISIONS.md` D-014, D-034, D-041, D-057, D-079 to D-083, D-102, D-123, D-128, D-133, D-134, D-140, D-142 to D-147, D-153, D-154, D-156, D-174, D-176, D-182, D-189, D-229.
2. `pictures\pipe_window_full_size.html`; `pictures\pick_a_detention_blue.html`.
3. `design\SITUATIONS.md` section B; `reference\design\LIMITS.md`; `reference\design\SUMS.md`.
