# Tools of today register (T-)

Every general drafting helper and every civil command group that exists on the owner's PC and the office shared folders today, one item each. Re-filed from the evidence on Mon 16 Nov 2026. This is a record of what exists, not a list of what to keep: the existing plugin is a parts bin (D-001), and each piece goes back to the owner as keep / change / drop in Stage 3. Nothing was run in AutoCAD for this record.

Folder and file names on disk that contain a staff first name are written masked here (for example `<owner>_CE_CADTOOLS`); the exact spellings are in the evidence file.

## How to add to this file

1. Take the number on the last line ("Next free number"). Never reuse or renumber.
2. Copy the four headings below in the same order. One item per helper or per command group (a group = what the drafter is doing).
3. Give every typed name exactly as typed, and every place the tool lives. List every duplicate you know of under "Duplicates".
4. Finish with an "Evidence:" line and move "Next free number" on by one.

## Fixed headings for every item

1. **Typed name(s)**
2. **What it does**
3. **Where it lives**
4. **Duplicates**
5. **Evidence** (written as the closing line)

## The three generations (read first)

1. **Generation 1: loose LISP files** in the shared drafting folder `Lisp Files`: 653 files (181 LISP files, 17 old-style dialog files, 392 small button pictures, 30 drawings, 5 menu files). 486 different typed names; only 156 are in files not in a folder marked superseded, saved or old; the other 330 exist only in superseded copies. The same file often exists two to six times.
2. **Generation 2: tool palettes** in the shared folder `Tool Palettes`: 71 palette files in three sets. Every tool is a block dragged from a master drawing; no palette tool runs a command.
3. **Generation 3: commands inside the plug-ins:** 145 typed names in the Civil program (143 in its list, 78 hidden), 376 in the Structural program (375 in its list, 63 hidden), 12 in the Manager. 533 typed names from the plug-ins alone.
4. **How the LISP files and palettes get loaded on a colleague's PC:** Unknown (Q-105). **Which tool answers** when a typed name exists in both a loaded LISP file and a plug-in: Unknown.
5. **Which helpers the owner and drafters really use:** Unknown (Q-015).

Evidence: STUDY_C section 2A, 2B, section 3, section 7 items 1 to 3, section 8 items 5 and 6.

---

# Part 1. General helpers, generation 1 (loose LISP)

## T-001 Move and copy

1. **Typed name(s):** `MR` / `MOVEROT`; `CR` / `COPYROT`; `C`; `CPB`; `MD`.
2. **What it does:** `MR`: move the picked objects, then rotate them at the new spot. `CR`: copy the picked objects, then rotate the copy. `C`: AutoCAD COPY forced to "multiple". `CPB`: copy the picked objects and paste them back as one block on a BLOCKS layer. `MD`: offset the picked objects repeatedly between two points at a set maximum spacing.
3. **Where it lives:** Shared drafting folder, `Lisp Files` (a 2015 file and a 2025 rewrite for move/copy+rotate).
4. **Duplicates:** Move+Rotate / Copy+Rotate exists in five homes: shared LISP, LISP inside the Structural bundle (version 2.2), the Civil program (hidden), a C++ part in the Civil bundle, and the separate trial bundle (T-054). `CPB`, `CR`, `MR` again in the Structural program (T-030).

Evidence: STUDY_C section 2A item 1, section 2D item 1.

## T-002 Dimensions and leaders

1. **Typed name(s):** `Q`; `QD`; `LD`; `AD`; `DUP`; `DSET`.
2. **What it does:** `Q`: leader with arrow. `QD`: leader with dot. `LD`: linear dimension. `AD`: aligned dimension (both on the office dimension layer and style, at 1:20 or 1:100). `DUP`: change all dimensions from the 1:20 set-up to 1:100. `DSET`: set the measuring factor on picked dimensions.
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** The same typed names in the Structural program (T-027).

Evidence: STUDY_C section 2A item 2, section 2D item 5.

## T-003 Hatching

1. **Typed name(s):** `EH`, `CH`, `WH`; `10H`, `21H`, `31H`, `51H`, `74H`, `201H`, `238H`, `242H`; `LBH`, `LBUH`; `H2A`.
2. **What it does:** Earth, concrete and waffle pod hatches; number-named hatches that each lay the office hatch of that pen colour at the right scale for the drawing; load-bearing wall over and under; `H2A` re-attaches hatches to their outlines.
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** The same and more in the Structural program (T-026); ready-made hatches on tool palettes (T-019).

Evidence: STUDY_C section 2A item 3, section 2D item 5.

## T-004 Text styles, clean-up and saving

1. **Typed name(s):** `MTS`; `CLEAN`; `FASTSAVE`; `LU`.
2. **What it does:** `MTS`: merge text styles into one. `CLEAN`: purge, run the Xref layer tidy, force text styles to standard, regenerate, save. `FASTSAVE`: quick version. `LU`: bring the office layers and styles in by inserting a settings block, then purge it.
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** The same typed names in the Structural program (T-029).

Evidence: STUDY_C section 2A item 4, section 2D item 5.

## T-005 Xref layer tidy

