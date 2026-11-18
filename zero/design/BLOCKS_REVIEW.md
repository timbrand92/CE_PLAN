# Blocks review: the office master drawing

**Revision:** 2 (Wed 18 Nov 2026, afternoon, Melbourne time). Revision 2 adds Tim's ten decisions (section below the summary).
**Written by:** the tools interview side chat, for the planning chat (D-211). Planning only.
**Asked for by Tim:** "you need to look throught hem all see what they are and then we can decide and order and organise them all" (TA-038) and "we might not need all blocks" (TA-042).
**IDs:** BK-001 to BK-453, never reused. Nothing here is decided: every keep, merge or drop is a proposal for Tim.

## How it was read

1. **A copy only.** The DXF of the office master drawing "CE_TYPICAL BLOCKS-LAYERS-SCHEDULES-NOTES" was copied once to `C:\CE_WORK\scratch\blocks_review\master_copy.dxf`. Only the copy was read. Nothing in the office folder was opened in AutoCAD, saved or changed. AutoCAD was not used.
2. **Read as text** by a small script: each block's lines, text, fill-in fields (attributes), hatches, layers and size, whether it is dynamic, and how many times it is placed in the master drawing.
3. **Checked by hand:** 30 blocks picked at random were compared against their full contents. Three proposals were wrong and the rules were fixed:
   - **Two "merge" proposals were wrong:** IB2-BOTTOM and EB2-BOTTOM are top / bottom pairs, not copies. All such pairs now say "ask Tim".
   - **One note was filed as unknown:** the footing probe note.
   - **Text size samples** now say "drop-candidate".
4. **Client names and job addresses:** the block text and fill-in fields were searched for street addresses, job numbers and client words. None were found. Some notes carry general building notes. One block carries the public Before You Dig web address.

## Summary (one screen)

