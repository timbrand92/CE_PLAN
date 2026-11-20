# FOLD DRAFT: every "Every gap" question, sorted against Tim's answers and the open unknowns

**What this is.** A filing draft, not a ruling. It takes every question in the two "Every gap" lists and sorts it against Tim's answers (TR-001 to TR-081 in `interview\ANSWERS_TIM.md`) and the unknowns list (`UNKNOWNS.md`), so the questions still worth asking Tim are few, plain and batched. It changes no other file. Nothing here is a decision until Tim says so (rule 3.4).

**Written:** Fri 20 Nov 2026, 13:18 (clock read, `date`) and finished the same afternoon. Spec pages read were written from decisions up to D-383 and TR-069; the newest answers are TR-070 to TR-081.

**Counts**

1. **Questions read:** 87 from SPEC_PIT section 10 plus 122 from SPEC_PIPE section 12 = **209**.
2. **A, answered already:** 14 (5 from PIT, 9 from PIPE).
3. **B, same as an open unknown:** 76 (30 PIT, 46 PIPE).
4. **C, partly answered:** 27 (14 PIT, 13 PIPE).
5. **D, new:** 92 (38 PIT, 54 PIPE).
6. **Check:** 14 + 76 + 27 + 92 = 209. Lines in Part 1 (C and D) = 119, in Part 2 (B) = 76, in Part 3 (A) = 14; 119 + 76 + 14 = **209**.
7. **Of the 195 B, C and D lines:** **117 block Stage 1** (86 C/D, 31 B) and **78 can wait** (33 C/D, 45 B).
8. **Kind, all 195 lines:** plain confirm 112; real choice 23; needs a picture first 34; needs research first 13; a test, not a question 13 (sum 195).
9. **Kind, only the 117 that block Stage 1:** plain confirm 55; real choice 18; needs a picture first 26; needs research first 9; a test, not a question 9 (sum 117).
10. **Plain confirms that block Stage 1** go in 6 batches (Part 4): five of ten and one of five = 55.
11. **Duplicates:** at least 14 questions are asked on both pages (layout sheet, read-only, units, speed, wording, which half's grade, several arrivals, pipe names, clash, APPROX reminder, text style, REDO, CDEDIT, settings). Each source question still has its own line so the counts add up; answer each pair once.

---

# PART 1: NEW AND PARTLY ANSWERED (C and D)

Grouped by the drafter's moment. N-numbers are my own temporary numbers. "PIT n" is SPEC_PIT section 10 item n; "PIPE n" is SPEC_PIPE section 12 item n; the spec's own line number is in brackets. A line marked "same as N-xxx" is the same question asked on the other page; answer it once. Tim's picks of an offered option are quoted as the option text.

## Starting a drawing

**N-001** **Source:** PIT 2 (spec 1.7). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** When a drawing's units are "unitless" or inches, does the tool draw as millimetres or refuse? **Example:** an architect's file left on "Unitless". **Recommended (PIT page):** treat unitless as millimetres with one grey line saying so; refuse inches like metres. The PIPE page recommends the opposite for unitless (N-002). TR-047 refused metres only.

**N-002** **Source:** PIPE 5 (spec 1.10). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Same as N-001: a drawing with the units not set. **Example:** an architect's drawing with units left "unitless". **Recommended (PIPE page):** refuse like a metre drawing and say "set the drawing units to millimetres", because guessing could draw a pipe 1,000 times out. Answer once with N-001.

**N-003** **Source:** PIT 3 (spec 1.8). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** If he types PT on a layout sheet, does the tool refuse and say why? **Example:** he types PT while in the A1 layout, not through a viewport. **Recommended:** refuse in words ("pits go in the plan: switch to model space").

**N-004** **Source:** PIPE 3 (spec 1.7). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Same as N-003, for CD. **Example:** he types CD on the sheet out of habit. **Recommended:** refuse with "Pipes are drawn in the model; switch to Model and type CD again", drawing nothing.

**N-005** **Source:** PIT 4 (spec 1.9). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What does the tool do in a drawing opened read-only? **Example:** the drawing is open read-only because a colleague has it. **Recommended:** say so before the first click and draw nothing.

**N-006** **Source:** PIPE 4 (spec 1.8). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Same as N-005, for the Pipe tool. **Example:** a drawing opened read-only from the job folder. **Recommended:** refuse before the first click, saying the drawing is read-only.

**N-007** **Source:** PIT 5 (spec 1.14). **Blocks:** can wait (an old-job case; new jobs start from the template, D-191). **Kind:** plain confirm. **Question:** If the drawing already holds a different PIT BLOCK 3 (older or hand-edited), which one does the tool use? **Example:** an old job holds a hand-edited block with a different stretch. **Recommended:** use the drawing's own, never overwrite it, report once if it lacks a size or state the tool needs.

**N-008** **Source:** PIPE 1 (spec 1.3). **Blocks:** can wait (typed CD and PIPE work without it; the Civil ribbon is its own piece). **Kind:** needs a picture first. **Question:** Where does the Pipe button sit on the CE Civil tab and what does it say? **Example:** a drafter who does not know CD looks for the pipe on the ribbon. **Recommended:** first button on the CE Civil tab, labelled "Pipe", beside "Pit".

## Placing a pit

**N-009** **Source:** PIT 9 (spec 2.1). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Does the real pit block, at its opening size, ride the cursor before the click? **Example:** PT typed, the 450 junction pit follows the cursor with TBC in grey. **Recommended:** yes. **PARTLY ANSWERED:** TR-058 (the pit starts on the cursor by its centre, a key steps the corners) and TR-053 (one click places it square). **Left to ask:** that what rides the cursor is the real block at 450 (350 plastic for PP) with grey TBC, not an outline.

**N-010** **Source:** PIT 10 (spec 2.4). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Which key steps the cursor point round the pit's corners? **Example:** placing a pit hard into a corner by its top-left corner. **Recommended:** Tab. **PARTLY ANSWERED:** TR-058 ("Centre, with a key to cycle corners"). **Left to ask:** which key (Tab was only an example); a test must show the key is free in AutoCAD.

**N-011** **Source:** PIT 45 (spec 3.13). **Blocks:** blocks Stage 1 (drawing safety). **Kind:** plain confirm. **Question:** At what height and scale is the pit block placed, and do edits ever change them? **Example:** a pit block at Z 100 after an architect's file. **Recommended:** place at Z 0, scale 1; never change either on edits.

**N-012** **Source:** PIT 14 (spec 2.10). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** A pit dropped on the middle of a pipe whose outer levels are both typed: once the 0.02 drop goes in, which half's grade gives? **Example:** IL 12.40 and 12.30 typed, 10 m at 1 in 100, P7 half way. **Recommended:** split the fall evenly (about 12.36 in, 12.34 out); both halves shown as worked out. TR-041's own note says this was never asked.

**N-013** **Source:** PIPE 99 (spec 7.35). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Same as N-012. **Example:** P7 dropped half way along a 10 m pipe at 1 in 100 with both ends typed. **Recommended:** split the difference evenly (both halves equal grade), shown as worked out.

**N-014** **Source:** PIT 32 (spec 2.60). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** How does he end a run of pit clicks? **Example:** after P6 he is done. **Recommended:** Enter, Space or right-click, as in AutoCAD. (D-186 said "Enter to finish" before TR-006 made it click, window, OK for each pit.)

**N-015** **Source:** PIT 33 (spec 2.62). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** After he cancels one pit's window, does the tool wait for the next click or end? **Example:** he cancels P5 because he clicked the wrong spot. **Recommended:** back to "click where the pit goes"; Enter then ends.

**N-016** **Source:** PIT 37 (spec 2.70). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Where is the Renumber button in Stage 1, and what does it number from with no legal point tool yet? **Example:** six pits placed back to front before any outlet exists. **Recommended:** a Renumber button in the Pit window that numbers from a pit he picks as the outlet. **PARTLY ANSWERED:** TR-034 (an erased number is never reused; "the Renumber button closes gaps when asked"). **Left to ask:** where the button sits and which pit it counts from in Stage 1.

**N-017** **Source:** PIT 39 (spec 3.2). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Does a junction pit show the block's solid look with the cross and a grated pit its grated look? **Example:** a junction pit shows the solid cross. **Recommended:** confirm as drafted.

**N-018** **Source:** PIT 12 (spec 2.6). **Blocks:** can wait (draft words work until the wording pass). **Kind:** plain confirm. **Question:** Who settles the exact command-line words for placing pits? **Example:** "Click where the pit goes [Enter to finish]:". **Recommended:** settle in the release wording pass; plain words.

## The Pit window

**N-019** **Source:** PIT 19 (spec 2.23). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** When he picks Plastic while the size reads 450 x 450, does the size change (and change back when he leaves Plastic)? **Example:** PT opens at 450, he picks Plastic. **Recommended:** Plastic sets 350 x 350 and greys the other sizes; leaving Plastic restores 450. TR-052 listed the kinds only.

**N-020** **Source:** PIT 20 (spec 2.25). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Can the pit size be typed as well as picked? **Example:** he wants to type "600x900" rather than pick. **Recommended:** pick only, with all 25 pairs offered; nothing typed means nothing refused. (D-080 list-only was replaced by D-272 without saying.)

**N-021** **Source:** PIT 21 (spec 2.26). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Which way does a 600 x 900 pit run when placed? **Example:** a 600 x 900 pit against a boundary. **Recommended:** first figure across the sheet; Turn for the rest; read from the block's own widths.

**N-022** **Source:** PIT 22 (spec 2.30). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What does the Lid box open with when "what is over it" is Not known? **Example:** a driveway pit with nothing set for "what is over it". **Recommended:** it opens with last used and reads as chosen; the preset fills it only when he sets "what is over it". (D-287 gives a class from the preset; TR-063 opens "what is over it" as Not known.)

**N-023** **Source:** PIT 25 (spec 2.39). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the pit number a box he can type in the window? **Example:** he wants this pit to be P10. **Recommended:** yes; a duplicate shows amber on both. **PARTLY ANSWERED:** TR-081 ("Nothing: it is right as drawn"; the picture lists Number in step 1, "What you type"). **Left to ask:** only that the Number box takes typing (his words do not name it).

**N-024** **Source:** PIT 26 (spec 2.42). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** With several pipes arriving at different levels, which arriving invert is the pit's outlet level worked from? **Example:** arrivals at 5.30 and 5.25. **Recommended:** work from the lowest arriving invert. Same as N-055.

**N-025** **Source:** PIT 50 (spec 3.23). **Blocks:** blocks Stage 1 (Turn is in the Stage 1 window). **Kind:** real choice. **Question:** On a turned pit, does the cover level stay at 45 degrees to the sheet or turn with the pit? **Example:** a pit turned 30 degrees to follow a fence. **Recommended:** stays at 45 degrees to the sheet, off the nearest turned corner. The spec names this as D-267 against D-363; TR-012's note says the room read it that way, Tim did not say it.

**N-026** **Source:** PIT 23 (spec 2.31). **Blocks:** can wait (Stage 2: lid words print in the pit schedule). **Kind:** needs research first. **Question:** What are the exact lid words and how do they print? **Example:** "CLASS C HEEL SAFE GRATED". **Recommended:** read the wording off three issued schedules, then put to him.

**N-027** **Source:** PIT 27 (spec 2.45, 2.46). **Blocks:** can wait (Stage 2: schedule and detention). **Kind:** plain confirm. **Question:** Do the "in the schedule" and "holds detention water" ticks show in the Stage 1 window? **Example:** a plastic pit placed in Stage 1. **Recommended:** show and store both now. **PARTLY ANSWERED:** TR-081 ("the two ticks" in the approved picture, which TR-039 names as Tag and Cover level text). **Left to ask:** confirm the schedule and detention ticks are stored from day one but not shown in Stage 1.

**N-028** **Source:** PIT 29 (spec 2.49). **Blocks:** can wait. **Kind:** plain confirm. **Question:** Does the Match button (copy the choices from a pit already drawn) stay? **Example:** make this pit like P2. **Recommended:** keep a quiet "Match a pit" button bottom left. **PARTLY ANSWERED:** TR-081 approved the window as drawn, and the drawn window has no Match. **Left to ask:** confirm Match stays out of Stage 1.

**N-029** **Source:** PIT 30 (spec 2.55). **Blocks:** can wait. **Kind:** plain confirm. **Question:** How big is the plan preview and does it zoom? **Example:** a 600 pit in a tight side setback. **Recommended:** about a third of the window, zoomed to the pit and its pipes, wheel zooms. **PARTLY ANSWERED:** TR-078 (about 40 per cent of the window, "Yes, that is it") and TR-080 (zooming the plan panel was offered and not taken). **Left to ask:** only the starting zoom around the pit; wheel zoom is already declined.

**N-030** **Source:** PIT 36 (spec 2.67). **Blocks:** can wait (a build target proved by a timed test). **Kind:** plain confirm. **Question:** Are 0.3 seconds to open and 0.1 seconds to redraw after a keystroke right? **Example:** the window lags as he types. **Recommended:** confirm.

**N-031** **Source:** PIT 86 (spec 8.10). **Blocks:** can wait (Stage 2: detention). **Kind:** plain confirm. **Question:** For storage, is a pit's plan size the size it is drawn at, with a typed figure standing? **Example:** a 900 x 900 pit used for detention. **Recommended:** confirm.

## Drawing a pipe run

**N-032** **Source:** PIPE 11 (spec 2.3). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** How does the first prompt tell "use this polyline as my run" from "start a pipe here" when the click lands on a polyline? **Example:** he wants to start a pipe on the corner of a plain sketch line that is not meant to be the run. **Recommended:** the prompt reads "Click the start, or [Polyline]"; typing P (or clicking the option) then picks a polyline; a plain click is always a start point.

**N-033** **Source:** PIPE 16 (spec 2.20). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** When a run starts on the open end of a loose pipe already drawn, does the new run join end to end or carry the old pipe on as one? **Example:** he drew a loose 100 from the back downpipe yesterday and now continues it to P2. **Recommended:** the new run joins that end as a pipe-to-pipe join; the window shows both, with the old pipe's size as the arriving size. **PARTLY ANSWERED:** TR-027 ("Join them, old pipe stays one": a run starting on an existing pipe joins part way, the old pipe keeps one label, the level at the join is worked out). **Left to ask:** the case of a loose pipe's open END rather than its side.

**N-034** **Source:** PIPE 17 (spec 2.25). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Where do the two ends sit at a pit a run passes through? **Example:** a run clicked P1 to P5 that passes straight through P3 off-centre. **Recommended:** each pipe meets the wall where the drawn line crosses it, so the plan shows exactly what he drew. (TR-059 ruled only the start of a pipe.)

**N-035** **Source:** PIPE 18 (spec 2.27). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Where does a pipe end when his last click is inside a pit? **Example:** he ends the run with a click in the middle of P1. **Recommended:** on the wall facing where the run came from, square to it, at the inner wall (the mirror of TR-059).

**N-036** **Source:** PIPE 21 (spec 2.35). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What do Escape, a Close option and "one click then Enter" do while clicking a run? **Example:** he clicks once, changes his mind and presses Escape. **Recommended:** Escape ends with nothing drawn; no Close option (a closed run is refused as for polylines); one click then Enter ends with nothing drawn and a line saying a pipe needs two points.

**N-037** **Source:** PIPE 23 (spec 2.40). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is a picked polyline's width ever read as the pipe size? **Example:** a 375 wide sketch polyline picked as the run. **Recommended:** no; the width is ignored and the run opens at the biggest pipe arriving, else 100. (TR-008 is silent on width.)

**N-038** **Source:** PIPE 24 (spec 2.41). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Do a picked polyline's layer and colour carry to the pipes? **Example:** a sketch on layer 0 in red. **Recommended:** no; the pipes go on the pipe layer.

**N-039** **Source:** PIPE 26 (spec 2.46). **Blocks:** blocks Stage 1 (drawing safety). **Kind:** plain confirm. **Question:** If he cancels the window after picking a polyline, is the polyline left exactly as it was? **Example:** he picks a sketch polyline, opens the window, then Cancels. **Recommended:** yes, left exactly as it was with all its points. (TR-008 covers Undo after OK only.)

**N-040** **Source:** PIPE 56 (spec 4.2). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the drawn band as wide as the pipe size? **Example:** a 100 pipe is a 100 wide band, as drawn today. **Recommended:** yes. **PARTLY ANSWERED:** TR-067 ("The pipe band at its real width", on the cursor). **Left to ask:** confirm the finished band is the same full-size width.

**N-041** **Source:** PIPE 8 (spec 1.16). **Blocks:** can wait (the polyline-pick route already works from the prompt). **Kind:** plain confirm. **Question:** If something is already selected when CD is typed, does the tool use it? **Example:** he selects a polyline sketch, then types CD. **Recommended:** use a single selected plain polyline as the run (as if picked); anything else selected is ignored. (U-024 asks the same for a pit.)

**N-042** **Source:** PIPE 10 (spec 1.18). **Blocks:** can wait (same as N-018). **Kind:** plain confirm. **Question:** Who settles the exact command-line prompts and messages for the Pipe tool? **Example:** the first prompt after CD. **Recommended:** one wording sheet shown to Tim as a tick list before he drafts.

**N-043** **Source:** PIPE 15 (spec 2.18). **Blocks:** can wait (Stage 2: inlets). **Kind:** plain confirm. **Question:** Does Stage 1 offer an inspection opening at all? **Example:** a branch joins at a bend but the Inlet tool is not in Stage 1. **Recommended:** Stage 1 shows nothing; the offer arrives with the Inlet tool.

**N-044** **Source:** PIPE 25 (spec 2.42). **Blocks:** can wait (TR-028 already refuses curved pieces with the reason). **Kind:** plain confirm. **Question:** Can a LINE, a spline or a 3D polyline be picked as a run? **Example:** a LINE, a spline or a 3D polyline picked. **Recommended:** a LINE is a one-length run; a spline, a 3D polyline with varying height, or anything inside a block is refused with the reason.

**N-045** **Source:** PIPE 27 (spec 2.47). **Blocks:** can wait (a new convenience, not a gap in the rulings). **Kind:** real choice. **Question:** After a mistaken Cancel, can he get his clicked run back? **Example:** he presses Cancel by mistake after clicking a long run. **Recommended:** typing CD again offers "Use the last run" for that drawing until something else is drawn.

## The Pipe window

**N-046** **Source:** PIPE 28 (spec 3.3). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is a pipe's length always measured from the drawing and never typed? **Example:** a pipe whose real length on site differs from the plan. **Recommended:** yes; to change it, change the drawing.

**N-047** **Source:** PIPE 29 (spec 3.5). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** How is a pipe named in the window? **Example:** the pipe from P4 to P3. **Recommended:** "P4 to P3", and "free end" for a loose end.

**N-048** **Source:** PIT 63 (spec 4.21, 8.6). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Same as N-047, seen from the pit side: pipe names follow the pits. **Example:** "P3 to P4"; a loose end reads "free end". **Recommended:** confirm.

**N-049** **Source:** PIPE 30 (spec 3.6). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What does the Pipe window's title bar say? **Example:** a run of three pipes from P6 to P3. **Recommended:** "Pipe · P4 to P3", or "Pipe · 3 pipes, P6 to P3" for a run, matching "Pit · P1".

**N-050** **Source:** PIPE 40 (spec 3.27). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Does "arriving" mean only pipes whose downstream end joins the pit? **Example:** a pit with one pipe leaving and two arriving. **Recommended:** yes, as drafted (never a pipe leaving it).

**N-051** **Source:** PIPE 41 (spec 3.30). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** He types 150 for a whole run, but a bigger pipe already arrives part way along: what shows? **Example:** he types 150 for P1 to P5, but a 225 already arrives at P3. **Recommended:** all five stay 150 (held) and P3 to P2 onwards show amber "Needs a look: smaller than the 225 arriving". **PARTLY ANSWERED:** TR-045 ("All five are held"), TR-023 (drawn as typed, amber "Needs a look") and TR-075 (an offer when a bigger pipe joins a smaller outlet). **Left to ask:** does the window also offer once to raise the held 150s below P3 to 225, or only flag them.

**N-052** **Source:** PIPE 42 (spec 3.32). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** How is an existing pipe's size read, and what if it cannot be? **Example:** an existing pipe drawn 150 wide, or one with an odd width. **Recommended:** the drawn width; 100 is never offered. **PARTLY ANSWERED:** TR-046 (drawn size shown, both figures in words, one click to put the typed size back) and TR-042 (open at the biggest it can read, naming the pipe it could not). **Left to ask:** a width that cannot be read at all, and one that is not an office size (still open as U-119 and U-123).

**N-053** **Source:** PIPE 43 (spec 3.34). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Does each size show its source in words? **Example:** a size beside the box reading "worked out". **Recommended:** "worked out", "read off the drawing", or a solid typed box. (TR-081's checker found the Pit window's step 2 figures carry no source word.)

**N-054** **Source:** PIPE 44 (spec 3.37). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** What material follows the size above 150? **Example:** a 225 pipe between pits. **Recommended:** research the office's issued sheets and fill the office list (likely UPVC SN8 for 225 and above).

**N-055** **Source:** PIPE 46 (spec 3.52). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Same as N-024: with several pipes arriving at different levels, which sets the pipe leaving? **Example:** P4 has a 100 arriving at 12.40 and a 150 at 12.30. **Recommended:** the lowest arriving invert, less the 0.02 drop, sets the pipe leaving.

**N-056** **Source:** PIPE 48 (spec 3.55). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Does the 0.02 drop apply where a branch joins a pipe with no pit, and where does the branch invert sit? **Example:** a 100 branch joining a 150 with no pit. **Recommended:** no drop; the branch invert sits at or above the main's invert at the join, and is checked. **PARTLY ANSWERED:** TR-027 (the level at the join is worked out, not typed). **Left to ask:** whether any drop applies and how the branch sits against the main.

**N-057** **Source:** PIPE 9 (spec 1.17). **Blocks:** can wait (same as N-030). **Kind:** plain confirm. **Question:** Are 0.3 seconds to open and 0.1 seconds to follow typing right? **Example:** changing 100 to 150 and watching the preview. **Recommended:** yes, as drafted.

## Labels, levels and arrow

**N-058** **Source:** PIT 46 (spec 3.15). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the pit number the office's circled tag? **Example:** "P3" in a circle as on issued sheets. **Recommended:** yes. (TR-012 settled the position of the number, not the circle; U-076 closed without it.)

**N-059** **Source:** PIT 47 (spec 3.18). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** When the pit number goes "beside", which side first? **Example:** pipes leave above and below. **Recommended:** right first, then left. **PARTLY ANSWERED:** TR-014 (900 mm above the pit centre, then below, then beside; a side a pipe leaves from is skipped). **Left to ask:** left or right first.

**N-060** **Source:** PIT 48 (spec 3.19). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the 900 mm measured to the centre of the number tag, its base or its circle? **Example:** a circled P2 above its pit. **Recommended:** to the centre of the tag. **PARTLY ANSWERED:** TR-014 (900 mm above the pit centre, "distances need to be settings"). **Left to ask:** which part of the tag.

**N-061** **Source:** PIT 49 (spec 3.21). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Which way round the pit does the cover level go when its first spot is taken, and which corner is the 400 mm measured from? **Example:** CL 12.95 with the top right corner blocked by a pipe label. **Recommended:** clockwise from top right; 400 from the outer dashed corner to the near end of the text. **PARTLY ANSWERED:** TR-014 (top right first, 400 mm off the corner, then round the pit). **Left to ask:** direction, and outer dashed line or inner wall.

**N-062** **Source:** PIT 51 (spec 3.24). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What are the cover level's words? **Example:** CL 12.95; a pit with no level. **Recommended:** "CL 12.95" as on issued sheets; "CL TBC" when not known.

**N-063** **Source:** PIT 40 (spec 3.4). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Question:** How does "PP over CL" sit when the cover level is turned 45 degrees? **Example:** a 350 plastic pit in a garden. **Recommended:** the two lines turned 45 degrees together off the corner.

**N-064** **Source:** PIT 53 (spec 3.30, 9.13). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** What text style and height do the pit number and cover level use? **Example:** text at 1:100 on an issued sheet. **Recommended:** read off the office template and issued sheets, then put the figure to him.

**N-065** **Source:** PIT 56 (spec 3.34). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** What counts as a clash for pit text? **Example:** P4's number lands on a pipe label (TR-039's example was text in the way of a dimension). **Recommended:** other CE text, pipe bands, pit outlines and any text; not hatching or plain linework.