1. **Typed name(s):** `XRL`; `XRLFAST`, `XRLCONFIG`, `XRLINFO`, `XRLSILENT`, `XRLHELP`.
2. **What it does:** Put Xrefs on the office Xref layer and tidy their layers.
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** `XRL` and its four variants in the Structural program (T-029), with `CXREF`, `PXREF`.

Evidence: STUDY_C section 2A item 5, section 2C item 4.5.

## T-006 Revision cloud

1. **Typed name(s):** `RC`.
2. **What it does:** Rectangular revision cloud at the office arc size; asks about object snap first.
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** `RC` in the Structural program (T-028).

Evidence: STUDY_C section 2A item 6, section 2C item 4.4.

## T-007 Multilines

1. **Typed name(s):** `CML`; `SML`; `CHECKML`.
2. **What it does:** `CML`: closed-end multiline. `SML`: standard multiline. `CHECKML`: say which style is current. (These are the multiline styles used for pipe walls: E-001.)
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** In shared LISP and again in the Structural program under the same typed names.

Evidence: STUDY_C section 2A item 7, section 2D item 5.

## T-008 Footings and piers

1. **Typed name(s):** `SPW`, `SPW3`, `SPW6`, `SPWC`; `DIV`, `DIVX`.
2. **What it does:** Bored piers at 450, 300, 600, and 450 with concrete hatch, spaced along a line. `DIV`, `DIVX`: divide a line with cross marks or a block. (Structural; recorded because it sits in the same folder.)
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** Bored piers and divide again in the Structural program (`DIV`, `DIVX` in T-030).

Evidence: STUDY_C section 2A item 8, section 2D item 5.

## T-009 Slab joints

1. **Typed name(s):** `CJ`; `SSC` (older file: `SCC`).
2. **What it does:** `CJ`: construction joint line and label. `SSC`: saw cut line and label.
3. **Where it lives:** Shared `Lisp Files` (two versions).
4. **Duplicates:** `CJ` / `SSC` / `CJSS` in Structural; `CDCJ` / `CDSC` / `CDJOINT` in Civil (T-040); SC and CJ line blocks on a tool palette.

Evidence: STUDY_C section 2A item 9, section 2D item 3.

## T-010 Structural text tags

1. **Typed name(s):** About 55, including `EBT`/`EBB`, `IBT`/`IBB`, `SFT`/`SFB`, `THL`/`THR`, `PFL`/`PFR`, `BPL`/`BPR`, `CL1`/`CR1`, `PCL`/`PCR`, `SL`/`SR`, `DSL`/`DSR`, `TSL`/`TSR`, `25L`/`25R`/`25C`...; "B..." versions for basements; "...C..." versions that also draw the footing outline; `FST`.
2. **What it does:** Places the standard tag text for edge beam, internal beam, strip footing, slab thickening, pad footing, bored pier, column, portal column, stiffener, double stud, triple stud; 2.5 mm text left, right, centre, top, bottom; `FST` is a size manager window. (Structural; parked scope.)
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** Again in the Structural program under the same typed names; label blocks on tool palettes.

Evidence: STUDY_C section 2A item 10, section 2D item 5.

## T-011 Supports

1. **Typed name(s):** `IDS`, `IDSA`, `ITSA`, `ICA`; `SDS`, `SDSA`, `STSA`, `SCA`.
2. **What it does:** Insert a post or stud support block with a rotation preview; swap one support type for another and fix its tag. (Structural.)
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** Support blocks on the SUPPORTS FRAMING palette.

Evidence: STUDY_C section 2A item 11, section 2B item 1.7.

## T-012 Beams

1. **Typed name(s):** `1`, `2`, `4`, `5`, `1A`, `2A`, `4A`, `8`.
2. **What it does:** `1` beam, `2` lower beam, `4` and `5` beams with a formatted size label, the "A" versions the same drawn between support blocks, `8` set the beam offsets. (Structural.)
3. **Where it lives:** Shared `Lisp Files`; newest beam files in `UPDATED LISP FILES` (Jan to Feb 2026).
4. **Duplicates:** Structural program beam commands (outside this record).

Evidence: STUDY_C section 2A item 12 and opening paragraphs.

## T-013 Bracing

1. **Typed name(s):** `AB`, `BB`; `ABS` / `ABSWITCH`; five more fault-finding names.
2. **What it does:** Place type A or type B wall bracing; swap A and B. (Structural.)
3. **Where it lives:** Shared `Lisp Files`; newest in `UPDATED LISP FILES`.
4. **Duplicates:** Again in the Structural program; bracing blocks on the BRACING FRAMING palette.

Evidence: STUDY_C section 2A item 13, section 2D item 5.

## T-014 Excel into drawings

1. **Typed name(s):** `EXCELMTEXT`; `CIVILEXCELMTEXT`; `VALIDATECSV`, `FIXCSV`, `CREATETEMPLATE`, `EXCELHELP`, `EXCELLOAD`.
2. **What it does:** `EXCELMTEXT`: bring a member schedule from Excel into drawing text. `CIVILEXCELMTEXT`: the same for a civil pit schedule from a CSV file. The rest are helpers around it.
3. **Where it lives:** Shared `Lisp Files` (four LISP versions of `EXCELMTEXT`).
4. **Duplicates:** `EXCELMTEXT` / `XCLMTXT` in Structural (T-031); the pit schedule itself in Civil (`PITSCHEDULE`, T-041).

