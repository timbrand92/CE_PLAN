# Current rulings: Drawing and sheets (1:1, units, layouts, layers, colours, blocks, templates, the no-plug-in rule)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Scale and units

1. **Plans are drawn at 1:1 and the paper layout scales them to 1:100;** model text and label sizes suit a 1:100 viewport, and the scale belongs to the layout, not the plan (D-194).
2. **Other plan scales are the once-a-year case** (D-169 with D-194).
3. **The office always draws 1:1 but sometimes with the drawing's units in metres;** the plug-in must work properly in both millimetre and metre drawings and must not refuse metre drawings (D-217). **Set aside for the one-job release by D-344 and D-380 (19 and 20 Nov):** units for the first job "Millimetres"; metre drawings go to the carpark (P-09 item 14) with their design page and the rounding call D-341; a drawing in metres is refused, saying plainly that metres are not supported yet (the planning chat's call in D-344, confirmed by Tim in D-380) (item 31).

### The no-plug-in rule

4. **Without the plug-in a drawing must look and plot identical, and this must be proven** (D-015).
5. **A person with no plug-in must be able to use the drawing as intended,** not only see and plot it: select, move, edit and add with plain AutoCAD, or at the very least explode and carry on (D-094).
6. **What is drawn is only ordinary AutoCAD linework, text and the office's own blocks** (D-094; THE_PLAN section 1).
7. **Live area and length labels are AutoCAD fields,** so they work without the plug-in (TA-041, under D-209).

### Templates, blocks and layers

8. **Drafters start a new job from the office template,** a clean start each time (D-191).
9. **The real tools use the office's own blocks and layouts exactly as drawn today** (D-039), and standards live in one place (D-013). **Where the blocks come from (D-352, 20 Nov):** a copy shipped with the tool, brought into a drawing that lacks them (item 33).
10. **The office master drawing of typical blocks, layers, schedules and notes "should have blocks, hatches and more"** (D-205).
11. **New pits use PIT BLOCK 3 exactly as it is,** and the old "Stormwater Pit" stays readable on old drawings (D-228, settling D-215); the inner wall is the wipeout's edge and the plug-in prompts the drafter to change the wipeout frame setting if it is not right, never changing it itself (D-224).
12. **The office master drawing:** nothing in it is changed by any chat until Tim says so; the 51 exact copies are merged on a copy of the master first and the master is replaced only on his word; the 65 notes held as blocks stay in the master drawing, outside the palette; BK-450 (a whole sheet as one block) and the 33 drop-candidates are dropped; pipe description label blocks are dropped; the 181 structural blocks wait for the CE Structural tab; left / right and top / bottom pairs become one dynamic block each when structural is unparked; the 104 blocks of unknown purpose go on picture sheets for Tim to tick (D-229).
13. **Detention pipes go on their own layer in a slightly different blue, with a legend line** (D-083): colour 160 (D-156); layer STORMWATER DETENTION PIPE, DASHED, not separately ruled (D-153).
14. **A pipe stops at the pit's inner wall line,** so new sheets differ from old ones at pit edges (D-102).
15. **Night tests use a copy of the office drawing template;** the office template folder is read only (D-197).
16. **A plain line on a stormwater layer drawn with no plug-in:** one line on opening with a "take it up" click (D-192).

### Sheets and output

17. **Today's sheets:** layout plan, notes and details, computations; long sections only when council asks (D-030).
18. **Title block and issue are not in the first release** (D-097).
19. **"Changed since last issue" with a "Mark as issued" button: "Yes, but later"** (D-187).
20. **Plotting with open items:** one quiet command-line line, never a stop (D-188).
21. **The pit schedule is placed once, grows downward, and the plug-in only warns when it may not fit** (D-109, D-114).

### Added 18 Nov 2026, D-230 to D-297

