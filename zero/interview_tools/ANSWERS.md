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

## Batch 20 (hatch scale; post-tensioned slab; extra layers)

**TA-058 Hatch scale.** "always from ltscale and dimscale. but we need to base it from our existing scales at dimscale 100 ltscale 1000". So OFFICEHATCH reads the drawing's DIMSCALE and LTSCALE; each hatch's base scale is the office scale at DIMSCALE 100 / LTSCALE 1000, and changes in proportion.

**TA-059 Post-tensioned slab.** "HATCH PANTONE"; HATCH PT retired from the list.

**TA-060 The other extra layers (HATCH 155, 70, 221, 45, SAND, FILL, HATCH-SLAB INFILL).** "keep them all". What each means is still to be named by Tim (HATCH 155, 70, 221 and HATCH-SLAB INFILL had no legend beside them).

## Batch 21 (base scales)

**TA-061 AR-CONC base scale (HATCH 21, concrete in section).** "5" at DIMSCALE 100 / LTSCALE 1000.

**TA-062 When DIMSCALE and LTSCALE disagree.** "DIMSCALE leads": hatch scale = base x DIMSCALE / 100.

**TA-063 Meaning of HATCH 155, HATCH 70, HATCH 221, HATCH-SLAB INFILL.** "Not sure either": kept in the list, meaning marked unknown.

## Batch 22 and 23 (the ten block decisions, `design\BLOCKS_REVIEW.md`; picture `pictures\blocks_pits_inlets.png`)

**TA-064 Office pit.** "PIT BLOCK 3 (BK-020)". Note: the night tests and the new Pit tool's DRAFT use "Stormwater Pit" (D-197); this answer changes that, for the planning chat to carry to the build.

**TA-065 Inlet set.** "The WITH MASK set": the DYNAMIC WITH MASK downpipe, IO, GIO, overflow, grated overflow, floor waste, from above and to below. BK-012 FLOOR WASTE, its copy BK-034 and BK-027 retire from the palette.

**TA-066 Pipe description labels.** "Drop them" (the Pipe tool writes its own label).

**TA-067 Left / right and top / bottom pairs.** "One dynamic block each" (when structural is unparked).

**TA-068 The 104 blocks whose purpose is unknown.** "Picture sheets, I tick".

**TA-069 The 65 notes held as blocks.** "Outside the palette": they stay in the master drawing only.

**TA-070 BK-450, a whole sheet held as one block.** "Drop it".

**TA-071 The 33 drop-candidates.** "Drop all 33".

**TA-072 The 181 structural blocks.** "Not yet": they stay in the master and join a structural palette when the CE Structural tab arrives.

**TA-073 The 51 exact copies.** "Merge all 51", on a copy of the master first, replacing the master only on Tim's word.

**TA-074 Ticking the 54 unknown blocks.** "the issue i have is i dont know what we do have so its hard for me to know what to get rid of and what not to". So a picture of what the palette would hold after his decisions (32 blocks) was drawn first: `pictures\blocks_palette_now.png`.

**TA-075 The palette, after seeing what it would hold.** "remove bk-22, 91, 410, 25, 9,13,14,15,16,18,19,24,23,20 as they are not needed and or covered in the plugin. add bk413, 81, 414, 416, 420, 417, 425, 430, 432, 433, 436, 434, 443, 453, 452, 451, 438, 446".
1. **Removed from the palette** (the CE tools place them, or not needed): BK-020 PIT BLOCK 3, BK-022 Stormwater Pit, the inlet set (BK-009, 013, 014, 015, 016, 018, 019, 024), BK-023 strip drain label, BK-025 trench grate, BK-091 Section Flag, BK-410 SCREW PILES. PIT BLOCK 3 is still the block the PIT tool draws (TA-064).
2. **Added from the 54 unknown blocks (all machine-named, each needs a proper name):**
   - **BK-081:** TPZ / SRZ / gas pipe legend.
   - **BK-413 and BK-414:** retaining wall details.
   - **BK-416:** RL / RB schedule.
   - **BK-436:** block wall schedule.
   - **BK-438:** strip and pad footing schedule.
   - **BK-434:** large shaded area.
   - **BK-446:** concrete pier hatch.
   - **Small symbols:** BK-417, 420, 425, 430, 432, 433, 443, 451, 452, 453.
3. **Result:** the palette holds 37 blocks: 19 of the earlier 32 plus these 18.

