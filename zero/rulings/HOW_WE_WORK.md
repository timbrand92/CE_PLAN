# Current rulings: How we work (built, tested, installed, accepted; the gate; loops; speed; testing that learns)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Done is four facts

1. **Built, tested, installed and accepted are four separate facts,** never merged (R-18; HOW_WE_WORK).
2. **Who accepts a tool: "Me, or a robot pass if I am busy"** (D-089, settling PARKING_LOT P-01).
3. **A loop never calls its own work accepted; the builder never tests its own work; the tester never fixes** (LOOPS section 2, under D-158).

### Pace and order

4. **One tool at a time, each finished before the next** (D-091). **For the one-job release, replaced by two stages (D-347, 20 Nov):** Stage 1 Pit, Pipe, drawing safety, cover and grade checks; Stage 2 the rest of the nine parts, once he has drafted with Stage 1 (see FIRST_RELEASE).
5. **Never start anything new while a tool on the ribbon is broken** (D-090).
6. **Every shared tool must work and be tested before release** (D-214).

### The gate

7. **The obstacle course is the gate every tool must go through:** "yes this is the gate" (D-216), written as 27 tests with every one of the 597 recurring old bugs behind one of them (D-213). **How a fix reaches the main line is now the merge gate of D-346 (19 Nov; planning chat's call, Tim's to overturn):** see MERGE_GATE.
8. **Testing learns:** every fault found by a test or a person becomes a new check; every run records its time, counts and what it caught; slow checks are sped up; the trend shows in the director's summary; this is learning by record and rule, not a trained model (D-225, R-70).

### Loops and keeping things moving

9. **The six loops** (tool, AutoCAD night, real job, decision, director, keep-moving) are written in `stage6\LOOPS.md` (D-158).
10. **The build chat may start the AutoCAD part** (the foundation, then Pit, then Pipe), with nothing installed without Tim's yes (D-158). **Widened by D-304 and D-306 (18 and 19 Nov):** the chats may install the tools the work needs (D-304), and the planning chat may install the new plug-in into his AutoCAD on its own judgement when the work needs it, saying what it did and how to undo it (D-306); see ROOMS_AND_HELPERS.
11. **While Tim is away, the planning chat keeps things moving:** anything that is Tim's call is taken at the recommended default and marked DRAFT for him (D-137); the bench of seven windows went ahead (D-138).
12. **Building happens in a new private repository of its own,** `C:\CE_CIVIL` with its own private GitHub repository, nothing shared with the old plug-in's repository (D-127).
13. **Side chat for the tools interview reports to the planning chat;** its answers go to `interview_tools\ANSWERS.md` and the planning chat folds what matters into DECISIONS.md (D-198).

### Records

14. **Every bug, idea and other item carries an ID number that is never reused, and documents carry a revision number** (D-205).
15. **Every item lives in exactly one home, and the current ruling on any subject can be read in one place** (R-71; this folder is that place).
16. **The board is built, and Tim manages only what is put to him in chat;** keeping the record, lists, side chats, order of work and follow-ups is the planning chat's job, run without faults (D-226).

### Speed

