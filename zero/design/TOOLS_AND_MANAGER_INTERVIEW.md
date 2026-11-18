# Tools and Manager interview

**Revision:** 2 (Wed 18 Nov 2026, late afternoon, Melbourne time). Revision 1 had answers A-01 to A-17 only; revision 2 adds section 8a. Tim's answers are numbered TA- in `interview_tools\ANSWERS.md` (A-01 to A-17 there are TA-001 to TA-017).
**Written by:** the interview side session started by the planning chat 'CE_ACAD / zero plan / 01'.
**Status:** Tim's answers, in his words, plus proposals. **Nothing here is a decision until the planning chat files it in `DECISIONS.md`.** Nothing was built, no code was changed, AutoCAD was not opened.
**IDs in this file:** shared tools ST-01 onwards, Manager items MG-01 onwards, future ideas FI-01 onwards, open questions TQ-01 onwards, clashes with earlier decisions CX-01 onwards. Never reuse or renumber; a later revision adds new numbers.

**Read before asking:** the old plug-in at ref `origin/claude/rel-20261114a` (commit a6809594; Manager, Structural, Structural blocks, Shared/CE_SHARED, both command registries), `stage3\PARTS_BIN_REPORT.md`, `reference\today\TOOLS_TODAY.md`, `DECISIONS.md` (D-006, D-044 to D-059, D-071 to D-073, D-097, D-101, D-170, D-196), `design\NAMES_C_AND_RC_PROPOSAL.md`, Tim's alias list `evidence\TIM_ALIAS_LIST_16NOV.md`, and the office master drawing (DXF copy) Tim pointed to.

---

## 1. Tim's answers, in his words

**A-01 Used on both civil and structural drawings (question 1).** Ticked: Dims and leaders; Move / copy helpers; Clean-up and Xrefs. Typed: "RC, HATCHES, BL. HATCHES NEEDS WORK THOUGH BEFORE GOING OUT". Not ticked: centreline, level mark, section mark, FFL.

**A-02 Second list (question 1b).** Ticked: Hatch presets; Slab joints; Blocks palette. Not ticked: Excel into text and plot to PDF. Typed, as the rule for the whole job:
> "NEED TO GO THROUGH EACH COMMAND, THINK, HOW CAN THIS BE BUILT BETTER, HOW CAN THIS BE PART OF THE OVERALL CODE IN A BETTER WYA, HOW CAN WE USE THIS IN A DATABSE, SCALABILITY AND BUILD UPON THIS. ALSO WE NEED TO LOOK AT THESE COMMANDS AND MAKE SURE THEY WORK AS I INTENDED AND CAN WE MAKE IT BETTER OR MORE ORGANISED"

**A-03 Hatches, what is wrong (question 2).** "Too many names", "Wrong scale". (Not ticked: layer or pen wrong; loses its outline.)

**A-04 Dims and leaders (question 3).** "Work fine", "Want more", typed "ARC DIMESNION".

**A-05 C, the repeat copy (question 4).** "Retire it, use Copy" (the recommended option: C runs AutoCAD's own Copy, which repeats until Enter; if a PC's Copy does not repeat, Tim sets COPYMODE to 0 himself). **Answers question 1 of `NAMES_C_AND_RC_PROPOSAL.md`.**

**A-06 MR, CR, CPB, DIV (question 4b).** "Work fine", and "DO YOU HAVE SUGGESTIONS". Suggestions are in ST-03 to ST-05.

**A-07 Clean-up (question 5).** "Should be one tool", and: "I USE THIS COMMAND VERY OFTEN AS THE MAIN TOOL FOR SAVING THE DRAWING SO WE NEED TO WORK OUT HOW THIS WORKS AND CAN BE REPLICATED QUICKLY AND OFTEN".

**A-08 Revision cloud name (question 6).** "REVBOX / RV". **Answers question 2 of `NAMES_C_AND_RC_PROPOSAL.md`.**