**N-066** **Source:** PIT 64 (spec 4.23). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What happens when he retypes the cover level text by hand on the drawing? **Example:** he types "CL 13.10" over "CL 12.95". **Recommended:** keep his words, flag "no longer matches", one click to follow again. **PARTLY ANSWERED:** TR-072 (a retyped pipe label keeps his words, shows the amber marker, one click lets it follow). **Left to ask:** that the same rule covers the pit's cover text.

**N-067** **Source:** PIPE 59 (spec 4.10). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the pipe label plain text the tool writes, not an office label block? **Example:** a label he can edit with plain AutoCAD. **Recommended:** yes, as drafted.

**N-068** **Source:** PIPE 60 (spec 4.11). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is the ordinary label's wording "[size] DIA. [material] PIPE AT 1 IN [grade]" with MIN. where it applies? **Example:** "100 DIA. UPVC PIPE AT 1 IN 100 MIN.". **Recommended:** yes, as on issued sheets. (TR-069 settled only when MIN. appears.)

**N-069** **Source:** PIPE 61 (spec 4.15). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What does the label print for an unknown or Wrong grade? **Example:** no grade yet; a typed 1 in 40 that fails. **Recommended:** TBC for unknown; the typed figure kept when Wrong.

**N-070** **Source:** PIPE 62 (spec 4.16). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** How does a grade worked out from two typed inverts print? **Example:** inverts 12.40 and 12.30 over 7.3 m give 1 in 73.0. **Recommended:** to the nearest whole number, "1 IN 73", as the office writes grades.

