# Tools, Manager and shared structural commands: Tim's answers

**Revision:** 2 (Wed 18 Nov 2026, afternoon, Melbourne time). Revision 1 used T-001 to T-017; renumbered TA-001 to TA-017 under D-205 (ID numbers never clash or get reused; T- belongs to `reference\today\TOOLS_TODAY.md`). The text of each answer is unchanged.
**Owner:** the tools interview side chat, reporting to the planning chat (D-198). Planning only: Tools, Manager and structural are not in the first release.
**Numbering:** TA-001 onwards, never reused. TA-001 to TA-017 here are A-01 to A-17 in `design\TOOLS_AND_MANAGER_INTERVIEW.md` (same text).
**Rule:** Tim's exact words in quotes. Clicked choices are given as the option he chose.

**TA-001 Used on both civil and structural drawings (question 1).** Ticked: Dims and leaders; Move / copy helpers; Clean-up and Xrefs. Typed: "RC, HATCHES, BL. HATCHES NEEDS WORK THOUGH BEFORE GOING OUT". Not ticked: centreline, level mark, section mark, FFL.

**TA-002 Second list (question 1b).** Ticked: Hatch presets; Slab joints; Blocks palette. Not ticked: Excel into text and plot to PDF. Typed, as the rule for the whole job:
> "NEED TO GO THROUGH EACH COMMAND, THINK, HOW CAN THIS BE BUILT BETTER, HOW CAN THIS BE PART OF THE OVERALL CODE IN A BETTER WYA, HOW CAN WE USE THIS IN A DATABSE, SCALABILITY AND BUILD UPON THIS. ALSO WE NEED TO LOOK AT THESE COMMANDS AND MAKE SURE THEY WORK AS I INTENDED AND CAN WE MAKE IT BETTER OR MORE ORGANISED"

**TA-003 Hatches, what is wrong (question 2).** "Too many names", "Wrong scale". (Not ticked: layer or pen wrong; loses its outline.)

**TA-004 Dims and leaders (question 3).** "Work fine", "Want more", typed "ARC DIMESNION".

**TA-005 C, the repeat copy (question 4).** "Retire it, use Copy" (the recommended option: C runs AutoCAD's own Copy, which repeats until Enter; if a PC's Copy does not repeat, Tim sets COPYMODE to 0 himself). **Answers question 1 of `NAMES_C_AND_RC_PROPOSAL.md`.**

**TA-006 MR, CR, CPB, DIV (question 4b).** "Work fine", and "DO YOU HAVE SUGGESTIONS". Suggestions are in ST-03 to ST-05.

**TA-007 Clean-up (question 5).** "Should be one tool", and: "I USE THIS COMMAND VERY OFTEN AS THE MAIN TOOL FOR SAVING THE DRAWING SO WE NEED TO WORK OUT HOW THIS WORKS AND CAN BE REPLICATED QUICKLY AND OFTEN".

**TA-008 Revision cloud name (question 6).** "REVBOX / RV". **Answers question 2 of `NAMES_C_AND_RC_PROPOSAL.md`.**

**TA-009 Slab joints (question 6b).** "CAN WE USE CJ / CONSTRUCTIONJOINT AND SSC / SAWCUT. ALSO THEY DONT WORK PERFECTLY AT THE MOMENT TEXT DOESNT GET PLACED HOW I WANT IT TO BE AND THERES NOTHING TO HELP THIS PROCESS OR LEARN FROM HOW AND WHERE THEY ARE PLACED".

**TA-010 Blocks palette (question 6c).** Ticked "Hard to find blocks", "Blocks break or differ". Typed: "TOOLPALETTE JUST WORKS BETTER, IT INSERTS THE BLOCKS WRONG, THERES NOT SETTINGS LIKE REGULAR TOOL PALETTES AND I WOULD USE TOOL PALETTES BUT ITS CLUNKY/SLOW TO QUICKLY ADD OR REMOVE BLOCKS AND THEIR SETTINGS".

**TA-011 What the Manager should do (question 7).** All four ticked: "Updates and version", "Health and fault report", "Office lists", "Job link".

**TA-012 What the Manager should not do (question 7b).** Ticked "No drawing tools". Typed: "I WANT THE ADMIN DASHBOARD BUT IS THERE A BETTER WAY FOR A SMALL PROGRAM LIKE THIS?" (Not ticked: no usage records, no own ribbon tab, no admin dashboard.)

**TA-013 Admin shape (question 8).** "One admin page": one page in the Manager that only Tim sees, with each PC's version, faults this week, and one "approve this update for everyone" button; no canary rollout or policy pages.

**TA-014 First in order of importance (question 8b).** "CLEAN (save + tidy)".

**TA-015 The rest of the order (question 9).** "JUST DO THEM IN ANY ORDER AND RELEASE THEM ALL IN THE FIRST ISSUE RELEASE".