**A-09 Slab joints (question 6b).** "CAN WE USE CJ / CONSTRUCTIONJOINT AND SSC / SAWCUT. ALSO THEY DONT WORK PERFECTLY AT THE MOMENT TEXT DOESNT GET PLACED HOW I WANT IT TO BE AND THERES NOTHING TO HELP THIS PROCESS OR LEARN FROM HOW AND WHERE THEY ARE PLACED".

**A-10 Blocks palette (question 6c).** Ticked "Hard to find blocks", "Blocks break or differ". Typed: "TOOLPALETTE JUST WORKS BETTER, IT INSERTS THE BLOCKS WRONG, THERES NOT SETTINGS LIKE REGULAR TOOL PALETTES AND I WOULD USE TOOL PALETTES BUT ITS CLUNKY/SLOW TO QUICKLY ADD OR REMOVE BLOCKS AND THEIR SETTINGS".

**A-11 What the Manager should do (question 7).** All four ticked: "Updates and version", "Health and fault report", "Office lists", "Job link".

**A-12 What the Manager should not do (question 7b).** Ticked "No drawing tools". Typed: "I WANT THE ADMIN DASHBOARD BUT IS THERE A BETTER WAY FOR A SMALL PROGRAM LIKE THIS?" (Not ticked: no usage records, no own ribbon tab, no admin dashboard.)

**A-13 Admin shape (question 8).** "One admin page": one page in the Manager that only Tim sees, with each PC's version, faults this week, and one "approve this update for everyone" button; no canary rollout or policy pages.

**A-14 First in order of importance (question 8b).** "CLEAN (save + tidy)".

**A-15 The rest of the order (question 9).** "JUST DO THEM IN ANY ORDER AND RELEASE THEM ALL IN THE FIRST ISSUE RELEASE".

**A-16 Where the tools sit (question 9b).** "WE SHOULD HAVE THREE TABS CE CIVIL, CE TOOLS&MANAGER  & CE STRUCTURAL (BETTER NAMES FOR ALL)".

**A-17 Message sent mid-interview (verbatim, paths kept, they hold no client detail):**
> "C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dxf" / "...\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg" / "...\Drawings Templates\A1 Templates\CE_A1_C01 - VERTICAL.dwg"
> "THIS SHOULD HAVE BLOCKS, HATCHES AND MORE"
> "ALSO I WANT TO BUILD STATISTICS, ADMIN CONTROL AND A BETTER OVCERALL SYSTEM THIS CAN COME LATER BUT ADD TO FUTURE IDEAS. PLEASE MAKE SURE WE ALWAYS HAVE REVISION NUMBERS, ID NUMBERS FOR ALL BUGS, IDEAS AND ANYTHING ELSE"

---

## 2. What the office master drawing holds (read from the DXF copy, read only)

1. **Blocks:** 453 block definitions not counting AutoCAD's own hidden ones; **174 have proper names** (for example Stormwater Pit, PIT BLOCK 3, DOWNPIPE DYNAMIC WITH MASK, FLOOR WASTE DYNAMIC WITH MASK, TRENCH GRATE, FALL SYMBOL, SECT MARK, the bracing, support, beam label and bored pier blocks, the schedules) and **279 are machine-named** ("A$C" plus a code). TOOLS_TODAY T-019 already records that a palette tool pointing at a machine-named block breaks when that block is purged or re-pasted. This is one likely reason for "Blocks break or differ".
2. **Two leftovers from CPB:** blocks named `CE_CPB_20260325_143832` and `CE_CPB_20260326_093702`. CPB names its block by date and time, so these pile up in drawings.
3. **Layers:** 189.
4. **Hatch patterns used in it:** SOLID (most), ANSI31, AR-CONC, EARTH, WOODFACE, JIS_LC_8A, DOTS, ANSI37, CROSS, AR-SAND, HONEY, BRASS, GRASS, plus user-defined line hatches.
5. **Not read:** the DWG itself (the DXF was read instead) and the A1 vertical template. Which blocks are dynamic and which carry attributes the tools must fill: not checked.

