# CE tools, the Manager and how they are installed today

**Written:** Mon 16 Nov 2026 (Melbourne). Read-only study. Nothing was changed, built, installed or run in AutoCAD.
**Scope:** this one PC (the principal's), the office shared drafting folder, the office IT folder, and the plugin's source repository read at the three versions that are installed.
**Words used:** "bundle" = a folder ending in `.bundle` that AutoCAD looks for in its plug-in folders. "Lane" = one of three copies of the same program built for different AutoCAD years. "Typed name" = what a drafter types at the command line.
**No tables, no secrets, no client or staff names.** Where a file name on disk contains a staff or client name it is described, not quoted.

How to read the counts: "in the program" means counted from the program's own source at the installed version; "in the list" means the program's own command list file (`command-registry.json`) that ships inside the bundle.

---

## 1. What is installed on this PC right now

AutoCAD installed on this PC: **AutoCAD 2027 only** (one folder under Program Files\Autodesk).

AutoCAD's three plug-in folders were all read. Seven bundles exist. Six are the office's own (one of them switched off).

1. **CE Civil (`CE_CVL_SUITE.bundle`)**, in the per-user folder `%APPDATA%\Autodesk\ApplicationPlugins`.
   1. **Version:** 3.0.90.13, files dated 15 Nov 2026 10:44 pm. Described in its own file as "Civil Stormwater Drainage Suite".
   2. **Size:** 832 files, 162 MB. Three lanes, each a full copy: Legacy (AutoCAD 2022 to 2024), Net8 (2025 and 2026), Modern (2027).
   3. **What AutoCAD 2027 loads from it:** the main civil program (10.8 MB), the shared CE library `CE_SHARED.dll` (version 1.1.0), `CE.AI.Core.dll` (1.0.0), 21 third-party helper libraries (Excel, PDF, geometry, logging, web view, window styling), plus two C++ parts asked for at start-up: `CE_CVL_NATIVE_GRIP_2027.arx` (grips on CE pipes) and `CE_CVL_OBJECTS_2027.dbx` (the "object enabler" that teaches AutoCAD the CE pipe object). A third C++ file, `CE_TRANSFORM_2027.arx` (Copy+Rotate, Move+Rotate), is in the folder but is not named in the bundle's start-up list. How it gets loaded: Unknown from the files alone.
   4. **What it adds:** a ribbon tab called **CE** (or **CE Civil** if the personal switch "show the old CE tabs" is on), three extra tabs that appear when a pipe, a pit or a source is selected (Pipe, Pit, Source), a status bar item, and 145 typed commands (section 3). There is no ribbon file (CUIX) in this bundle; the ribbon is made by the program at start-up.
   5. **Data files shipped in it:** 18 block drawings (pit block, pit label, pit schedule, downpipe, overflow, inspection opening, floor waste, riser, dropper, GIO, trench grate, source, spot level, fall symbols, flow arrow, on-site detention criteria), a line type file, the help guide (web pages), and nine data files: the command list, a ribbon layout list, council profiles (184 KB), Melbourne rainfall data, network catalogue, slab types, tank library, colleague starting settings, and a "what's new" text.
   6. **Mismatch seen inside it:** the main civil program is built from the 15 Nov source, while `CE_SHARED.dll` and `CE.AI.Core.dll` beside it are dated 2 Nov and built from an older source point. The "what's new" file says version 3.0.1; the program says 3.0.90.13. The source note for this exact version says it is "for Tim's PC, never for colleagues", with its new switches off.
2. **CE Structural (`CE_STRUC_SUITE.bundle`)**, same per-user folder.
   1. **Version:** 1.0.126.1, files dated 14 Nov 2026 1:35 am. 2,007 files, 72 MB, three lanes.
   2. **What AutoCAD 2027 loads:** the structural program (5.2 MB), a design-calculation library, 19 third-party libraries, and one C++ part `CE_STRUC_NATIVE_2027.arx` (reads architect backgrounds for the "review architectural changes" tool).
   3. **What it adds:** it is the only bundle with a ribbon file (`CE_STRUC_SUITE_MENU.cuix`, one copy per lane, plus a working copy in `%LOCALAPPDATA%\CE_STRUC_SUITE`). 376 typed commands in the program; 375 in its command list, 63 of them hidden. It also carries 14 block drawings, 2 old-style dialog files, 2 LISP files (Copy+Rotate, Copy-Paste-as-Block), a hatch pattern, section, rebar and timber catalogues, and 1,773 small button pictures.
3. **CE Suite Manager (`CE_SUITE_MANAGER.bundle`)**, same per-user folder.
   1. **Version:** 1.1.89, files dated 2 Nov 2026 11:07 am. 75 files, 8.7 MB, three lanes.
   2. **What AutoCAD 2027 loads:** the Manager program, its own copy of `CE_SHARED.dll` (same version and build as the copy in the Civil bundle), and `CE.Diagnostics.dll`.
   3. **What it adds:** the **CE Tools** ribbon tab and 12 typed commands (section 4). It also re-assembles the CE ribbon tabs after start-up.
4. **CE AutoCAD Link 2027 (`CE.AutoCADLink.2027.bundle`)**, same per-user folder. Version 0.3.0, dated 20 Jul 2026. Named in its own file "Isolated Development" and "synthetic-only read-only test bundle; no network". Loads at start-up. Two typed commands: `CEW03TESTEXTRACT`, `CELINKSTATUS`. This is a leftover test piece.
5. **CE Transform Trial 2027 (`CE.Transform.Trial.2027.bundle`)**, same per-user folder. Version 0.1.0, dated 7 Sep 2026. One C++ file. Loads only when its commands are typed: `CETESTCR`, `CETESTMR` (trial Copy+Rotate and Move+Rotate). Also a leftover test piece.
6. **An old Manager in the all-users folder (`C:\ProgramData\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle`)**. Version 1.0.0, dated 8 Jul 2026. Its contents file has been renamed to end in `.DISABLED-duplicate-appdata-wins`, so it is switched off by hand, not removed.
7. **Autodesk's own "AutoCAD MCP Server" bundle** in Program Files. Not the office's. Listed only for completeness.

**Old copies sitting beside the live bundles.** The per-user plug-in folder also holds 119 folders that are not live: 56 dated backups of Civil, 17 of Structural, 45 of Manager, and one marked "removed". They are named with a source code and a date-time (for example `CE_CVL_SUITE_PRE_<code>_<date>.backup`). Together they take **10.2 GB**. The oldest is from 23 Sep 2026; most are from 10 Oct to 16 Nov 2026. That is roughly one install every day or two for five weeks.

**Where settings, logs and working files live on this PC (described, not dumped).**

1. **`%APPDATA%\TIM_CE_CADTOOLS`** (the civil program's settings folder, by its own source). Civil settings (`CD_Settings.json`, 15 KB), recent typed values, civil project data file, parts catalogue, label styles, theme, two dated settings backups, a 352 KB structural settings file dated March, auto-save backups (1,270 files, 1.0 GB), logs (276 files), caches, exports, Excel import sessions, markup files, an admin folder with 32,866 small files, and a per-PC identity file.
2. **`%APPDATA%\CE_CVL_SUITE`**. A second, small civil settings file (`settings.json`, 672 bytes), logs (383 files, 36 MB, mostly check reports named after the drawing checked), a suggestions record ("ledger", 14 MB), feedback, usage counts ("telemetry"), dated roll-back files for one drawing's identity upgrade, and two small switch files for pipe grips.
3. **`%APPDATA%\CE_STRUC_SUITE`**. Structural settings (`CS_Settings.json`, 36 KB, about 800 entries) plus a dated backup, **auto-save backups: 2,176 files, 2.0 GB**, caches, logs (342 files, 45 MB), Excel sessions, project files.
4. **`%APPDATA%\CE_SUITE_MANAGER`**. Manager logs (14 files) and usage counts.
5. **`%APPDATA%\CE_CADTOOLS`**. An install identity file, a Manager menu file (rewritten today), and another admin folder (1,019 files, 105 MB).
6. **`%APPDATA%\TIM_CETOOLS`**. 23 checklist templates (the same 23 as in the shared folder `TIM_CETOOLS\Templates`).
7. **`%APPDATA%\CE_ACAD_PLUGIN`**, **`CE_BEAM_DESIGNER`**, **`Creative Engineering\CE Suite Manager`**. One small file or empty.
8. **`%LOCALAPPDATA%`** holds a further set of install and release working folders: `CE Suite` (release candidates, staged updates, roll-backs, evidence: 36,441 files, 1.3 GB, all dated July), `CE_CADTOOLS` (official releases, deployments, activations: 717 MB, July to August), `CE_ACAD_PLUGIN` (deploy staging and roll-back: 234 MB, August), `CE_SUITE` (roll-backs and a study folder: 300 MB), `CE_CVL_SUITE` (web-view caches and deployment backups: 152 MB), `CE_SUITE_MANAGER` (a crash trace written today and an older start-up failure log), nine `CE-W0x-...` folders from a July experiment (two of them 421 MB each), and `CreativeEngineering` (19 GB, an e-mail archive audit, not plug-in related).
9. **`%APPDATA%\CE_SUITE`** (the folder the brief named): **does not exist** on this PC.
10. **Scheduled tasks:** none with a CE name were found today, although older installers were written to create a daily 6 am update task.

---

## 2. CE tools: the everyday drafting helpers

Three separate generations of general helpers exist side by side.

### 2A. Generation 1: loose LISP files in the shared drafting folder

Folder: `Creative Engineering - Drafting\Lisp Files`. 653 files: 181 LISP files, 17 old-style dialog files, 392 small button pictures, 30 drawings, 5 menu files.

**Count:** 486 different typed names across all 181 files. Only 156 of them are in files that are not in a folder marked superseded, saved or old; the other 330 exist only in superseded copies.

The same file often exists two to six times (root, `TIM`, `TIM EXPORT`, `UPDATED LISP FILES`, `C DRIVE STUFF`, `SUPERSEDED`, `SAVED`). `TIM EXPORT` has the newest dates (mid to late 2025) for most tools; `UPDATED LISP FILES` has the newest bracing and beam files (Jan to Feb 2026).

Current helpers, by what the drafter is doing (typed name, then what it does):

1. **Move and copy.**
   1. `MR` / `MOVEROT`: move the picked objects, then rotate them at the new spot.
   2. `CR` / `COPYROT`: copy the picked objects, then rotate the copy.
   3. `C`: AutoCAD COPY forced to "multiple".
   4. `CPB`: copy the picked objects and paste them back as one block on a BLOCKS layer.
   5. `MD`: offset the picked objects repeatedly between two points at a set maximum spacing.
2. **Dimensions and leaders.**
   1. `Q`: leader with arrow. `QD`: leader with dot.
   2. `LD`: linear dimension. `AD`: aligned dimension. Both on the office dimension layer and style, at 1:20 or 1:100.
   3. `DUP`: change all dimensions from the 1:20 set-up to 1:100. `DSET`: set the measuring factor on picked dimensions.
3. **Hatching (structural plans and sections).** `EH` earth, `CH` concrete, `WH` waffle pod, and number-named hatches `10H`, `21H`, `31H`, `51H`, `74H`, `201H`, `238H`, `242H` (each lays the office hatch of that pen colour at the right scale for the drawing); `LBH`, `LBUH` load-bearing wall over and under; `H2A` re-attach hatches to their outlines.
4. **Text styles, clean-up and saving.**
   1. `MTS`: merge text styles into one.
   2. `CLEAN`: purge, run the Xref layer tidy, force text styles to standard, regenerate, save. `FASTSAVE`: quick version.
   3. `LU`: bring the office layers and styles in by inserting a settings block, then purge it.
5. **Xrefs.** `XRL` (and `XRLFAST`, `XRLCONFIG`, `XRLINFO`, `XRLSILENT`, `XRLHELP`): put Xrefs on the office Xref layer and tidy their layers.
6. **Revision cloud.** `RC`: rectangular revision cloud at the office arc size, asks about object snap first.
7. **Multilines.** `CML`: closed-end multiline. `SML`: standard multiline. `CHECKML`: say which style is current.
8. **Footings and piers.** `SPW`, `SPW3`, `SPW6`, `SPWC`: bored piers at 450, 300, 600, and 450 with concrete hatch, spaced along a line. `DIV`, `DIVX`: divide a line with cross marks or a block.
9. **Slab joints.** `CJ`: construction joint line and label. `SSC` (older file: `SCC`): saw cut line and label.
10. **Structural text tags (about 55 typed names).** `EBT`/`EBB` edge beam, `IBT`/`IBB` internal beam, `SFT`/`SFB` strip footing, `THL`/`THR` slab thickening, `PFL`/`PFR` pad footing, `BPL`/`BPR` bored pier, `CL1`/`CR1` column, `PCL`/`PCR` portal column, `SL`/`SR` stiffener, `DSL`/`DSR` double stud, `TSL`/`TSR` triple stud, `25L`/`25R`/`25C`... 2.5 mm text left, right, centre, top, bottom; "B..." versions for basements; "...C..." versions that also draw the footing outline; `FST` a size manager window.
11. **Supports.** `IDS`, `IDSA`, `ITSA`, `ICA`: insert a post or stud support block with a rotation preview. `SDS`, `SDSA`, `STSA`, `SCA`: swap one support type for another and fix its tag.
12. **Beams.** Typed as single digits: `1` beam, `2` lower beam, `4` and `5` beams with a formatted size label, `1A`, `2A`, `4A` the same drawn between support blocks, `8` set the beam offsets.
13. **Bracing.** `AB`, `BB`: place type A or type B wall bracing. `ABS`/`ABSWITCH`: swap A and B. Five more typed names are fault-finding only.
14. **Excel into drawings.** `EXCELMTEXT`: bring a member schedule from Excel into drawing text. `CIVILEXCELMTEXT`: the same for a civil pit schedule from a CSV file. `VALIDATECSV`, `FIXCSV`, `CREATETEMPLATE`, `EXCELHELP`, `EXCELLOAD`: helpers around it.
15. **Old civil pipe tools (LISP).** `CDD` (also `CDD3`, `CDDE`): draw a drainage pipe with size, grade, invert text and flow arrow, from an 11,540-line file dated Nov 2025. `CDDS` settings, `CDDA`/`MFA` move the flow arrow, `SETOFFSET` text offset. An earlier `CD` LISP ("Civil Pipe Creation") exists in six copies, all in old or superseded folders. `TIM` and `TBDRAIN-INPUT`: an older pipe-data dialog. `SETODIST`/`GETODIST`, `SETCVLODIST`/`GETCVLODIST`: remembered offset distances.
16. **Tool palettes switcher.** `TP`: show one group of tool palettes (CIVIL, FRAMING, GROUND, SECTIONS).
17. **Other.** `3DF2L`: a third-party tool that turns 3D faces into lines (its prompts are not in English).

Also in that folder: `TB2024.MNU`, an old-style menu file (4 pull-down menus, about 30 toolbars) that calls 903 different LISP routines by name. Those routines are not in this folder; they belong to a bought-in structural toolkit kept in the IT folder. Whether anyone still loads this menu: Unknown.

How these LISP files get loaded on a colleague's PC (start-up suite, a start-up LISP file, or the menu): **Unknown.** No start-up loader file was found in the shared folder itself. The settings export zips in `Autocad Utilities` may hold the answer but were not opened.

### 2B. Generation 2: tool palettes

Folder: `Creative Engineering - Drafting\Tool Palettes`. 71 palette files in three sets. Every tool is a block dragged from a master drawing (mostly one office "typical blocks, layers, schedules and notes" drawing, plus the civil A1 sheet and a truss drawing). **No palette tool runs a command**; they only insert blocks.

1. **Current set (17 palettes, 358 block tools, dated 10 Dec 2024).**
   1. BLOCKS CIVIL (26): stormwater pit, pit block, downpipe, overflow, inspection opening, grated inspection, floor waste, riser/dropper, existing pit and pipes, council drain, cut pipe, trench grate, RL tags, fall label, spoon drain labels, pit level tags, services lines, gas pipe, retaining wall.
   2. LABELS CIVIL (24): invert level tags (4 corners), cover level tags, "PP" tags, flow arrows, pipe descriptions for 100, 150, 225, 300 and rising main.
   3. BLOCKS GROUND (19): step symbols, cross bars, dowels, bored pier, slab thickness, column over, cast-in plate, footing, screw pile, batter, SC and CJ lines.
   4. LABELS GROUND (27): edge beam, internal beam, thickening, bored pier, pad footing, strip footing tags, SC and CJ labels.
   5. LABELS FRAMING (28): column, stud, portal column, purlin tags, floor beam, lintel, roof beam tags, bracing wall tags.
   6. BRACING FRAMING (19): A and B bracing, wall bracing, truss labels.
   7. SUPPORTS FRAMING (25): timber and steel post supports, load-bearing wall, rafters, joists.
   8. HATCH FRAMING (31) and HATCH SECTIONS (7): ready-made hatches.
   9. STEEL (23), PFC's (14), TIMBER (27), WALLS (15): section and connection blocks.
   10. TEXT (30): ready text at each pen size for 1:100 and 1:20.
   11. NOTES (16), SCHED (20): section titles, legends, standard notes, schedules, and the A1 and A3 title sheets.
   12. TOOLS SECTIONS (7): RL tags, waterstop, pipe ends.
2. **"NEW" set (12 palettes, 307 block tools, dated 24 Sep 2026).** A regrouped copy: BLOCKS CIVIL, BLOCK CIVIL 2 (the two have identical tool lists), LABELS CIVIL, FRAMING, GROUND, HATCHES, NOTES, SCHED, STEEL (now includes the PFC sections), TEXT, TIMBER, WALLS.
3. **"OLD TOOL PALETTES" (43 palette files, 2022 to Sep 2024).** Earlier versions, several with "-Administrator" twins.

The same pit, downpipe, overflow, inspection opening, floor waste and trench grate blocks that sit on the civil palettes are also shipped inside the Civil bundle and placed by civil commands (`PIT`, `DP`, `OF`, `IO`, `CDFW`, `CDTG`).

### 2C. Generation 3: helpers inside the plug-ins

1. **CE Tools ribbon tab (from the Manager).** Four panels: Product (CE Manager, Survey Review, Version), Health & Support (CE Health, Support Bundle, Diagnostics, Open Logs), Updates (Updates & Rollback, Refresh, Admin), Shared Drafting (**CE Blocks**, **Move + Rotate**, **Copy + Rotate**).
2. **`CEBLOCKS`** (Manager): opens the office blocks palette; picking a block there places it.
3. **`MR`, `MOVEROT`, `CR`, `COPYROT`** exist again inside the Civil program (hidden from its list, "retained pending the approved Shared migration"), again as LISP inside the Structural bundle, and again as a C++ part in the Civil bundle.
4. **General drafting helpers that live inside the Structural program** (so a PC without Structural does not have them). From its command list:
   1. **Pen and line type quick-set (21):** `SL25C`, `SL25H`, `SL25CTR`, `SL25D`, `SL25P` and the same for 35, 50 and 70 (make the layer for that pen and line type current), `SLALL` (match a picked object, then start LINE).
   2. **Hatching (43):** the number-named hatches from the LISP set and more (`6H`, `8H`, `10H`, `11CH`, `21H`, `31H`, `51H`, `74H`, `121H`, `138H`, `140H`, `141H`, `150H`, `174H`, `201H`, `213H`, `238H`, `242H`, `253H`...), `EH`, `CH`, `WH`, `PH`, `LBH`, `LBUH`, `H2A`, and five managers (`CEHATCH`, `CEHATCHCHANGE`, `CEHATCHAUDIT`, `CEHATCHGAP`, `CEHATCHBATCH`).
   3. **Dimensions and leaders:** `Q`, `QD`, `LD`, `AD`, `DUP`, `DSET`, `DSET1`, `CE_ARCDIM` (`RD`), `CE_MLEADERRIGHT` (`MLR`), `CE_MLEADERLEFT` (`MLL`).
   4. **Marks:** `CE_SECTIONMARK` (`SM`), `CE_LEVELMARK` (`LM`), `CE_LEVELUPDATE`, `FFL`, `CE_RL`, `CE_SSL`, `CE_NGL`, `CL` centreline symbol, `BL` break line, `RC` revision cloud.
   5. **Clean-up and Xrefs:** `CLEAN`, `FASTSAVE`, `MTS`, `LU`, `XRL` and its four variants, `CXREF`, `PXREF`.
   6. **Copy helpers:** `CPB`, `CR`, `MR`, `COPYROT`, `MOVEROT`, `DIV`, `DIVX`.
   7. **Excel and export:** `EXCELMTEXT` / `XCLMTXT`, `STRUCEXPORTCSV`, `STRUCEXPORTPDF` (plot the current layout to PDF), `STRUCEXPORTBLOCKS`, `CEEXPORTNOTES`.
   8. **Sheets and job:** `CESHEETS`, `CESHEETSMANAGER`, `CEPROPS` (drawing properties), `CECHECKLIST`, `CENOTES`, job time recording.
   9. **Finders:** `CETOOLS` (a command hub palette), `CEPALETTE` (search and run any CE command), `CEHELP`, `CESETTINGS`, `CEADMINSETTINGS` (drafting standards).
5. **Structural drafting commands proper** (beams, columns, footings, slabs, bracing, schedules, markup reading, section details) make up the rest of the 376 and are outside this study's focus.

### 2D. Duplicates: the same job done by more than one tool

1. **Move+Rotate / Copy+Rotate:** five homes. Shared LISP (2015 file and a 2025 rewrite), LISP inside the Structural bundle (version 2.2), the Civil program (hidden), a C++ part in the Civil bundle, and the separate trial bundle (`CETESTMR`, `CETESTCR`). The Civil bundle carries the LISP copy for AutoCAD 2022 to 2026 only and the C++ part for 2027 only.
2. **Draw a drainage pipe:** `CD` in the Civil program; `CDD` in LISP (Nov 2025); an older `CD` in LISP (six copies).
3. **Construction joint and saw cut:** `CJ`/`SSC` in shared LISP (two versions), `CJ`/`SSC`/`CJSS` in Structural, `CDCJ`/`CDSC`/`CDJOINT` in Civil, and SC/CJ line blocks on a tool palette.
4. **Excel schedule into text:** `EXCELMTEXT` in four LISP versions and in Structural; a civil CSV version in LISP; the pit schedule itself in Civil (`PITSCHEDULE`).
5. **Hatches, dimensions/leaders, clean, Xref layers, copy-as-block, bored piers, divide, multilines, bracing, structural text tags:** each exists in shared LISP and again in the Structural program under the same typed names. Which one answers when a name is typed on a PC that has both loaded: Unknown.
6. **Pit, downpipe, overflow, inspection opening, floor waste, trench grate, fall symbol, spot level:** as palette blocks and as Civil commands.
7. **Pit block, pit label and pit schedule drawings:** shipped in both the Civil and the Structural bundles; the pit block file differs in size between the two.
8. **Plot style files (CTB):** the same three or four names are kept in three places (`Drafting\CTB Files`, `Drafting\Autocad Utilities`, IT folder `CTB Files`) with different dates for the same name.
9. **Checklist templates:** the same 23 files in the shared folder and in `%APPDATA%\TIM_CETOOLS`.

---

## 3. Civil tools

**Count: 145 typed names in the Civil program** at the installed version. The program's own list has 143 entries, **78 of them marked hidden** (not on the ribbon). So a drafter sees about 65 on the ribbon and can type about 80 more. The bundle's contents file tells AutoCAD about only 51 of them.

Grouped by what the drafter is doing. "(typed only)" means hidden from the ribbon.

1. **Set up a job or a drawing.**
   1. `CDNEWDWG` (typed only): pick a job folder, discipline and sheet size; copies the office template in, names it, fills the title block, opens it. AutoCAD 2027 only.
   2. `CDDISCIPLINE`: view or set whether this drawing is Civil or Structural.
   3. `CDS`: your CE defaults on this computer (drafting, pipes and pits, design checks, survey, display).
   4. `CDMANAGER`: drawing standards (layer colours, draw order, label styles).
   5. `CDPARTS`: parts and materials catalogue.
   6. `CDRULEBOOK` (typed only): project pit drop, council profile and cover override for the rule check.
   7. `CDLABELSTYLE` (typed only): old name, now inside `CDS`.
   8. `CDSURVEY`: load a surveyor's drawing and keep ground levels for cover level suggestions.
2. **Pits.**
   1. `PIT`: place a pit with type, size, cover and schedule values.
   2. `PP`: the same, pre-filled as a 350 x 350 plastic pit.
   3. `CDPIT350`, `CDPIT450`, `CDPIT600`, `CDPIT900`, `CDPIT1200` (typed only): pit size presets.
   4. `CDEDIT` (also `PITEDIT`, `PIPEEDIT`): pick a pit or pipe and open its editor.
   5. `PITDELETE` (typed only): delete a pit with its label and cover text.
   6. `CDPITCOVERFLIP` (typed only): move a pit's cover level text to another corner.
   7. `CDRENUMBER` (typed only): renumber pits from the outlet upstream.
3. **Pipes.**
   1. `CD`: draw a drainage pipe with size, flow and invert controls.
   2. `CDPIPEOBJ` (typed only): draw a pipe as one AutoCAD object. 2027 only.
   3. `CDC7UPGRADE` (typed only): turn a drawing's existing pipes into one-object pipes, with a dated copy first. 2027 only.
   4. `CDBREAK` (typed only): record a branch joining a main.
   5. `CDREVERSEFLOW` (typed only): turn a pipe around (ends, inverts, arrow, labels).
   6. `CDPIPEDIRECTION` (typed only): confirm or reverse a flow direction CE only guessed.
   7. `CDSYSTEM` (typed only): put pipes in a system (property drainage, outfall, council connection).
   8. `CDSTRIP`: 100 mm strip drain with floor wastes at corners and at 12 m centres.
   9. `CDAGI`: agricultural drain line, auto-tagged. `CDPERIMETER`: perimeter drain line, auto-tagged.
   10. `CDLPD`: legal point of discharge. `CDLPDRESET` (typed only): reset it.
   11. `CDPIPEOVERRIDE`, `CDPIPEOVERRIDECLEAR`, `PIPEPITLINK` (`LINKPIPEPIT`), `PIPEPITUNLINK` (`CLEARPIPEPITLINK`), `CDCONFIRM` (all typed only): join or un-join a pipe end to a pit by hand.
4. **Levels and falls.**
   1. `CDSL`: place and manage spot levels.
   2. `CDFALL`: place a fall symbol. `CDFALLSUGGEST`: suggest a fall arrow toward the nearest grated pit.
   3. `CDRUNSOLVE`: pick a start pit, work out inverts and grades down the run, preview, apply.
   4. `CDPROPAGATE`, `CDRECOVERINVERTS` (typed only): push or rebuild invert levels.
   5. `CDTWL`: top water level from a detention pit or tank outlet, with storage and head. Changes nothing.
5. **Sources (where water comes from).**
   1. `DP` downpipe, `IO` inspection opening, `OF` overflow, `FO` front overflow, `GIO` gross inlet block, `CDFW` floor waste, `CDTG` (old name `TG`) trench grate, `CDSOURCE` generic source, `CDRG` raingarden outline with hatch.
   2. `CDTAG`: tag, re-tag or repair source names; also registers non-standard blocks.
   3. `CDDEST`: follow the pipes and say where each downpipe ends up.
   4. `CDFIXTAGS`, `CDSOURCECHANGETYPE` (typed only): fix duplicate names; change type (parked, does nothing).
6. **Tanks.** `CDWT`: tag a water tank, ask total, detention and reuse litres, place a callout, link riser and dropper.
7. **Slabs, paving and site.**
   1. `CDSLAB`: design slab or hardstand falls; places fall symbols and spot levels.
   2. `CDSLABIMPORT`: adopt a hand-drawn slab. `CDSLABEDIT`, `CDSLABEREGEN`, `CDSLABFLOW` (typed only): edit, regenerate, show where water goes.
   3. `CDJOINT`: automatic saw-cut grid. `CDCJ`, `CDSC`: one construction joint or saw cut.
   4. `CDSPOON`: spoon drain outline inside a slab. `CDSPOONDRAIN`: spoon drain run with length and fall. `CDKERB`: kerb line.
   5. `CDPAVE`: hatch and record a paved area. `CDCATCHMENT`: show a grated pit's paved catchment as a light overlay and warn if too big.
   6. `CDTPZ`, `CDSRZ`: tree protection zone and structural root zone circles.
8. **Schedules.** `PITSCHEDULE`: review, override, compare and place the pit schedule.
9. **Details and labels.**
   1. `CDPROFILE`: long section from a picked upstream pit.
   2. `CDANNOTATIONEDIT`: move, rotate, mirror or flip one label or arrow.
   3. `CDTIDYLABELS`: slide CE labels clear of other text.
   4. `CDMA`, `CDTEXTSEG` (typed only): move a flow arrow or pipe text to another segment.
10. **Checks.**
    1. `CDCHECK`: list every connection the drawing can prove and those it cannot; jump to any.
    2. `CDCHECKCURRENT`: show what CE can read in the open drawing. Changes nothing.
    3. `CDDASHBOARD`: design-check dashboard. `CDHUB`: read-only network health hub.
    4. `CDRULES` (typed only): check against the engineering rulebook (velocity, grade, cover, pit drop).
    5. `CDCHECKS`, `CDCHECKIGNORE`, `CDCHECKIGNOREAPPLY` (typed only, "not switched on yet"): the new single checks list.
    6. `CDINSPECTOR`: the Inspector side palette. `CDFOCUS`, `CEFIND` (typed only): zoom to and highlight a pit, pipe or source.
11. **Calculations and design.**
    1. `CDCALC`: the drainage calculations suite (also makes the computations sheet as PDF or Excel).
    2. `CDDESIGN` (old name `CDSETUP`): review design inputs and work out the design. Nothing is drawn.
    3. `CDRAINFALL`: show or record the job's rainfall.
12. **Import and export.**
    1. `CDIMPORTXCIVIL`, `CDIMPORTLANDXML`: bring in another civil package's drawing or a LandXML file, with a review first.
    2. `CDIMPORTCOMPARE`: compare imported data with the drawing. `CDCHECKDWG`: read-only check of a consultant's drawing.
    3. `CDEXPORTENTITIES`: export geometry and schedule references. `CDEXPORTCORPUS` (typed only): developer export.
    4. `CDXREFCOMPARE`, `CDXREFREPAIR` (typed only): compare a changed background; repair broken Xref paths.
13. **Issue (plot, transmit, revise).** **No civil command for issuing was found.** The only plot-to-PDF command found is in Structural (`STRUCEXPORTPDF`).
14. **Repair and upgrade (20, almost all typed only).** `CDREPAIR` (the repair centre, on the ribbon), `CDSYNC`, `CDREBUILD`, `CDREBUILDLINKS`, `CDLINKDANGLINGPIPES`, `CDFIXPIPEENDS`, `CDFIXFLATPIPES`, `CDUPGRADE`, `CDSPINEUPGRADE`, `CDREFRESHBLOCKS`, `CDREFRESHLINKS`, `CDAUDIT`, `CDAUDITDETAIL`, `CDGRAPH`, `CDIMPORTAUDIT`, `CDLEGACYAUDIT`, `CDSTARTUPAUDIT`, `CDTRENCHGRATEAUDIT`, `CDTRIAGE`, `CDDEBUG`.
15. **Help and feedback.** `CDHELP` (help centre), `CESTARTHERE` (2-minute picture tour), `CDFEEDBACK` (bug report), `CDDIAG` (count pits and pipes), `CEASK` / `CDASK` (ask a question about the drawing), `CDMENU` (typed only).
16. **General helpers carried inside Civil (typed only).** `MR`, `MOVEROT`, `CR`, `COPYROT`, `COPYMULTI`.
17. **Internal or fault-finding (typed only, not staff tools).** `CDGRIPROUTE`, `CDGRIPDIAG`, `CEPERFDIAG`, `CETRUSTREAD`, `CDPIPEATTACHMENTACTION`, `CDUSEPLANLABEL`, `CDCLOSETAB`, `CE_TEST_RUN`.

**The civil ribbon as coded (single "CE" tab).** Panels: CE (Ask CE, Help Centre, Civil/Structural switch), Draw (Pipe, Pit gallery, Water Tank, Spot Level, Fall, Suggest Fall), Sources (Downpipe, Inspection Opening, Overflow, Front Overflow, "More sources" drop-down), Edit (Edit, Repair & Upgrade, Edit Annotation, Tidy labels), Design (Design setup, Rainfall, Legal point of discharge), Review (Project Review, Checks, Check Current Drawing, Pit Schedule, Calculations...), Site (Slab System, Spoon Drain, Pavement Area, Catchment Overlay, Kerb, Spoon Drain Run, Joints, Tree Zones), Import (Survey, Consultant DWG, Compare; Export), Settings (Settings, Layer Standards, Parts Catalogue, Feedback, Data Diagnostics).

A second, different ribbon layout list ships in the same bundle as a data file, with panels named Layout, Design, Sources, Review, Edit, Settings, Import/Export, Admin. It is read by a menu/toolbar builder in the program. What the drafter actually sees on screen was not checked (AutoCAD was not touched).

**Civil settings.** The settings model has **577 separate settings in 49 groups; 250 of them are on/off switches.** Main groups: pipes, pits, inverts, grades, cover, water tanks, pavement, surface drainage, detention, pump station, long section, design standards, layer names, layer colours, layer checks, concrete joints, survey, drafting checks, checks, pit schedule and Excel, calculation export, import, markup, object snaps, right-click, window feel and placement, start-up, auto-save, command short names, onboarding, job time, job checklist, privacy, AI, install. The saved settings file on this PC has about 400 entries. A small "colleague starting settings" file in the bundle sets 9 values on a PC that has no settings file yet; its own note says it is a draft waiting for the principal's answer.

---

## 4. The Manager

**What it is for (in its own words):** "Management hub for all CE Suite plugins. Handles installation, updates, health checks, diagnostics, and admin." It is meant to be on every PC that has any CE plug-in.

**What a colleague sees.**

1. **The CE Tools ribbon tab** (section 2C, item 1).
2. **The CE Suite Manager window** (`CEMANAGER`). Title line: "Suite Manager · Status, modules and updates". Pages: **Status**, **Updates**, **Settings**, **Help**, **Project / Sheets**, **Project QA**, **Survey Intake**, **Drawing Repair**. It lists each CE module as Installed / Running / Starts next time, with buttons Refresh, Load Now, View Commands, View History, What's ready, Review update, Get update ready, Older versions, Open Help, Open Hub, Open Repair, Send a fault report, Send waiting reports. The update page shows three steps: "1 · Approved", "2 · Copied, waiting", "3 · Install", then "Close AutoCAD" and "Then run the CE installer".
3. **The Admin Dashboard window** (`CEMANAGERADMIN`), only for a Windows login listed as a CE administrator. Tabs: Overview, Usage, Machines, Failures, Updates, Policies, Support Bundles. Buttons: Approve Available Build, Canary Rollout, Promote to All, Roll Back Approved Release, Create Support Bundle, Upload Pending, Set up CE administrator, "Who is this?".
4. **The Version window** (`CE_VERSION`): the exact loaded Civil, Structural and Manager versions.
5. **The CE Blocks palette** (`CEBLOCKS`).

**Its 12 typed commands.**

1. `CEMANAGER`: open the Manager window.
2. `CEMANAGERREFRESH`: re-check what is installed, send waiting usage reports, rebuild the ribbon.
3. `CEMANAGERUPDATES`: open the Updates page.
4. `CEMANAGERADMIN`: open the Admin Dashboard (refused with a plain message if not an administrator).
5. `CEMANAGERDIAG`: write a plain-English diagnostic report.
6. `CEMANAGERLOGS`: open the logs folder.
7. `CEHEALTH`: print a health check on the command line: each module present and running, the Manager, whether Civil's and Manager's shared library copies match, duplicate bundles, and whether the office IT folder can be reached.
8. `CESUPPORT`: zip logs and diagnostics on this PC.
9. `CE_VERSION`: the version window.
10. `CESURVEYREVIEW`: open the Manager at a survey just brought in by `CDSURVEY`.
11. `CEBLOCKS`: the blocks palette.
12. `CEBLOCKINSERT`: used by the palette; typing it does nothing.

**What it does behind the scenes.** Reads the office IT folder for newer builds; records which build is approved; copies an approved build to a waiting area on the PC; writes usage counts, machine records and failure records to the office IT folder (`CE Plugin Admin`: usage, machines, failures, policies, releases, support bundles; 9 machine entries exist there today); rebuilds the CE ribbon tabs whenever status changes; keeps its own menu file in `%APPDATA%\CE_CADTOOLS`.

**What it cannot do (by its own design note):** "it cannot publish, activate or replace a loaded bundle". It gets an update ready; a separate installer program finishes it.

---

## 5. How it gets onto a colleague's PC today

There is **not one route**. Four were found: three older ones that are still sitting in the office folders, and one current design. Evidence that the current design has completed end to end on a colleague's PC was not found.

### 5A. The route as designed today ("signed release, Manager prepares, installer finishes")

1. **A version is made.** On the principal's PC the three programs are built, each in three lanes. Rules written in the repository: every build must carry a "do not touch the live bundle" switch, because building one lane without it overwrites the live Civil bundle on that PC (this happened on 3 Jul 2026 one minute before a field test).
2. **A prepared bundle is assembled** for each module in a folder outside AutoCAD's plug-in folders. Civil's and Manager's copies of the shared library must be identical byte for byte in every lane; this is checked by hand-run steps.
3. **Four evidence files are required:** Build, Automated Tests, Command Truth, Release Safety.
4. **Pre-flight.** A "release authority" program checks the prepared bundle, the clean source and an approval file, and answers READY or NOT READY.
5. **Minting (signing).** The same program makes a new package folder holding the bundle, a release record, a signature file and a summary. The signing key is held in the principal's Windows login and cannot be exported. Only that login can sign.
6. **Publishing.** The package is placed in the office IT folder, a SharePoint library synced by OneDrive as `Creative Engineering - IT Admin`. The Manager searches that folder, four folders deep, for any bundle and treats the highest version number of each module as "available".
7. **Approval.** In the Admin Dashboard an administrator presses Approve Available Build. Options: Canary Rollout (named pilot PCs first), Promote to All, Roll Back.
8. **On the colleague's PC, OneDrive must have synced the IT folder.** If not, the Manager says so and asks them to sync it and press Refresh.
9. **The colleague opens the Manager, Updates page, and presses "Get update ready".** The Manager re-checks the signature and every file, then copies the build to a waiting area on the PC (not into AutoCAD's folder). Status becomes "Copied, waiting".
10. **The colleague closes every AutoCAD window.**
11. **The CE installer program is run.** It asks Windows for **administrator rights** (its own settings file says "require administrator"). The Manager's own wording for a colleague is "ask your CE administrator to finish the install". The installer re-checks that AutoCAD and its console are closed, re-checks the signature and file hashes, keeps the whole old bundle for roll-back, swaps the whole folder, and puts the old one back if the swap cannot finish. It writes a record of the attempt.
12. **The colleague reopens AutoCAD.** AutoCAD's own plug-in loader reads each bundle's contents file, picks the lane that matches the AutoCAD year, and loads what that lane lists for start-up. The programs then build the ribbon.
13. **Version checks after start.** The Manager shows installed, available and waiting versions; `CEHEALTH` checks the shared library copies match.

**What needs AutoCAD closed:** step 11 (any swap of bundle files). **What needs administrator rights:** the installer in step 11; being a "CE administrator" for approval in step 7 is a separate list kept in the IT folder. **What does not:** steps 8 to 10.

**When it fails (as written in the program's messages):**

1. OneDrive not synced: "CE cannot find the update files in the office IT folder. OneDrive may not have finished syncing."
2. Signature, hash, file count or version does not match: refused, nothing changed ("fails closed").
3. AutoCAD still open: the installer refuses.
4. Installer not on the PC: "The CE installer was not found on this PC... Ask your CE administrator."
5. Swap cannot finish: the old bundle is restored.
6. A module loads but its commands are missing, or its program file is missing: `CEHEALTH` says restart AutoCAD or run the installer again.

**How many separate things must agree for a colleague to end up working (counted from the steps above):** at least 12. (1) three lanes built from one source point, (2) the shared library identical in Civil and Manager, (3) four evidence files, (4) the approval file, (5) the signing key in the principal's login, (6) the signature and record, (7) OneDrive sync on the principal's PC, (8) OneDrive sync on the colleague's PC, (9) the administrator's approval and pilot list, (10) the waiting copy matching the approval, (11) AutoCAD closed plus administrator rights for the installer, (12) the bundle contents file choosing the right lane for that AutoCAD year. For AutoCAD 2027 add the three C++ parts, which are tied to that one AutoCAD year.

### 5B. What is actually in the office IT folder today

1. **`CE V3 PILOT`** (4 Nov 2026): three plain bundles (Civil 3.0.89, Structural 1.0.125, Manager 1.1.89) and one file listing a checksum for every file. **No signature file or release record is in this folder**, so it is not in the "minted package" shape of 5A. The folder name is not mentioned anywhere in the program source. How a colleague is meant to use it: Unknown.
2. **`CE SUITE MANAGER\1.0.6-...-Tim-Test`** (25 Aug 2026): the only folder found in the signed shape (bundle, release record, signature, summary). Beside it is a half-made folder starting `.preparing-`.
3. **`CE CVL SUITE`**: a Civil bundle at version 2.1.14 (July), an installer program dated May, a version 2.0.0 package with a readme, and an install script.
4. **`CE STR SUITE`**: a Structural bundle at 1.0.41 (August), an installer program dated June, an install script, a release-history folder.
5. **`CE SUITE MANAGER`**: a Manager bundle at 1.0.0 (July), an installer program dated May, an install script and an "apply update" script.
6. **Top level:** a Civil installer named for version 2.1.11 (June) and a script "Install-All-CE-Plugins".
7. **`Software\CE CVL SUITE`**: a Civil bundle at 2.0.0 with a payload zip, an installer, a readme and several "update available" notes from March and April.
8. **`CE Plugin Admin\releases`**: folders for Civil and Structural dated April.

So the newest Civil in the IT folder is 3.0.89; this PC runs 3.0.90.13. The newest Structural there is 1.0.125; this PC runs 1.0.126.1. Manager matches at 1.1.89.

### 5C. The older routes, still on the shelves

1. **Single installer program (version 2.0, May 2026).** The readme tells each colleague: close AutoCAD, double-click the installer, click Yes on the Windows administrator prompt, wait 30 seconds, reopen AutoCAD. It copied the bundle to the per-user plug-in folder, set an AutoCAD security setting in the Windows registry for every AutoCAD year, created a **daily 6 am update task** and a log-on task, and installed Microsoft's web-view component. It was sent by e-mail or link. In today's source this whole method is switched off ("retired the legacy delete/overwrite installer").
2. **Payload zip beside the installer (early 2026).** Its readme: "On AutoCAD start, the plugin checks this folder for a newer payload.zip. If a newer version exists, it updates automatically."
3. **"Install-All-CE-Plugins" script (April 2026).** Right-click, run, accept the administrator prompt; copies all three bundles to the **all-users** folder (`C:\ProgramData`), and says the Manager "keeps all plugins up to date automatically on AutoCAD startup". A later note in the installer source says colleagues' PCs with AutoCAD 2027 were not picking the plug-in up from that all-users folder, which is why the per-user folder is used now.
4. **The first Structural installer (March 2026)**, kept with its build outputs in the shared drafting folder `CE STR SUITE\Installer`: installs to the all-users folder and creates the daily and log-on update tasks. Its payload is Structural version 0.1.0 with 22 LISP files.

### 5D. How this PC is actually updated

Not by 5A. The 119 dated backup folders (section 1) show the live bundles being replaced directly and often, with the old one renamed beside it. The script or tool that does this was not in the places this study was allowed to read: Unknown.

---

## 6. How it is put together today

1. **Modules that load into AutoCAD 2027 on this PC.** Three office bundles in use (Civil, Structural, Manager) and two leftover test bundles.
2. **Program files.** Civil: 3 office-written .NET program files + 21 third-party + 3 C++ parts. Structural: 2 office-written + 19 third-party + 1 C++ part. Manager: 3 office-written. That is **8 office-written .NET program files** (two of them the same shared library shipped twice), **4 C++ parts**, about 40 third-party libraries, per lane. Across all three lanes the three bundles hold 169 program files.
3. **Languages.** C# for almost everything (Civil about 1,570 source files and 68 window layouts; Structural about 680 source files; Manager about 100). C++ for five parts: pipe grips, the pipe object enabler for 2027, an enabler project for 2024 (project file only; the notes say no enabler exists for 2022 to 2024 today), Copy/Move+Rotate, and the structural background reader. LISP: two small files shipped in bundles; 181 loose files in the shared folder.
4. **AutoCAD years built for.** Three lanes: 2022 to 2024, 2025 to 2026, 2027. All C++ parts are 2027 only. Several civil commands say "AutoCAD 2027 only".
5. **The repository.** One repository holding all modules ("monorepo"), 27 projects in the solution, 11 of them not tests. Its checked-out main line is from 28 Sep 2026 and is far behind what is installed; the installed versions come from other branches. The repository also has projects that are not present as separate program files in any bundle found (`CE.Host`, `CE.Cloud`, `CE.Spine`, `CE.AI.Harness`).
6. **What is stored inside the drawing (Civil).** Named record stores in the drawing's own dictionary: project data, pipe-to-pit links, permanent identities for pits and pipes ("spine"), slabs, survey levels, legal point of discharge, discipline, multi-plan, repair quarantine, and the next source-tag number. Extra data is also attached to individual objects (68 source files deal with it). Pits, labels and sources are ordinary blocks and text. Pipes are ordinary polylines and multilines, or, when the one-object switch is used on 2027, a CE pipe object.
7. **What is stored outside the drawing.** Settings, recent values, parts catalogue, label styles and theme per user (section 1); auto-save backups; logs and check reports named after the drawing; suggestion and usage records; office-wide usage, machine and failure records in the IT folder; time logs and weekly reports in the shared drafting folder (`TIM_CETOOLS`, `CE_CVL_SUITE`, `CE_STRUC_SUITE` sub-folders hold only time logs, weekly reports and checklist templates, no program).
8. **A drawing opened on a PC without the plug-in (as documented).**
   1. Ordinary CE drawings (pipes as polylines, pits as blocks): everything shows and plots as normal AutoCAD objects. The older design notes state this as a rule.
   2. Drawings with one-object pipes: a PC with the enabler part but no ribbon "sees and can move the pipe". A PC with nothing installed "sees the saved proxy graphics only (walls and band) and cannot edit the pipe". "There is no enabler for AutoCAD 2022 to 2024 today."
   3. Whether the data stores survive an edit-and-save on a PC without the plug-in: Unknown (not documented in what was read).
9. **Structural settings.** About 800 entries in its settings file. Structural settings windows were not studied.

---

## 7. Facts that look like sources of fragility or confusion

Observed facts only.

1. **Three generations of the same helpers are live at once:** loose LISP, tool palettes, and plug-in commands, with many identical typed names (section 2D).
2. **486 LISP typed names, 330 of them only in superseded copies**; the same LISP file exists up to six times in differently named folders.
3. **Very large command counts:** 145 Civil + 376 Structural + 12 Manager = 533 typed names from the plug-ins alone. 78 of Civil's 143 listed commands are hidden; 20 are repair or audit commands.
4. **Very large setting counts:** 577 civil settings (250 on/off), about 800 structural entries.
5. **General drafting helpers live inside the Structural program** (pens, hatches, dimensions, clean, Xref layers). A civil-only PC does not get them from the plug-ins.
6. **Move+Rotate / Copy+Rotate exists in five places**, including a separate trial bundle still installed on this PC.
7. **At least four install routes** have been used in eight months (e-mailed installer with a 6 am task, payload zip check at start-up, run-as-administrator script to the all-users folder, signed release with Manager and installer). Files for all four are still in the office IT folder.
8. **Two plug-in folders have been used** (all-users and per-user). An old Manager still sits in the all-users folder on this PC, switched off by renaming one file.
9. **The office IT folder holds seven different Civil builds or installers** (2.0.0, 2.1.11, 2.1.14, 3.0.89 and others), and the Manager picks "newest version number found anywhere four folders deep".
10. **The one folder named for the pilot has no signature**, while the design says only signed packages may be installed.
11. **Version mismatches on this PC:** the Civil bundle's main program and its two companion libraries come from different source dates; "what's new" says 3.0.1 against 3.0.90.13; the IT folder is one step behind this PC for Civil and Structural; the installed Civil is marked in its own source note as not for colleagues.
12. **The bundle contents files under-report commands:** 51 of 145 (Civil), 36 of 376 (Structural). The Manager's own notes say "8 commands"; it has 12.
13. **Two different ribbon layouts for Civil ship in one bundle** (one in the program, one as a data file) with different panel names.
14. **The same shared library is shipped twice** (in Civil and in Manager) and must be identical; the first one AutoCAD loads wins. There is a health check just for this.
15. **Finishing an update needs administrator rights and AutoCAD closed**, and the Manager tells a colleague to ask an administrator.
16. **Only one Windows login can sign a release.** The notes say losing that key needs a planned key change.
17. **Everything depends on OneDrive having synced** a SharePoint library on both PCs.
18. **Settings and logs are spread over at least seven folders** under two different roots, with two civil settings files, two structural settings files (36 KB and 352 KB, different folders, different dates) and two admin folders.
19. **Working files are large:** 10.2 GB of old bundle backups inside AutoCAD's plug-in folder, 2.0 GB + 1.0 GB of auto-save backups, about 3 GB of old release and staging folders.
20. **All C++ parts are for AutoCAD 2027 only**, while the bundles still carry full copies for 2022 to 2026 (two thirds of each bundle's size).
21. **A drawing with one-object pipes cannot be edited on a PC with nothing installed**, and there is no enabler for 2022 to 2024.
22. **Two leftover test bundles load on this PC** (one at every start-up).
23. **Staff names appear** in a comment at the top of two bundle contents files and in several file and folder names in the shared and IT folders. **Client and job names appear** as hundreds of log file names in the repository's working folder (not tracked by the repository) and in log names under `%APPDATA%`.
24. **No civil "issue" command exists**; the long list is weighted to drawing, checking and repair.
25. **Tool palettes exist in three sets** (17 current, 12 "NEW", 43 old), and two of the "NEW" civil palettes are identical.

---

## 8. Unknown / could not determine

1. **What a colleague's PC has today.** Only this PC was read. The IT folder has 9 machine records but they were not opened.
2. **Whether any colleague has been updated by the signed route (5A)** from start to finish. No record of it was found in what was read.
3. **How `CE V3 PILOT` is meant to be used**, and by whom.
4. **How this PC's bundles are replaced day to day** (the tool that makes the dated backups).
5. **How the loose LISP files and tool palettes are loaded on each colleague's PC**, and which colleagues still use them.
6. **Which tool answers** when a typed name exists in both a loaded LISP file and a plug-in.
7. **How `CE_TRANSFORM_2027.arx` is loaded**, since the bundle's start-up list does not name it.
8. **What the ribbon and windows really look like on screen today.** AutoCAD was not touched; ribbon facts are from files and source.
9. **Whether the old menu file `TB2024.MNU` and the bought-in structural toolkit are still in use.**
10. **Whether CE data inside a drawing survives editing and saving on a PC without the plug-in.**
11. **Exact count of structural settings a user can change** (only the size of the settings file was read).
12. **Cloud-only files were not opened** (to avoid downloading them), including the Structural installer build script and some documents in `Autocad Utilities`.
13. **The Windows registry was not read**, so trusted-folder and security settings for plug-in loading are unknown.
14. **The old plan repository was not read** (by instruction), so any plan-level decisions about install routes are not reflected here.
