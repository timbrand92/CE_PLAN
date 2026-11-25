# New plug-in faults register (revision 1)

**Revision 1, Wed 18 Nov 2026.** **IDs are never reused.** NB-001 onward. A fixed item keeps its number and is marked fixed with the date; it is never removed.

**What this is.** Faults in the NEW plug-in only (the one being built in `C:\CE_CIVIL`). Faults in the old plug-in stay BUG- in `C:\CE_PLAN\BUG_CARPARK.md`. This is the list D-205 and R-007 section 5 asked for, kept empty at the start and filled as faults are found. It was seeded on 18 Nov 2026 from section 5 of `BOARD.md` (its N- numbers are noted on each line; the board keeps its N- list as the same items).

**Fields on every entry:** what was done; what was seen; what was expected; how serious; found by a test or by a person; which obstacle course line now covers it (`stage6\OBSTACLE_COURSE.md`); status. Where the board did not say, the field reads "not recorded" and is never guessed.

**Status words:** open; fixed (built); fixed (tested by something that did not build it); accepted (Tim, or a robot pass, D-089). "Built" alone is never "fixed and accepted" (RULES R-18).

---

1. **NB-001 (was N-001): exploding a pipe from code loses its hidden note.**
   1. **Done:** a pipe was exploded from code (night check `golden_explode_pipe`). **Seen:** the hidden note is lost. **Expected:** the note survives, or what typed EXPLODE does is known.
   2. **Serious:** not recorded. **Found by:** a test (CETEST); the supervised typed EXPLODE check has not been run. **Obstacle course line:** none named. **Status:** open.
2. **NB-002 (was N-002): moving a pit with its pipes is too slow.**
   1. **Done:** a pit moved with its pipes on a 2,500-object drawing. **Seen:** 0.21 s. **Expected:** 0.1 s (draft limit, W-026).
   2. **Serious:** not recorded. **Found by:** a test (CESPEED, not re-run in pass 2). **Obstacle course line:** OC-26 (speed). **Status:** open.
3. **NB-003 (was N-003): detention would repeat the wrong rainfall and has no council minimum runoff.**
   1. **Done:** read from the code against R-008. **Seen:** one Kingston job's rainfall would be used on every site; no council floor. **Expected:** no storage figure without the site's rainfall (D-218); a council floor where one applies.
   2. **Serious:** not recorded (the same faults in the old plug-in put a wrong figure on a sheet). **Found by:** a person (review of the code). **Obstacle course line:** OC-24. **Status:** open; a fix is under way and a test file is being written (not yet saved).
4. **NB-004 (was N-004): a pipe cannot be bent.**
   1. **Done:** pipes drawn. **Seen:** every pipe is two points. **Expected:** bends on every kind of pipe (D-189).
   2. **Serious:** not recorded. **Found by:** a person (walk-through). **Obstacle course line:** OC-14 (fails). **Status:** open.
5. **NB-005 (was N-005): assumed and not-known figures do not print APPROX. and TBC.**
   1. **Done:** windows and sheet output read. **Seen:** windows still say "unknown" in the figure boxes. **Expected:** APPROX. and TBC (D-177, D-178).
   2. **Serious:** not recorded. **Found by:** a person (walk-through). **Obstacle course line:** OC-04 (fails). **Status:** open.
6. **NB-006 (was N-006): pipe labels do not follow a moved pit, and a pit's tag and cover text should keep their offset.**
   1. **Done:** a pit moved. **Seen:** a hand-moved tag stays put; pipe labels do not follow. **Expected:** they keep the same offset and move with it (D-181).
   2. **Serious:** not recorded. **Found by:** a person (walk-through) and a test line. **Obstacle course line:** OC-10 (fails). **Status:** open.
7. **NB-007 (was N-007): a typed-over pipe label is not kept and flagged.**
   1. **Expected:** the wording is kept, flagged, one click to follow again (D-182). **Seen:** not built. **Done:** read from the build log.
   2. **Serious:** not recorded. **Found by:** a person (review). **Obstacle course line:** none yet (OC-06 is the nearest). **Status:** open.
8. **NB-008 (was N-008): copy and numbering rules not built.**
   1. **Expected:** next free numbers and assumed levels (D-179), one series for two systems (D-183), after-issue choices (D-184), a retyped tag renames the pit (D-185). **Seen:** none built.
   2. **Serious:** not recorded. **Found by:** a person (walk-through). **Obstacle course line:** OC-09 and OC-15 (both fail). **Status:** open.
9. **NB-009 (was N-009): the drawing does not keep the standard values it was designed with.**
   1. **Expected:** the drawing remembers its own standard values (D-180). **Seen:** not built; needs a new adapter member.
   2. **Serious:** not recorded. **Found by:** a person (review). **Obstacle course line:** OC-05 (fails). **Status:** open.
10. **NB-010 (was N-010): the tools refuse a drawing in metres.**
    1. **Done:** Pit, Pipe and Long section tried in a metre drawing. **Seen:** each refuses in words. **Expected:** work in both (D-217).
    2. **Serious:** not recorded. **Found by:** a test. **Obstacle course line:** OC-01 (fails). **Status:** open.
11. **NB-011 (was N-011): nothing checks locked layers, xrefs, REFEDIT or paper space.**
    1. **Expected:** AutoCAD's own protections win (native protection rule). **Seen:** no check exists; expected to fail.
    2. **Serious:** not recorded. **Found by:** a person (review). **Obstacle course line:** OC-19. **Status:** open.
12. **NB-012 (was N-012): no log or fault report exists yet.**
    1. **Serious:** not recorded. **Found by:** a person (review). **Obstacle course line:** OC-25 (not tested). **Status:** open.