17. **Speed is part of the plan:** time limits for each thing a drafter feels, measured every night, over the limit is a fault (D-165); the limits themselves are DRAFT. **Taken as built by D-288 DQ-089 to DQ-091 (18 Nov; planning chat's call from his rulings; his to overturn), item 21.**
18. **Testing faster:** the free gains cut a full AutoCAD test pass from about 16 minutes to about 2 minutes 20 seconds; the no-screen engine is to be looked into and written up for approval with nothing run; the cloud engine and a second machine stay parked (D-161).

### Added 18 Nov 2026, D-230 to D-297

19. **A separate checker looks at every screen before Tim does (D-286 rule 31; D-295):** never the chat that built it; once the style is approved a separate checker's look is enough for other windows in that style.
20. **Test result files held a login name, a PC name and folder paths (D-231):** two test result files committed that day to the private CE_CIVIL repository held his Windows login name, PC name and folder paths (no client details, no keys). The working copies were cleaned and a scrubber added; the old copies remain in git history. Asked whether to rewrite history, Tim answered "Leave the history alone". Condition recorded with it: if the repository is ever shared with anyone else, the history is cleaned first.
21. **Build calls on speed and the outside library (D-288; planning chat's call from his rulings; his to overturn):** DQ-089 to DQ-091 the speed limits as built (1 second at start and on opening a 500-object drawing; window open 0.3 s; typing and preview 0.1 s; pit move 0.1 s on 2,500 objects; 5 thousandths of a second on a plain command), as in `stage6\PERFORMANCE.md`; DQ-102 the outside library is allowed in the automatic tests only, read only, never inside the installed plug-in.

### Added 20 Nov 2026, D-298 to D-383

22. **How fixes reach the main line (D-346, added to 20 Nov; planning chat's call, Tim's to overturn):** grouped by root cause, failing tests first, a fix merges on its list green with the whole suite, one honest check and one adversarial pass with no blocker; at most two fix rounds; a proof owed in AutoCAD is not a blocker, "merged" and "proven" are two separate facts. Full text on MERGE_GATE.
23. **No third patch round; a design page first (D-347 method, D-372 item 4; planning chat's and control room's calls):** a cause that has failed two rounds gets a design page first, as copy identity did (D-340), then one build.
24. **Codex abides by the rulings (D-308):** "make sure codex abides by our rules and decisions": every Codex job carries `CODEX_STANDING_BRIEF.md` at the top, names the rulings it touches, is reviewed against them, and is checked by the build chat before merging; a run that breaks a line is thrown away. A Team checker (Opus) reads every Codex result against the rulings (D-329).
25. **Every reply and report starts with "WHERE WE ARE" (D-339, R-72):** see WHERE_WE_ARE.
26. **The 19 budgets as tick sheets (D-328):** "As pictures and tick sheets later today".
27. **Rooms, models and usage (D-302, D-303, D-307, D-329, D-342, D-353, D-360):** see ROOMS_AND_HELPERS.
28. **Night test safety (D-364):** see NIGHT_TEST_SAFETY.

## Changed along the way

1. **"Who accepts" (RULES.md Rulings item 1, P-01, "Not decided" list in DECISIONS.md) was answered by D-089 (16 Nov);** RULES.md still says "Answer: not yet given".
2. **"Only the brain" (D-127) was extended to the window frame and seven bench windows (D-137, D-138), then to the AutoCAD part (D-158).**
3. **"Both reviews must pass with nothing found" was replaced by the merge gate of D-346 (19 Nov; planning chat's call, Tim's to overturn),** which let nothing merge on the night of 19 Nov.
4. **"One tool at a time" (D-091) was replaced for the one-job release by two stages (D-347, 20 Nov).**
5. **"Nothing installed without Tim's yes" (D-158) was widened by D-304 and D-306 (18 and 19 Nov).**

## Still open on this subject

1. **R-71 in RULES.md still reads "not yet approved" for the board,** although D-226 approved it. Waits on: the planning chat.
2. **A plain explanation of how the gate works and "short term suffering for long term gain"** (D-216, OQ-01). Waits on: the planning chat.
3. **OBSTACLE_COURSE OQ-03, keep the 0.1 s limit for moving a pit;** measured 208 ms against 100 ms, one FAULT (OBSTACLE_COURSE). Waits on: Tim.
4. **Time limits in PERFORMANCE section 2 are DRAFT,** including the 5 thousandths of a second idle limit (D-165). Waits on: Tim. D-288 takes them as built, as the planning chat's call; Tim has not ruled on the figures.
5. **Not measured yet:** AutoCAD start with the plug-in, a drawing open on a big real job, a window opening inside AutoCAD, the plug-in beside Tim's other plug-ins (PERFORMANCE section 3). Waits on: a test.
6. **What the robot pass must contain to count as accepted** (HOW_WE_WORK "Not settled" item 3). Waits on: Tim.
7. **The usage budget per tool** (HOW_WE_WORK "Not settled" item 2). Waits on: the planning chat.
8. **HOW_WE_WORK is "not yet approved as a stage"; LOOPS has not been read line by line by Tim** (HOW_WE_WORK status; LOOPS status). Waits on: Tim.
9. **No-screen engine write-up:** R-005 recommends not using it yet and says nothing is needed from Tim today (D-161). Waits on: the planning chat (to close or keep open).
10. **FUNCTION_MAP and OBSTACLE_COURSE are "not approved until he has read it"** (D-213); D-216 settles the obstacle course as the gate, not its content. Waits on: Tim.
11. **Obstacle course starting score:** 3 of 108 full passes, 29 FAIL, 48 NOT TESTED, 12 UNKNOWN, 17 "does not apply" for a reviewer to decide (OBSTACLE_COURSE part E). Waits on: a test.
12. **Proposal that obstacle lines become a night-run list file:** for the build chat only; no new script without Tim's approval (OBSTACLE_COURSE D4; R-29). Waits on: Tim.
13. **RULES.md Rulings item 1 still records "who accepts" as unanswered** although D-089 answered it. Waits on: the planning chat.
14. **Decision loop:** Tim's calls taken at the recommended answer, marked DRAFT, and given to him once a day as one batch of at most 12 (LOOPS loop 4); no batch record yet. Waits on: the planning chat.

15. **The 19 budgets as tick sheets** (D-328). Waits on: the planning chat, then Tim.

**Closed (D-298 to D-383):** what the robot pass must contain is now set by the merge gate for the main line (open item 6 in part, D-346; acceptance in AutoCAD is still Tim's or a robot pass under D-089).

**Closed:** whether the board is approved (closed by D-226, "build the board").

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-302 to D-304, D-306 to D-308, D-328, D-329, D-339, D-340, D-342, D-346, D-347, D-353, D-360, D-364, D-372; `CODEX_STANDING_BRIEF.md`; `ROOMS.md`.

Added 18 Nov 2026: `DECISIONS.md` D-231, D-286, D-288, D-295.

1. `stage5\HOW_WE_WORK.md`; `stage6\LOOPS.md`; `stage6\PERFORMANCE.md`; `stage6\OBSTACLE_COURSE.md`.
2. `DECISIONS.md` D-089 to D-091, D-127, D-137, D-138, D-158, D-161, D-165, D-198, D-205, D-213, D-214, D-216, D-225, D-226.
3. `RULES.md` R-16 to R-31, R-68 to R-71; `reference\research\R-004_TESTING_FASTER.md`, `R-005_NO_SCREEN_ENGINE.md`.
