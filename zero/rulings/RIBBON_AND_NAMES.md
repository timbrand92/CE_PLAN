# Current rulings: Ribbon and names

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### The ribbon

1. **Three tabs: CE Civil, CE Tools and CE Structural,** with the structural tab hidden until it has tools (D-208, settling the "better names" of D-200, which replaced the "one short CE Civil tab" of D-051).
2. **A light tab for the picked thing appears on selection and goes when it is let go,** the way AutoCAD's own Hatch tab does (D-051); it must stay light because choices are made in the pop-up window, not in ribbon buttons (D-058); this part of D-051 was not withdrawn by D-200.
3. **Every ribbon button shows its short name in its tip** (UI_PLAN section 1; NAMING_DRAFT, from R-001).
4. **The ribbon and names must feel like part of AutoCAD,** redesigned as one system (D-044).

### The naming rule

5. **Each tool gets a plain full word plus a one to three letter short name, the way AutoCAD's own commands work;** the short name is built from the first letters of the word and sits in one office list the office can edit (D-055, settling D-052; following D-046 "LONG COMMAND NAMES ARE HARD TO REUSE").
6. **Names are refreshed on one strategy** (D-049 item 4).
7. **Old typed names are gone;** only the new names work from day one (D-053), with the exceptions in items 10 to 12.
8. **Only placing has a name:** changing a thing has no typed name; click it and use its tab, grips or Properties (D-056).
9. **The plug-in does not edit Tim's alias file;** where a new name sits on one of his aliases, moving his alias is his to do (D-170, D-208). **Changed for one job by D-250 and D-251 (18 Nov):** the eleven aliases and the second spelling SERIAL were removed from his AutoCAD 2027 alias file on 18 Nov on his words (D-250; done, board item 20), a dated copy beside the file; Pp removed the same way (D-251); the plug-in itself still never edits the file (items 19 and 20).

### Exceptions kept from today

10. **PIPE keeps CD** (D-057, D-101).
11. **IO is kept although it sits on AutoCAD's own short name** (D-054).
12. **Shared tools keeping today's names:** MR, CR, CPB unchanged (D-210); Divide kept (TA-022); the text set 25T, 25B and the rest kept (TA-034); LD, AD, QD and DUP carried in the dimensions tool (FUNCTION_MAP FM-073, citing D-201).

### Every tool's name as it stands now