13. **NB-013 (was N-013): the Pipe tool does not draw the flow arrow, the invert text or the office's edge lines yet.**
    1. **Seen:** the window's ticks for them are off. **Serious:** not recorded. **Found by:** a person (build log entry 25 item 8). **Obstacle course line:** none. **Status:** open.
14. **NB-014 (was N-014): joining to another pipe is not built, and a pit dropped on the middle of a pipe does not split it.**
    1. **Expected:** the pipe splits in two (D-077). **Serious:** not recorded. **Found by:** a person (UNFINISHED_CHECK). **Obstacle course line:** none. **Status:** open.
15. **NB-015 (was N-015): a stand-in outline cannot be swapped for the office block when it arrives.**
    1. **Seen:** the "Turned" box is kept but not acted on. **Serious:** not recorded. **Found by:** a person (UNFINISHED_CHECK 3). **Obstacle course line:** none. **Status:** open.
16. **NB-016 (was N-016): the stretch parameters of PIT BLOCK 3 are not read.**
    1. **Expected:** read (D-215). **Serious:** not recorded. **Found by:** a person (build log 30 item 7). **Obstacle course line:** none. **Status:** open; waits for W-001.
17. **NB-017 (was N-017): a custom grip on an ordinary object crashed AutoCAD; double-click also runs AutoCAD's own polyline edit.**
    1. **Done:** trial 2 and trial 8. **Seen:** crash (trial 2 FAIL); two edits at once (trial 8). **Expected:** neither.
    2. **Serious:** a crash. **Found by:** a test (the trials). **Obstacle course line:** OC-18 (nearest; not matched by the board). **Status:** open; ordinary grips only until understood.
18. **NB-018 (was N-018): the self-check is not wired to run when a drawing opens.**
    1. **Seen:** only CESELFCHECK runs it. **Serious:** not recorded. **Found by:** a person (build log 29 item 2). **Obstacle course line:** none. **Status:** open.
19. **NB-019 (was N-019): one undo step for the mover and for each tool is unproven.**
    1. **Serious:** not recorded. **Found by:** not yet tested. **Obstacle course line:** OC-07 (not tested). **Status:** open (unproven, not shown broken).
20. **NB-020 (was N-020): later items not built: placing many in a row (D-186), the plot line (D-188), "take it up" for a hand-drawn pipe (D-192), tabs on small screens (D-193).**
    1. **Serious:** not recorded. **Found by:** a person (build log 27 "later items"). **Obstacle course line:** none. **Status:** open (planned, not faults as such).
21. **NB-021 (was N-021): the long section is not drawn onto the sheet; runs through branches are only said, not drawn.**
    1. **Serious:** not recorded. **Found by:** a person (FUNCTION_MAP section 4 A1). **Obstacle course line:** OC-12 (not built). **Status:** open.
22. **NB-022 (was N-022): the computations sheet has no tool.**
    1. **Seen:** only CDCALC in the old plug-in makes it, so the old plug-in must stay installed beside the new. **Serious:** not recorded. **Found by:** a person (FUNCTION_MAP 1.7, D-220). **Obstacle course line:** none. **Status:** open; a plan is in `design\FUNCTION_PLAN.md`.
23. **NB-023 (was N-023): small window faults from the fifth tester round.**
    1. **Seen:** the Inlet preview prints UPVC from its data file; the Inlet text lookup names one window in shared code; the Schedule's red line always says 0.00; one dead line; the focus-ring test reads source text only.
    2. **Serious:** small. **Found by:** a person (independent tester round, build log 23). **Obstacle course line:** none. **Status:** open; partly checked.
24. **NB-024 (was N-024): the Pit window opens with a 450 square preview while the size is unknown; the tag and cover text are plain text, not the office's masked text.**
    1. **Serious:** not recorded. **Found by:** a person (build log 23, DRAFTS_pit_tool 3). **Obstacle course line:** none. **Status:** open.
25. **NB-025 (was N-025): the golden recordings are "designed, not yet seen".**
    1. **Seen:** 17 recordings wait for the night run to re-take them. **Serious:** not recorded. **Found by:** a person (build log 26 item 6). **Obstacle course line:** none. **Status:** open; CETEST re-takes them.
26. **NB-026 (was N-026): the plan has no home for sheet set-up, viewport colour overrides, the fixed frame, slabs or the second sheet.**
    1. **Serious:** not recorded. **Found by:** a person (CONCEPT_GAP_CHECK section 1). **Obstacle course line:** none. **Status:** open (a plan gap, not code).
27. **NB-027 (was N-027): nineteen changed files not saved in `C:\CE_CIVIL` (one deleted); the build log still labels entries "not committed" that git shows saved.**
    1. **Serious:** risk of lost work. **Found by:** a person (git status read). **Obstacle course line:** none. **Status:** open (the build chat's job).
28. **NB-028 (was N-028): the agricultural drain card of the concept pages prints an invert text and feeds the schedule, against D-040.**
    1. **Serious:** low (the concept pages are working references only). **Found by:** a person (CONCEPT_GAP_CHECK gap 4). **Obstacle course line:** none. **Status:** open.
29. **NB-029: mock-up: four incoming levels on the plan have no matching column in step 3.**
    1. **Done:** not recorded in the archived chat. **Seen:** four incoming levels shown on the plan of the mock-up have no matching column in step 3. **Expected:** not recorded.
    1. **Serious:** not recorded. **Found by:** a person (from archived chat "CE_ACAD / Tim / interview and ideas", as it stood Fri 20 Nov 2026; filed 25 Nov 2026 by the TimOS control room on Tim's instruction). **Obstacle course line:** none. **Status:** open (a mock-up fault, not code).

---

**Next number:** NB-030. Faults found by the night run or by Tim go here the same day, with the check that now catches each (R-70).