**TA-016 Where the tools sit (question 9b).** "WE SHOULD HAVE THREE TABS CE CIVIL, CE TOOLS&MANAGER  & CE STRUCTURAL (BETTER NAMES FOR ALL)".

**TA-017 Message sent mid-interview (verbatim, paths kept, they hold no client detail):**
> "C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Drafting\Drawings Templates\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dxf" / "...\CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES.dwg" / "...\Drawings Templates\A1 Templates\CE_A1_C01 - VERTICAL.dwg"
> "THIS SHOULD HAVE BLOCKS, HATCHES AND MORE"
> "ALSO I WANT TO BUILD STATISTICS, ADMIN CONTROL AND A BETTER OVCERALL SYSTEM THIS CAN COME LATER BUT ADD TO FUTURE IDEAS. PLEASE MAKE SURE WE ALWAYS HAVE REVISION NUMBERS, ID NUMBERS FOR ALL BUGS, IDEAS AND ANYTHING ELSE"

## Batch 10 (18 Nov 2026, afternoon; names checked against the acad.pgp copy and his alias list inside each question)

**TA-018 Tab names (TQ-01).** "CE Civil/Tools/Structural": the three tabs are CE Civil, CE Tools, CE Structural.

**TA-019 Structural tab before structural is built (TQ-02).** "Hidden until it has tools".

**TA-020 Short name for CLEAN (TQ-03).** "CLEAN plus CN" (CN free in both lists).

**TA-021 His Q (TQ-04).** "Keep my Q; leader is QL": his alias q (mltim) stays; the CE arrow leader becomes QL (free in both lists). What mltim is: not said.

## Batch 11

**TA-022 DIV and DIVX (TQ-05).** "OUR DIVIDE IS SIMILAR BUT HAS UPGRADES, RESEARCH WHAT THEY ARE AND EXPLAIN HOW IT COULD BE EVEN BETTER". (Researched in the old code and put back to him in batch 12.)

**TA-023 Break line (TQ-08).** "WE USE BREAKLINE / BL, I WILL CHNAGE ALIASES". So BREAKLINE / BL; Tim moves his own "Bl, *Block" alias himself. Still to check: BREAKLINE as an Express Tools command name.

**TA-024 Revision box and object snap (TQ-07).** "Keep the question".

**TA-025 Joint labels (TQ-09).** "EXPLAIN HOW IT WORKS NOW AND THEN ILL EXPLAIN WHATS WRONG. LINETYPE AND REGULAR LINE NEEDS TO WORK PROPERLY AND THEN THE TEXT NEEDS TO BE PLACED SIMILAR TO 25T OR 25B DEPENDING ON WHATS AROUND."

**TA-026 Message during batch 11.** "WE HAVE THE OPPORTUNINITY NOW TO UPGRADE, IMPROVE AND ADD EXTRA FUNCTIONALITY TO ALL OF THESE COMMANDS RIGHT NOW, CAN YOU INTERVIEW ME ABOUT THIS ALSO BEFORE BUILDING. ALSO WE HAVE MISSED TEXT COMMANDS AND OTHER THINGS LIKE THAT"

## Batch 12 (DIV upgrades, joint line faults, text tools, missed commands)

**TA-027** Batch 12 was not answered by clicking; Tim sent this message instead, recorded as his answer: "ARE THERE ANY OTHER COMMANDS THAT CAN BE ADDED TO TOOLS". So batch 12 is not re-asked in that form; batch 13 answered his question.

## Batch 13 (other commands that could join CE Tools; old ones and NEW ideas marked)

**TA-028 Text and marks.** Ticked "Text 25 and 18 set" only. Not ticked: marks (CL, LM, SM, FFL tags), multileaders MLL / MLR, multilines CML / SML.

**TA-029 Layers, Xrefs and viewports.** Ticked all four: "Pen quick-set", "Xref copy and paste", "NEW: put on office layer", "NEW: viewport scale".

**TA-030 Output and sheets.** Ticked "NEW: find and replace" only. Not ticked: plot to PDF, Excel into schedule, north point and scale bar.

**TA-031 Finding and measuring.** Ticked "NEW: area label", "NEW: length label", "Small office symbols". Not ticked: command search (old CEPALETTE).

## Batch 14 (upgrades: divide, joints, text set)

**TA-032 Divide upgrades.** "Follow bends, visible cross", "Preview and spacing text". Not ticked: end offsets, numbering each one.

**TA-033 Joint line faults.** "Dashes wrong at 1:100", "Needs bends", "Label words". Not ticked: layer or linetype wrong. (With TA-025: text placed like 25T / 25B depending on what is around.)

**TA-034 Text 25 and 18 set.** "Keep names, add window": 25T, 25B and the rest stay; a TEXT window (size, side, angle, remembers last) is added.

