# Current rulings: Shared everyday tools (ST-01 to ST-18, CLEAN first)

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

Answers marked TA-xxx are Tim's words in `interview_tools\ANSWERS.md`; the hatch answers TA-047 to TA-063 are filed as D-227 and the block answers TA-064 to TA-073 as D-229.

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
12. **OFFICEHATCH scale:** "always from ltscale and dimscale. but we need to base it from our existing scales at dimscale 100 ltscale 1000": hatch scale = base x DIMSCALE / 100, with the base figures taken from the old jobs (AR-CONC base 5) (D-227, TA-058).
13. **The office hatch list is sorted by what each hatch is for and the layer it sits on,** from old-job evidence; the full list is `interview_tools\HATCHES_BY_FUNCTION.md` revision 2, and it replaces the tick sheet HT-01 to HT-58 (D-227, TA-047, TA-048).
14. **Hatch rulings:** HATCH 74 keeps all three uses (first floor over, band beams, rain garden); HATCH 51 is set-down and HATCH 238 bathtub or extra load; existing to be retained is HATCH 201 only; sections use HATCH 21 for concrete and HATCH EARTH for earth, and HATCH 11 keeps only "wall over"; walls are over, under, brick or block (WALL HATCH) and retaining block (BLOCKWORK WALL); HATCH 141 is roof trusses only; the layer names are HATCH TIMBER and HATCH WATER; post-tensioned slab is HATCH PANTONE; the seven other extra layers are kept, four of them with meaning unknown (HATCH 155, 70, 221, SLAB INFILL) (D-227, from TA-049 to TA-060; the wall layers in detail are TA-053: over HATCH 11, under HATCH 231).
15. **ST-07 REVBOX / RV, revision box:** keeps its object-snap question and can cloud any shape (D-203, D-208, D-210).
16. **ST-08 BREAKLINE / BL:** trims the lines it crosses; Tim moves his own BL alias (D-208, D-210).
17. **ST-09 CONSTRUCTIONJOINT / CJ and SAWCUT / SSC:** dashes right at 1:100, bends allowed, a full-word label placed like the 25T / 25B text depending on what is around (D-203, D-210, TA-025, TA-033).
18. **ST-10 BLOCKS / BLK, the blocks palette:** built from one office block list taken from the master drawing (D-208); all 453 blocks are looked through read-only first and "we might not need all blocks" (D-211). **Palette set by D-232 (18 Nov):** 37 blocks (item 28).
19. **Tim's ten block decisions:** the office pit is PIT BLOCK 3 (BK-020); inlet symbols are the WITH MASK set; pipe description label blocks are dropped; left / right and top / bottom pairs become one dynamic block each when structural is unparked; the 104 blocks of unknown purpose go on picture sheets for him to tick; the 65 notes held as blocks stay outside the palette, in the master drawing only; BK-450 is dropped; all 33 drop-candidates are dropped; the 181 structural blocks wait for a structural palette with the CE Structural tab; all 51 exact copies are merged on a copy of the master first, the master replaced only on his word (D-229).
20. **Nothing in the office master drawing is changed by any chat until Tim says so** (D-229).
21. **ST-11 Text 25 and 18 set:** names kept (25T, 25B and the rest), plus a TEXT window for size, side, angle, remembering the last (D-209, TA-034).
22. **ST-12 Pen quick-set; ST-13 Xref copy and paste; ST-14 Put on the office layer (new); ST-15 Viewport scale set and lock (new); ST-16 Find and replace (new):** all in (D-209, TA-029, TA-030).
23. **ST-17 Live area and length labels:** update by themselves as an AutoCAD field, so they still work on a PC without the plug-in (D-209, TA-031, TA-041).
24. **ST-18 Small office symbols from the palette** (scabble, wipeout, cut tube) (D-209, TA-031).

### What goes

