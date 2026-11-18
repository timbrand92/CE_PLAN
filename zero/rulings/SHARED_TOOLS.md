# Current rulings: Shared everyday tools (ST-01 to ST-18, CLEAN first)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

Answers marked TA-xxx are Tim's words in `interview_tools\ANSWERS.md`; TA-047 to TA-060 have not yet been filed as D-numbers in DECISIONS.md.

## What is decided now

### Whether and when

1. **All 18 shared tools are in the first release, but each must work and be tested before release:** "all 18 but we need to make sure they all work and are tested before release. a lot of it already works and has been tested so it shouldnt take as long" (D-214, confirming D-201 and the planning chat's reading of D-209).
2. **CLEAN comes first in importance;** the rest in any order (D-201).
3. **D-091 (one tool at a time) still governs the order of building** (D-201, the planning chat's note).
4. **Every shared tool is gone through before it is built:** how it can be built better, fit the overall code and the database, scale, work as Tim intended and be better organised (D-202), and every one is interviewed for upgrades first (D-209).
5. **Structural-only tools stay parked** (D-201, D-006).

### The eighteen, as they stand now

6. **ST-01 CLEAN / CN, save and tidy:** one tool, used very often as the main way to save, so it must be quick and repeatable (D-204, D-208); it also audits, zeroes stray Z heights and sets the drawing units, then saves (D-210, TA-035).
7. **ST-02 Dimensions and leaders (LD, AD, QD, DUP):** the quick leader is QL and Tim keeps his own Q (D-208); an arc dimension is added (TA-004); dimension size follows the viewport and already-drawn dimensions must update too (D-210, TA-039).
8. **ST-03 MR and CR (move and rotate, copy and rotate):** unchanged, one copy each (D-210, TA-036).
9. **ST-04 CPB (copy and paste as block):** unchanged (D-210, TA-036).
10. **ST-05 Divide (DIV, DIVX kept):** follows bends and arcs, shows a visible cross, a preview and spacing text; no end offsets or numbering (D-210, TA-022, TA-032).
11. **ST-06 OFFICEHATCH / OH, one hatch window:** every hatch it makes is linked to its outline (associative), Tim's AutoCAD settings put back after (D-214, TA-044, TA-046).
12. **OFFICEHATCH scale:** read from LTSCALE and DIMSCALE, each hatch's base scale being the office scale at DIMSCALE 100 / LTSCALE 1000, changing in proportion (TA-058).
13. **OFFICEHATCH list sorted by what each hatch does and its layer,** checked against old project evidence (TA-047, TA-048).
14. **Hatch overlaps ruled:** HATCH 74 carries first floor over, band beam and rain garden as separate choices (TA-049); set-down is HATCH 51, HATCH 238 kept for bathtub and extra-load areas (TA-050); existing to be retained is HATCH 201 only (TA-051); concrete in section HATCH 21, earth HATCH EARTH, HATCH 11 keeps only "load bearing wall over" (TA-052); walls: over HATCH 11, under HATCH 231, brick and block WALL HATCH, retaining block BLOCKWORK WALL (TA-053); HATCH 141 roof trusses only (TA-054); keep HATCH TIMBER and HATCH WATER (TA-055); post-tensioned slab HATCH PANTONE, HATCH PT retired (TA-059); the extra layers HATCH 155, 70, 221, 45, SAND, FILL and HATCH-SLAB INFILL are all kept (TA-060).
15. **ST-07 REVBOX / RV, revision box:** keeps its object-snap question and can cloud any shape (D-203, D-208, D-210).
16. **ST-08 BREAKLINE / BL:** trims the lines it crosses; Tim moves his own BL alias (D-208, D-210).
17. **ST-09 CONSTRUCTIONJOINT / CJ and SAWCUT / SSC:** dashes right at 1:100, bends allowed, a full-word label placed like the 25T / 25B text depending on what is around (D-203, D-210, TA-025, TA-033).
18. **ST-10 BLOCKS / BLK, the blocks palette:** built from one office block list taken from the master drawing (D-208); all 453 blocks are looked through read-only first and "we might not need all blocks" (D-211).
19. **ST-11 Text 25 and 18 set:** names kept (25T, 25B and the rest), plus a TEXT window for size, side, angle, remembering the last (D-209, TA-034).
20. **ST-12 Pen quick-set; ST-13 Xref copy and paste; ST-14 Put on the office layer (new); ST-15 Viewport scale set and lock (new); ST-16 Find and replace (new):** all in (D-209, TA-029, TA-030).
21. **ST-17 Live area and length labels:** update by themselves as an AutoCAD field, so they still work on a PC without the plug-in (D-209, TA-031, TA-041).
22. **ST-18 Small office symbols from the palette** (scabble, wipeout, cut tube) (D-209, TA-031).

### What goes

23. **C, the repeat copy, is retired: "Retire it, use Copy"** (D-203, settling "rename C" in D-054).
24. **Not wanted:** CL, LM, SM and FFL tags; MLL / MLR and CML / SML; plot to PDF; Excel into schedule; north point and scale bar; command search; end offsets and numbering on Divide (TA-028, TA-030, TA-031, TA-032).
25. **The office master drawing "should have blocks, hatches and more"** (D-205).

## Changed along the way

1. **"CE everyday helpers are not in the first release" (THE_PLAN section 3, 16 Nov) was replaced by D-201 (18 Nov),** widened by D-209 and confirmed by D-214.
2. **RC (revision cloud) became REVBOX / RV and C was retired (D-203, 18 Nov),** settling D-054's "rename C and RC".
3. **The CE arrow leader Q became QL (D-208, 18 Nov).**
4. **Proposals in the interview file now overtaken:** retiring DIV and DIVX (kept, TA-022); dropping REVBOX's snap question (kept, TA-024); BK for break line (BL, TA-023); "CE Draft" tab name (CE Tools, TA-018); pen quick-set as structural only (now ST-12).
5. **HATCH 11 for concrete in section was retired to HATCH 21 (TA-052);** HATCHES_BY_FUNCTION still lists it as an open overlap.

## Still open on this subject

1. **File TA-047 to TA-060 (hatch list, overlaps, scale, extra layers) as D-numbers in DECISIONS.md** (the planning chat folds the interview in, D-198). Waits on: the planning chat.
2. **Hatch tick list HT-01 to HT-58:** every line "not yet ticked" (TA-045; the civil / structural / other split is a guess). Waits on: Tim.
3. **What HATCH 155, 70, 221 and HATCH-SLAB INFILL each mean** (no legend beside them) (TA-060). Waits on: Tim.
4. **Hatch starting scales from old jobs are unproven:** which viewport each hatch sat in was not read (HATCHES_BY_FUNCTION "Scale"). Waits on: a test.
5. **"Hatches need work before going out"** is not specified further; H2A becomes a button or goes (TA-001; interview ST-06). Waits on: Tim.
6. **OFFICEHATCH full word still to be typed once in AutoCAD** (TA-044). Waits on: a test.
7. **Short names ST-11 to ST-18:** none given beyond "names kept" for the text set (interview ST-11 to ST-18). Waits on: Tim.
8. **Arc dimension name ARCDIM / RD:** proposal only. Waits on: Tim.
9. **Long names MOVEROTATE, COPYROTATE, COPYASBLOCK:** proposals. Waits on: Tim.
10. **Divide's typed names:** DIV clashes with Tim's alias "Div, *Divide"; which names it uses is not stated (FUNCTION_MAP FM-081). Waits on: Tim.
11. **Name checks in AutoCAD 2027 not yet done:** RV, CN, QL, BLK, BL, CJ, SSC, OH and the full words; BREAKLINE also to be checked as an Express Tools command name (TA-023; D-203 note). Waits on: a test.
12. **CLEAN's steps and the time each takes are not measured;** a time limit is owed in PERFORMANCE.md; whether today's Structural CLEAN saves is unknown, and the plan relies on it (interview ST-01; FUNCTION_MAP section 5 item 4). Waits on: the build chat.
13. **What "learn from how and where they are placed" means for joint labels** (TQ-09; FI-04 later; FM-056). Waits on: Tim.
14. **Who owns edits to the master drawing, and whether the 279 machine-named blocks may be renamed on a copy** (TQ-10). Waits on: Tim.
15. **The ten block questions:** which pit block, one set of inlet symbols, pipe description labels, the 37-square hatch set, the 104 "ask Tim" blocks, the 65 notes as blocks, left/right pairs, BK-450, the 33 drop-candidates, the 181 structural blocks out of the palette (BLOCKS_REVIEW). Waits on: Tim.
16. **Dynamic block states and which blocks carry attributes the tools must fill:** not read; the DWG and A1 template not opened (BLOCKS_REVIEW, interview section 9). Waits on: the build chat.
17. **Undecided function-map lines in this area:** DSET / DSET1 (FM-076), CEHATCHCHANGE and batch (FM-085), CJSS swap button (FM-089), MD (FM-082), TP retire (FM-103), 3DF2L (FM-104), automatic saw-cut grid (FM-055), CIVILEXCELMTEXT retire (FM-098). Waits on: Tim.
18. **COPYMODE on office PCs not checked;** if not 0, Tim sets it himself (NAMES_C_AND_RC_PROPOSAL; rule 1.9). Waits on: Tim.
19. **The hatch fault in his working AutoCAD:** R-006 judges it probably plain AutoCAD and gives a two-minute check (Associative, PICKSTYLE, GRIPS, GRIPMULTIFUNCTIONAL, HPBOUND). Waits on: Tim.
20. **What his alias q (mltim) is:** not said (TA-021); definitions of several alias targets not found (FM-177). Waits on: Tim.

## Where the detail lives

1. `DECISIONS.md` D-199, D-201 to D-205, D-208 to D-211, D-214.
2. `interview_tools\ANSWERS.md` TA-001 to TA-060; `design\TOOLS_AND_MANAGER_INTERVIEW.md` revision 2.
3. `interview_tools\HATCH_TICK_LIST.md`; `interview_tools\HATCHES_BY_FUNCTION.md`; `design\BLOCKS_REVIEW.md`.
4. `reference\research\R-006_HATCH_AND_GRIPS.md`; `design\FUNCTION_MAP.md` FM-067 to FM-107.
