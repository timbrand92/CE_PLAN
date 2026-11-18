# Current rulings: Detention (rainfall, runoff, orifice, head, top water level, storage)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Where it lives and what it does

1. **In the first release:** "Tank and detention sums" (D-097).
2. **One "Detention" window for the job:** what is fixed, the volume needed, the storage you have (tank share, pipes and pits that hold water), the orifice, and it fills the criteria box on the sheet (D-099).
3. **Typed name DETENTION / DET** (D-101).
4. **Two answers side by side, of equal weight:** storage against what is needed, and discharge against what is permitted (D-106).
5. **Methods on day one:** Boyd's method and OSD4W / Swinburne; council-supplied figures typed in and the council's own calculator are not day one (D-098).
6. **The sums live inside the plug-in:** council figures and areas typed once, storage, orifice, depths and checks follow, and the computations sheet prints from the same numbers (D-021).
7. **Taken from the old plug-in,** each re-checked against a real job first: the orifice sums, storage in pipes, pits and tanks, the rainfall data and curve, pipe capacity sums (D-095).
8. **Detention window: "Tick: right track"** (D-114) and on the bench it looks good (D-169).
9. **Reduce what is typed:** use everything the system knows to cut manual calculations and inputs, "SUCH AS HEAD AND ORIFICE AS AN EXAMPLE" (D-169), carried out by D-171 change 3 (head, orifice and pit size worked out).

### Orifice, head and top water level

10. **The top of the orifice pit baffle (plate) is the top water level:** plate height = top water level less the orifice invert; head = that less half the orifice; neither is typed (D-172).
11. **The criteria box keeps printing the baffle height under "HEAD",** as now; the sum uses the head to the orifice centre (D-023).
12. **Orifice size put on the drawing is rounded down to a whole mm,** never over the permitted discharge (D-173).
13. **The top water level and the orifice are normally fixed on a tight site** (D-018).
14. **The tank orifice is 30 mm, office standard** (D-024).

### Storage

15. **Tank split worked out from the volume needed;** re-use takes the rest (D-100). (CONFLICT with D-024, see Still open.)
16. **Pits count as storage only when ticked;** volume = plan size times water depth, the depth worked out from the top water level (D-105).
17. **Twin detention pipes count both pipes** in the storage sum (D-082).
18. **Head, orifice, storage and flows run only on a run that reaches the outlet,** and otherwise say what is missing (D-176).

### Areas, runoff and rainfall

19. **Site areas: picked off the drawing (and then linked to the outline), typed, or given in a council document;** each shows where it came from; the first release marks a council figure "given" (D-107, D-108).
20. **Site and impervious areas are measured by a mix, job by job** (D-020).
21. **No site rainfall entered:** by default no storage figure is shown ("cannot work out yet: site rainfall not entered"), and the drafter may type his own rainfall estimate to get a figure for now (D-218).
22. **Old council figures:** only sourced figures come across, with their source; assumed ones are dropped and filled in from the first real council letter (D-096); a council figure without a document on file stays blank (D-148).
23. **When rules disagree:** council, then AS 3500.3, then the office guidebook (D-022).

## Changed along the way

1. **OBSTACLE_COURSE OQ-04 recommended option A (amber and APPROX. when no rainfall is entered); Tim chose no figure by default, with his own estimate allowed (D-218, 18 Nov).**
2. **INPUT_AUDIT question 1 (is the baffle top at the top water level) was answered yes by D-172 and question 3 (orifice rounding) by D-173 (18 Nov);** the document still lists them as open.

## Still open on this subject

1. **CONFLICT: tank re-use from the STORM or sustainability report (D-024) against worked out from the volume needed (D-100).** Neither marks the other. Waits on: Tim.
2. **How the top water level is first chosen** (Q-001; INPUT_AUDIT question 2); the four "work it out from the system" questions were not answered and must not be re-asked in the same form (D-175). Waits on: the planning chat (to find a new way to ask).
3. **Whether the orifice pit is always the last pit before the council connection** (INPUT_AUDIT question 6; item 15 says nothing ties the orifice pit to P1). Waits on: Tim.
4. **A typed rainfall estimate:** the planning chat's reading, not yet put back to Tim, is that it is marked assumed, prints APPROX., stays on the unfinished list until the site's table replaces it, and the plug-in never supplies a curve of its own (D-218). Waits on: Tim.
5. **How each site's Bureau rainfall table arrives, and whether one table per job is right** (INPUT_AUDIT question 5, section 1 item 8; FM-050). Waits on: Tim.
6. **OSD4W inputs are not in the reference;** the window shows only two typed results (D-114; THE_PLAN section 7 item 3); where the OSD4W rainfall zone and times come from when the letter is silent (Q-006). Waits on: Tim.
7. **Pervious coefficient 0.30 or 0.35** (Q-004; INPUT_AUDIT section 1 item 9). Waits on: Tim.
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

## Where the detail lives

1. `DECISIONS.md` D-018, D-020 to D-024, D-095 to D-100, D-105 to D-108, D-114, D-148, D-169, D-171 to D-173, D-176, D-218.
2. `design\INPUT_AUDIT.md` sections 1, 2, 5, 9; `reference\design\SUMS.md`; `reference\councils\`.
3. `reference\research\R-008_TWO_WRONG_FIGURE_BUGS.md`; `stage6\OBSTACLE_COURSE.md` OC-24.
