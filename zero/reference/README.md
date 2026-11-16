# Reference library: index and rules for adding to it

**Made:** Mon 16 Nov 2026. **What this is:** what is TRUE about the office's civil work today, filed by topic so it can be looked up and added to. Every fact points back to its evidence. **What this is not:** it holds no decisions and no design. Nothing here is confirmed by the owner unless a D-number is quoted. No new facts were added in the filing and no conflicts were resolved: where two pieces of evidence disagree, both are recorded under "Conflict:".

**Scope:** civil, the everyday drafting helpers and the Manager (D-006). AutoCAD 2027 only going forward (D-008). Built to be added to (D-009).

**Updated Mon 16 Nov 2026 (later the same day):** the facts of STUDY_D (the study that closed the gaps in section 9) and the owner's rulings D-031 to D-051 were added to the registers. Section 2 lists the new next-free numbers. Nothing was renumbered; old lines that STUDY_D contradicts are kept and marked "Superseded by STUDY_D" or sit beside a "Conflict:" line.

## 1. Every file, one line each

### Process
1. **`process\CIVIL_JOB_FLOW.md`:** the steps of a civil job from quote to construction issue; what arrives when; who does what; the issue sequence; elapsed times; what arrives late; what goes to council; dates of the 13 studied jobs.

### Design
2. **`design\JOB_KINDS.md`:** register K-001 to K-015: each kind of job, its trigger, inputs, decisions in order, sums, what lands on the sheet, a real example.
3. **`design\SUMS.md`:** register S-001 to S-028: each sum in words and as a formula, with a worked example from a real job and the known slips in the office workbooks.
4. **`design\LIMITS.md`:** register L-001 to L-027: each rule or limit, every value with its source, conflicts, order of authority, status.
5. **`design\INPUTS_AND_OUTPUTS.md`:** every input by where it comes from (49) and every output that lands on the drawing (29), each tied to its sums and elements.

### Drafting
6. **`drafting\ELEMENTS.md`:** register E-001 to E-074: every element on a civil sheet: objects, layer, colour, text, measured offsets, what it relates to.
7. **`drafting\SHEET_SETUP.md`:** model space frame, layouts, viewport, scales, details at 5 times, part plans, annotation and linetype scaling, background attachment, plot style table, templates.
8. **`drafting\TABLES_AND_BOXES.md`:** pit schedule, criteria box, roof-area box, pump box, long-section rows, legend, notes blocks, warning boxes, computations sheet.
9. **`drafting\TITLE_BLOCK_AND_ISSUE.md`:** title block contents, drawing numbering, revision rows, issue stamp wording and stages, issue sequence.

### Standards (data files)
10. **`standards\README.md`:** what each data file's columns mean and how to add a row.
11. **`standards\layers.csv`:** 146 layers with colour, linetype, use, and whether in the master and the template.
12. **`standards\text_heights.csv`:** 56 text heights by purpose.
13. **`standards\pen_colours.csv`:** 36 rows of what each colour prints as.
14. **`standards\linetypes.csv`:** 24 linetypes and multiline styles.
15. **`standards\label_offsets.csv`:** 28 measured distances of labels from their objects.
16. **`standards\wording_patterns.csv`:** 49 label and note wordings with real examples.
17. **`standards\pit_sizes.csv`:** 32 rows of pit sizes and depth limits (two tables in conflict).
18. **`standards\pipe_sizes.csv`:** 21 rows of pipe sizes, materials and classes.
19. **`standards\blocks.csv`:** 60 blocks with states, attributes, layer and scale.

### Councils
20. **`councils\README.md`:** the list of council files, the councils described but not named, and known faults in the office's own council documents.
21. **`councils\C-001_Kingston.md`:** letter gives the figure; Boyd's on the council's copy; tanks may hold the storage.
22. **`councils\C-002_Mornington_Peninsula.md`:** OSD4W; minimum orifice 65; at least 50% underground.
23. **`councils\C-003_Darebin.md`:** OSD4W with council settings; outfall and long section.
24. **`councils\C-004_Monash.md`:** council supplies both figures; 60% underground.
25. **`councils\C-005_Bayside.md`:** council supplies both figures; STORM 100%; basement guideline.
26. **`councils\C-006_Glen_Eira.md`:** detention only when asked; gravity at the kerb.
27. **`councils\C-007_Frankston.md`:** Boyd's; soak on site; 250 cover.
28. **`councils\C-008_Greater_Dandenong.md`:** industrial 0.9 and 1 in 20.
29. **`councils\C-009_Bass_Coast.md`:** on-site absorption to a council standard drawing.

### Today
30. **`today\TOOLS_TODAY.md`:** register T-001 to T-055: every general helper (T-055 is the usage and failure records) and civil command group that exists today, with typed names, where it lives and its duplicates.
31. **`today\INSTALL_TODAY.md`:** what is installed, the install / update path as steps, the fragility facts, unknowns.

