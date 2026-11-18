# Current rulings: Foundation (facts, sums, joins, standards, checks, unfinished, assumed, copies, what a drawing remembers)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Hold what is fixed, the rest is worked out

1. **Every number has a value, where it came from, and a hold; what is not held is worked out,** in whichever direction that needs: "Yes, that is the idea" (D-086, agreeing the proposal of D-085).
2. **Type it once, carried throughout** (D-002); **disagreeing sources are never left standing:** the user picks the correct number or adds a short note (D-003).
3. **Source words:** given, measured, chosen, worked out, assumed, standard, typed over (D-150, which added "typed over" for a standard that has been typed over).
4. **A site area can come from the drawing, be typed, or be given in a council document:** one more source on the same fact, not a new piece of screen (D-108, D-107).
5. **Worked-out facts:** for example the tank split is worked out unless held (D-100).
6. **The plug-in never bends a standard by itself;** it says how far out and what could be changed (D-124), and reports a clash by stretch and amount without blaming one pipe (D-125).
7. **The sums live inside the plug-in** and every view prints from the same numbers (D-021).

### Standards held in one place

8. **Symbols, hand-drawn items and text sizes are standardised and understood in one place** (D-013).
9. **Offsets of text and parts from the object are a setting,** normally always the same, moved only to clear a clash (D-012).
10. **Order of authority:** council, then AS 3500.3, then the office guidebook (D-022), narrowed for cover by D-144 (take the larger).
11. **What a drawing remembers:** the drawing keeps the standard values it was designed with; on opening, one line says what has changed in the office list and offers to switch; nothing changes unless a person says so (D-180).

### Cut what is typed

12. **Five changes, in this order:** (1) numbers, kinds and office defaults fill themselves; (2) one fact held in one place; (3) head, orifice and pit size worked out; (4) one Job window typed once per job; (5) read the drawing: downpipe joins, hatched roof and paving, the boundary, then cover levels (D-171, from D-169 item 4); item 5's "cover levels" was withdrawn by D-178 (see Changed).
13. **Fewer places for a mistake to live:** the planning chat's answer to D-212 (one shared part for every job every tool does; rules as lines in a list; one fact held once; the obstacle course; speed and "native AutoCAD untouched" as tests) led to "yes, write both" (D-213); the answer itself is the planning chat's, and the function map and obstacle course are not approved until read.

### Unfinished is normal

14. **The office designs while it draws,** and pipes are often drawn before they belong to a run or reach an outlet; the plug-in must work with loose pipes and pits (D-175).
15. **Loose things:** allowed and not an error; "not known yet", never a guess; "not joined yet" in grey; joining fills in and "What else changes" says what; sums wait and say what is missing; one list of what is not joined yet (D-176).
16. **A check that cannot run because a figure is missing is grey,** like "not known yet"; amber and red stay for decided figures (D-219).
17. **Plotting with open items:** one quiet command-line line with the count, never a stop (D-188).

### Assumed and not known

18. **An assumed figure prints "APPROX." in front, plus one standing note;** when confirmed APPROX. goes (D-177).
19. **A figure not known yet prints "TBC"** (D-178).
20. **Design often starts on assumptions** and there is no set way today of showing what was assumed (D-030).
21. **Job facts found in a copied drawing are treated as assumed until confirmed** (D-191).

### Copies, typed-over text and hand edits

22. **Copying to a mirror unit:** sizes and grades copy; levels copy marked assumed; copies take the next free numbers (D-179).
23. **Typed-over text keeps the wording, is flagged, and one click lets it follow again** (D-182, same as a schedule cell, D-103).
24. **A plain line on a stormwater layer drawn with no plug-in:** one line on opening with a "take it up" click; never automatic (D-192).
25. **Levels and grades are never changed by editing their text** (D-185).

### Ordinary objects

26. **Only ordinary AutoCAD linework, text and the office's own blocks;** the special one-piece pipe object, the linking code around it, facts held in several places with repair commands, the settings store where a new value needs new code, and the old windows are left behind (D-094).
27. **Build approach from the trials:** a join is kept as a soft pointer on the object itself; joined pipe ends are moved at the end of the command (one undo step); a position stamp is kept with each note; no drawing-wide shelf of facts keyed by handle (THE_PLAN section 6a, from trial results; not a Tim decision).

