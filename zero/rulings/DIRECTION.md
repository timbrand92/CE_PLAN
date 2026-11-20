# Current rulings: Direction and scope of the whole plan

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Why and how far

1. **Plan from zero:** the plan starts from a blank page and the existing plug-in is a parts bin, with user experience and the interface as a main focus (D-001).
2. **The aim:** the plug-in's database understands the whole system so the user can "type it once and everything is carried throughout and logical" (D-002).
3. **Disagreeing sources:** a disagreement is never allowed to stand; the user selects the correct number or gives a short note to justify it (D-003).
4. **Simpler than the old plan:** take what is good from the old plan and mix it with a full understanding of the drafting and engineering, without over-complicating (D-004).
5. **End goal:** "ultimately my plan is to support all job types and situations", and the chat must lead Tim through with full understanding (D-005).
6. **Scope now:** civil, CE tools and the Manager; structural joins only "once everything is working" (D-006, R-67). **Narrowed for now by D-337 and D-338 (19 Nov):** one release for one real job with detention; CE tools, the Manager and the rest are paused in P-09, not cancelled (item 26).
7. **Rethink from the core:** how the plug-in is distributed, installed and structured is rethought from the very core (D-007).
8. **AutoCAD 2027 only** (D-008, R-66).
9. **Strict rule:** "ALWAYS BUILD FOR SCALABILITY AND ABILITY TO BE BUILT UPON" (D-009, R-65).
10. **Client drawings for planning:** client drawings may be read for planning; client details never go into any saved file (D-010).

### How the design is approached