Evidence: STUDY_C section 2A item 14, section 2D item 4.

## T-015 Old civil pipe tools (LISP)

1. **Typed name(s):** `CDD` (also `CDD3`, `CDDE`); `CDDS`; `CDDA` / `MFA`; `SETOFFSET`; an earlier `CD`; a typed name that is the owner's first name, and `TBDRAIN-INPUT`; `SETODIST` / `GETODIST`, `SETCVLODIST` / `GETCVLODIST`.
2. **What it does:** `CDD`: draw a drainage pipe with size, grade, invert text and flow arrow, from an 11,540-line file dated Nov 2025. `CDDS`: settings. `CDDA` / `MFA`: move the flow arrow. `SETOFFSET`: text offset. Earlier `CD` LISP ("Civil Pipe Creation"). An older pipe-data dialog. Remembered offset distances.
3. **Where it lives:** Shared `Lisp Files`; the earlier `CD` in six copies, all in old or superseded folders.
4. **Duplicates:** Draw a drainage pipe exists three ways: `CD` in the Civil program (T-036); `CDD` in LISP; the older `CD` in LISP.

Evidence: STUDY_C section 2A item 15, section 2D item 2.

## T-016 Tool palettes switcher

1. **Typed name(s):** `TP`.
2. **What it does:** Show one group of tool palettes (CIVIL, FRAMING, GROUND, SECTIONS).
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** None recorded.

Evidence: STUDY_C section 2A item 16.

## T-017 3D faces to lines

1. **Typed name(s):** `3DF2L`.
2. **What it does:** A third-party tool that turns 3D faces into lines (its prompts are not in English).
3. **Where it lives:** Shared `Lisp Files`.
4. **Duplicates:** None recorded.

Evidence: STUDY_C section 2A item 17.

## T-018 Old menu file and bought-in structural toolkit

1. **Typed name(s):** None typed; menu file `TB2024.MNU`.
2. **What it does:** An old-style menu file (4 pull-down menus, about 30 toolbars) that calls 903 different LISP routines by name. Those routines are not in this folder; they belong to a bought-in structural toolkit kept in the IT folder.
3. **Where it lives:** Shared `Lisp Files`; toolkit in the IT folder.
4. **Duplicates:** Not applicable. Whether anyone still loads this menu: Unknown.

Evidence: STUDY_C section 2A closing paragraphs, section 8 item 9.

# Part 2. General helpers, generation 2 (tool palettes)

## T-019 Current palette set

1. **Typed name(s):** None (palettes; shown by `TP`).
2. **What it does:** 17 palettes, 358 block tools, dated 10 Dec 2024. Civil ones: BLOCKS CIVIL (26): stormwater pit, pit block, downpipe, overflow, inspection opening, grated inspection, floor waste, riser/dropper, existing pit and pipes, council drain, cut pipe, trench grate, RL tags, fall label, spoon drain labels, pit level tags, services lines, gas pipe, retaining wall. LABELS CIVIL (24): invert level tags (4 corners), cover level tags, "PP" tags, flow arrows, pipe descriptions for 100, 150, 225, 300 and rising main. Others: BLOCKS GROUND (19), LABELS GROUND (27), LABELS FRAMING (28), BRACING FRAMING (19), SUPPORTS FRAMING (25), HATCH FRAMING (31), HATCH SECTIONS (7), STEEL (23), PFC's (14), TIMBER (27), WALLS (15), TEXT (30: ready text at each pen size for 1:100 and 1:20), NOTES (16), SCHED (20: section titles, legends, standard notes, schedules, the A1 and A3 title sheets), TOOLS SECTIONS (7).
3. **Where it lives:** Shared drafting folder `Tool Palettes`. Blocks are dragged from a master drawing (mostly the office "typical blocks, layers, schedules and notes" drawing, plus the civil A1 sheet and a truss drawing).
4. **Duplicates:** The same pit, downpipe, overflow, inspection opening, floor waste and trench grate blocks are also shipped inside the Civil bundle and placed by civil commands (`PIT`, `DP`, `OF`, `IO`, `CDFW`, `CDTG`); fall symbol and spot level likewise.

Evidence: STUDY_C section 2B item 1 and closing paragraph, section 2D item 6.

## T-020 "NEW" palette set

1. **Typed name(s):** None.
2. **What it does:** 12 palettes, 307 block tools, dated 24 Sep 2026. A regrouped copy: BLOCKS CIVIL, BLOCK CIVIL 2, LABELS CIVIL, FRAMING, GROUND, HATCHES, NOTES, SCHED, STEEL (now includes the PFC sections), TEXT, TIMBER, WALLS.
3. **Where it lives:** Shared `Tool Palettes`.
4. **Duplicates:** BLOCKS CIVIL and BLOCK CIVIL 2 have identical tool lists. Duplicates the current set (T-019).

Evidence: STUDY_C section 2B item 2, section 7 item 25.