**N-071** **Source:** PIPE 65 (spec 4.22). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** Same as N-064 for the pipe label's text style and height. **Example:** the office template's pipe text at 1:100. **Recommended:** read the office template's pipe text style and height at 1:100 and confirm in one line.

**N-072** **Source:** PIPE 68 (spec 4.27). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Question:** Which side is "above" on a pipe running up the page or at an angle? **Example:** a pipe running straight up the page. **Recommended:** "above" is the side that reads correctly (the left of a pipe running up the page); then flip. TR-009's picture showed a level pipe only.

**N-073** **Source:** PIPE 69 (spec 4.28). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Do the label, invert levels and arrow always run along the pipe and never read upside down? **Example:** a pipe drawn from right to left. **Recommended:** yes, as AutoCAD's own aligned text does. **PARTLY ANSWERED:** TR-056 (after a MIRROR nothing reads backwards or upside down). **Left to ask:** the same for an ordinary pipe at every angle.

**N-074** **Source:** PIPE 71 (spec 4.32). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Same as N-065 for pipe text: what counts as a clash? **Example:** the label lands on a hatch boundary. **Recommended:** pits, pipes and CE text only in Stage 1; hatches and other lines later.

**N-075** **Source:** PIPE 73 (spec 4.38). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What is the 200 mm invert offset measured from? **Example:** IL 12.31 beside the pit. **Recommended:** from the inner wall where the pipe ends to the near end of the text. **PARTLY ANSWERED:** TR-010 (200 mm from the pit, a setting; "from the pit" read as the pit wall, to be confirmed). **Left to ask:** which wall line, and which end of the text.