1. **453 named blocks.**
   - **174** have proper names.
   - **279** have machine names ("A$C..."). These were made by copy-and-paste, so most are pasted copies of notes, labels and hatch samples.
   - **162** of the 453 are dynamic.
   - **Not counted here:** 333 hidden copies (AutoCAD's own "*U" copies of dynamic blocks and similar). 248 of them are tied back to their parent block. They are not palette blocks.
2. **By group:**
   - **Civil drainage:** 77.
   - **Civil pavement and site:** 6.
   - **Symbols:** 53, including 37 hatch sample squares.
   - **Notes and schedules:** 83.
   - **Title and sheet:** 3.
   - **Structural:** 181.
   - **Unknown:** 50.
3. **Exact copies:** 51 groups of blocks draw exactly the same thing on the same layers, 119 blocks in all.
   - **Merge:** 51 are proposed for merging into one copy.
   - **Pairs:** the left / right and top / bottom pairs (EB1 and EB1-BOTTOM, C1 and C1-R and the like) are not merged. They go to Tim.
4. **Proposals:**
   - **Keep:** 200.
   - **Keep, give it a proper name:** 65, all notes.
   - **Merge:** 51.
   - **Ask Tim:** 104.
   - **Drop-candidate:** 33.
5. **Used or not:** every block but one is placed at least once in the master drawing, because the master is itself a sample sheet. So "placed in the master" does not mean "used on jobs". How often each block is used on real jobs: unknown.
6. **Not read:** the names of each dynamic block's states (visibility list). The DXF reader used cannot list them, so "dynamic" is shown without its states.

## Tim's decisions (18 Nov 2026, answers TA-064 to TA-073 in `interview_tools\ANSWERS.md`)

1. **Office pit: "PIT BLOCK 3 (BK-020)".** Stormwater Pit (BK-022) and the old PIT BLOCK 2 retire from the palette. This changes the night tests' pit (D-197), for the planning chat to carry to the build.
2. **Inlets: "The WITH MASK set".** BK-012 FLOOR WASTE, its copy BK-034 and BK-027 retire.
3. **Pipe description labels: "Drop them".**
4. **Hatch sample squares:** settled by the hatch work in `interview_tools\HATCHES_BY_FUNCTION.md` (TA-047 to TA-063).
5. **The unknown machine-named blocks: "Picture sheets, I tick".** 54 remain once pairs, hatch samples, the whole sheet and the structural blocks are taken out. Sheets: `pictures/blocks_to_tick_1.png` to `pictures/blocks_to_tick_3.png`.
6. **Notes held as blocks: "Outside the palette".**
7. **BK-450, the whole sheet held as one block: "Drop it".**
8. **The 33 drop-candidates: "Drop all 33".**
9. **Structural blocks: "Not yet".** They join a structural palette with the CE Structural tab.
10. **The 51 exact copies: "Merge all 51"**, on a copy of the master first, replacing it only on Tim's word.
11. **Pairs: "One dynamic block each"**, when structural is unparked.

Nothing has been changed in the master drawing.

## The ten things Tim most needs to decide

1. **Which pit block is the office pit.** BK-022 "Stormwater Pit" (dynamic, about 6.0 x 2.2 m overall) or BK-020 "PIT BLOCK 3" (dynamic, about 1.9 x 1.9 m). The old plug-in also shipped a "PIT BLOCK 2". The night tests use Stormwater Pit (D-197).
2. **One set of inlet symbols.** The "... DYNAMIC WITH MASK" downpipe, IO, GIO, overflow and floor waste blocks (BK-009 and siblings) sit beside:
   - **Plain floor waste:** BK-012 FLOOR WASTE and its copy BK-034.
   - **Machine-named downpipe:** BK-027, with a DP fill-in field.

   Which set do the new Inlet tools place?
3. **Pipe description labels.** BK-002, BK-003, BK-005 to BK-007 and BK-021 are typed labels with a leader, such as "100 DIA. UPVC PIPE AT 1 IN 100 MIN." and "RISING MAIN". BK-001 and BK-004 are short sample lengths of pipe. There are also 16 machine-named label copies. The new Pipe tool writes its own label (D-154), so do these stay in the palette for hand use, or go?
4. **The 37 hatch sample squares.** Is this set the office hatch list for the new hatch tool (TQ-12)? Each is a 1 m square on a "HATCH nn" layer with its pattern (list below). Some layers carry two or three different samples.
5. **The 104 "ask Tim" blocks.** Mostly machine-named things whose purpose cannot be told from the drawing alone: small linework on text layers, single hidden copies, part-drawn details. Name each or drop it.
6. **The 65 notes held as blocks.** Building notes, geotechnical notes, shoring notes, pool notes and schedules, all with machine names. Keep them as a named notes library, for example "NOTE - SHORING" (proposed), or keep notes outside the blocks palette?
7. **Left / right and top / bottom pairs.** EB1 / EB1-BOTTOM, C1 / C1-R, JOIST HANGER LEFT / RIGHT and others. Keep both, or make each pair one dynamic block with a flip?
8. **BK-450, a whole sheet held as one block.** About 153 x 207 m, holding 332 blocks: footing sizes, member tags and more. Keep it as reference only, outside the palette?
9. **Leftovers proposed for dropping (33):**
   - **Old CPB tool:** BK-008 and BK-405, named by date and time.
   - **Text size samples:** such as "25TEXT OVER"; the new TEXT tool places these sizes.
   - **Label copies:** that a new CE tool writes itself.
10. **Structural blocks (181).** Keep them in the master but out of the CE Tools palette until structural is unparked (D-006, TA-019)?

## Proposed palette order (CE Tools blocks palette, BLOCKS / BLK)

1. **Civil drainage:** pits, inlets (downpipe, IO, GIO, overflow, floor waste, trench grate), strip and spoon drain labels, fall symbol.
2. **Civil labels:** pipe descriptions, existing council drain, rising main (only if Tim keeps them, decision 3).
3. **Site:** boundary, TPZ / SRZ, Before You Dig panel, batter.
4. **Symbols:** section mark and bubble, RL level tag, scabble, cut tube, shadow box with mask, wipeout.
5. **Notes and schedules:** named notes, then schedules.
6. **Title and sheet:** layers legend, section title.
7. **Structural:** on the CE Structural tab later, hidden until it has tools.

## The 37 hatch sample squares (for TQ-12)

Layer name, then pattern. "x2" means two identical samples on that layer.
1. **HATCH 6:** DOTS x2, CROSS.
2. **HATCH 11:** BRASS.
3. **HATCH 11 - LOAD BEARING WALL OVER:** AR-CONC x4, ANSI31.
4. **HATCH 11 - FENCE WALL OVER:** ANSI31.
5. **HATCH 21:** SOLID; AR-CONC (small 200 mm sample).
6. **HATCH 31:** SOLID.
7. **HATCH 47:** ANSI31 x2.
8. **HATCH 51:** SOLID.
9. **HATCH 74:** SOLID.
10. **HATCH 121, 138, 141, 174, 201, 238, 242:** SOLID each.
11. **HATCH 140:** SOLID, DOTS.
12. **HATCH 150:** ANSI31.
13. **HATCH 213:** BRASS.
14. **HATCH 231 - LOAD BEARING WALL UNDER:** DOTS.
15. **HATCH 231 - FENCE WALL UNDER:** DOTS.
16. **HATCH 253:** ANSI37, SOLID.
17. **HATCH EARTH:** EARTH (small 200 mm sample).
18. **HATCH PANTONE, HATCH WATER:** SOLID each.
19. **HATCH TIMBER:** ANSI31.
20. **WALL HATCH:** JIS_LC_8A.

The number in a layer name is the pen colour, the same as the old number-named commands (21H, 238H and so on).

## Every block

Each line gives: what it draws, whether it is dynamic, how many times it is placed in the master drawing, and the proposal. "Merge into X" means it draws exactly the same as X on the same layers.

### Civil drainage (77)

1. **BK-001 100 CHARGED PIPE.** about 3,559 x 100 mm; layer STORMWATER CHARGED PIPE, DRAINAGE. Not dynamic; placed 1 time in the master. **Proposal:** keep.
2. **BK-002 100 DIA CHARGED PIPE.** text "100 DIA. UPVC CHARGED PIPE TO WT / 100 DIA. UPVC CHARGED PIPE TO WT"; about 8,559 x 817 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
3. **BK-003 100 DIA. PIPE.** text "100 DIA. UPVC PIPE AT 1 IN 100 MIN. / 100 DIA. UPVC PIPE AT 1 IN 100 MIN."; about 8,559 x 1,234 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
4. **BK-004 100 PIPE.** about 3,559 x 100 mm; layer STORMWATER PIPE, DRAINAGE. Not dynamic; placed 2 times in the master. **Proposal:** keep.
5. **BK-005 150 DIA. PIPE.** text "150 DIA. UPVC SN8 PIPE AT 1 IN 100 / 150 DIA. UPVC SN8 PIPE AT 1 IN 100"; about 8,559 x 885 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
6. **BK-006 225 DIA. PIPE.** text "225 DIA. UPVC PIPE AT 1 IN 100 / 225 DIA. UPVC PIPE AT 1 IN 100"; about 8,559 x 942 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
7. **BK-007 300 DIA. PIPE.** text "300 DIA. StormPRO PIPE AT 1 IN 100 / 300 DIA. StormPRO PIPE AT 1 IN 100"; about 8,559 x 1,017 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
8. **BK-008 CE_CPB_20260325_143832.** hatch SOLID; about 800 x 800 mm; layer EXISTING DRAIN. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (left behind by the old CPB tool, named by date and time).
9. **BK-009 DOWNPIPE DYNAMIC WITH MASK.** text "DP"; hatch SOLID; about 773 x 826 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 1 time in the master. **Proposal:** keep.
10. **BK-010 Fall.** text "FALL"; about 1,013 x 369 mm; layer 25DIMS, 25TEXT. Dynamic; placed 16 times in the master. **Proposal:** keep.
11. **BK-011 FALL SYMBOL.** fill-in fields FALL, FALL_GRADE; about 1,490 x 574 mm; layer 0, GUIDELINES. Dynamic; placed 1 time in the master. **Proposal:** keep.
12. **BK-012 FLOOR WASTE.** hatch HONEY; about 200 x 200 mm; layer FLOOR WASTE, GUIDELINES. Not dynamic; placed 2 times in the master. **Proposal:** keep.
13. **BK-013 FLOOR WASTE DYNAMIC WITH MASK.** text "FW"; hatch HONEY; about 699 x 737 mm; layer FLOOR WASTE HATCH, FLOOR WASTE. Dynamic; placed 1 time in the master. **Proposal:** keep.
14. **BK-014 FROM ABOVE.** text "F/A"; hatch SOLID; about 726 x 740 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 1 time in the master. **Proposal:** keep.
15. **BK-015 GRATED INSPECTION OPENING DYNAMIC WITH MASK.** text "GIO"; contains A$C2FBF17D0; about 700 x 727 mm; layer FLOOR WASTE, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
16. **BK-016 GRATED OVERFLOW.** text "GOF"; contains A$C2FBF17D0; about 700 x 727 mm; layer FLOOR WASTE, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
17. **BK-017 GRATED SURCHARGE PIPE.** text "GSP"; contains A$C2FBF17D0; about 700 x 727 mm; layer FLOOR WASTE, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
18. **BK-018 INSPECTION OPENING DYNAMIC WITH MASK.** text "IO"; hatch SOLID; about 726 x 740 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 1 time in the master. **Proposal:** keep.
19. **BK-019 OVERFLOW.** text "OF"; hatch SOLID; about 773 x 826 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 1 time in the master. **Proposal:** keep.
20. **BK-020 PIT BLOCK 3.** hatch _USER; about 1,900 x 1,900 mm; layer GRATED TRENCH, PITS HIDDEN. Dynamic; placed 1 time in the master. **Proposal:** keep.
21. **BK-021 RISING MAIN.** text "RISING MAIN FROM SPS / RISING MAIN TO PIT P..."; about 8,559 x 817 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
22. **BK-022 Stormwater Pit.** hatch ANSI31, SOLID, _USER; about 6,000 x 2,200 mm; layer STORMWATER PIT, PITS HIDDEN. Dynamic; placed 2 times in the master. **Proposal:** keep.
23. **BK-023 STRIP DRAIN LABEL DYNAMIC.** text "SD"; about 990 x 230 mm; layer SPOON DRAIN. Dynamic; placed 3 times in the master. **Proposal:** keep.
24. **BK-024 TO BELOW.** text "T/B"; hatch SOLID; about 726 x 740 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 1 time in the master. **Proposal:** keep.
25. **BK-025 TRENCH GRATE.** hatch ANSI31; about 3,100 x 200 mm; layer TRENCH GRATE. Dynamic; placed 2 times in the master. **Proposal:** keep.
26. **BK-026 A$C05fc417a.** text "CL x.xx"; about 794 x 794 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
27. **BK-027 A$C10A6178F.** fill-in fields DP; hatch SOLID; about 779 x 779 mm; layer DOWNPIPES HATCH, DOWNPIPES. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
28. **BK-028 A$C153579b2.** text "150 DIA. UPVC PIPE AT 1 IN 100"; about 6,086 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
29. **BK-029 A$C1537e271.** text "CL x.xx"; about 794 x 794 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C05fc417a.
30. **BK-030 A$C1a9117ef.** text "CL x.xx"; about 705 x 705 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
31. **BK-031 A$C21a5ec02.** text "PP CL x.xx"; about 828 x 828 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
32. **BK-032 A$C2541944e.** text "IL _____"; about 803 x 230 mm; layer 20TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
33. **BK-033 A$C25cd98a9.** contains a hidden copy of a dynamic block; about 990 x 230 mm; layer SPOON DRAIN. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
34. **BK-034 A$C2FBF17D0.** hatch HONEY; about 200 x 200 mm; layer FLOOR WASTE HATCH, FLOOR WASTE. Not dynamic; placed 4 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
35. **BK-035 A$C33d5b0dd.** text "IL _____"; about 803 x 230 mm; layer 20TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C2541944e.
36. **BK-036 A$C4190377c.** text "CL x.xx"; about 794 x 794 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C05fc417a.
37. **BK-037 A$C41ebeae2.** hatch SOLID; about 350 x 350 mm; layer DOWNPIPES HATCH, DOWNPIPES. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
38. **BK-038 A$C43d3dd8a.** text "SC"; about 398 x 319 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
39. **BK-039 A$C4601c447.** text "100 DIA. UPVC PIPE AT 1 IN 100 MIN."; about 6,766 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
40. **BK-040 A$C4f885c0f.** text "IL _____"; about 803 x 230 mm; layer 20TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C2541944e.
41. **BK-041 A$C5216a57b.** text "PP CL x.xx"; about 901 x 901 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
42. **BK-042 A$C56ba7ad3.** text "CL x.xx"; about 705 x 705 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C1a9117ef.
43. **BK-043 A$C577a31df.** text "PP CL x.xx"; about 828 x 828 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C21a5ec02.
44. **BK-044 A$C59d7842d.** contains STRIP DRAIN LABEL DYNAMIC; about 990 x 230 mm; layer SPOON DRAIN. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C25cd98a9.
45. **BK-045 A$C6165d914.** text "CL x.xx"; about 705 x 705 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C1a9117ef.
46. **BK-046 A$C620f461b.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
47. **BK-047 A$C64beaebf.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C620f461b.
48. **BK-048 A$C6a1b5627.** text "SC"; about 398 x 319 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C43d3dd8a.
49. **BK-049 A$C6ee215bf.** text "CHECK VISIBILITY / 300 DIA. EXISTING PIPE TO REMAIN"; hatch EARTH; contains A$Cbf942e10, A$Cec844387, A$Cfb1103aa; about 6,457 x 3,779 mm; layer 9HIDDEN2, HATCHOUTLINE. Dynamic; placed 8 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
50. **BK-050 A$C7700cfe5.** text "450 / 300"; about 7,160 x 3,200 mm; layer EX STORMWATER, EX PIT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
51. **BK-051 A$C7a4e0111.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C620f461b.
52. **BK-052 A$C83bd6e4f.** text "150 DIA. UPVC PIPE AT 1 IN 100"; about 6,086 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C153579b2.
53. **BK-053 A$C846a2044.** fill-in fields FALL, FALL_GRADE; about 1,490 x 570 mm; layer 0, GUIDELINES. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
54. **BK-054 A$C987d6fbf.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C620f461b.
55. **BK-055 A$C98eb5b4b.** text "CL x.xx"; about 794 x 794 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C05fc417a.
56. **BK-056 A$C9e13dcc8.** text "450 DIA. EXISTING COUNCIL DRAIN"; hatch EARTH; contains A$Cec844387; about 6,052 x 4,126 mm; layer HATCHOUTLINE, BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
57. **BK-057 A$C9f82133e.** text "RISING MAIN FROM SPS"; about 5,136 x 737 mm; layer 25DIMS, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
58. **BK-058 A$Cae572a67.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C620f461b.
59. **BK-059 A$Caf54613b.** text "EX. 300 DIA. COUNCIL DRAIN"; about 5,715 x 619 mm; layer EX STORMWATER, 25DIMS. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
60. **BK-060 A$Cb0753bb2.** text "100 DIA. UPVC PIPE AT 1 IN 100 MIN."; about 6,766 x 737 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
61. **BK-061 A$Cb58e54a8.** text "225 DIA. UPVC PIPE AT 1 IN 100"; about 6,086 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
62. **BK-062 A$Cb637cde3.** text "CJ"; about 350 x 319 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
63. **BK-063 A$Cb727afb5.** text "225 DIA. UPVC PIPE AT 1 IN 100"; about 6,086 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$Cb58e54a8.
64. **BK-064 A$Cbd2724ce.** text "PP CL x.xx"; about 828 x 828 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C21a5ec02.
65. **BK-065 A$Cbfccf521.** text "IL _____"; about 803 x 230 mm; layer 20TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C2541944e.
66. **BK-066 A$Cc48981fe.** text "RISING MAIN FROM SPS"; about 5,136 x 737 mm; layer 25DIMS, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C9f82133e.
67. **BK-067 A$Ccda0ca0a.** text "300 DIA. StormPRO PIPE AT 1 IN 100"; about 6,783 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (a new CE tool writes this label itself).
68. **BK-068 A$Cd22692e6.** text "SILT PIT CL x.xx"; about 1,094 x 1,094 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C620f461b.
69. **BK-069 A$Cd76eaf29.** text "CL x.xx"; about 705 x 705 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C1a9117ef.
70. **BK-070 A$Cdbddf089.** text "LOW PRESSURE GAS PIPE"; about 8,229 x 407 mm; layer HATCH 31, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
71. **BK-071 A$Cdc45558b.** fill-in fields PIT_LABEL; about 2,095 x 800 mm; layer 50CONT, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
72. **BK-072 A$Cdc508aeb.** text "CJ"; about 350 x 319 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$Cb637cde3.
73. **BK-073 A$Cde2093ca.** text "300 DIA. StormPRO PIPE AT 1 IN 100"; about 6,783 x 319 mm; layer 25DIMS, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$Ccda0ca0a.
74. **BK-074 A$Cee81a14b.** text "PP CL x.xx"; about 901 x 901 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C5216a57b.
75. **BK-075 A$Ceea08501.** text "PP CL x.xx"; about 828 x 828 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C21a5ec02.
76. **BK-076 A$Cf4fa2709.** text "PP CL x.xx"; about 901 x 901 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C5216a57b.
77. **BK-077 A$Cfc997b40.** text "PP CL x.xx"; about 901 x 901 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C5216a57b.

### Civil pavement and site (6)

78. **BK-078 BOUNDARY.** text "TITLE BOUNDARY"; about 2,482 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
79. **BK-079 MOC.** text "www.1100.com.au / DIAL BEFORE  YOU DIG"; hatch SOLID, SOLID,_O; about 12,879 x 6,044 mm; layer 25CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep.
80. **BK-080 A$C542cb28c.** text "ROOF CATCHMENT TO TANK"; hatch BRASS; about 7,066 x 1,000 mm; layer HATCH 140, 0. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
81. **BK-081 A$C8b30c528.** text "TPZ / SRZ"; contains A$Cdbddf089; about 8,229 x 7,501 mm; layer TPZ, SRZ. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
82. **BK-082 A$C9fa92ceb.** text "www.byda.com.au / BEFORE  YOU DIG"; hatch SOLID, SOLID,_O; about 12,879 x 4,445 mm; layer BYDA, WIPEOUT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
83. **BK-083 A$Cfd377557.** hatch SOLID; about 1,231 x 740 mm; layer BATTER. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).