25. **C, the repeat copy, is retired: "Retire it, use Copy"** (D-203, settling "rename C" in D-054).
26. **Not wanted:** CL, LM, SM and FFL tags; MLL / MLR and CML / SML; plot to PDF; Excel into schedule; north point and scale bar; command search; end offsets and numbering on Divide (TA-028, TA-030, TA-031, TA-032).
27. **The office master drawing "should have blocks, hatches and more"** (D-205).

### Added 18 Nov 2026, D-230 to D-297

28. **The Blocks palette holds 37 blocks (D-232):** Tim: "i dont know what we do have so its hard for me to know what to get rid of", so the interview chat drew what the palette would hold and he edited it: out came the pit and inlet blocks, the strip drain label and the trench grate ("covered in the plugin"), Section Flag and SCREW PILES; in went 18 of the 54 unknown blocks. The rest stay in the master drawing as spares. Proper names for the 18 machine-named blocks he added are still open (TQ-13).
29. **The four hatch layers of unknown meaning (HATCH 155, 70, 221, SLAB INFILL) (D-232):** "Not sure either"; they are kept and marked unknown. The 37 hatch sample squares in the master are a legend sample set, not the hatch list; the hatch tool reads the function list of D-227.
30. **The APPROX. standing note is a notes block on the Blocks palette (D-248):** the Unfinished list reminds the drafter to place it when anything prints APPROX. (wording on LABELS_AND_TEXT item 20).

## Changed along the way

1. **"CE everyday helpers are not in the first release" (THE_PLAN section 3, 16 Nov) was replaced by D-201 (18 Nov),** widened by D-209 and confirmed by D-214.
2. **RC (revision cloud) became REVBOX / RV and C was retired (D-203, 18 Nov),** settling D-054's "rename C and RC".
3. **The CE arrow leader Q became QL (D-208, 18 Nov).**
4. **Proposals in the interview file now overtaken:** retiring DIV and DIVX (kept, TA-022); dropping REVBOX's snap question (kept, TA-024); BK for break line (BL, TA-023); "CE Draft" tab name (CE Tools, TA-018); pen quick-set as structural only (now ST-12).
5. **HATCH 11 for concrete in section was moved to HATCH 21; HATCH 11 keeps only "wall over" (TA-052, D-227).**
6. **The hatch tick sheet HT-01 to HT-58 (TA-045, 18 Nov) was replaced by the function list in HATCHES_BY_FUNCTION revision 2 (D-227, 18 Nov afternoon).**

## Still open on this subject

