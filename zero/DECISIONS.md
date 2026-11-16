# Decisions (zero plan)

Tim's decisions for this plan, in his words, dated. Numbers are never reused. A later answer that replaces an earlier one is added as a new D-number and the old one is marked superseded. Clicked choices are shown as the option he chose; typed answers are in quotes. Full context for each is in `evidence\STAGE1_INTERVIEW.md` (item numbers in brackets).

## Direction

**D-001** (16 Nov 2026) Plan from zero; the existing plugin is a parts bin. "can we plan from zero and then take what is relevant ... i feel like im going nowhere in the current version, we also need to focus on user experience and interface."

**D-002** (16 Nov 2026) [8l] The aim: "the whole idea of the plugin is that the database is built so that it understands the whole system and it allows the end user to type it once and everything is carried throughout and logical".

**D-003** (16 Nov 2026) [8m] Disagreement between sources is not allowed to stand: "we cant allow this to happen, if they disagree end user can select correct number or provide a small note to justify".

**D-004** (16 Nov 2026) [8n] Simpler than the old plan: "THE ISSUE WITH THE OLD PLAN IS THAT I THINK IT OVERCOMPLICATED EVERYTHING WHEREAS I WANT THIS NEW PLAN TO TAKE WHATS GOOD FROMT HE OLD PLAN AND THEN MIX IT WITH YOUR NEW FULL UNDERSTANDING OF THE DRAFTING AND ENGINEERING ELEMENTS".

**D-005** (16 Nov 2026) [8k] End goal: "ultimately my plan is to support all job types and situations". The chat must lead: "you need to guide me through and have full understanding then we can make better plugins".

**D-006** (16 Nov 2026) [8t] Scope now: "for now lets focus on civil/ce tools/manager and then structural will only become part of it once everything is working". (R-67)

**D-007** (16 Nov 2026) [8t] Rethink the foundations: "i want us to completely rethink how this is distritbuted, how this is installed, how this is even structured from the very core".

**D-008** (16 Nov 2026) [8u] AutoCAD 2027 only: "we will be going with autocad 2027 build only for this". (R-66)

**D-009** (16 Nov 2026) [8u] Always build to be added to: "THIS IS A STRICT RULE ALWAYS BUILD FOR SCALABILITY AND ABILITY TO BE BUILT UPON". (R-65)

**D-010** (16 Nov 2026) [8q] Client drawings may be read for planning: "WITH THIS PLANNIGN I DONT MIND IF YOU USE ANY CLIENT DRAWINGS WE NEED TO UNDERSTAND USING AS CLOSE TO REAL SCENARIOS AS POSSIBLE". (Client details still never go into any saved file.)

## The one element

**D-011** (16 Nov 2026) [8u] Pits and pipes are one element with editable parts: "all pipes and all pits are one element with the separate objects within it but they are all editable in their own way ... instead of having all these separate objects to handle it becomes one easy object that can be modified and moved to suit each design because sizing is tight often".

**D-012** (16 Nov 2026) [8u] Offsets are settings: "they have distances off the object like the text, this is a setting and is always the same normally unless we need to move for clashing purposes".

**D-013** (16 Nov 2026) [8u] One place for standards: "same with all the symbols, drawn by hand and text sizes this should all be standardised and understood in one place".

**D-014** (16 Nov 2026) [8w] A label moved by hand stays where it was put when the pipe changes (wording updates; position holds until reset).

**D-015** (16 Nov 2026) [8x] Without the plugin a drawing must look and plot identical, and this must be proven: "LOOKS AND PLOTS IDENTICAL BUT I HAVE A SITUATION ATM WHERE SOMEONE HAS DRAWN AND DESIGNED USING THE NEW PLUGIN AND IT WAS MEANT TO BE LOOKS AND PLOTS IDENTICAL BUT THE PEOPLE WITH NO PLUGIN CANT SEE ANYTHING AT ALL. SO MAKE SURE IT CORRECT".

**D-031** (16 Nov 2026, later the same day) SUPERSEDES the reading of D-011 as "one big element". A pipe is an element and a pit is an element; they work together but are not one: "I MEANT MORE THAT THOISE 13 ELEMENTS BECOME ONE PIPE AND TWO PITS THAT WORK TOGETHER BUT ARENT ONE FULL ELEMENT, DOES THAT MAKE MORE SENSE? OTHERWISE IT MIGHT GET TOO STICKY?"

**D-032** (16 Nov 2026) Muscle memory: "A LOT OF OUR STAFF HAVE BUILT MUSCLE MEMORY TO HOW THINGS LOOK AND FEEL NOW SO MAKE SURE IT ALIGNS WITH THAT VISION AND THAT UNDERSTANDING". Tim's UI / UX rules as pasted that day are saved word for word in `UI_UX_RULES.md`.

