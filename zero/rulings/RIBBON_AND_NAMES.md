# Current rulings: Ribbon and names

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

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
9. **The plug-in does not edit Tim's alias file;** where a new name sits on one of his aliases, moving his alias is his to do (D-170, D-208).

### Exceptions kept from today

10. **PIPE keeps CD** (D-057, D-101).
11. **IO is kept although it sits on AutoCAD's own short name** (D-054).
12. **Shared tools keeping today's names:** MR, CR, CPB unchanged (D-210); Divide kept (TA-022); the text set 25T, 25B and the rest kept (TA-034); LD, AD, QD and DUP carried in the dimensions tool (FUNCTION_MAP FM-073, citing D-201).

### Every tool's name as it stands now

13. **CE Civil, ruled:** PIT / PT; PIPE / CD; LONGSECTION / LG; DOWNPIPE / DP; OVERFLOW / OF; FO / FO (no longer name); INSPECTION / IO; GIO / GIO; FLOORWASTE / FW; TANK / WT; DETENTION / DET; SCHEDULE / SH (D-101, D-059, D-170, D-196).
14. **CE Tools, ruled:** CLEAN / CN; QL (quick leader); BREAKLINE / BL; BLOCKS / BLK; REVBOX / RV; CONSTRUCTIONJOINT / CJ; SAWCUT / SSC; OFFICEHATCH / OH (D-203, D-208, D-214).
15. **Retired:** C (use AutoCAD's Copy) (D-203); RC renamed REVBOX / RV (D-203); Q as the CE leader, now QL, with Tim keeping his own Q alias (D-208); LEVELS / LV, now LONGSECTION / LG (D-196); TK, now WT (D-170).

## Changed along the way

1. **"One short CE Civil tab" (D-051, 16 Nov) became three tabs (D-200, 18 Nov), named CE Civil, CE Tools, CE Structural (D-208).**
2. **The three naming options on `pick_a_naming_rule.html` (16 Nov) were all rejected (D-052) and replaced by the full word plus short name rule (D-055).**
3. **Draft list of 17 names (16 Nov) was never seen by Tim; D-057 kept PIPE / CD; the first-release list was then agreed as D-101.**
4. **TANK / TK (D-101) became TANK / WT (D-169, D-170, 18 Nov).**
5. **LEVELS / LV (D-101) became LONGSECTION / LG (D-196, 18 Nov).**
6. **"Rename C and RC" (D-054) was settled by D-203 (18 Nov):** C retired, revision cloud REVBOX / RV.
7. **The CE arrow leader Q became QL (D-208).**
8. **NAMING_DRAFT's PIPE / PI and LEVELS / LV are stale** (FUNCTION_MAP section 5 item 11).

## Still open on this subject

1. **Which buttons sit on each tab and on the light tab that appears on selection** (D-051; UI_PLAN section 9 item 2; FUNCTION_MAP). Waits on: Tim.
2. **Every short name to be typed once in AutoCAD 2027 to prove it is free** (D-101; NAMING_DRAFT; trial 7 PARTIAL). Waits on: a test.
3. **PIT and CD may already answer in AutoCAD before CE loads:** keep them? (OBSTACLE_COURSE OQ-09). Waits on: the build chat, then Tim.
4. **Short names delivered by the plug-in or as alias lines:** recommendation in the plug-in (FM-176; NAMING_DRAFT, Stage 4). Waits on: Tim.
5. **Names not yet given:** Outlet tool, LPD tool, Job window (JOB is a draft), Manager, CHECK / CK (draft), TRENCHGRATE / TG (draft), AGDRAIN / AG (draft), SLAB / SB (draft), ISSUE / IS (draft, not first release), ARCDIM / RD (proposal), ST-11 to ST-18 (NAMING_DRAFT, FUNCTION_MAP, interview). Waits on: Tim.
6. **GIO's full word is unknown** (NAMING_DRAFT). Waits on: Tim.
7. **Divide's names clash with Tim's own "Div" alias** (FM-081). Waits on: Tim.
8. **Several ruled short names are not first letters of their word (CD, WT, LG);** they are Tim's later picks and stand, but the rule text in D-055 does not mention the exception. Waits on: the planning chat (to note the exceptions in the office list).
9. **Two Civil ribbon layouts exist today; which one a drafter sees was not checked** (FUNCTION_MAP section 5 item 8). Waits on: the build chat.
10. **How the light tab and tips look on screen, the rules-file route, workspace switch and restart:** not tested (trial 7). Waits on: a test.

## Where the detail lives

1. `DECISIONS.md` D-044, D-046, D-047, D-049, D-051 to D-059, D-101, D-162, D-169, D-170, D-196, D-200, D-203, D-208, D-214.
2. `design\NAMING_DRAFT.md`; `evidence\TIM_ALIAS_LIST_16NOV.md`; `reference\research\R-001_FEELING_NATIVE_IN_AUTOCAD.md` section E.
3. `design\FUNCTION_MAP.md` FM-174, FM-176, FM-177.