1. **What HATCH 155, 70, 221 and SLAB INFILL each mean:** kept with meaning unknown (D-227, TA-060). Waits on: Tim. Asked again, "Not sure either" (D-232); kept and marked unknown.
2. **Hatch starting scales from old jobs are unproven:** which viewport each hatch sat in was not read (HATCHES_BY_FUNCTION "Scale"). Waits on: a test.
3. **"Hatches need work before going out"** is not specified further; H2A becomes a button or goes (TA-001; interview ST-06). Waits on: Tim.
4. **OFFICEHATCH full word still to be typed once in AutoCAD** (TA-044). Waits on: a test.
5. **Short names ST-11 to ST-18:** none given beyond "names kept" for the text set (interview ST-11 to ST-18). Waits on: Tim.
6. **Arc dimension name ARCDIM / RD:** proposal only. Waits on: Tim.
7. **Long names MOVEROTATE, COPYROTATE, COPYASBLOCK:** proposals. Waits on: Tim.
8. **Divide's typed names:** DIV clashes with Tim's alias "Div, *Divide"; which names it uses is not stated (FUNCTION_MAP FM-081). Waits on: Tim.
9. **Name checks in AutoCAD 2027 not yet done:** RV, CN, QL, BLK, BL, CJ, SSC, OH and the full words; BREAKLINE also to be checked as an Express Tools command name (TA-023; D-203 note). Waits on: a test.
10. **CLEAN's steps and the time each takes are not measured;** a time limit is owed in PERFORMANCE.md; whether today's Structural CLEAN saves is unknown, and the plan relies on it (interview ST-01; FUNCTION_MAP section 5 item 4). Waits on: the build chat.
11. **What "learn from how and where they are placed" means for joint labels** (TQ-09; FI-04 later; FM-056). Waits on: Tim.
12. **Whether the 279 machine-named blocks may be renamed on a copy** (TQ-10); D-229 settles that the master changes only on Tim's word but does not mention renaming. Waits on: Tim.
13. **Picture sheets of the 104 blocks of unknown purpose for Tim to tick** (D-229, "Picture sheets, I tick"). Waits on: the planning chat.
14. **Whether the 37-square hatch sample set in the master drawing is the office hatch list:** it was BLOCKS_REVIEW question 4 and is not among the ten answers in D-229; D-227 makes the function list the hatch list. Waits on: the planning chat. **Answered by D-232 (18 Nov):** the 37 squares are a legend sample set, not the hatch list.
15. **Dynamic block states and which blocks carry attributes the tools must fill:** not read; the DWG and A1 template not opened (BLOCKS_REVIEW, interview section 9). Waits on: the build chat.
16. **Undecided function-map lines in this area:** DSET / DSET1 (FM-076), CEHATCHCHANGE and batch (FM-085), CJSS swap button (FM-089), MD (FM-082), TP retire (FM-103), 3DF2L (FM-104), automatic saw-cut grid (FM-055), CIVILEXCELMTEXT retire (FM-098). Waits on: Tim.
17. **COPYMODE on office PCs not checked;** if not 0, Tim sets it himself (NAMES_C_AND_RC_PROPOSAL; rule 1.9). Waits on: Tim.
18. **The hatch fault in his working AutoCAD:** R-006 judges it probably plain AutoCAD and gives a two-minute check (Associative, PICKSTYLE, GRIPS, GRIPMULTIFUNCTIONAL, HPBOUND). Waits on: Tim.
19. **What his alias q (mltim) is:** not said (TA-021); definitions of several alias targets not found (FM-177). Waits on: Tim. D-250 (18 Nov) removed eleven of his aliases that call commands found in no CE code, among them q and MLL (see RIBBON_AND_NAMES item 19).
20. **POSSIBLE CONFLICT: Tim's Q.** D-208 says the CE arrow leader is QL and Tim keeps his own Q alias; D-250 lists "q" among the eleven aliases removed from his alias file. Neither says whether they are the same alias. Waits on: Tim.
21. **Proper names for the 18 machine-named blocks he added to the palette** (D-232, TQ-13). Waits on: Tim.

**Closed (D-230 to D-297):** what the Blocks palette holds (D-232, 37 blocks); whether the 37-square hatch sample set is the office hatch list (D-232, no).

**Closed:** filing the hatch answers as D-numbers (closed by D-227); the hatch tick list HT-01 to HT-58 (closed by D-227, replaced by the function list); who owns edits to the master drawing (closed by D-229, nothing changes until Tim says so); the block questions on the pit block, inlet symbols, pipe description labels, left / right pairs, the 65 notes, BK-450, the 33 drop-candidates, the 181 structural blocks and the 51 copies (closed by D-229, and by D-228 for the pit block).

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-208, D-232, D-248, D-250.

1. `DECISIONS.md` D-199, D-201 to D-205, D-208 to D-211, D-214, D-227 to D-229.
2. `interview_tools\ANSWERS.md` TA-001 to TA-073; `design\TOOLS_AND_MANAGER_INTERVIEW.md` revision 2.
3. `interview_tools\HATCH_TICK_LIST.md`; `interview_tools\HATCHES_BY_FUNCTION.md`; `design\BLOCKS_REVIEW.md`.
4. `reference\research\R-006_HATCH_AND_GRIPS.md`; `design\FUNCTION_MAP.md` FM-067 to FM-107.