**TA-076 Names for the 18 blocks added to the palette (TQ-13; picture `pictures\blocks_added18.png`).** Tim's words: "81 - CIVIL LINETYPES, 413 - WALL SCHEDULE, 414 - SLEEPER RETAINING WALL SCHEDULE, 416 - MEMBER SCHEDULE, 417 - WAFFLE POD SETOUT 420 - PFC WITH PLATE, 425 - PFC WITH EQUAL ANGLE, 430 - DINCEL BLOCK, 432 - PFC WITH WITH UNEQUAL ANGLE, 433 - T BRACKET, 434 - SHADOW BOX FILLED, 436 - WALL SCHEDULE 2, 438 - FOOTING SCHEDULE, 443 - BOLT, 446- BORED PIER, 451 - WATERSTOP, 452 - ROUND BREAKLINE, 453 - DOWEL BAR". So, as block names:
1. **BK-081:** CIVIL LINETYPES.
2. **BK-413:** WALL SCHEDULE.
3. **BK-414:** SLEEPER RETAINING WALL SCHEDULE.
4. **BK-416:** MEMBER SCHEDULE.
5. **BK-417:** WAFFLE POD SETOUT.
6. **BK-420:** PFC WITH PLATE.
7. **BK-425:** PFC WITH EQUAL ANGLE.
8. **BK-430:** DINCEL BLOCK.
9. **BK-432:** PFC WITH UNEQUAL ANGLE ("WITH WITH" in his words read as a typing slip).
10. **BK-433:** T BRACKET.
11. **BK-434:** SHADOW BOX FILLED.
12. **BK-436:** WALL SCHEDULE 2.
13. **BK-438:** FOOTING SCHEDULE.
14. **BK-443:** BOLT.
15. **BK-446:** BORED PIER.
16. **BK-451:** WATERSTOP.
17. **BK-452:** ROUND BREAKLINE.
18. **BK-453:** DOWEL BAR.

Learnt: the planning chat's guesses for 417, 420, 425, 430, 432, 433, 443, 451 and 453 were wrong (it had read the PFC and angle sections as post brackets, the Dincel block as a panel with openings, the dowel bar as a sand bed). The office names blocks plainly, with no "SYMBOL -" or "MARK -" prefix.

## Batch 24 and 25 (CLEAN / CN step by step; `interview_tools\CLEAN_STEPS.md`)

**TA-077 Purge (CL-01).** "Purge, keep office ones": purge everything unused except the office layers, blocks and styles the CE tools use.

**TA-078 Text style (CL-03).** "Yes, as today": all text and multiline text to STANDARD, Arial Narrow.

**TA-079 Hatch default (CL-04).** "Stop resetting it": CN no longer sets SOLID on HATCH 21; OFFICEHATCH remembers the last pick.

**TA-080 Report.** "One line"; full detail to the log only.

**TA-081 Xrefs (CL-02).** "Yes, XREF colour 7".

**TA-082 Zero Z (CL-08).** "WE NEED TO FLATTEN EVERYTHING BUT CAN WE USE MY EXISTING TOOL. I WILL SEND IN CHAT". He then sent a screenshot of his own toolbar button "3D to 2D Command" (on his TIM toolbar) with the macro `^C^C_UCS;;_move;_all;;0,0,1e99;;_move;_all;;0,0,-1e99;;` and asked: "IS THAT A GOOD WAY TO DO IT?"

**TA-083 Audit (CL-07).** "Every CN".

**TA-084 Units (CL-09).** "Set mm, say so".

Answer given in chat (planning chat's reading, not Tim's words): his button is a good, proven way to flatten. It moves everything up by 1e99 and back down, so every height rounds to 0, sloping lines included. Its gaps:
1. **Locked and frozen layers:** objects on them are skipped by MOVE.
2. **Inside blocks:** the lines inside a block keep their heights.
3. **No report:** it never says what it flattened.

**TA-085 Flatten inside blocks?** "INSIDE BLOCKS AND XREFS".

**TA-086 Xrefs, after being told an Xref's lines live in the other file (opening and saving it changes it for everyone, and a reloaded new version is 3D again).** "Flatten the Xref file". So CN flattens:
1. **This drawing,** including locked and frozen layers, which are put back after.
2. **Inside blocks.**
3. **Each Xref's own file,** opened and saved by CN, with a backup copy first (as offered).

