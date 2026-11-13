# Structural faults from the 13 Nov list that were not filed

Written Fri 13 Nov 2026 by the records helper for the controller chat. Source list: `areas/trust-run/STRUCTURAL_NEW_FAULTS_TO_FILE.md` (104 items). Each item was checked against the code copy `C:\CE_WORK\scratch\audit_struc` (Structural 1.0.126, commit 8de95c34). 95 entries were filed as BUG-1361 to BUG-1455. This file records the rest.

## Not confirmed (1)

1. **Schedules item 23, CLEAN and FASTSAVE saving a never-saved drawing over its template (listed as HIGH).** Found in the code: nothing stops CLEAN or FASTSAVE on a drawing that has never been saved. `DrawingSafetyService.TryGetNormalProjectDrawing` only refuses the `.sv$` and `.ac$` autosave names, and `DrawingAutoSaveService.cs:198` calls `db.SaveAs(drawingPath, ...)` on whatever path it was given. What the code cannot show is whether AutoCAD 2027 gives a never-saved drawing's path as the template file; that decides whether a template is overwritten. Needs one robot probe (new drawing from the office template, run CLEAN, check the template file's date). If the probe shows the template changes, file it as HIGH, lost work. If it shows a Drawing1 path, file a LOW wording entry only.
   - **Fri 13 Nov 2026 11:29 (PC clock): now confirmed.** The robot probe on the installed build (1.0.126) showed both CLEAN and FASTSAVE save a never-saved drawing over its template file. Filed as BUG-1457 (HIGH). Evidence: reas/trust-run/EVIDENCE_CLEAN_TEMPLATE.md.

## Already in the bug file (2), not filed again

1. **Roof item 18, no error catch in AB, BB, BT1 and ABS so any other AutoCAD error opens AutoCAD's own error window.** The ABS case is BUG-583 (locked brace, reproduced in AutoCAD). The BT1 case is named in BUG-473. AB and BB refuse a locked brace layer before drawing, so only the unusual-error case remains, and it is the same missing catch.
2. **Schedules item 7, a brace with a blank type tag is listed as type A.** Same fault as BUG-499 ("a brace with no type tag is read as type A"). Nothing added.

## Filed together (same underlying fault, one entry naming every tool)

1. Roof item 5 and schedules item 5: older-named brace blocks counted as zero in the panel and left out of the schedule: BUG-1369 (CSBRACINGPANEL, STRSCHEDCREATE, STRSCHEDREFRESH).
2. Roof item 14 and supports item 18: the "footings, labels and text" and "LIST one footing" wording in the non-millimetre hold line: BUG-1378, one entry naming 11 tools.
3. Roof item 20 and schedules item 8: switches with no box on CESETTINGS: BUG-1383, one entry naming AB, BB, CSBRACINGPANEL, R1, BT1, C1, TS1, STRSCHEDCREATE and FASTSAVE.
4. Beam items 1 and 2: layer set-up refusals: one entry for tools 1, 2, 4 and 5.
5. Beam items 3 and 4: layout tab and REFEDIT wording: one entry for tools 1, 2, 4 and 5.
6. Beam items 21 and 22: BSET, BSETRESET and BSETLIST swallowed store errors: one entry.

## Read with a limit

1. Beam items 3, 4, 10 and 14 and supports item 8 were checked by reading the cited lines and the wording tables, and are stated in the entries as read, not seen. Supports item 8 (labels turn about a different point from the block) is a difference in the rotation base point visible in the code; the size of the offset in drawing units is not measured.
2. Beam item 11 was narrowed: the new beam route reads the remembered mark but writes none; only BDL and the older paths write it. The entry says that.
3. Beam item 5 (Settings layer names ignored) was narrowed to the new atomic route; BDL does use the Settings names, as the list said.
4. Roof item 3 was narrowed: the type of an untagged block is read from the layer name, so a blank tag on a layer containing "TYPE B" is read as B.
