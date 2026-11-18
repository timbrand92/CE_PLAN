# Easy and AutoCAD-like: an evidence-based proposal (revision 1)

**Asked by:** Tim, 18 Nov 2026 (D-230): "now you have this all understood, what is the best and easiest way to make the plugin for an end user experience that is easy and autocad like in how it can used ... also use old projects data and evidence to form your decisions."
**Status:** proposal, DRAFT for Tim. Nothing here is decided or built. Where it departs from a live ruling it says so with the figures.
**Made:** 18 Nov 2026 (Melbourne), read-only. Old-job drawings read as DXF text with small throwaway scripts in `C:\CE_WORK\scratch\ux_evidence\`; AutoCAD was not started; nothing installed; the office Projects folder was not opened. Job codes JOB-A to JOB-F are this study's own and are NOT the JOB_A to JOB_C of STUDY_A.

---

## The short answer for Tim

1. **Keep your window, but make "same again" cost nothing.** Type the short name, the window opens filled in (your D-060), Enter accepts, then click, click, click, Enter to finish (your D-186, used for every placing tool, not only downpipes). Change something afterwards by Properties, a grip or a double-click.
2. **Three figures that matter most:**
   1. **73 in every 100 placements repeated the settings of the one before** (258 of 354, in drawing order, 6 jobs). Downpipes 78 of 78.
   2. **Edits matched placements in the old plug-in:** 207 edit runs against 200 placing runs (CD and PIT). People go back to things as often as they place them, so editing must be as cheap as placing.
   3. **Downpipe, inspection opening and trench grate commands ran 2 times each**, while the six jobs hold 77 downpipes, 31 inspection openings and 12 trench grates. They were placed from the palette and with COPY. Plain AutoCAD ways of placing must give a full CE object.
3. **Clicks barely move; interruptions do.** A two-unit job takes about 82 clicks and keys with 16 full-screen windows as designed now, and about 71 with 5 windows the lean way. The window-every-time ruling is cheap in clicks. Its cost is 11 windows that only ask you to confirm what is already right.
4. **Eight questions are at section H.** The first one matters most. On a PC with the ribbon showing, AutoCAD's own HATCH shows the ribbon tab, not the window, unless the window has been switched on. Which "like Hatch" did you mean?

---

## Half 1: the evidence

### 1. What was read, and how far to trust it

1. **Old-job drawings:** 218 DXF files sit in the read-only evidence copies of 21 old jobs. **Only 6 of the 21 jobs hold office civil drainage drawings** (stormwater pipe layer, pit blocks, pit schedule); the other 15 are structural or architectural only. Read for this study: 9 drawings from those 6 jobs (6 sheet drawings, 3 drainage drawings attached to them as Xrefs). Exact copies were counted once. One received consultant drainage drawing (not office work) was read for its units only.
2. **Only what the sheet shows was counted.** Each sheet's layout viewports were used to find the part of model space that is printed. Parked samples outside the frame were left out (the template carries one of every tank, inlet and note). The drainage Xref drawings have no sheet, so everything in them was counted.
3. **Old plug-in use:** objects carrying the old plug-in's links were found in 4 of the 6 jobs (JOB-B to JOB-E). JOB-A and JOB-F were drawn by hand with the blocks.
4. **Reliability words used below:** **high** = read straight off the drawing (block name, layer, text, polyline width); **medium** = worked out from geometry (pipes meeting at a pit, label side); **low** = an estimate or an inference. Six jobs is a small sample: the office's mix of jobs is unknown beyond it.
5. **Not readable from DXF:** who drew it, how long it took, the order of actions within a session (only creation order, from object handles), whether a value was typed or copied, and the cover-level reasoning (D-178).

### 2. What a drainage sheet holds (6 jobs)

1. **Pits:** 52 in total, per job 5, 5, 7, 9, 11 and 15; **median 8.** High.
2. **Downpipes:** 77, per job 5, 8, 8, 11, 17 and 28; median about 10. On one hand-drawn job the same block shows "IO" 6 times and "O/F" once; those were counted as inlets of those kinds. High.
3. **Other inlets:** inspection openings 31 (on 6 of 6 jobs), floor wastes 46 (34 of them in one basement), overflows 19 (3 jobs), trench grates 12 (5 jobs), from above or to below 12 (1 job). High.
4. **Pipes:** 236 pipe polylines on the stormwater pipe layers, per job 19 to 89; median about 30. A "piece" is one polyline: a pit-to-pit run, a downpipe stub or a branch. Kinds: gravity 184, suspended 45, charged 7 (some charged pipes are drawn by other means), rising main 2. High.
5. **Pipe labels:** 57 (one per main run; stubs to downpipes are not labelled). High.
6. **Tanks:** on 4 of 6 jobs. One job has a 2,000 litre tank per dwelling, numbered WT4 to WT12. Another note reads "2000 LITRE WATER TANK ... TYPICAL". The others are 5,000 L slimline, 2 x 5,500 L underground and 15,000 L underground for detention. High.
7. **Detention:** a criteria box ("ON SITE DETENTION CRITERIA") on 3 of 6 jobs. Detention pipes on 1 job, 7 runs of 375 and 450 Stormpro. High.
8. **Outlets:** one per site on 4 jobs. Two on 2 jobs: two kerb connections on one, and a gravity system plus a basement pump system on the other. Each outlet is written as a note ("CONNECT TO KERB & CHANNEL AT APPROX IL ..." or "CONNECT TO EXISTING COUNCIL PIT AT APPROX IL ..."). The legal point of discharge is marked "LPD" on 2 jobs. High. Pit-and-pipe groups found by joining geometry agree on JOB-A (6 pits and 5 pits): medium.
9. **Always on the sheet:** pit schedule 6 of 6; the pit detail block and the pipe bedding detail 6 of 6; saw cut detail and slab on ground detail 5 of 6; disclaimer 4 of 6; before-you-dig block 4 of 6; fall arrows 5 of 6 (2 to 46 each); spot level tags on 3 jobs (up to 98). A legend could only be seen inside the viewports on 2 jobs (it may sit on another layout: low). High except the legend.

### 3. Pits: kinds and sizes actually used

1. **Kind (from the visible parts of the block):** grated **47 of 52 (90%)**, solid or junction 4, pump pit 1. High.
2. **Size (inside size, read from the block's visible wipeout):**
   1. 350 x 350: 22 (42%). 9 of these are on one older hand-drawn job whose block reads 300 inside; they are taken to be the 350 state. Medium for those 9.
   2. 450 x 450: 8 (15%).
   3. 600 x 600: 6.
   4. 600 x 900 (either way round): 6.
   5. 900 x 900: 8, all on one larger job.
   6. Twin-chamber orifice pits: 2 (1350 x 600 and 1950 x 900).
3. **The schedule agrees** where it was filled in (5 jobs). On one job 7 of 8 rows read "900 x 900 / Class C Grated Lid With Step Irons". Plastic 350 pits do not appear in the schedules, which matches D-076's tick box. High.
4. **Lids written in the schedule:** Class C 10 (7 on one job), Class D 4, Class A 3; "heel safe" on 4 rows of one job. The lid class goes by job, not by pit. High.
5. **Blocks:** the 16-state "Stormwater Pit" on 3 jobs; "PIT BLOCK" on 2; "PIT BLOCK 3" on 1 job (all 9 pits). High.
6. **Pit tags:** "P1" upward; existing council pits tagged X1, X01 or C1; tag text 350 high on 35TEXT. High.

### 4. Pipes: sizes, materials, grades, shapes

1. **Size, from the width of the pipe polyline (width = nominal size on all 236):** 100 on **152 (64%)**, 150 on 69 (29%), 225 on 7, 375 on 3, 450 on 5. High.
2. **Size on labels:** 100 on 24, 150 on 20, 225 on 5, 375 on 2, 450 on 5. High.
3. **Material on labels:** "UPVC" on every 100 label. For 150 below ground, "UPVC SN8" on about 9 of 11 (about 8 in 10). Suspended pipes are "UPVC SUSPENDED". Detention pipes are "STORMPRO". In basements, "SEWER CLASS" is used for 100. High.
4. **Grade:** **1 in 100 on 42 of 47 graded gravity and suspended labels (89%).** The other five read 1 in 13, 1 in 54, 1 in 60, 1 in 173 and 1 in 187. Every detention pipe has its own grade, 1 in 159 to 1 in 193 (7 of 7). High.
5. **"MIN." after the grade:** on 21 of the 42 (50%). Some jobs use it on every label and some never do. High. **This is a real wording choice (question H2).**
6. **Detention label wording:** "450 DIA. STORMPRO PIPE AT 1 IN 190 15.24m DETENTION" on 7 of 7, with the length to 2 decimals and the word DETENTION. High.
7. **Bends:** 33 of 184 gravity pieces have bends (18%); 61 of 236 pieces of every kind (26%). Suspended pipes bend most. High.
8. **Lengths of gravity pieces:** median 3.35 m; a quarter under 0.8 m (downpipe stubs); a quarter over 9.7 m. High.
9. **Branches:** 69 pipe ends land part-way along another pipe with no pit, on 5 of 6 jobs (a downpipe stub joining a main run). Medium.
10. **Pipes meeting at a pit (pipe ends within reach of the pit):** 1 pipe at 13 pits, 2 at 9, 3 at 12, 4 at 11, 5 or more at 5. **28 of 52 pits (54%) take 3 or more pipes.** Medium.

### 5. Levels and text

1. **Cover levels:** 59 "CL" texts for 52 pits, so about one per pit. Every one is a number to 2 decimals; none is left blank on an issued sheet. Text 200 or 180 high, turned about 45 degrees. High.
2. **Invert levels:** 148 "IL" texts, **about 2.8 per pit** (one at each pipe end), all to 2 decimals, 180 high on 18TEXT or 20TEXT. High.
3. **Pipe label text:** 250 high on 25TEXT on 56 of 57 (98%). High.
4. **Label side:** above the pipe (reading left to right) on 37 of 48 measured (77%). On the 5 jobs that place it the same way, it is 33 of 38 (87%). Medium.
5. **Label distance:** on 26 of 48 labels the text's anchor sits exactly the pipe's half-width plus 125 from the centreline (175 for a 100 pipe, 200 for 150, 350 for 450). All 26 are on old plug-in jobs. On the hand-drawn job the anchor sits on or near the pipe line (a different text anchor; low). High for the 26.
6. **Downpipe tags:** "DP" on 70 of 77; never numbered (DP1, DP2) on any of the 6 jobs. Roof areas per downpipe appear on **0 of 6** sheets. High.
7. **Flow arrows:** on every old plug-in job (14 to 47 per job). High.

### 6. Drawing set-up

1. **Units:** millimetres on **6 of 6** office jobs ($INSUNITS 4). The only drawing in metres ($INSUNITS 6, DIMSCALE 0.1, LTSCALE 1) is the received consultant drawing. So D-217 (metre drawings must work) is real, but on this evidence it mostly concerns drawings that come in from others. High.
2. **Scales:** DIMSCALE 100 on every job that sets it (5 of 5); LTSCALE 1000 on 6 of 6; all 13 printing viewports at 1:100. High. This matches D-194 and D-227.
3. **Model and layouts:** drawn full size in model space, sheets in layouts (C01, C02, C03) on 6 of 6. High.

### 7. Repeats: how often the next placement used the same settings

Objects were put in creation order (by their handle) and each was compared with the one before it of the same kind. Medium: handles follow creation order, but the old plug-in remade some objects.

1. **Pits** (size and grated or solid): 25 of 46 (54%) repeat the pit before.
2. **Pipes** (layer and size): 155 of 230 (67%).
3. **Downpipes:** 78 of 78 (100%).
4. **All together: 258 of 354 (73%).**
5. **Grouped by job** (if each kind is placed together): pits 32 of 52 (62%) and pipe pieces 211 of 236 (89%) could reuse an earlier setting. On labels (size, material and grade), 29 of 56 (52%).

### 8. What the reference library says, checked against these counts

1. **Agrees:** label 250 high, IL 180, pit tag 350 (`standards\text_heights.csv`, `label_offsets.csv`); labels "above on 36 and below on 23 of 59" in STUDY_A, against 37 of 48 here (both say above is commoner, and this study finds it more so); 1 in 100 as the start grade (D-143); 100 as the start size (D-174); the three-sheet schedule wording (D-113).
2. **Adds:** STUDY_A said "no fixed side" for labels. On old plug-in jobs the side and distance were fixed: half-width plus 125. STUDY_A read 3 jobs; this reads 6.
3. **Corrects nothing in the rulings.** Two built drafts are out of step with the evidence:
   1. The built Pipe tool's draft "two ends only, no bends" (`C:\CE_CIVIL\acad\DESIGN_PIPE_TOOL.md`) does not match D-189 or the 18% bent pieces.
   2. The built Pit tool places one pit per run, where 54% of pits repeat the pit before.

### 9. Usage records of the old plug-in (TOOLS_TODAY T-055; April to November 2026, 2 PCs)

1. **Placing:** CD 155 runs (median 20.7 s; 14 not completed), PIT 45 (median 28.6 s; 8 not completed), PITSCHEDULE 39 (median 21.6 s).
2. **Editing:** PITEDIT 74, CDEDIT 67, PIPEEDIT 66: **207 edits against 200 placing runs.**
3. **Inlets by command:** DP 2, IO 2, TG 2. The palette and copy-paste did that work.
4. **Old shortcuts that show what was wanted:** PP was "pre-filled as a 350 x 350 plastic pit"; CDPIT350 to CDPIT1200 were size presets. The office wanted the common pit in one go.
5. **Limit:** only commands the plug-ins wrap are recorded. Plain AutoCAD commands and palette drags are not.

### 10. What kept going wrong for real users (R-007: 597 recurring faults; OBSTACLE_COURSE)

1. **Plain words, honest closing line:** about 53 faults.
2. **One value, one place:** about 46.
3. **Units and scale:** about 44.
4. **AutoCAD's own protections (locked layers, Xrefs):** about 35.
5. **Labels clear and kept where put:** about 28.
6. **Unknown stays unknown:** about 26.
7. **Undo and Cancel change nothing:** about 25.
8. **Move, copy, mirror keep parts together:** about 22.
9. **Typed values never overwritten:** about 21.

The lesson for ease of use: most faults were plain AutoCAD actions (copy, undo, move, a locked layer) not behaving as a drafter expects. Something that feels AutoCAD-like is mostly something that behaves AutoCAD-like under plain commands.

### 11. How AutoCAD itself does it (sources named; anything not read on a page is marked UNVERIFIED)

1. **Prompts:** options are shown in square brackets; you type the capital letter; the current value is shown in angle brackets and Enter keeps it ("POLYGON Enter number of sides <4>:"). Source: About Entering Commands in the Command Window, AutoCAD LT 2026 help, Autodesk.
2. **Enter repeats:** "You can also repeat the previous command by pressing Enter or the spacebar." Dynamic Input shows the prompt at the cursor. Source: AutoCAD 2027 Foundations, "Start Working with Commands", Autodesk help.
3. **HATCH and its window:** HPDLGMODE starts at 2: "Hatch and Gradient dialog box is not displayed for HATCH and GRADIENT when the ribbon is active"; at 1 the dialog shows every time; at 0 only when Settings is typed. Source: HPDLGMODE (System Variable), AutoCAD LT 2022 help, Autodesk. Not re-read for 2027.
4. **What shows instead:** the Hatch Creation tab has six panels in work order: Boundaries, Pattern, Properties, Origin, Options, Close. "You can also press Enter or Esc to exit HATCH." Source: Hatch Creation Ribbon Contextual Tab, AutoCAD LT 2026 help, Autodesk.
5. **Noun-verb:** PICKFIRST "Determines whether you can select objects before starting a command"; SELECTSIMILAR "Adds all objects in the drawing that match the properties of the selected objects", governed by SELECTSIMILARMODE. Source: Commands for Selecting Objects, AutoCAD LT 2023 help, Autodesk.
6. **ADDSELECTED:** makes a new object of the same type and general properties as a picked one, asking only for the new geometry. It is on the right-click menu of a single selected object. Source: ADDSELECTED (Command) help pages, Autodesk, read as search extracts only (medium).
7. **Double-click, Properties, Quick Properties, right-click options, multi-function grips:** as R-001 sections D.1 to D.5 (Autodesk help pages named there). The command's bracket options are added to the right-click menu while it runs (R-001 D.4).
8. **Contextual tabs come and go on selection; Civil 3D moves pipe ends with a structure:** R-001 A.3 to A.6 and B.3 to B.5.
9. **UNVERIFIED (from memory, not read on a page this session):**
   1. FILLET and OFFSET print a "Current settings:" line before their first prompt.
   2. MATCHPROP copies layer, colour and similar general properties, plus some special ones per object kind.
   3. A tool palette tool can run a command rather than insert a block.
   4. One command makes one U step.

   Tim's own alias list maps Ma to MATCHPROP and H to the old BHATCH (`evidence\TIM_ALIAS_LIST_16NOV.md`), so he uses both.

### 12. What is built now (bench pictures looked at; `C:\CE_CIVIL`)

1. **Pit window:** preview; four cards. Card 1: size tiles, number, kind, lid, "Holds detention water". Card 2: levels with a padlock on each. Card 3: pipes joined. Card 4: tag and cover-level ticks, and "Turned". Then "What else changes", and Inspect, Match, Cancel and OK.
2. **Pipe window:** wide preview; four cards. Card 1: size, kind, material. Card 2: fall (length divided by grade). Card 3: levels, with work downhill or uphill. Card 4: label, flow arrow and invert ticks, and label side.
3. **Inlet window:** kind buttons (DP, OF, FO, IO, GIO, FW), number, size; where it sits along the pipe; roof area it drains and where it drains to; text side.
4. **The picked look:** AutoCAD grey with rose (D-168).
5. **Prompts as built:** "Pick a point for the new pit or [Select]:" then the window; "Pick the pit the pipe starts at or [Point/Select]:"; last values kept for the session only.

---

## Half 2: the proposal

## A. Principles (seven)

1. **The common case asks nothing.** Type the short name, click, done; 73% of placements repeated the settings before them, and downpipes 100%.
2. **The window is for changing, not confirming.** It opens when you start the command, filled in (D-060), then you place pick after pick (D-186 for every placing tool). This is how HATCH behaves with its window switched on (HPDLGMODE 1).
3. **Edit the AutoCAD way, as cheaply as placing:** Properties, Quick Properties, grips, double-click (D-048, D-061). The old plug-in saw 207 edits against 200 placements.
4. **Plain AutoCAD commands are first-class ways of working:** COPY, MOVE, ERASE, MATCHPROP, palette drag and Enter-repeat all give a full CE object. Inlets were placed by palette and copy (6 command runs against 120 downpipes, inspection openings and trench grates), and 9 of the top 14 fault lessons were plain commands misbehaving.
5. **Defaults come from the office's own sheets, and the system works out what it can know.** 1 in 100 (89%), 100 dia (64%), grated (90%), label above (77 to 87%), text 250 (98%), pit size from depth (D-135).
6. **Draw drains the way they really run:** bends and branches inside the same command, like PLINE (18% of gravity pieces bend; branches on 5 of 6 jobs).
7. **Say little, never stop the drafter:** one quiet command-line line, unfinished is normal (D-176, D-188), and nothing asks what the drawing already answers (D-171).

## B. The common case costs almost nothing

### B1. The commonest things in this office

1. **Pit:** grated (90%). Size goes with depth and job. 350 x 350 is the commonest single size (42%), and 450 x 450 the commonest scheduled size alongside 600. No one size is right most of the time, so the size should be **worked out from depth** (D-135) and otherwise carry over from the last pit.
2. **Pipe:** 100 dia UPVC at 1 in 100 (100 on 64% of pieces; 1 in 100 on 89% of graded labels). For 150: UPVC SN8 at 1 in 100.
3. **Downpipe:** the masked DP block, tag "DP", unnumbered on the sheet, joined to a 100 dia stub (77 of 77 are the same symbol).
4. **Tank:** 2,000 litre re-use tank with the standard note (2 of the 4 tank jobs); larger tanks vary by job.

### B2. The test job: 6 downpipes, 4 pits, 8 pipes, a tank, an outlet, a schedule

Rules of the count:

1. A key press, a mouse click or a pick each count 1.
2. Typing a short name is its letters plus Enter.
3. Enter-repeat is allowed in every design.
4. Typed engineering values are left out because they are the same in all three: 4 cover levels, the outlet invert, the tank litres.
5. Changes of setting follow section 7: about 2 of 4 pits and 3 of 8 pipes differ from the one before.

**(i) As designed now (window every time, D-060; one placement per window for Pit and Pipe; D-186 for inlets):**

1. **Downpipes:** DP Enter (3), the window opens, OK (1), 6 picks (6), Enter (1) = **11**, 1 window.
2. **Pits:** PT Enter (3), then Enter-repeat for the next 3 (3) = 6 keys; 4 picks; 4 OKs; 2 changes of 2 clicks (4) = **18**, 4 windows.
3. **Pipes:** CD Enter (3), Enter-repeat 7 times (7) = 10 keys; 16 picks (two pits each); 8 OKs; 3 size changes of 1 click (3) = **37**, 8 windows.
4. **Tank:** WT Enter (3), pick (1), OK (1), pick the note's place (1) = **6**, 1 window.
5. **Outlet:** short name Enter (about 3), pick the pipe end (1), OK (1) = **5**, 1 window.
6. **Schedule:** SH Enter (3), OK (1), pick its place (1) = **5**, 1 window.
7. **Total: 82 actions, 16 full-screen windows.**

**(ii) The leanest AutoCAD-like way:**

1. Window when you type the name, Enter for OK, pick after pick for every placing tool.
2. Pit size from depth.
3. Changes afterwards by Quick Properties or Properties: select 1, pick the value 2 = 3 each.
4. The schedule places without a window; double-click opens it.

The count:

1. **Downpipes:** same as (i) = **11**, 1 window.
2. **Pits:** PT Enter (3), OK (1), 4 picks (4), Enter (1), 2 changes afterwards (6) = **15**, 1 window. With size from depth most size changes vanish; the 2 changes allowed for here are kind or lid.
3. **Pipes:** CD Enter (3), OK (1), 16 picks (16), Enter (1), 3 size changes afterwards (9) = **30**, 1 window. Chaining a run (the next pipe starts at the last pit, as LINE does) would save about 5 more picks.
4. **Tank:** **6**, 1 window.
5. **Outlet:** **5**, 1 window.
6. **Schedule:** SH Enter (3), pick (1) = **4**, no window.
7. **Total: 71 actions, 5 windows.**

**(iii) The old plug-in (from the records):** clicks were not recorded. Recorded command time for the same job: 4 pits x 28.6 s + 8 pipes x 20.7 s + 1 schedule x 21.6 s = **about 5 minutes**. Downpipes, inspection openings and the trench grate came from the palette or COPY, not timed. Then, on the record, about one edit run per placement.

### B3. What that says about your ruling D-060

1. **In clicks, D-060 is cheap:** 82 against 71, a 13% difference. The evidence does not justify overturning it on clicks.
2. **In interruptions, it is not:** 16 windows covering 80% of the screen, of which about 11 only confirm what was already right (73% repeats). Each costs a look over the whole window and a move to OK. The time per window is not known (section G).
3. **The bigger costs in the evidence are elsewhere:**
   1. Editing as often as placing (principle 3).
   2. COPY and the palette doing the inlets (principle 4).
   3. Bends and branches needing a second command (principle 6).
   4. Typed values the system could know (INPUT_AUDIT: 85 figures on a two-unit job, 20 possible).

### B4. The options, smallest change first (your choice: question H1)

1. **Option 1, recommended: keep D-060 and use D-186 for every placing tool.** Typing PT, CD, DP, WT and the others opens the window filled with the last used. Enter or OK accepts it. You then place as many as you like; Enter finishes. Pressing Enter again (AutoCAD's repeat) runs the command again with the window. This keeps every word of D-060 and D-186 and needs no new idea. It gives (ii) apart from the schedule.
2. **Option 2: as Option 1, but Enter-repeat means "same again" with no window.** Typing the name always gives the window; the Enter or Space repeat skips it; [Settings] at the prompt brings it back. This departs from D-060's "every time" for the repeat only. It saves one window and one OK per repeat.
3. **Option 3: a switch per drafter, "Show the window: every time / first time in a drawing / only when asked".** This is how AutoCAD treats its own Hatch window (HPDLGMODE). The office default would be your choice and each colleague could set their own (settings-first rule).
4. **Option 4: a Hatch-style ribbon tab while the command runs, no window.** This is closest to AutoCAD's own default HATCH on a ribbon PC. It goes against D-058 ("I LIKE THAT BETTER THAN TOO MUCH IN THE RIBBON") and the approved window (D-070). Shown for completeness only; not recommended.

## C. Using each first-release tool (as a drafter would see it)

Common to every placing tool:

1. **The window:** opens filled in when the name is typed. Enter accepts, Esc cancels and changes nothing (OC-08). Inspect hides it (D-065).
2. **The prompt:** one "Current settings" line, then a prompt in AutoCAD's form. Every bracket option is also on the right-click menu (AutoCAD adds them by itself, R-001 D.4).
3. **Unfinished:** one grey line at the end of the command, never a stop (D-176, D-188).
4. **Undo:** one U removes the whole command (OC-07).
5. **Pick-first:** if one CE thing of the same kind is selected when the name is typed, the window opens on it to edit (as built today). If a pipe is selected when PT is typed, the pit goes on that pipe and splits it (D-077).
6. **Locked or frozen layer, Xref, REFEDIT:** refused before anything is drawn, naming the layer (OC-19).

### C1. PIT (PT)

```
Command: PT
PIT  [window opens: 450 x 450 grated pit, Class C grated lid, next P3 -> Enter]
Current settings: 450 x 450 grated pit, size from depth, next number P3
Specify pit location or [Settings/Number]:                 <click>   P3 placed
Specify pit location or [Settings/Number/Undo] <done>:     <click>   P4 placed
Specify pit location or [Settings/Number/Undo] <done>:     <Enter>
2 pits placed (P3, P4). Cover level not known yet at P3, P4 (prints TBC).
```

1. **Click on a drawn pipe:** the pit sits on it and splits it (D-077). The closing line says "P3 split pipe P2-P4 in two".
2. **Number:** type a different next number. D-184's three choices are offered only when the drawing has been issued.
3. **Double-click a pit:** opens the Pit window on it (D-061).
4. **Properties:** a CE Pit group with size, kind, lid, cover level (padlock), number, "In the schedule" for plastic pits (D-048, D-076).
5. **Grips:** tag and CL text move and flip (D-037). The pit's own grip moves it and carries the pipe ends (D-181; Civil 3D does the same, R-001 B.3).
6. **Plain commands:** COPY gives P5 with size and kind copied and levels marked assumed (D-179). ERASE takes the tag, CL text and schedule row, and leaves the pipes "not joined yet" (D-221). MATCHPROP from one pit to another copies size, kind and lid, never number or levels (proposal).
7. **Wrong:** cover below the pipe shows red "Wrong" in Properties and the window, never blocking (D-140); too deep for the size shows amber "Needs a look".

### C2. PIPE (CD)

```
Command: CD
PIPE  [window opens: 100 dia UPVC, 1 in 100, label above -> Enter]
Current settings: 100 DIA. UPVC PIPE AT 1 IN 100, label above
Specify start (pit, pipe or point) or [Settings]:          <click P4 wall>
Specify next point or [Arc/Undo] <end here>:               <click>        a bend
Specify next point or [Arc/Undo] <end here>:               <click P3 wall>
Pipe P4-P3 drawn, 8.40 m. Continue from P3? Specify next point or [New start] <done>:  <Enter>
```

1. **Ends:** the pipe starts and ends exactly on the inner wall in line with the click (D-034, D-102). Bends are ordinary vertices (D-189). Ending on another pipe makes a branch (D-081 offers an inspection opening quietly when it applies).
2. **Continue from P3:** after a pipe reaches a pit, the next pipe can start there, as LINE continues (proposal; question H4).
3. **Kinds:** charged, suspended, detention, ag and perimeter are kinds in the window (THE_PLAN). AG has no inverts (D-040).
4. **Double-click:** the Pipe window. **Properties:** size, material (pick or type, D-079), grade (pick or type), both inverts with padlocks (D-080). **Grips:** the label, IL text and arrow slide along or across (D-037, D-041); a hand-moved label stays put (D-014).
5. **Plain commands:** STRETCH or a grip on a bend is a normal polyline edit and the label follows. MATCHPROP pipe to pipe copies size, material and grade.
6. **Wrong:** flatter than 1 in 200 shows amber (D-142); low cover red (D-140); a loose end grey "not joined yet" (D-176).

### C3. LONGSECTION (LG)

```
Command: LG
LONGSECTION
Select the downstream end (outlet or pit) or [Run]:        <click P1>
Run P1 to P6 found (5 pipes). [window opens: long section above, plan strip below]
  ... hold what is fixed, the rest is worked out (D-086, D-129) ... OK
