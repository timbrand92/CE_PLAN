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