13. **CE Civil, ruled:** PIT / PT; PIPE / CD; LONGSECTION / LG; DOWNPIPE / DP; OVERFLOW / OF; FO / FO (no longer name); INSPECTION / IO; GIO / GIO; FLOORWASTE / FW; TANK / WT; DETENTION / DET; SCHEDULE / SH (D-101, D-059, D-170, D-196). **SH superseded by D-233 (18 Nov): SCHEDULE / SCH. LEGALPOINT / LPD added (D-274); PP is plastic pit (D-251).**
14. **CE Tools, ruled:** CLEAN / CN; QL (quick leader); BREAKLINE / BL; BLOCKS / BLK; REVBOX / RV; CONSTRUCTIONJOINT / CJ; SAWCUT / SSC; OFFICEHATCH / OH (D-203, D-208, D-214).
15. **Retired:** C (use AutoCAD's Copy) (D-203); RC renamed REVBOX / RV (D-203); Q as the CE leader, now QL, with Tim keeping his own Q alias (D-208); LEVELS / LV, now LONGSECTION / LG (D-196); TK, now WT (D-170).

### Added 18 Nov 2026, D-230 to D-297

16. **SCHEDULE / SCH (D-233):** "SCHEDULE / SCH" replaces SH, which is AutoCAD's own shell command (found when the third AutoCAD pass read which short names are already taken).
17. **TRENCHGRATE / TG (D-233):** "Keep TG; it takes over when the old plugin goes". Until the old plug-in is removed the new tool is tested under its full word TRENCHGRATE.
18. **One tool for the end of a system, LEGALPOINT / LPD (D-274):** OUTLET as a separate tool and typed name goes; the civil tab is now 11 windows.
19. **WT is Tank, and eleven of Tim's own aliases are removed (D-250; changes the rule that his alias file is never edited by a chat, for this one job only):** asked about his short commands WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial and ET, which call commands found in no CE code or shared LISP folder: "EDIT THE ALIAS FILE TO REMOVE THOSE OTHER COMMANDS, WT IS TANK". The eleven aliases and the second spelling SERIAL were removed from his AutoCAD 2027 alias file on 18 Nov on his words (D-250; done, board item 20), a dated copy beside the file; Pp removed the same way (D-251); nothing else in the file is touched and the plug-in still never edits it by itself.
20. **PP is plastic pit (D-251):** "Remove my Pp alias; PP is plastic pit (Recommended)": that one line (Pp ran PEDIT) was removed from his AutoCAD 2027 alias file, dated copy beside it.
21. **PIT and CD go to the new tools straight away (D-258, not the recommended answer):** "New tools take PIT and CD now": the new Pit and Pipe tools answer to PIT and CD (and PT and PIPE) while the old plug-in is loaded, and the old ones stop answering to those names when both are loaded. How AutoCAD chooses when two plug-ins register the same name is not proven; the build must make the new one win and prove it in the night run, or say plainly that it cannot.

## Changed along the way

1. **"One short CE Civil tab" (D-051, 16 Nov) became three tabs (D-200, 18 Nov), named CE Civil, CE Tools, CE Structural (D-208).**
2. **The three naming options on `pick_a_naming_rule.html` (16 Nov) were all rejected (D-052) and replaced by the full word plus short name rule (D-055).**
3. **Draft list of 17 names (16 Nov) was never seen by Tim; D-057 kept PIPE / CD; the first-release list was then agreed as D-101.**
4. **TANK / TK (D-101) became TANK / WT (D-169, D-170, 18 Nov).**
5. **LEVELS / LV (D-101) became LONGSECTION / LG (D-196, 18 Nov).**
6. **"Rename C and RC" (D-054) was settled by D-203 (18 Nov):** C retired, revision cloud REVBOX / RV.
7. **The CE arrow leader Q became QL (D-208).**
8. **NAMING_DRAFT's PIPE / PI and LEVELS / LV are stale** (FUNCTION_MAP section 5 item 11).
9. **SCHEDULE / SH (D-101) became SCHEDULE / SCH (D-233, 18 Nov),** because SH is AutoCAD's own shell command.
10. **An Outlet tool and an LPD tool, neither named (D-190, D-222), became ONE tool, LEGALPOINT / LPD (D-274, 18 Nov).**
11. **"The plug-in does not edit Tim's alias file" (D-170, D-208) was set aside for one job by D-250 and D-251 (18 Nov):** twelve named aliases removed at his word; the rule stands for everything else.

## Still open on this subject

1. **Which buttons sit on each tab and on the light tab that appears on selection** (D-051; UI_PLAN section 9 item 2; FUNCTION_MAP). Waits on: Tim.
2. **Every short name to be typed once in AutoCAD 2027 to prove it is free** (D-101; NAMING_DRAFT; trial 7 PARTIAL). Waits on: a test. The third AutoCAD pass (D-233) read which names are taken: SH is AutoCAD's own (now SCH) and TG is the old plug-in's.
3. **PIT and CD may already answer in AutoCAD before CE loads:** keep them? (OBSTACLE_COURSE OQ-09). Waits on: the build chat, then Tim. **Answered by D-258 (18 Nov):** the new tools take PIT and CD now; not proven how AutoCAD chooses.
4. **Short names delivered by the plug-in or as alias lines:** recommendation in the plug-in (FM-176; NAMING_DRAFT, Stage 4). Waits on: Tim.
5. **Names not yet given:** Outlet tool, LPD tool, Job window (JOB is a draft), Manager, CHECK / CK (draft), TRENCHGRATE / TG (draft), AGDRAIN / AG (draft), SLAB / SB (draft), ISSUE / IS (draft, not first release), ARCDIM / RD (proposal), ST-11 to ST-18 (NAMING_DRAFT, FUNCTION_MAP, interview). Waits on: Tim. **Outlet tool and LPD tool answered by D-274 (LEGALPOINT / LPD); TRENCHGRATE / TG answered by D-233 (TG).**
6. **GIO's full word is unknown** (NAMING_DRAFT). Waits on: Tim.
7. **Divide's names clash with Tim's own "Div" alias** (FM-081). Waits on: Tim.
8. **Several ruled short names are not first letters of their word (CD, WT, LG);** they are Tim's later picks and stand, but the rule text in D-055 does not mention the exception. Waits on: the planning chat (to note the exceptions in the office list).
9. **Two Civil ribbon layouts exist today; which one a drafter sees was not checked** (FUNCTION_MAP section 5 item 8). Waits on: the build chat.
10. **How the light tab and tips look on screen, the rules-file route, workspace switch and restart:** not tested (trial 7). Waits on: a test.
11. **Which plug-in wins PIT and CD when both are loaded** is not proven (D-258). Waits on: a test.
12. **Other clashes between new names and Tim's aliases** (for example Divide, open item 7 above) remain his to move; only the twelve named aliases were removed (D-250, D-251). Waits on: Tim.
13. **POSSIBLE CONFLICT, waits on Tim (board item 68):** D-208 says he keeps his own Q alias; the eleven removed under D-250 included q. Putting it back is one line from the dated copy.

**Closed (D-230 to D-297):** whether the new tools keep PIT and CD (closed by D-258); the names of the Outlet and LPD tools (closed by D-274); the typed name of the trench grate (closed by D-233); the short name clash on the schedule (closed by D-233); PP against Tim's Pp alias (closed by D-251); WT against his alias (closed by D-250).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-233, D-250, D-251, D-258, D-274.

1. `DECISIONS.md` D-044, D-046, D-047, D-049, D-051 to D-059, D-101, D-162, D-169, D-170, D-196, D-200, D-203, D-208, D-214.
2. `design\NAMING_DRAFT.md`; `evidence\TIM_ALIAS_LIST_16NOV.md`; `reference\research\R-001_FEELING_NATIVE_IN_AUTOCAD.md` section E.
3. `design\FUNCTION_MAP.md` FM-174, FM-176, FM-177.