### Symbols (including the hatch sample squares) (53)

84. **BK-084 _Dot.** about 2 x 1 mm; layer 0. Not dynamic; placed 0 times in the master. **Proposal:** drop-candidate (not used anywhere in the master drawing).
85. **BK-085 bubtail.** about 3 x 10 mm; layer 0. Not dynamic; placed 5 times in the master. **Proposal:** keep.
86. **BK-086 CUT TUBE.** about 100 x 25 mm; layer 18CONT. Dynamic; placed 2 times in the master. **Proposal:** keep.
87. **BK-087 RL LEVEL.** fill-in fields RL__.__; about 1,650 x 650 mm; layer 35CONT, 35TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
88. **BK-088 SCABBLE.** about 1,940 x 69 mm; layer 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep.
89. **BK-089 sddbhead.** about 13 x 14 mm; layer 0. Not dynamic; placed 2 times in the master. **Proposal:** keep.
90. **BK-090 SECT MARK.** fill-in fields SEC, DWG; contains bubtail, sddbhead; about 30 x 16 mm; layer SECTION MARK. Dynamic; placed 1 time in the master. **Proposal:** keep.
91. **BK-091 Section Flag.** contains bubtail; about 9 x 10 mm; layer SECTION MARK. Dynamic; placed 4 times in the master. **Proposal:** keep.
92. **BK-092 SHADOW BOX W MASK.** about 10,000 x 8,119 mm; layer 35CONT, HATCHOUTLINE. Dynamic; placed 2 times in the master. **Proposal:** keep.
93. **BK-093 SUPPORT_COLUMN.** empty definition (draws nothing). Not dynamic; placed 2 times in the master. **Proposal:** drop-candidate (empty).
94. **BK-094 SUPPORT_DS.** empty definition (draws nothing). Not dynamic; placed 1 time in the master. **Proposal:** merge into SUPPORT_COLUMN.
95. **BK-095 SUPPORT_STUD.** empty definition (draws nothing). Not dynamic; placed 2 times in the master. **Proposal:** merge into SUPPORT_COLUMN.
96. **BK-096 A$C0d099526.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 201, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
97. **BK-097 A$C11f89bb4.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH 11 - LOAD BEARING WALL OVER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
98. **BK-098 A$C190fd0ce.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 51, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
99. **BK-099 A$C221ee0a5.** fill-in fields UNITTYPE; about 3,000 x 800 mm; layer 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
100. **BK-100 A$C2931bd3b.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 140, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
101. **BK-101 A$C2c2f2310.** hatch sample square; hatch EARTH; about 200 x 200 mm; layer HATCH EARTH, 35TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
102. **BK-102 A$C460327b5.** hatch sample square; hatch AR-CONC; about 200 x 200 mm; layer HATCH 21, 35TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
103. **BK-103 A$C47b9943c.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 253, 50CONT. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
104. **BK-104 A$C4aec42c6.** hatch sample square; hatch DOTS; about 1,000 x 1,000 mm; layer HATCH 231 - LOAD BEARING WALL UNDER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
105. **BK-105 A$C4e66e89a.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH TIMBER, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
106. **BK-106 A$C5565908c.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 138, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
107. **BK-107 A$C5a231265.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH PANTONE, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
108. **BK-108 A$C64f3d967.** fill-in fields RL__.__; about 1,650 x 596 mm; layer 35CONT, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
109. **BK-109 A$C6de29102.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH 47, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
110. **BK-110 A$C87fc3733.** fill-in fields TEXT; about 933 x 3,186 mm; layer 0, 25DIMS. Dynamic; placed 12 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
111. **BK-111 A$C88c5ab0c.** hatch sample square; hatch JIS_LC_8A; about 1,000 x 1,000 mm; layer WALL HATCH, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
112. **BK-112 A$C8ac2f600.** hatch sample square; hatch BRASS; about 1,000 x 1,000 mm; layer HATCH 213, 50CONT. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
113. **BK-113 A$C8d350b4e.** hatch sample square; hatch DOTS; about 1,000 x 1,000 mm; layer HATCH 231 - FENCE WALL UNDER, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
114. **BK-114 A$C91565c5a.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH 11 - FENCE WALL OVER, 50CONT. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
115. **BK-115 A$C9a8fd0b7.** hatch sample square; hatch AR-CONC; about 1,000 x 1,000 mm; layer HATCH 11 - LOAD BEARING WALL OVER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
116. **BK-116 A$C9f975527.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 21, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
117. **BK-117 A$C9fccb90e.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 74, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
118. **BK-118 A$Ca5190dfd.** hatch sample square; hatch CROSS; about 1,000 x 1,000 mm; layer HATCH 6, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
119. **BK-119 A$Caa50cf6f.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH 47, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C6de29102.
120. **BK-120 A$Cabff1564.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 121, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
121. **BK-121 A$Cad2e2b19.** hatch sample square; hatch AR-CONC; about 1,000 x 1,000 mm; layer HATCH 11 - LOAD BEARING WALL OVER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C9a8fd0b7.
122. **BK-122 A$Cb385b841.** fill-in fields LEVEL; contains A$C3DB57EB2; about 916 x 956 mm; layer 20TEXT, GUIDELINES. Dynamic; placed 4 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
123. **BK-123 A$Cc2634836.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH WATER, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
124. **BK-124 A$Cc6fcbb91.** hatch sample square; hatch ANSI31; about 1,000 x 1,000 mm; layer HATCH 150, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
125. **BK-125 A$Ccc243160.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 238, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
126. **BK-126 A$Ccd69104e.** hatch sample square; hatch DOTS; about 1,000 x 1,000 mm; layer HATCH 6, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
127. **BK-127 A$Cd1f0f158.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 242, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
128. **BK-128 A$Cdd0b562c.** hatch sample square; hatch DOTS; about 1,000 x 1,000 mm; layer HATCH 6, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$Ccd69104e.
129. **BK-129 A$Cf3e7e119.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 141, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
130. **BK-130 A$Cf74f4a4c.** hatch sample square; hatch ANSI37; about 1,000 x 1,000 mm; layer HATCH 253, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
131. **BK-131 A$Cf819e618.** hatch sample square; hatch DOTS; about 1,000 x 1,000 mm; layer HATCH 140, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
132. **BK-132 A$Cf940d094.** hatch sample square; hatch AR-CONC; about 1,000 x 1,000 mm; layer HATCH 11 - LOAD BEARING WALL OVER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C9a8fd0b7.
133. **BK-133 A$Cfbc5bb08.** hatch sample square; hatch BRASS; about 1,000 x 1,000 mm; layer HATCH 11, 50CONT. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
134. **BK-134 A$Cfdb3532c.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 174, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).
135. **BK-135 A$Cfe811e6f.** hatch sample square; hatch AR-CONC; about 1,000 x 1,000 mm; layer HATCH 11 - LOAD BEARING WALL OVER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** merge into A$C9a8fd0b7.
136. **BK-136 A$Cff67309b.** hatch sample square; hatch SOLID; about 1,000 x 1,000 mm; layer HATCH 31, 50CONT. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (source for the office hatch list, TQ-12; not a palette block).

### Notes and schedules (83)

