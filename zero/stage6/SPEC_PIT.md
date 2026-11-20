# The Pit tool (PT and PP): every specific, Stage 1

**Revision:** 1, Fri 20 Nov 2026. **Status:** DRAFT spec for Tim to go through. It is not a ruling and decides nothing. Where it and `DECISIONS.md` disagree, `DECISIONS.md` wins and this page is stale.

**Why it exists.** Tim, 20 Nov 2026: "i need every specific down to a tee before we complete this first stage" (D-359). This page walks the pit tool the way a drafter meets it, start to finish.

**Read from:** `DECISIONS.md` D-001 to D-383; `rulings\INDEX.md`, `PIT.md`, `EDITING_AND_GRIPS.md`, `LABELS_AND_TEXT.md`, `AUTOCAD_RULES.md`, `OLD_PLUGIN.md` (filed only to D-297); `stage6\STAGE1_TIMS_EYES.md`; `stage6\ONE_JOB_RELEASE.md`; `design\SCREEN_RULES_18NOV.md`; `design\STYLE_APPROVED_18NOV.md`; `UNKNOWNS.md`; `interview\ANSWERS_TIM.md` (TR-001 to TR-069); `stage6\findings_19nov\ROOT_CAUSES.md` and `part_2.md`.

**How each line ends.**
1. **[D-nnn]:** rests on Tim's own decision (or a draft call he has since confirmed in words, as D-380 does).
2. **[DRAFT D-nnn]:** rests only on a planning chat's or control room's call, never confirmed by Tim.
3. **[NOT RULED]:** nothing answers it. Every DRAFT and NOT RULED line is a question in section 10.

---

## 1. Starting