---

## 3. Proposed shared tools (all in the first issue release, A-15)

Every name below is checked against Tim's alias list only. **None is checked against AutoCAD 2027's own short names yet**: the night run must check each before it is used. Names clashing with his alias list are marked.

**ST-01 CLEAN (save and tidy, one tool)**
1. **What it does:** Tim's everyday save. In one go: purge, Xrefs onto the office Xref layer (today's XRL), office layers and styles in (today's LU), text styles merged (today's MTS), regenerate, save. The steps are ticks in a small window remembered from last time; typing CLEAN just runs it with the remembered ticks and prints one line saying what it did.
2. **Who uses it:** everyone, civil and structural, many times a day.
3. **What to fix:** first find out exactly what today's CLEAN does, step by step, and how long each step takes on a real-size drawing (A-07: "work out how this works"). Make it fast enough to run on every save (a time limit to go in `stage6\PERFORMANCE.md`). Never purge a block, layer or style the plug-in's own things use. Replaces four commands with one.
4. **Typed name:** CLEAN (Tim types it today; not in his alias list). Whether it also gets a short name: TQ-03.
5. **Priority:** 1 (A-14).

**ST-02 Dimensions and leaders**
1. **What it does:** LD linear and AD aligned dimension on the office layer and style; Q arrow leader; QD dot leader; DUP switches dimensions from the 1:20 to the 1:100 set-up; plus a new **arc dimension** (A-04; the old Structural program had one as CE_ARCDIM / RD).
2. **Who uses it:** civil and structural.
3. **What to fix:** nothing reported ("Work fine"). Bring them across as they work today, one copy only, with sizes read from the office list (plans are 1:1 with a 1:100 viewport, D-194), so a later change is a list edit, not new code.
4. **Typed names:** LD, AD, QD, DUP kept. **Q clashes** with Tim's alias list (`q, *mltim`): TQ-04. Arc dimension: proposal ARCDIM / RD (RD not in his alias list).
5. **Priority:** first release, any order.

**ST-03 Move and rotate, copy and rotate**
1. **What it does:** MR moves the picked objects then rotates them at the new spot; CR copies then rotates the copy.
2. **Who uses it:** civil and structural.
3. **What to fix (suggestions, A-06):** today it lives in five places (shared LISP, Structural LISP, Civil hidden, a C++ part, a test bundle); keep exactly one. Show the objects turning live under the cursor; let the angle snap to a picked line (a fence, a boundary, a wall); remember the last angle typed.
4. **Typed names:** MR, CR (not in his alias list). Long names MOVEROTATE, COPYROTATE proposed.
5. **Priority:** first release, any order.

**ST-04 Copy-paste as block**
1. **What it does:** copies the picked objects and pastes them back as one block.
2. **Who uses it:** civil and structural (10 runs recorded).
3. **What to fix (suggestion):** today it names the block by date and time (two such blocks are already in the office master drawing). Ask for a name, offering a sensible one, pick the base point, put it on the office blocks layer.
4. **Typed name:** CPB (not in his alias list). Long name COPYASBLOCK proposed.
5. **Priority:** first release, any order.

**ST-05 Divide (DIV, DIVX)**
1. **What it does:** divides a line with cross marks (DIV) or a block (DIVX).
2. **Who uses it:** recorded as structural (10 runs); Tim ticked the move / copy group as used on both.
3. **What to fix (suggestion):** **DIV clashes** with Tim's alias list (`Div, *Divide`, AutoCAD's own Divide). AutoCAD's own DIVIDE and MEASURE already place a block along a line. Suggest retiring DIV and DIVX like C, unless the cross mark does something DIVIDE cannot: TQ-05.
4. **Typed name:** none if retired.
5. **Priority:** first release if kept.