**D-033** (16 Nov 2026) Grips: "WITH THE GRIPS THERE NEEDS TO BE AS MANY AS THERE ARE NOW FOR THE INDIVIDUAL ELEMENTS WITHIN THE OVERALL ELEMENT".

**D-034** (16 Nov 2026) Things interact precisely: "I WANT EVERYTHING TO INTERACT AND PLAY NICE TOGETHER, SAY AN END USER WANTS TO DRAW A PIPE FROM ONE PIT TO ANOTHER AND THEY SELECT SOMEWHWERE ON THE PIT I WANT IT TO VISUALLY SHOW IT COMING FROM EXACTLY ON THE PIT WALL IN LINE WITH WHERE THEY CLICKED".

**D-035** (16 Nov 2026) What a concept must show: "HOW AN END USER WOULD INTERACT WITH IT ... HOW THE WHOLE PROCESS WOULD WORK, HOW IT MAKES IT EASIER FOR THE END USER AND WHERE AND HOW THE DATABASE AND CORE FOUNDATIONS WILL WORK BETTER THAN THEY UISED TO".

**D-036** (16 Nov 2026) The concept must cover every element before anything progresses: "ALSO YOU HAVENT SHOWN HOW SOURCE BLOCKS WORK, TANKS, ALL OTHER ELEMENTS THAT MAKE UP PART OF THE SYSTEM. I WANT THIS TO BE FULLY COVERED PRIOR TO PROGRESSING".

**D-037** (16 Nov 2026) How the grips must work: "GRIPS NEED TO WORK SO TEXT / INVERT TEXT / ARROW CAN BE MOVED PEPENDICULAR TO LINE OR PARALLEL TO LINE, COVER LEVEL TEXT CAN BE FLIPPED AND MOVED AND PIT LABEL CAN BE MOVED AND FLIPPED WE NEED ALL SCENARIOS".

**D-038** (16 Nov 2026) Every situation must be thought through: "HAVE YOU THOUGHT ABOUT ALL SITUATIONS AND SCENARIOS WHAT HAPPENS IF A PIPE IS PLACED ANYWHERE, ARE YOU FINE WITH THAT, WHAT HAPPENS IF A CHARGED PIPE RUNS FROM DOWNPIPE TO WATER TANK ONLY". Tim also asked for both pages to be sent together when the elements page is done.

**D-039** (16 Nov 2026) The concept pictures are illustrations, not one-to-one. The real thing uses the office's own blocks and layouts exactly as drawn today. Tim's two examples: "WATER TANK TEXT HAS AN ARROW BACK TO WATER TANK ISNT SHOWN IN YOURS BUT THATS HOW WE DISPLAY IT" and "THE PIT AND THE PIT WALL YOURE SHOWING JUST THE INTERNAL PIT WALL LINE AND NOT THE OUTER DASHED/HIDDEN LINE". So: the tank note has a leader arrow back to the tank (a part of the tank element); a pit shows its inner wall line and its outer dashed / hidden line.

**D-040** (16 Nov 2026) "AGI DRAINS DONT HAVE INVERT LEVELS."

**D-041** (16 Nov 2026) All pipes behave alike: "ALL PIPES ACT IN THE SAME OR SIMILAR WAYS LIKE INVERT LELVEL IS ALWAYS PLACED IN THE SAME SPOT ON THE PIPE UNLESS THERES CLASHES IN WHICH CASE IT SLIDES UP AND DOWN TO SUIT". (One standard spot for each part on every pipe kind; a clash is solved by sliding the part along the pipe.)

**D-042** (16 Nov 2026) On the two concept pages (concept draft 2 and "Every element, one by one"): "EVERYTHING LOOKS RIGHT BUT I MIGHT HAVE MISSED SOME STUFF". Read as: the direction is right; it is NOT the formal "approve" of R-15, and the chat must itself hunt for what was missed rather than rely on Tim to spot it.

**D-043** (16 Nov 2026) Tim's next question for the design: "NOW YOU KNOW ALL THIS WHAT AND HOW DO WE DELIVER THIS THROUGH THE UI AND UX TO END USERS AND HOW BEST CAN WE ALLOW THE DESIGN ADN DRAFTING PROCESS BUT ALSO ENCOURAGE AUTOMATION OF TASKS". (A question, not a decision. The chat's answer is the page `pictures\new_plugin_ui_and_automation.html` and CONCEPT.md section 11, both drafts until Tim rules.)

**D-044** (16 Nov 2026) Two points from Tim: "WOULD THERE BE A WAY TO ADD JOB TRACKING FOR THE MANAGER SECTION AND ALSO IM NOT CONVINCED THE DESIGN OF THE PLUGIN IS PERFECT YET, COMMAND NAMES AND RIBBON FEELS SEPARATE AND IT DOESNT FEEL LIKE A GOOD EXTENSION OF AUTOCAD". So: (1) job tracking is wanted in the Manager (what kind: being asked); (2) the concept's command names and ribbon are NOT accepted: they must be redesigned as one system that feels like part of AutoCAD. This qualifies D-042 ("everything looks right").