## Changed along the way

1. **D-011 "one big element" became separate elements working together (D-031, 16 Nov).**
2. **Typed-over values as special cases in the window (D-079, D-080, 16 Nov) were replaced by one mechanism, the hold (D-086, 16 Nov).**
3. **FOUNDATION.md "Rulings from the first trial" item 1 still says a printed grade is what the printed inverts give (D-123); for the label this was replaced by D-154 (17 Nov):** print the grade as typed. FOUNDATION.md is stale on this line.
4. **Read cover levels off the drawing (D-171 change 5, INPUT_AUDIT) was withdrawn by D-178 (18 Nov).**
5. **The amber-or-grey question for "cannot check yet" (SITUATIONS, OQ-06) was settled grey by D-219 (18 Nov).**

## Still open on this subject

1. **FOUNDATION.md beyond the hold idea is "proposed":** the seven blocks (fact, sum, thing, join, standard, check, view) are the planning chat's write-up; only the hold idea is agreed (FOUNDATION.md status, D-086). Waits on: Tim.
2. **SITUATIONS rules 1 to 18 "have NOT been put to Tim one by one";** where a rule goes beyond his answers it is only a proposal (SITUATIONS "Rules this adds to the foundation"). Waits on: Tim.
3. **Where the network, job facts and office standards are stored** so later tools read one place, and keeping job facts out of pasted objects (Q-204; SITUATIONS C14). Waits on: the build chat.
4. **The standing note wording for APPROX.:** not yet given (D-177). Waits on: Tim.
5. **How many layers of the old evidence model are needed** (PARKING_LOT P-02). Waits on: the planning chat.
6. **Whether sums in any direction stay quick and predictable on a branched run inside AutoCAD** (FOUNDATION honest limits; THE_PLAN section 6 item 4). Waits on: a test.
7. **A "junction on a pipe" join is missing from the joins list** (SITUATIONS B6). Waits on: the build chat.
8. **"Largest size that still passes" brain ability, the top water level box and a council minimum orifice row** do not exist yet (INPUT_AUDIT section 1). Waits on: the build chat.
9. **On-open self-check:** wording of the "changed outside the plug-in" list, self-check after RECOVER, a check for a half-made pit after a crash, an unreadable note treated as a plain object (SITUATIONS C15, C17, J4, J5). Waits on: the build chat.
10. **Exploding a pipe loses its note** (CETEST FAIL, midday 18 Nov); EXPLODE awaits a supervised check (SITUATIONS C10). Waits on: the build chat.
11. **The live drawing that shows nothing without the plug-in is kept as a test case;** where the file is has not been given (PARKING_LOT P-04, Q-017). Waits on: Tim.
12. **Proof that a sheet edited with no plug-in comes back and is reported correctly:** PASS in trial 3; AutoCAD LT and a live drawing not tested (THE_PLAN section 6a). Waits on: a test.
13. **R-36 lists "read from a schedule or PDF by Claude" as a source;** D-150's list has no such word. Waits on: Tim.
14. **Following stays on from open (SITUATIONS J6) against PERFORMANCE 2.6 "starts only when a CE tool is first used"** (SITUATIONS document conflicts). Waits on: Tim.

## Where the detail lives

1. `design\FOUNDATION.md`; `DECISIONS.md` D-002, D-003, D-012, D-013, D-021, D-022, D-030, D-085, D-086, D-094, D-100, D-107, D-108, D-124, D-125, D-150, D-171, D-175 to D-180, D-182, D-185, D-188, D-191, D-192, D-213, D-219.
2. `design\SITUATIONS.md`; `design\INPUT_AUDIT.md`; `reference\design\SUMS.md`.
3. `stage4\TRIAL_RESULTS.md`; `reference\research\R-002_HOW_TO_BUILD_IT.md`, `R-003_TRIAL_FINDINGS.md`.