137. **BK-137 A3 Footing Schedule.** text "FOOTING TYPE / WIDTH MINIMUM "; about 9,371 x 4,937 mm; layer 25CONT, 25TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep.
138. **BK-138 Block Wall Schedule.** text "WALL TYPE (THICKNESS) / VERTICAL"; hatch SOLID; about 26,550 x 5,500 mm; layer SCHEDULE, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep.
139. **BK-139 FIRST FLOOR MEMBER SCHEDULE - 2 COLUMNS.** text "FIRST FLOOR MEMBER SCHEDULE  / SIZE"; fill-in fields MEMBER_SCHEDULE1, MEMBER_SCHEDULE2, MEMBER_SCHEDULE3, MEMBER_SCHEDULE4; about 20,850 x 3,050 mm; layer SCHEDULE, 50TEXT. Dynamic; placed 12 times in the master. **Proposal:** keep.
140. **BK-140 Footing Schedule - Added Comments.** text "FOOTING TYPE / WIDTH MINIMUM "; about 9,371 x 5,937 mm; layer 25CONT, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
141. **BK-141 A$C02f0e84f.** text "DENOTES ORIENTATION OF '    ' BRACKET TO TIMBER POST OVER"; about 5,962 x 737 mm; layer 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
142. **BK-142 A$C05a27c0e.** text "ROOF TRUSSES NOTE ROOF TRUSSES AND BRACING TO MANUFACTURER'S"; hatch SOLID; contains a hidden copy of a dynamic block; about 6,950 x 7,604 mm; layer HATCH 141, HATCHOUTLINE. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
143. **BK-143 A$C06dcc82e.** text "___ DIA. BORED PIERS (CFA) AT ____ MAX. CTS.  _-N__ VERTICAL / ____mm MAX RETAINING"; hatch AR-CONC; contains a hidden copy of a dynamic blockA$C9d55d28f; about 17,300 x 12,300 mm; layer 25TEXT, 35CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
144. **BK-144 A$C090cecee.** fill-in fields MEMBER_TITLE; about 6,750 x 750 mm; layer 0, 35TEXT. Dynamic; placed 26 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
145. **BK-145 A$C09e9fbe4.** text "NOTE WHERE FILL INCLUDING ANY EXISTING FILL AND DISTURBED SO"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 2,561 mm; layer HATCH 51, HATCHOUTLINE. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
146. **BK-146 A$C0AC007BC.** text "RETAINING WALL NOTE REFER TO STRUCTURAL DOCUMENTATION FOR RE"; hatch SOLID; contains a hidden copy of a dynamic block; about 15,625 x 5,073 mm; layer HATCH 51, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
147. **BK-147 A$C0b158b2b.** text "25TEXT NOTES"; about 4,259 x 319 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
148. **BK-148 A$C0eac50ba.** text "CORE FILL NOTES TO ALL BLOCK WALLS FILL ALL CORES WITH f 'c "; contains a hidden copy of a dynamic block; about 7,974 x 2,728 mm; layer 0, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
149. **BK-149 A$C18e4c5e8.** text "NOTE EXISTING FRAMING IS BASED ON ASSUMPTIONS ONLY. IF EXIST"; contains a hidden copy of a dynamic block; about 6,950 x 3,936 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
150. **BK-150 A$C19da017b.** text "BASEMENT RETENTION & FOOTING PLAN SCALE 1:100 / __mm THICK RC RAFT SLAB SL__ MESH TOP (25mm COVER) BAR CHAIR"; hatch CROSS, SOLID; about 12,239 x 14,329 mm; layer 25TEXT, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
151. **BK-151 A$C1cc019bf.** text "STUDWALL FRAMING ALL STUD FRAMING, TYPE, FIXINGS AND BRACING"; contains a hidden copy of a dynamic block; about 10,154 x 34,435 mm; layer 25TEXT, BLOCKS. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
152. **BK-152 A$C1cfb6ea6.** text "BB1 / -"; contains a hidden copy of a dynamic block; about 21,890 x 4,225 mm; layer 25TEXT, BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
153. **BK-153 A$C1df2b933.** text "FOOTING TYPE / WIDTH MINIMUM "; about 9,371 x 8,537 mm; layer 25CONT, 25TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
154. **BK-154 A$C1ef9587f.** text size sample; text "18TEXT UNDER"; about 1,546 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
155. **BK-155 A$C24316c7f.** text size sample; text "25TEXT UNDER"; about 2,148 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
156. **BK-156 A$C2467cf7e.** text "STRUCTURAL PERFORMANCE NOTES ALL PARTIES NEED TO BE AWARE TH"; contains a hidden copy of a dynamic block; about 9,150 x 4,396 mm; layer 0, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
157. **BK-157 A$C26e1985a.** text "FB1 / FB2"; contains 3 hidden copies of dynamic blocks; about 20,850 x 33,869 mm; layer 35TEXT, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
158. **BK-158 A$C2c85f112.** text "NOTES:  BEAM / LINTEL SUPPORT PROVIDE 2 No 90 x 45 MGP10 STU / NOTES:  EXTERNAL TIMBER ALL EXTERNAL TIMBERS THAT ARE NOT PR"; hatch SOLID; about 13,700 x 12,169 mm; layer HATCH 51, 25TEXT. Dynamic; placed 4 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
159. **BK-159 A$C2fce5a49.** text "NOTES  1. REFER TO ARCHITECTURAL DRAWINGS AND AS1684 - RESID"; contains a hidden copy of a dynamic block; about 6,950 x 5,652 mm; layer 35CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
160. **BK-160 A$C3182637a.** text "SWIMMING POOL PLAN SCALE 1:100 / RC POOL SHELL  F'c = 40 MPa POOL WALLS - 150 THICK POOL WALL"; hatch SOLID; about 8,151 x 3,759 mm; layer 70TEXT, HATCH WATER. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
161. **BK-161 A$C35dcb436.** text "NOTE LOCAL COLLAPSE WILL OCCUR DURING EXCAVATION OF TRENCHES"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 3,296 mm; layer HATCH 51, HATCHOUTLINE. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
162. **BK-162 A$C3f6b2047.** text "NOTE: THE SUPPLIER / INSTALLER OF SCREW-IN PILES SHALL PROVI / DESIGN LOAD"; about 13,700 x 4,870 mm; layer 25CONT, 35TEXT. Dynamic; placed 3 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
163. **BK-163 A$C449d6c3e.** text "GROUND FLOOR FOOTING PLAN SCALE 1:100 / BW1"; hatch ANSI31, DOTS, SOLID; contains 3 hidden copies of dynamic blocks; about 13,705 x 58,565 mm; layer 25TEXT, BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
164. **BK-164 A$C44A725F9.** text "EXTERNAL MASONRY WALLS - ONE WAY SPANNING WALLS ENGAGED PIER / Wind Region  A5 Terrain Category 3"; about 11,000 x 6,050 mm; layer 25TEXT, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
165. **BK-165 A$C44bd43c8.** text "80 kN 3000 MIN. DEEP / 100 kN 3000 MIN. DEEP"; contains 2 hidden copies of dynamic blocks; about 13,700 x 4,870 mm; layer 25CONT, 25TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
166. **BK-166 A$C483f9214.** text size sample; text "25TEXTOVER"; about 1,862 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
167. **BK-167 A$C53b54ca1.** text "25TEXT NOTES"; about 925 x 64 mm; layer 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
168. **BK-168 A$C5c6a76f3.** text "SHORING NOTE  BUILDER TO TEMPORARILY SHORE FOOTING EXCAVATIO"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 3,700 mm; layer HATCH 51, HATCHOUTLINE. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
169. **BK-169 A$C5eda2e49.** text "EXISTING ROOF NOTE: EXISTING ROOF FRAMING TO BE PROPPED PRIO"; contains a hidden copy of a dynamic block; about 13,772 x 3,489 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
170. **BK-170 A$C5edaf276.** text "NOTE: 1. REFER TO ARCHITECTURAL DRAWINGS FOR LOCATIONS AND E"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,297 x 7,338 mm; layer HATCH 51, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
171. **BK-171 A$C63216dbe.** text "RAINWATER GARDEN REFER TO DETAIL"; hatch GRASS; about 9,372 x 1,032 mm; layer HATCH 74, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
172. **BK-172 A$C65AA04C5.** text "POOL CONSTRUCTION NOTES 1. BUILDER TO ENSURE PROPOSED SWIMMI"; hatch SOLID; about 9,208 x 25,246 mm; layer 35CONT, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
173. **BK-173 A$C66309814.** text "BOUNDARY PROTECTION NOTE: 1. NO WORK IS TO EXTEND OVER THE B / TEMPORARY SHORING NOTE BUILDER TO TEMPORARILY SHORE EXCAVATI"; contains a hidden copy of a dynamic block; about 10,171 x 9,050 mm; layer 25TEXT, 35CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
174. **BK-174 A$C6da5688d.** text "1. REFER ARCHITECTURAL DRAWINGS FOR LOCATIONS AND EXTENT OF  / %%UNOTES"; contains a hidden copy of a dynamic block; about 10,171 x 7,171 mm; layer 25TEXT, 35CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
175. **BK-175 A$C713c671d.** text "SOLDIER PILE RETAINING WALL SCHEDULE / LABEL"; hatch AR-CONC; about 11,300 x 12,300 mm; layer 25CONT, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
176. **BK-176 A$C7330e27d.** text "SIZE  REINFORCEMENT LIGATURES (30mm  COVER) / RC FILLED MASONRY PIER SCHEDULE"; hatch AR-CONC, JIS_LC_8A; about 12,744 x 12,764 mm; layer 25CONT, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
177. **BK-177 A$C74092e54.** text size sample; text "18TEXTOVER"; about 1,341 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
178. **BK-178 A$C755b2067.** text size sample; text "70TEXTOVER"; about 3,724 x 639 mm; layer 70TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
179. **BK-179 A$C7a98bd55.** text "GROUND FLOOR SLAB & BAND BEAMS TO REMAIN PROPPED UNTIL FIRST"; contains a hidden copy of a dynamic block; about 10,099 x 1,261 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
180. **BK-180 A$C7f10f0c3.** text "NOTE: ALL TIMBER FRAMING CAN BE REPLACED WITH LIGHT GAUGE ST"; contains a hidden copy of a dynamic block; about 8,750 x 3,300 mm; layer 0, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
181. **BK-181 A$C7f889699.** text "NOTE BUILDER IS TO ENSURE ADJOINING PROPERTY FOOTINGS ARE NO"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 2,139 mm; layer HATCH 51, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
182. **BK-182 A$C8356d715.** text "GROUND FLOOR  LEVEL / SIZE  REINFORCEMENT LIGATURES GRADE (MPa) "; about 9,500 x 6,200 mm; layer 25CONT, 25TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
183. **BK-183 A$C8b31cf48.** text size sample; text "35TEXTUNDER"; about 2,068 x 319 mm; layer 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
184. **BK-184 A$C8d5486ce.** text "GEOTECHNICAL NOTE ASSUMED CLASS "M" SOIL CLASSIFICATION. FOU"; hatch SOLID; contains a hidden copy of a dynamic block; about 6,742 x 3,229 mm; layer HATCH 51, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
185. **BK-185 A$C8f7ee122.** contains 2 hidden copies of dynamic blocks; about 6,750 x 1,500 mm; layer SCHEDULE. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
186. **BK-186 A$C951d9d36.** text "MASONRY LINTEL SCHEDULE  / SPAN"; about 6,750 x 6,000 mm; layer 0, 35TEXT. Not dynamic; placed 3 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
187. **BK-187 A$C953717fd.** text size sample; text " 25TEXT"; about 1,025 x 1,025 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
188. **BK-188 A$C9ef2b5d7.** text "WALL TYPE (THICKNESS) / VERTICAL"; hatch SOLID; about 26,700 x 5,200 mm; layer SCHEDULE, 35TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
189. **BK-189 A$C9f82891f.** text "NOTE BUILDER IS TO ENSURE THAT NO PART OF NEW FOOTINGS ENCRO"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 1,722 mm; layer HATCH 51, HATCHOUTLINE. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
190. **BK-190 A$Ca0b4390e.** text size sample; text "50TEXTUNDER"; about 2,895 x 447 mm; layer 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
191. **BK-191 A$Ca1efdcac.** text size sample; text "35TEXTOVER"; about 1,862 x 319 mm; layer 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
192. **BK-192 A$Ca611a18d.** text "GEOTECHNICAL NOTE CONSTRUCTION SHALL BE IN ACCORDANCE WITH T"; contains a hidden copy of a dynamic block; about 10,156 x 8,119 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
193. **BK-193 A$Ca76b9716.** text "STUDWALL FRAMING ALL STUD FRAMING, TYPE, FIXINGS AND BRACING / LOAD BEARING & ALL BRACED STUDWALLS : 0mm - 2740mm STUDS: 90"; contains a hidden copy of a dynamic block; about 16,900 x 20,530 mm; layer 25TEXT, BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
194. **BK-194 A$Caffdd389.** text "BOUNDARY PROTECTION NOTE: 1. NO WORK IS TO EXTEND OVER THE B / TEMPORARY SHORING NOTE BUILDER TO TEMPORARILY SHORE EXCAVATI"; hatch SOLID; contains a hidden copy of a dynamic block; about 12,611 x 7,338 mm; layer 25TEXT, HATCH 51. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
195. **BK-195 A$Cb423b2a4.** text size sample; text "25TEXT"; about 1,050 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
196. **BK-196 A$Cb88528b0.** text "HORIZONTAL PLANKS / BORED PIER SIZE"; about 15,808 x 3,700 mm; layer 25CONT, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
197. **BK-197 A$Cbbc802dd.** text "STRUCTURAL ENGINEER TO INSPECT GROUND FLOOR SLAB REINFORCEME"; contains a hidden copy of a dynamic block; about 10,099 x 1,261 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
198. **BK-198 A$Cc02dd2f7.** text size sample; text "25TEXT "; about 1,025 x 1,025 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
199. **BK-199 A$Cc19d0131.** text "GROUND FLOOR SLAB TO REMAIN PROPPED UNTIL FIRST FLOOR SLAB H"; contains a hidden copy of a dynamic block; about 10,099 x 1,261 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
200. **BK-200 A$Cc1c66398.** text size sample; text "50TEXT TITLE 35TEXT TITLE"; about 2,656 x 1,616 mm; layer 50TEXT. Dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
201. **BK-201 A$Cc271391e.** text "NOTE THIS DRAWING IS TO BE READ IN CONJUNCTION WITH CIVIL DO"; contains a hidden copy of a dynamic block; about 9,150 x 1,812 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
202. **BK-202 A$Cc6472a71.** text "FIRST FLOOR  LEVEL / SIZE  REINFORCEMENT LIGATURES (30mm COVER) GRADE (MPa) "; hatch AR-CONC; contains 2 hidden copies of dynamic blocks; about 14,797 x 10,200 mm; layer 25CONT, 35CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
203. **BK-203 A$Cc659dd69.** text "NOTE:  1. TABLE ONLY TO BE USED WHEN SIZES CANNOT FIT WITHIN / 90 x 45 LVL"; about 11,000 x 5,645 mm; layer 25CONT, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
204. **BK-204 A$Cc660033e.** text "WIDTH / VERTICAL BARS"; hatch SOLID; about 15,808 x 5,700 mm; layer SCHEDULE, 35TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
205. **BK-205 A$Cc6994312.** text "LEGEND / ROOF FRAMING PLAN SCALE 1:100"; hatch SOLID; contains 3 hidden copies of dynamic blocks; about 8,669 x 17,005 mm; layer 25TEXT, BRACING ROOF. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
206. **BK-206 A$Cc78a9684.** text "NOTE THIS DRAWING IS TO BE READ IN CONJUNCTION WITH STRUCTUR"; contains a hidden copy of a dynamic block; about 9,150 x 1,812 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
207. **BK-207 A$Cc7d4b7bb.** text size sample; text "50TEXTOVER"; about 2,607 x 447 mm; layer 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
208. **BK-208 A$Ccf31ddac.** text "STUDWALL FRAMING ALL STUD FRAMING, TYPE, FIXINGS AND BRACING"; contains a hidden copy of a dynamic block; about 9,452 x 41,785 mm; layer 25TEXT, 35CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
209. **BK-209 A$Cd13279a9.** text "MARK / SIZE"; fill-in fields MEMBER_SCHEDULE1; about 6,950 x 3,050 mm; layer SCHEDULE, HIDDENLINE. Dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
210. **BK-210 A$Cd56fe8d0.** text "ROOF TRUSSES NOTE ROOF TRUSSES AND BRACING TO MANUFACTURER'S"; hatch SOLID; contains a hidden copy of a dynamic block; about 6,950 x 9,684 mm; layer HATCH 141, HATCHOUTLINE. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
211. **BK-211 A$Cd8a534a7.** text "LEGEND / DENOTES TYPE A WALL BRACING (STRAP BRACE) REFER TO DETAIL"; hatch SOLID; contains 3 hidden copies of dynamic blocks; about 9,372 x 27,624 mm; layer 25TEXT, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
212. **BK-212 A$Cd8d1c7f7.** text "RC POOL SHELL POOL WALLS AND BASE:  150mm THICK - N12-250, E / RC POOL SHELL BASE - 150mm THICK POOL BASE N12-200 CTS. EACH"; hatch SOLID,_O; contains A$C65AA04C5; about 11,178 x 33,274 mm; layer HATCH WATER, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
213. **BK-213 A$Cd9e0f92e.** text "RC1 / REFER PLAN"; contains 3 hidden copies of dynamic blocks; about 9,500 x 6,200 mm; layer 25TEXT, 25CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
214. **BK-214 A$Ce20527bb.** text size sample; text "70TEXTUNDER"; about 4,136 x 639 mm; layer 70TEXT. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (text size sample; the new TEXT tool places these sizes).
215. **BK-215 A$Ce7b721c4.** text "BUFFER STRIP REFER TO DETAIL"; hatch SOLID; about 9,372 x 1,032 mm; layer HATCH 74, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
216. **BK-216 A$Ce8459fd2.** text "SUBJECT TO FOOTING PROBE: FOOTING PROBE REQUIRED TO DETERMIN"; hatch SOLID; contains a hidden copy of a dynamic block; about 9,150 x 1,722 mm; layer HATCH 51, HATCHOUTLINE. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
217. **BK-217 A$Ceae34718.** text "MARK / WIDTH MINIMUM "; hatch SOLID; about 21,890 x 4,225 mm; layer 25CONT, 25TEXT. Dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).
218. **BK-218 A$Cf7bf9b1b.** text "MASS REINFORCED CONCRETE STAIRS SL81 MESH BOTTOM - f`c = 32  / MASS REINFORCED CONCRETE RAMP SL81 MESH TOP & BOTTOM - f`c ="; hatch ANSI31, AR-CONC, SOLID; about 12,238 x 16,744 mm; layer 25TEXT, 50CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep, give it a proper name (Tim names it).
219. **BK-219 A$Cffe07346.** text "NOTE THIS DRAWING IS TO BE READ IN CONJUNCTION WITH ARCHITEC"; contains a hidden copy of a dynamic block; about 9,150 x 1,812 mm; layer 0, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep, give it a proper name (Tim names it).