Place long section on sheet? [Yes/No] <No>:                <Enter>
Levels updated on 5 pipes and 6 pits. Out by 0.06 between P4 and P1 (held: P4 cover, connection invert).
```

1. **Mostly a window for the whole run;** nothing is placed unless asked (long sections only when council asks, D-030).
2. **Double-click a drawn long section:** opens this window on its run.
3. **Wrong:** named by stretch and amount (D-125); never bends a standard (D-124).

### C4. The inlets: DOWNPIPE (DP), OVERFLOW (OF), FO, INSPECTION (IO), GIO, FLOORWASTE (FW)

```
Command: DP
DOWNPIPE  [window opens: DP, 100 dia, text right -> Enter]
Current settings: downpipe, 100 dia stub, tag DP
Specify downpipe location or [Kind/Settings]:              <click>
Specify downpipe location or [Kind/Settings/Undo] <done>:  <click> x5
Specify downpipe location or [Kind/Settings/Undo] <done>:  <Enter>
6 downpipes placed. Not joined yet: 6 (draw their pipes with CD).
```

1. **Kind:** switches between DP, OF, FO, IO, GIO and FW without leaving the command (the same window, D-111).
2. **Click on a pipe:** the inlet sits on it where clicked and slides by its grip (D-050).
3. **The palette:** dragging a DP from the Blocks palette runs DP and places a full downpipe (proposal; question H5). Copying a DP gives a full downpipe.
4. **Double-click:** the Inlet window. **Properties:** kind, size, tag text and side.
5. **Wrong:** a downpipe not joined to any pipe is grey "not joined yet", counted at plot (D-188).

### C5. TANK (WT)

```
Command: WT
TANK  [window opens: 2,000 L re-use, standard note -> Enter]
Specify tank location or [Size/Settings]:                  <click>
Specify note location:                                     <click>   leader arrow back to tank (D-039)
Tank WT1 placed, 2,000 L. Detention share: not worked out yet (site rainfall not entered).
```

1. **Double-click:** the Tank window. **Properties:** litres, re-use and detention split (worked out, D-100), note wording.
2. **COPY:** gives WT2 (numbered, as one job's WT4 to WT12).

### C6. DETENTION (DET)

```
Command: DET
DETENTION  [the job's Detention window opens; no pick]
  storage needed | storage you have | orifice and head (worked out, D-172, D-173)
Place criteria box? [Yes/No] <Yes>:   Specify location: <click>
Criteria box placed. Cannot work out storage yet: site rainfall not entered (D-218).
```

1. **One window per job** (D-099). The criteria box follows the figures afterwards. Double-click the box to open the window.

### C7. SCHEDULE (SH)

```
Command: SH
SCHEDULE
Specify top-left corner of pit schedule:                   <click>
STORMWATER PIT SCHEDULE placed, 6 rows (P1-P5, X1). It follows the pits from now on.
```

1. **No window on placing (proposal; a departure from D-060's "every time" for this one tool, because there is nothing to choose):** your own words were "placed once, then follows the pits" (D-109).
2. **Double-click:** the Schedule window (typed-over cells with padlocks, D-103).
3. **Too long for its spot:** one line saying it may not fit (D-114).

### C8. OUTLET (name not yet given; draft OUT is not checked)

```
Command: OUT
OUTLET  [window opens: council pit / kerb and channel, invert -> type 4.95 APPROX.]
Select the pipe end that discharges:                        <click>
Outlet placed: council pit X1, APPROX. IL 4.95 (to be confirmed). Run P1-P6 now reaches an outlet.
```

1. Prints "APPROX. IL 4.95" with one standing note until confirmed (D-177); joins the schedule as X1 (D-110).

### C9. LEGAL POINT OF DISCHARGE (own small tool, D-222; name not given)

```
Command: LPD
Specify point of discharge:      <click>
Specify label location:          <click>        "LPD"
```

1. Two clicks; Properties for the wording.

### C10. TRENCH GRATE (TRENCHGRATE / TG draft)

```
Command: TG
TRENCHGRATE  [window: 150 wide, class C -> Enter]
Specify start point:   <click>    Specify end point or [Width]:   <click>
Trench grate 150 wide x 3.10 m placed. Label "150 WIDE TRENCH WITH CLASS C GRATE".
```

1. Grips stretch its length and width (the office block has two stretches). Double-click opens the window.

### C11. AG AND PERIMETER DRAIN (AGDRAIN / AG draft)

```
Command: AG
AGDRAIN
Specify start point or [Perimeter]:   <click>
Specify next point or [Undo] <done>:  <click> ... <Enter>
Ag drain 14.2 m placed. No invert levels (D-040).
```

1. Behaves exactly like PLINE; label kept clear (D-041).

### C12. CLEAN (CN)

```
Command: CN
CLEAN  purge, Xrefs to layer, office layers and styles, audit, zero Z, units, save
Saved. 3 unused blocks purged, 0 errors found, 12 objects set to Z 0. (1.8 s)
```

1. **No window and no question** (D-204: "replicated quickly and often"). The steps are ticks in a small window reached by [Settings] or by right-clicking the ribbon button. It never touches the office template (BUG-1457).

### C13. BLOCKS (BLK)

1. **What it is:** a docked palette, AutoCAD's own Tool Palettes look, with tabs Civil, Notes and details, and Symbols (D-208, D-229).
2. **Dragging a CE thing** (pit, downpipe, inlet, tank) runs its placing tool (proposal). Dragging a detail or note inserts the office block on its layer at the drawing's scale.
3. **Typing BLK** opens or closes the palette, as TP does for AutoCAD's.

## D. Defaults, with how often each would have been right on the old jobs

1. **Pit kind: grated.** Right for 47 of 52 pits (90%).
2. **Pit size:** worked out from depth (D-135) once a cover and an outlet invert exist. Before that it carries over from the last pit (54% repeat the one before). A fixed first size would be right only 42% of the time (350) or 15% (450). The office table, not a fixed number, is the default.
3. **Pit lid class: set once per job and carried by every pit.** Lid class went by job on every scheduled job; one job had 7 of 8 rows the same. The first-ever default is not safe (Class C 10, D 4, A 3): question H7.
4. **Pit tag:** next free number from P1 at the outlet (D-075); existing council pit X1. Right on 6 of 6 jobs' numbering style. Text 350 on 35TEXT: 6 of 6.
5. **Pipe size: 100.** Right for 64% of drawn pieces (D-174 agrees).
6. **Pipe material:** UPVC for 100 (every 100 label); UPVC SN8 for 150 below ground (about 9 of 11); STORMPRO for detention (7 of 7).
7. **Pipe grade: 1 in 100.** Right for 42 of 47 graded labels (89%); detention by the stepped list (D-134).
8. **Label wording:** "100 DIA. UPVC PIPE AT 1 IN 100", with or without "MIN." (50/50: question H2). Detention: "450 DIA. STORMPRO PIPE AT 1 IN 190 15.24m DETENTION" (7 of 7).
9. **Label side and distance:** above (77 to 87%); anchor at half-width plus 125 from the centreline (26 of 48, all old plug-in labels); parallel to the pipe and turned to read left to right or bottom to top.
10. **Text heights:** labels 250 on 25TEXT (98%); IL 180 (148 of 148); CL 200 on 25TEXT, turned 45 degrees; pit tag 350.
11. **Layers:** STORMWATER PIPE with the polyline width equal to the size (236 of 236); charged and suspended on their own layers; pits, tags and inlets per the office list.
12. **Number formats:** levels to 2 decimals (207 of 207 CL and IL texts); grades "1 IN n"; lengths "16.90m" in detention labels; litres with a thousands comma.
13. **Downpipe tag:** "DP", not numbered on the sheet (70 of 77; 0 numbered).
14. **Flow arrows and inverts at each end:** on (every old plug-in job).
15. **Tank:** 2,000 L re-use with the standard note (2 of 4 tank jobs). Low confidence; carry the last used.
16. **No default is safe for:**
    1. Cover levels: the engineer's, never the survey (D-178); prints TBC.
    2. Site rainfall: per site (D-218); "cannot work out yet", or your typed estimate marked APPROX.
    3. Permitted discharge and the council connection invert: from the council letter (D-030, D-177).
    4. Tank litres beyond the first: these varied on every tank job.
    5. The outlet's place.

## E. What to take away so it feels less "complex and AI-built"

None of these is removed from the plug-in. Each moves out of the placing window into Properties, a grip or the job's own window (D-049 item 6: only where logical). The window opens shorter and every remaining card is a real decision.

1. **Pit window, card 4 "Shown on the drawing" (tag tick, cover level tick, "Turned"):** tags and CL text were on every scheduled pit on all 6 jobs. Turning a pit is AutoCAD's ROTATE or a grip. Move to Properties.
2. **Pipe window, card 4 ticks (Label, Flow arrow, Invert at each end):** all three were on, on every old plug-in job. Keep "Label side" as a grip flip; move the ticks to Properties.
3. **Inlet window, "Roof it drains" card:** roof area per downpipe is on 0 of 6 sheets and is used only by detention (3 of 6 jobs). It belongs in the Detention and Tank windows (where catchments are added up) or in Properties, not in placing a downpipe.
4. **Inlet window, "Where it sits: along the pipe 0.00 m" card:** the click decides it and the grip slides it (D-050); the figure never prints. Take it out of the window.
5. **Inlet window, "Number" box:** downpipes are never numbered on the sheet (0 of 6 jobs). Keep the internal name and drop the box from the window.
6. **Pit window, "Holds detention water" tick:** 2 of 52 pits, on 2 of 6 jobs. Show it only when the job has detention (D-105 keeps the tick itself).
7. **Pipe window, separate "Fall" card:** fall is printed on 0 of 57 labels. Fold the "length divided by grade" working into the Levels card, which keeps your maths-teacher working (D-069) with one card fewer. This touches the approved layout (D-068), so it is a question for you, not a change.
8. **The Schedule window on placing:** nothing to choose (section C7).
9. **Status words on every line ("measured", "chosen", "worked out"):** keep. The padlock reads at a glance (D-128). This is not clutter.
10. **Old repair and audit commands** (20 names, CDSYNC, CDREPAIR and the rest): a drafter would not miss them; they die with the old object (D-094).

## F. The first five minutes for a colleague who has never seen it

1. **Minute 1:** they open a new drawing from the office template (D-191). The CE Civil tab shows the tools by their plain names, each tip showing the short name (UI_PLAN; R-001).
2. **Minute 2:** they type PT, the way they type L or C. The window shows a picture of the pit as it will look, already filled in. They press Enter and click three times on the drawing. Three pits appear, numbered, with "TBC" where the cover level will go. The command line tells them in one line what is not done yet.
3. **Minute 3:** they type CD and click from pit to pit, adding a bend on the way, as with PLINE. The label appears above the pipe in the office wording.
4. **Minute 4:** they click a pit and see its facts in Properties, the palette they already use for everything. They type a cover level, and the TBC becomes a number and the depth works itself out. They double-click a pipe and get the same window it was drawn with.
5. **Minute 5:** they COPY a downpipe four times and get four downpipes. They press U and one undo takes back the last copy. They type SH and click, and the schedule appears and keeps itself up to date.
6. **Why no manual:** every step is an AutoCAD habit they already have (typed name, click, Enter, Properties, double-click, COPY, U). The only new things are the window, which is already filled in, and the padlock, which reads at a glance (D-128).

## G. What the evidence could not tell, and the smallest test that would

1. **Time per window:** not in any record. Test: time Tim placing ten pits two ways, one window per pit against one window then ten clicks. About 10 minutes in the bench or AutoCAD at night hours.
2. **What Tim's own AutoCAD does on H (Hatch window every time or the ribbon tab):** not readable without touching his settings. Test: Tim types HPDLGMODE once and reads the number (1 = window every time, 2 = ribbon tab).
3. **What drafters edit after placing (size, levels, label place):** the records count edits, not what changed. Test: a colleague drafts one real two-unit job copy with the bench windows while the bench logs what was changed. One sitting.
4. **Whether colleagues type or use the ribbon:** not recorded. Test: ask the 2 to 5 civil users one question, or log ribbon clicks against typed names for a week once installed.
5. **Whether a cold colleague needs help:** test the first five minutes (section F) with one colleague and no help. Count the questions they ask; target none.
6. **The office's mix of job sizes:** 6 jobs is small. Test: count pits per job on the next ten issued civil sheets as they go out.

## H. Questions for Tim

1. **H1. When should the window open?** Context: AutoCAD's own HATCH on a PC with the ribbon showing does NOT open its window each time; it shows the Hatch tab, unless HPDLGMODE is set to 1. Example: placing 4 pits, 3 of them like the one before. Evidence: 73% of placements repeated the one before; clicks barely change (82 against 71), windows drop from 16 to 5. **Recommended: Option 1 in B4. The window opens when you type the name, then pick after pick, Enter to finish (D-186 for every placing tool).**
2. **H2. Pipe label: "AT 1 IN 100" or "AT 1 IN 100 MIN."?** Example: "100 DIA. UPVC PIPE AT 1 IN 100 MIN.". Evidence: "MIN." on 21 of 42 labels at 1 in 100, used on whole jobs or not at all. **Recommended: "MIN." when the grade is the office's flattest allowed grade (the "at least" case), plain when a steeper grade is typed; one line in the office list.**
3. **H3. Pit size from depth when placing?** Example: cover 5.75, outlet 5.18, depth 0.57, so 450 x 450 by your table (D-135). Evidence: pit settings changed between one pit and the next 46% of the time, mostly size. **Recommended: yes. Size follows depth unless held; before levels exist it carries over from the last pit.**
4. **H4. Continue a run from the last pit, as LINE does?** Example: draw P4 to P3, then carry straight on to P2 without picking P3 again. Evidence: pipes repeat the one before 67% of the time; 54% of pits take 3 or more pipes, so branches still need a new start. **Recommended: yes. After a pipe reaches a pit, offer "Specify next point or [New start] <done>".**
5. **H5. Dragging from the Blocks palette runs the placing tool?** Example: drag a DP from BLK and get a joined-ready downpipe, the same as typing DP. Evidence: DP, IO and TG were typed 2 times each while 120 inlets were placed by palette and copy. **Recommended: yes, for every CE thing on the palette.**
6. **H6. 150 pipe material default UPVC SN8?** Example: "150 DIA. UPVC SN8 PIPE AT 1 IN 100". Evidence: SN8 on about 9 of 11 below-ground 150 labels; every 100 label is plain UPVC. **Recommended: yes. 100 is UPVC and 150 below ground is UPVC SN8, as office-list lines.**
7. **H7. Lid class once per job?** Example: a driveway job where every grated pit is Class C. Evidence: the lid class went by job on every scheduled job (one job 7 of 8 rows the same); no single class is right across jobs (C 10, D 4, A 3). **Recommended: set it once in the Job window, carried by every pit, changed per pit in Properties.**
8. **H8. Move the cards in section E out of the placing windows?** Example: the Inlet window loses "Roof it drains", "Along the pipe" and "Number", and opens with kind, size and text side only. Evidence: each is always the same value or never printed on the 6 jobs. **Recommended: yes for E1 to E6 and E8. E7 (folding Fall into Levels) only if you agree, because it touches the approved layout.**

## Where the evidence lives

1. Scripts (read-only, no job names inside): `C:\CE_WORK\scratch\ux_evidence\scan2.py`, `scan3.py`, `scan4.py` and the small analysis scripts beside them.
2. Reference: `reference\standards\*.csv`, `reference\today\TOOLS_TODAY.md` (T-035 to T-038, T-055), `reference\research\R-001`, `R-006`, `R-007`, `stage6\OBSTACLE_COURSE.md`, `design\INPUT_AUDIT.md`.
3. Rulings: `DECISIONS.md` D-001 to D-230; `rulings\WINDOWS.md`, `RIBBON_AND_NAMES.md`, `EDITING_AND_GRIPS.md`, `DIRECTION.md`, `INLETS.md`, `TANK.md`, `OUTLET_AND_LPD.md`, `OTHER_DRAINS.md`, `LONG_SECTION.md`, `PIT_SCHEDULE.md`, `SHARED_TOOLS.md`.
4. Built: `C:\CE_CIVIL\DESIGN.md`, `C:\CE_CIVIL\acad\DESIGN_PIT_TOOL.md`, `DESIGN_PIPE_TOOL.md`, the bench shots and the rose scheme picture.
