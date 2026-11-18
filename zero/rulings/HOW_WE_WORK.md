# Current rulings: How we work (built, tested, installed, accepted; the gate; loops; speed; testing that learns)

Current rulings as of 18 Nov 2026, 1:40 pm (Melbourne), from decisions D-001 to D-229. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Done is four facts

1. **Built, tested, installed and accepted are four separate facts,** never merged (R-18; HOW_WE_WORK).
2. **Who accepts a tool: "Me, or a robot pass if I am busy"** (D-089, settling PARKING_LOT P-01).
3. **A loop never calls its own work accepted; the builder never tests its own work; the tester never fixes** (LOOPS section 2, under D-158).

### Pace and order

4. **One tool at a time, each finished before the next** (D-091).
5. **Never start anything new while a tool on the ribbon is broken** (D-090).
6. **Every shared tool must work and be tested before release** (D-214).

### The gate

7. **The obstacle course is the gate every tool must go through:** "yes this is the gate" (D-216), written as 27 tests with every one of the 597 recurring old bugs behind one of them (D-213).
8. **Testing learns:** every fault found by a test or a person becomes a new check; every run records its time, counts and what it caught; slow checks are sped up; the trend shows in the director's summary; this is learning by record and rule, not a trained model (D-225, R-70).

### Loops and keeping things moving

9. **The six loops** (tool, AutoCAD night, real job, decision, director, keep-moving) are written in `stage6\LOOPS.md` (D-158).
10. **The build chat may start the AutoCAD part** (the foundation, then Pit, then Pipe), with nothing installed without Tim's yes (D-158).
11. **While Tim is away, the planning chat keeps things moving:** anything that is Tim's call is taken at the recommended default and marked DRAFT for him (D-137); the bench of seven windows went ahead (D-138).
12. **Building happens in a new private repository of its own,** `C:\CE_CIVIL` with its own private GitHub repository, nothing shared with the old plug-in's repository (D-127).
13. **Side chat for the tools interview reports to the planning chat;** its answers go to `interview_tools\ANSWERS.md` and the planning chat folds what matters into DECISIONS.md (D-198).

### Records

14. **Every bug, idea and other item carries an ID number that is never reused, and documents carry a revision number** (D-205).
15. **Every item lives in exactly one home, and the current ruling on any subject can be read in one place** (R-71; this folder is that place).
16. **The board is built, and Tim manages only what is put to him in chat;** keeping the record, lists, side chats, order of work and follow-ups is the planning chat's job, run without faults (D-226).

### Speed

17. **Speed is part of the plan:** time limits for each thing a drafter feels, measured every night, over the limit is a fault (D-165); the limits themselves are DRAFT.
18. **Testing faster:** the free gains cut a full AutoCAD test pass from about 16 minutes to about 2 minutes 20 seconds; the no-screen engine is to be looked into and written up for approval with nothing run; the cloud engine and a second machine stay parked (D-161).

## Changed along the way

1. **"Who accepts" (RULES.md Rulings item 1, P-01, "Not decided" list in DECISIONS.md) was answered by D-089 (16 Nov);** RULES.md still says "Answer: not yet given".
2. **"Only the brain" (D-127) was extended to the window frame and seven bench windows (D-137, D-138), then to the AutoCAD part (D-158).**

## Still open on this subject

1. **R-71 in RULES.md still reads "not yet approved" for the board,** although D-226 approved it. Waits on: the planning chat.
2. **A plain explanation of how the gate works and "short term suffering for long term gain"** (D-216, OQ-01). Waits on: the planning chat.
3. **OBSTACLE_COURSE OQ-03, keep the 0.1 s limit for moving a pit;** measured 208 ms against 100 ms, one FAULT (OBSTACLE_COURSE). Waits on: Tim.
4. **Time limits in PERFORMANCE section 2 are DRAFT,** including the 5 thousandths of a second idle limit (D-165). Waits on: Tim.
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

**Closed:** whether the board is approved (closed by D-226, "build the board").

## Where the detail lives

1. `stage5\HOW_WE_WORK.md`; `stage6\LOOPS.md`; `stage6\PERFORMANCE.md`; `stage6\OBSTACLE_COURSE.md`.
2. `DECISIONS.md` D-089 to D-091, D-127, D-137, D-138, D-158, D-161, D-165, D-198, D-205, D-213, D-214, D-216, D-225, D-226.
3. `RULES.md` R-16 to R-31, R-68 to R-71; `reference\research\R-004_TESTING_FASTER.md`, `R-005_NO_SCREEN_ENGINE.md`.