### Title and sheet (3)

220. **BK-220 LAYERS.** text "TPZ / 450"; contains 3 hidden copies of dynamic blocks; about 12,436 x 16,559 mm; layer EX PIT, EX STORMWATER. Not dynamic; placed 1 time in the master. **Proposal:** keep.
221. **BK-221 Section Title Block.** text "SCALE / MIDPOINT"; fill-in fields SECTION, #, SHEET#, 1:20; about 43 x 13 mm; layer SECTION MARK, GUIDELINES. Dynamic; placed 3 times in the master. **Proposal:** keep.
222. **BK-222 A$C9369596c.** text "SCALE / MIDPOINT"; fill-in fields 1:20, SHEET#, #, SECTION; about 4,300 x 1,300 mm; layer SECTION MARK, GUIDELINES. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).

### Structural (parked under D-006) (181)

223. **BK-223 'A'- BRACING.** fill-in fields A; about 2,880 x 650 mm; layer DEFPOINTS, 0. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
224. **BK-224 'B' - BRACING.** fill-in fields B; about 2,700 x 650 mm; layer 0, WALL BRACING TYPE B. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
225. **BK-225 100UC15 SRW.** text "100 UC 15"; hatch SOLID; contains 2 hidden copies of dynamic blocks; about 2,488 x 771 mm; layer SLEEPER RETAINING WALL, 0. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
226. **BK-226 140-BLOCK.** hatch ANSI31, DOTS; about 140 x 200 mm; layer WALLS BLOCK, DEFPOINTS. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
227. **BK-227 150 CFS REDIWALL.** hatch ANSI31, AR-CONC, SOLID; about 150 x 200 mm; layer BLOCKWORK WALL, HATCH 21. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
228. **BK-228 150 PFC.** hatch SOLID; about 253 x 273 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
229. **BK-229 150UC23 SRW.** text "150 UC 23"; hatch SOLID, SOLID,_O; contains a hidden copy of a dynamic block; about 1,412 x 556 mm; layer BORED PIER HATCH, SLEEPER RETAINING WALL. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
230. **BK-230 180 PFC.** hatch SOLID; about 253 x 273 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
231. **BK-231 190-BLOCK.** hatch ANSI31, DOTS; about 190 x 200 mm; layer WALLS BLOCK, DEFPOINTS. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
232. **BK-232 2 BOLT CLEAT.** contains a hidden copy of a dynamic block; about 96 x 142 mm; layer WELDING, HATCH 21. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
233. **BK-233 2 BOLT CLEAT - FRONT.** contains a hidden copy of a dynamic block; about 238 x 140 mm; layer HATCH 21, 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
234. **BK-234 200 CFS REDIWALL.** hatch ANSI31, AR-CONC, SOLID; about 200 x 200 mm; layer BLOCKWORK WALL, HATCH 21. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
235. **BK-235 200 PFC.** hatch SOLID; about 253 x 278 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
236. **BK-236 200x75 SRW.** text "200 x 75"; hatch SOLID, SOLID,_O; contains a hidden copy of a dynamic block; about 1,425 x 622 mm; layer SLEEPER RETAINING WALL, BORED PIER HATCH. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
237. **BK-237 230 PFC.** hatch SOLID; about 257 x 273 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
238. **BK-238 250 PFC.** hatch SOLID; about 376 x 310 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
239. **BK-239 290-BLOCK.** hatch ANSI31, DOTS; about 290 x 200 mm; layer WALLS BLOCK, DEFPOINTS. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
240. **BK-240 3 BOLT CLEAT.** contains a hidden copy of a dynamic block; about 96 x 212 mm; layer WELDING, HATCH 21. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
241. **BK-241 3 BOLT CLEAT - FRONT.** contains a hidden copy of a dynamic block; about 238 x 210 mm; layer HATCH 21, 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
242. **BK-242 300 PFC.** hatch SOLID; about 420 x 350 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
243. **BK-243 380 PFC.** hatch SOLID; about 466 x 450 mm; layer WELDING, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
244. **BK-244 4 BOLT CLEAT.** contains a hidden copy of a dynamic block; about 96 x 282 mm; layer WELDING, HATCH 21. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
245. **BK-245 4 BOLT CLEAT - FRONT.** contains a hidden copy of a dynamic block; about 238 x 280 mm; layer HATCH 21, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
246. **BK-246 450DIABP.** hatch SOLID,_O; about 450 x 450 mm; layer GUIDELINES, HATCH BORED PIER. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
247. **BK-247 A-BRACE.** fill-in fields A; about 2,880 x 650 mm; layer DEFPOINTS, WALL BRACING TYPE A. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
248. **BK-248 B-BRACE.** fill-in fields B; about 2,700 x 650 mm; layer WALL BRACING TYPE B, DEFPOINTS. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
249. **BK-249 BEAM AND STUDS DYNAMIC.** fill-in fields BEAM; contains a hidden copy of a dynamic block; about 1,425 x 576 mm; layer SUPPORT DS, BEAM. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
250. **BK-250 BEAM LABEL.** member tag text; text "FB__ CANT."; about 1,367 x 230 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
251. **BK-251 BEYOND.** member tag text; text "BEYOND"; about 778 x 778 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
252. **BK-252 Bondek Arrow.** about 2,200 x 664 mm; layer 70CONT, 25TEXT. Not dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
253. **BK-253 BORED PIER 2.** hatch SOLID, SOLID,_O; contains a hidden copy of a dynamic block; about 1,411 x 450 mm; layer BORED PIER UNDER, BORED PIER HATCH. Dynamic; placed 8 times in the master. **Proposal:** keep (structural, parked under D-006).
254. **BK-254 BORED PIER ONLY.** hatch SOLID,_O; about 600 x 600 mm; layer GUIDELINES, 0. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
255. **BK-255 Bored Pier Retainin Wall.** hatch SOLID,_O; about 1,500 x 600 mm; layer BORED PIER HATCH, 0. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
256. **BK-256 Bored Pier Sequence 1 - no wipeout.** fill-in fields FB; about 1,315 x 450 mm; layer BEAM, SUPPORT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
257. **BK-257 Bored Pier Sequence 1 with wipeout.** fill-in fields FB; about 1,315 x 450 mm; layer BEAM, SUPPORT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
258. **BK-258 BP1.** member tag text; text "BP1"; about 536 x 536 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
259. **BK-259 BP2.** member tag text; text "BP2"; about 536 x 536 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
260. **BK-260 BRICK WALL.** hatch JIS_LC_8A; about 146 x 607 mm; layer 25CONT, DEFPOINTS. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
261. **BK-261 C1.** member tag text; text "C1"; about 388 x 388 mm; layer SUPPORT TEXT COLUMN. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
262. **BK-262 C1-R.** member tag text; text "C1"; about 388 x 388 mm; layer SUPPORT TEXT COLUMN. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with C1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
263. **BK-263 CANTILEVERED.** member tag text; text "CANT."; about 618 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
264. **BK-264 Cavity Door.** text "620 / 720"; about 1,280 x 177 mm; layer WINDOW & DOOR, GUIDELINES. Dynamic; placed 12 times in the master. **Proposal:** keep (structural, parked under D-006).
265. **BK-265 Column Bars.** about 600 x 530 mm; layer RC COLUMN REINFORCEMENT, GUIDELINES. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
266. **BK-266 COLUMN OVER.** member tag text; text "C1(O)"; about 559 x 559 mm; layer SUPPORT COLUMN TEXT OVER. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
267. **BK-267 CONTINUOUS.** member tag text; text "CONT."; about 641 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
268. **BK-268 DOWELS.** about 300 x 400 mm; layer REINFORCEMENT ADDITIONAL. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
269. **BK-269 DS1.** member tag text; text "DS1"; about 496 x 496 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
270. **BK-270 DS1-R.** member tag text; text "DS1"; about 496 x 496 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with DS1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
271. **BK-271 DYNAMIC BLOCK.** hatch ANSI31, DOTS; about 140 x 200 mm; layer WALLS BLOCK, DEFPOINTS. Dynamic; placed 1 time in the master. **Proposal:** merge into 140-BLOCK.
272. **BK-272 EB1 TOP.** member tag text; text "EB1"; about 541 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
273. **BK-273 EB1-BOTTOM.** member tag text; text "EB1"; about 541 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with EB1 TOP: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
274. **BK-274 EB2.** member tag text; text "EB2"; about 541 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
275. **BK-275 EB2-BOTTOM.** member tag text; text "EB2"; about 541 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with EB2: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
276. **BK-276 F1.** member tag text; text "PF1"; about 526 x 526 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
277. **BK-277 F2.** member tag text; text "PF2"; about 526 x 526 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
278. **BK-278 FB.** member tag text; text "FB"; about 366 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
279. **BK-279 FB-BOTTOM.** member tag text; text "FB"; about 366 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with FB: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
280. **BK-280 GANG NAIL.** hatch CROSS; about 68 x 116 mm; layer 18CONT, 35CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
281. **BK-281 HOOP IRON STRAP.** about 39 x 528 mm; layer 18CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
282. **BK-282 IB1.** member tag text; text "IB1"; about 430 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
283. **BK-283 IB1-BOTTOM.** member tag text; text "IB1"; about 430 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with IB1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
284. **BK-284 IB2.** member tag text; text "IB2"; about 430 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
285. **BK-285 IB2-BOTTOM.** member tag text; text "IB2"; about 430 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with IB2: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
286. **BK-286 JOIST HAGER RIGHT.** about 117 x 166 mm; layer 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
287. **BK-287 JOIST HANGER LEFT.** about 117 x 166 mm; layer 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (pair with JOIST HAGER RIGHT: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
288. **BK-288 JOIST HANGER TALL LEFT.** about 117 x 248 mm; layer 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
289. **BK-289 JOIST HANGER TALL RIGHT.** about 117 x 248 mm; layer 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
290. **BK-290 L.** member tag text; text "L"; about 159 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
291. **BK-291 L-BOTTOM.** member tag text; text "L"; about 159 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with L: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
292. **BK-292 MEMBER BEYOND.** member tag text; text "1_1 BEYOND"; about 162 x 162 mm; layer 18TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
293. **BK-293 OVER.** member tag text; text "OVER"; about 584 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
294. **BK-294 P1.** member tag text; text "P1"; about 379 x 379 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
295. **BK-295 P1-R.** member tag text; text "P1"; about 379 x 379 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with P1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
296. **BK-296 PC1.** member tag text; text "PC1"; about 496 x 496 mm; layer SUPPORT TEXT COLUMN. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
297. **BK-297 PC1-R.** member tag text; text "PC1"; about 496 x 496 mm; layer SUPPORT TEXT COLUMN. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with PC1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
298. **BK-298 PORTAL FRAME.** member tag text; text "PORTAL FRAME"; about 1,604 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
299. **BK-299 PT250 LABEL.** text "PT250"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
300. **BK-300 PT300 LABEL.** text "PT300"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
301. **BK-301 PT400 LABEL.** text "PT400"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
302. **BK-302 PT450 LABEL.** text "PT450"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
303. **BK-303 PT500 LABEL.** text "PT500"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
304. **BK-304 PT550 LABEL.** text "PT550"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
305. **BK-305 PT600 LABEL.** text "PT600"; about 844 x 475 mm; layer WALL BRACING TYPE C. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
306. **BK-306 RAFTERJOISTS.** fill-in fields R1/FJ1; about 2,582 x 2,097 mm; layer 25DIMS, 0. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
307. **BK-307 RB.** member tag text; text "RB"; about 398 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
308. **BK-308 RB-BOTTOM.** member tag text; text "RB"; about 398 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with RB: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
309. **BK-309 RL.** member tag text; text "RL"; about 366 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
310. **BK-310 RL-BOTTOM.** member tag text; text "RL"; about 366 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with RL: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
311. **BK-311 Screw Pile.** fill-in fields SP; about 1,000 x 330 mm; layer SCREW PILE. Dynamic; placed 19 times in the master. **Proposal:** keep (structural, parked under D-006).
312. **BK-312 SF1.** member tag text; text "SF1"; about 525 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
313. **BK-313 SF1-BOTTOM.** member tag text; text "SF1"; about 525 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with SF1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
314. **BK-314 SF2.** member tag text; text "SF2"; about 525 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
315. **BK-315 SF2-BOTTOM.** member tag text; text "SF2"; about 525 x 319 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with SF2: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
316. **BK-316 SLAB THICKNESS 2.** fill-in fields THICK; contains a hidden copy of a dynamic block; about 12 x 7 mm; layer SLAB THICKNESS TEXT, SLAB THICKNESS. Not dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
317. **BK-317 STARTER BAR.** about 171 x 621 mm; layer 70CONT, 35CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
318. **BK-318 STIFFENER.** about 40 x 149 mm; layer WELDING, 25CONT. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
319. **BK-319 STUD WALL DYNAMIC.** hatch SOLID, WOODFACE; about 306 x 646 mm; layer HATCH STUD WALL, 25CONT. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
320. **BK-320 SUPPORT BLOCK.** about 483 x 517 mm; layer 0, SUPPORT DEFPOINTS. Dynamic; placed 31 times in the master. **Proposal:** keep (structural, parked under D-006).
321. **BK-321 SUPPORT BLOCK NEW.** about 483 x 517 mm; layer SUPPORT DEFPOINTS, 0. Dynamic; placed 21 times in the master. **Proposal:** keep (structural, parked under D-006).
322. **BK-322 SUPPORT_BLOCK.** about 483 x 517 mm; layer SUPPORT DEFPOINTS, 0. Dynamic; placed 2 times in the master. **Proposal:** merge into SUPPORT BLOCK NEW.
323. **BK-323 TH1.** member tag text; text "TH1"; about 535 x 535 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
324. **BK-324 TH2.** member tag text; text "TH2"; about 535 x 535 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
325. **BK-325 TH3.** member tag text; text "TH3"; about 535 x 535 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
326. **BK-326 TH4.** member tag text; text "TH4"; about 535 x 535 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
327. **BK-327 thick.** fill-in fields THICK; about 12 x 6 mm; layer SLAB THICKNESS, SLAB THICKNESS TEXT. Not dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
328. **BK-328 TRIP-L-GRIP.** hatch CROSS; about 48 x 126 mm; layer 35CONT, 18CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
329. **BK-329 TRIP-L-GRIP 2.** hatch CROSS; about 41 x 69 mm; layer 18CONT, 35CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
330. **BK-330 TS1.** member tag text; text "TS1"; about 478 x 478 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
331. **BK-331 TS1-R.** member tag text; text "TS1"; about 478 x 478 mm; layer SUPPORT TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with TS1: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
332. **BK-332 Type A.** text "A"; about 2,880 x 650 mm; layer WALL BRACING TYPE A, DEFPOINTS. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
333. **BK-333 Type A - Brace.** contains a hidden copy of a dynamic block; about 2,880 x 650 mm; layer 0. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
334. **BK-334 Type A - Brace L.** text "A"; about 2,880 x 650 mm; layer WALL BRACING TYPE A, DEFPOINTS. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
335. **BK-335 Type B.** text "B"; about 1,180 x 650 mm; layer WALL BRACING TYPE B, DEFPOINTS. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked under D-006).
336. **BK-336 Type B - Brace.** text "B"; about 2,700 x 650 mm; layer WALL BRACING TYPE B, DEFPOINTS. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
337. **BK-337 Type BT1.** fill-in fields TRUSS; about 2,700 x 554 mm; layer 0, WALL BRACING TYPE BT1. Dynamic; placed 9 times in the master. **Proposal:** keep (structural, parked under D-006).
338. **BK-338 Type P1.** member tag text; text "P1"; about 2,700 x 650 mm; layer WALL BRACING TYPE C, DEFPOINTS. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
339. **BK-339 Type P2.** text "P2"; about 2,700 x 650 mm; layer WALL BRACING TYPE C, DEFPOINTS. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked under D-006).
340. **BK-340 Type S1 - Brace.** text "S1"; about 2,880 x 650 mm; layer WALL BRACING TYPE A, WALL BRACING TYPE S. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked under D-006).
341. **BK-341 Type S1 - Brace R.** contains a hidden copy of a dynamic block; about 2,880 x 650 mm; layer 0. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (pair with Type A - Brace: same text and size, may differ only in which side the text sits or a mirror; keep both or make one dynamic block).
342. **BK-342 UNDER.** member tag text; text "UNDER"; about 733 x 230 mm; layer 18TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked under D-006).
343. **BK-343 A$C02db0a8f.** member tag text; text "FB_"; about 505 x 350 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
344. **BK-344 A$C06d24d7e.** member tag text; text "BW1(O)"; about 745 x 230 mm; layer 18TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
345. **BK-345 A$C0707566b.** fill-in fields BRACING; about 2,880 x 614 mm; layer WALL BRACING. Dynamic; placed 3 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
346. **BK-346 A$C08b60d97.** hatch JIS_LC_8A, SOLID; about 1,450 x 4,435 mm; layer HATCH 11, 9CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
347. **BK-347 A$C0C432F43.** hatch SOLID; about 147 x 100 mm; layer SLEEPER RETAINING WALL, RETAINING WALL. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
348. **BK-348 A$C15731cf4.** member tag text; text "FB_"; about 505 x 200 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
349. **BK-349 A$C1973e579.** member tag text; text "FB_"; about 505 x 250 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
350. **BK-350 A$C1df1e16a.** about 2,000 x 2,000 mm; layer REINFORCEMENT ADDITIONAL. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
351. **BK-351 A$C23044EDF.** about 3,200 x 700 mm; layer SLAB THICKNESS. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
352. **BK-352 A$C23a4386f.** about 45 x 240 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
353. **BK-353 A$C24763418.** member tag text; text "STEP"; about 1,400 x 592 mm; layer 18CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
354. **BK-354 A$C2f8362d7.** about 45 x 360 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
355. **BK-355 A$C3541c4c9.** member tag text; text "FB_"; about 505 x 420 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
356. **BK-356 A$C3b5a3b8f.** about 45 x 290 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
357. **BK-357 A$C3f4cc5ac.** member tag text; text "FB_"; about 505 x 350 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C02db0a8f.
358. **BK-358 A$C44BE304A.** hatch SOLID; about 600 x 400 mm; layer 0, CAST IN PLATE IN FRONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
359. **BK-359 A$C4c4632ba.** contains a hidden copy of a dynamic block; about 450 x 450 mm; layer BORED PIER UNDER. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
360. **BK-360 A$C4f7b0216.** member tag text; text "FB_"; about 505 x 300 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
361. **BK-361 A$C51e08d9a.** member tag text; text "  C1"; about 195 x 680 mm; layer WELDING, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
362. **BK-362 A$C562fc3b1.** hatch SOLID, WOODFACE; about 1,529 x 3,787 mm; layer HATCH STUD WALL, 25CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
363. **BK-363 A$C588d870d.** member tag text; text "  C1"; about 195 x 680 mm; layer WELDING, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
364. **BK-364 A$C5d295bb9.1.** hatch SOLID; about 200 x 152 mm; layer SLEEPER RETAINING WALL, SLEEPER RETAINING WALL HATCH. Dynamic; placed 45 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
365. **BK-365 A$C61D13DF0.** hatch SOLID; about 424 x 424 mm; layer STUMPS. Not dynamic; placed 5 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
366. **BK-366 A$C63635a6b.** hatch ANSI31, WOODFACE; about 1,779 x 4,150 mm; layer HATCH STUD WALL, 25CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
367. **BK-367 A$C6da933ed.** member tag text; text "FB_"; about 505 x 150 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
368. **BK-368 A$C6f3eb472.** hatch ANSI37, AR-SAND, JIS_LC_8A; about 1,600 x 7,374 mm; layer 18CONT, HATCH TIMBER. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
369. **BK-369 A$C6ffc57c3.** member tag text; text "FB_"; about 505 x 420 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C3541c4c9.
370. **BK-370 A$C74ef5c53.** member tag text; text "FB_"; about 505 x 300 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C4f7b0216.
371. **BK-371 A$C78390d6e.** hatch SOLID; about 1,175 x 75 mm; layer HATCH 31, SLEEPER RETAINING WALL. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
372. **BK-372 A$C812a1502.** contains a hidden copy of a dynamic block; about 2,880 x 650 mm; layer WALL BRACING TYPE A. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
373. **BK-373 A$C81a38721.** hatch ANSI31; about 1,000 x 90 mm; layer LOADBEARING WALL, HATCHOUTLINE. Dynamic; placed 6 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
374. **BK-374 A$C8414cca5.** member tag text; text "FB_"; about 505 x 150 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C6da933ed.
375. **BK-375 A$C95ea6f72.** member tag text; text "  C1"; contains a hidden copy of a dynamic block; about 295 x 844 mm; layer WELDING, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
376. **BK-376 A$C9a0ce05b.** fill-in fields DEPTH; hatch SOLID; about 699 x 868 mm; layer BEAM, 9CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
377. **BK-377 A$Ca66df757.** member tag text; text "BW1(U)"; about 733 x 230 mm; layer 18TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
378. **BK-378 A$Ca736f8c0.** about 45 x 140 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
379. **BK-379 A$Ca8495c80.** about 45 x 190 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
380. **BK-380 A$Cacd65ef2.** about 90 x 45 mm; layer HATCH TIMBER, TIMBER BEAMS. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
381. **BK-381 A$Cb1089f04.** hatch JIS_LC_8A; about 2,575 x 4,435 mm; layer WALL HATCH, 0. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
382. **BK-382 A$Cb58920a9.** member tag text; text "PF4"; about 526 x 526 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
383. **BK-383 A$Cb92f944d.** hatch WOODFACE; about 377 x 125 mm; layer HATCH TIMBER. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
384. **BK-384 A$Cbaf7fc80.** hatch SOLID, WOODFACE; about 1,529 x 4,287 mm; layer HATCH STUD WALL, 25CONT. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
385. **BK-385 A$Cbec5ca9b.** hatch SOLID; about 300 x 300 mm; layer CAST-IN PLATE HATCH, CAST-IN PLATE. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
386. **BK-386 A$Cbf942e10.** hatch SOLID; about 240 x 240 mm; layer HATCH 11 - LOAD BEARING WALL OVER. Not dynamic; placed 11 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
387. **BK-387 A$Cc3d977b0.** member tag text; text "  C1"; about 295 x 717 mm; layer WELDING, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
388. **BK-388 A$Cc98093fe.** member tag text; text "FB_"; about 505 x 200 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C15731cf4.
389. **BK-389 A$Ccb2bbba9.** hatch ANSI37, AR-SAND, JIS_LC_8A; about 1,600 x 3,935 mm; layer 25CONT, HATCH STUD WALL. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
390. **BK-390 A$Cccd665c9.** member tag text; text "BP3"; about 536 x 536 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
391. **BK-391 A$Ccf8cf82e.** hatch WOODFACE; about 756 x 4,323 mm; layer HATCH TIMBER, 18CONT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
392. **BK-392 A$Cd2a42f46.** hatch ANSI37, WOODFACE; about 1,114 x 3,908 mm; layer 18CONT, HATCH STUD WALL. Dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
393. **BK-393 A$Cdafe998c.** member tag text; text "BW1(O)"; about 745 x 230 mm; layer 18TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$C06d24d7e.
394. **BK-394 A$Cddd2ea4a.** member tag text; text "FB_"; about 505 x 250 mm; layer 18CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C1973e579.
395. **BK-395 A$Ce0b09645.** member tag text; text "BW1(U)"; about 733 x 230 mm; layer 18TEXT. Dynamic; placed 1 time in the master. **Proposal:** merge into A$Ca66df757.
396. **BK-396 A$Ce3a2da80.** member tag text; text "FB__ CANT."; about 1,367 x 230 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** merge into BEAM LABEL.
397. **BK-397 A$Cebd0794f.** text "A.J"; about 1,000 x 319 mm; layer ARTICULATION JOINT, 25TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
398. **BK-398 A$Cec844387.** hatch SOLID; about 320 x 320 mm; layer HATCH 11 - LOAD BEARING WALL OVER. Not dynamic; placed 12 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
399. **BK-399 A$Cf303a7af.** member tag text; text "PF3"; about 526 x 526 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** keep (structural, parked), give it a proper name later.
400. **BK-400 A$Cf4c5e6b2.** about 2,453 x 150 mm; layer HATCH 31, SLEEPER RETAINING WALL. Dynamic; placed 2 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
401. **BK-401 A$Cfb1103aa.** hatch SOLID; about 160 x 160 mm; layer HATCH 11 - LOAD BEARING WALL OVER. Not dynamic; placed 11 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
402. **BK-402 A$Cfbac6ae0.** hatch ANSI31; about 1,190 x 1,385 mm; layer RAFTERS, 8CONT. Not dynamic; placed 4 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.
403. **BK-403 A$Cfe6cb77c.** hatch SOLID; about 106 x 106 mm; layer HATCH 11 - LOAD BEARING WALL OVER. Not dynamic; placed 11 times in the master. **Proposal:** keep (structural, parked), give it a proper name later.