## T-021 "OLD TOOL PALETTES"

1. **Typed name(s):** None.
2. **What it does:** 43 palette files, 2022 to Sep 2024: earlier versions, several with "-Administrator" twins.
3. **Where it lives:** Shared `Tool Palettes`.
4. **Duplicates:** Earlier versions of T-019.

Evidence: STUDY_C section 2B item 3.

# Part 3. General helpers, generation 3 (inside the plug-ins)

## T-022 CE Tools ribbon tab

1. **Typed name(s):** None (a ribbon tab).
2. **What it does:** Four panels: Product (CE Manager, Survey Review, Version), Health & Support (CE Health, Support Bundle, Diagnostics, Open Logs), Updates (Updates & Rollback, Refresh, Admin), Shared Drafting (CE Blocks, Move + Rotate, Copy + Rotate).
3. **Where it lives:** Made by the Manager bundle.
4. **Duplicates:** Its buttons run the Manager commands in T-051 and the move / copy helpers in T-024.

Evidence: STUDY_C section 2C item 1, section 1 item 3.3.

## T-023 CE Blocks palette

1. **Typed name(s):** `CEBLOCKS`; `CEBLOCKINSERT` (used by the palette; typing it does nothing).
2. **What it does:** Opens the office blocks palette; picking a block there places it.
3. **Where it lives:** Manager.
4. **Duplicates:** Does the job of the tool palettes (T-019 to T-021).

Evidence: STUDY_C section 2C item 2, section 4 commands 11 and 12.

## T-024 Move + Rotate / Copy + Rotate inside the plug-ins

