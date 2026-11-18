# Office layers by what they are for (the list behind OFFICELAYER / OL)

**Revision:** 1 (Wed 18 Nov 2026, evening, Melbourne time). IDs: LY-001 to LY-189 for layers, Q-L1 onwards for questions; never reused.
**Asked for by Tim:** "Same as hatches" (TA-130): sort the master drawing's layers by what each is for, using the old jobs, and show him only the overlaps and unknowns.
**How it was read (read only):**
1. **Master drawing:** the copy of its DXF at `C:\CE_WORK\scratch\blocks_review\master_copy.dxf`. Each layer's colour, linetype and print setting, and what sits on it.
2. **Old jobs:** 218 drawings from 21 old jobs in the local evidence store. The same layer names were looked for there, with what kinds of objects sit on them and on how many jobs.

Only master layer names, counts and job counts are written here. Names of blocks and words found in old jobs are left out, because some carry job details. AutoCAD was not used. The consultant match list living in the office IT folder is the working assumption: DRAFT.

## The answer first

1. **189 layers:** 181 are used in the old jobs; 8 are not.
2. **By group:**
   - **Hatches:** 32, already settled by the hatch list (D-227).
   - **Slabs and footings:** 28.
   - **Civil site and services:** 20.
   - **Bracing and supports:** 20.
   - **Civil drainage:** 15.
   - **Framing and steel:** 14.
   - **Pens:** 12.
   - **Walls:** 12.
   - **Sheet:** 11.
   - **Helper (non-printing and AutoCAD's own):** 8.
   - **Text:** 7.
   - **Architecture background:** 5.
   - **Existing services:** 4.
   - **Dimensions:** 1.
3. **Proposals:**
   - **Keep:** 136.
   - **As the hatch list:** 28.
   - **Drop-candidate:** 4. These are not used in any old job: LAYER LOCK, HIDDENLINE, HATCH 10 - CONC COLUMN UNDER, HATCH 231 - FENCE WALL UNDER.
   - **Retired already:** 1 (EXISTING WALL HATCH, TA-051).
   - **Questions for Tim:** 20 layers, in the 10 questions below.
4. **Layers named by Tim's earlier rulings:**
   - **SLAB CJ:** not in the master at all; the joints tool makes it (TA-121).
   - **XREF:** where CLEAN puts Xrefs (TA-081).
   - **The pen and text layers:** pens, not sizes (TA-116).

## The 10 questions (only the overlaps and unknowns)

1. **Q-L1 Stormwater linework:** STORMWATER (lines, 10 jobs), DRAINAGE (pipe walls as multilines, 9 jobs) and EX DRAIN HATCH (existing drain outline, phantom, 11 jobs). The new PIPE tool draws on STORMWATER PIPE and its own kinds.
   - **Proposal:** keep STORMWATER for hand-drawn drainage lines, keep EX DRAIN HATCH for existing drains, and retire DRAINAGE from the list (the PIPE tool replaces multiline pipe walls).
   - **Example:** a hand-drawn AG line to a soakage trench.
2. **Q-L2 Services named twice:** WATER (9 jobs) and WATER LINE (none); ELEC OVERHEAD (8 jobs) and ELECTRICAL OVERHEAD (none).
   - **Proposal:** keep WATER and ELEC OVERHEAD, and retire the unused twins.
   - **Note:** the new CIVIL LINETYPES block (BK-081) uses WATER LINE, so it would move to WATER.
3. **Q-L3 TITLE TEXT does not print.** It holds title text (8 jobs, 480 objects) but is set not to print in the master.
   - **Proposal:** ask why. If it is a mistake, set it to print.
   - **Example:** a sheet title that vanishes on the PDF.
4. **Q-L4 Existing walls named twice:** WALLS EXISTING (11 jobs) and EXISTING WALL (4 jobs).
   - **Proposal:** keep WALLS EXISTING, the "WALLS ..." family name, and retire EXISTING WALL. This matches retiring its hatch (TA-051).
5. **Q-L5 Section and grid extras:** SECTION TAG (12 jobs) beside SECTION MARK, and 9GRID (fine centre line, 10 jobs) beside GRID.
   - **Proposal:** keep both pairs, each with its own use: the section tag is the bubble on a detail and the mark is the cut on a plan; 9GRID is a light grid, GRID the main one. To confirm.
6. **Q-L6 Slab edge named twice:** SLAB PERIMETER (14 jobs, 2,686 objects) and SLAB OUTLINE (7 jobs, 20 objects).
   - **Proposal:** keep SLAB PERIMETER and retire SLAB OUTLINE from the list.
7. **Q-L7 Construction joints on two layers:** CONSTRUCTION JOINT (palette blocks, 12 jobs) and SLAB CJ, which the joints tool uses (TA-121).
   - **Proposal:** the joints tool draws on SLAB CJ only, and CONSTRUCTION JOINT is retired from the list. Old drawings keep theirs.
8. **Q-L8 Bored pier fill named twice:** BORED PIER HATCH (7 jobs) and HATCH BORED PIER (9 jobs), both solid, colour 47.
   - **Proposal:** keep HATCH BORED PIER, the "HATCH ..." family name (as TA-055), and retire the other.
9. **Q-L9 Roof bracing named twice:** BRACING ROOF (11 jobs) and ROOF BRACING (9 jobs), both DASHDOT2, colour 6.
   - **Proposal:** keep ROOF BRACING, next to ROOF LOWER and ROOF UPPER, and retire BRACING ROOF.
10. **Q-L10 Band beam:** HATCH 74 - BANDBEAM (7 jobs) beside HATCH 74 (band beam, first floor over, rain garden, TA-049) and BANDBEAM (the hidden outline).
    - **Proposal:** the band beam hatch goes on HATCH 74 as ruled, and HATCH 74 - BANDBEAM is retired. BANDBEAM stays for the outline.

## Every layer

### Pens (12)

1. **LY-001 18CONT:** lines, pen 0.18. Colour 6, Continuous. 19 of 21 old jobs, 100,610 objects. **Proposal:** keep.
2. **LY-002 18HIDDEN:** hidden lines, pen 0.18. Colour 6, Hidden. 18 of 21 old jobs, 5,085 objects. **Proposal:** keep.
3. **LY-003 18HIDDEN2:** hidden lines (short dash), pen 0.18. Colour 6, Hidden2. 18 of 21 old jobs, 8,690 objects. **Proposal:** keep.
4. **LY-004 25CONT:** lines, pen 0.25. Colour 7, Continuous. 19 of 21 old jobs, 91,115 objects. **Proposal:** keep.
5. **LY-005 35CONT:** lines, pen 0.35. Colour 2, Continuous. 19 of 21 old jobs, 51,002 objects. **Proposal:** keep.
6. **LY-006 50CONT:** lines, pen 0.50. Colour 3, Continuous. 19 of 21 old jobs, 11,108 objects. **Proposal:** keep.
7. **LY-007 70CONT:** lines, pen 0.70. Colour 4, Continuous. 18 of 21 old jobs, 15,173 objects. **Proposal:** keep.
8. **LY-008 8CONT:** lines, pen 8 (light grey). Colour 8, Continuous. 10 of 21 old jobs, 116 objects. **Proposal:** keep.
9. **LY-009 9CONT:** lines, pen 9 (lightest). Colour 9, Continuous. 18 of 21 old jobs, 35,610 objects. **Proposal:** keep.
10. **LY-010 9HIDDEN:** hidden lines, pen 9. Colour 9, Hidden. 16 of 21 old jobs, 579 objects. **Proposal:** keep.
11. **LY-011 9HIDDEN2:** hidden lines (short dash), pen 9. Colour 9, Hidden2. 15 of 21 old jobs, 2,083 objects. **Proposal:** keep.
12. **LY-012 WELDING:** steel and weld detail lines (pen 9). Colour 9, Continuous. 16 of 21 old jobs, 52,373 objects. **Proposal:** keep (structural).

### Text (7)

13. **LY-013 10TEXT:** fill-in fields inside one block (LEFTIE); no text of its own in old jobs. Colour 10, Continuous. not used in any old job. **Proposal:** keep (inside a block only).
14. **LY-014 18TEXT:** text, pen 0.18 (TA-116). Colour 6, Continuous. 20 of 21 old jobs, 6,912 objects. **Proposal:** keep.
15. **LY-015 20TEXT:** level text: IL ____, CL ____, spot levels. Colour 10, Continuous. 7 of 21 old jobs, 1,052 objects. **Proposal:** keep.
16. **LY-016 25TEXT:** text, pen 0.25. Colour 7, Continuous. 21 of 21 old jobs, 62,341 objects. **Proposal:** keep.
17. **LY-017 35TEXT:** text, pen 0.35. Colour 2, Continuous. 19 of 21 old jobs, 7,213 objects. **Proposal:** keep.
18. **LY-018 50TEXT:** text, pen 0.50 (titles). Colour 3, Continuous. 19 of 21 old jobs, 5,130 objects. **Proposal:** keep.
19. **LY-019 70TEXT:** text, pen 0.70 (sheet titles). Colour 4, Continuous. 17 of 21 old jobs, 117 objects. **Proposal:** keep.

### Dimensions (1)

20. **LY-020 25DIMS:** dimensions and leaders, pen 0.25. Colour 7, Continuous. 20 of 21 old jobs, 148,295 objects. **Proposal:** keep.

### Civil drainage (15)

21. **LY-021 AGI DRAIN:** agricultural drain. Colour 2, Ag_Line. 11 of 21 old jobs, 292 objects. **Proposal:** keep.
22. **LY-022 DOWNPIPES:** downpipes, IO, overflow symbols. Colour 2, Continuous. 5 of 21 old jobs, 583 objects. **Proposal:** keep (inlet tools).
23. **LY-023 DOWNPIPES HATCH:** downpipe symbol fill. Colour 10, Continuous. 5 of 21 old jobs, 233 objects. **Proposal:** keep (inlet tools).
24. **LY-024 DRAINAGE:** pipe walls drawn as multilines. Colour 6, Continuous. 9 of 21 old jobs, 1,043 objects. **Proposal:** ASK (Q-L1).
25. **LY-025 FLOOR WASTE:** floor wastes. Colour 7, Continuous. 6 of 21 old jobs, 143 objects. **Proposal:** keep (inlet tools).
26. **LY-026 FLOOR WASTE HATCH:** floor waste fill. Colour 6, Continuous. 1 of 21 old jobs, 5 objects. **Proposal:** keep (inlet tools).
27. **LY-027 GRATED TRENCH:** grated trench (inside the pit block). Colour 9, Continuous. 6 of 21 old jobs, 901 objects. **Proposal:** keep.
28. **LY-028 PITS HIDDEN:** hidden pit walls. Colour 7, Hidden. 6 of 21 old jobs, 908 objects. **Proposal:** keep (PIT tool).
29. **LY-029 SPOON DRAIN:** spoon and strip drain labels. Colour 1, Continuous. 7 of 21 old jobs, 121 objects. **Proposal:** keep.
30. **LY-030 STORMWATER:** stormwater linework (general). Colour 9, Continuous. 10 of 21 old jobs, 3,226 objects. **Proposal:** ASK (Q-L1).
31. **LY-031 STORMWATER CHARGED PIPE:** charged pipe (dashed). Colour 10, Dashed. 7 of 21 old jobs, 37 objects. **Proposal:** keep (PIPE tool).
32. **LY-032 STORMWATER PIPE:** stormwater pipe (dashed). Colour 150, Dashed. 9 of 21 old jobs, 955 objects. **Proposal:** keep (PIPE tool).
33. **LY-033 STORMWATER PIT:** pits. Colour 2, Continuous. 6 of 21 old jobs, 1,584 objects. **Proposal:** keep (PIT tool).
34. **LY-034 STORMWATER RISING MAIN:** rising main (dashed). Colour 70, Dashed. 2 of 21 old jobs, 3 objects. **Proposal:** keep (PIPE tool).
35. **LY-035 TRENCH GRATE:** trench grates. Colour 9, Continuous. 7 of 21 old jobs, 369 objects. **Proposal:** keep.

### Existing (4)

36. **LY-036 EX DRAIN HATCH:** existing drain outline (phantom). Colour 61, Phantom. 11 of 21 old jobs, 168 objects. **Proposal:** ASK (Q-L1).
37. **LY-037 EX PIT:** existing pits. Colour 9, Continuous. 9 of 21 old jobs, 428 objects. **Proposal:** keep.
38. **LY-038 EX STORMWATER:** existing stormwater pipes. Colour 9, Hidden. 11 of 21 old jobs, 373 objects. **Proposal:** keep.
39. **LY-039 EXISTING DRAIN:** existing council drain in section (fill). Colour 2, Continuous. 11 of 21 old jobs, 674 objects. **Proposal:** keep.

### Civil site and services (20)

40. **LY-040 BATTER:** batters. Colour 253, Continuous. 8 of 21 old jobs, 239 objects. **Proposal:** keep.
41. **LY-041 BOUNDARY:** title boundary. Colour 2, Dashdot. 11 of 21 old jobs, 398 objects. **Proposal:** keep.
42. **LY-042 BYDA:** Before You Dig panel. Colour 7, Continuous. 7 of 21 old jobs, 842 objects. **Proposal:** keep.
43. **LY-043 CONTOURS AND LEVELS:** contours and levels. Colour 45, Center2. 4 of 21 old jobs, 1,184 objects. **Proposal:** keep.
44. **LY-044 DRIVEWAY:** driveways and paths. Colour 254, Continuous. 15 of 21 old jobs, 294 objects. **Proposal:** keep.
45. **LY-045 EASEMENT:** easements. Colour 6, Dashed. 10 of 21 old jobs, 68 objects. **Proposal:** keep.
46. **LY-046 ELEC OVERHEAD:** overhead power. Colour 251, Electricity. 8 of 21 old jobs, 54 objects. **Proposal:** ASK (Q-L2).
47. **LY-047 ELECTRICAL OVERHEAD:** overhead power; not used in any old job. Colour 251, Electricity. not used in any old job. **Proposal:** ASK (Q-L2).
48. **LY-048 FENCE:** fences. Colour 11, Continuous. 10 of 21 old jobs, 541 objects. **Proposal:** keep.
49. **LY-049 GAS:** gas service. Colour 9, Gas_Line. 9 of 21 old jobs, 29 objects. **Proposal:** keep.
50. **LY-050 LANDSCAPING:** landscaping. Colour 8, Continuous. 9 of 21 old jobs, 1,543 objects. **Proposal:** keep.
51. **LY-051 SEWER:** sewer service. Colour 9, Sewer. 11 of 21 old jobs, 102 objects. **Proposal:** keep.
52. **LY-052 SRZ:** structural root zone. Colour 233, Hidden. 2 of 21 old jobs, 16 objects. **Proposal:** keep.
53. **LY-053 SURVEY:** survey information. Colour 251, Continuous. 9 of 21 old jobs, 1,423 objects. **Proposal:** keep.
54. **LY-054 TELSTRA:** telecom service. Colour 9, Telstra. 10 of 21 old jobs, 42 objects. **Proposal:** keep.
55. **LY-055 TPZ:** tree protection zone. Colour 2, Hidden. 10 of 21 old jobs, 249 objects. **Proposal:** keep.
56. **LY-056 TREE:** trees. Colour 73, Continuous. 9 of 21 old jobs, 1,785 objects. **Proposal:** keep.
57. **LY-057 TREE EXISTING:** existing trees. Colour 53, Continuous. 6 of 21 old jobs, 430 objects. **Proposal:** keep.
58. **LY-058 WATER:** water service. Colour 9, Water. 9 of 21 old jobs, 39 objects. **Proposal:** ASK (Q-L2).
59. **LY-059 WATER LINE:** water service; not used in any old job. Colour 9, Water. not used in any old job. **Proposal:** ASK (Q-L2).

### Architecture (background) (5)

60. **LY-060 ARCH:** architect's linework copied in. Colour 252, Continuous. 9 of 21 old jobs, 508 objects. **Proposal:** keep.
61. **LY-061 AWNING:** awnings. Colour 42, Continuous. 9 of 21 old jobs, 48 objects. **Proposal:** keep.
62. **LY-062 BALUSTRADE:** balustrades. Colour 252, Continuous. 7 of 21 old jobs, 87 objects. **Proposal:** keep.
63. **LY-063 STAIRS:** stairs. Colour 11, Continuous. 10 of 21 old jobs, 2,087 objects. **Proposal:** keep.
64. **LY-064 WINDOW & DOOR:** windows and doors. Colour 253, Continuous. 8 of 21 old jobs, 2,429 objects. **Proposal:** keep.

### Walls (12)

65. **LY-065 BLOCKWORK WALL:** retaining block walls (hatch, TA-053). Colour 6, Continuous. 12 of 21 old jobs, 16,651 objects. **Proposal:** keep.
66. **LY-066 EXISTING WALL:** existing walls. Colour 61, Continuous. 4 of 21 old jobs, 14 objects. **Proposal:** ASK (Q-L4).
67. **LY-067 LOADBEARING WALL:** load bearing walls (lines); hatch retired (TA-053). Colour 10, Continuous. 17 of 21 old jobs, 388 objects. **Proposal:** keep.
68. **LY-068 RETAINING WALL:** retaining walls. Colour 1, Continuous. 6 of 21 old jobs, 170 objects. **Proposal:** keep.
69. **LY-069 SLEEPER RETAINING WALL:** sleeper retaining walls. Colour 1, Continuous. 6 of 21 old jobs, 118 objects. **Proposal:** keep.
70. **LY-070 SLEEPER RETAINING WALL HATCH:** sleeper wall fill. Colour 31, Continuous. 2 of 21 old jobs, 26 objects. **Proposal:** keep.
71. **LY-071 TEMPORARY SHORING:** temporary shoring. Colour 150, Center. 10 of 21 old jobs, 62 objects. **Proposal:** keep.
72. **LY-072 WALLS:** walls (new). Colour 47, Continuous. 11 of 21 old jobs, 2,853 objects. **Proposal:** keep.
73. **LY-073 WALLS BLOCK:** blockwork walls. Colour 6, Continuous. 12 of 21 old jobs, 1,606 objects. **Proposal:** keep.
74. **LY-074 WALLS BLOCK DWARF:** dwarf block walls. Colour 6, Continuous. 3 of 21 old jobs, 47 objects. **Proposal:** keep.
75. **LY-075 WALLS DEMOLISH:** walls to be demolished. Colour 14, Hidden. 11 of 21 old jobs, 64 objects. **Proposal:** keep.
76. **LY-076 WALLS EXISTING:** existing walls. Colour 61, Continuous. 11 of 21 old jobs, 383 objects. **Proposal:** ASK (Q-L4).

### Slabs and footings (28)

77. **LY-077 ARTICULATION JOINT:** articulation joints (AJ, TA-123). Colour 3, Center. 6 of 21 old jobs, 51 objects. **Proposal:** keep.
78. **LY-078 BANDBEAM:** band beam outline (hidden). Colour 2, Hidden. 9 of 21 old jobs, 48 objects. **Proposal:** keep.
79. **LY-079 BORED PIER:** bored piers. Colour 3, Continuous. 11 of 21 old jobs, 179 objects. **Proposal:** keep.
80. **LY-080 BORED PIER HATCH:** bored pier fill. Colour 47, Continuous. 7 of 21 old jobs, 146 objects. **Proposal:** ASK (Q-L8).
81. **LY-081 BORED PIER UNDER:** bored piers under (hidden). Colour 2, Hidden. 10 of 21 old jobs, 485 objects. **Proposal:** keep.
82. **LY-082 CAPPING BEAM:** capping beams. Colour 2, Hidden. 10 of 21 old jobs, 65 objects. **Proposal:** keep.
83. **LY-083 CONSTRUCTION JOINT:** construction joints (palette blocks). Colour 3, Phantom. 12 of 21 old jobs, 267 objects. **Proposal:** ASK (Q-L7).
84. **LY-084 FOOTINGS EXISTING:** existing footings. Colour 6, Hidden. 10 of 21 old jobs, 124 objects. **Proposal:** keep.
85. **LY-085 HATCH BORED PIER:** bored pier fill. Colour 47, Continuous. 9 of 21 old jobs, 181 objects. **Proposal:** ASK (Q-L8).
86. **LY-086 REINFORCEMENT ADDITIONAL:** extra reinforcement. Colour 170, Continuous. 8 of 21 old jobs, 282 objects. **Proposal:** keep.
87. **LY-087 SCREW PILE:** screw piles. Colour 10, Continuous. 6 of 21 old jobs, 61 objects. **Proposal:** keep.
88. **LY-088 SLAB - hob hatch:** hob fill. Colour 74, Continuous. 3 of 21 old jobs, 3 objects. **Proposal:** keep.
89. **LY-089 SLAB - hob perimeter:** hob edge. Colour 6, Continuous. 3 of 21 old jobs, 6 objects. **Proposal:** keep.
90. **LY-090 SLAB - threshold drain hatch:** threshold drain fill. Colour 141, Continuous. 2 of 21 old jobs, 2 objects. **Proposal:** keep.
91. **LY-091 SLAB - threshold perimeter:** threshold drain edge. Colour 9, Continuous. 2 of 21 old jobs, 4 objects. **Proposal:** keep.
92. **LY-092 SLAB - upstand hatch:** upstand fill. Colour 14, Continuous. 2 of 21 old jobs, 3 objects. **Proposal:** keep.
93. **LY-093 SLAB - upstand perimeter:** upstand edge. Colour 6, Continuous. 2 of 21 old jobs, 9 objects. **Proposal:** keep.
94. **LY-094 SLAB FOLD:** slab folds. Colour 7, Hidden. 9 of 21 old jobs, 50 objects. **Proposal:** keep.
95. **LY-095 SLAB INTERNAL BEAM:** internal beams under slab (hidden). Colour 2, Hidden. 15 of 21 old jobs, 1,392 objects. **Proposal:** keep.
96. **LY-096 SLAB OUTLINE:** slab edge. Colour 2, Continuous. 7 of 21 old jobs, 20 objects. **Proposal:** ASK (Q-L6).
97. **LY-097 SLAB PERIMETER:** slab edge. Colour 2, Continuous. 14 of 21 old jobs, 2,686 objects. **Proposal:** ASK (Q-L6).
98. **LY-098 SLAB SC:** saw cuts (SAWCUT / SSC, TA-121). Colour 2, Dashdot2. 11 of 21 old jobs, 798 objects. **Proposal:** keep.
99. **LY-099 SLAB SOFFIT:** slab soffit. Colour 2, Hidden. 6 of 21 old jobs, 38 objects. **Proposal:** keep.
100. **LY-100 SLAB STEP:** slab steps. Colour 6, Continuous. 9 of 21 old jobs, 92 objects. **Proposal:** keep.
101. **LY-101 SLAB THICKNESS:** slab thickness symbol. Colour 6, Continuous. 9 of 21 old jobs, 229 objects. **Proposal:** keep.
102. **LY-102 SLAB THICKNESS TEXT:** slab thickness figures. Colour 2, Continuous. 8 of 21 old jobs, 53 objects. **Proposal:** keep.
103. **LY-103 STRIP FOOTINGS:** strip footings (hidden). Colour 3, Hidden. 11 of 21 old jobs, 296 objects. **Proposal:** keep.
104. **LY-104 STUMPS:** stumps. Colour 6, Continuous. 8 of 21 old jobs, 68 objects. **Proposal:** keep.

### Framing and steel (14)

105. **LY-105 BEAM:** beams. Colour 4, Continuous. 19 of 21 old jobs, 2,174 objects. **Proposal:** keep.
106. **LY-106 BEAM LOWER:** lower beams (hidden). Colour 2, Hidden. 12 of 21 old jobs, 284 objects. **Proposal:** keep.
107. **LY-107 CAST IN PLATE IN FRONT:** cast-in plate in front (fill). Colour 6, Continuous. 6 of 21 old jobs, 2,303 objects. **Proposal:** keep.
108. **LY-108 CAST-IN PLATE:** cast-in plates. Colour 2, Continuous. 8 of 21 old jobs, 116 objects. **Proposal:** keep.
109. **LY-109 CAST-IN PLATE HATCH:** cast-in plate fill. Colour 51, Continuous. 7 of 21 old jobs, 16 objects. **Proposal:** keep.
110. **LY-110 COLUMN UNDER:** columns under. Colour 2, Continuous. 5 of 21 old jobs, 248 objects. **Proposal:** keep.
111. **LY-111 GIRDERS:** girders. Colour 3, Dashdot. 9 of 21 old jobs, 55 objects. **Proposal:** keep.
112. **LY-112 JOISTS:** joists. Colour 150, Continuous. 12 of 21 old jobs, 194 objects. **Proposal:** keep.
113. **LY-113 RAFTERS:** rafters. Colour 200, Continuous. 15 of 21 old jobs, 237 objects. **Proposal:** keep.
114. **LY-114 RC COLUMN:** concrete columns. Colour 2, Continuous. 6 of 21 old jobs, 46 objects. **Proposal:** keep.
115. **LY-115 RC COLUMN REINFORCEMENT:** column bars. Colour 4, Continuous. 1 of 21 old jobs, 24 objects. **Proposal:** keep.
116. **LY-116 ROOF LOWER:** lower roof. Colour 43, Continuous. 14 of 21 old jobs, 479 objects. **Proposal:** keep.
117. **LY-117 ROOF UPPER:** upper roof. Colour 55, Continuous. 9 of 21 old jobs, 360 objects. **Proposal:** keep.
118. **LY-118 TIMBER BEAMS:** timber beams. Colour 6, Continuous. 6 of 21 old jobs, 495 objects. **Proposal:** keep.

### Bracing and supports (20)

119. **LY-119 BRACING ROOF:** roof bracing. Colour 6, Dashdot2. 11 of 21 old jobs, 214 objects. **Proposal:** ASK (Q-L9).
120. **LY-120 ROOF BRACING:** roof bracing. Colour 6, Dashdot2. 9 of 21 old jobs, 256 objects. **Proposal:** ASK (Q-L9).
121. **LY-121 SEQUENCE:** bored pier sequence circles. Colour 6, Continuous. 5 of 21 old jobs, 12 objects. **Proposal:** keep.
122. **LY-122 SEQUENCE TEXT:** bored pier sequence numbers. Colour 7, Continuous. 5 of 21 old jobs, 12 objects. **Proposal:** keep.
123. **LY-123 SUPPORT:** supports. Colour 2, Continuous. 17 of 21 old jobs, 317 objects. **Proposal:** keep (structural).
124. **LY-124 SUPPORT COLUMN:** supports column. Colour 3, Continuous. 15 of 21 old jobs, 577 objects. **Proposal:** keep (structural).
125. **LY-125 SUPPORT COLUMN OVER:** supports column over. Colour 10, Continuous. 12 of 21 old jobs, 225 objects. **Proposal:** keep (structural).
126. **LY-126 SUPPORT COLUMN TEXT OVER:** supports column text over. Colour 10, Continuous. 14 of 21 old jobs, 241 objects. **Proposal:** keep (structural).
127. **LY-127 SUPPORT DROPPER:** supports dropper. Colour 2, Continuous. 7 of 21 old jobs, 42 objects. **Proposal:** keep (structural).
128. **LY-128 SUPPORT DS:** supports double studs. Colour 150, Continuous. 14 of 21 old jobs, 585 objects. **Proposal:** keep (structural).
129. **LY-129 SUPPORT OVER:** supports over. Colour 10, Continuous. 13 of 21 old jobs, 413 objects. **Proposal:** keep (structural).
130. **LY-130 SUPPORT STUB:** supports stub. Colour 7, Continuous. 8 of 21 old jobs, 66 objects. **Proposal:** keep (structural).
131. **LY-131 SUPPORT TEXT:** supports text. Colour 2, Continuous. 12 of 21 old jobs, 348 objects. **Proposal:** keep (structural).
132. **LY-132 SUPPORT TEXT COLUMN:** supports text column. Colour 3, Continuous. 12 of 21 old jobs, 335 objects. **Proposal:** keep (structural).
133. **LY-133 WALL BRACING:** wall bracing (general). Colour 7, Dashdot2. 11 of 21 old jobs, 141 objects. **Proposal:** keep.
134. **LY-134 WALL BRACING TYPE A:** wall bracing, type a. Colour 10, Dashdot2. 15 of 21 old jobs, 835 objects. **Proposal:** keep (structural).
135. **LY-135 WALL BRACING TYPE B:** wall bracing, type b. Colour 150, Dashdot2. 15 of 21 old jobs, 1,203 objects. **Proposal:** keep (structural).
136. **LY-136 WALL BRACING TYPE BT1:** wall bracing, type bt1. Colour 27, Dashdot2. 8 of 21 old jobs, 79 objects. **Proposal:** keep (structural).
137. **LY-137 WALL BRACING TYPE C:** wall bracing, type c. Colour 27, Dashdot2. 9 of 21 old jobs, 253 objects. **Proposal:** keep (structural).
138. **LY-138 WALL BRACING TYPE S:** wall bracing, type s. Colour 10, Dashdot2. 5 of 21 old jobs, 48 objects. **Proposal:** keep (structural).

### Hatches (32)

139. **LY-139 EXISTING WALL HATCH:** hatch layer: see the hatch list (D-227). Colour 250, Continuous. 4 of 21 old jobs, 7 objects. **Proposal:** retired from the hatch list (TA-051).
140. **LY-140 HATCH 10:** hatch layer: see the hatch list (D-227). Colour 10, Continuous. 14 of 21 old jobs, 1,411 objects. **Proposal:** as the hatch list.
141. **LY-141 HATCH 10 - CONC COLUMN UNDER:** hatch layer: see the hatch list (D-227). Colour 10, Continuous. not used in any old job. **Proposal:** drop-candidate (not used in any old job).
142. **LY-142 HATCH 11:** hatch layer: see the hatch list (D-227). Colour 11, Continuous. 18 of 21 old jobs, 14,902 objects. **Proposal:** as the hatch list.
143. **LY-143 HATCH 11 - FENCE WALL OVER:** hatch layer: see the hatch list (D-227). Colour 11, Continuous. 1 of 21 old jobs, 1 objects. **Proposal:** as the hatch list.
144. **LY-144 HATCH 11 - LOAD BEARING WALL OVER:** hatch layer: see the hatch list (D-227). Colour 11, Continuous. 11 of 21 old jobs, 362 objects. **Proposal:** as the hatch list.
145. **LY-145 HATCH 121:** hatch layer: see the hatch list (D-227). Colour 121, Continuous. 4 of 21 old jobs, 14 objects. **Proposal:** as the hatch list.
146. **LY-146 HATCH 138:** hatch layer: see the hatch list (D-227). Colour 138, Continuous. 1 of 21 old jobs, 4 objects. **Proposal:** as the hatch list.
147. **LY-147 HATCH 140:** hatch layer: see the hatch list (D-227). Colour 140, Continuous. 3 of 21 old jobs, 22 objects. **Proposal:** as the hatch list.
148. **LY-148 HATCH 141:** hatch layer: see the hatch list (D-227). Colour 141, Continuous. 15 of 21 old jobs, 167 objects. **Proposal:** as the hatch list.
149. **LY-149 HATCH 150:** hatch layer: see the hatch list (D-227). Colour 150, Continuous. 7 of 21 old jobs, 89 objects. **Proposal:** as the hatch list.
150. **LY-150 HATCH 174:** hatch layer: see the hatch list (D-227). Colour 174, Continuous. 4 of 21 old jobs, 19 objects. **Proposal:** as the hatch list.
151. **LY-151 HATCH 201:** hatch layer: see the hatch list (D-227). Colour 201, Continuous. 17 of 21 old jobs, 1,345 objects. **Proposal:** as the hatch list.
152. **LY-152 HATCH 21:** hatch layer: see the hatch list (D-227). Colour 21, Continuous. 19 of 21 old jobs, 7,369 objects. **Proposal:** as the hatch list.
153. **LY-153 HATCH 213:** hatch layer: see the hatch list (D-227). Colour 213, Continuous. 1 of 21 old jobs, 1 objects. **Proposal:** as the hatch list.
154. **LY-154 HATCH 231 - FENCE WALL UNDER:** hatch layer: see the hatch list (D-227). Colour 231, Continuous. not used in any old job. **Proposal:** drop-candidate (not used in any old job).
155. **LY-155 HATCH 231 - LOAD BEARING WALL UNDER:** hatch layer: see the hatch list (D-227). Colour 231, Continuous. 9 of 21 old jobs, 137 objects. **Proposal:** as the hatch list.
156. **LY-156 HATCH 238:** hatch layer: see the hatch list (D-227). Colour 238, Continuous. 9 of 21 old jobs, 43 objects. **Proposal:** as the hatch list.
157. **LY-157 HATCH 242:** hatch layer: see the hatch list (D-227). Colour 242, Continuous. 4 of 21 old jobs, 28 objects. **Proposal:** as the hatch list.
158. **LY-158 HATCH 253:** hatch layer: see the hatch list (D-227). Colour 253, Continuous. 10 of 21 old jobs, 953 objects. **Proposal:** as the hatch list.
159. **LY-159 HATCH 31:** hatch layer: see the hatch list (D-227). Colour 31, Continuous. 6 of 21 old jobs, 73 objects. **Proposal:** as the hatch list.
160. **LY-160 HATCH 47:** hatch layer: see the hatch list (D-227). Colour 47, Continuous. 7 of 21 old jobs, 27 objects. **Proposal:** as the hatch list.
161. **LY-161 HATCH 51:** hatch layer: see the hatch list (D-227). Colour 250, Continuous. 18 of 21 old jobs, 755 objects. **Proposal:** as the hatch list.
162. **LY-162 HATCH 6:** hatch layer: see the hatch list (D-227). Colour 6, Continuous. 7 of 21 old jobs, 25 objects. **Proposal:** as the hatch list.
163. **LY-163 HATCH 74:** hatch layer: see the hatch list (D-227). Colour 74, Continuous. 15 of 21 old jobs, 210 objects. **Proposal:** as the hatch list.
164. **LY-164 HATCH 74 - BANDBEAM:** band beam hatch. Colour 74, Continuous. 7 of 21 old jobs, 46 objects. **Proposal:** ASK (Q-L10).
165. **LY-165 HATCH EARTH:** hatch layer: see the hatch list (D-227). Colour 11, Continuous. 17 of 21 old jobs, 5,479 objects. **Proposal:** as the hatch list.
166. **LY-166 HATCH PANTONE:** hatch layer: see the hatch list (D-227). Colour 254, Continuous. 5 of 21 old jobs, 14 objects. **Proposal:** as the hatch list.
167. **LY-167 HATCH STUD WALL:** hatch layer: see the hatch list (D-227). Colour 47, Continuous. 11 of 21 old jobs, 4,525 objects. **Proposal:** as the hatch list.
168. **LY-168 HATCH TIMBER:** hatch layer: see the hatch list (D-227). Colour 47, Continuous. 16 of 21 old jobs, 6,069 objects. **Proposal:** as the hatch list.
169. **LY-169 HATCH WATER:** hatch layer: see the hatch list (D-227). Colour 150, Continuous. 8 of 21 old jobs, 631 objects. **Proposal:** as the hatch list.
170. **LY-170 WALL HATCH:** hatch layer: see the hatch list (D-227). Colour 8, Continuous. 18 of 21 old jobs, 1,374 objects. **Proposal:** as the hatch list.

### Sheet (11)

171. **LY-171 9GRID:** fine grid lines (pen 9, centre line). Colour 9, Center2. 10 of 21 old jobs, 448 objects. **Proposal:** ASK (Q-L5).
172. **LY-172 BLOCKS:** where office blocks are placed (schedules, section titles). Colour 7, Continuous. 19 of 21 old jobs, 10,028 objects. **Proposal:** keep.
173. **LY-173 CLOUD:** revision clouds (REVBOX / RV). Colour 12, Continuous. 16 of 21 old jobs, 482 objects. **Proposal:** keep.
174. **LY-174 DETSHT:** detail sheet linework and notes. Colour 2, Continuous. 12 of 21 old jobs, 5,540 objects. **Proposal:** keep.
175. **LY-175 GRID:** grid lines and grid bubbles. Colour 213, Center. 18 of 21 old jobs, 2,070 objects. **Proposal:** keep.
176. **LY-176 SCHEDULE:** schedule table lines. Colour 7, Continuous. 17 of 21 old jobs, 8,693 objects. **Proposal:** keep.
177. **LY-177 SECTION MARK:** section cut marks and bubbles. Colour 2, Continuous. 13 of 21 old jobs, 2,331 objects. **Proposal:** keep.
178. **LY-178 SECTION TAG:** section tags. Colour 2, Continuous. 12 of 21 old jobs, 321 objects. **Proposal:** ASK (Q-L5).
179. **LY-179 TITLE TEXT:** title text; set NOT to print in the master. Colour 2, Continuous, does not print. 8 of 21 old jobs, 480 objects. **Proposal:** ASK (Q-L3).
180. **LY-180 WIPEOUT:** masks behind text and symbols. Colour 255, Dotx2. 15 of 21 old jobs, 350 objects. **Proposal:** keep.
181. **LY-181 XREF:** where Xrefs sit (CLEAN puts them here, TA-081). Colour 7, Continuous. 17 of 21 old jobs, 846 objects. **Proposal:** keep.

### Helper (8)

182. **LY-182 *ADSK_ASSOC_ENTITY_BACKUPS:** AutoCAD's own hidden layer. Colour -7, Continuous. not used in any old job. **Proposal:** keep (AutoCAD's own, never in a list).
183. **LY-183 0:** AutoCAD's own layer; block insides and pasted work. Colour 7, Continuous. 21 of 21 old jobs, 47,328 objects. **Proposal:** keep (AutoCAD's own).
184. **LY-184 DEFPOINTS:** AutoCAD's dimension points; office uses it for non-printing lines. Colour 5, Continuous, does not print. 20 of 21 old jobs, 59,849 objects. **Proposal:** keep (AutoCAD's own).
185. **LY-185 GUIDELINES:** non-printing construction and setout lines, notes to self. Colour 75, Continuous, does not print. 20 of 21 old jobs, 12,465 objects. **Proposal:** keep.
186. **LY-186 HATCHOUTLINE:** non-printing hatch boundaries. Colour 215, Continuous, does not print. 20 of 21 old jobs, 15,818 objects. **Proposal:** keep.
187. **LY-187 HIDDENLINE:** one solid; not used in any old job. Colour 7, Continuous. not used in any old job. **Proposal:** drop-candidate.
188. **LY-188 LAYER LOCK:** one block; not used in any old job. Colour 7, Continuous. not used in any old job. **Proposal:** drop-candidate.
189. **LY-189 SUPPORT DEFPOINTS:** non-printing parts inside the support blocks. Colour 5, Continuous, does not print. 16 of 21 old jobs, 4,714 objects. **Proposal:** keep (structural).

## What was not done

1. **Real use:** what each layer is used for on real jobs was judged from its name, its objects and the master. A best guess, for Tim to correct.
2. **The 387 DWG files** in the evidence store were not read; only the DXF copies.
3. **AutoCAD** was not used.