## 2. The numbering letters

1. **K-** job kinds (`design\JOB_KINDS.md`). Next free: K-016.
2. **S-** sums (`design\SUMS.md`). Next free: S-029.
3. **L-** rules and limits (`design\LIMITS.md`). Next free: L-028.
4. **E-** drawing elements (`drafting\ELEMENTS.md`). Next free: E-075.
5. **C-** councils (`councils\`). Next free: C-010.
6. **T-** tools of today (`today\TOOLS_TODAY.md`). Next free: T-056.
7. **Used but not owned here:** R- rules, D- decisions, P- parked items, Q- open questions (the files beside this folder).
8. **Rules for every number:** three digits; never reused; no gaps; a changed item keeps its number and the old words stay, marked superseded with the date. Each register ends with a "Next free number" line: update it and the line above when you add an item. If the two ever differ, the register file is right.

## 3. Short names of the evidence files (used on every "Evidence:" line)

1. **STUDY_A** = `evidence\STUDY_A_CIVIL_DRAFTING_ANATOMY.md`
2. **STUDY_B** = `evidence\STUDY_B_CIVIL_DESIGN_PROCEDURES.md`
3. **STUDY_C** = `evidence\STUDY_C_TOOLS_AND_INSTALL_TODAY.md`
4. **ELEMENT_LIST** = `evidence\STAGE1_ELEMENT_LIST_DRAFT.md`
5. **ENG_NOTES** = `evidence\STAGE1_ENGINEERING_NOTES.md`
6. **GUIDEBOOK_NOTES** = `evidence\STAGE1_GUIDEBOOK_NOTES.md`
7. **DIGEST** = `evidence\STAGE1_CIVIL_EVIDENCE_DIGEST.md`
8. **MODEL_NOTES** = `evidence\STAGE1_EVIDENCE_MODEL_NOTES.md`
9. **INTERVIEW** = `evidence\STAGE1_INTERVIEW.md`
10. **DECISIONS** = `DECISIONS.md`; **OPEN_QUESTIONS** = `OPEN_QUESTIONS.md`.
11. STUDY_B section 1 is cited by its letter: "section 1c item 3" is job kind c, item 3. STUDY_A section 2 "civil layer 12" is item 12 of the civil layers list.
12. **STUDY_D** = `evidence\STUDY_D_GAPS_CLOSED.md` (added 16 Nov 2026; cited by section and item, e.g. "STUDY_D section 5.3"). It closes the gaps listed in section 9 below: the cleaned background file, templates and libraries, undecoded items, more job kinds on paper, missing sums, colleagues' PCs. Its "Still unknown" items are cited as "Still unknown item N".
13. **D-031 to D-051** in `DECISIONS.md` (the owner's rulings of 16 Nov 2026, quoted where used and cited "D-0nn"). Only those that bear on a reference item were filed (elements, tools); the rest are design and stay in `DECISIONS.md`.

## 4. Rules for anyone adding to the library

1. **Add, do not start a new document.** Find the register the fact belongs to and add an item or a line there.
2. **Every item ends with "Evidence:"** naming the evidence file and section. A fact with no evidence does not go in.
3. **Conflicts are recorded, not settled.** Write both under "Conflict:". Only a decision settles one: "Settled by D-0xx: ...".
4. **Unknown stays unknown.** Write "Unknown" and the Q-number if `OPEN_QUESTIONS.md` has it.
5. **Carry the numbers.** Measured values are copied, not rounded or summarised.
6. **Plain drafting and engineering words.** Markdown files: numbered lists with bold labels, no tables. Data files: CSV.
7. **No client names, addresses, job numbers or staff names.** Jobs are JOB_A/B/C and CIV-01..13. Council names are fine. Names on disk that carry a staff name are written masked.
8. **Evidence files are never edited.** If the evidence is wrong, say so in the item and raise a question.

## 5. How to add a new job kind

1. Check it is not already a mix of existing kinds (one job is often several K-numbers).
2. Add any new sum to `design\SUMS.md` and any new limit to `design\LIMITS.md` first, so they have numbers.
3. Add any new sheet element to `drafting\ELEMENTS.md`.
4. Add the kind as the next K-number in `design\JOB_KINDS.md` with the ten fixed headings.
5. Add the example job's dates to `process\CIVIL_JOB_FLOW.md` section 8.
6. Update section 2 above.

## 6. How to add a new element

1. Add it as the next E-number in `drafting\ELEMENTS.md` with the eight fixed headings.
2. Add its layer(s) to `standards\layers.csv`, its text to `standards\text_heights.csv`, its block to `standards\blocks.csv`, its wording to `standards\wording_patterns.csv` and any measured distance to `standards\label_offsets.csv`.
3. If it is a table or box, add a section to `drafting\TABLES_AND_BOXES.md`.
4. If it shows a worked-out number, name the sum (S-number) under "What it relates to".
5. Update section 2 above.

## 7. How to add a new council

1. Follow `councils\README.md` "How to add a council" (copy a council file, keep the ten headings).
2. Put each of its limits that differs from the office's into `design\LIMITS.md` under the matching L-number, naming the council as a source.
3. Add its studied jobs to `process\CIVIL_JOB_FLOW.md` section 8.
4. Update the list in `councils\README.md` and section 2 above.

## 8. How to add a new limit

1. If it is another value for a rule that already has an L-number, add the value and its source to that item and record the conflict. Do not make a new number.
2. If it is a new rule, add it as the next L-number in `design\LIMITS.md` with the fixed headings, including the order of authority (D-022).
3. If it comes from a council, add it to that council's file too.
4. If it is a drafting value (a size, an offset), it belongs in a `standards\` data file instead.
5. Update section 2 above.

## 9. What is not covered yet

1. **Structural.** Parked until civil, the helpers and the Manager work (D-006, P-05). The two structural evidence files were not filed.
2. **Waiting on study D** (running 16 Nov 2026):
   1. Inside the cleaned background drawing: boundary, bearings, bench mark, survey levels, street name (Q-101). Superseded by STUDY_D section 1.2, 16 Nov 2026.
   2. A3 templates, the council-specific A1 template, long-section examples, the other civil detail drawings (Q-102). Superseded by STUDY_D section 2.1 to 2.3 and 2.6, 16 Nov 2026.
   3. Which look each pit symbol is set to; true colours of fills; draw order; what block "MOC" is (Q-103). Superseded by STUDY_D section 3.1 to 3.4, 16 Nov 2026.
   4. Sums for the plain house, the house with detention, the basement house and the rural house; a raingarden job end to end (Q-104). Superseded by STUDY_D section 5.1 to 5.5, 16 Nov 2026.
   5. What colleagues' PCs have installed, which commands are really used, how the old LISP and palettes load (Q-105). Superseded by STUDY_D section 6.1 to 6.5, 16 Nov 2026.
   6. Paper look of pump, soakage, outfall, industrial and basement sheets, and childcare / school / apartment jobs (Q-106). Superseded by STUDY_D section 4.1 to 4.8 (apartments not found; school not opened: section 4.9), 16 Nov 2026.
3. **Waiting on the owner** (see `OPEN_QUESTIONS.md`): Q-001 to Q-017, in particular the rulings on conflicting office values (Q-004), the pump workbook version (Q-003), how the top water level is first chosen (Q-001), how pipe capacities are checked on bigger jobs (Q-002), and which "civil site" drawings exist (Q-011).
4. **Not read in the evidence:** the guidebook's workflow figure (Q-107) and 24 of its 33 pictures; OSD4W and STORM themselves; the workbooks dumped but not read line by line (Manning's, pipe flows, rectangular pipe flows, culverts, rain intensity, pipe loads, road design, head-loss line, overland flow, the supplier's infiltration tank workbook, the older detention workbook, the discharge-letter tracker); three of the six tabs of the water tank sizing workbook; the computations sheet drawing. Superseded by STUDY_D section 2.4 (the computations sheet drawing was read), 16 Nov 2026.
5. **Councils described but not named** in the evidence: listed in `councils\README.md`.
6. **Research questions** (Q-201 to Q-206) and **how we work** (Q-301): not reference matter; they belong to later stages.
7. **Still open after study D** (its 16 "Still unknown" items): sheets not looked at as pictures; apartment and school jobs; how horizontal-title civil sheets are started; the council's own e-mail for CIV-09 and the architect's sustainability report; whether the 1 m3 tank credit and the 2% raingarden area are office rules or council rules; what Civil and Structural versions colleagues run today; whether PC-6 is a person or a test robot; whether "did not close cleanly" records are crashes; how often plain commands, loose LISP and palettes are used; the 2015 instruction documents and four unopened settings packages; the start-up suite's full 17 entries; stretch values of each trench grate and each pit schedule's row count; easement and kerb-and-channel standards in a background file; printed thickness of default-lineweight objects and whether every PC plots with the same table; what differs between councils inside the orifice pit details; the "NEW" palette set tool by tool. (STUDY_D Still unknown items 1 to 16)
8. **Updated 16 Nov 2026:** STUDY_D and the owner's rulings D-031 to D-051 were filed into the registers above; each added line ends with its evidence. Items that STUDY_D contradicts were not deleted: the old line is marked "Superseded by STUDY_D ..." or a "Conflict:" line sits beside it. (STUDY_D; D-031 to D-051)

Evidence: zero-plan `README.md`; `DECISIONS.md` D-006, D-008, D-009; `OPEN_QUESTIONS.md`; STUDY_A section 10; STUDY_B section 0; STUDY_C section 8; ENG_NOTES "What was read"; STUDY_D section 0 to 7 and Still unknown; D-031 to D-051.