11. **Foundation first:** the plug-in is designed from its foundation (one set of building blocks) before more windows and details, and detail tangents stop (D-086, which accepted Tim's concern in D-085).
12. **Cut typing and sums everywhere:** use everything the system already knows to cut manual calculations and what the user must type, across the whole plug-in (D-169 item 4), carried out as five changes in a fixed order (D-171; detail on the FOUNDATION page).
13. **Real use thought through first:** real-use situations such as loose pipes are found and settled before tools are built, not after (D-176).
14. **What a concept must show:** how an end user interacts with it, how the whole process works, how it is easier, and where the database and foundation work better than before (D-035).
15. **Every element covered before progress:** source blocks, tanks and every other element of the system are covered before progressing (D-036).
16. **Every situation thought through:** for example a pipe placed anywhere, or a charged pipe from a downpipe to a water tank only (D-038).
17. **Design principles from D-049:** screens are never a mass of lines, tables and numbers; every tool is explained as how you do it, starting from how it is done today; what a regular AutoCAD user finds intuitive is the core foundation and the plug-in must not interfere much with today's way of working; nothing depends on a hidden action such as a right-click; nothing is removed just to have fewer things (D-049).
18. **Nothing optional is forced:** for example a slab never requires saw cuts (D-050).
19. **The direction of the concept is right, but it is not approved:** "EVERYTHING LOOKS RIGHT BUT I MIGHT HAVE MISSED SOME STUFF" is not the formal approve of R-15, and the chat must hunt for what was missed itself (D-042, qualified by D-044).
20. **Windows on the foundation:** "thats better, i cant give you full answer until using but were on the right track" (D-087).
21. **Speed is part of the plan** (D-165; detail on HOW_WE_WORK).

### Added 18 Nov 2026, D-230 to D-297

22. **The easiest, most AutoCAD-like way to use the plug-in, worked out from the old jobs (D-230):** Tim: "now you have this all understood, what is the best and easiest way to make the plugin for an end user experience that is easy and autocad like in how it can used. do you get what i mean. also use old projects data and evidence to form your decisions." The planning chat works it out from the old jobs' drawings and the usage records and brings it as a proposal (`design\EASY_AND_AUTOCAD_LIKE.md`; old-job copies read only, counts only, no job names); the answers it produced are D-234 to D-239.
23. **Few tools, each a window, with the old scattered commands folded inside (D-246):** Tim: "THERES TOO MANY COMMANDS THAT SHOULD BE CONSOLIDATED INTO A WINDOW OR A TOOL THAT ARE STREWN EVERYWHERE EBCAUSE THEY WERE ALL BUILT AT DIFFERENT TIMES, THIS PLUGIN SHOULD BE SCALABLE AND SHOULD BE ABLE TO BE BUILT UPON AND IT WE NEED TO PLAN HOW ALL THE EXISTING STUFF WILL WORK FOR AN END USER." He is not using the old rainfall, design and calculation commands (see OLD_PLUGIN).
24. **Every screen matches his 31 screen design rules and the approved window style (D-286, D-295):** see SCREENS_AND_STYLE.
25. **Missed messages are put in front of him again (D-230):** the planning chat makes sure anything he may have missed in the day's messages is put in front of him again (see CHAT_AND_TIM).

### Added 20 Nov 2026, D-298 to D-383

26. **One release for one job, the rest paused (D-337, D-338, D-347):** "lets focus on a release for everything needed for one job, pause the rest for now and table it under future planning or the carpark and make sure we get back to it later"; the first job is "A job with detention"; the release is staged ("stage it"). Detail on FIRST_RELEASE.
27. **Every specific down to a tee (D-359):** "i need every specific down to a tee before we complete this first stage"; and (D-353) "ideally i want to just keep getting interviewed on the plan and how things work so you dont have any unknowns at all. i want to get this right". Tim's room interviews him down a list of unknowns (see ROOMS_AND_HELPERS).
28. **Keep it simple but record everything (TR-026, filed with D-376 and settled by D-377 item 1):** "keep it simple but record everything so ... everything is scalable and can be built upon" (D-009 carried into the pipe kinds: every kind a data row from the start).

## Changed along the way

1. **"One big element" (D-011, 16 Nov) was replaced the same day by D-031:** a pipe and its two pits work together but are not one element.
2. **"Keep today's typed names" in the concept was replaced by D-049 item 4 (16 Nov):** names are refreshed on one strategy (see RIBBON_AND_NAMES).
3. **"Everything looks right" (D-042, 16 Nov) was qualified by D-044 the same day:** the command names and ribbon were not accepted.
4. **Windows mocked up to work in one direction only (16 Nov) were replaced by the foundation of D-086 the same evening:** hold what is fixed, the rest is worked out.
5. **Scope "civil, CE tools and the Manager now" (D-006) was narrowed for now to one release for one job (D-337, D-338, 19 Nov);** the rest is paused in P-09.

## Still open on this subject

1. **Full acceptance of the design:** Tim gives a full answer only after using it for real (D-087, D-042). Waits on: Tim.
2. **Tim's question on UI and automation:** the draft answer, `pictures\new_plugin_ui_and_automation.html` and CONCEPT.md section 11, were "drafts until Tim rules" and were never ruled; much is overtaken by D-051 to D-070 (D-043). Waits on: the planning chat (to mark superseded or put back).
3. **How existing projects are taken up:** D-049 item 7 reopened D-027; D-191 (new jobs start from the template) and D-119 (make-ordinary tool later) answer part, and the rest is not designed (see JOB_AND_OFFICE). Waits on: the planning chat.
4. **How a slab is added and how edits such as size changes are handled must be shown (D-049 item 8):** size changes are covered by the foundation, but the slab group's fate is "park" only as a FUNCTION_MAP recommendation (FM-053), not ruled. Waits on: Tim.
5. **How many layers of the old evidence model are needed:** PARKING_LOT P-02, open since 16 Nov. Waits on: the planning chat.
6. **Structural:** parked; four structural questions put on 16 Nov were never answered (PARKING_LOT P-05). Waits on: Tim (later).
7. **Coverage proof under R-69:** no plan or stage is complete until everything that exists today has a decided fate and coverage is stated as "N of M"; the function map shows 67 names with no decided fate (D-220, R-69). Waits on: the planning chat.
8. **The function plan re-read against "few tools, each a window" (D-246):** `design\FUNCTION_PLAN.md` proposes 31 tools and gives every old command a fate; it is to be shown as the drafter's picture, with the artifact page of D-281 showing where each old calculation command lands. Waits on: the planning chat.

9. **The paused work in P-09 is brought back to him unprompted** once the one-job release has carried one real job (D-337). Waits on: the planning chat (later).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-337, D-338, D-347, D-353, D-359, D-377; `PARKING_LOT.md` P-09; `stage6\ONE_JOB_RELEASE.md`.

Added 18 Nov 2026: `DECISIONS.md` D-230, D-234 to D-239, D-246, D-281, D-286, D-295; `design\EASY_AND_AUTOCAD_LIKE.md`; `design\FUNCTION_PLAN.md`.

1. `DECISIONS.md`, sections "Direction" and "The one element".
2. `RULES.md` R-65 to R-71.
3. `design\FOUNDATION.md`; `design\CONCEPT.md` (history); `design\CONCEPT_GAP_CHECK.md`.
4. `stage6\THE_PLAN.md` sections 1 and 2.