**N-076** **Source:** PIPE 74 (spec 4.41). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Question:** What does the flow arrow look like? **Example:** an arrow on a 9 m pipe. **Recommended:** the office's own arrow from the issued sheets, at the label's text height, on the label's layer. (U-078 closed for placing only.)

**N-077** **Source:** PIPE 78 (spec 5.5). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Once he reverses a pipe by hand, is that direction held against the tool's own working? **Example:** he reverses a pipe the tool thought ran the other way. **Recommended:** yes, held like any typed figure; the tool may then only offer "Turn round", never turn it. **PARTLY ANSWERED:** TR-020 (a reverse in the edit window; the tool may work direction out where it can but he does not rely on it). **Left to ask:** whether a hand-reversed direction is held.

**N-078** **Source:** PIPE 79 (spec 5.6). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** What does a reverse do to typed levels, MIN. and the size checks, and can a whole run be reversed? **Example:** a pipe with only the downstream invert typed is reversed. **Recommended:** typed levels stay at their physical ends; MIN. and size checks re-run; a whole run reverses when the run is opened.

**N-079** **Source:** PIPE 86 (spec 6.20). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What happens to an invert's wording he retypes by hand? **Example:** he edits "IL 12.31" to read "IL 12.31 (EX)". **Recommended:** kept and flagged, as a label is (D-182). **PARTLY ANSWERED:** TR-072 (a retyped label is kept, flagged with the amber marker, one click to follow again). **Left to ask:** the same for invert text.

**N-080** **Source:** PIT 52 (spec 3.29). **Blocks:** can wait (the usual reminder is the Unfinished list, Stage 2). **Kind:** plain confirm. **Question:** What reminds him in Stage 1 to place the APPROX. standing note? **Example:** a copied unit's pits print APPROX. **Recommended:** one command-line line after the copy reminding him.

**N-081** **Source:** PIPE 76 (spec 4.49). **Blocks:** can wait (same as N-080). **Kind:** plain confirm. **Question:** Same as N-080 for pipes. **Example:** the first APPROX. printed in a drawing. **Recommended:** one command-line line the first time anything prints APPROX. in a drawing.

**N-082** **Source:** PIPE 63 (spec 4.18). **Blocks:** can wait (existing hand-drawn pipes are not tool pipes in the first release, D-190). **Kind:** plain confirm. **Question:** An existing pipe whose size cannot be read: is its label left as drawn? **Example:** an as-built pipe with an odd width. **Recommended:** label left exactly as drawn.

**N-083** **Source:** PIPE 77 (spec 5.4). **Blocks:** can wait (Stage 2: the outlet). **Kind:** plain confirm. **Question:** What does direction do once a run reaches an outlet? **Example:** a run whose levels disagree with the way it was drawn. **Recommended:** as drafted: it follows the outlet, with a quiet "Turn round" offer. **PARTLY ANSWERED:** TR-020 (the tool may work direction out where it can). **Left to ask:** what shows once the outlet tool exists.

## Changing a size or figure