1.1 **Typing PT** starts the Pit tool; the full word PIT starts the same tool [D-101, D-258].
1.2 **Typing PP** starts the same tool preset to a 350 x 350 plastic pit; Tim's old Pp alias (PEDIT) was removed from his alias file for this [D-235, D-251, D-323].
1.3 **The old plug-in loaded as well:** the new tool takes PIT, PP and CD and the old one stops answering to them; proven in Tim's own AutoCAD only when the new plug-in was loaded after the old one ("Pit · P1" window answered) [D-258, D-351].
1.4 **The other load order** (new plug-in loaded first, old one second): what answers PIT, PP and CD is not proven [NOT RULED].
1.5 **Tim's alias file:** the tool never edits it by itself [D-170, D-250].
1.6 **Units:** millimetre drawings only in this release. A drawing set to metres is refused: the tool says metre drawings are not supported yet and draws nothing [D-344, D-380].
1.7 **A drawing with no units set, or set to inches or another unit:** what the tool does [NOT RULED].
1.8 **The pit is clicked on a layout sheet rather than in model space:** what the tool does [NOT RULED].
1.9 **A drawing opened read-only:** what the tool does before the first click [NOT RULED].
1.10 **Scale:** plans are drawn full size (1:1) and the layout viewport sets 1:100; in Stage 1 text is sized for a 1:100 viewport as an office default [D-194, D-381].
1.11 **Office pit block missing from the drawing:** PIT BLOCK 3 is brought in from a copy that travels in the plug-in's own folder (copied from the office master at each release); no network needed; a plain stand-in square is never drawn [D-352].
1.12 **Where that copy lives:** one data setting holds its path [D-352].
1.13 **Layers, text styles and linetypes missing** (an architect's bare drawing): brought in from the tool's own copy of the office set-up, with one command-line line listing what was added; anything already in the drawing is never changed [D-381].
1.14 **The drawing already holds a block called PIT BLOCK 3 that differs from the office copy** (an older or hand-edited one): which definition the tool uses [NOT RULED].
1.15 **The tool's own block copy cannot be found:** the tool says so and draws nothing [DRAFT D-352].
1.16 **Wipeout frame setting:** the tool tells the drafter when the drawing's setting would hide the pit's inner wall or stop it plotting; the drafter changes it, the tool never does [D-224].
1.17 **The words of that warning and which setting values trigger it** [NOT RULED].
1.18 **No Job window in Stage 1:** the tool uses office defaults (5 mm tolerance, the ten "what is over it" presets, no council, text for 1:100) and the window says so in one grey line ("Office defaults: no job set yet") [D-381].
1.19 **Starting a job:** drafters start from the office template, a clean start each time [D-191].
1.20 **A drawing begun by Save As of the last job,** with the last job's pits still in it: what the tool treats as confirmed [NOT RULED].
1.21 **A layer the pit needs is off or frozen:** the window says so and offers a button to turn it on; nothing changes unless he presses it [D-320].
1.22 **Nothing in AutoCAD's own set-up is touched:** no profile, saved setting or registry entry; last used choices live in a small CE file of the tool's own [D-121, D-263].

## 2. Placing a pit

**On the cursor, before the click**

2.1 **What rides the cursor:** the real PIT BLOCK 3 at the opening size (450 x 450 for PT, 350 x 350 plastic for PP), square to the sheet, with "TBC" in grey for what is not known [DRAFT D-267].
2.2 **Which point of the pit is on the cursor:** the centre [D-383].
2.3 **Stepping the cursor point:** a key steps it round the four corners and the four wall midpoints [D-383].
2.4 **Which key does that** (Tab was only an example in the question) [NOT RULED].
2.5 **Object snap, ortho, polar, zoom and pan while placing:** whether they all behave as in plain AutoCAD [NOT RULED].
2.6 **Command-line prompt words:** draft words until the release wording pass [DRAFT D-261].
2.7 **Hover:** what lights up under the cursor and what a hover tip says [NOT RULED].

**The click**

2.8 **One click places the pit** at that point, square to the sheet; the angle is never asked while placing [D-354, D-381].
2.9 **Clicked on the middle of a drawn pipe:** the pipe is split in two at the pit; each half keeps its own label and levels; a typed level stays with its own half; the two levels at the new pit are worked out along the old grade with the 0.02 drop and shown as worked out; both halves keep size and material [D-077, D-377].
2.10 **Which half's grade gives** when both outer levels are typed and the 0.02 drop is added (P7 halfway along a 10 m pipe at 1 in 100 with IL 12.40 and 12.30 typed) [NOT RULED].
2.11 **Clicked on or within its own outline of a loose pipe end:** the pit joins that pipe, the pipe is trimmed to the pit wall and its label updates [D-270, D-377].
2.12 **Clicked short of a loose pipe end** (outside the pit's outer wall line): the pipe stays loose, "not joined yet"; nothing is pulled in from outside [D-270].
2.13 **A pipe already selected when PT is typed:** whether a pit goes on it [NOT RULED].

**The window**

2.14 **The window opens after the click,** for that one pit [D-354].
2.15 **Where on screen it opens, and whether it remembers** (second monitor, over the drawing) [NOT RULED].
2.16 **Its size:** Tim's words "80% of the autocad open window not screen in entirety or we can do a better system of like one for laptop one slightly bigger for desktop" are not settled; scrolling not answered [NOT RULED].
2.17 **Its look:** the approved style: dark ground, the answer band, step 1 "What you type", step 2 "What the drawing gives", step 3 "The answers", Cancel and a rose OK at the bottom right [D-294, D-295].
2.18 **Title bar:** the tool and the thing's name, for example "Pit · P1" [D-295].
2.19 **What it opens with:** size 450 x 450 for PT and 350 x 350 for PP every time ("Yes, size resets"); kind, lid and the rest as last used, kept between AutoCAD sessions [D-263, D-323].
2.20 **Switch per tool:** a setting lets anyone switch any tool to "always office default" or "always last used" [D-263].
2.21 **The window gone through line by line with Tim** (which choices, in what order, in what words): never done [NOT RULED].
2.22 **Kind:** Junction, Grated, Plastic only in Stage 1; orifice pit, pump pit (SPS grated, SPS solid) and bought-in units are left out until their real looks exist [D-259, D-381].
2.23 **Choosing Plastic while the size reads 450 x 450,** or another kind while it reads 350 x 350: whether the size changes with it [NOT RULED].
2.24 **Size:** any pair the block takes, 350, 450, 600, 900 or 1200 each way (so 1200 x 900 works); the five office sizes of the guidebook table (350, 450, 600, 600 x 900, 900 x 900) sit at the top as the usual ones; anything PIT BLOCK 3 cannot draw is refused in words, and the drafter decides [D-135, D-228, D-272].
2.25 **Whether the size can be typed as well as picked** (the list-only ruling D-080 was replaced by D-272 without saying) [NOT RULED].
2.26 **Which way a 600 x 900 pit runs when placed** (first figure across the sheet or up it) [NOT RULED].
2.27 **Lid:** a box he can pick from or type into [D-080].
2.28 **Lid class:** follows where the pit sits and what can drive over it, pit by pit: garden Class A, house driveway Class C ("office practice"), truck hardstand or industrial slab Class D, from the ten "what is over it" presets; a guide only, the engineer can change it (shown as typed over), a council's request overrides [D-240, D-242, D-243, D-287].
2.29 **"What is over it" on a pit:** opens "Not known" and is never nagged for; the presets are there if he wants them [D-383].
2.30 **What the lid box opens with when "what is over it" is Not known** (D-287 gives a class from the preset; D-383 opens the preset as Not known) [NOT RULED].
2.31 **The lid words themselves** (grated, solid, heel safe and the like) and how they print [NOT RULED].
2.32 **Cover level:** typed in this window for each pit as it is placed [D-358].
2.33 **Where the cover level comes from:** the engineer sets it from the internal house levels and the surrounding pavement levels; the tool never offers or reads a survey level as a cover level [D-178].
2.34 **Once typed, the cover level is locked:** only the person changes it; working out levels along a run never touches it [D-078].
2.35 **Cover level left blank:** reads "Not known" in the window and "TBC" on the sheet [D-178, D-295].
2.36 **Help with the cover level:** allowed only as a suggestion marked as such, the engineer's figure always wins [D-195].
2.37 **Which form that help takes, and whether it is in Stage 1** [NOT RULED].
2.38 **Pit number:** the next free number, the highest plus one (P1 to P5 with P3 erased gives P6) [D-377].
2.39 **Whether the number can be typed in the window,** as it can be retyped on the drawn tag [NOT RULED].
2.40 **Drop across the pit:** office standard 0.02 from invert in to invert out, typed over on this pit if wanted [D-084, D-141].
2.41 **Any figure can be held by typing over it;** a worked-out figure shows dashed and is used as it stands with no extra step [D-086, D-319, D-322].
2.42 **Several pipes arriving at different levels:** which arriving invert the pit's outlet level is worked from [NOT RULED].
2.43 **Text ticks:** the pit number and the cover level text each have their own tick on the pit [D-377].
2.44 **"In the schedule" tick on each plastic pit, starting ticked** [D-076].
2.45 **Whether that tick shows in the Stage 1 window** while the schedule itself waits for Stage 2 [NOT RULED].
2.46 **"Holds detention water" tick** (D-105): whether it shows in the Stage 1 window [NOT RULED].
2.47 **Turn button:** the window steps aside, the pit swings live on the cursor like ROTATE, he clicks or types the angle, the window comes back showing it [D-266, D-381].
2.48 **Inspect button** (D-065, "ALWAYS"): the approved style's bottom bar has none; whether it stays and what it shows [NOT RULED].
2.49 **Match** (copy the choices from a pit already drawn; in the approved structure of D-068, not in the approved style): whether it stays [NOT RULED].
2.50 **The answer band:** which one answer the Pit window leads with [NOT RULED].

**The preview inside the window**

2.51 **What it shows:** the real drawing around the pit, with the pit changing live as he types; Tim: "I MEANT THE LIVE DRAWING SHOULD SHOW IN THE PREVIEW IWNDOW IN THE WINDOW ITSELF" [D-378, D-382].
2.52 **Where it sits:** the drawing at the left of the window, plus a small picture beside the inputs it shows [D-296, D-313].
2.53 **Where on the plan and where in the system:** a small site locator in the corner and a strip under the preview with the run as a chain and this pit lit [D-167].
2.54 **Made-up scenery is labelled as made up;** no build wording such as "Bench preview" [D-286].
2.55 **The preview's size and zoom** [NOT RULED].
2.56 **Whether the pit is also shown on the AutoCAD drawing behind the window** while it is open (D-301 said both; D-382 says the preview) [NOT RULED].

**OK, Cancel, Escape, the next pit**

2.57 **OK:** the pit goes in with its number, its level and its text placed by the placing rules of section 3 [D-354].
2.58 **One write:** the pit, its tag, its text and any pipe it splits or joins go in as a whole or not at all [D-348].
2.59 **After OK,** the tool waits for the next click; the next window opens with the last pit's kind and lid (size reset as 2.19) [D-263, D-323, D-354].
2.60 **Ending the run of clicks** (Enter, Space, right-click) [NOT RULED].
2.61 **Cancel:** the window closes and nothing is placed for that pit [D-357, D-382].
2.62 **After Cancel,** whether the tool waits for the next click or ends [NOT RULED].
2.63 **Escape:** cancels the whole window [DRAFT D-288].
2.64 **A half-filled window offered back** after Escape [NOT RULED].
2.65 **Undo:** one pit per Undo, each with its own window and OK [D-377].
2.66 **Click budget** for placing a pit [NOT RULED].
2.67 **Speed:** window open in 0.3 s; preview redraw in 0.1 s after a keystroke [DRAFT D-288].

**Numbering**

2.68 **P1 at the outlet;** new pits take the next free number; a Renumber button re-runs them from the outlet upstream when asked [D-075].
2.69 **An erased number is never handed out again by itself;** Renumber closes gaps when asked [D-377].
2.70 **Where the Renumber button is, and what it numbers from in Stage 1** (the legal point tool that marks the outlet is Stage 2) [NOT RULED].
2.71 **Two systems on one site:** one series, no number used twice on a sheet, each system numbered from its own outlet, the street system first [D-183].
2.72 **A duplicate number** shows amber on both pits [D-185].
2.73 **A pit added after the sheet is issued:** the drafter chooses each time among the next free number, a letter (P3A) or renumbering everything [D-184].
2.74 **Which of those three is offered first** [NOT RULED].

## 3. What is drawn

3.1 **The block:** PIT BLOCK 3 exactly as it is: kinds by its visibility states, size by its two stretches, no renamed parameters, no 50 mm step, no extra inner wall line [D-228, D-229].
3.2 **Look by kind:** a grated pit uses the block's grated look; a junction pit the solid look with the cross [DRAFT D-260].
3.3 **Plastic pit:** the same block at 350 x 350, no new state [D-224].
3.4 **Plastic pit cover text:** "PP" over "CL" on two lines, as the office draws it [DRAFT D-260].
3.5 **Walls:** the inner wall is the edge of the block's wipeout; the outer wall is the dashed / hidden line [D-039, D-224].
3.6 **Pipes stop at the inner wall line,** passing the dashed outer line [D-102].
3.7 **How far inside the outer line the inner wall sits for each size** (needed for every pipe end) [NOT RULED].
3.8 **A size the block will not take:** refused in words; the drafter decides [D-228, D-272].
3.9 **A stand-in outline is never drawn** [D-352].
3.10 **Which layer the pit block goes on** [NOT RULED].
3.11 **Which layer the pit number and cover level text go on** [NOT RULED].
3.12 **Colour, linetype and lineweight of the pit and its text** (ByLayer or set) [NOT RULED].
3.13 **The block's elevation and scale** when placed and on every later edit [NOT RULED].
3.14 **Pit number words:** "P" and the number, for example P1 [D-075].
3.15 **Pit number look:** the office's circled tag [DRAFT D-260].
3.16 **Pit number reads flat,** straight above, straight below or straight beside the pit, never off a corner [D-363].
3.17 **Order it tries:** 900 mm above the pit centre first, then below, then beside; a side a pipe leaves from is skipped [D-366].
3.18 **Which side "beside" tries first** (left or right) [NOT RULED].
3.19 **Whether the 900 mm is to the centre of the text, its base or its circle** [NOT RULED].
3.20 **Cover level text:** always turned 45 degrees, off one of the four corners; top right first, 400 mm off the corner, then round the pit [D-363, D-366].
3.21 **Which way "round the pit" goes, and which corner the 400 mm is measured from** (outer dashed line or inner wall) [NOT RULED].
3.22 **On a turned pit:** only the pit box turns; the number and cover level stay put and upright, level with the sheet, at the same offset from the pit centre [D-267].
3.23 **On a turned pit, whether the cover level stays at 45 degrees to the sheet or to the pit** (D-267 against D-363) [NOT RULED].
3.24 **Cover level words:** "CL" and the figure, for example "CL 12.95" [DRAFT D-260].
3.25 **Figures:** a level is taken to a tenth of a millimetre, then rounded half up to two decimals (12.345 shows 12.35) [D-341, D-380].
3.26 **Cover level not known:** "TBC" prints in place of the figure [D-178].
3.27 **Cover level assumed** (copied from another pit, not yet confirmed): "APPROX." in front of it [D-177, D-179].
3.28 **The APPROX. standing note:** its wording is settled and it is a notes block the drafter places from the Blocks palette [D-248].
3.29 **What reminds the drafter to place that note in Stage 1,** with the Unfinished list in Stage 2 [NOT RULED].
3.30 **Text style and height** of the pit number and cover level (the invert text is 20TEXT, D-265) [NOT RULED].
3.31 **A background mask behind the number and cover text,** as the office draws them [DRAFT D-260].
3.32 **No spot clear:** the text goes in its first spot on its mask and is flagged as overlapping [D-368].
3.33 **Where that overlap flag shows in Stage 1** [NOT RULED].
3.34 **What counts as a clash for pit text** (pipe labels, other pits, the pipe band, existing linework, hatching) [NOT RULED].
3.35 **Text moved by hand stays where he put it** when the pit changes; its wording still updates [D-014, D-181].
3.36 **Erasing the number or cover text by hand** is the same as unticking it: it stays off, the figure is still known and checked, the tick brings it back [D-377].
3.37 **A level below 0.00:** amber "check the datum", never Wrong by itself [DRAFT D-288].
3.38 **Without the plug-in** the drawing looks and plots identical, and a person can select, move, edit and add to it with plain AutoCAD [D-015, D-094].
3.39 **On-screen-only CE marks** go on one CE layer set not to plot, named in the office list [D-275].

## 4. Changing a pit

4.1 **Double-click a pit:** opens the same window it was placed with [D-061, D-383].
4.2 **Double-click must not change how AutoCAD treats its own objects** (a plain block still opens its own editor); proof in AutoCAD owed [D-199].
4.3 **CDEDIT:** a typed command; he picks any CE part and the right window opens [D-383].
4.4 **Whether CDEDIT clashes with an old plug-in command or an AutoCAD name** [NOT RULED].
4.5 **AutoCAD's Properties palette, under a CE heading, editable there** [D-048, D-061].
4.6 **Whether Properties or an inspector window of our own is what he gets** (his question "CAN WE EDIT IN PROPERTIES OR A CD INSPECTOR WINDOW?" is owed an answer; Properties is not proven) [NOT RULED].
4.7 **Several pits at once:** one window, "Varies" where they differ; what he types goes to all, what he leaves is untouched on each; one Undo [D-381].
4.8 **Pits and pipes selected together:** nothing opens and the tool says so [D-381].
4.9 **Size changed** (window, the block's own stretch grips or its dynamic properties): each joined pipe end moves to the new wall, lengths and labels update, one Undo puts it all back [D-256].
4.10 **A pipe end keeps its angle from the pit centre;** an end placed by hand or not on the old wall is left alone and the tool says so [DRAFT D-260].
4.11 **A plastic pit stretched past 350:** whether it stays a plastic pit (cover text, schedule tick) [NOT RULED].
4.12 **Kind switched between grated and solid:** the pit on the plan, the schedule row, the lid class check and the detention storage tick all change from the one edit [D-257].
4.13 **Lid changed:** pick or type; a figure changed from its preset shows as typed over [D-080, D-150, D-287].
4.14 **Cover level changed:** only by the person; the cover text follows; levels worked along a run never touch it [D-078, D-171].
4.15 **Cover level cleared:** the old figure goes from the plan and TBC prints [D-178].
4.16 **Drop changed:** the levels that depend on it are worked out again; held figures stay [D-084, D-086].
4.17 **A held figure is never let go silently;** typing one level never releases another [DRAFT D-288].
4.18 **Too many figures held to all be true:** the tool names the stretch and the amount ("Out by 0.06 between P4 and P1"), lists the held figures and changes nothing [D-124, D-125].
4.19 **Turned:** by the window's Turn button, or plain ROTATE, which does the same; only the box turns, text stays upright, pipe ends follow the turned walls [D-266, D-267].
4.20 **The tag retyped on the drawing** (P3 typed as P7): it renames the pit; pipe names and the system strip follow; a duplicate shows amber on both [D-185].
4.21 **Pipe names follow the pits** ("P3 to P4"; "free end" for a loose end) [DRAFT D-261].
4.22 **The cover level text retyped by hand on the drawing:** levels are never changed by editing their text [D-185].
4.23 **What happens to that hand-typed cover text** (kept and flagged, as a hand-typed pipe label is, or put back) [NOT RULED].
4.24 **Grips:** text can be moved and flipped by grip; as many grips as there are now [D-033, D-037].
4.25 **Which grips a pit has, where, and what each does** (a trial grip crashed AutoCAD) [NOT RULED].
4.26 **"What else changes"** strip names everything else the change moves or rechecks [D-068, D-077].
4.27 **A pit drawn with the old plug-in's block:** readable; an edit is refused in words [DRAFT D-261].

## 5. Moving, stretching, copying, mirroring, arraying, erasing, exploding, undo

5.1 **MOVE:** the number and cover level text go with the pit; text moved by hand keeps its offset in both directions [D-181].
5.2 **Joined pipe ends follow the pit** to its walls [D-034, D-381].
5.3 **A move that changes a pipe's length:** Tim wants a small window to choose whether the levels or the grade give, showing the effect down the system; not settled, and it must fit one AutoCAD MOVE with one Undo [NOT RULED].
5.4 **A joined pipe on a locked layer:** the pit goes back where it was and the command line says "P3 not moved: its pipe P3 to P4 is on locked layer STORMWATER" [D-348].
5.5 **MOVE and the tool's follow-up are one Undo** [D-348].
5.6 **The pit's own insertion grip dragged:** whether that is treated exactly as MOVE [NOT RULED].
5.7 **STRETCH with a crossing window:** pits caught move; joined pipes follow at their ends whether or not inside the window; a pipe end caught without its pit comes off, "not joined yet" [D-381].
5.8 **Moving the whole plan with everything:** nothing changes: no join, level, label position, held figure or number, no window; proof in AutoCAD owed [D-381].
5.9 **COPY a single pit:** the copy takes the next free number at once [D-262].
5.10 **A copied pit's levels** come across marked assumed until confirmed [D-179].
5.11 **A copied pit is its own pit;** it never claims the original's joins [D-340].
5.12 **Copying a unit's drainage to the mirror unit:** sizes, kinds and grades copy as they are; levels copy marked assumed; copies take the next free numbers [D-179].
5.13 **How "assumed" looks in the window and on the drawing for a copied system** (a picture is owed) [NOT RULED].
5.14 **A tag or cover text copied on its own:** it is the drafter's own plain text; the tool never moves, renumbers or erases it, and says so once at the end of the COPY [D-340].
5.15 **Two tags claiming one pit** in an older drawing: both are left and it is listed ("P2 has two tags; click the real one") [D-340].
5.16 **Where that is listed in Stage 1** [NOT RULED].
5.17 **MIRROR:** text stays readable and is re-placed by the placing rules; a hand-moved label is mirrored to the matching spot; arrows still point with the flow [D-381].
5.18 **MIRROR that erases the source:** whether the pit keeps its number or takes the next free [NOT RULED].
5.19 **ARRAY, or pits inside an unexploded block:** not followed; the tool says once "parts inside an array or block are not followed; explode it to work on them" [D-340].
5.20 **ERASE:** the pit's tag, text and schedule row go; joined pipes stay and read "not joined yet"; one Undo brings everything back [D-221].
5.21 **A pit erased from the middle of a run:** whether the tool offers to join the two pipes into one [NOT RULED].
5.22 **EXPLODE of a pit** (a typed EXPLODE of a pipe is ruled; a pit was not asked) [NOT RULED].
5.23 **UNDO:** one pit per Undo when placing; one Undo per edit command [D-348, D-377].
5.24 **REDO after an Undo** [NOT RULED].
5.25 **SCALE of a pit or a whole system** [NOT RULED].
5.26 **A pit on a locked layer:** AutoCAD's own protection wins; nothing is unlocked or bypassed [D-199, D-348].
5.27 **The words for a locked layer, an xref or a reference edit** beyond the one ruled case [NOT RULED].
5.28 **A pit inside an xref:** whether the tool reads it, and that it never edits it [NOT RULED].
5.29 **A pit being edited inside REFEDIT** [NOT RULED].
5.30 **MATCHPROP or a layer changed by hand on a pit** [NOT RULED].
5.31 **Copy and paste between drawings, and WBLOCK** [NOT RULED].
5.32 **PURGE, AUDIT and RECOVER** [NOT RULED].
5.33 **Edited by someone without the plug-in, then reopened with it:** the tool's self-check reports what was changed by hand [DRAFT D-094].

## 6. Checks and words

6.1 **The words:** "Suits" (green), "Short" and "Wrong" (orange-red), "Needs a look" (amber), "Cannot check yet" (grey), "Not known" (grey; TBC on the sheet); each colour always with its word [D-219, D-295].
6.2 **No check ever blocks** placing or OK [D-124, D-140].
6.3 **Depth:** depth to outlet, cover level less outlet invert, shown as plain worked-out text [D-113, D-295].
6.4 **Cover not known:** the depth and every check built on it read "Cannot check yet", grey, never amber [D-219].
6.5 **Step irons:** a pit deeper than 1.0 m shows amber "Needs a look" [D-136, D-149].
6.6 **Size for depth:** the guidebook table (350 to 0.45, 450 to 0.60, 600 to 0.90, 600 x 900 to 1.20 with step irons, 900 x 900 deeper) is a guide offered when the depth is known; it never changes the size by itself; a council condition overrides [D-135, D-235].
6.7 **Whether the step-iron and size-for-depth checks are in Stage 1,** and whether the next size up is offered [NOT RULED].
6.8 **A pit deeper than 6 m:** amber "Needs a look", never Wrong [DRAFT D-288].
6.9 **Zero or negative depth:** Wrong, and checks built on it read "Cannot check yet" [DRAFT D-288].
6.10 **Tolerance:** levels are checked at their exact figure with the 5 mm tolerance ("Within the 5 mm tolerance") [D-321, D-350].
6.11 **Duplicate pit number:** amber on both [D-185].
6.12 **What the "lid class check" checks** and what it says [NOT RULED].
6.13 **Whether a joined pipe's short cover shows in the Pit window** as well as the Pipe window [NOT RULED].
6.14 **Where a drafter sees a pit's check results in Stage 1** (window only, on the drawing, on the command line) [NOT RULED].
6.15 **Plotting with open items:** one quiet command-line line with the count; plotting carries on [D-188].
6.16 **Software suggests, the engineer decides;** a standard is never bent by the tool [D-124, D-195].

## 7. Older drawings and the old plug-in's pits

7.1 **The old 16-state "Stormwater Pit" block** stays readable on old drawings; new pits never use it [D-228].
7.2 **An edit to an old-block pit** is refused in words [DRAFT D-261].
7.3 **Old hand-drawn drawings** open and plot; a tool to adopt them comes later [D-027].
7.4 **Drawings made with the old plug-in's special pipe:** a one-off "make it ordinary" tool, later, one drawing at a time on a copy [D-119].
7.5 **A plain line on a stormwater layer drawn by someone with no plug-in:** one line on opening with a "take it up" click; never automatic [D-192].
7.6 **The drawing keeps the standard values it was designed with;** on opening, one line says what has changed in the office list and offers to switch; nothing changes unless a person says so [D-180].
7.7 **A stand-in outline left by an earlier test build:** never swapped by itself; a "take it up" click once the office block is in the drawing [DRAFT D-261].
7.8 **A drawing opened on a PC without the tool, edited by hand, then reopened:** what exactly the drafter is told and offered [NOT RULED].

## 8. What the pit hands to other tools

8.1 **Pipe, start on the wall:** a click on the pit wall starts the pipe exactly there; a click inside the pit starts it on the wall facing the next click, square to it [D-034, D-383].
8.2 **Pipe, catching the pit:** only on or inside the pit's outer wall line joins, with no catch distance; the pit lights up when the cursor has caught it; the end is trimmed to the inner wall [D-102, D-270, D-383].
8.3 **Pipe, opening size:** a new pipe leaving a pit opens at the biggest pipe arriving; one that cannot be read is named [D-373, D-379].
8.4 **Pipe, levels:** the 0.02 drop across the pit; type one level in a run and the rest are worked out [D-141, D-383].
8.5 **Pipe, cover check ground:** a straight line between the two pit cover levels, plus points he adds [D-383].
8.6 **Pipe, names:** pipes named by their two pits [DRAFT D-261].
8.7 **Pit schedule (Stage 2):** one row per pit (one per inlet where a pit has several), plastic pits by their tick, cells that can be typed over and held, the council pit connected to [D-076, D-103, D-110, D-113].
8.8 **Schedule row order:** outlet first, following the flow [DRAFT D-288].
8.9 **Detention (Stage 2):** only pits he ticks; volume is plan size times water depth from the top water level; a ticked pit no pipe reaches is left out and said [D-105, D-343].
8.10 **Plan size for storage:** the size the pit is drawn at; a typed figure stands [DRAFT D-285].
8.11 **Unfinished list (Stage 2):** TBC covers, assumed levels, two tags on one pit, overlapping text [D-311, D-340, D-368].
8.12 **Job window (Stage 2):** council lid override, tolerance, scale; the same drawing picks them up when it arrives [D-310, D-381].
8.13 **Legal point (Stage 2):** marks the outlet that pit numbering runs from [D-075, D-274].
8.14 **Later kinds:** orifice pit (one detail per council), pump pit with its own sums, bought-in units; silt and soakage pits later still [D-104, D-247, D-252, D-253].
8.15 **Everything above marked Stage 2 waits until Tim has drafted with Stage 1** [D-347].

## 9. Settings (each a line in the office list; none typed into the program)

9.1 **PT opening size:** 450 x 450 [D-323].
9.2 **PP opening size:** 350 x 350, plastic [D-323].
9.3 **Opening choices per tool:** last used, switchable to always office default [D-263].
9.4 **Where last used choices live:** a small CE file of the tool's own, kept between sessions, never an AutoCAD setting, profile or registry entry [D-263].
9.5 **Pit number distance:** 900 mm above the pit centre [D-366].
9.6 **Cover level distance:** 400 mm off the corner [D-366].
9.7 **Drop across a pit:** 0.02 [D-141].
9.8 **Level and cover tolerance:** 5 mm [D-321].
9.9 **Step irons needed deeper than:** 1.0 m [D-136].
9.10 **Size for depth guide:** the guidebook table in 6.6 [D-135].
9.11 **"What is over it" presets:** ten lines, each with cover and lid class (garden house 100 A; garden units 300 A; footpath 75 A; house driveway concrete 100 C; house driveway pavers 75 C; common driveway 100 C; basement 100 C; truck hardstand 100 D; vehicles no paving 450 C; council road the council's cover, D) [D-287].
9.12 **Text sized for:** a 1:100 viewport [D-381].
9.13 **The actual heights of the pit number and cover text** [NOT RULED].
9.14 **Office block folder path:** one data setting [D-352].
9.15 **"Needs a look" pit depth limit:** 6 m [DRAFT D-288].
9.16 **The CE no-plot layer name** [D-275].
9.17 **One place for standards,** the drawing keeping its own copy of the values it was designed with [D-013, D-180].
9.18 **Where a drafter changes any of these in Stage 1,** with no Job window [NOT RULED].

---

## 10. Every gap

Each item names the lines it covers, gives a drafting example, a recommended answer, and the matching unknown in `UNKNOWNS.md` (or "new").

1. **Other load order (1.4).** If the new plug-in loads first and the old one second, does PT still open the new window? *Example:* a colleague's PC loads the CE bundle before the old suite. *Recommend:* test it on a test copy; if the old one wins, the new tool says so once at load. *Unknown:* U-003.
2. **Non-millimetre drawings (1.7).** What happens in a drawing with no units set, or inches? *Example:* an architect's file set to "Unitless". *Recommend:* treat unitless as millimetres with one grey line saying so; refuse inches like metres. *Unknown:* new.
3. **Clicked on a layout sheet (1.8).** *Example:* he types PT while in the A1 layout, not through a viewport. *Recommend:* refuse in words ("pits go in the plan: switch to model space"). *Unknown:* new.
4. **Read-only drawing (1.9).** *Example:* the drawing is open read-only because a colleague has it. *Recommend:* say so before the first click, draw nothing. *Unknown:* new.
5. **A differing PIT BLOCK 3 in the drawing (1.14).** *Example:* an old job holds a hand-edited PIT BLOCK 3 with a different stretch. *Recommend:* use the drawing's own, never overwrite it, report once if it lacks a size or state the tool needs. *Unknown:* new.
6. **Block copy not found (1.15).** What does it say and what does he do next? *Example:* the plug-in folder was partly deleted. *Recommend:* "The office pit block could not be found in the CE folder; nothing drawn. Reinstall CE or tell Tim." *Unknown:* U-025.
7. **Wipeout frame warning words (1.17).** *Example:* WIPEOUTFRAME is 0 so the inner wall vanishes. *Recommend:* one line when a pit is first placed in a drawing whose setting hides the frame, naming the setting and the value to set. *Unknown:* U-007.
8. **Save As of the last job (1.20).** *Example:* he Save-As's last week's job and its pits P1 to P6 are still in it. *Recommend:* same-job Save As keeps everything; for a new job, inherited levels are marked assumed until confirmed. *Unknown:* U-006.
9. **Cursor pit before the click (2.1).** Is the real block at 450 (or 350 for PP) on the cursor before the window? *Example:* PT, the 450 junction pit follows the cursor with TBC in grey. *Recommend:* yes, as described. *Unknown:* new (D-267 predates D-354).
10. **Cursor point key (2.4).** *Example:* placing a pit hard into a corner by its top-left corner. *Recommend:* Tab steps the point. *Unknown:* U-020 (part).
11. **Snaps while placing (2.5).** *Example:* snapping the pit centre to the end of a stormwater line with ENDpoint, ortho on. *Recommend:* every AutoCAD snap, ortho, polar, zoom and pan works unchanged. *Unknown:* U-020, U-040.
12. **Prompt words (2.6).** *Example:* "Click where the pit goes [Enter to finish]:". *Recommend:* settle in the release wording pass; plain words. *Unknown:* new.
13. **Hover (2.7).** *Example:* the cursor passes over P3 while placing P4. *Recommend:* the pit under the cursor lights; a tip shows its number and cover level. *Unknown:* U-103.
14. **Which half's grade gives (2.10).** *Example:* IL 12.40 and 12.30 typed, 10 m at 1 in 100, P7 halfway with a 0.02 drop. *Recommend:* split the fall evenly (about 12.36 in, 12.34 out), both halves shown worked out. *Unknown:* new (TR-041 note).
15. **Pipe selected before PT (2.13).** *Example:* he selects a pipe, then types PT. *Recommend:* ignore the selection and ask for the click, as AutoCAD's INSERT does. *Unknown:* U-024.
16. **Where the window opens (2.15).** *Example:* two monitors, drawing on the left. *Recommend:* centred over the AutoCAD window, then where he last left it. *Unknown:* U-094, U-105.
17. **Window size (2.16).** *Example:* the 1366-wide drafting laptop and the 1440 desktop. *Recommend:* two set sizes, laptop and desktop, chosen from the AutoCAD window size, never scrolling. *Unknown:* U-011, U-096.
18. **The window line by line (2.21, 2.50).** Which boxes, in what order, what words, and what the answer band says? *Example:* band "P4 · 0.85 deep · Suits". *Recommend:* show one full-size picture and go through it with him once. *Unknown:* U-012.
19. **Kind against size (2.23).** *Example:* PT opens 450, he picks Plastic. *Recommend:* Plastic sets 350 x 350 and greys other sizes; leaving Plastic restores 450. *Unknown:* new.
20. **Typing a pit size (2.25).** *Example:* he wants to type "600x900" rather than pick. *Recommend:* pick only, with all 25 pairs offered; nothing to type means nothing refused. *Unknown:* new (U-012 area).
21. **600 x 900 orientation (2.26).** *Example:* a 600 x 900 pit against a boundary. *Recommend:* first figure across the sheet; Turn for the rest; read from the block's own widths. *Unknown:* new.
22. **Lid opening value (2.30).** *Example:* a driveway pit, nothing set for "what is over it". *Recommend:* lid opens with last used (D-263) and reads as chosen; the preset fills it only when he sets "what is over it". *Unknown:* new.
23. **Lid words (2.31).** *Example:* "CLASS C HEEL SAFE GRATED". *Recommend:* read the wording off three issued schedules, then put to him. *Unknown:* new.
24. **Cover level help (2.37).** *Example:* the house FFL is 13.20 and the paving falls away. *Recommend:* leave out of Stage 1. *Unknown:* U-023.
25. **Number in the window (2.39).** *Example:* he wants this pit to be P10. *Recommend:* yes, the number is a box; a duplicate shows amber. *Unknown:* new.
26. **Outlet level from several arrivals (2.42).** *Example:* arrivals at 5.30 and 5.25. *Recommend:* work from the lowest arriving invert. *Unknown:* new (part 2 finding 19).
27. **Schedule and detention ticks in Stage 1 (2.45, 2.46).** *Example:* a plastic pit placed in Stage 1. *Recommend:* show and store both ticks now so nothing is lost; they act when Stage 2 arrives. *Unknown:* new.
28. **Inspect button (2.48).** *Example:* he wants to glance at the house wall behind the window. *Recommend:* keep it bottom left; it hides the window, keeps every figure typed. *Unknown:* U-110.
29. **Match (2.49).** *Example:* make this pit like P2. *Recommend:* keep a quiet "Match a pit" button bottom left. *Unknown:* new.
30. **Preview size and zoom (2.55).** *Example:* a 600 pit in a tight side setback. *Recommend:* about a third of the window, zoomed to the pit and its pipes, scroll wheel zooms. *Unknown:* U-013.
31. **Also on the drawing behind (2.56).** *Example:* moving the window aside to see the pit. *Recommend:* preview only in Stage 1; nothing painted behind. *Unknown:* U-100.
32. **Ending the clicks (2.60).** *Example:* after P6 he is done. *Recommend:* Enter, Space or right-click ends, as in AutoCAD. *Unknown:* new.
33. **After Cancel (2.62).** *Example:* he cancels P5 because he clicked the wrong spot. *Recommend:* back to "click where the pit goes"; Enter then ends. *Unknown:* new.
34. **Escape and half-filled window (2.63, 2.64).** *Example:* Escape pressed by habit with a cover level typed. *Recommend:* Escape cancels like Cancel; nothing offered back. *Unknown:* U-051.
35. **Click budget (2.66).** *Example:* one pit with a cover level. *Recommend:* type PT, one click, type the cover level, Enter: 1 command, 1 pick, 1 field. *Unknown:* U-095.
36. **Speed limits (2.67).** *Example:* the window lags as he types. *Recommend:* confirm 0.3 s open and 0.1 s redraw. *Unknown:* new.
37. **Renumber in Stage 1 (2.70).** *Example:* six pits placed back to front before any outlet exists. *Recommend:* a Renumber button in the Pit window that numbers from a pit he picks as the outlet. *Unknown:* new.
38. **After-issue choice (2.74).** *Example:* a pit added between P3 and P4 after issue. *Recommend:* next free number first. *Unknown:* U-206.
39. **Kind looks (3.2).** *Example:* junction pit shows the solid cross. *Recommend:* confirm as drafted. *Unknown:* new.
40. **Plastic cover text (3.4).** How does "PP over CL" sit when the cover level is at 45 degrees? *Example:* a 350 plastic pit in a garden. *Recommend:* the two lines turned 45 degrees together off the corner. *Unknown:* new.
41. **Inner wall distance (3.7).** *Example:* how far inside the dashed line a 450 pit's pipe ends. *Recommend:* measure PIT BLOCK 3 at all five sizes, then show him. *Unknown:* U-031.
42. **Pit layer (3.10).** *Example:* every pit lands on a layer he can freeze for a services plan. *Recommend:* read the layer from the office template's existing pits; put to him with that answer. *Unknown:* new.
43. **Text layer (3.11).** *Example:* he freezes pit numbers for a coordination plan. *Recommend:* same as the office's existing pit text layer, read from issued jobs. *Unknown:* new.
44. **Colour and lineweight (3.12).** *Recommend:* ByLayer throughout. *Unknown:* new.
45. **Elevation and scale (3.13).** *Example:* a pit block at Z 100 after an architect's file. *Recommend:* place at Z 0, scale 1; never change either on edits. *Unknown:* new (part 2 finding 22).
46. **Number circled (3.15).** *Example:* "P3" in a circle as on issued sheets. *Recommend:* yes, the office's circled tag. *Unknown:* U-076 (closed for position only).
47. **Beside order (3.18).** *Example:* pipes leave above and below. *Recommend:* right first, then left. *Unknown:* new.
48. **Where the 900 is measured to (3.19).** *Recommend:* to the centre of the tag. *Unknown:* new.
49. **Round the pit, and from which corner (3.21).** *Recommend:* clockwise from top right; 400 from the outer dashed corner to the near end of the text. *Unknown:* new.
50. **45 degrees on a turned pit (3.23).** *Example:* a pit turned 30 degrees to follow a fence. *Recommend:* the cover level stays at 45 degrees to the sheet, off the nearest turned corner. *Unknown:* new (D-267 against D-363).
51. **"CL" wording (3.24).** *Recommend:* "CL 12.95" as on issued sheets; "CL TBC" when not known. *Unknown:* new.
52. **APPROX. note reminder in Stage 1 (3.29).** *Example:* a copied unit's pits print APPROX. *Recommend:* one command-line line after the copy reminding him to place the note. *Unknown:* new.
53. **Text style and height (3.30, 9.13).** *Recommend:* read off the office template and issued sheets, put the figure to him. *Unknown:* new (LABELS open 8).
54. **Masks (3.31).** *Recommend:* on from day one, margin as the office text. *Unknown:* U-079.
55. **Overlap flag in Stage 1 (3.33, 5.16, 6.14).** Where does he see an overlap, two tags, or a check result? *Example:* P4's number lands on a pipe label. *Recommend:* in the Pit window band and one command-line line on OK. *Unknown:* U-082.
56. **What counts as a clash (3.34).** *Recommend:* other CE text, pipe bands, pit outlines and any text; not hatching or plain linework. *Unknown:* new.
57. **Level below 0.00 (3.37).** *Example:* a bayside job at RL -0.20. *Recommend:* confirm amber "check the datum". *Unknown:* new.
58. **CDEDIT name (4.4).** *Recommend:* check the old plug-in and AutoCAD lists before it ships. *Unknown:* new.
59. **Properties or own panel (4.6).** *Example:* change a cover level without opening the window. *Recommend:* Properties if the night proof passes, otherwise double-click and CDEDIT only. *Unknown:* U-052.
60. **End angle on resize (4.10).** *Example:* a pipe enters a 450 at an angle, pit goes to 900. *Recommend:* confirm. *Unknown:* U-050.
61. **Plastic stretched (4.11).** *Example:* a plastic pit stretched to 600 by grip. *Recommend:* it becomes a junction pit, said once. *Unknown:* new (part 2 finding 37).
62. **Held figure never let go (4.17).** *Recommend:* confirm. *Unknown:* new.
63. **Pipe names (4.21, 8.6).** *Recommend:* confirm "P3 to P4" and "free end". *Unknown:* new.
64. **Hand-typed cover text (4.23).** *Example:* he types "CL 13.10" over "CL 12.95". *Recommend:* keep his words, flag "no longer matches", one click to follow again (as D-182 for labels). *Unknown:* new.
65. **Grips (4.25).** *Example:* flipping the cover level to another corner. *Recommend:* show a picture of each grip first, then test. *Unknown:* U-057.
66. **Old-block pit edit refused (4.27, 7.2).** *Example:* double-click an old 16-state pit. *Recommend:* confirm; the words offer the later "take it up". *Unknown:* U-091.
67. **Length change on a move (5.3).** *Example:* a pit moved 2 m, its 10 m pipe at 1 in 100 with both levels typed. *Recommend:* the move finishes; typed levels stay and the grade changes; the band says so on next open. *Unknown:* U-053, U-113.
68. **Insertion grip (5.6).** *Recommend:* treated exactly as MOVE. *Unknown:* new.
69. **Assumed look on a copied system (5.13).** *Recommend:* APPROX. on the sheet, "Assumed" tag in the window. *Unknown:* U-063.
70. **MIRROR erasing source (5.18).** *Example:* mirror unit 1's pits, erase source "Yes". *Recommend:* the pits keep their numbers. *Unknown:* new.
71. **Erase mid-run (5.21).** *Recommend:* leave both pipes "not joined yet". *Unknown:* U-070.
72. **EXPLODE of a pit (5.22).** *Recommend:* AutoCAD's own explode of the block; the tool stops following it and says so once; one Undo restores. *Unknown:* U-066.
73. **REDO (5.24).** *Recommend:* REDO puts back exactly what Undo took. *Unknown:* new.
74. **SCALE (5.25).** *Example:* a system scaled by mistake by 1000. *Recommend:* pits keep their real size; refused in words. *Unknown:* U-060.
75. **Locked, xref, REFEDIT words and behaviour (5.27, 5.28, 5.29).** *Recommend:* xref pits read only, never edited; REFEDIT edits refused in words. *Unknown:* U-061.
76. **MATCHPROP and layer change (5.30).** *Recommend:* allowed; layer change shown amber. *Unknown:* U-065.
77. **Paste and WBLOCK (5.31).** *Recommend:* pasted pits are new pits with next free numbers, levels assumed. *Unknown:* U-064.
78. **PURGE, AUDIT, RECOVER (5.32).** *Recommend:* test that pits survive all three. *Unknown:* U-071.
79. **Edited without the plug-in (5.33, 7.8).** *Recommend:* one line on opening listing parts changed by hand, with "take it up". *Unknown:* U-092.
80. **Depth checks in Stage 1 (6.7).** *Recommend:* yes, step irons and the size guide, with a quiet offer of the next size. *Unknown:* U-088.
81. **6 m and zero depth (6.8, 6.9, 9.15).** *Recommend:* confirm. *Unknown:* new.
82. **Lid class check (6.12).** *Recommend:* compare the lid class with the "what is over it" preset only when that is set; otherwise "Cannot check yet". *Unknown:* new.
83. **Pipe cover in Pit window (6.13).** *Recommend:* yes, the worst joined pipe's cover shows in the Pit band. *Unknown:* new.
84. **Stand-in take up (7.7).** *Recommend:* confirm. *Unknown:* new.
85. **Schedule row order (8.8).** *Recommend:* outlet first, following the flow. *Unknown:* U-207.
86. **Storage plan size (8.10).** *Recommend:* confirm. *Unknown:* new.
87. **Where settings are changed in Stage 1 (9.18).** *Example:* he wants the tag at 600 not 900 on this job. *Recommend:* a small CE settings window reached from the Pit window. *Unknown:* new.