1. **Typed name(s):** `MR`, `MOVEROT`, `CR`, `COPYROT`; `COPYMULTI`.
2. **What it does:** As T-001.
3. **Where it lives:** Inside the Civil program (hidden from its list, "retained pending the approved Shared migration"); as LISP inside the Structural bundle; as a C++ part in the Civil bundle (`CE_TRANSFORM_2027.arx`, in the folder but not named in the bundle's start-up list; how it loads: Unknown). The Civil bundle carries the LISP copy for AutoCAD 2022 to 2026 only and the C++ part for 2027 only.
4. **Duplicates:** Five homes in all (T-001, T-054).

Evidence: STUDY_C section 2C item 3, section 2D item 1, section 3 item 16, section 1 item 1.3.

## T-025 Pen and line type quick-set (in the Structural program)

1. **Typed name(s):** 21: `SL25C`, `SL25H`, `SL25CTR`, `SL25D`, `SL25P` and the same for 35, 50 and 70; `SLALL`.
2. **What it does:** Make the layer for that pen and line type current; `SLALL` matches a picked object, then starts LINE.
3. **Where it lives:** Inside the Structural program, so a PC without Structural does not have them.
4. **Duplicates:** None recorded.

Evidence: STUDY_C section 2C item 4.1, section 7 item 5.

## T-026 Hatching (in the Structural program)

1. **Typed name(s):** 43: `6H`, `8H`, `10H`, `11CH`, `21H`, `31H`, `51H`, `74H`, `121H`, `138H`, `140H`, `141H`, `150H`, `174H`, `201H`, `213H`, `238H`, `242H`, `253H`...; `EH`, `CH`, `WH`, `PH`, `LBH`, `LBUH`, `H2A`; five managers `CEHATCH`, `CEHATCHCHANGE`, `CEHATCHAUDIT`, `CEHATCHGAP`, `CEHATCHBATCH`.
2. **What it does:** The number-named hatches from the LISP set and more, plus hatch managers.
3. **Where it lives:** Structural program.
4. **Duplicates:** T-003 (LISP); palette hatches.

Evidence: STUDY_C section 2C item 4.2.

## T-027 Dimensions and leaders (in the Structural program)

1. **Typed name(s):** `Q`, `QD`, `LD`, `AD`, `DUP`, `DSET`, `DSET1`, `CE_ARCDIM` (`RD`), `CE_MLEADERRIGHT` (`MLR`), `CE_MLEADERLEFT` (`MLL`).
2. **What it does:** As T-002, plus arc dimension and left / right multileaders.
3. **Where it lives:** Structural program.
4. **Duplicates:** T-002 (LISP).

Evidence: STUDY_C section 2C item 4.3.

## T-028 Marks (in the Structural program)

1. **Typed name(s):** `CE_SECTIONMARK` (`SM`), `CE_LEVELMARK` (`LM`), `CE_LEVELUPDATE`, `FFL`, `CE_RL`, `CE_SSL`, `CE_NGL`, `CL`, `BL`, `RC`.
2. **What it does:** Section mark, level mark and update, floor level, RL, SSL and NGL tags, centreline symbol, break line, revision cloud.
3. **Where it lives:** Structural program.
4. **Duplicates:** `RC` in LISP (T-006); level tag blocks on palettes.

Evidence: STUDY_C section 2C item 4.4.

## T-029 Clean-up and Xrefs (in the Structural program)

1. **Typed name(s):** `CLEAN`, `FASTSAVE`, `MTS`, `LU`, `XRL` and its four variants, `CXREF`, `PXREF`.
2. **What it does:** As T-004 and T-005.
3. **Where it lives:** Structural program.
4. **Duplicates:** T-004, T-005 (LISP). Civil has `CDXREFCOMPARE`, `CDXREFREPAIR` (T-045).

Evidence: STUDY_C section 2C item 4.5.

## T-030 Copy helpers (in the Structural program)

1. **Typed name(s):** `CPB`, `CR`, `MR`, `COPYROT`, `MOVEROT`, `DIV`, `DIVX`.
2. **What it does:** As T-001 and T-008.
3. **Where it lives:** Structural program; a Copy-Paste-as-Block LISP file ships in the Structural bundle.
4. **Duplicates:** T-001, T-008, T-024.

Evidence: STUDY_C section 2C item 4.6, section 1 item 2.3.

## T-031 Excel and export (in the Structural program)

1. **Typed name(s):** `EXCELMTEXT` / `XCLMTXT`, `STRUCEXPORTCSV`, `STRUCEXPORTPDF`, `STRUCEXPORTBLOCKS`, `CEEXPORTNOTES`.
2. **What it does:** Excel schedule into text; exports; `STRUCEXPORTPDF` plots the current layout to PDF (the only plot-to-PDF command found in any CE plug-in).
3. **Where it lives:** Structural program.
4. **Duplicates:** T-014 (LISP).

Evidence: STUDY_C section 2C item 4.7, section 3 item 13.

## T-032 Sheets and job (in the Structural program)

1. **Typed name(s):** `CESHEETS`, `CESHEETSMANAGER`, `CEPROPS`, `CECHECKLIST`, `CENOTES`; job time recording.
2. **What it does:** Sheets list and manager, drawing properties, job checklist, notes, job time recording.
3. **Where it lives:** Structural program. Checklist templates (23) in the shared folder and in a per-user folder.
4. **Duplicates:** The Manager window has "Project / Sheets" and "Project QA" pages (T-052). The same 23 checklist templates are kept in two places.

Evidence: STUDY_C section 2C item 4.8, section 2D item 9, section 4.

## T-033 Finders and settings (in the Structural program)

1. **Typed name(s):** `CETOOLS`, `CEPALETTE`, `CEHELP`, `CESETTINGS`, `CEADMINSETTINGS`.
2. **What it does:** `CETOOLS`: a command hub palette. `CEPALETTE`: search and run any CE command. Help; settings; drafting standards.
3. **Where it lives:** Structural program.
4. **Duplicates:** Civil has its own help, settings and standards commands (T-034, T-048).

Evidence: STUDY_C section 2C item 4.9.

# Part 4. Civil command groups (the Civil program, 145 typed names)

"(typed only)" means hidden from the ribbon.

## T-034 Set up a job or a drawing

1. **Typed name(s):** `CDNEWDWG` (typed only); `CDDISCIPLINE`; `CDS`; `CDMANAGER`; `CDPARTS`; `CDRULEBOOK` (typed only); `CDLABELSTYLE` (typed only); `CDSURVEY`.
2. **What it does:** `CDNEWDWG`: pick a job folder, discipline and sheet size; copies the office template in, names it, fills the title block, opens it (2027 only). `CDDISCIPLINE`: Civil or Structural drawing. `CDS`: CE defaults on this computer. `CDMANAGER`: drawing standards (layer colours, draw order, label styles). `CDPARTS`: parts and materials catalogue. `CDRULEBOOK`: project pit drop, council profile and cover override. `CDLABELSTYLE`: old name, now inside `CDS`. `CDSURVEY`: load a surveyor's drawing and keep ground levels for cover level suggestions.
3. **Where it lives:** Civil bundle (per-user plug-in folder).
4. **Duplicates:** `LU` (T-004) also brings in office layers and styles.

Evidence: STUDY_C section 3 item 1.

## T-035 Pits

1. **Typed name(s):** `PIT`; `PP`; `CDPIT350`, `CDPIT450`, `CDPIT600`, `CDPIT900`, `CDPIT1200` (typed only); `CDEDIT` (also `PITEDIT`, `PIPEEDIT`); `PITDELETE`, `CDPITCOVERFLIP`, `CDRENUMBER` (typed only).
2. **What it does:** Place a pit with type, size, cover and schedule values; `PP` pre-filled as a 350 x 350 plastic pit; size presets; open the editor of a picked pit or pipe; delete a pit with its label and cover text; move the cover level text to another corner; renumber pits from the outlet upstream.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** Pit blocks on the BLOCKS CIVIL palette. The pit block, pit label and pit schedule drawings ship in both the Civil and the Structural bundles; the pit block file differs in size between the two.

Evidence: STUDY_C section 3 item 2, section 2D items 6 and 7.

## T-036 Pipes

1. **Typed name(s):** `CD`; `CDPIPEOBJ`, `CDC7UPGRADE`, `CDBREAK`, `CDREVERSEFLOW`, `CDPIPEDIRECTION`, `CDSYSTEM` (typed only); `CDSTRIP`; `CDAGI`; `CDPERIMETER`; `CDLPD`; `CDLPDRESET` (typed only); `CDPIPEOVERRIDE`, `CDPIPEOVERRIDECLEAR`, `PIPEPITLINK` (`LINKPIPEPIT`), `PIPEPITUNLINK` (`CLEARPIPEPITLINK`), `CDCONFIRM` (typed only).
2. **What it does:** `CD`: draw a drainage pipe with size, flow and invert controls. `CDPIPEOBJ`: draw a pipe as one AutoCAD object (2027 only). `CDC7UPGRADE`: turn existing pipes into one-object pipes, with a dated copy first (2027 only). Record a branch; turn a pipe around; confirm or reverse a guessed flow direction; put pipes in a system. `CDSTRIP`: 100 mm strip drain with floor wastes at corners and at 12 m centres. `CDAGI` / `CDPERIMETER`: agricultural or perimeter drain line, auto-tagged. `CDLPD`: legal point of discharge. The last group joins or un-joins a pipe end to a pit by hand.
3. **Where it lives:** Civil bundle; with two C++ parts for the one-object pipe (grips and the object enabler, 2027 only).
4. **Duplicates:** `CDD` and the older `CD` in LISP (T-015). A drawing with one-object pipes cannot be edited on a PC with nothing installed (see `INSTALL_TODAY.md`).

Evidence: STUDY_C section 3 item 3, section 2D item 2, section 6 item 8.

## T-037 Levels and falls

1. **Typed name(s):** `CDSL`; `CDFALL`; `CDFALLSUGGEST`; `CDRUNSOLVE`; `CDPROPAGATE`, `CDRECOVERINVERTS` (typed only); `CDTWL`.
2. **What it does:** Place and manage spot levels; place a fall symbol; suggest a fall arrow toward the nearest grated pit; `CDRUNSOLVE`: pick a start pit, work out inverts and grades down the run, preview, apply; push or rebuild invert levels; `CDTWL`: top water level from a detention pit or tank outlet, with storage and head (changes nothing).
3. **Where it lives:** Civil bundle.
4. **Duplicates:** Fall symbol and spot level blocks on tool palettes; level marks in Structural (T-028).

Evidence: STUDY_C section 3 item 4, section 2D item 6.

## T-038 Sources (where water comes from)

1. **Typed name(s):** `DP`, `IO`, `OF`, `FO`, `GIO`, `CDFW`, `CDTG` (old name `TG`), `CDSOURCE`, `CDRG`; `CDTAG`; `CDDEST`; `CDFIXTAGS`, `CDSOURCECHANGETYPE` (typed only).
2. **What it does:** Downpipe, inspection opening, overflow, front overflow, gross inlet block (`GIO`, as the evidence words it), floor waste, trench grate, generic source, raingarden outline with hatch; tag, re-tag or repair source names and register non-standard blocks; follow the pipes and say where each downpipe ends up; fix duplicate names; change type (parked, does nothing).
3. **Where it lives:** Civil bundle.
4. **Duplicates:** The same blocks on the BLOCKS CIVIL palette.

Evidence: STUDY_C section 3 item 5, section 2D item 6.

## T-039 Tanks

1. **Typed name(s):** `CDWT`.
2. **What it does:** Tag a water tank, ask total, detention and reuse litres, place a callout, link riser and dropper.
3. **Where it lives:** Civil bundle (with a tank library data file).
4. **Duplicates:** None recorded.

Evidence: STUDY_C section 3 item 6, section 1 item 1.5.

## T-040 Slabs, paving and site

1. **Typed name(s):** `CDSLAB`; `CDSLABIMPORT`; `CDSLABEDIT`, `CDSLABEREGEN`, `CDSLABFLOW` (typed only); `CDJOINT`; `CDCJ`, `CDSC`; `CDSPOON`; `CDSPOONDRAIN`; `CDKERB`; `CDPAVE`; `CDCATCHMENT`; `CDTPZ`, `CDSRZ`.
2. **What it does:** Design slab or hardstand falls (places fall symbols and spot levels); adopt a hand-drawn slab; edit, regenerate, show where water goes; automatic saw-cut grid; one construction joint or saw cut; spoon drain outline inside a slab; spoon drain run with length and fall; kerb line; hatch and record a paved area; show a grated pit's paved catchment as a light overlay and warn if too big; tree protection zone and structural root zone circles.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** Joints: T-009 (LISP), Structural, palette blocks.

Evidence: STUDY_C section 3 item 7, section 2D item 3.

## T-041 Schedules

1. **Typed name(s):** `PITSCHEDULE`.
2. **What it does:** Review, override, compare and place the pit schedule.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** `CIVILEXCELMTEXT` (T-014); pit schedule block on palettes and in both bundles.

Evidence: STUDY_C section 3 item 8, section 2D items 4 and 7.

## T-042 Details and labels

1. **Typed name(s):** `CDPROFILE`; `CDANNOTATIONEDIT`; `CDTIDYLABELS`; `CDMA`, `CDTEXTSEG` (typed only).
2. **What it does:** Long section from a picked upstream pit; move, rotate, mirror or flip one label or arrow; slide CE labels clear of other text; move a flow arrow or pipe text to another segment.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** `CDDA` / `MFA` in LISP move the flow arrow (T-015).

Evidence: STUDY_C section 3 item 9.

## T-043 Checks

1. **Typed name(s):** `CDCHECK`; `CDCHECKCURRENT`; `CDDASHBOARD`; `CDHUB`; `CDRULES` (typed only); `CDCHECKS`, `CDCHECKIGNORE`, `CDCHECKIGNOREAPPLY` (typed only, "not switched on yet"); `CDINSPECTOR`; `CDFOCUS`, `CEFIND` (typed only).
2. **What it does:** List every connection the drawing can prove and those it cannot; show what CE can read in the open drawing; design-check dashboard; read-only network health hub; check against the engineering rulebook (velocity, grade, cover, pit drop); the new single checks list; the Inspector side palette; zoom to and highlight a pit, pipe or source.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** Several check views of the same drawing (check, dashboard, hub, rules, the new checks list).

Evidence: STUDY_C section 3 item 10.

## T-044 Calculations and design

1. **Typed name(s):** `CDCALC`; `CDDESIGN` (old name `CDSETUP`); `CDRAINFALL`.
2. **What it does:** The drainage calculations suite (also makes the computations sheet as PDF or Excel); review design inputs and work out the design (nothing is drawn); show or record the job's rainfall.
3. **Where it lives:** Civil bundle (with council profiles and Melbourne rainfall data files).
4. **Duplicates:** The office workbooks (see `design\SUMS.md`).

Evidence: STUDY_C section 3 item 11, section 1 item 1.5.

## T-045 Import and export

1. **Typed name(s):** `CDIMPORTXCIVIL`, `CDIMPORTLANDXML`; `CDIMPORTCOMPARE`; `CDCHECKDWG`; `CDEXPORTENTITIES`; `CDEXPORTCORPUS`, `CDXREFCOMPARE`, `CDXREFREPAIR` (typed only).
2. **What it does:** Bring in another civil package's drawing or a LandXML file, with a review first; compare imported data with the drawing; read-only check of a consultant's drawing; export geometry and schedule references; developer export; compare a changed background; repair broken Xref paths.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** None recorded. The August notes record that bringing in an outside engineer's plan went badly wrong (lost the control pit, made 47 false pits out of labels).

Evidence: STUDY_C section 3 item 12; DIGEST section 7 item 1.

## T-046 Issue (plot, transmit, revise)

1. **Typed name(s):** None.
2. **What it does:** No civil command for issuing was found.
3. **Where it lives:** Not applicable. The only plot-to-PDF command found is in Structural (`STRUCEXPORTPDF`, T-031).
4. **Duplicates:** Not applicable.

Evidence: STUDY_C section 3 item 13, section 7 item 24.

## T-047 Repair and upgrade

1. **Typed name(s):** 20, almost all typed only: `CDREPAIR` (on the ribbon), `CDSYNC`, `CDREBUILD`, `CDREBUILDLINKS`, `CDLINKDANGLINGPIPES`, `CDFIXPIPEENDS`, `CDFIXFLATPIPES`, `CDUPGRADE`, `CDSPINEUPGRADE`, `CDREFRESHBLOCKS`, `CDREFRESHLINKS`, `CDAUDIT`, `CDAUDITDETAIL`, `CDGRAPH`, `CDIMPORTAUDIT`, `CDLEGACYAUDIT`, `CDSTARTUPAUDIT`, `CDTRENCHGRATEAUDIT`, `CDTRIAGE`, `CDDEBUG`.
2. **What it does:** The repair centre and its many repair, rebuild, upgrade and audit commands.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** The Manager window has a "Drawing Repair" page (T-052).

Evidence: STUDY_C section 3 item 14, section 7 item 3.

## T-048 Help and feedback

1. **Typed name(s):** `CDHELP`; `CESTARTHERE`; `CDFEEDBACK`; `CDDIAG`; `CEASK` / `CDASK`; `CDMENU` (typed only).
2. **What it does:** Help centre; 2-minute picture tour; bug report; count pits and pipes; ask a question about the drawing.
3. **Where it lives:** Civil bundle (with the help guide as web pages).
4. **Duplicates:** `CEHELP` in Structural (T-033); fault report in the Manager (T-052).

Evidence: STUDY_C section 3 item 15.

## T-049 Internal or fault-finding (not staff tools)

1. **Typed name(s):** `CDGRIPROUTE`, `CDGRIPDIAG`, `CEPERFDIAG`, `CETRUSTREAD`, `CDPIPEATTACHMENTACTION`, `CDUSEPLANLABEL`, `CDCLOSETAB`, `CE_TEST_RUN` (all typed only).
2. **What it does:** Internal or fault-finding.
3. **Where it lives:** Civil bundle.
4. **Duplicates:** Not applicable.

Evidence: STUDY_C section 3 item 17.

## T-050 The civil ribbon and the civil settings

1. **Typed name(s):** None (ribbon and settings).
2. **What it does:** Ribbon as coded, single "CE" tab, panels: CE (Ask CE, Help Centre, Civil/Structural switch), Draw (Pipe, Pit gallery, Water Tank, Spot Level, Fall, Suggest Fall), Sources (Downpipe, Inspection Opening, Overflow, Front Overflow, "More sources"), Edit (Edit, Repair & Upgrade, Edit Annotation, Tidy labels), Design (Design setup, Rainfall, Legal point of discharge), Review (Project Review, Checks, Check Current Drawing, Pit Schedule, Calculations...), Site (Slab System, Spoon Drain, Pavement Area, Catchment Overlay, Kerb, Spoon Drain Run, Joints, Tree Zones), Import (Survey, Consultant DWG, Compare; Export), Settings (Settings, Layer Standards, Parts Catalogue, Feedback, Data Diagnostics). Three extra tabs appear when a pipe, a pit or a source is selected. Settings: 577 separate settings in 49 groups, 250 of them on/off switches; about 400 entries saved on this PC.
3. **Where it lives:** The ribbon is made by the program at start-up (no ribbon file in the Civil bundle). Settings in per-user folders (see `INSTALL_TODAY.md`).
4. **Duplicates:** A second, different ribbon layout list ships in the same bundle as a data file (panels Layout, Design, Sources, Review, Edit, Settings, Import/Export, Admin). What the drafter actually sees on screen was not checked.

Evidence: STUDY_C section 3 closing paragraphs, section 1 item 1.4, section 7 items 4 and 13.

# Part 5. The Manager

## T-051 Manager typed commands

1. **Typed name(s):** `CEMANAGER`; `CEMANAGERREFRESH`; `CEMANAGERUPDATES`; `CEMANAGERADMIN`; `CEMANAGERDIAG`; `CEMANAGERLOGS`; `CEHEALTH`; `CESUPPORT`; `CE_VERSION`; `CESURVEYREVIEW`; `CEBLOCKS`; `CEBLOCKINSERT`.
2. **What it does:** Open the Manager window; re-check what is installed, send waiting usage reports, rebuild the ribbon; open the Updates page; open the Admin Dashboard (refused if not an administrator); write a plain-English diagnostic report; open the logs folder; `CEHEALTH`: print a health check (each module present and running, whether Civil's and Manager's shared library copies match, duplicate bundles, whether the office IT folder can be reached); zip logs and diagnostics; the version window; open the Manager at a survey just brought in; the blocks palette.
3. **Where it lives:** Manager bundle (per-user plug-in folder), version 1.1.89.
4. **Duplicates:** The Manager's own notes say "8 commands"; it has 12. An old Manager (1.0.0) sits switched off in the all-users folder.

Evidence: STUDY_C section 4 "Its 12 typed commands", section 1 items 3 and 6, section 7 item 12.

## T-052 Manager windows

1. **Typed name(s):** Opened by `CEMANAGER`, `CEMANAGERADMIN`, `CE_VERSION`.
2. **What it does:** The CE Suite Manager window: pages Status, Updates, Settings, Help, Project / Sheets, Project QA, Survey Intake, Drawing Repair; lists each CE module as Installed / Running / Starts next time; buttons Refresh, Load Now, View Commands, View History, What's ready, Review update, Get update ready, Older versions, Open Help, Open Hub, Open Repair, Send a fault report, Send waiting reports; the update page shows "1 · Approved", "2 · Copied, waiting", "3 · Install", then "Close AutoCAD" and "Then run the CE installer". The Admin Dashboard (only for a listed CE administrator): tabs Overview, Usage, Machines, Failures, Updates, Policies, Support Bundles; buttons Approve Available Build, Canary Rollout, Promote to All, Roll Back Approved Release, Create Support Bundle, Upload Pending, Set up CE administrator. The Version window: the exact loaded Civil, Structural and Manager versions.
3. **Where it lives:** Manager bundle. Behind the scenes it reads the office IT folder for newer builds, records which build is approved, copies an approved build to a waiting area, writes usage, machine and failure records to the office IT folder, and rebuilds the CE ribbon tabs.
4. **Duplicates:** By its own design note "it cannot publish, activate or replace a loaded bundle": a separate installer program finishes an update.

Evidence: STUDY_C section 4.

# Part 6. Leftover test pieces

## T-053 CE AutoCAD Link 2027 (test bundle)

1. **Typed name(s):** `CEW03TESTEXTRACT`, `CELINKSTATUS`.
2. **What it does:** Named in its own file "Isolated Development" and "synthetic-only read-only test bundle; no network". Loads at every start-up. A leftover test piece.
3. **Where it lives:** Per-user plug-in folder; version 0.3.0, dated 20 Jul 2026.
4. **Duplicates:** Not applicable.

Evidence: STUDY_C section 1 item 4, section 7 item 22.

## T-054 CE Transform Trial 2027 (test bundle)

1. **Typed name(s):** `CETESTCR`, `CETESTMR`.
2. **What it does:** Trial Copy+Rotate and Move+Rotate. One C++ file. Loads only when its commands are typed. A leftover test piece.
3. **Where it lives:** Per-user plug-in folder; version 0.1.0, dated 7 Sep 2026.
4. **Duplicates:** The fifth home of Move+Rotate / Copy+Rotate (T-001, T-024).

Evidence: STUDY_C section 1 item 5, section 2D item 1.

---

Next free number: T-055