22. **The Blocks palette is 37 blocks (D-232):** Tim: "i dont know what we do have so its hard for me to know what to get rid of", so the interview chat drew what the palette would hold and he edited it: out came the pit and inlet blocks, the strip drain label and the trench grate ("covered in the plugin"), Section Flag and SCREW PILES; in went 18 of the 54 unknown blocks; the rest stay in the master drawing as spares. The four hatch layers of unknown meaning (HATCH 155, 70, 221, SLAB INFILL): "Not sure either"; they are kept and marked unknown. The 37 hatch sample squares in the master are a legend sample set, not the hatch list; the hatch tool reads the function list of D-227.
23. **One orifice pit detail per council in the library (D-253, not the recommended answer):** "The pits really differ by council"; Detention fills the job's figures into the detail that belongs to the job's council.
24. **Anything shown only on screen goes on one CE no-plot layer (D-275):** a small CE marker set not to plot, named in the office list, used for every on-screen-only CE mark (the first use is the end of a system).
25. **Layers made by the tools (D-260 DQ-005; planning chat's call from his rulings; his to overturn):** a missing layer is made with the office colour and said in one line; an existing layer is never changed (D-191). **Ruled by Tim in D-381 item 1 (20 Nov):** missing layers, text styles and linetypes are brought in from the tool's own copy of the office set-up, said once; nothing existing is changed (item 34).
26. **The long-section sheet layer and rows (D-276 DQ-039, DQ-040; planning chat's call from his rulings; his to overturn):** one SCHED layer as the three newest examples, to be checked against the office template when built; the rows of the issued council sheet are pipe size, pipe grade, design flow and velocity, invert depth, invert level, surface level and chainage, under a datum line.
27. **A pipe is drawn as a band plus two thin edge lines (D-264):** the edge lines move with the pipe as one thing; how that is done with ordinary AutoCAD objects, so the no-plug-in rule still holds (D-094), is the build's to prove.

### Added 20 Nov 2026, D-298 to D-383

28. **New symbols for the end of a system (D-317, D-333, D-334; `pictures\system_end_symbols.html`):** "both need new symbols" (D-317; the planning chat's proposal, PIT BLOCK 3 on EXISTING DRAIN and a bare pipe end on the kerb line, not taken). Existing council pit: "B, cross and 'EX'": a solid square with a cross, with a tag that starts with EX (for example EX SEP), one block with a tag attribute (D-333). Kerb outlet: "C, half circle": a half circle on the kerb, round side toward the road, one block (D-334). See OUTLET_AND_LPD.
29. **Water tanks drawn true to size (D-316, D-335, D-336):** "we have in the past not shown water tanks to scale we need to create a block or water tank that is correct to size"; then "presets fill, typing wins but the tanks need to be rounded in the same way as real life. look at kingspan and other local manufacturers"; then "Yes, full round ends for all" (see TANK).
30. **Layer questions as tick sheets (D-328):** "As pictures and tick sheets later today": the 10 layer questions (and 19 budgets) one page each with the recommended answer ticked; he changes only the ones he disagrees with.
31. **Units for the first job (D-344, D-380):** "Millimetres". Metre drawings come off the one-job release and go to the carpark (P-09 item 14) with their design page (`C:\CE_CIVIL` branch design/units) and the rounding call D-341. A drawing set to metres is refused, saying plainly that metres are not supported yet, rather than drawing wrongly (planning chat's call, confirmed by Tim in D-380).
32. **Rounding and pick distances (D-341, confirmed by D-380):** every length and level is first taken to the nearest tenth of a millimetre, then rounded half up for display; two points within a tenth of a millimetre are the same point; every pick distance is a real-world size, the same on the ground in metre and millimetre drawings; a change for metre drawings must not alter a millimetre drawing.
33. **Office blocks shipped with the tool (D-352):** "A copy shipped with the tool (Recommended)": copied from the office master when a version is released; brought into the drawing when missing; no network needed; a plain stand-in square is never drawn; one data setting holds the path. Found by his supervised check (D-351), where a bare test copy without the office blocks drew plain squares.
34. **A bare drawing (D-381 item 1):** missing layers, text styles and linetypes are brought in from the tool's own copy of the office set-up, as the blocks are, said once; nothing existing is changed (TR-048).
35. **Text for 1:100 by default in Stage 1 (D-381 item 2).**
36. **Moving the whole plan changes nothing (D-381 item 7):** proof in AutoCAD owed.

## Changed along the way

1. **"Looks and plots identical" (D-015) was made stronger by D-094 (16 Nov):** usable with plain AutoCAD, not only visible.
2. **A hard refusal of non-millimetre drawings in the bench code (SITUATIONS A6) is ruled out by D-217 (18 Nov).**
3. **Detention colour 152 (D-153) became 160 (D-156, 17 Nov).**
4. **"Must not refuse metre drawings" (D-217) was set aside for the one-job release by D-344 and D-380 (19 and 20 Nov):** metres refused with words; metre drawings parked (P-09 item 14), not cancelled.
5. **The end of a system drawn "by kind, from office blocks" (D-275) was changed by D-317, D-333 and D-334 (19 Nov):** two new symbols.
6. **A missing layer made with the office colour (D-260 DQ-005, planning chat's call) became Tim's ruling in D-381 item 1:** brought in from the tool's own copy of the office set-up.

## Still open on this subject

1. **How metre drawings are handled in practice** (D-217; OBSTACLE_COURSE OC-01; R-007 lesson 1, about 44 old bugs). Waits on: the build chat. **Parked by D-344 (19 Nov) to P-09 item 14;** the release refuses metres with words (D-380).
2. **An existing layer with a different colour: leave it and say once, or reset to the list** (OBSTACLE_COURSE OQ-07, OC-20). Waits on: Tim. **Answered by D-260 DQ-005 (18 Nov; planning chat's call from his rulings; his to overturn):** an existing layer is never changed; a missing one is made with the office colour and said in one line.
3. **Pen width of the new layers and of colour 160 through the office plot style; seen on a real plot** (D-156, Q-103, SITUATIONS). Waits on: Tim.
4. **Layer name STORMWATER DETENTION PIPE not separately ruled** (D-153). Waits on: Tim.
5. **Title block and issue: no tool in the first release,** and CDNEWDWG recommended park (D-097; FM-065). Waits on: Tim (later).
6. **AutoCAD LT and a live drawing not tested for the no-plug-in proof** (trial 3). Waits on: a test.
7. **CE things inside an xref are never counted or changed; draw the locator once and never scan inside xrefs** (SITUATIONS H5, K2); xref attach and bind not tested (trial 1). Waits on: a test.
8. **Grey status never written into the DWG** (SITUATIONS H3). Waits on: the build chat.
9. **As-built copies and the office's duty when as-built mark-ups arrive** (SITUATIONS H4; Q-010). Waits on: Tim (later).
10. **A3 templates, the council-specific A1 template, long-section examples** (Q-102); the A1 vertical template was not opened (interview section 9). Waits on: the build chat.
11. **Background plotting profile:** approved by Tim on 16 Nov but not made; his own profile points the plotter folder at a folder that does not exist (PARKING_LOT P-03); rule 1.9 now applies to any profile work. Waits on: Tim.
12. **Viewport scale set and lock (ST-15) and dimensions following the viewport:** detail not designed (D-209, D-210). Waits on: Tim.
13. **Model-space text height assumptions in SITUATIONS H1 and H2 need re-checking against D-194** (SITUATIONS document conflicts). Waits on: the build chat.
14. **"Plan scale" job fact:** recommended in SITUATIONS Q18; D-194 gives a different model; whether the fact still exists is not said. Waits on: Tim.
15. **Old jobs that start from SAVEAS of the last job:** D-191 says from the template; handling of leftover pits and facts from another drawing is recommended, not confirmed (SITUATIONS A7, Q15). Waits on: Tim.
16. **Proper names for the 18 machine-named blocks Tim added to the palette** (D-232, TQ-13). Waits on: Tim.
17. **The name of the CE no-plot layer** and whether the office template already has one (D-275). Waits on: the build chat.
18. **The 10 layer questions** as tick sheets (D-328). Waits on: the planning chat, then Tim.
19. **Metre drawings, with their design page and D-341, return from the carpark** after the one-job release (D-337, D-344). Waits on: later.

**Closed (D-298 to D-383):** where office blocks come from when a drawing lacks them (D-352); end-of-system symbols (D-333, D-334); metre drawings for the first job (D-344, D-380: refused, parked).

**Closed (D-230 to D-297):** the existing-layer question in the build (taken by D-260 DQ-005, the planning chat's call); what the Blocks palette holds (D-232, 37 blocks).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-316, D-317, D-328, D-333 to D-336, D-341, D-344, D-351, D-352, D-380, D-381; `pictures\system_end_symbols.html`; `pictures\tank_true_size.html`; `PARKING_LOT.md` P-09.

Added 18 Nov 2026: `DECISIONS.md` D-232, D-253, D-260, D-264, D-275, D-276.

1. `DECISIONS.md` D-013, D-015, D-030, D-039, D-083, D-094, D-097, D-102, D-109, D-114, D-153, D-156, D-169, D-187, D-188, D-191, D-192, D-194, D-197, D-205, D-215, D-217, D-224, D-228, D-229.
2. `reference\drafting\SHEET_SETUP.md`, `TITLE_BLOCK_AND_ISSUE.md`, `ELEMENTS.md`.
3. `design\BLOCKS_REVIEW.md`; `reference\research\R-009_PIT_BLOCK.md`; `stage4\TRIAL_RESULTS.md` trial 3.
