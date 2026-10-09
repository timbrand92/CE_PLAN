# CLAUDE DRIVER RUN 15: BUG-565 evidence (which layer is the pit's own label on), Sat 10 Oct 2026

Window about 10:24 to 10:29 PC clock. Driver: `acad_driver_witness.ps1` only, through a counting wrapper. **26 of 60 driver calls used** (call 7 was refused by the driver as over 500 characters; it is counted). Fresh copy CLD23_B1 from DRV1_B1 (SHA256 equal, starts 34BBE37C). No Codex W-run was active (no acad.exe at the start). Witness recorder not loaded (not needed for this question).

## Answer first

1. **The pit number ("P3") is on layer 35TEXT.** It is an attribute inside the pit's label block, and the block's own definition puts that attribute on 35TEXT. All 11 pit labels in the drawing (P1 to P10, C1, X1) have it on 35TEXT.
2. **The pit's label block itself (the INSERT named PIT LABEL) is on STORMWATER PIT LABEL. The cover text ("CL 18.88") is an MTEXT on 25TEXT. The pit block is on STORMWATER PIT.** So one pit writes to FOUR layers: STORMWATER PIT, STORMWATER PIT LABEL, 25TEXT and 35TEXT.
3. **What the writer would need to pre-check:** today PitAnnotationLockRule tests only STORMWATER PIT LABEL and 25TEXT. It misses **35TEXT**, the layer of the number text inside the label block. That matches W58 exactly: with 35TEXT locked, nothing refused up front, the label write failed afterwards ("Pit retained without its number label") and Edit Pit threw "Error during PITEDIT". The Codex lookup was therefore not a wrong text: layer 35TEXT really is where the number lives. The controller's second theory (the schedule's text) is not needed to explain it.
4. **The fix target is the resolver, not another fixed name:** read the layer of the PIT_LABEL attribute definition inside the block (here 35TEXT), and test that as well as the block's own layer and the cover-text layer. Check at PIT, at Edit Pit and at the schedule update.
5. **Not proved:** the sentence AutoCAD prints when CE writes the label with 35TEXT locked (the driver will not press Continue placement or Save pit and close; that is Codex or Tim). I also did not see which layer CE writes when it re-writes a label on an edit (no complete typed form for PITEDIT). The layer comes from the block definition's attribute (and the 11 existing labels agree), which is strong but is reading, not a witnessed write.
6. **AUTOCAD CLOSED.**

## 1. Versions installed (nine DLLs read with readdll.ps1)

1. **Civil** 3.0.44+b7eed253df3f (Legacy 6C9C91FA2FC4, Net8 0117F2EDD64E, Modern 37DCB42C8005).
2. **Manager** 1.1.44+b7eed253df3f (Legacy 270EAFD07B7A, Net8 7F7BFED95C4D, Modern 762825AE390E).
3. **Structural** 1.0.113+2e0cf385030f (Legacy 5AD4C11F5988, Net8 8E97370E6F56, Modern F72DAFEEF802).

## 2. System variables

1. **Before:** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS", CTAB "Model", FILEDIA 1.
2. **After (read back by LISP and getvar):** OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS", FILEDIA 1, DBMOD 1 (same as at the start; nothing was added). Pit count still 11.
3. **Layer lock flags after unlock:** STORMWATER PIT 0, STORMWATER PIT LABEL 0, 25TEXT 0, 35TEXT 0.

## 3. Step 1: the pit P3 (handle 109D56) and its own label

1. **109D56** is an INSERT of anonymous block `*U182` on layer **STORMWATER PIT**, at (53777.7, -25569.9). It has no regular xdata.
2. **Its link data** is in its extension dictionary, sub-dictionary `CE_CVL_SUITE_LINKS`, record `PIT_LINK`: `{"PitHandle":"109D56","Pipes":[109E23, 109ED4, 10A901, 10A98D, 110136, 110179],"Attachments":["109E08","109E0F"]}`. Also `SPINE_ID` CE-CIV-PIT-1773A76E-....
3. **The two attachments (EVERY candidate linked to the pit, with handle and layer):**
   1. **109E08**: INSERT, block `PIT LABEL`, layer **STORMWATER PIT LABEL**, at (52570.9, -26238.3).
   2. **109E0F**: MTEXT "CL 18.88" (the cover text), layer **25TEXT**, at (54354.4, -24866.6).