**D-045** (16 Nov 2026) Job tracking in the Manager covers all four: where each job is up to; what was issued and when; time spent on each job; what each job is waiting on.

**D-046** (16 Nov 2026) Command names: Tim asked for a recommendation and said "I FIND LONG COMMAND NAMES ARE HARD TO REUSE". So short names are what people type; any long plain name is only the label. Not yet decided: the actual list (to be proposed after checking for clashes with AutoCAD's own short names).

**D-047** (16 Nov 2026) Ribbon: "Show me options first" (study how AutoCAD and Civil 3D lay out their own ribbons; show two or three mock-ups to choose from).

**D-048** (16 Nov 2026) One pit's or pipe's facts show in AutoCAD's own Properties palette, under a CE heading, editable there. The CE side panel is for whole-job things (job facts, levels, storage, checks, sheet).

**D-049** (16 Nov 2026) Tim on the concept pages and the design, his words: "HAVING A MASS OF LINES, TABLES, NUMBERS AND INFORMATION IN SOME SCREENS IS TO ITS DETRIMENT AS PEOPLE LOSE FOCUS OF WHATS IMPORTANT. IN YOUR PLAN ITS PRETTY HARD TO KNOW HOW WE ADD A SLAB OR HOW WE ADD SOMETHING LIKE A GIO HOW AND WHY IS WHAT YOUVE DONE APPRIOPRIATE? HOW DOES STUFF GET HANDLED WHEN IT IS EDITED LIKE SIZE CHANEGS AND OTHER THINGS LIKE THAT. I THINK THE TYPED NAMES NEEDS A REFRESH AND IT NEEDS TO BE ALL ON ONE STRATEGY. HOW DOES ONE KNOW THAT A FLIP ONLY WORKS WITH A RIGHT CLICK. I DIDNT MEAN REMOVE THINGS TO MAKE THERE LESS THINGS I MEANT WERE LOGICAL WE DO THAT. SOMETHINGS ARE INTUITIVE TO A REGULAR USER OF AUTOCAD THAT SHOULD BE THE CORE FOUNDATION. HOW DOES THE PLUGIN CONSUME EXISTING PROJECTS, HOW DO THEY WORK TOGETHER OR GET UPTO SPEED? THINK HOW DOES A USER DO THIS TODAY WITHOUT THE PLUGIN AND THINK HOW CAN WE NOT INTERFERE TOO MUCH WITH HOW THAT WORKS BUT ALSO MAKE LIFE EASIER. TEH WAY YOU DISPLAYED THIS INFORMATION TO ME IS HARD TO READ AND UNDERSTAND, IT TAKES TRUE FOCUS TO READ IT". Rulings in it: (1) screens and pages must not be a mass of lines, tables and numbers; (2) every tool must be explained as how you do it, starting from how it is done today; (3) what a regular AutoCAD user already finds intuitive is the core foundation, and the plugin must not interfere much with today's way of working; (4) typed names are to be refreshed on ONE strategy (this replaces "keep today's names" in the concept); (5) nothing may depend on a hidden action such as a right-click (a flip must be discoverable); (6) do not remove things just to have fewer: only where logical; (7) how existing projects are taken up must be designed (this reopens D-027); (8) slabs and how edits such as a size change are handled must be shown.

**D-050** (16 Nov 2026) On the "How you do it" page (five short picture stories): "WHAT IF I DONT WANT TO PUT SAWCUTS OR GIO NEEDS TO GO SOMEWHERE ALONG THE PIPE. THE REST LOOKS GREAT". Read as: (1) the short picture-story format works and is to be used from now on; (2) nothing optional is ever forced: a slab does not require saw cuts; (3) an inlet such as a GIO goes exactly where the drafter clicks along the pipe and can be slid along afterwards. The planning chat's answer, given to Tim the same day: saw cuts are only drawn if the drafter draws them; a GIO sits where it is clicked on the pipe, slides along the pipe by its grip, and can also be placed off a pipe.

**D-051** (16 Nov 2026, evening) Ribbon: Tim picked "B: short CE tab + pop-ups" from the page `pictures\pick_a_ribbon.html`. One short CE Civil tab always in the row; a tab for the picked thing (Pit, Pipe, Inlet, Tank) appears when it is selected and goes when it is let go, the way AutoCAD's own Hatch tab does. Which buttons sit on the short tab is not yet settled (button names on the page were placeholders).

**D-052** (16 Nov 2026, evening) Naming rule: Tim rejected all three options on `pictures\pick_a_naming_rule.html`. His words: "I DONT LIKE ANYTHING, THINK ABOUT HOW REGULAR COMMANDS WORK LIKE BELOW", followed by the office's own short-name list (kept exactly in `evidence\TIM_ALIAS_LIST_16NOV.md`: A Arc, C Copy, Ch Chamfer, Ci Circle, M Move, Pl Pline, T Trim and so on). The planning chat's reading, to be confirmed by Tim: plugin names should work the way AutoCAD's do, a plain full word plus a one to three letter short name on the first-letter pattern, kept in the office's own list. Not yet confirmed.

**D-053** (16 Nov 2026, evening) Old typed names: "Old names are gone". Only the new names work from day one.

**D-054** (16 Nov 2026, evening) Names that sit on AutoCAD's own short names: "Keep IO, rename C and RC".

**D-055** (16 Nov 2026, evening) Naming rule confirmed. Asked "each plugin tool gets a plain full word plus a one to three letter short name, the way AutoCAD's own commands work?", Tim picked "Yes, that is it". The short name is built from the first letters of the word and sits in one office list the office can edit. This settles D-052 and replaces the three options on `pictures\pick_a_naming_rule.html`.

**D-056** (16 Nov 2026, evening) "Only placing has a name". Changing a thing (size, flip a tag) has no typed name: click the thing and use its tab, grips or Properties.

## How levels are designed

**D-016** (16 Nov 2026) [8v] Moving a pit has no single rule for levels: "IT DEPENDS ON THE DESIGN NO? SO INVERTS MIGHT HAVE TO CHANGE UPSTREAM OR WE MIGHT NEED TO UPDATE INVERTS TO SUIT OR GRADE".

**D-017** (16 Nov 2026) [8z] The critical value governs the method: "DEPENDS ON WHAT IS THE CRITICAL VALUE. MAYBE THE LPD INVERT IS REALLY HIGH AND WE NEED TO SEE IF WE HAVE ENOUGH DEPTH TO BACK OF SITE TO MAKE IT WORK OR MAYBE WE HAVE HEAPS OF DEPTH IN WHICH CASE WE WORK FROM THE TOP DOWN. IT ALL DEPENDS".

**D-018** (16 Nov 2026) [8za] Normally fixed on a tight site: the council connection invert; cover levels; the top water level and orifice. (Tank outlet / charged inlet was not ticked as fixed.)

**D-019** (16 Nov 2026) [8zb] House with no detention: levels and cover only are worked out; pipe capacity is not checked.

**D-020** (16 Nov 2026) [8zc] Site and impervious areas are measured by a mix, job by job (architect's figures, off the CAD, engineer or drafter).

## Sums and rules

**D-021** (16 Nov 2026) [8y] The sums live inside the plugin (council figures and areas typed once; storage, orifice, depths and checks follow; the computations sheet prints from the same numbers).

**D-022** (16 Nov 2026) [8zd] When rules disagree: council, then AS 3500.3, then the office guidebook.

**D-023** (16 Nov 2026) [8ze] The criteria box keeps printing the baffle height under "HEAD", as now; the sum keeps using the head to the orifice centre.

**D-024** (16 Nov 2026) [8zf] The 30 mm tank orifice is the office standard; reuse volume comes from the STORM or sustainability report; the rest of the tank is detention.

## How people work

**D-025** (16 Nov 2026) [8zg] Design and drafting meet either way, per job: small jobs straight in the drawing by one person; bigger jobs by mark-up and a drafter. The plugin must suit both.

**D-026** (16 Nov 2026) [8zh] 2 to 5 people will use the civil tools in the first year.

**D-027** (16 Nov 2026) [8zi] New jobs first. Old hand-drawn drawings still open and plot; a tool to adopt them comes later.

**D-028** (16 Nov 2026) [8zj] A new version is offered when AutoCAD starts and installs with one click, with no administrator rights; going back is one click.

**D-029** (16 Nov 2026) [8zk] A "civil site job" apart from the stormwater and pavement sheet exists "sometimes". Which kinds: not yet said (see OPEN_QUESTIONS).

## About today's practice (facts Tim gave, not design decisions)

**D-030** (16 Nov 2026) [1 to 8, 8b to 8j] Council stormwater work is mostly single houses and units; under half a day each; one person on small jobs, mark-up and drafter on units; the office applies to council for the discharge point; sheets are layout plan, notes and details, computations; long sections only when council asks; rework comes from architect changes, council sending it back, and the drawing not matching; design often starts on assumptions (discharge point or flow, levels, tanks) and there is no set way of showing what was assumed.

## Not decided (asked or raised, no decision yet)

1. Whether Stage 1's civil explanation is approved (Tim moved on to the design without saying "approve").
2. Who accepts work (P-01).
3. Everything in Stages 3 to 6.