**For the build (planning chat's note):** this is the only CLEAN step that changes files other than the one open. It needs:
- a backup of each Xref file first;
- a check that the file is not read-only or open by someone else;
- a mention in the one-line report of each Xref file it changed.

**TA-087 FASTSAVE.** "Drop it, CN only": one command; its speed is measured every night against the PERFORMANCE.md limits.

## Batch 26 and 27 (the Manager in detail; `interview_tools\MANAGER_SPEC.md`)

**TA-088 Name.** "MANAGER / MG" (MG free in AutoCAD's list and his), plus a button at the end of the CE Tools tab.

**TA-089 Who decides a new version reaches the office.** "You approve first": Tim sees it first and presses "approve for everyone" on his admin page; only then are colleagues offered it.

**TA-090 How the update offer looks.** "Small window": at AutoCAD start, a small window with "Install now" and "Later".

**TA-091 What changed.** "3 lines, plain words": the first time AutoCAD opens on a new version, up to three plain lines, with a link to the full list.

**TA-092 Fault report.** "Include the drawing": the report always carries the drawing, as well as the CE log, the version and what the person was doing.

**TA-093 Office list changes reach colleagues.** "Next AutoCAD start"; an open drawing says one line and offers to switch (D-180).

**TA-094 Which job a drawing belongs to.** "From the folder": read the job number from the drawing's folder or file name by the office naming pattern; ask once if it cannot tell.

**TA-095 Admin page, beyond versions, faults and "approve for everyone".** "Who is on an old version", "Go back for everyone", "Office list changes".

**TA-096 Message.** "CAN YOU ADD STATISTICS TO THIS RELEASE?" This brings statistics (future idea FI-01) into the first release, on Tim's admin page.

**TA-097 Which statistics.** All four ticked: "Tool use counts", "Time a tool takes", "Faults per tool", "Time per job".

**TA-098 Who is shown.** "Same as job hours": totals for everyone; per person only on Tim's admin page (as D-073).

## Batch 28 (the three open Manager details)

**TA-099 How a PC knows Tim is the administrator.** "Your Windows sign-in": a short admin list in the office IT folder names his Windows sign-in; only he can change it.

**TA-100 "Go back for everyone" while a colleague has AutoCAD open.** "Small window now": their AutoCAD shows the small window at once ("Go back: Now / At next start"); nothing closes their drawing.

**TA-101 How long fault reports (with drawings) are kept.** "90 days", then the report and its drawing copy are deleted, and Tim is told first.

## Batch 29 to 31 (OFFICEHATCH / OH in detail; `interview_tools\OFFICEHATCH_SPEC.md`, mock-ups `pictures\pick_an_oh_window.html`)

**TA-102 What OH opens (small window or the full CE window).** "SHOW BOTH TRIES AT IT". Both were drawn as mock-ups.

**TA-103 How the list is laid out.** "Grouped + search".

**TA-104 Picking the area.** "Click inside, keep going": like HATCH, Enter to finish; "select outline" also offered.

**TA-105 Changing a hatch already drawn.** "AutoCAD's own edit": double-click opens AutoCAD's normal Hatch Edit, not the OH window. This is an exception to D-061 (double-click opens the same small window) for hatches only.

**TA-106 After seeing both mock-ups.** "FULL WINDOW LOOKS GOOD BUT CAN WE MAKE MORE HATCHES VISIBLE AT ONE TIME? I DONT WANT TO SCROLL TOO MUCH". B was redrawn with every hatch as a real sample, 8 across, grouped, no scrolling.

**TA-107 The revised full window.** "Yes, that's it".

**TA-108 Legend line.** "Offer it, once per sheet": the first time a hatch is used on a sheet, "What else changes" offers its legend line; one tick, never forced.

**TA-109 Draw order.** "Always behind": every OH hatch goes behind the linework and text.

**TA-110 Existing hatches when DIMSCALE changes.** "Only new ones": hatches already drawn keep their scale. Note: this differs from his dimension ruling, where existing dimensions update (D-210).

## Batch 32 (the TEXT window, in words; no mock-ups until the approved style, D-286)

**TA-111 Name.** "OFFICETEXT / OT" (TEXT is AutoCAD's own command; OT is free in AutoCAD's list and his).

**TA-112 Size.** "All sizes follow DIMSCALE": every size is its sheet height x DIMSCALE. Today 25 already does; 18 is fixed at 180 and does not.

**TA-113 Which sizes.** "LOOK THROUGH EXISTING JOBS AND SEE WHAT THEY DO". Researched: `interview_tools\TEXT_SPEC.md`, evidence section.

**TA-114 Side of a line.** "Pick the clear side": 25T / 25B text goes on the side with less in the way; typing 25T or 25B still forces a side.

**TA-115 Message.** "WILL THE INDIVIDUAL COMMANDS STILL WORK?" Answer given: yes. TA-034 "Keep names, add window" stands: 25T, 25B, 25L, 25R, 25C, 25LC, 25RC, 18T, 18B, 18L and 18R keep working, and OT is the extra window.

**TA-116 Text layer number.** "Yes, layer is the pen": 18TEXT, 25TEXT, 35TEXT, 50TEXT and 70TEXT are pen weights; size is chosen separately.

**TA-117 Sizes offered.** "1.8 2.0 2.5 3.0 3.5 5.0 7.0" (sheet mm, all following DIMSCALE).

**TA-118 Capitals.** "As typed".

**TA-119 Text kind.** "Multiline always" for OT; 25T and the rest keep single-line as today.

## Batch 33 and 34 (CONSTRUCTIONJOINT / CJ, SAWCUT / SSC; `interview_tools\JOINTS_SPEC.md`)

**TA-120 Label words.** "CJ / SC plus legend": keep the short labels; a legend line ("SC DENOTES SAW CUT") offered once per sheet.

**TA-121 Layers.** "SLAB CJ / SLAB SC" (PHANTOM and DASHDOT2), lines and labels on them.

**TA-122 Dashes.** "Follow DIMSCALE": each joint line gets its own linetype scale from DIMSCALE.

**TA-123 Articulation joint.** "Add as third joint": ARTICULATIONJOINT / AJ (AJ free in both lists).

**TA-124 Drawing several.** "Keep drawing, Enter ends".

**TA-125 The CJ / SC swap.** "NEW COMMAND NAME BUT KEEP". Then: "JOINTSWAP / JS" (JS free in both lists).

Next free number: TA-126