**N-084** **Source:** PIT 58 (spec 4.4). **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Question:** Does CDEDIT clash with an old plug-in command or an AutoCAD name? **Example:** CDEDIT already defined by the old suite. **Recommended:** check both lists before it ships. **PARTLY ANSWERED:** TR-066 (CDEDIT is Tim's word). **Left to ask:** nothing of Tim; the name check is a test.

**N-085** **Source:** PIPE 81 (spec 6.3). **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Question:** Same as N-084, plus confirming CDEDIT replaces D-056's "only placing has a name". **Example:** as N-084. **Recommended:** keep CDEDIT as Tim's newer word. **PARTLY ANSWERED:** TR-066. **Left to ask:** the name check (a test).

**N-086** **Source:** PIT 62 (spec 4.17). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is a held figure never let go silently? **Example:** a typed cover level changes while a depth is held. **Recommended:** confirm. **PARTLY ANSWERED:** TR-074 (the held depth IS let go, with words: "Depth was held at 0.90, now 1.05 because the cover level changed"), TR-043 and TR-046 (nothing changes silently), TR-045. **Left to ask:** the spec says "typing one level never releases another"; TR-074 shows typing a cover level does release a held depth. Confirm the rule is "never let go without saying so".

**N-087** **Source:** PIPE 83 (spec 6.7). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** When he double-clicks one pipe of a run, does the window show that pipe or the whole run? **Example:** double-clicking the middle pipe of a run of four. **Recommended:** that one pipe; selecting all four opens them together with "Varies".

**N-088** **Source:** PIPE 84 (spec 6.15). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** When he edits a level on one pipe, do the pipes below re-work? **Example:** he lowers the upstream invert of the top pipe of a run. **Recommended:** pipes below re-work only where their levels were worked out, never where held, and the window lists what moved. (TR-064 rules this for the run window only.)

**N-089** **Source:** PIT 61 (spec 4.11). **Blocks:** can wait (an edge case of grips, U-057). **Kind:** real choice. **Question:** If a plastic pit is stretched past 350, does it stay a plastic pit? **Example:** a plastic pit stretched to 600 by grip. **Recommended:** it becomes a junction pit, said once.

## Moving and stretching

**N-090** **Source:** PIPE 89 (spec 7.6). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** When a move turns or lengthens a pipe, is its auto-placed label re-placed by the placing rules? **Example:** a pit move turns a pipe 20 degrees. **Recommended:** a label never moved by hand is re-placed by the rules; a hand-moved one keeps its offset. (TR-037 says the label goes with a moved pipe; TR-056 re-places on a mirror.)

**N-091** **Source:** PIPE 95 (spec 7.23). **Blocks:** blocks Stage 1 (drawing safety). **Kind:** real choice. **Question:** What do TRIM, EXTEND, BREAK, FILLET, JOIN, PEDIT and OFFSET do to a pipe? **Example:** TRIM cuts a pipe at a wall line. **Recommended:** the pipe is read again after any of these; a pipe cut in two by BREAK becomes two loose pipes "not joined yet"; JOIN and PEDIT refused on pipes with words.

## Copying and mirroring

**N-092** **Source:** PIT 70 (spec 5.18). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** When MIRROR erases the source, do the pits keep their numbers? **Example:** mirror unit 1's pits, erase source "Yes". **Recommended:** the pits keep their numbers.

## Erasing and exploding

None new. EXPLODE of a pit is answered (Part 3); erasing a mid-run pit is U-070 (Part 2).

## Undo

**N-093** **Source:** PIPE 22 (spec 2.36). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** While clicking a run, does U step back one click? **Example:** he clicks a wrong bend half way down the run. **Recommended:** U steps back one click, as PLINE does. (D-324 predates draw-first.)

**N-094** **Source:** PIT 73 (spec 5.24). **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Question:** Does REDO put back exactly what Undo took? **Example:** Undo a placed pit, then REDO. **Recommended:** yes, exactly, as one step.

**N-095** **Source:** PIPE 97 (spec 7.30). **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Question:** Same as N-094 for a pipe run. **Example:** Undo a drawn run, then REDO. **Recommended:** REDO puts back exactly what the Undo took, as one step.

## Checks

**N-096** **Source:** PIT 55 (spec 3.33, 5.16, 6.14). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Where does he see an overlap, two tags on one pit, or a check result in Stage 1? **Example:** P4's number lands on a pipe label. **Recommended (PIT page):** in the Pit window band and one command-line line on OK. **PARTLY ANSWERED:** TR-072 (a small amber triangle on the plan beside the part, never printed; hover says what is wrong; the window says the same; it serves "text overlaps", "Needs a look" and a failed check). The PIT page's recommendation differs from his pick. **Left to ask:** where "two tags on one pit" is listed (5.16).

**N-097** **Source:** PIPE 103 (spec 8.3). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** What does the cover check say when "what is over it" is not known? **Example:** a pipe with nothing set. **Recommended:** grey "Cannot check yet", never amber. **PARTLY ANSWERED:** TR-063 ("or unkown if not known ... a minor feature ... simply a check"; the grey wording is the room's proposal). **Left to ask:** confirm the wording and that it never shows amber.

**N-098** **Source:** PIPE 106 (spec 8.14). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Is cover checked at each bend, not only at the pits? **Example:** a deep bend with 300 cover at both pits. **Recommended:** each bend is checked as a station on the straight ground line between the pits. **PARTLY ANSWERED:** TR-062 (ground is a straight line between the two pit cover levels plus points he adds; the check reports the tightest spot). **Left to ask:** whether bends count as checking stations.

**N-099** **Source:** PIPE 110 (spec 8.26). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Does a cover or grade failure read "Wrong" or "Short" in the answer band? **Example:** cover 40 mm short at P3. **Recommended:** "Wrong" with the shortfall in words ("Wrong: 40 mm short at P3"); "Short" kept for storage.

**N-100** **Source:** PIT 83 (spec 6.13). **Blocks:** can wait (TR-081's approved Pit window has no pipe cover line). **Kind:** plain confirm. **Question:** Does a joined pipe's short cover show in the Pit window too? **Example:** a pit whose joined pipe is 40 mm short of cover. **Recommended:** yes, the worst joined pipe's cover shows in the Pit band.

**N-101** **Source:** PIT 82 (spec 6.12). **Blocks:** can wait (not on the Stage 1 list). **Kind:** plain confirm. **Question:** What does the lid class check compare? **Example:** a garden pit with a Class C lid. **Recommended:** compare the lid class with the "what is over it" preset only when that is set; otherwise "Cannot check yet".

**N-102** **Source:** PIT 57 (spec 3.37). **Blocks:** can wait (edge case). **Kind:** plain confirm. **Question:** Is a level below 0.00 amber "check the datum" and never Wrong? **Example:** a bayside job at RL -0.20. **Recommended:** confirm.

**N-103** **Source:** PIT 81 (spec 6.8, 6.9, 9.15). **Blocks:** can wait (edge case). **Kind:** plain confirm. **Question:** Are a pit deeper than 6 m (amber) and a zero or negative depth (Wrong) right? **Example:** a pit 6.5 m deep. **Recommended:** confirm.

**N-104** **Source:** PIPE 80 (spec 5.7). **Blocks:** can wait (rare extremes; the draft stands). **Kind:** plain confirm. **Question:** Are uphill and very steep grades handled as drafted? **Example:** a pipe typed uphill. **Recommended:** as drafted (grade 0 or below Wrong; steeper than 1 in 1 "Needs a look").

**N-105** **Source:** PIPE 107 (spec 8.17). **Blocks:** can wait (same family as N-104). **Kind:** plain confirm. **Question:** Are the extra grade limits right? **Example:** a grade flatter than 1 in 500. **Recommended:** as drafted.

**N-106** **Source:** PIPE 109 (spec 8.21). **Blocks:** can wait (same family as N-104). **Kind:** plain confirm. **Question:** Are the other limits right? **Example:** a pipe over 1,050 dia. **Recommended:** as drafted.

**N-107** **Source:** PIPE 121 (spec 11.10). **Blocks:** can wait (same family as N-104). **Kind:** plain confirm. **Question:** Are the upper "Needs a look" limits right as settings? **Example:** 1 in 500 and 1,050 dia. **Recommended:** as drafted.

**N-108** **Source:** PIPE 105 (spec 8.9). **Blocks:** can wait (Stage 2: the Job window). **Kind:** real choice. **Question:** Where is a slab thickness set in Stage 1? **Example:** a pipe under a 125 mm driveway slab. **Recommended:** typed on the pipe in its window in Stage 1, moving to the Job window in Stage 2. Note: TR-063 says he does not want "what is over it" set pipe by pipe; see Part 5.

**N-109** **Source:** PIPE 111 (spec 8.32). **Blocks:** can wait (Stage 2: the schedule and printed working). **Kind:** plain confirm. **Question:** Must a printed working add up as printed? **Example:** a printed depth 0.01 off the printed levels. **Recommended:** as drafted: add a decimal place where needed. (Related to U-221.)

## Older drawings

**N-110** **Source:** PIT 84 (spec 7.7). **Blocks:** can wait. **Kind:** plain confirm. **Question:** Is a stand-in outline from an earlier test build only ever replaced by a "take it up" click? **Example:** an old test drawing with a stand-in square. **Recommended:** confirm.

**N-111** **Source:** PIPE 114 (spec 9.5). **Blocks:** can wait. **Kind:** plain confirm. **Question:** Does Stage 1 show the opening "take it up" line for plain lines on a stormwater layer? **Example:** a colleague's drawing opened with the tool. **Recommended:** not in Stage 1; picking a polyline as a run covers it.

**N-112** **Source:** PIPE 119 (spec 9.13). **Blocks:** can wait. **Kind:** plain confirm. **Question:** Is a damaged or newer pipe record refused in words? **Example:** a record written by a newer version. **Recommended:** refuse the edit naming the pipe; never guess.

## Settings and layers

**N-113** **Source:** PIT 42 (spec 3.10). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** Which layer does the pit block go on? **Example:** every pit on a layer he can freeze for a services plan. **Recommended:** read the layer from the office template's existing pits; put to him with that answer.

**N-114** **Source:** PIT 43 (spec 3.11). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** Which layer do the pit number and cover level go on? **Example:** he freezes pit numbers for a coordination plan. **Recommended:** the office's existing pit text layer, read from issued jobs.

**N-115** **Source:** PIT 44 (spec 3.12). **Blocks:** blocks Stage 1. **Kind:** plain confirm. **Question:** Are colour, linetype and lineweight ByLayer? **Example:** a pit and its text on the drawing. **Recommended:** ByLayer throughout.

**N-116** **Source:** PIPE 57 (spec 4.4). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** What are the pipe band and edge lines' layer, colour and lineweight? **Example:** the ordinary pipe on an issued sheet. **Recommended:** read them off the office template and three issued jobs; show Tim one line to confirm.

**N-117** **Source:** PIPE 72 (spec 4.36). **Blocks:** blocks Stage 1. **Kind:** needs research first. **Question:** Which layer does the invert text go on? **Example:** the invert levels beside P4. **Recommended:** the same layer as the label, read off the office template.

**N-118** **Source:** PIT 87 (spec 9.18). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Where does a drafter change a setting in Stage 1, with no Job window? **Example:** he wants the number tag at 600 not 900 on this job. **Recommended (PIT page):** a small CE settings window reached from the Pit window. The PIPE page recommends the opposite (N-119).

**N-119** **Source:** PIPE 122 (spec 11.20). **Blocks:** blocks Stage 1. **Kind:** real choice. **Question:** Same as N-118. **Example:** Tim wants the invert offset at 250 on one job. **Recommended (PIPE page):** the office list ships with the tool and only Tim changes it; per-job changes (tolerance) wait for the Job window; the drawing keeps what it was drawn with.

---

# PART 2: SAME AS AN OPEN UNKNOWN (B)

B-numbers are mine. The U-number is the line in UNKNOWNS.md that still needs asking. "Blocks" repeats the room's own label for that unknown.

## From SPEC_PIT section 10

**B-001** PIT 1 (1.4) is **U-003**. **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Moment:** starting a drawing. Old and new plug-in in the other load order. Example: a colleague's PC loads the CE bundle before the old suite. Recommended: test on a test copy; if the old one wins, the tool says so once at load.

**B-002** PIT 6 (1.15) is **U-025**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** starting a drawing. Words when the tool's own block folder is missing. Example: plug-in folder partly deleted. Recommended: "The office pit block could not be found in the CE folder; nothing drawn. Reinstall CE or tell Tim."

**B-003** PIT 7 (1.17) is **U-007**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** starting a drawing. Wipeout frame warning words. Example: WIPEOUTFRAME is 0 so the inner wall vanishes. Recommended: one line when a pit is first placed, naming the setting and the value to set.

**B-004** PIT 8 (1.20) is **U-006**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** starting a drawing. A drawing begun by Save As of the last job. Example: last week's job with P1 to P6 still in it. Recommended: same-job Save As keeps everything; for a new job, inherited levels are marked assumed until confirmed.

**B-005** PIT 11 (2.5) is **U-040** (and U-020, closed by TR-058, which says "ordinary object snaps work"). **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Moment:** placing a pit. Snaps, ortho, polar, zoom and pan while placing. Example: snapping the pit centre to a line end with ENDpoint, ortho on. Recommended: every AutoCAD snap, ortho, polar, zoom and pan works unchanged. Tim's hands.

**B-006** PIT 13 (2.7) is **U-103**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** placing a pit. Hover over a pit while placing. Example: the cursor passes P3 while placing P4. Recommended: the pit under the cursor lights; a tip shows its number and cover level. TR-060 only rules that a pit lights when the cursor has caught it while drawing a pipe.

**B-007** PIT 15 (2.13) is **U-024**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** placing a pit. A pipe selected before PT. Example: he selects a pipe, then types PT. Recommended: ignore the selection and ask for the click, as INSERT does.

**B-008** PIT 24 (2.37) is **U-023**. **Blocks:** can wait. **Kind:** needs a picture first. **Moment:** the Pit window. Cover level help. Example: the house FFL is 13.20 and the paving falls away. Recommended: leave out of Stage 1.

**B-009** PIT 31 (2.56) is **U-100** (TR-070 not answered). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pit window. Is the pit also shown on the AutoCAD drawing behind the window? Example: moving the window aside to see the pit. Recommended: preview only in Stage 1; nothing painted behind. (D-301 said both; Tim's TR-068 correction means the preview shows it.)

**B-010** PIT 34 (2.63, 2.64) is **U-051**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** the Pit window. Escape and a half-filled window. Example: Escape pressed by habit with a cover level typed. Recommended: Escape cancels like Cancel; nothing offered back.

**B-011** PIT 35 (2.66) is **U-095**. **Blocks:** blocks Stage 1. **Kind:** real choice. **Moment:** placing a pit. Click budget. Example: one pit with a cover level. Recommended: type PT, one click, type the cover level: 1 command, 1 pick, 1 field. (Tim's rule R-39; the budgets tick sheet was never answered.)

**B-012** PIT 38 (2.74) is **U-206**. **Blocks:** can wait (Stage 2). **Kind:** plain confirm. **Moment:** placing a pit. Which numbering choice is offered first after issue. Example: a pit added between P3 and P4 after issue. Recommended: next free number first.

**B-013** PIT 41 (3.7) is **U-031**. **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Moment:** placing a pit. How far inside the dashed line the inner wall sits. Example: a 450 pit's pipe ends. Recommended: measure PIT BLOCK 3 at all five sizes, then show him.

**B-014** PIT 54 (3.31) is **U-079**. **Blocks:** can wait (the room's label), but TR-016 already assumes masks ("on its background mask"). **Kind:** needs a picture first. **Moment:** labels, levels and arrow. Background masks. Recommended: on from day one, margin as the office text.

**B-015** PIT 59 (4.6) is **U-052**. **Blocks:** can wait. **Kind:** needs a picture first. **Moment:** changing a size or figure. Properties or an own panel (TR-066 left his question "CAN WE EDIT IN PROPERTIES OR A CD INSPECTOR WINDOW?" owed an answer). Example: change a cover level without opening the window. Recommended: Properties if the night proof passes, otherwise double-click and CDEDIT only.

**B-016** PIT 60 (4.10) is **U-050**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** changing a size or figure. End angle on a pit resize. Example: a pipe enters a 450 at an angle, pit goes to 900. Recommended: the end keeps its angle from the pit centre; an end placed by hand is left alone and said.

**B-017** PIT 65 (4.25) is **U-057**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. Which grips a pit has. Example: flipping the cover level to another corner. Recommended: show a picture of each grip first, then test. (TR-004 ticked "Grips to stretch and adjust".) Tim's hands.

**B-018** PIT 66 (4.27, 7.2) is **U-091**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** older drawings. Old-block pit edit refused. Example: double-click an old 16-state pit. Recommended: refuse in words that offer the later "take it up".

**B-019** PIT 67 (5.3) is **U-053 and U-113**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. Pit moved so a pipe's length changes. Example: a pit moved 2 m, its 10 m pipe at 1 in 100 with both levels typed. Page recommends the move finishes, typed levels stay, grade changes. That differs from TR-036 (a small window opens so he picks levels or grade); see Part 5.

**B-020** PIT 68 (5.6) is **U-057**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. The pit's insertion grip dragged. Recommended: treated exactly as MOVE. Spec called it new; it is one grip of U-057.

**B-021** PIT 69 (5.13) is **U-063**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** copying and mirroring. How "assumed" looks on a copied system. Recommended: APPROX. on the sheet, "Assumed" tag in the window.

**B-022** PIT 71 (5.21) is **U-070**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** erasing and exploding. A pit erased from the middle of a run. Recommended: leave both pipes "not joined yet".

**B-023** PIT 74 (5.25) is **U-060**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** moving and stretching. SCALE. Example: a system scaled by mistake by 1000. Recommended: pits keep their real size; refused in words.

**B-024** PIT 75 (5.27 to 5.29) is **U-061**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** moving and stretching. Words and behaviour for locked layer, xref, REFEDIT. Recommended: xref pits read only, never edited; REFEDIT edits refused in words.

**B-025** PIT 76 (5.30) is **U-065**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** changing a size or figure. MATCHPROP and a layer change. Recommended: allowed; layer change shown amber.

**B-026** PIT 77 (5.31) is **U-064**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** copying and mirroring. Paste and WBLOCK. Recommended: pasted pits are new pits with next free numbers, levels assumed.

**B-027** PIT 78 (5.32) is **U-071**. **Blocks:** can wait. **Kind:** a test, not a question. **Moment:** older drawings. PURGE, AUDIT, RECOVER. Recommended: test that pits survive all three.

**B-028** PIT 79 (5.33, 7.8) is **U-092**. **Blocks:** can wait. **Kind:** a test, not a question. **Moment:** older drawings. Edited without the plug-in. Recommended: one line on opening listing parts changed by hand, with "take it up".

**B-029** PIT 80 (6.7) is **U-088**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** checks. Depth checks in Stage 1. Recommended: yes, step irons and the size guide, with a quiet offer of the next size.

**B-030** PIT 85 (8.8) is **U-207**. **Blocks:** can wait (Stage 2). **Kind:** plain confirm. **Moment:** placing a pit. Schedule row order. Recommended: outlet first, following the flow.

## From SPEC_PIPE section 12

**B-031** PIPE 2 (1.6) is **U-003**. **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Moment:** starting a drawing. Old plug-in loaded after the new. Example: old suite at start-up, new one by NETLOAD. Recommended: Tim tries it once; the release says plainly if the old one wins. Same as B-001.

**B-032** PIPE 6 (1.12) is **U-025**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** starting a drawing. Office set-up copy missing. Example: a broken install on a laptop. Recommended: "The office set-up that comes with the CE tools cannot be found. Nothing was drawn. Reinstall the CE tools or tell the office."

**B-033** PIPE 7 (1.15) is **U-061**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** drawing a pipe run. Pipe layer locked. Example: he locked the stormwater layer while moving the house. Recommended: refuse with words naming the layer; never unlock it.

**B-034** PIPE 12 (2.8) is **U-098**. **Blocks:** blocks Stage 1. **Kind:** needs research first. **Moment:** drawing a pipe run. Bends "within the standards". Example: a 100 dia. pipe with three 90 degree bends down the side of a house. Recommended: research the plumbing standard first; then amber "Needs a look" only.

**B-035** PIPE 13 (2.13) is **U-103**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** drawing a pipe run. How a caught pit looks. Example: drawing toward P3 in a crowded corner. Recommended: the outline brightens in the CE highlight with a hover tip "P3". TR-060 rules that it lights; the look is open.

**B-036** PIPE 14 (2.17) is **U-041**. **Blocks:** can wait. **Kind:** needs research first. **Moment:** drawing a pipe run. How long before an inspection opening is offered. Example: a 100 branch joining a bend in a 30 m main. Recommended: research the standard and office practice; figure goes in the office list.

**B-037** PIPE 19 (2.30) is **U-043**. **Blocks:** can wait. **Kind:** needs research first. **Moment:** drawing a pipe run. Crossing another pipe. Example: a new 100 crosses an existing 150 with no pit. Recommended: a crossing, no join; the clearance check waits for the office figure.

**B-038** PIPE 20 (2.31) is **U-042**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** drawing a pipe run. Passing a pit without joining it. Example: a pipe runs past P2, clipping its corner. Recommended: the run splits at any pit it passes through; to pass by, draw round it.

**B-039** PIPE 31 (3.11) is **U-038**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. Size of the top strip and side picture. Example: a run of five pipes down a long boundary. Recommended: a picture of both ways, starting at a third of the height as Detention has. (TR-078 settled the Pit window only.)

**B-040** PIPE 32 (3.12) is **U-100**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. The drawing behind lighting up. Recommended: ask once with a picture; start with the preview panel only. Same as B-009.

**B-041** PIPE 36 (3.17) is **U-037** (the spec calls it new; Match is one line of the Pipe window). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. Match button. Example: a new pipe takes the settings of an existing 150 SN8. Recommended: a quiet Match button bottom left beside Inspect.

**B-042** PIPE 37 (3.19) is **U-037**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. The window line by line. Recommended: one full-size picture in the approved style for Tim to tick or correct before it is built. (The Pit window got this and was approved, TR-081.)

**B-043** PIPE 38 (3.21) is **U-037**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. Kind box in Stage 1. Recommended: hidden in Stage 1 (only one kind), shown when the second arrives. (TR-030: ordinary only; every kind a data row.)

**B-044** PIPE 39 (3.23) is **U-037** (spec calls it new; it is a list in the window). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. The size and grade lists. Example: the size list on a house job. Recommended: sizes 90, 100, 150, 225, 300, 375, 450; grades 1 in 50, 60, 80, 100, 150, 200; any other typed.

**B-045** PIPE 47 (3.53) is **U-037**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. One grade or a grade per pipe in a run. Example: a run of four where one must be flatter to keep cover. Recommended: one grade box for the run with a row per pipe where any can be typed over.

**B-046** PIPE 49 (3.60) is **U-037**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. Where "what is over it" and ground points sit. Recommended: both in step 1 under a quiet "Cover check (optional)" heading; "Add a ground point" steps the window aside for one click.

**B-047** PIPE 50 (3.64) is **U-111 and U-112**. **Blocks:** blocks Stage 1 (the room's label). **Kind:** needs a picture first. **Moment:** the Pipe window. Sleeve in Stage 1. Example: a 100 sleeved in a 150 under a garage slab. Page recommends out of Stage 1; Tim said "a tick on the pipe" (TR-031) and the unknowns block Stage 1; see Part 5.

**B-048** PIPE 51 (3.65) is **U-052**. **Blocks:** can wait. **Kind:** needs a picture first. **Moment:** the Pipe window. Rarely changed settings to Properties. Recommended: explain with two pictures, before and after, then ask.

**B-049** PIPE 52 (3.66) is **U-037** (spec calls it new; the answer band is a line of the window). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. The one answer in the band. Example: good grade but 40 mm short of cover at the downstream end. Recommended: the worst result named with its end ("Wrong: cover 40 mm short at P3"), else "Suits".

**B-050** PIPE 53 (3.69) is **U-051**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** the Pipe window. Escape. Recommended: Escape equals Cancel.

**B-051** PIPE 54 (3.70) is **U-051**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** the Pipe window. A half-filled window offered back. Recommended: no; nothing is left behind.

**B-052** PIPE 58 (4.7) is **U-031**. **Blocks:** blocks Stage 1. **Kind:** a test, not a question. **Moment:** drawing a pipe run. Inner wall distance. Recommended: measure PIT BLOCK 3 for all five sizes; show Tim one picture. Same as B-013.

**B-053** PIPE 66 (4.23) is **U-079**. **Blocks:** can wait (the room's label; see B-014). **Kind:** needs a picture first. **Moment:** labels, levels and arrow. Masks on label, inverts, arrow. Recommended: yes, as the office draws them.

**B-054** PIPE 67 (4.24) is **U-079**. **Blocks:** can wait (see B-014). **Kind:** needs a picture first. **Moment:** labels, levels and arrow. Mask margin. Recommended: the office template's current margin, on from the first day.

**B-055** PIPE 75 (4.43) is **U-107**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** labels, levels and arrow. Text on a pipe with bends. Example: one bend, a 1 m leg and an 8 m leg. Recommended: the label on the longest straight length; each invert on the length that touches its pit; the arrow on the longest length opposite the label; no text crosses a bend.

**B-056** PIPE 82 (6.4) is **U-052**. **Blocks:** can wait. **Kind:** needs a picture first. **Moment:** changing a size or figure. Properties or an inspector. Recommended: answer Tim: Properties is not proven; offer a CE side panel as the fallback, picture first.

**B-057** PIPE 85 (6.17) is **U-037**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** the Pipe window. A label-side choice in the window. Recommended: a "Label side" pair of buttons beside the label tick, as well as the grip.

**B-058** PIPE 88 (7.5) is **U-053 and U-113**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. A pit moved so a pipe's length changes. Example: P2 moved 2 m on the architect's update, a 10 m pipe at 1 in 100 with both levels typed. Recommended: a picture of the small "levels or grade" window first; meanwhile typed levels stay and the grade is shown changed. Same as B-019.

**B-059** PIPE 90 (7.9) is **U-061**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** moving and stretching. Words for locks, xrefs and reference edits. Recommended: one line each naming the part and the layer or xref; nothing changed.

**B-060** PIPE 91 (7.12) is **U-057** (and U-113 for the length change). **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. Moving one bend. Example: he grips a bend to pull the pipe off a footing. Recommended: the length is read again, levels follow as for a length change, labels re-placed unless moved by hand.

**B-061** PIPE 92 (7.15) is **U-057**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** moving and stretching. Which grips a pipe has. Recommended: a picture of a pipe's grips (each end, each bend, label, each invert, arrow), then a test. Tim's hands.

**B-062** PIPE 93 (7.18) is **U-063**. **Blocks:** blocks Stage 1. **Kind:** needs a picture first. **Moment:** copying and mirroring. How "assumed" shows on a copy. Recommended: APPROX. on the plan and an amber "Needs you: assumed level, copied from P3" in the window. Same as B-021.

**B-063** PIPE 94 (7.22) is **U-060**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** moving and stretching. ROTATE and SCALE. Example: rotating a whole unit's drainage 90 degrees. Recommended: ROTATE as a move (text re-placed, readable); SCALE refused with words.

**B-064** PIPE 96 (7.27) is **U-070**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** erasing and exploding. Erasing a mid-run pit. Recommended: both pipes stay "not joined yet", with one quiet offer to join them into one.

**B-065** PIPE 98 (7.32) is **U-050**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** changing a size or figure. Pipe end angle after a pit resize. Recommended: as drafted. Same as B-016.

**B-066** PIPE 100 (7.37) is **U-065**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** changing a size or figure. MATCHPROP or a hand layer change. Recommended: allowed; a pipe off its layer shows amber "Needs a look: not on the pipe layer".

**B-067** PIPE 101 (7.38) is **U-064**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** copying and mirroring. Paste and WBLOCK. Recommended: pasted pipes are new loose pipes with levels assumed, as for COPY.

**B-068** PIPE 102 (7.39) is **U-071**. **Blocks:** can wait. **Kind:** a test, not a question. **Moment:** older drawings. PURGE, AUDIT, RECOVER. Recommended: test in AutoCAD that each leaves pipes and joins intact.

**B-069** PIPE 104 (8.7) is **U-086**. **Blocks:** blocks Stage 1. **Kind:** needs research first. **Moment:** checks. The pipe's outside size for cover. Example: a 100 UPVC pipe's real outside diameter. Recommended: research the makers' figures and keep an outside size per material and size in the office list.

**B-070** PIPE 108 (8.18) is **U-089**. **Blocks:** can wait. **Kind:** needs research first. **Moment:** checks. A steepest grade. Recommended: research first; amber only.

**B-071** PIPE 112 (8.33) is **U-081**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** checks. A note about printed inverts and grade. Recommended: nothing on the sheet; the grade is the design grade as typed.

**B-072** PIPE 115 (9.7) is **U-091**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** older drawings. Old plug-in parts read only. Recommended: as drafted. Same as B-018.

**B-073** PIPE 116 (9.9) is **U-045**. **Blocks:** can wait. **Kind:** real choice. **Moment:** older drawings. Existing pipes drawn with the tool. Recommended: not in Stage 1; existing drains stay hand-drawn.

**B-074** PIPE 117 (9.10) is **U-092**. **Blocks:** can wait. **Kind:** a test, not a question. **Moment:** older drawings. Hand edits without the plug-in. Recommended: as drafted, the self-check reports them; test it. Same as B-028.

**B-075** PIPE 118 (9.12) is **U-006**. **Blocks:** can wait. **Kind:** plain confirm. **Moment:** older drawings. SAVE AS of the last job. Recommended: can wait; jobs start from the template. Same as B-004.

**B-076** PIPE 120 (10.14) is **U-090**. **Blocks:** can wait. **Kind:** real choice. **Moment:** checks. Pipe capacity. Recommended: later; sizes come from the standard until Tim says otherwise.

---

# PART 3: ANSWERED ALREADY (A)

Tim's own picks are quoted as the option text he chose in the question window (his typed words are marked "typed").

**A-01** PIT 16 (2.15, window position): **TR-071**: "Where I left it last time (Recommended)". The middle of the AutoCAD window the first time; dragged anywhere, second screen included, it opens there after.

**A-02** PIT 17 (2.16, window size): **TR-079**: "Two set sizes, as drawn (Recommended)". Laptop and desktop sizes picked from the AutoCAD window; no scrolling on a 1366 x 768 laptop.

**A-03** PIT 18 (2.21, 2.50, the window line by line and the answer band): **TR-081**: "Nothing: it is right as drawn". The Stage 1 Pit window contents are approved. The checker's open polish (no verdict word in step 3; figure 14 not 24; no source word in step 2) is for the build, not a question.

**A-04** PIT 28 (2.48, Inspect): **TR-080**: "Keep it, as drawn (Recommended)".

**A-05** PIT 72 (5.22, EXPLODE of a pit): **TR-073**: "Same rule as the pipe (Recommended)". Plain lines and text stay; the tool stops looking; joined pipes read "not joined yet"; one Undo.

**A-06** PIPE 33 (3.13, window size): **TR-079**: "Two set sizes, as drawn (Recommended)".

**A-07** PIPE 34 (3.15, where the window opens): **TR-071**: "Where I left it last time (Recommended)".

**A-08** PIPE 35 (3.16, Inspect): **TR-080**: "Keep it, as drawn (Recommended)".

**A-09** PIPE 45 (3.47, typing at the other end of a run): **TR-064**: "Type one level, the rest are worked out (Recommended)". A level typed anywhere in the run anchors it; typing over any other holds it and the run re-works around it.

**A-10** PIPE 55 (3.71, what carries to the next run): **TR-077**: "100: size never carries (Recommended)". Material, kind and the rest open as last used (D-263).

**A-11** PIPE 64 (4.20, where a hand-typed label is flagged): **TR-072**: "A small amber marker on the plan, never printed (Recommended)". The window says the same, with one click to let the label follow again. The page's recommended command-line line was not taken.

**A-12** PIPE 70 (4.31, where the overlap flag shows): **TR-072** (same pick); it serves "text overlaps".

**A-13** PIPE 87 (7.2, label on a moved pipe): **TR-037**: "It comes off, 'not joined yet' (Recommended)". The pipe moves with its label and levels.

**A-14** PIPE 113 (8.34, where check results show): **TR-072** (same pick); it serves a failed check. The page's recommended command-line line after OK was not taken.

---

# PART 4: BATCHES OF PLAIN CONFIRMATIONS

Plain confirms that block Stage 1 (all from Part 1; none of the B lines is a plain confirm that blocks). Order is the order a drafter meets them. Each batch can go to Tim as ONE question: "confirm these ten".

1. **Batch 1: starting a drawing and clicking a pit:** N-003, N-004, N-005, N-006, N-009, N-010, N-011, N-012, N-013, N-014. (Layout sheet and read-only refusals, the pit on the cursor, the cursor key, height and scale, which half's grade gives, ending the clicks.)
2. **Batch 2: the pit window and the first pipe clicks:** N-015, N-017, N-020, N-021, N-022, N-023, N-034, N-035, N-036, N-037. (After Cancel, kind looks, typing a size, 600 x 900 direction, lid opening, number box, pass-through and last-click ends, Escape and Close, polyline width.)
3. **Batch 3: the run and the Pipe window:** N-038, N-039, N-040, N-046, N-047, N-048, N-049, N-050, N-051, N-052. (Polyline layer, polyline after Cancel, band width, length measured, names, title, "arriving", typed size against a bigger arriving pipe, existing pipe size.)
4. **Batch 4: source words and the first text:** N-053, N-058, N-059, N-060, N-061, N-062, N-066, N-067, N-068, N-069. (Size source words, circled tag, beside side, where the 900 is measured, round the pit, CL wording, retyped cover text, label as text, label wording, unknown and Wrong grades.)
5. **Batch 5: text direction, flow and drawing safety:** N-070, N-073, N-075, N-077, N-079, N-086, N-088, N-090, N-092, N-093. (Worked-out grade print, text upright, what the 200 is from, reversed direction held, retyped invert, held figures, levels below an edit, re-placed labels, mirror with erase, undo while clicking.)
6. **Batch 6: checks and layers:** N-096, N-097, N-098, N-099, N-115. (Where results show, cover check when unknown, cover at a bend, Wrong or Short, ByLayer.)

Not in a batch, and why: every "can wait" line (33 C and D lines, 45 B lines) waits; the B lines that block Stage 1 need their own picture, test or research first (none is a plain confirm); and the rest of the C and D lines are the "real choice" lines (N-001, N-002, N-016, N-019, N-024, N-025, N-032, N-033, N-045, N-055, N-056, N-065, N-074, N-078, N-087, N-089, N-091, N-108, N-118, N-119), the "needs a picture first" lines (N-008, N-063, N-072, N-076), the "needs research first" lines (N-026, N-054, N-064, N-071, N-113, N-114, N-116, N-117) and the "a test, not a question" lines (N-084, N-085, N-094, N-095).

---

# PART 5: CLASHES

**5a. Named by the spec pages themselves.**

1. **Driveway cover:** D-287's presets (house driveway concrete 100, pavers 75, common driveway 100) against D-330 ("300 paved, 450 unpaved" under a driveway). The PIPE page uses D-330 as the later word.
2. **The name for editing:** D-056 ("only placing has a name") against D-383 (CDEDIT as a typed name). Tim's own word in TR-066 is CDEDIT.
3. **Inspect button:** D-065 (every window always has one) against the approved style D-295 (none in the bottom bar). Settled by TR-080: keep it.
4. **A clashing invert:** D-041 (it slides) against D-365 (flip first, slide second). Settled by TR-013: that order.
5. **Lid class when "what is over it" is not known:** D-287 gives a class from the preset; D-383 opens "what is over it" as Not known (PIT 2.30; N-022).
6. **Turned pit text:** D-267 (number and cover level stay upright, level with the sheet) against D-363 (cover level always at 45 degrees) (PIT 3.23; N-025).
7. **Drawing behind the window:** D-301 ("both" the preview and the real drawing) against D-382 (Tim meant the preview) (PIT 2.56, PIPE 3.12; B-009, B-040; U-100 open).
8. **Pit size by list or typing:** D-080 (list only) replaced by D-272 without saying so (PIT 2.25; N-020).
9. **Undo while clicking a run:** D-324 (takes back the last pipe) predates draw-first (PIPE 2.36; N-093).

**5b. Flagged in ANSWERS_TIM and still to be settled in the records.**

1. **Window timing:** D-234, D-186, D-060 and D-058 (window opens when the name is typed; "one window per run, then pick after pick") against TR-002, TR-005 and TR-006 (draw or click first, then the window, for each pit and each run).
2. **Cover level text:** D-260 DQ-009 (700 below the pit centre, flat) against TR-012 (always 45 degrees off a corner).
3. **A window in the middle of a MOVE:** TR-036's small window against R-41 ("No Are you sure?") and D-348 (a MOVE finished in one go).
4. **"What is over it" on each pipe:** D-133 and D-287 against TR-063 (not asked pipe by pipe).
5. **Size held on a run:** TR-045 ("All five are held") overturns the control room's draft call in D-372.
6. **Where "live" shows:** TR-068 corrects TR-003, TR-007 and TR-032 and so D-357.
7. **The no-plot layer name** is still open (D-275).

**5c. Found by me, between the spec pages and Tim's later words, or between the two pages.**

1. **Unitless drawings:** the PIT page says treat as millimetres (N-001); the PIPE page says refuse (N-002).
2. **Settings in Stage 1:** the PIT page recommends a small settings window; the PIPE page recommends the office list changed only by Tim (N-118, N-119).
3. **A pit moved so a pipe changes length:** PIT 67's recommendation (typed levels stay, grade changes, no window) is not what Tim asked for in TR-036 (a small window to choose levels or grade) (B-019). PIPE 88 is careful to wait for the picture.
4. **Where flags show:** PIT 55 and PIPE 64, 70 and 113 recommend a command-line line or a band line; Tim picked an amber marker on the plan in TR-072 (N-096, A-11, A-12, A-14).
5. **The sleeve:** PIPE 50 recommends leaving it out of Stage 1; Tim said "a tick on the pipe" (TR-031) and U-111 and U-112 are labelled blocking Stage 1 (B-047).
6. **Slab thickness typed on each pipe** (PIPE 105) pulls against TR-063 (he does not want per-pipe "what is over it") (N-108).
7. **Held figures:** PIT 4.17 says typing one level never releases another; TR-074 let go a held depth when the cover level changed, with words (N-086).
8. **Masks:** U-079 is labelled "can wait", but TR-016 already puts text "on its background mask" (B-014, B-053, B-054).

---

# What I could not decide

1. **PIT 18 (the Pit window line by line and answer band), put in A.** TR-081 approves the picture as drawn, but I cannot see the picture; I rely on the room's note of what it holds. If the picture has no answer band, PIT 18's answer-band half goes back to open.
2. **PIT 30 (preview size and zoom), put in C, not A.** TR-078 and TR-080 almost settle it; I left a small remainder (the starting zoom) because of the rule to choose C when unsure.
3. **PIT 25 (number box) and PIT 27 and PIT 29 (ticks, Match), put in C.** These rest on what TR-081's picture shows, which is the room's reading, not Tim's words.
4. **PIPE 45 (typing at the other end), put in A on TR-064.** His option reads "Type one level, the rest are worked out"; the spec asks about turning the direction of work. I judged his option covers it; if not, it is C.
5. **PIPE 87 (label on a moved pipe), put in A on TR-037.** His option says the label and levels go with the pipe; "keeps its offset" is my reading of "go with it".
6. **PIPE 36, 39, 49 (Match, lists, answer band) put in B against U-037,** although the spec marks them "New". They are lines of the Pipe window, which U-037 covers; if the control room wants each as its own unknown they become D.
7. **PIT 68 and PIPE 91 put in B against U-057 (grips).** The spec calls PIT 68 new; both ask what a grip or bend-move does.
8. **"Can wait" labels on D lines** (for example N-007, N-018, N-030, N-082, N-102 to N-107) are my judgement from the room's own habit (edge cases and drafts that already work); Tim's gate (D-359) says "every specific", so he may rule them all blocking.
9. **Kind of N-084, N-085, N-094 and N-095:** I called them "a test, not a question" because only AutoCAD can show the result; the confirmation of the rule itself is already in the spec's recommendation.