## Batch 15 (upgrades: CLEAN, MR / CR / CPB; blocks palette name; master drawing blocks)

**TA-035 CLEAN / CN upgrades.** "Fix common faults" (also audit, zero stray Z heights, set the drawing units, then save). Not ticked: one-line report, safe purge, ticks remembered.

**TA-036 MR / CR / CPB upgrades.** "Fine as they are": one copy of each, no changes.

**TA-037 Blocks palette name (TQ-11).** "BLOCKS / BLK".

**TA-038 Machine-named blocks in the master drawing (TQ-10).** "yes on a copy, you need to look throught hem all see what they are and then we can decide and order and organise them all".

## Batch 16 (upgrades: dims, revision box and break line; live area and length labels)

**TA-039 Dims and leaders upgrades.** "Fine, plus arc dim only", and typed: "scale follows viewport, but it only works on creation it doesnt update already created dims". Read as: dimension size should follow the viewport, including dimensions already drawn, not only new ones.

**TA-040 REVBOX and BREAKLINE upgrades.** "Cloud any shape" (REVBOX can also cloud round a picked polyline), "Break line trims" (BREAKLINE trims the lines it crosses).

**TA-041 Area and length labels.** "Yes, update by itself" (an AutoCAD field, so it still works on a PC without the plug-in).

**TA-042 Message during batch 16, on the master drawing blocks.** "we might not need all blocks". With TA-038: look through them all, then decide which to keep, order and organise them.

## Batch 17 (first release size; hatch name, list and linking, after R-006)

**TA-043 First release size (asked once, as the planning chat ruled).** "all 18 but we need to make sure they all work and are tested before release. a lot of it already works and has been tested so it shouldnt take as long".

**TA-044 Hatch tool name (TQ-06).** "OFFICEHATCH / OH" (OH free in both lists; the full word still to be typed once in AutoCAD).

**TA-045 Hatch list (TQ-12).** "give me a list of strucutral and civil hatches and then a visual and i will tick off what is and isnt needed".

**TA-046 Hatches linked to their outline.** "Always linked": every hatch the new tool makes is associative; his AutoCAD settings are put back after.

**TA-047 Message instead of ticking the hatch pictures.** "theres lots of overlapping here and we normally discuss them based on what they do and the layer theyre on, can you please look into this using old project evidence as well, some hatches have served multiple functions like the hatch 74 is used for subfloor framing on first floor typically and its also used on suspedned slabs as the band beam hatch". So the hatch list is to be sorted by what each hatch does and its layer, checked against old project evidence. Fact about practice: HATCH 74 = subfloor framing on a first floor, and the band beam hatch on suspended slabs.

**TA-048 Message.** "also check what layer each hatch is on in the old jobs". Answered by `interview_tools\HATCHES_BY_FUNCTION.md` (HF- by function, HL- by layer, 218 drawings from 21 old jobs).

## Batch 18 (hatch overlaps from the old-job evidence)

**TA-049 HATCH 74.** "All three on HATCH 74": first floor over, band beam and rain garden all stay on HATCH 74, each a separate choice in the list.

**TA-050 Set-down.** "HATCH 51 set-down"; HATCH 238 kept for bathtub and extra-load areas.

**TA-051 Existing to be retained.** "HATCH 201 only"; WALLS EXISTING HATCH, EXISTING WALL HATCH and EXISTING DETAIL retired from the list.

**TA-052 Sections.** "HATCH 21 conc, EARTH earth": concrete in section on HATCH 21, earth on HATCH EARTH; HATCH 11 keeps only "load bearing wall over".

## Batch 19 (more hatch overlaps)

**TA-053 Walls.** "Over, under, brick, block". Four choices kept:
1. **Wall over:** HATCH 11 - LOAD BEARING WALL OVER.
2. **Wall under:** HATCH 231 - LOAD BEARING WALL UNDER.
3. **Brick and block:** WALL HATCH.
4. **Retaining block:** BLOCKWORK WALL.

LOADBEARING WALL, LOADBEARING HATCH and BLOCK RETAINING WALL are retired from the list.

**TA-054 HATCH 141.** "Roof trusses only".

**TA-055 Two names for one thing.** "Keep HATCH TIMBER / WATER"; TIMBER HATCH and WATER HATCH retired from the list.

**TA-056 Layers in old jobs but not in the master (HATCH 155, 70, 221, 45, SAND, FILL, PT, HATCH-SLAB INFILL).** "Show me each first".

**TA-057 Message.** "make sure you look at the scale as well". Answered in `interview_tools\HATCHES_BY_FUNCTION.md` section "Scale": old jobs mostly use HATCH 21 AR-CONC at 3 (master samples 1 to 2), EARTH at 40, brick and block at 110, timber at 1000, stud wall at 800.

Next free number: TA-058