**ST-06 Hatches, one window**
1. **What it does:** one hatch tool that works like AutoCAD's own Hatch window (D-058, D-062): pick the office hatch from a short named list (Earth, Concrete, Waffle pod, Load-bearing wall over / under, the pen-colour hatches by their plain names), and it lands at the right scale for the drawing. Replaces about 43 number-named commands (10H, 21H, 238H and so on). H2A (re-attach a hatch to its outline) becomes a button in the same window or goes.
2. **Who uses it:** civil and structural.
3. **What to fix:** "Too many names", "Wrong scale" (A-03). The list of office hatches, their pattern, pen and scale comes from the office master drawing (A-17) into one office list, so a new hatch is a list line, not code. The scale follows the layout's viewport scale (D-194), so it is right at 1:100 and 1:20 alike.
4. **Typed name:** open (TQ-06). It must be a plain word with a short name and must not take H or HE (his alias list's Hatch and Hatchedit). Today's EH and CH do not carry over: **CH clashes** with `Ch, *Chamfer` in his alias list.
5. **Priority:** first release; Tim: "NEEDS WORK THOUGH BEFORE GOING OUT".

**ST-07 Revision box**
1. **What it does:** a rectangular revision cloud at the office arc size.
2. **Who uses it:** civil and structural.
3. **What to fix:** new name only; the snap question it asks first today could go (TQ-07). One copy, not two.
4. **Typed name:** **REVBOX / RV** (A-08). RV is not in his alias list; still to be checked against AutoCAD's own names.
5. **Priority:** first release, any order.

**ST-08 Break line**
1. **What it does:** draws the office break line symbol.
2. **Who uses it:** civil and structural (A-01).
3. **What to fix:** **BL clashes** with Tim's alias list (`Bl, *Block`). Needs a new name: TQ-08.
4. **Typed name:** proposal BREAKLINE / BK (BK not in his alias list; not checked against AutoCAD's own).
5. **Priority:** first release, any order.

**ST-09 Construction joint and saw cut**
1. **What it does:** draws a construction joint or saw cut line with its label, the same for slabs on civil and structural sheets. Replaces structural CJ / SSC / CJSS and civil CDJOINT / CDCJ / CDSC.
2. **Who uses it:** civil and structural (SSC 21 runs).
3. **What to fix:** "TEXT DOESNT GET PLACED HOW I WANT IT TO BE AND THERES NOTHING TO HELP THIS PROCESS OR LEARN FROM HOW AND WHERE THEY ARE PLACED" (A-09). Proposal: read where the label sits on issued office sheets and make that the default; a label moved by hand keeps its offset and moves with the line (the same rule as pits, D-181); the office list holds the label wording and offsets. How it should "learn": TQ-09.
4. **Typed names:** **CONSTRUCTIONJOINT / CJ** and **SAWCUT / SSC** (Tim's words). Neither CJ nor SSC is in his alias list; not checked against AutoCAD's own.
5. **Priority:** first release, any order.

**ST-10 Blocks palette**
1. **What it does:** a palette of the office blocks from the office master drawing (A-17), grouped and searchable, that inserts each block correctly (right layer, scale, rotation, attributes) and is quick to add to or remove from.
2. **Who uses it:** civil and structural.
3. **What to fix:** today's CEBLOCKS "INSERTS THE BLOCKS WRONG", has no per-tool settings like AutoCAD's tool palettes, blocks are hard to find, and blocks break or differ (A-10). AutoCAD's own tool palettes "JUST WORK BETTER" but are slow to add or remove blocks and their settings. Proposal: one office list of blocks (block name, group, layer, scale rule, rotation rule) read from the master drawing; the palette is built from that list, so adding a block is one line; blocks with a CE tool (pit, downpipe, inspection opening) are placed by their tool, not the palette. Fix the 279 machine-named blocks in the master drawing before any tool points at them (TQ-10).
4. **Typed name:** proposal BLOCKS / BLK? (BLK is not in his alias list; not checked against AutoCAD's own): TQ-11.
5. **Priority:** first release, any order.

**Not shared tools (stay where they are):** C (retired, A-05); Excel into text and plot to PDF (not ticked as used on both); centreline, level mark, section mark, FFL tag (not ticked); the pen and line type quick-set, text tags, beams, bracing, supports, footings (structural only, parked by D-006).

---

## 4. The Manager

**MG-01 Updates and version.** Says which version is running; offers a new version when AutoCAD starts; one click to install or go back, no administrator rights (D-028).

**MG-02 Health and fault report.** One button for "something is wrong": checks the install and sends a fault report with the logs, private text scrubbed (the old scrub is worth keeping, parts bin item 29).

**MG-03 Office lists (administrator only).** One place to edit the office lists: standards, typed names, the block list (ST-10), the hatch list (ST-06), CLEAN's steps (ST-01). The plug-in never edits Tim's own alias file (D-170).

**MG-04 Job link.** Hands the Job Manager program what only the drawing knows (stage, what was issued and when, time on the drawing, assumptions still open), per D-071 to D-073. The tracking itself lives in the Job Manager, not here.

**MG-05 One admin page.** Only Tim sees it: each PC's version, faults this week, one "approve this update for everyone" button. No canary rollout, machine or policy pages (A-13).

**MG-06 Not in the Manager:** no drawing tools (no drawing repair, survey intake or project QA pages) (A-12).

---

## 5. Ribbon: three tabs (A-16)

1. **Tim's words:** "THREE TABS CE CIVIL, CE TOOLS&MANAGER & CE STRUCTURAL (BETTER NAMES FOR ALL)".
2. **Proposal for the names (TQ-01):** CE Civil, CE Draft, CE Structural; or CE Drainage, CE Tools, CE Structural. The Manager would be one button at the end of the middle tab.
3. **The CE Structural tab** is empty until structural is unparked (D-006), unless Tim says otherwise (TQ-02).

---

## 6. Future ideas (A-17: "THIS CAN COME LATER")

**FI-01 Statistics:** "I WANT TO BUILD STATISTICS".
**FI-02 Admin control:** fuller admin control than the one admin page (MG-05).
**FI-03 A better overall system:** "A BETTER OVCERALL SYSTEM".
**FI-04 Joint labels that learn** from where they are placed on issued sheets, beyond the first-release default (ST-09).

These go into the plan's idea file with the planning chat's own numbers; this file keeps FI- numbers so the link stays traceable.

---

## 7. Open questions for Tim

**TQ-01** Names for the three tabs (section 5).
**TQ-02** Does the CE Structural tab appear in the first release, empty or with only the shared tools, or stay hidden until structural is unparked?
**TQ-03** Does CLEAN get a short name, or stay CLEAN only?
**TQ-04** Q clashes with "q, *mltim" in his alias list. Keep Q (his alias would have to move) or a new short name such as QL?
**TQ-05** DIV and DIVX: retire them for AutoCAD's own DIVIDE and MEASURE, or keep under new names?
**TQ-06** Plain word and short name for the hatch window (it must not take H or HE, which are his alias list's Hatch and Hatchedit).
**TQ-07** Should the revision box still ask about object snap first?
**TQ-08** BREAKLINE / BK for the break line, or another?
**TQ-09** What "learn from how and where they are placed" should mean for joint labels in the first release.
**TQ-10** May the master drawing's 279 machine-named blocks be renamed (on a copy first) so the palette and tools can point at them safely? Who owns that drawing's edits?
**TQ-11** Typed name for the blocks palette.
**TQ-12** Which hatches go in the office list: every pattern in the master drawing, or a short list Tim names?

---

## 8. Clashes with earlier decisions (for the planning chat to settle with Tim; nothing changed here)

**CX-01** A-16 (three tabs) differs from D-051 (one short CE Civil tab plus pop-up tabs). The pop-up tabs could stay as they are; the "one tab" part changes.
**CX-02** A-15 (all shared tools in the first issue release) differs from what `design\NAMES_C_AND_RC_PROPOSAL.md` says ("CE everyday helpers are out, D-097 to D-100"). D-097 did not list helpers either way, so this adds to the first release; it also adds to D-091 "one tool at a time" pacing.
**CX-03** D-006 parks structural; the shared tools are used on structural sheets too. Read as: shared tools are in, structural-only tools stay parked.
**CX-04** A-17 asks for revision numbers and ID numbers on all bugs, ideas "AND ANYTHING ELSE": a standing rule for the plan's files, to be filed as a decision.

---

## 8a. Revision 2 additions (18 Nov 2026, late afternoon; answers TA-018 to TA-042 in `interview_tools\ANSWERS.md`)

Names checked against the acad.pgp copy and Tim's alias list; full words still need the night run's one-type check.

1. **Settled:** tabs CE Civil · CE Tools · CE Structural, the structural one hidden until it has tools (TA-018, TA-019). CLEAN / CN (TA-020). Arrow leader QL; Tim keeps his own Q (TA-021). BREAKLINE / BL; Tim moves his own Bl alias (TA-023). REVBOX keeps its snap question (TA-024). Blocks palette BLOCKS / BLK (TA-037).
2. **Upgrades:**
   - **ST-01 CLEAN:** also audit, zero stray Z heights, set drawing units, then save (TA-035).
   - **ST-02 dims:** add the arc dimension; dimension size follows the viewport, and already-drawn dimensions update too (TA-039).
   - **ST-03 / ST-04 MR, CR, CPB:** no changes (TA-036).
   - **ST-05 Divide:** kept (TA-022). It follows bends and arcs, the cross is sized for the sheet, and it previews the marks and reports the spacing as text (TA-032).
   - **ST-07 REVBOX:** can cloud any picked shape (TA-040).
   - **ST-08 BREAKLINE:** trims the lines it crosses (TA-040).
   - **ST-09 joints:**
     - **Dashes:** right at 1:100.
     - **Bends:** the line can have bends.
     - **Label:** full words, placed like 25T / 25B depending on what is around (TA-025, TA-033).
3. **New shared tools (to be named by the same rule):**
   - **ST-11 Text 25 and 18 set:** names kept, plus a TEXT window (TA-028, TA-034).
   - **ST-12 Pen quick-set** (TA-029).
   - **ST-13 Xref copy and paste** (TA-029).
   - **ST-14 Put on office layer (new)** (TA-029).
   - **ST-15 Viewport scale set and lock (new)** (TA-029).
   - **ST-16 Find and replace across layouts (new)** (TA-030).
   - **ST-17 Area label and length label (new):** each label updates itself (TA-031, TA-041).
   - **ST-18 Small office symbols** placed from the blocks palette: scabble, wipeout, cut tube (TA-031).
4. **Not wanted:**
   - **Marks:** CL, LM, SM, FFL tags.
   - **Multileaders and multilines:** MLL / MLR; CML / SML.
   - **Output:** plot to PDF; Excel into schedule; north point and scale bar.
   - **Finding:** command search.
   - **End offsets and numbering** on Divide.
5. **Master drawing blocks:** look through all 279 machine-named blocks (and the rest) on a copy, say what each is, then Tim decides which to keep and how to order them; "we might not need all blocks" (TA-038, TA-042).
6. **Still held:** TQ-06 hatch name and TQ-12 hatch list wait for research R-006 (D-199).

## 9. What was not done

1. AutoCAD was not opened; no name was checked against AutoCAD 2027's own short names.
2. The office master DWG and the A1 vertical template were not opened; only the DXF copy was read, as text.
3. What today's CLEAN does step by step, and how long it takes, was not measured (ST-01 needs this first).
4. This file is not committed to git; the planning chat owns saves in `C:\CE_PLAN`.
