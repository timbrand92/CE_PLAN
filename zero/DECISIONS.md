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

**D-057** (16 Nov 2026, evening) On the draft list of 17 names: "I CANT SEE LIST, LETS FOR NOW JUST KEEP PIPE/CD". The list was in the chat behind the question window, so Tim has NOT reviewed it; it stays a draft. For now a pipe is PIPE with short name CD (this keeps today's CD, an exception to D-053 for this one name).

**D-058** (16 Nov 2026, evening) How a tool is driven. Asked how the kinds of pipe should be typed: "IN THE WINDOW WE SELECT THESE THINGS, SO IT SHOUDL WORK SIMILAR TO HATCHES. WE CAN HAVE SMALL COMMANDS RUN IN THE COMMAND LINE BUT THEN WHEN YOURE USING HATCH IT SHOWS A POP UP WINDOW TO SELECT AND MODIFY. I LIKE THAT BETTER THAN TOO MUCH IN THE RIBBON OR ON THE COMMAND LINE. DOES THAT MAKE SENSE?" And straight after: "THE COMMANDS NEED TO WORK SIMILAR TO HOW AUTOCAD DOES, ALL PLACEMENT USES A COMMAND AND THEN PROPRTIES OR SOMETHING LIKE THAT EDITS IT OR SOMETHING LIKE THAT". Read as: (1) every placement starts with a short typed command; (2) the choices for it (kind, size and so on) are made in a small pop-up window, the way Hatch does it, not in a long row of ribbon buttons or command-line prompts; (3) editing afterwards is through Properties or a like window. Effect on D-051: the short CE Civil tab stays; the tab that appears on selection must stay light.

**D-059** (16 Nov 2026, evening) FO: "Leave it as FO only". It has no longer name.

**D-060** (16 Nov 2026, evening) When the small window appears: "Every time, like Hatch". Type the command (CD for a pipe), the small window opens already filled in with what was used last, change something or not, then draw.

**D-061** (16 Nov 2026, evening) Editing a drawn thing: "Properties, and double-click opens the window". Click it and change it in AutoCAD's Properties (D-048), or double-click it to get the same small window it was placed with.

**D-062** (16 Nov 2026, evening) The model for the small window: Tim sent a screenshot of AutoCAD's own Hatch Edit window, with no words (kept as `evidence\TIM_HATCH_EDIT_WINDOW_16NOV.png`). It follows D-058 ("IT SHOUDL WORK SIMILAR TO HATCHES"). What the picture shows, as the planning chat reads it: one fixed window, not a ribbon tab and not a side palette; a few boxed groups each with a plain title (Type and pattern, Angle and scale, Hatch origin, Boundaries, Options); drop-down lists for the choices with a swatch showing the result; buttons that send you to the drawing to pick and bring you back (Add: Pick points, Add: Select objects); Inherit Properties (copy the settings from one already drawn); Preview, OK, Cancel, Help along the bottom. Every plugin window is to be built on this pattern. Tim has not yet confirmed that reading in words.

**D-063** (16 Nov 2026, evening) Corrects D-062. Tim: "IT SHOULDNT BE THE EXACT WAY THINGS ARE BUILT. ITS A START BUT I WANT TO CREATE A UI PLAN ON HOW THINGS SHOULD LOOK NO MATTER WHAT COMMAND, DOES THAT MAKE SENSE". Read as: the Hatch Edit window is a starting point, not a template to copy. What is wanted is ONE UI plan: a single set of rules for how every window looks and behaves, whatever the command, so a person who has used one has used them all. The UI plan is to be made with Tim before any window is designed. (His standing UI/UX rules in `UI_UX_RULES.md` still apply.)

**D-064** (16 Nov 2026, evening) What the UI plan must deliver. From the Hatch window Tim ticked only "See it before OK" as what he likes. On what our windows must do better, his words: "PREVIEW SHOULD SHOW THE EXACT OBJECT AND HOW YOU ARE MANIPULATING IT IN REAL TIME, HOW THAT AFFECTS EVERYTHING AROUND IT. THEN IT SHOULD ALSO BE LAID OUT IN A WAY THAT MAKES SENSE TO AN END USER AND BE CONSISTENT AS MUCH AS POSSIBLE ACROSS ALL WINDOWS. IT SHOULD ALSO BE DISPLAYED IN A WAY THAT MAKES THE NEXT DECISION EASY TO FOLLOW AND THE PROCESS MAKES LOGICAL SENSE. LANGUAGE NEEDS TO BE EASY BUT LOGICAL FOR SOMEONE WHO USES AUTOCAD AND IS AN ENGINEER." He also ticked "A picture of the thing". Rulings: (1) the preview is the exact object, changing live as it is manipulated, and it shows the effect on everything around it; (2) layout makes sense to the end user and is consistent across all windows; (3) the order of choices makes the next decision easy to follow; (4) language is easy but logical for an engineer who uses AutoCAD. He asked to be shown "Two or three frame styles to pick from". Not ticked, so not assumed: everything in one window; boxed groups; pick-from-drawing buttons; smaller and simpler; not blocking the drawing; a line of words when something is off.

**D-065** (16 Nov 2026, evening) On the page `pictures\pick_a_window_style.html` (three small styles), Tim picked none and wrote: "THE WINDOW NEEDS TO TAKE UP 80% OF SCREEN AREA AND WE NEED TO SUPPORT 1440P AND 1080P ALSO WE ALWAYS NEED TO HAVE A INSPECT BUTTON WHICH ALLOWS YOU TO TEMPORARILY CLOSE THE WINDOW AND SEE WHAT YOURE WORKING ON AND STILL SAVE WHAT YOU ARE INPUTTING. THIS MOCKUP LOOKS SMALL AND DOESNT ACTUALLY SHOW THE TRUE DETAIL OF WHAT EACH WINDOW WILL HAVE IN IT". Rulings: (1) every window takes about 80% of the screen; (2) it must work at 1920 x 1080 and 2560 x 1440; (3) every window always has an Inspect button that hides the window for a moment so the drawing can be seen, and brings it back with everything typed still there; (4) mock-ups shown to Tim must be full size and show the true content of the window, not a small sketch. The three small styles on that page are set aside. Consequence drawn by the planning chat (not Tim's words): a window that size covers the drawing, so the live preview of the exact object and its surroundings (D-064) has to be inside the window, with Inspect for the real drawing.

**D-066** (16 Nov 2026, evening) Tim, while the full-size Pit window mock-up was being built: "PIT AND PIPE WILL BE DIFFERENT UI TYPES BUT THOSE ARE THE TWO STYLES". Read as: the UI plan has two window styles, one of the Pit type and one of the Pipe type, and every other command's window is one or the other. What makes the Pipe type different, and which commands belong to which type, is not yet said: to ask.

**D-067** (16 Nov 2026, evening) What makes the two window styles differ: "THE PREVIEW FOR PIPE WILL BE HROIZONTAL WHEREAS PIT AND OTHERS WILL BE A SQAURE, DOES THAT MAKE SENSE?" Which tools use which: "THINK ABOUT IT LOGICALLY". So: Style 1 (square preview) for a thing at one spot; Style 2 (wide, horizontal preview) for a thing that runs along a line. The planning chat's sorting, on that logic (Tim may correct): square = pit, downpipe, overflow, FO, IO, GIO, floor waste, tank; horizontal = pipe of every kind, AG drain, trench grate, spoon drain, strip drain. Everything else in the window (where choices, "what else changes", Inspect, Cancel and OK sit) is the same in both styles.

**D-068** (16 Nov 2026, evening) On the two full-size mock-ups (`pictures\pit_window_full_size.html`, `pictures\pipe_window_full_size.html`): "approve both but visually they are pretty average, look at our rules". Read as: the structure of both windows is approved (80% window; square preview for the Pit style, wide preview for the Pipe style; numbered choices in decision order; "What else changes" strip; Inspect and Match on the left, Cancel and OK on the right; live preview; both screen sizes). The look is NOT approved: it must be redone to `UI_UX_RULES.md` (Apple-like finish, one accent, cards that read like a maths teacher's working with one bold answer and the sum shown, colour for status only with a word, dark and light both designed, spacing scale, a separate UI critic before it is shown).

**D-069** (16 Nov 2026, evening) On the redone look of the two windows (screenshots of the Pit window in dark and the Pipe window in light, version 3): "those screenshots look great". Read as: this look is the direction for the UI plan (dark or light all through, following AutoCAD; one bold answer per card; the working shown as a sum; a small side view in the Levels card; status pills with a word; "What else changes" strip with Moves / Check / Wrong pills). He had seen two screenshots, not yet the working pages or every state; a separate UI critic was still checking.

**D-070** (16 Nov 2026, evening) "approve those new pit and pipe windows, all other windows should match". The Pit and Pipe windows (version 3 of `pictures\pit_window_full_size.html` and `pictures\pipe_window_full_size.html`, as sent to him working) are approved, and they are the pattern every other window must match. Written up as `design\UI_PLAN.md`. At the time, thirteen tightening fixes from the separate UI critic were being applied (version 4); they keep the approved look. The content of each window (which choices, their order and words) has not been gone through line by line.

**D-071** (16 Nov 2026, evening) Job tracking, how it is done today and where it should live. Asked how jobs are tracked today, Tim ticked "In my head / asking around", "Emails and folders" and "Another program", and wrote: "im building a creative engineering job manager program and ideally we build this in". Read as: job tracking belongs in the office's Job Manager program (the Job Manager website inside the CE_PM project, per `C:\TimOS\ROUTER.md`), not as a second, separate tracker inside the AutoCAD plugin. The plugin's part is to hand that program what only the drawing knows (stage reached, what was issued and when, time on the drawing, assumed values still open) and to show it back in the Manager window. How the two join has not been designed and the Job Manager's own plan has not been read by this chat: Stage 4.

**D-072** (16 Nov 2026, evening) Time on a job: "count by itself but you have ability to check". Time is counted automatically; the person can check (and correct) it.

**D-073** (16 Nov 2026, evening) Who sees hours: "Everyone sees job totals; only you see who".

**D-074** (16 Nov 2026, evening) Waiting on something that is not a value in the drawing: "A short note on the job in the Manager". Assumed values in the drawing still flag themselves.

**D-075** (16 Nov 2026, evening) Pit numbers: "P1 at the outlet, Renumber button". New pits take the next free number; a Renumber button re-runs them from the outlet working upstream when asked. (Gap check Pit item 4.)

**D-076** (16 Nov 2026, evening) Plastic pits in the schedule: "My choice per pit". A tick box "In the schedule" on each plastic pit, starting ticked. (Pit item 5.)

**D-077** (16 Nov 2026, evening) A pit placed on a drawn pipe: "Split the pipe in two". Two pipes joined to the new pit, each with its own label and levels; "What else changes" says so. (Pit item 6.)

**D-078** (16 Nov 2026, evening) Cover levels: "Locked on every pit". Once typed, only the person can change a cover level; working out levels along a run never touches it. (Pit item 2; follows D-018.)

**D-079** (16 Nov 2026, evening) Pipe material: "material selection for pipes must be text field as well a drop down". The Material box is a list you can pick from AND type into (a material not on the list can be typed). Straight after: "same with grade": the Grade box is also pick-or-type (any grade, such as 1 in 75, can be typed). Whether other lists (kind, size, lid) also allow typing: not said, to ask.

**D-080** (16 Nov 2026, evening) Asked which other boxes are pick-or-type, Tim ticked "Pipe size" and "Lid" and wrote: "you need ability to override both invert levels as well". So: pipe size and lid can be typed as well as picked; pit size was not ticked, so it stays list only; on a pipe BOTH invert levels (upstream and downstream) can be typed over. The planning chat's working rule for the mock-up (Tim to confirm): when the downstream invert is typed over, the grade is worked out from the two inverts and the length, the value is marked "typed over", and "Put back" returns it to the grade-driven value.

**D-081** (16 Nov 2026, evening) A branch joining a pipe with no pit: "allow it and offer an io if its a bend point in main pipe and theres no io on the main line and the run is long or is this over complicating it?" The branch is always allowed. An inspection opening is OFFERED (never forced) when the join is at a bend in the main pipe, the main line has no inspection opening, and the run is long. How long is "long": not said; to come from the office list or AS 3500.3, to be looked up. The planning chat's answer to "is this over complicating it?": no, provided it stays one quiet offer line and its numbers live in the office list. (Gap check Pipe item 19.)

**D-082** (16 Nov 2026, evening) Twin detention pipes: "One pipe that says '2 x 225'". One pipe with a number-of-pipes box; draws two bands, one label; the storage sum counts both. (Pipe item 16.)

**D-083** (16 Nov 2026, evening) Marking detention: "its own kind with a slightly different blue colour and layer, we will need to update the legend as well". Detention is its own kind of pipe, on its own layer, in a slightly different blue, and the legend gains a line for it. Which blue and what layer name: not said, to settle with the standards list. (Pipe item 17.)

**D-084** (16 Nov 2026, evening) The drop across a pit and the steps in the orifice pit: "Office standard, can be typed over". (Pipe item 23.)

**D-085** (16 Nov 2026, evening) Tim's concern about the foundation, his words: "keep interviewing me and keep stages moving. what happens if we design from the other directrion. see what i have an issue with is theres so many variables and it feels like too many to take care of and it feels like the ui / ux dont get designed for this and then i add stuff it doesnt feel like its being built onna foundation that is scalable  and or can be built on". Read as: (1) keep interviewing and keep the stages moving; (2) the windows as mocked up work in one direction only (upstream invert and grade give the downstream invert), and designing from the other direction (D-016, D-017: it depends on the critical value) is not catered for; (3) each new variable he raises is being added as a one-off (pick-or-type, typed-over inverts) and not from one foundation, which breaks R-65 (always scalable, always able to be built upon). The planning chat accepts this as correct. Its proposed answer, put to Tim the same evening and NOT yet agreed: one mechanism for every number everywhere, "hold what is fixed, the rest is worked out": every value shows where it came from and can be held; the plugin works out whatever is not held, in whichever direction that needs; if too much is held it says which values cannot all be true and by how much. A new variable is then a new fact using the same part, not a new piece of screen.

**D-086** (16 Nov 2026, evening) Asked what "design from the other direction" meant (levels from the discharge point upstream; or designing the plugin from the foundation up; or both), Tim: "a mix of all three points you made, this is where were going wrong were getting caught on tangents". Asked whether "hold what is fixed, the rest is worked out" is the right foundation for every number: "Yes, that is the idea". Rulings: (1) levels must work from either end; (2) the plugin is to be designed from its foundation (one set of building blocks) before more windows and details; (3) stop chasing detail tangents; (4) every number has a value, where it came from, and a hold; what is not held is worked out. Written up as `design\FOUNDATION.md`.

**D-087** (16 Nov 2026, evening) On the windows rebuilt on the foundation (version 6, padlock on every number, works uphill or downhill): "thats better, i cant give you full answer until using but were on the right track". The direction is confirmed; it is NOT a final acceptance. A full answer waits until he can use it for real.

**D-088** (16 Nov 2026, night) Stage 3 go-ahead: asked "may I start Stage 3 now, the parts-bin read of the OLD plugin? It is read-only", Tim: "Yes, start it in the background". Asked what to bring next for the plugin: "The whole-run levels tool". Stage 3 runs alongside Stage 2 from here; Stage 2 has not had a formal "approve".

**D-089** (16 Nov 2026, night) Who accepts a tool: "Me, or a robot pass if I am busy". Settles P-01.

**D-090** (16 Nov 2026, night) When something new may start: "Never while a tool on the ribbon is broken".

**D-091** (16 Nov 2026, night) Pace: "One tool at a time, each finished before the next".

**D-092** (16 Nov 2026, night) When the real AutoCAD may be used for trials: "anytime between 5:30pm and 8:30am weekdays and all day weekends". Test copies only. Note: the switch file `.timos\autocad.json` (written 5 Nov) still reads in-use and "mayStart: false"; which wins is to be confirmed by Tim before anything starts AutoCAD.

**D-093** (16 Nov 2026, night) Switch file against the new hours: "The hours win". Inside 5:30 pm to 8:30 am on weekdays and all weekend, trials may start AutoCAD on test copies whatever the switch file says, as long as no AutoCAD window of Tim's is already open (the option's own wording). Scope: the zero-plan trials. Asked whether he had clicked through the three windows: "Not yet, carry on".

**D-094** (16 Nov 2026, night) Parts bin, what is left behind: "leave all 5 behind but we need to ensure that people without the plugin are able to use everything as it was intended is that a hard thing to do? or at least eb able to explode it and use it as intended". Left behind: the special one-piece pipe object; the linking code built around it; facts held in several places with repair commands; the settings store where a new value needs new code; the old windows. Condition (restates D-015 and makes it stronger): a person with NO plugin must be able to use the drawing as intended, not only see and plot it: select, move, edit and add to it with plain AutoCAD; at the very least explode and carry on. The planning chat's answer the same evening: with only ordinary objects there is nothing to explode; what such a person loses is the automatic following; on return the plugin's self-check reports what was changed by hand. To be proven in trial 3, which is widened to "edit without the plugin and hand back".

**D-095** (16 Nov 2026, night) Parts bin, what is taken: "Yes, take these": the orifice sums, storage in pipes / pits / tanks, the rainfall data and curve, pipe capacity sums with their known-right answers, the office's own blocks, the pit schedule row rules. Each re-checked against a real job before it is trusted.

**D-096** (16 Nov 2026, night) Old council figures (287 of 410 marked assumed): "Keep only sourced figures; rest start blank". Sourced figures come across with their source; assumed ones are dropped; a council value is filled in the first time a real council letter gives it.

**D-097** (16 Nov 2026, night) First release, beside Pit, Pipe and Levels along a run: Tim ticked "Downpipe and the other inlets", "Tank and detention sums", "Pit schedule". "Title block and issue" was NOT ticked: not in the first release.

**D-098** (16 Nov 2026, night) Detention methods in the first release: Tim ticked "Boyd's method" and "OSD4W / Swinburne". Not ticked, so not day one: council-supplied figures typed in; the council's own calculator.

**D-099** (16 Nov 2026, night) Where detention lives: "One 'Detention' window for the job". Same window family: what is fixed, the volume needed, the storage you have (tank share, pipes and pits that hold water), the orifice; one answer; it fills the criteria box on the sheet.

**D-100** (16 Nov 2026, night) Tank split between re-use and detention: "Worked out from the volume needed". The detention part is what the sums say is needed; re-use takes the rest of the tank. (This is the foundation at work: the split is a worked-out fact unless held.)

**D-101** (16 Nov 2026, night) Short names for the first release: "Good, with DET for detention". PIT = PT; PIPE = CD; DOWNPIPE = DP; OVERFLOW = OF; FO = FO; INSPECTION = IO; GIO = GIO; FLOORWASTE = FW; TANK = TK; LEVELS = LV; DETENTION = DET; SCHEDULE = SH. Each still to be proven free in AutoCAD 2027 by the trials.

**D-102** (16 Nov 2026, night) Where a pipe stops at a pit: "At the inner wall line". The pipe passes the dashed outer line and stops at the solid inner wall. (This differs from how it is drawn today; new sheets will differ from old ones at pit edges.)

**D-103** (16 Nov 2026, night) Pit schedule cells: "Yes, with a padlock like everything else". A cell normally reads the pit; typed over it is held and shows a closed padlock; one click lets it follow the pit again.

**D-104** (16 Nov 2026, night) Pit kinds on day one: junction, grated, plastic; orifice (control) pit; pump pit and bought-in units. Silt pit and soakage pit were not ticked: later.

**D-105** (16 Nov 2026, night) Pits as detention storage: "Only pits I tick". Volume = plan size times water depth, the depth worked out from the top water level.

**D-106** (16 Nov 2026, night) The Detention window's answer: "Both, side by side". Two answers of equal weight: storage against what is needed, and discharge against what is permitted.

**D-107** (16 Nov 2026, night) Site areas: "Picked off the drawing, or typed". An area picked from a closed outline stays linked and updates if the outline changes; or it is simply typed. Each shows where it came from.

**D-108** (16 Nov 2026, night) Adds to D-107: "site areas might be able to come from council documents". A site area has three possible sources: measured off the drawing, typed, or given in a council document. In foundation terms this is one more source on the same fact, not a new piece of screen. Whether the plugin reads the figure out of the document itself or the person types it and marks it "given" is not said; the first release marks it "given".

**D-109** (16 Nov 2026, night) Pit schedule: "Placed once, then follows the pits". Type SH, pick where it goes; it draws in the office's layout and then updates itself whenever a pit or pipe changes; a typed-over cell is held (D-103); ordinary lines and text.

**D-110** (16 Nov 2026, night) Schedule rows besides the numbered pits: the existing council pit connected to; a pump well; plastic pits that are ticked (D-076).

**D-111** (16 Nov 2026, night) Inlet window (`pictures\inlet_window_full_size.html`): "Tick: right track, same as the others". Not a final acceptance; symbols are to be the office's own blocks when built. On the three leftovers of the stopped trial chat (the ZeroTrial profile, the load-safety setting in the unnamed profile, the trial folder): "Leave everything, I will look tomorrow". Nothing more is to be touched; the trials stay stopped (PARKING_LOT P-08).

**D-112** (16 Nov 2026, night) Pit schedule window: "tick but what happens for schedules that are 16 rows deep?" Ticked as right track; the long-schedule case is open (how it is handled today was asked next). On the unknown title and standing notes: "Read it off an issued job". Earlier the same night, unprompted, on the Inlet window: "yep happy witht hat window".

**D-113** (16 Nov 2026, night) Tank window: "Tick: right track, same as the others". Asked what is done today with a schedule of 16 or more rows, Tim answered about the WINDOW: "preview on the left and options on the right, allows more depth?" Ruling: a window whose subject is tall (the pit schedule) puts its preview on the left at full height with the choices on the right. UI plan consequence: the preview's shape follows the shape of the thing shown (square or tall on the left; wide across the top). What happens on the SHEET when a long schedule will not fit its spot is still not answered. Wording read off three issued sheets (identical on all three): title "STORMWATER PIT SCHEDULE"; headings PIT No. | PIT SIZE | INLET (FROM, DIA, INVERT LEVEL) | OUTLET (DIA, INVERT LEVEL) | COVER LEVEL | DEPTH TO OUTLET | TYPE OF LID AND REMARKS; three dash-bullet notes: "CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK."; "ALL STORMWATER PIPE SUB BRANCHES SHALL BE MIN. SAME SIZE DOWNPIPES GRADED AT 1:100 MIN."; "ALL GRATED COVERS TO BE HEEL SAFE UNLESS NOTED OTHERWISE. ALL COVERS TO BE PROFILED AND POSITIONED TO SUIT EXISTING SURFACE LEVELS, PAVING LAYOUTS, SPOON DRAINS, KERB CHANNELS AND OTHER FEATURES AS DETAILED ON ARCHITECTURAL DRAWINGS." Also seen: a pit with several inlets takes one schedule row per inlet (16 rows for 12 pits on one job). To be filed into `reference\drafting\TABLES_AND_BOXES.md`.

**D-114** (16 Nov 2026, night) Detention window: "Tick: right track" (he was told it is the busiest window and that OSD4W shows only two typed results because its inputs are not in the reference). A long pit schedule on the sheet: "It runs long; I make room": one block that grows downward; the plugin only warns that it may not fit.

**D-115** (16 Nov 2026, night) The plan: "Approve as the plan". `stage6\THE_PLAN.md` draft 1 is the plan the build works to: trials, foundation, window frame, one tool at a time (Pit, Pipe, Levels along a run, Inlets, Tank, Detention, Pit schedule), one real job, colleagues; no dates until the trials are done.

**D-116** (16 Nov 2026, night) Trials after the licence incident (P-08): "start the trials now, i checked license and it should be fine now or you can use codex as well through cli". The trials restart tonight. Codex through its command line is allowed as the driver. The planning chat added limits to `stage4\TRIALS_BRIEF.md` before restarting: no profiles, no force-closing, no licensing or sign-in, one AutoCAD at a time and none while Tim's is open, no registry writes, leftovers untouched. (His earlier answer "Leave everything, I will look tomorrow" about the leftovers still stands.)

**D-117** (16 Nov 2026, night) Stage 1 (how the office designs and draws civil jobs): "Approved as good enough to build on". He corrects it whenever he sees something wrong.

**D-118** (16 Nov 2026, night) Detention pipe layer and blue: "You propose, I approve on a sheet". A layer name in the office's style and two or three blues that print clearly different through the office plot style, shown on a sample sheet for him to pick. Owed.

**D-119** (16 Nov 2026, night) Drawings made with the old plugin's special pipe: "A one-off 'make it ordinary' tool, later". After the first release; one drawing at a time, on a copy first.

**D-120** (16 Nov 2026, night) Asked whether the ban on a chat making AutoCAD profiles, force-closing AutoCAD or touching licensing should be a standing rule for ALL chats on his PC: "Yes, add it to my rules". The rule text is to be drafted and shown to him before it goes into `C:\TimOS\RULES.md`.

**D-121** (16 Nov 2026, night) Rule 1.9 wording put to Tim in full: "Yes, add it as written". Added to `C:\TimOS\RULES.md` as 1.9 "Hands off AutoCAD's profile and licence", after 1.8; nothing else in that file changed.

**D-122** (16 Nov 2026, night) How the trial chat may open AutoCAD: "Yes, after I close the stuck window". After Tim closes the AutoCAD left at the "Customization file load failed. File not found: acad" message, trials may open AutoCAD by the double-click hand-off only (a made-up drawing handed to Windows), under his own profile, changing nothing, one at a time; rule 1.9 applies in full. At 21:58 that AutoCAD was still open (showing its Start tab), so nothing was released yet.

**D-123** (16 Nov 2026, night) A typed grade against rounded inverts: "What the inverts give: 1 in 59". The pipe label always shows the true grade between the two printed inverts, so a checker working from the sheet gets the same figure. (So a typed grade is the aim, and the printed grade is worked out from the rounded levels.) **SUPERSEDED for the label on 17 Nov 2026 by D-154: the label prints the grade as typed.**

**D-124** (16 Nov 2026, night) When held values do not fit and an office standard would have to give way: "Nothing: tell me, I decide". The plugin never bends a standard by itself; it says how far out and shows what could be changed.

**D-125** (16 Nov 2026, night) Reporting a clash of held values: "Name the stretch and the amount" (for example "Out by 0.06 between P4 and P1"), with the held values on that stretch listed and marked; no single pipe is blamed.

**D-126** (16 Nov 2026, about 10:05 pm) Tim: "can you force close autocad for some reason i cant". On that yes in words (rule 1.9), the planning chat closed the trial's stuck AutoCAD (the only AutoCAD running, started 9:24 pm, showing its Start tab): a normal close was tried first and did not work in 15 seconds, so it was force-closed. No AutoCAD was left running. The trial chat was then released to open AutoCAD by the double-click hand-off only (D-122).

**D-127** (16 Nov 2026, night) Start building: "Yes, start it now": a new chat builds only the part that needs no AutoCAD (the brain: facts, holds, sums, the office list of standards) and its tests, while the AutoCAD trials carry on; it never starts AutoCAD and never touches the installed plugin. Where the new plugin lives: "A new private repository of its own": the folder `C:\CE_CIVIL` with its own private GitHub repository under Tim's account, nothing shared with the old plugin's repository.

**D-128** (16 Nov 2026, night) First hands-on test by Tim, the Pipe window mock-up: closing the padlock on Downstream invert, typing 5.14 (grade becomes 1 in 89) and "Work uphill": "Yes, all three worked". On whether "padlock = held, open = worked out" reads at a glance for a drafter meeting it cold: "Yes, it is clear".

**D-129** (16 Nov 2026, night) Levels along a run. Asked whether the four test steps worked: "i cant test can you try". Whether it is how he would design levels on a tight site: "Yes: fix what is fixed, see where it fails". The preview: "Long section AND the plan". The planning chat then clicked the page itself (served locally, real events): typing 5.15 into Connection invert fails the run (0.20 m cover at P4, short by 0.10): works; "Flatten all grades to 1 in 200": works (still short by 0.05 at the connection; the chat had earlier told Tim "short by 0.01 at P3", which is the P3 figure, not the worst one); "Work downhill from the top": works; clicking a level in the long section to hold it gives NO visible feedback: a fault. Being fixed, with the plan added beside the long section.

**D-130** (16 Nov 2026, about 10:40 pm) The trial chat's test AutoCAD (t1_seed, opened 10:06 pm by hand-off) jammed part-way through trial 1 and was left open. Tim: "Close it for me": normal close tried, not complete in 15 seconds, force-closed on his word; no AutoCAD left running. On how the trials carry on after three jams (the planning chat recommended stopping for the night and using Codex tomorrow): "Keep trying tonight". The trial chat was told to continue under rule 1.9 with a changed method: short steps, state read back after each, never keys sent blind.

**D-131** (16 Nov 2026, night) Levels along a run with the plan under the long section and the hold feedback: "need more height on vertical otherwise great". The long section is to be drawn taller (about 5 times) with a slimmer plan strip.

**D-132** (16 Nov 2026, night) Levels along a run with the taller long section (4 to 5 times) and the one-line plan: "thats better".

**D-133** (16 Nov 2026, night) Office standard, minimum pipe cover (L-004 conflict): "The standard's table, by situation": each pipe has a 'what is over it' choice and the cover needed follows the table (100 single dwelling no traffic; 300 other sites no pavement; 450 under traffic no pavement; 100 under reinforced pavement; 75 under light pavement); detention pipe keeps 300.

**D-134** (16 Nov 2026, night) Office standard, minimum grade for detention pipes (L-001 conflict): "The stepped list by size": 225 at 1 in 200, 300 at 1 in 250, larger at 1 in 300; a council's own figure overrides it.

**D-135** (16 Nov 2026, night) Office standard, pit size by depth (L-006 conflict, Q-004): "Guidebook table": 350 to 0.45, 450 to 0.60, 600 to 0.90, 600 x 900 to 1.20 with step irons, 900 x 900 deeper than 1.20; a council condition overrides.

**D-136** (16 Nov 2026, night) Office standard, step irons: "1.0 m" (the design checklist's figure; not the 1.2 m printed in the sheet note, which the planning chat had recommended). Note for the build: the guidebook pit table in D-135 says "600 x 900 to 1.20 with step irons"; with step irons needed deeper than 1.0 m the two fit, and the sheet's standing note wording that says 1.2 m is now out of step with the office figure: raise with Tim when notes are built.

**D-137** (16 Nov 2026, late night) Tim: "im goign to ed can you keep things moving". The planning chat's reading and what it set going (his to overrule in the morning): (1) the build chat finishes the brain and then builds the window frame and shared parts as a stand-alone test program with no AutoCAD in it (the plan's next stage that needs no AutoCAD); anything that is Tim's call is taken at the recommended default and marked DRAFT for him; (2) a separate UI critic checks the four windows that never had one (inlet, tank, detention, schedule), and the faults are fixed; (3) tonight's decisions are filed into the reference library; (4) NOTHING starts AutoCAD overnight: the two trials that need a real mouse (grips, double-click) wait until Tim is there, because a stuck AutoCAD could not be closed without his word (rule 1.9).

**D-138** (17 Nov 2026, morning) Tim, out of the office all day: "for your reference im out of the office all day, what can you do whilst i am gone and where are we at?" Asked whether the build chat should carry on with the other five windows (Levels, Inlets, Tank, Detention, Schedule) on the same test bench, having gone one step past his "only the brain" ruling overnight: "Yes, carry on". This also confirms the Pit and Pipe bench of D-137. Still no AutoCAD in the bench, nothing installed.

**D-139** (17 Nov 2026, morning) Asked whether the trial chat may use AutoCAD on his PC today, on test copies only, for the two mouse trials (grips and double-click) with the Codex robot, rule 1.9 in force (no profiles, no licence, no force-close): "Yes, test copies only". This yes is for today (17 Nov) only. If AutoCAD jams or a licence or sign-in window shows, the trial stops and leaves it for Tim; nothing is force-closed.

**D-140** (17 Nov 2026, morning; build chat draft 1) Cover less than the minimum, in every window: "Red: Wrong". It never blocks.

**D-141** (17 Nov 2026, morning; build chat draft 2) Office standard drop across a pit (invert in to invert out): "0.02". Can be typed over on a pit (D-084).

**D-142** (17 Nov 2026, morning; build chat draft 3) An ordinary gravity pipe flatter than 1 in 200 is flagged amber: "Yes, flag flatter than 1 in 200". Detention pipes keep their own stepped list (D-134).

**D-143** (17 Nov 2026, morning; build chat draft 4) The grade a new gravity pipe starts with: "Yes, 1 in 100". Can be typed over.

**D-144** (17 Nov 2026, morning; draft 5) A council's own cover figure against the standard's table: "Take the larger of the two". Both are minimums and both apply. (Narrows "council beats AS 3500.3" for cover: a council figure never lowers the standard's minimum.)

**D-145** (17 Nov 2026, morning; draft 6) A detention pipe under a driveway: "The larger: 0.45". Detention is the kind of pipe, the driveway is what is over it; both apply and the larger governs.

**D-146** (17 Nov 2026, morning; draft 7) Cover under paving (the 0.10 and 0.075 figures) is measured from: "Underside of the pavement". Needs a slab thickness as an office standard that can be typed over; the figure is not yet given. The planning chat told Tim it believes AS 3500.3 measures these from the underside but had NOT checked the printed standard: still to be checked.

**D-147** (17 Nov 2026, morning; draft 8) A detention pipe smaller than 225: "1 in 200, flagged amber" (Needs a look: detention pipe smaller than 225).

**D-148** (17 Nov 2026, morning; draft 9) The two council figures not yet entered (one council's junction pit on the council drain; one council's step irons deeper than 0.9 m): "Enter only if the source is on file". With a council document behind it in the reference it goes in showing its source; without one it stays blank.

**D-149** (17 Nov 2026, morning; draft 10) Step irons needed on a pit deeper than 1.0 m shows: "Keep amber: Needs a look". No fourth kind of status.

**D-150** (17 Nov 2026, morning; draft 11) Source word for a standard that has been typed over: "Yes, add 'typed over'". Source words are now: given, measured, chosen, worked out, assumed, standard, typed over.

**D-151** (17 Nov 2026, morning; draft 12) On the 2560 x 1440 screen: "Yes, drawings grow". Cards and text keep a comfortable size; the preview and sketches take the extra room.

**D-152** (17 Nov 2026, morning) Slab thickness for D-146: "By what is over it". A short editable list by what is over the pipe. The planning chat's starting figures (path 0.10, driveway 0.125, crossover 0.15) are its own guesses, NOT Tim's: DRAFT until he corrects them.

**D-153** (17 Nov 2026, morning; settles D-083 and D-118) Detention pipe blue, picked from the sample sheet `pictures\pick_a_detention_blue.html`: "B: dark steel blue, colour 152" (**colour SUPERSEDED the same evening by D-156: option A, colour 160**). Layer name proposed on the same sheet, STORMWATER DETENTION PIPE, linetype DASHED like the ordinary pipe: shown to Tim with the pick and not objected to; not separately ruled. Still unknown: the printed pen width of colour 152 (reference open question Q-103), and the office wording of the legend line and the label. Tim picked from a screen picture, not a real plot.

**D-154** (17 Nov 2026, morning; SUPERSEDES D-123 for the label) Shown what D-123 gives in practice (1 in 75 typed, inverts rounded to two decimals, label prints "1 IN 73"), asked if that is what he wants on the sheet: "Print what I typed: 1 IN 75". The label prints the design grade as typed. The inverts are still rounded to two decimals, so a checker working from the printed inverts may get a slightly different grade.

**D-155** (17 Nov 2026, evening) The grip trial crashed the test AutoCAD (custom grip clicked by the Codex robot; cause not proven), leaving an "AutoCAD Error Report" window on the made-up drawing t2_mouse. Asked what to do with it: "Close it for me" (the option offered: press Close on the error window only, no report sent; if AutoCAD does not go, leave it; no more trials today). Done about 21:25: the error window closed normally; AutoCAD itself stayed open and responding on t2_mouse and was left as it is for Tim. Trials stay stopped. Trial 2: FAIL for the custom grip. Trial 8: PARTIAL. Trial 5: not started.

**D-157** (17 Nov 2026, evening) The test AutoCAD left open after D-155: Tim "close" (a normal close was asked and it did not go in 30 seconds, left as it was), then, told it had not closed and that forcing needs his word under rule 1.9: "force close". Done: that one AutoCAD (t2_mouse, made-up drawing) was ended; no AutoCAD and no error window is running. This word covered that one window only.

**D-158** (18 Nov 2026, just after midnight) Tim: "the plan needs to create the best possible loops for the overall plan. also how long until releases?" The six loops are written in `stage6\LOOPS.md`. Asked whether the build chat may start the AutoCAD part (the foundation, then Pit, then Pipe; nothing installed without his yes): "Yes, start it".

**D-159** (18 Nov 2026) A standing yes for AutoCAD testing: AutoCAD may be started on TEST COPIES every night inside his hours (5:30 pm to 8:30 am weekdays, all weekend) without asking each day; never one of his drawings, never while his own AutoCAD is open: "Yes, every night in my hours". (Replaces the day-by-day yes of D-139 and the "nothing while asleep" of D-137.)

**D-160** (18 Nov 2026) One named exception to rule 1.9: a robot may close (normal close, then force) a TEST AutoCAD that it started itself that night on a test copy when it jams or crashes; never one of Tim's; licence and sign-in windows still stop everything: "Yes, add that exception". Written into `C:\TimOS\RULES.md` rule 1.9 the same night.

**D-161** (18 Nov 2026, 9 am) Testing faster (research R-004). Told that the free gains already cut a full AutoCAD test pass from about 16 minutes to about 2 minutes 20 seconds, and asked what to do with the three options that need him (the no-screen engine, Autodesk's cloud engine, a second machine): "Look into the no-screen engine". The option as offered: the planning chat writes up exactly what it touches for him to approve first; NOTHING IS RUN. The cloud engine and a second machine stay parked.

**D-162** (18 Nov 2026, morning; first verdict on the bench windows, checklist step 16, in part) Tim, after opening the bench: "COLOURS ARENT GREAT LETS GO THROUGH A CREATIVE ENGINEERING COLOUR SCHEME. PIT LOOKS GOOD, PIPE LOOKS GOOD BUT THE RENDERS/PREVIEW NEED TO RENDER CLOSER TO TEH REAL OBJECTS LIKE YOU SHOULD KNOW. SAME WITH ARROW AND TEXT, IT SHOULD LOOK LIKE HOW IT WILL ON SCREEN. LEVELS SHOULD BE CALLED LONG SECTION OR SOMETHING LIKE THAT OR PIPE SECTION. LEVELS LOOKS GOOD. HOW DOES THE INLET KNOW WHERE THE HOUSE WALL IS? I CANT SEE THE OTHER WINDOWS?" So: (1) a Creative Engineering colour scheme is to be gone through with him; (2) Pit and Pipe windows good; previews must show the objects, arrow and text as they will look on screen in AutoCAD; (3) the Levels tool is to be renamed (long section / pipe section; exact word and short name not yet picked); the Levels window itself looks good; (4) a question, answered by the planning chat: the inlet does not know where the wall is, the wall on the bench is made-up scenery; (5) he could not reach Inlet, Tank, Detention or Schedule because the chooser cut their buttons off: a fault, sent to the build chat. Inlet, Tank, Detention and Schedule: not yet seen by him.

**D-163** (18 Nov 2026, morning) Colour scheme: Tim pointed to the office branding folder (the Creative Engineering logo in black and in white, the CE square mark, the brochure). What the planning chat saw there: the brand is black, white and greys only, with wide squared capitals for the name and a plain rounded sans for body text; no brand colour. He then raised the preview: "THE ISSUES I HAVE IS THAT PREVIEWS MIGHT NOT EDIT IN REAL TIME WHEN CHANING STUFF WITHIN THE WINDOW. CAN THE WINDOW UNDERSTAND WHERE IN THE SYSTEM WE ARE AND WHERE ON THE PLAN WE ARE AND SHOW THAT IN THE PREVIEW." Not yet decisions: schemes built from the brand, and a preview that shows the real drawing around the object and where the object sits in the drainage system, are to be drawn for him to pick.

**D-164** (18 Nov 2026, morning) Told the planning chat was drawing a black, white and grey scheme with "no blue anywhere" as one option: "JUST BECAUSE OUR BRAND IS COLOURED THAT WAY DOESNT MEAN WE SHOULDNT FOLLOW UI CONVENTIONS AND USE COLOUR TO DRAW THE EYE". So: the brand gives the base (black, white, grey, the type, the CE mark); colour is used on purpose, by normal UI convention, to draw the eye to the next action, the box in use, what changed, and what is selected. Status keeps its own colours. No colourless option.

**D-165** (18 Nov 2026, morning) Tim: "THE OTHER THING TO CONSIDER IN THE FULL PLAN IS COMPUTER AND PLUGIN SPEED AND SMART, EFFICIENT WAYS TO MAKE PERFORMANCE STRONGER AND BETTER". Speed is now part of the plan: `stage6\PERFORMANCE.md` (time limits per thing a drafter feels, measured every night, over the limit is a fault; smart ways; the PC protected in work hours). The time limits in it are the planning chat's proposals, DRAFT until he rules.

**D-166** (18 Nov 2026, morning; after seeing schemes A, B, C of `pictures\pick_a_ce_scheme.html`) Tim: "THE COLOUR OF THE BUTTONS SHOULD BE COMPLETELY DIFFERENT TO WHAT IS USED ON SCREEN. IN TERMS OF COLOUR SCHEME I THINK WE SHOULD USE A SIMILAR GREY BACKGROUND TO AUTOCAD AND FORGET LIGHT OR DARK JUST DO ONE COLOUR SCHEME". So: ONE colour scheme only, no light and dark versions (this replaces "dark or light all through" in the UI plan, D-070); the window background is a grey like AutoCAD's own; the button and highlight colour must be clearly different from every colour used in the drawing on screen. None of A, B or C is picked. Which accent: to be picked from a second sheet. He did not answer on the new preview (plan, locator, system strip).

**D-168** (18 Nov 2026, late morning) The accent colour, picked from the second sheet `pictures\pick_a_ce_scheme_2.html` (one scheme on AutoCAD's own greys; three accents measured to be unlike any colour in the drawing: A violet, B rose, C lime; the planning chat recommended A): "B, ROSE". Rose #FF70B3 with dark text on it. The full values are at the end of `design\UI_PLAN.md`. This settles the colour part of D-162, D-164 and D-166.

**D-169** (18 Nov 2026, late morning; the rest of his verdict on the bench windows, checklist step 16) Tim: "INLET, TANK (SHORT COMMAND SHOULD BE WT),  DETENTION (SO WE HAVE THE DATABASE THAT IS SCALABLE AND CAN BE BUILT ON BUT WITH THE CALCULATIONS HOW CAN WE USE EVERYTHING IN THE WHOLE SYSTEM TO REDUCE THE AMOUNT OF MANUAL CALCULATIONS AND HOW WE CAN REDUCE TH EAMOUNT OF INPUT NEEDED FROM END USER - SUCH AS HEAD AND ORIFICE AS AN EXAMPLE BUT THROUGHOUT THE ENTIRE PLUGIN) LOOK GOOD. PIT SCHEDULE IS GOOD BUT THE COLUMNS SQUARE WONT WORK AND IS NOT NECESSARY FOR US AS THE BLOCK OF OUR CURRENT PIT SCHEDULE WONT REDUCE DOWN TO SUIT AND NOR DO WE NEED IT TO AND THE ON SHEET STUFF ABOUT SCALE IS SOMETHING WE USE ONCE A YEAR AT MOST, IM HAPPY TO BE PROVEN OTHERWISE". So: (1) Inlet, Tank and Detention windows look good; (2) the Tank short name is WT, not TK (changes D-101); (3) Pit schedule window good, but the Columns card comes out (the office schedule block does not drop columns and does not need to) and the on-sheet scale choice comes out of the window (used once a year at most; he is open to being shown otherwise); (4) a design instruction for the whole plug-in: use everything the system already knows to cut manual calculations and to cut what the user must type, head and orifice being his example. With D-162 this completes his first verdict on all seven windows: all seven "good" or "looks good", with the changes recorded in D-162 to D-169.

**D-170** (18 Nov 2026, late morning) Told that WT is already in his own alias list as "Wall-t" and asked which should have it: "TANK IS WT FOR WATER TANK". The Tank tool is TANK / WT (replaces TK in D-101). What happens to his "Wall-t" alias: he did not say; it stays his to move. The plug-in does not edit his alias file.

**D-171** (18 Nov 2026, midday; the input audit `design\INPUT_AUDIT.md`: 85 figures typed today on a two-unit job, 20 possible, 31 if the drawing cannot be read) Asked whether to go ahead with the five changes (1 numbers, kinds and office defaults fill themselves; 2 one fact held in one place; 3 head, orifice and pit size worked out; 4 one Job window typed once per job; 5 read the drawing: downpipe joins, hatched roof and paving, the boundary, then cover levels): "YES ALL FIVE IN THAT ORDER, THE THING WITH CONTEXT AND REAL WORLD EXAMPLES WHEN WORKING THROUGH IT WITH ME". So: all five, in that order; and when the planning chat works a design question through with him it gives the context and a real-world example each time.

**D-172** (18 Nov 2026, midday) Orifice pit: is the top of the baffle (plate) always at the top water level of the storage: "Yes, baffle top = top water level". So plate height = top water level less the orifice invert; head = that less half the orifice; neither is typed.

**D-173** (18 Nov 2026, midday) Orifice size put on the drawing: "Round down to a whole mm" (never over the permitted discharge).

**D-174** (18 Nov 2026, midday) The size a new pipe opens at: "100 everywhere" (can always be changed; a council figure would raise it).

**D-175** (18 Nov 2026, midday; a fact about practice and a question, not yet a design ruling) Asked four questions about working things out from the system (how the top water level is chosen, where the orifice pit sits, tank re-use against detention, cover levels off the drawing), Tim answered instead: "BECAUSE WERE DESIGNING AS WERE DRAWING SOMETIMES WERE DRAWING PIPES THAT ARENT PART OF A SYSTEM YET SO HOW WILL WE HANDLE THESE THINGS". So: the office designs while it draws, and pipes are often drawn before they belong to a run or reach an outlet. The plug-in must work with loose pipes and pits. The four questions were NOT answered and are not to be re-asked in the same form.

**D-176** (18 Nov 2026, midday) The planning chat's proposal for loose pipes (a loose pipe is allowed and is not an error; what it cannot know reads "not known yet", never a guess; it shows quietly as "not joined yet" in grey; when its end is brought to a pit or pipe it joins and what can be worked out is, with "What else changes" saying what filled in; the system strip says it is a loose run not yet connected to an outlet; head, orifice, storage and flows run only on a run that reaches the outlet and otherwise say what is missing; one list of what is not joined yet), asked "quiet" or "louder": "THATS RIGHT, YOU NEED TO THINK ABOUT THESE THINGS BEFORE CREATING THE PLUGIN. THERE WILL BE OTHER USER EXPERIENCE THINGS THAT POP UP THAT NEED THE SAME KIND OF ATTENTION". So: the loose-pipe behaviour is approved as proposed (quiet); and the planning chat is to find the other real-use situations of this kind before the tools are built, not after. A walk-through of real use is being written to `design\SITUATIONS.md`.

**D-177** (18 Nov 2026, early afternoon; `design\SITUATIONS.md` question 1) How an assumed figure prints on the sheet (example: the council pit invert 4.95 assumed before the council letter arrives): "APPROX. in front, plus one standing note". It prints "APPROX. IL 4.95"; one note on the sheet says figures marked APPROX. are assumed and to be confirmed; when confirmed, APPROX. goes. The note's exact wording: not yet given.

**D-178** (18 Nov 2026; question 2) How a figure not known yet prints (example: a pit placed with no cover level): "TBC - BUT FOR YOUR REFERENCE THE SURVEY DOES NOT GUIDE THE COVER LEVE, THESE ARE OFTEN PRE DEMOLITION SURVEYS AND THE LEVELS WILL CHANGE SIGNIFICANTLY PRIOR TO INSTALLATION OF PITS. COVER LEVEL IS DETERMINED TYPICALLY BY INTERNAL HOUSE LEVELS AND SURROUNDING NEW AND OLD PAVEMENTS LEVELS THIS IS DONE TYPICALLY BY ENGINEER". So: not known prints "TBC". And a fact about practice that corrects the planning chat: a pit's cover level does NOT come from the survey (surveys are often pre-demolition and levels change a lot before the pits go in); the engineer sets it from the internal house levels and the surrounding new and old pavement levels. The plug-in must not offer or read a survey level as a cover level. This corrects `design\INPUT_AUDIT.md` change 5 ("cover levels last" read off the drawing) and the question the planning chat asked earlier about the nearest level text.

**D-179** (18 Nov 2026; question 3) Copying one unit's drainage to the mirror unit: "Sizes and grades yes; levels marked assumed". Pit size, kind, pipe size and grade copy as they are; levels copy but are marked assumed (copied from the pit they came from) until confirmed or changed; copies take the next free numbers.

**D-180** (18 Nov 2026; question 4) The same drawing on another PC or after the office list changes: "The drawing keeps what it was designed with". The drawing remembers its own standard values; on opening, one line says what has changed in the office list and offers to switch; nothing changes unless a person says so.

**D-181** (18 Nov 2026, early afternoon; `design\SITUATIONS.md` question 7 in that file, asked as 5 of 18) A pit moved with plain MOVE, its number tag and cover level text: "THEY GO WITH THE PIT AND A HAND MOVED LABEL KEEPS ITS OFFSET FROM PIT IN BOTH DIRECTIONS AND MOVES WITH IT MAINTAINING THE SAME OFFSET".

**D-182** (18 Nov 2026; asked as 6 of 18) A pipe label typed over by hand, then the pipe changes: "Keep my wording, flag it, one click to follow again". Same as a typed-over schedule cell (D-103): the wording stays, it goes on the unfinished list as no longer matching, one click lets it follow the pipe again.

**D-183** (18 Nov 2026; asked as 7 of 18) Two separate systems on one site, pit numbers: "One series, street system first". No pit number is used twice on a sheet; each system is numbered from its own outlet, the street outlet first.

**D-184** (18 Nov 2026; asked as 8 of 18) A pit added mid-run after the sheet has been issued (the three ways offered: the next free number such as P13; a letter such as P3A; renumber everything): "OPTION TO DO ALL 3". The drafter chooses each time among the three. Which one is offered first: not said.

**D-185** (18 Nov 2026, early afternoon; asked as 9 of 18) Retyping a pit tag (P3 retyped as P7): "Yes, it renames the pit". The schedule row, pipe names and system strip follow; a duplicate number shows amber on both. Levels and grades are never changed by editing their text.

**D-186** (18 Nov 2026; asked as 10 of 18) Placing many of the same thing (12 downpipes): "Keep clicking, Enter to finish". One window, then pick after pick, each numbered in turn.

**D-187** (18 Nov 2026; asked as 11 of 18) A "changed since last issue" list with a "Mark as issued" button: "Yes, but later". Not in the first release.

**D-188** (18 Nov 2026; asked as 12 of 18) Plotting with open items (assumed, not joined): "One quiet line, never a stop". One command-line line with the count; plotting carries on.

**D-189** (18 Nov 2026, early afternoon; asked as 13 of 18) Pipes with bends in the first release: "Bends on every kind of pipe". Any pipe, gravity included, can be drawn with bends; the inspection opening offer at a bend stands (D-079 area).

**D-190** (18 Nov 2026; asked as 14 of 18) Existing pipes and pits: "The council pit you connect to; the rest by hand". An existing council pit or kerb outlet that the new system connects into is a proper outlet a run can reach; other existing drains stay hand-drawn in the first release.

**D-191** (18 Nov 2026; asked as 15 of 18; a fact about practice) How drafters start a new job: "From the office template". A clean start each time. The plug-in still treats job facts found in a copied drawing as assumed until confirmed, but that case is rare.

**D-192** (18 Nov 2026; asked as 16 of 18) A plain line on a stormwater layer drawn by someone with no plug-in: "One line on opening, with a 'take it up' click". Never automatic.

**D-193** (18 Nov 2026, early afternoon; asked as 17 of 18; a fact about the office) Screens: "Some laptops are used for drafting". So the windows must also fit a laptop screen and Windows scaling above 100%: on a small screen the cards go into tabs so nothing is cut off and nothing scrolls. The actual laptop resolutions and scaling: not yet known.

**D-194** (18 Nov 2026; asked as 18 of 18; a fact about practice) Plan scale: "PLANS ARE DRAWN AT 1:1 AND THEN THE PAPER LAYOUT SCALES THEM TO 1:100". The model is drawn full size; the layout viewport sets 1:100. So text and label sizes in the model are sized for a 1:100 viewport, and the scale belongs to the layout, not to the plan. (With D-169: other scales are the once-a-year case.)

**D-195** (18 Nov 2026) Whether the plug-in may help the engineer set a pit's cover level (after D-178: cover levels come from the house and pavement levels, set by the engineer, never the survey), offered as: no help; click two trusted levels and work between them; or click one level and type a fall: "HELP IS A SUGGESTION, ENGINEER GETS FINAL SAY". So help may be offered, only ever as a suggestion marked as such, and the engineer's figure always wins. Which form the help takes: not picked; both forms may be designed and shown to him.

**D-196** (18 Nov 2026, afternoon; settles the rename of D-162) The tool that was "Levels along a run" (LEVELS / LV): "LONGSECTION, short LG". Checked free in AutoCAD's own short names and in Tim's alias list (LS, PS and SEC were not).

**D-197** (18 Nov 2026, afternoon) The office Stormwater Pit block for the night tests (offered: he saves one pit as pit_seed.dwg himself, or says "copy the template" and the night run takes a COPY of the office drawing template and places the block itself; nothing of the office's is changed): "COPY THE TEMPLATE". The copy goes under `C:\CE_WORK\civil_tests\`; the office template folder is read only.

**D-198** (18 Nov 2026, afternoon) The build chat started a side chat, "Interview Tim: Tools, Manager and shared structural commands". Asked whether he had asked for it: "YES I ASKED FOR IT BUT CAN YOU PLACE IT UNDER YOUR PERVUE?" So: the interview is wanted, and it reports to the planning chat. It is planning only (Tools, Manager and structural are not in the first release); its answers go to `interview_tools\ANSWERS.md` as T-numbers in his words; the planning chat folds what matters into this file and the plan.

**D-199** (18 Nov 2026, about midday; a fault report in his working AutoCAD with the OLD plug-ins installed, and an instruction for the new one) Tim, with a screenshot of a selected hatch: "HATCHES ARENT WORKING HOW THEY NATIVELY USED TO WITH THE LATEST UPDATE? SEE HOW I CANT SELECT SOME EDGES, ALSO WHEN I RECREATE BOUNDARY IT CREATES INDIVIDUAL POLYLINES AS OPPOSED TO JOINED ONES. THIS IS SOMETHING WITH THE GRIP ISSUES. NEED TO DO SOME RESEARCH OR TESTING ON HOW THIS WORKS BEFORE IMPLEMENTING. GRIP POINTS WERE SOMEWHAT WORKING IN OLDER VERSION OF THE PLUGIN BUT MY INTENTION WAS FOR THEM TO HAVE DIFFERENT GRIP ICONS IF THIS IS POSSIBLE". So: (1) native hatch grips and "recreate boundary" are misbehaving in his AutoCAD; cause not known (the old plug-in's grip code, or AutoCAD itself: "the latest update" was not said to be which); (2) grips are to be researched and tested before they are built in the new plug-in; (3) his intention for the new plug-in: CE objects show different grip icons, if possible; (4) the new plug-in must never change how native objects behave. Research is being written to `reference\research\R-006_HATCH_AND_GRIPS.md`. The fault in the installed plug-in also belongs in `C:\CE_PLAN\BUG_CARPARK.md` (outside this chat's folder; flagged to Tim).

## From the Tools and Manager interview, 18 Nov 2026 (side chat under the planning chat, D-198; full record with his answers A-01 to A-17 in `design\TOOLS_AND_MANAGER_INTERVIEW.md`)

**D-200** (18 Nov 2026; interview A-16; CHANGES D-051) Where the tools sit on the ribbon: "WE SHOULD HAVE THREE TABS CE CIVIL, CE TOOLS&MANAGER  & CE STRUCTURAL (BETTER NAMES FOR ALL)". Three tabs, with better names still to be proposed. The light tab on selection of D-051 was not withdrawn. This replaces the "one short CE Civil tab" part of D-051.

**D-201** (18 Nov 2026; interview A-15 and A-14; ADDS to the first release, D-097 to D-100) The shared everyday tools: first in importance "CLEAN (save + tidy)"; the rest: "JUST DO THEM IN ANY ORDER AND RELEASE THEM ALL IN THE FIRST ISSUE RELEASE". So the shared tools (ST-01 to ST-10 in the interview file: CLEAN as one save-and-tidy tool; dims and leaders with a new arc dimension; MR and CR; CPB; DIV; one hatch window; REVBOX; break line; construction joint and sawcut; a blocks palette) are now in the first release, with CLEAN first. Structural-only tools stay parked (D-006). The planning chat notes: this lengthens the first release; D-091 (one tool at a time) still governs the order of building.

**D-202** (18 Nov 2026; interview A-02; a rule for every shared tool) "NEED TO GO THROUGH EACH COMMAND, THINK, HOW CAN THIS BE BUILT BETTER, HOW CAN THIS BE PART OF THE OVERALL CODE IN A BETTER WYA, HOW CAN WE USE THIS IN A DATABSE, SCALABILITY AND BUILD UPON THIS. ALSO WE NEED TO LOOK AT THESE COMMANDS AND MAKE SURE THEY WORK AS I INTENDED AND CAN WE MAKE IT BETTER OR MORE ORGANISED".

**D-203** (18 Nov 2026; interview A-05, A-08, A-09; names) C, the repeat copy: "Retire it, use Copy". The revision cloud: "REVBOX / RV". Slab joints: "CAN WE USE CJ / CONSTRUCTIONJOINT AND SSC / SAWCUT. ALSO THEY DONT WORK PERFECTLY AT THE MOMENT TEXT DOESNT GET PLACED HOW I WANT IT TO BE AND THERES NOTHING TO HELP THIS PROCESS OR LEARN FROM HOW AND WHERE THEY ARE PLACED". (Settles D-054's "rename C and RC". None of these short names has yet been checked against AutoCAD 2027's own list; Q, DIV, CH and BL clash with his alias list.)

**D-204** (18 Nov 2026; interview A-07, A-11 to A-13; CLEAN and the Manager) CLEAN: "Should be one tool", and "I USE THIS COMMAND VERY OFTEN AS THE MAIN TOOL FOR SAVING THE DRAWING SO WE NEED TO WORK OUT HOW THIS WORKS AND CAN BE REPLICATED QUICKLY AND OFTEN". The Manager does: updates and version, health and fault report, office lists, job link; no drawing tools; "I WANT THE ADMIN DASHBOARD BUT IS THERE A BETTER WAY FOR A SMALL PROGRAM LIKE THIS?", answered by him as "One admin page" only he sees.

**D-205** (18 Nov 2026; interview A-17; a standing rule and future ideas) "ALSO I WANT TO BUILD STATISTICS, ADMIN CONTROL AND A BETTER OVCERALL SYSTEM THIS CAN COME LATER BUT ADD TO FUTURE IDEAS. PLEASE MAKE SURE WE ALWAYS HAVE REVISION NUMBERS, ID NUMBERS FOR ALL BUGS, IDEAS AND ANYTHING ELSE". So: every bug, idea and other item in the plan's files carries an ID number that is never reused, and documents carry a revision number. Statistics, admin control and a better overall system are future ideas, not first release. He also pointed to the office master drawing of typical blocks, layers, schedules and notes in the templates folder: "THIS SHOULD HAVE BLOCKS, HATCHES AND MORE".

**D-206** (18 Nov 2026, midday) The hatch fault of D-199 added to the bug carpark: "ADD IT." Done as BUG-1461. And on the carpark itself: "BUT WE HAVE OVER 1200 BUGS AND MILLIONS OF IDEAS ON THE CARPARK I FEEL IT WOULD BE IMPOSSIBLE TO RESOLVE ALL OF THIS HENCE THE NEW PLAN. WHATS YOUR THOUHGTS?" The planning chat's proposal (freeze the carpark as the old plug-in's list; fix there only what stops daily work; sort every open bug once, read-only, into: would happen again in the new design and so becomes a test; dies with the old build; out of scope for now; stops daily work now; not a product bug; the new plug-in starts with an empty short list; the ideas inbox sorted the same way later): "RUN THE SWEEP". Counted that day: 1,410 bug entries, 1,295 open or in progress. Nothing in the carpark is changed, closed or deleted by the sweep. The freeze and the ideas sort were proposed with it; he approved the sweep, and did not rule separately on those two.

**D-207** (18 Nov 2026, 12:15 pm) After the sweep result (`reference\research\R-007_BUG_SWEEP.md`: 597 would happen again, 256 die with the old build, 399 outside the first release, 15 stop work now, 28 not bugs), asked whether to check the two wrong-figure bugs BUG-866 and BUG-1095 against the installed plug-in, read-only: "CHECK THEM, autocad is closed now you can do whatever you need for at least the next hour, i can continue using the computer yes?" So: the two bugs are being checked read-only; and AutoCAD is free for testing from 12:15 pm for at least an hour, this once, on test copies (the run planned for tonight is brought forward).

## From the Tools interview, batches 10 to 16, 18 Nov 2026 (his answers TA-018 to TA-042 in `interview_tools\ANSWERS.md`; design file `design\TOOLS_AND_MANAGER_INTERVIEW.md` revision 2)

**D-208** (18 Nov 2026; names; the exact answers are TA-018 onward) The three ribbon tabs are named CE Civil, CE Tools and CE Structural, with the structural tab hidden until it has tools (settles the "better names" of D-200). CLEAN / CN. The quick leader is QL and he keeps his own Q alias. BREAKLINE / BL, on which he said "I WILL CHNAGE ALIASES" (BL is his alias for Block today). BLOCKS / BLK for the blocks palette. REVBOX keeps its object-snap question.

**D-209** (18 Nov 2026; TA-026, TA-027; ADDS to the first release under D-201) "WE HAVE THE OPPORTUNINITY NOW TO UPGRADE, IMPROVE AND ADD EXTRA FUNCTIONALITY TO ALL OF THESE COMMANDS RIGHT NOW, CAN YOU INTERVIEW ME ABOUT THIS ALSO BEFORE BUILDING. ALSO WE HAVE MISSED TEXT COMMANDS AND OTHER THINGS LIKE THAT", then "ARE THERE ANY OTHER COMMANDS THAT CAN BE ADDED TO TOOLS". He ticked eight more shared tools, ST-11 to ST-18: the text 25/18 set kept plus a TEXT window; pen quick-set; xref copy and paste; new: put on the office layer; new: viewport scale set and lock; new: find and replace; new: live area and length labels; small office symbols from the palette. The planning chat reads these as joining the first release under D-201 ("release them all in the first issue release"); Tim has not been asked that in so many words. Every shared tool is to be interviewed for upgrades before it is built.

**D-210** (18 Nov 2026; upgrades he asked for, details in the interview file) CLEAN also audits, zeroes Z and sets units. Dimensions follow the viewport, and "it only works on creation it doesnt update already created dims": existing dimensions must update too. Divide follows bends, shows a visible cross, a preview and spacing text. Joints: dashes right at 1:100, bends, a full-word label placed like the 25T / 25B text. REVBOX clouds any shape. BREAKLINE trims. MR, CR and CPB unchanged.

**D-211** (18 Nov 2026; the office blocks) On the 453 blocks in the office master drawing (279 with machine-made names): "you need to look throught hem all see what they are and then we can decide and order and organise them all" and "we might not need all blocks". A read-only look through all of them on a copy, saying what each is and proposing an order, is assigned to the interview chat.

**D-212** (18 Nov 2026, about 12:45 pm) After the two wrong-figure bugs were reported back (`reference\research\R-008_TWO_WRONG_FIGURE_BUGS.md`: BUG-866 real and not fixed in the installed build; BUG-1095 real in older builds, fixed since Civil 3.0.87; the new plug-in's data would repeat both), Tim: "how can we reduce the number of bugs again, is there a way to rewrite areas of the code to be better optimised, better aligned and reusing the same code without removing any functionality. what can we do to rebuild the foundation ,databse and overall code to be scalable and also have the ability to be built upon. in terms of uatocad you can run a test now until 5:30pm with my approval". So: (1) a question to the planning chat about cutting bugs by better-shared, better-aligned code without losing functionality, and a scalable foundation; (2) AutoCAD may be used for tests today until 5:30 pm, on test copies, with his approval given here. Today only.

**D-213** (18 Nov 2026, about 1 pm) The planning chat's answer to D-212's question (fewer places for a mistake to live: one shared part for every job every tool does; rules as lines in a list; one fact held once; the recurring lessons of the bug sweep as a standing obstacle course every tool must pass; speed and "native AutoCAD untouched" as tests; no rewriting of the old plug-in beyond what stops work or puts a wrong figure on a sheet), and the offer of a function map (every command the office has today, one line each: goes to a new tool, folded in, parked, proposed to retire, or not decided) and the obstacle course written up for approval: "yes, write both". Being written to `design\FUNCTION_MAP.md` and `stage6\OBSTACLE_COURSE.md`. Neither is approved until he has read it.

**D-214** (18 Nov 2026, early afternoon; tools interview TA-043 to TA-046) Asked once, with the cost, whether all 18 shared tools come before colleagues get anything: "all 18 but we need to make sure they all work and are tested before release. a lot of it already works and has been tested so it shouldnt take as long". This confirms D-201 and D-209 in his own words. The hatch tool is OFFICEHATCH / OH; every hatch it makes is linked to its outline (associative). On which hatches it offers: "give me a list of strucutral and civil hatches and then a visual and i will tick off" (the tick list HT-01 to HT-58 has been sent to him; his ticks are still to come). The office blocks have been looked through read-only (`design\BLOCKS_REVIEW.md`, BK-001 to BK-453); nothing in it is decided; its first question for Tim is which block is the office pit, "Stormwater Pit" or "PIT BLOCK 3".

**D-215** (18 Nov 2026, early afternoon) Which block is the office pit: "pit block 3 i made it because it doesnt use as many visibilities instead it uses stretching, do your research and see what you like to use and if i can make things easier or better for the plugin / you". So: PIT BLOCK 3 is his own newer design (fewer visibility states, size by stretching) and is the one he means; he asks for a recommendation on which to use and what he could change in the block to make it easier for the plug-in. Research being written to `reference\research\R-009_PIT_BLOCK.md`. Not yet a ruling on which block the new Pit tool uses. (The midday AutoCAD run tested against "Stormwater Pit", the 16-state block in the A1 template.)

**D-167** (18 Nov 2026, morning) The new preview, as drawn on `pictures\pick_a_ce_scheme.html` (the drawing as AutoCAD shows it, from the office layers, colours, text and arrow; "where on the plan" as a small site locator in the corner; "where in the system" as a strip under the preview with the run as a chain and this object lit; the thing being changed highlighted the same way in all three): "YES THE PREVIEW IS WHAT I MEANT". It applies to every window (D-070: consistent across all windows). Not yet proven: how the locator is produced inside AutoCAD. The drawn details not taken from a real sheet (pit inner wall line, pit tag circle, which side the flow arrow sits) are still to be checked against how the office draws.

**D-156** (17 Nov 2026, evening; SUPERSEDES the colour in D-153) Tim, after seeing the sample sheet again: "lets go with a for the detention". Read by the planning chat as option A on `pictures\pick_a_detention_blue.html`: deeper blue, AutoCAD colour 160. Layer STORMWATER DETENTION PIPE and DASHED unchanged. Pen width, legend and label wording still unknown; still not seen on a real plot.

**Open after this sitting (asked once on 16 Nov, Tim sent D-079 instead of answering; not to be re-asked in the same form):** where a pipe stops at a pit (gap check Pit item 1); whether a schedule cell can be typed over (item 3); which pit kinds are in the first release and whether a turned pit is in the window (item 9); which pits count as storage (item 10).

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