4. **Inside 109E08** (read by walking its attributes): one ATTRIB, handle **109E0A**, tag `PIT_LABEL`, text `P3`, layer **35TEXT**, at (52325.7, -26413.3).
5. **The block definition PIT LABEL** holds a WIPEOUT on layer 50CONT and an ATTDEF (tag PIT_LABEL) on **35TEXT**. So new pits will get the number on 35TEXT too.
6. **All 11 labels** (insert handle, attribute handle, layer, text): 11A09A/11A09C P9, 119F9A/119F9C P10, 10A7AB/10A7AD P4, 10A68C/10A68E P5, 10A56D/10A56F P7, 10A18D/10A18F P6, 109E08/109E0A P3, 10981A/10981C P2, 1096B3/1096B5 P1, 10933E/109340 X1, 1090F6/1090F8 C1. **Every attribute is on 35TEXT.**
7. **Agrees with run 14** (pit P2, handle 109768, label 10981A on STORMWATER PIT LABEL). Run 14 did not look inside the block, so it missed the attribute layer.
8. **Why a text search is the wrong tool:** the number is an attribute, not an MTEXT. An exact-text search for "P2" finds the title-block MTEXTs (1152D4 on 35TEXT, 1152C6 on 25TEXT, far from the pit), not the pit's number. It reported 35TEXT only by coincidence of layer name.
9. **Not done:** the re-write of the label by a typed PITEDIT number change (no complete typed form in TYPED_FORMS).

## 4. Step 2: lock the label text layer, then PIT, Cancel only

1. **Lock:** `(command "_.-LAYER" "_LO" "35TEXT" "")` typed with `-AllowLisp`; read back: flag **4** (locked).
2. **PIT:** `type "PIT`n10000,-90000" -Enter -ExpectWindow "New Pit"`. AutoCAD printed `Specify pit insertion point: 10000,-90000`. **The New Pit window opened (5.7 s). No refusal before the window, no warning in it.** This is the same silent behaviour W58-03 saw before Continue placement.
3. **What the window shows (ui tree, ui scan):** pit number P8, 450 x 450 mm, "Enter the cover level.", **"Pit label block will be created or updated."** with the label and cover-text switches both On. Nothing about a locked layer. `Continue placement` disabled until a cover level is typed (and on the driver's never-press list); scan: 0 jargon, 0 raw handles.
4. **Close:** `ui click "New Pit" "Cancel without saving"` (ok), then AutoCAD printed **`PIT command cancelled.`**. Nothing placed (pit count 11 before and after).
5. **Unlock:** `(command "_.-LAYER" "_U" "35TEXT" "")`; all four layers read back 0.
6. **So what is possible with the driver:** reaching the open New Pit window with the real label layer locked, and reading that the window gives no lock warning. Not possible: Continue placement or Save pit and close, so the failing write itself is still Codex or Tim.

## 5. Step 3: counts of entities on the four layers (typed ssget, "_X", drawing-wide, attributes NOT counted by ssget)

1. **STORMWATER PIT:** 11 (all INSERT).
2. **STORMWATER PIT LABEL:** 11 (all INSERT).
3. **25TEXT:** 133 (129 MTEXT, 1 TEXT, 3 others).
4. **35TEXT:** 32 (8 MTEXT, 12 TEXT, 12 LWPOLYLINE) plus the 11 pit-number attributes (they sit inside blocks, so ssget does not count them). The other 35TEXT objects are not pit labels (schedule, long-section and title-block text).
5. **Which layer the writer really uses:** the pit block on STORMWATER PIT, the label block on STORMWATER PIT LABEL, the cover text on 25TEXT, **the pit number attribute on 35TEXT**. Locking 35TEXT alone can still break PIT and Edit Pit, and also the Pit Schedule update and long-section text that share it.

## 6. Driver notes (none worked around)

1. **A typed LISP over 500 characters is refused** (call 7, a near-scan). Split into a short `defun` helper plus a call. Cost one call.
2. A `-LAYER ... LO name` chain cannot end on its own empty Enter; a LISP `(command ...)` line is the working form (as run 14).
3. The 500-character rule and the ssget crossing window returning nil (my window was off the drawing's real extents) were my errors, not driver faults.
4. `quit` removed 5 stray log files (CLD23_B1 and four Drawing1 logs): harmless.

## 7. For the Civil lane (RED test first)

1. **Test:** lock only 35TEXT with a normal pit label; PIT and Edit Pit must refuse before writing anything with a plain sentence naming 35TEXT. Today both fail late.
2. **Resolver:** derive the pre-check layers from the PIT LABEL block definition (ATTDEF layer) plus the inserted label layer plus the cover-text layer, not fixed names. Include the same list in the Pit Schedule update's own pre-check (it also leaves an undo step: W58's first U echoed PITSCHEDULE).
3. **Then Codex or Tim:** repeat W58-02 and W58-03 after the fix (35TEXT locked: expect the plain refusal, nothing placed, no CE error line).
