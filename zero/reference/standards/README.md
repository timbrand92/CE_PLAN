# Standards data files

The office's drafting standards as plain data, one row per item, exactly as measured. They are kept as CSV (comma-separated) files because they are meant to become the plugin's one office standards file later (D-013: "this should all be standardised and understood in one place"; D-012: offsets are settings). Re-filed from the evidence on Mon 16 Nov 2026. These are MEASURED values and observed conflicts, not chosen standards: no row here has been ruled on by the owner.

Open them in Excel or any text editor. Units: model units are millimetres of real ground; "paper_mm" is millimetres on the A1 sheet at 1:100.

## How to add a row (any file)

1. Add the new row at the END of the file. Never delete or reorder rows; rows have no number, so their order is their identity for anyone comparing versions.
2. Keep the heading row as it is and fill every column. Write "not stated" where the evidence does not give a value. Never guess.
3. Put any field that contains a comma inside double quotes. (Rows here use semicolons inside a field to avoid that.)
4. Fill "source" with the evidence file and section, and "status" with one of the four words below.
5. If a new measurement disagrees with an existing row, add a second row and set BOTH rows' status to "conflict". Do not overwrite. The owner rules (D-003, D-022, Q-004).

## The status column (same four words in every file)

1. **measured:** read from a real job drawing, an issued sheet or a job's own sums (JOB_A/B/C, CIV-01..13).
2. **template:** read from the civil A1 template or its parked sample kit.
3. **master:** read only from the office master drawing of blocks, layers, schedules and notes.
4. **conflict:** two sources give different values for the same thing; both are recorded.

## The files and their columns

1. **`layers.csv`** (118 rows): every layer met on a civil sheet.
   1. name: the layer name exactly.
   2. colour: AutoCAD colour number (the colour picks the pen).
   3. linetype: the layer's linetype.
   4. plots: yes or no.
   5. used_for: what is drawn on it.
   6. in_master: is it in the office master drawing (yes / no / not stated).
   7. in_template: is it in the civil A1 template (yes / no / not stated).
   8. seen_on_jobs: which coded jobs used it.
   9. source, status.
2. **`text_heights.csv`** (42 rows): the height of every kind of text.
   1. purpose: what the text is.
   2. model_height: height in model units.
   3. paper_mm: height on paper.
   4. object_kind: MTEXT, plain TEXT, block attribute and so on.
   5. layer: the layer it sits on.
   6. justification: where the text is anchored.
   7. mask: background mask on or off.
   8. source, status.
3. **`pen_colours.csv`** (35 rows): what the office plot style table does with each colour.
   1. colour_number: AutoCAD colour number.
   2. prints_as: black, grey or its own colour.
   3. pen_mm: printed line thickness.
   4. screening: how strongly it prints (100% = solid).
   5. source, status.
4. **`linetypes.csv`** (24 rows): linetypes and multiline styles.
   1. name: the linetype or multiline style name.
   2. pattern: dash and gap lengths in the linetype's own units (multiplied by LTSCALE 1000).
   3. used_for: what it draws.
   4. object_scale: the object linetype scale used with it.
   5. source, status.
5. **`label_offsets.csv`** (20 rows): how far each label sits from its object.
   1. label: which label or part.
   2. from_what: what the distance is measured from.
   3. standard_clear_distance: the template's distance where there is one.
   4. measured_range: what was measured on real jobs.
   5. side_rule: which side it sits on.
   6. rotation_rule: how it is turned.
   7. source, status.
6. **`wording_patterns.csv`** (31 rows): the fixed wording of labels and notes.
   1. item: which label.
   2. pattern: the wording with blanks shown as <...>.
   3. real_examples: real wordings, separated by " | ".
   4. source, status.
7. **`pit_sizes.csv`** (32 rows): pit sizes and their depth limits.
   1. size: plan size.
   2. max_depth: the deepest that size may be, in mm.
   3. source: which document gives it.
   4. conflict: what another document says.
   5. status.
8. **`pipe_sizes.csv`** (17 rows): pipe sizes, materials and classes seen.
   1. nominal: nominal diameter in mm.
   2. material_class: material and class.
   3. where_used: what it is used for.
   4. real_inside_outside_if_known: the maker's real diameters.
   5. source, status.
9. **`blocks.csv`** (52 rows): every block met on a civil sheet.
   1. block_name: the block's name (machine-named blocks are described).
   2. what_it_is: drafting words.
   3. dynamic_states_or_grips: visibility states and grips.
   4. attributes: attribute tags and defaults.
   5. inserted_on_layer: the layer it is placed on.
   6. scale: insert scale.
   7. source, status.

## Conflicts recorded in these files (each waits on the owner)

1. **Layers:** SPOON DRAIN colour (1 master / 10 template); CONSTRUCTION JOINT linetype (PHANTOM / PHANTOM_CJ / CENTER2); TREE colour (73 / 65); WIPEOUT linetype (DOTX2 / DOT); DEFPOINTS colour (5 / 129); CLOUD colour (12 / 10); HATCH 21 colour (49 jobs / 21 template). 17 layers in all differ between master and template; only these are named in the evidence.
2. **Text:** invert level layer, colour and justification differ between JOB_C and JOB_A/B; warning box height range is given two ways in one study.
3. **Pens:** colour 4 prints 0.40 in the current table and 0.70 in an older one.
4. **Offsets:** pipe label distance: 73 to 74 clear of the pipe edge in the template against "about 139 off a 150 pipe" in the August study.
5. **Pit sizes:** two depth tables; three step iron depths (Q-004).

## Not in these files yet

1. Engineering standards that are rules rather than drafting data (grades, cover, coefficients, orifice): see `design\LIMITS.md`.
2. Council rules: see `reference\councils\`.
3. Symbols and text inside the background drawing; A3 and council-specific templates; true colours of fills; draw order (Q-101, Q-102, Q-103: waiting on study D).
4. Real diameters of detention pipe sizes other than 225.
5. Lid classes as a data file (four classes are in L-019).

Evidence: STUDY_A sections 1 to 7 and 9; STUDY_B section 3; DIGEST section 1; DECISIONS D-003, D-012, D-013, D-022.