### Unknown (50)

404. **BK-404 CAPPING BEAM STEP.** text "STEP"; fill-in fields STEP, CB_STEP; about 1,098 x 443 mm; layer 18TEXT, 18CONT. Dynamic; placed 1 time in the master. **Proposal:** keep.
405. **BK-405 CE_CPB_20260326_093702.** text "RL ........ / 150 DIA. SEWER MAIN"; hatch EARTH; contains CE_CPB_20260325_143832; about 7,382 x 7,381 mm; layer 35CONT, 25DIMS. Not dynamic; placed 1 time in the master. **Proposal:** drop-candidate (left behind by the old CPB tool, named by date and time).
406. **BK-406 Column Shade.** hatch AR-CONC; about 3,000 x 2,000 mm; layer GUIDELINES, DEFPOINTS. Dynamic; placed 4 times in the master. **Proposal:** keep.
407. **BK-407 LEFTIE.** fill-in fields FOOTING_TYPE, COLUMN_TYPE; about 1,790 x 1,982 mm; layer 25TEXT, 10TEXT. Not dynamic; placed 4 times in the master. **Proposal:** keep.
408. **BK-408 RAFTERS.** fill-in fields R1/FJ1; about 2,582 x 2,097 mm; layer 25DIMS, 0. Dynamic; placed 4 times in the master. **Proposal:** merge into RAFTERJOISTS.
409. **BK-409 RL___.** contains a hidden copy of a dynamic block; about 1,650 x 596 mm; layer 0. Not dynamic; placed 2 times in the master. **Proposal:** keep.
410. **BK-410 SCREW PILES.** fill-in fields SP; about 836 x 999 mm; layer 0, GUIDELINES. Dynamic; placed 1 time in the master. **Proposal:** keep.
411. **BK-411 STEP TAG.** text "STEP"; fill-in fields STEP; about 1,011 x 428 mm; layer 18TEXT, 18CONT. Dynamic; placed 3 times in the master. **Proposal:** keep.
412. **BK-412 VIEW - SIDE.** fill-in fields A1, A2; contains 2 hidden copies of dynamic blocks; about 1,000 x 3,104 mm; layer 0, 35TEXT. Dynamic; placed 1 time in the master. **Proposal:** keep.
413. **BK-413 A$C017b8207.** text "N12 - 400 CTS. 400 LAP VERT. BARS / N12 - 400 CTS."; contains a hidden copy of a dynamic block; about 15,808 x 7,700 mm; layer 25TEXT, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
414. **BK-414 A$C019ab699.** text "0 - 1000mm / 100 UC 15 AT 1200 MAX CTS"; contains a hidden copy of a dynamic block; about 15,808 x 6,700 mm; layer 25TEXT, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
415. **BK-415 A$C036900C0.** text "ORIENTATION OF '    ' BRACKET TO P1 POST OVER (TYPICAL)"; about 4,372 x 1,154 mm; layer 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
416. **BK-416 A$C12426c7a.** text "- / RL1"; contains 2 hidden copies of dynamic blocks; about 20,850 x 20,300 mm; layer 25TEXT, 35TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
417. **BK-417 A$C13C93C44.** about 450 x 450 mm; layer 0. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
418. **BK-418 A$C16a087cc.** about 1,300 x 400 mm; layer 18CONT. Dynamic; placed 3 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
419. **BK-419 A$C1b986084.** contains a hidden copy of a dynamic block; about 260 x 80 mm; layer HATCH 10. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
420. **BK-420 A$C1E3D6F90.** about 200 x 240 mm; layer 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
421. **BK-421 A$C22774cf4.** contains a hidden copy of a dynamic block; about 1,650 x 596 mm; layer 0. Not dynamic; placed 1 time in the master. **Proposal:** merge into RL___.
422. **BK-422 A$C2541944Z.** about 5,150 x 2,650 mm; layer 35CONT. Dynamic; placed 11 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
423. **BK-423 A$C32C15792.** about 5,150 x 2,650 mm; layer 35CONT. Dynamic; placed 9 times in the master. **Proposal:** merge into A$C2541944Z.
424. **BK-424 A$C34D7784C.** hatch SOLID; about 300 x 300 mm; layer 70CONT, HATCH 51. Not dynamic; placed 4 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
425. **BK-425 A$C3BD31297.** about 215 x 250 mm; layer 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
426. **BK-426 A$C3DB57EB2.** about 141 x 141 mm; layer 0. Not dynamic; placed 5 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
427. **BK-427 A$C41c113f7.** hatch AR-CONC; about 450 x 450 mm; layer HATCH 11, 0. Dynamic; placed 2 times in the master. **Proposal:** merge into A$Cb093a860.
428. **BK-428 A$C51842844.** contains a hidden copy of a dynamic block; about 926 x 965 mm; layer 0. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
429. **BK-429 A$C602e9b0a.** about 750 x 99 mm; layer 25DIMS. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
430. **BK-430 A$C609b160f.** hatch SOLID; about 200 x 300 mm; layer 18CONT, HATCH 51. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
431. **BK-431 A$C679bac2c.** text "SF1 STRIP FOOTING / PF1 PAD FOOTING"; contains a hidden copy of a dynamic block; about 22,371 x 10,493 mm; layer GUIDELINES, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
432. **BK-432 A$C68135D6B.** about 403 x 440 mm; layer 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
433. **BK-433 A$C6EC3217A.** about 250 x 250 mm; layer 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
434. **BK-434 A$C764a2f0e.** hatch SOLID; about 10,000 x 8,119 mm; layer 35CONT, HATCH 51. Dynamic; placed 14 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
435. **BK-435 A$C7ad72f56.** fill-in fields FOOTING_TYPE, COLUMN_TYPE; about 1,790 x 1,982 mm; layer 25TEXT, 10TEXT. Not dynamic; placed 4 times in the master. **Proposal:** merge into LEFTIE.
436. **BK-436 A$C7af03645.** text "___ BLOCKWORK / BW1"; contains Block Wall Schedule; about 26,550 x 5,500 mm; layer 25TEXT, BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
437. **BK-437 A$C7b8d294a.** about 24 x 238 mm; layer 25CONT. Dynamic; placed 9 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
438. **BK-438 A$C7d67211f.** text "SF1 STRIP FOOTING / PF1 PAD FOOTING"; contains a hidden copy of a dynamic block; about 32,871 x 6,801 mm; layer GUIDELINES, 25TEXT. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
439. **BK-439 A$C866a2947.** contains a hidden copy of a dynamic block; about 939 x 978 mm; layer 0. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
440. **BK-440 A$C88506891.** contains a hidden copy of a dynamic block; about 954 x 964 mm; layer 0. Dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
441. **BK-441 A$C8878fcca.** contains 3 hidden copies of dynamic blocks; about 1,129 x 6,103 mm; layer BLOCKS. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
442. **BK-442 A$C88b77704.** contains a hidden copy of a dynamic block; about 1,011 x 428 mm; layer 0. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
443. **BK-443 A$C914d3efd.** about 72 x 72 mm; layer 25CONT. Dynamic; placed 9 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
444. **BK-444 A$C9d55d28f.** hatch AR-CONC; about 450 x 450 mm; layer 35CONT, 25CONT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
445. **BK-445 A$Cb01ca845.** contains A$C0AC007BC; about 7,813 x 2,537 mm; layer 0. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
446. **BK-446 A$Cb093a860.** hatch AR-CONC; about 450 x 450 mm; layer HATCH 11, 0. Dynamic; placed 47 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
447. **BK-447 A$Cb7b1048b.** hatch SOLID; about 185 x 126 mm; layer 35CONT, 25TEXT. Not dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
448. **BK-448 A$Cc1859d59.** about 750 x 99 mm; layer 25DIMS. Not dynamic; placed 2 times in the master. **Proposal:** merge into A$C602e9b0a.
449. **BK-449 A$Cc609234a.** contains a hidden copy of a dynamic block; about 940 x 950 mm; layer 0. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
450. **BK-450 A$Cd1a7e07f.** whole sample sheet pasted as a block; text "400x400 / 500x500"; contains 3 hidden copies of dynamic blocks; about 153,202 x 207,026 mm; layer BLOCKS, GUIDELINES. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (a whole sheet held as one block).
451. **BK-451 A$Ceb5d7faa.** about 173 x 100 mm; layer HATCH 31. Not dynamic; placed 1 time in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
452. **BK-452 A$Cf0f6c55a.** about 500 x 133 mm; layer 18CONT. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).
453. **BK-453 A$Cf215024f.** hatch AR-SAND; about 1,972 x 200 mm; layer 9CONT, 18CONT. Dynamic; placed 2 times in the master. **Proposal:** ask Tim (what it is for; then name it or drop it).

## What was not done

1. **Dynamic block states** (visibility lists) were not read.
2. **Use on real jobs** was not counted; only placements in the master drawing.
3. **The A1 vertical template** was not read.
4. **Nothing was renamed, merged or dropped.** Every proposal waits for Tim.
