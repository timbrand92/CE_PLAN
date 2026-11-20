# The Pipe tool (CD / PIPE): the full behaviour, Stage 1

**What this page is.** Every step of the Pipe tool as a drafter meets it, from typing CD to plotting, written so Tim can check it "down to a tee" (D-359: "i need every specific down to a tee before we complete this first stage"). Written Fri 20 Nov 2026 from `DECISIONS.md` D-001 to D-383, the rulings pages (filed only to D-297, so DECISIONS.md wins), `stage6\STAGE1_TIMS_EYES.md`, `stage6\ONE_JOB_RELEASE.md`, the screen rules and approved style, `UNKNOWNS.md`, `interview\ANSWERS_TIM.md` (TR-001 to TR-069), the 19 Nov findings, and the three design pages for pipe size, sums and the edit doorway. Nothing here is a new ruling.

**How to read the marks.** Each line ends with what it rests on.

1. **A decision number in brackets,** for example [D-355]: ruled by Tim, or a draft he has since confirmed (D-380).
2. **[DRAFT D-nnn]:** rests only on a planning chat or control room call, or a design page, and Tim has not said yes in words.
3. **[NOT RULED]:** nothing answers it. Each DRAFT and NOT RULED line is in section 12 as a plain question with a recommended answer.

**Stage 1 draws the ordinary pipe only** (D-377: "yes ordinary for now because theyre all the same visually so we will do the rest later, there is also the rising main for later"). Every other kind is listed under section 10.

---

## 1. Starting

1. **Typed names:** CD (the short name) or PIPE (the full word) starts the tool; CD keeps today's name, the one exception to "old names are gone" [D-053, D-057, D-101].
2. **Ribbon:** a Pipe button on the CE Civil tab runs the same command [D-200, D-208].
3. **The button itself:** its place on the tab, its picture and its words are not settled [NOT RULED].
4. **AutoCAD:** AutoCAD 2027 only [D-008].
5. **Old plug-in loaded at the same time:** the new tool answers CD and PIPE; proven by Tim on 20 Nov only when the new plug-in was loaded after the old one [D-258, D-351].
6. **Old plug-in loaded after the new one:** what answers CD in that order is not proven; this needs Tim's own hands in AutoCAD [NOT RULED].
7. **Typed in a layout (paper space) or inside a viewport:** whether the tool works there, refuses, or switches to model space is not said [NOT RULED].
8. **A read-only drawing:** what the tool says and does is not said [NOT RULED].
9. **Units, millimetres:** the drawing must be in millimetres; a drawing set to metres is refused with the reason said, and nothing is drawn (Tim: "Yes, refuse and say why") [D-344, D-380].
10. **A drawing with no units set (unitless):** treated as millimetres, refused, or asked is not said [NOT RULED].
11. **What is brought in:** layers, text styles (20TEXT) and linetypes (DASHED) the drawing lacks are brought in from the tool's own copy of the office set-up, as the office blocks are, with one line on the command line listing what was added; nothing already in the drawing is changed ("Bring them in too, say so once") [D-352, D-381].
12. **The tool's own copy of the office set-up cannot be found:** the exact words and what the drafter does next are not said [NOT RULED].
13. **No Job window yet:** the tool uses office defaults (5 mm tolerance, the ten "what is over it" presets, no council picked, text sized for 1:100), and the window says so in one grey line, for example "Office defaults: no job set yet" [D-381].
14. **The pipe's layer is off or frozen:** the window says so and offers a button to turn it on; nothing changes unless he presses it [D-320].
15. **The pipe's layer is locked when a new pipe is about to be drawn:** refuse with words, or offer to unlock, is not said [NOT RULED].
16. **Something already selected when CD is typed** (a plain polyline, a pipe, a pit): whether the tool uses it is not said [NOT RULED].
17. **Speed:** the window opens within 0.3 seconds and the preview follows typing within 0.1 seconds [DRAFT D-288].
18. **Words on the command line and in the window:** every prompt and message has draft words; no wording pass has been done for the Pipe tool [NOT RULED].

## 2. Drawing a run

1. **The order: draw first, window second.** Type CD, click the run or pick a polyline, then the window opens already knowing the run, then OK and the pipes go in. Tim: "when you use command you either pick a polyline as your run and it replcaes that polyline or you draw, then the window opens now knowing the size and then you can place all your properites and it then inserts correctly after completion of window" [D-354, D-355].
2. **This replaces "the window opens when the name is typed"** for the Pipe tool [D-354, superseding D-058, D-060, D-234].
3. **Choosing between clicking and picking a polyline:** how the first prompt tells a click on a plain polyline ("use this as my run") from a start point that happens to sit on a polyline is not said [NOT RULED].
4. **What follows the cursor:** the dashed band at the real width the pipe will open with, from the last click to the cursor; bends show as clicked; no label until the window opens ("The pipe band at its real width") [D-383 item 10].
5. **The width on the cursor:** the size the run will open with, that is the biggest pipe arriving at the start pit, else the office default 100 [D-373, D-383 item 10].
6. **Object snaps, ortho, polar, zoom and pan in the middle of a run:** all work as they do in PLINE ("Like PLINE and LINE: it carries on"); proof in AutoCAD is owed, by Tim's hands [D-237].
7. **From anywhere to anywhere:** a run starts and ends anywhere, with "however many bends are required", not only pit to pit [D-355].
8. **"Within the standards":** which bend angles, and how many bends, the plumbing standard and councils allow, and whether the tool warns, is not researched or ruled [NOT RULED].
9. **First click on a pit wall:** the pipe starts exactly on the wall where he clicked, in line with the click [D-034].
10. **First click inside a pit (not on the wall):** it counts as that pit; the pipe leaves through the middle of the wall facing the next click, square to it, and stops at the inner wall ("On the wall facing where you go next") [D-383 item 3].
11. **What counts as on the pit:** only a click on or inside the pit's outer wall line joins; there is no catch distance; a click short of the outer line starts a loose end [D-270, D-383 item 4].
12. **Showing the catch:** the pit lights up the moment the cursor is on it [D-383 item 4].
13. **How the lit pit looks,** and what a hover tip says, is not drawn or ruled [NOT RULED].
14. **First click on an existing pipe (no pit there):** the run joins that pipe; the old pipe stays ONE pipe with one label; the branch is recorded as joining part way along; the level at the join is worked out ("Join them, old pipe stays one") [D-374].
15. **That differs on purpose from a pit dropped on a pipe,** which splits it in two; both stand [D-077, D-374].
16. **Inspection opening at a join on a bend:** where a branch joins at a bend in the main pipe, the main has no inspection opening and the run is long, an inspection opening is offered, never forced [D-081, D-189].
17. **How long is "long":** no figure is given [NOT RULED].
18. **The inspection opening offer in Stage 1:** an inspection opening is an inlet (Stage 2, D-347); whether Stage 1 shows the offer, and what Yes does without the Inlet tool, is not said [NOT RULED].
19. **First click on nothing:** a loose start, allowed and not an error; it shows quietly as "not joined yet" in grey; what it cannot know reads "Not known" [D-175, D-176].
20. **First click on the open end of a loose pipe already drawn:** whether the new run joins that end (end to end, no pit), or carries the old pipe on as one pipe, is not said [NOT RULED].
21. **A click between the ends:** a bend in the same pipe [D-237].
22. **A bend is a sharp corner,** as a polyline turns; no fitting symbol; any angle is drawn ("A sharp corner, as you draw now") [D-383 item 5].
23. **A click on a pit part way along the run:** that pipe ends at the pit and the next pipe starts from the same pit with no extra click [D-237, D-355].
24. **A length that passes through a pit with no click there:** the run still splits at that pit, one pipe per pit-to-pit length [D-355, D-356].
25. **Where the two ends sit when a length passes through a pit,** or when a click lands inside a pit part way along: which wall each pipe meets (where the line crosses the wall, or the wall facing the next or previous click) is not said [NOT RULED].
26. **Last click on a pit wall:** the pipe ends exactly there, in line [D-034].
27. **Last click inside a pit:** whether it ends on the wall facing where the run came from is not said (TR-059 ruled only the start) [NOT RULED].
28. **Last click on an existing pipe:** joins it part way, old pipe stays one, level there worked out [D-374].
29. **Last click on nothing:** a loose end, "not joined yet" [D-176].
30. **The run crosses another pipe with no click on it:** whether that is a crossing (no join) and whether a clearance is checked is not said [NOT RULED].
31. **The run passes over or through a pit it should not join:** how the drafter draws past a pit without being split there is not said [NOT RULED].
32. **A single pipe works exactly the same way as a run** ("id like the same thing for single pipe only to work") [D-355].
33. **Enter finishes the clicking** and opens the window [D-237, D-355].
34. **Two clicks within a tenth of a millimetre are one point** [D-341, D-380].
35. **Escape while clicking, a PLINE-style Close, and Enter after only one click:** what each does is not said [NOT RULED].
36. **Undo while clicking:** D-324 says undo while the command runs takes back the last pipe only; with draw-first, whether U steps back the last click (as PLINE does) or the last whole pit-to-pit length is not said [NOT RULED].
37. **Undo after OK:** one Undo takes back the whole run with its labels, levels, arrows and joins [D-324].
38. **Picking a polyline as the run:** the polyline is removed and pipes take its exact path; each corner is a bend in one pipe; where the path passes through a pit the pipe ends and the next begins; one Undo brings the polyline back ("Replaced by pipes, bends kept") [D-356].
39. **A polyline that is refused:** one with an arc in it, a closed one, one on a locked layer, or one inside an xref is refused, the reason is said, and nothing changes [D-375].
40. **A picked polyline's width is never read as a pipe size;** the pipes replacing it open as new pipes (biggest arriving, else 100) [DRAFT D-372].
41. **A picked polyline's own layer, colour and linetype** play no part; the pipes go on the pipe layer [NOT RULED].
42. **Other things picked as a run:** a LINE, a spline, a 3D polyline, a polyline with an elevation, or a polyline inside a block: refused or taken is not said [NOT RULED].
43. **A polyline ending short of a pit's outer line:** that end is loose, "not joined yet" [D-176, D-270].
44. **One window for the whole run,** opening on the run once clicking ends [D-355].
45. **Cancel from the window:** nothing is drawn [D-357, D-382].
46. **A picked polyline after Cancel:** it is left exactly as it was, with all its points [DRAFT D-372].
47. **The clicked points after Cancel:** whether they are kept so the drafter can reopen the window without clicking again is not said [NOT RULED].

## 3. The window

1. **When it opens:** after Enter ends the clicks, or straight after a polyline is picked [D-354, D-355].
2. **One window per run,** knowing every pipe of the run [D-355].
3. **What it knows from the drawing:** each pipe's length, measured from the pipe as drawn and never typed [D-349; DRAFT D-277].
4. **What else it knows:** the pits at each end with their cover levels, and the size and invert of every pipe arriving, so nothing is typed twice ("type it once and everything is carried throughout") [D-002, D-171].
5. **How a pipe is named in the window:** by its two pits, "P4 to P3", and "free end" for a loose end [DRAFT D-261].
6. **The window's title wording** is not said [NOT RULED].
7. **The look:** the approved style: dark ground, the answer band at the top of the figures, step 1 "What you type" in boxes, step 2 "What the drawing gives" as plain text, step 3 "The answers" as sums, Cancel and OK at bottom right, OK the only rose button ("Yes, this is the style") [D-292, D-294, D-295].
8. **The preview:** a wide strip across the top of the window, as Detention has, plus a small picture beside the inputs it shows ("Both: top strip and beside") [D-313].
9. **What the preview shows:** the real drawing around the run, with the pipes changing live as he types ("THE LIVE DRAWING SHOULD SHOW IN THE PREVIEW IWNDOW IN THE WINDOW ITSELF") [D-382].
10. **Where on the plan and where in the system:** a small site locator, and a strip showing the run as a chain with this pipe lit [D-167].
11. **How big the top strip and the side picture are** is not ruled [NOT RULED].
12. **The AutoCAD drawing behind the window lighting up as well** (temporary outlines, nothing saved): D-301 said "both", but D-382 says Tim was not asking for the part to be painted behind the window; whether it also shows there is to be asked [DRAFT D-301].
13. **Window size:** 80 per cent of the AutoCAD window (not the screen), or two set sizes, one for a laptop and one slightly bigger for a desktop: not settled; whether it may scroll is not answered [NOT RULED].
14. **Small screens and Windows scaling above 100 per cent:** the cards go into tabs so nothing is cut off [D-193].
15. **Where the window opens on screen,** whether it remembers its place and size, and whether it can sit on a second monitor [NOT RULED].
16. **The Inspect button:** D-065 said every window always has one; the approved style has none in its bottom bar; whether he still wants it is open [NOT RULED].
17. **A Match button** (take the settings from a pipe already drawn), shown in the window structure approved on 16 Nov: whether it stays is not said [NOT RULED].
18. **The office defaults line,** one grey line, while there is no Job window [D-381].
19. **The window line by line** (which boxes, in what order, in what words) has never been gone through with Tim; the boxes below are the ones the rulings name [NOT RULED].
20. **Kind:** Stage 1 offers the ordinary pipe only; each kind is a row in the office list from day one so later kinds are added as rows [D-377].
21. **Whether a Kind box shows at all in Stage 1,** with one choice, or is hidden until the other kinds arrive [NOT RULED].
22. **Size box:** pick from a list or type any size [D-080].
23. **The lists offered** for size and for grade (which sizes, which grades) are not given [NOT RULED].
24. **Opening size, new run:** the biggest pipe arriving at the upstream end; with nothing arriving, the office default 100 dia., a setting ("the biggest arriving"; "Office default 100, unless it joins a pipe") [D-263, D-373].
25. **An arriving pipe whose size cannot be read:** the window opens at the biggest size it can read and says which pipe could not be read ("the biggest it can read") [D-379 item 2].
26. **The last size typed never carries** into an unrelated pipe; a pipe from nothing opens on the office default ("Smart: pipe follows what it joins") [D-263].
27. **What "arriving" means:** a pipe whose downstream end is joined to that pit, never a pipe leaving it [DRAFT D-372].
28. **Down a run:** each pipe hands its size to the next; a bigger pipe already arriving at a pit part way along wins for the pipes below it [D-372, D-373 item 1].
29. **A size typed for the run is held on every pipe in that run;** nothing below changes by itself ("All five are held") [D-379 item 1].
30. **A size typed for the run, and a bigger pipe already arriving part way along:** whether the held size stays (and is flagged smaller downstream) or the bigger size takes over below that pit is not said [NOT RULED].
31. **Changing size part way along one run** is not in Stage 1: draw two runs, or edit the pipes afterwards ("not in stage 1") [D-379 item 3].
32. **Opening size, existing pipe:** read off the pipe as drawn (its drawn width), shown as worked out from the drawing, never as typed; if the width cannot be read the window says so in words, OK leaves the size alone, and 100 is never offered [D-349; DRAFT D-372].
33. **A typed size that no longer matches the drawing** (typed 300, since widened to 375): the window shows the drawn 375 with both figures in words, the label follows the 375, and one click puts the 300 back [D-380].
34. **The source words shown beside the size:** "worked out" (from what arrives, or the office default), "read off the drawing", or held (typed) [DRAFT D-372].
35. **Material box:** pick from a list or type ("material selection for pipes must be text field as well a drop down") [D-079].
36. **Material follows the size** by an office list, shown as "standard", and can be typed over: 100 dia. is UPVC, 150 dia. is UPVC SN8 ("Follow the size: 150 becomes UPVC SN8") [D-239].
37. **Material for sizes other than 100 and 150** is not listed [NOT RULED].
38. **Grade box:** pick from a list or type any grade, such as 1 in 75 ("same with grade") [D-079].
39. **Opening grade:** 1 in 100, which can be typed over [D-143, D-263].
40. **Upstream and downstream invert boxes:** both can be typed over ("you need ability to override both invert levels as well") [D-080].
41. **One invert or none:** a pipe may have an invert at both ends, at one end only, or at neither ("WE NEED THE ABILITY TO ONLY INSERT ONE INVERT LEVEL OR NONE AS WELL") [D-236].
42. **Hold what is fixed, the rest is worked out:** every figure has a value, where it came from, and a hold; whatever is not held is worked out in whichever direction that needs ("Yes, that is the idea") [D-086].
43. **Any two of upstream invert, downstream invert and grade give the third** (Tim's hands-on test: closing the padlock on the downstream invert, typing 5.14 and "Work uphill" all worked) [D-086, D-128].
44. **Held looks held:** a closed padlock means held and an open one worked out ("Yes, it is clear"); a worked-out figure shows dashed until held [D-128, D-319].
45. **Using a worked-out figure takes no extra step;** holding it is done by typing over it ("you shouldnt need to do anything") [D-322].
46. **Work downhill or work uphill:** levels work from either end of the pipe or run [D-086, D-128].
47. **Typing a figure at the end the run is not worked from** turns the run to work from that figure [DRAFT D-277].
48. **Too much held:** the window says "Out by", names the stretch and the amount ("Out by 0.06 between P4 and P1"), lists and marks the held figures on that stretch, blames no single pipe, and changes nothing ("Nothing: tell me, I decide") [D-124, D-125].
49. **A typed or held figure is never let go or overwritten without him;** both figures are shown [D-286 rule 26].
50. **Levels along a run (in Stage 1):** he types one level anywhere in the run; every other invert is worked out pipe by pipe at the grade shown, with the 0.02 drop across each pit, shown as worked out; typing over any of them holds it and the run re-works around it; cover is checked as it goes ("Type one level, the rest are worked out") [D-383 item 8].
51. **The drop across a pit** is 0.02 m, the office standard, typed over on the pit [D-084, D-141].
52. **Several pipes arriving at one pit at different inverts:** which one sets the outgoing pipe's upstream invert (the lowest arriving, less the drop) is not said [NOT RULED].
53. **One grade for the run, or a grade per pipe:** whether the run window has one grade box for every pipe or a row per pipe is not said [NOT RULED].
54. **A branch joining a pipe with no pit:** the level at the join is worked out [D-374].
55. **A drop at a pipe-to-pipe junction** (no pit): whether the 0.02 drop applies there is not said [NOT RULED].
56. **Cover levels belong to the pits:** the Pipe window shows them and never changes them ("Locked on every pit") [D-078].
57. **A cover level not known:** it reads "Not known" and the checks that need it read "Cannot check yet" in grey [D-178, D-219].
58. **What is over the pipe:** never asked pipe by pipe; it opens "Not known" with no nagging; the ten presets stay as something he may set ("we dont have to do this for every pipe ... its a minor feature or function that is simply a check") [D-383 item 7].
59. **Ground points along the pipe:** he can click a point on the pipe and type the surface level there; the check reports the tightest spot [D-383 item 6].
60. **Where in the window** "what is over it" and the ground points sit, and how a ground point is added (a button that steps the window aside, or typed chainage) [NOT RULED].
61. **Text ticks:** the label, each invert end and the flow arrow each have their own tick on the pipe [D-369, D-377 item 6].
62. **MIN. tick:** MIN. is automatic and can be ticked on or off on any pipe [D-238].
63. **Reverse flow:** the window has a way to reverse the flow, and the arrow turns with it [D-370].
64. **Sleeve tick** (a 100 inside a 150 under a garage): Tim said "a tick on the pipe" but the control room filed it as not settled, with pictures owed; whether it is in Stage 1 is not said [NOT RULED].
65. **Moving rarely changed settings off the window into Properties:** Tim asked for it to be explained better first [NOT RULED].
66. **The one answer in the answer band for a pipe** (cover, grade, or the worst of them, and which end) is not said [NOT RULED].
67. **OK:** writes every pipe of the run, its band, edge lines, label, inverts (each with its tick on, worked out or typed) and arrow, as one change and one Undo [D-322, D-324, D-286 rule 18].
68. **Cancel:** nothing is drawn and the preview goes [D-357, D-382].
69. **Escape** cancels the whole window [DRAFT D-288].
70. **A half-filled window after Escape or Cancel:** whether it is offered back next time is not said [NOT RULED].
71. **What carries to the next run:** never the size; the window's own choices (ticks, label on or off) carry, and a setting switches the tool to "always office default" or "always last used" [D-263; DRAFT D-372].

## 4. What is drawn

1. **The pipe:** the wide dashed band with the two thin edge lines, as the office draws now; the edge lines move with the pipe as one thing ("Band plus edge lines, as now drawn"); how that is done with ordinary objects is the build's to prove [D-264].
2. **The band's width is the pipe size,** drawn full size (a 100 dia. pipe is a 100 wide band) [DRAFT D-372].
3. **Only ordinary AutoCAD objects:** the drawing looks and plots identical without the plug-in, and a person with no plug-in can still select, move and edit it [D-015, D-094].
4. **Layer, colour and lineweight** of the band and of the edge lines are not ruled (the detention layer was proposed as "DASHED like the ordinary pipe", which is the only mention of the ordinary pipe's linetype) [NOT RULED].
5. **Where the ends stop:** at the pit's solid inner wall line; the pipe passes the dashed outer line ("At the inner wall line") [D-102].
6. **The inner wall** is the edge of PIT BLOCK 3's wipeout; no extra inner wall line is drawn [D-224, D-228].
7. **How far inside the outer line the inner wall sits** for each of the five sizes is not measured [NOT RULED].
8. **The end meets the wall in line with the click** [D-034].
9. **Bends are sharp corners** [D-383 item 5].
10. **The label is text the tool writes,** not an office label block [DRAFT D-290].
11. **The ordinary label's wording:** "[size] DIA. [material] PIPE AT 1 IN [grade]", with MIN. where it applies, for example "100 DIA. UPVC PIPE AT 1 IN 100 MIN." [DRAFT D-290].
12. **Always the full label;** he moves it by hand where it clashes ("Always the full label") [D-312].
13. **The grade prints as typed:** "Print what I typed: 1 IN 75"; the inverts are rounded to two decimals [D-154].
14. **MIN.:** the label ends "MIN." unless he typed both inverts; a worked-out level does not count; MIN. can still be ticked on or off ("MIN. unless I typed both ends") [D-238, D-383 item 9].
15. **A grade not known** prints TBC in its place; a Wrong grade keeps the typed figure on the label while the window shows Wrong [DRAFT D-277].
16. **A grade worked out from two typed inverts** (no grade typed): how it prints (rounded to a whole number, or to one or two decimals) is not said [NOT RULED].
17. **The size on a new pipe's label is never "unknown":** a new pipe always opens with a size [D-263, D-373].
18. **An existing pipe whose size cannot be read:** its label is left exactly as drawn [DRAFT D-372].
19. **A label typed over by hand:** his wording stays, it is flagged as no longer matching, and one click lets it follow the pipe again ("Keep my wording, flag it, one click to follow again") [D-182].
20. **Where that flag shows in Stage 1,** with no Unfinished list yet, is not said [NOT RULED].
21. **Text size:** model text is sized for a 1:100 viewport (plans drawn 1:1, the layout scales them to 1:100) [D-194, D-381].
22. **The label's text style and exact height** are not given (only the invert text style is ruled) [NOT RULED].
23. **Masks:** the label, invert levels and arrow sit on background masks as the office draws them [DRAFT D-260].
24. **The mask's margin,** and whether masks are on from the first day, are not given [NOT RULED].
25. **Where the label first goes:** above the pipe, centred along it, 75 mm clear, the 75 a setting ("B but the text should also be able to move up and down the length of the pipe if clashign in the middle") [D-361, D-366].
26. **The order the label tries its spots:** centred above, centred below, slid along above, slid along below; flip first, slide second ("Yes, that order") [D-365].
27. **Which side is "above"** on a pipe running up the page or at an angle is not said [NOT RULED].
28. **Label, invert levels and arrow aligned with the pipe and reading the right way up at every angle:** not said for an ordinary pipe (it is said only after a MIRROR) [NOT RULED].
29. **A label longer than its pipe:** first stacked on two lines centred on the pipe; when two lines still do not fit, a callout on a pointer; a callout is also available on any label by a grip ("both ideally, with stack as first option") [D-367].
30. **When no spot is clear:** the text goes in its first spot on its mask and is flagged as overlapping ("First spot, and flag it") [D-368].
31. **Where the overlap flag shows in Stage 1** is not said [NOT RULED].
32. **What counts as a clash** (pits, other pipes, other CE text, any line in the drawing, hatches, xref content) is not said [NOT RULED].
33. **Which invert levels are written:** every known invert, both ends, typed or worked out; an invert with no value is not written ("Every known level, both ends") [D-383 item 9].
34. **How an invert reads:** "IL 12.31", two decimals; an estimate reads "APPROX. IL 4.95" [D-154, D-177].
35. **Invert text style:** 20TEXT, colour ByLayer [D-265].
36. **The invert text's layer** is not named [NOT RULED].
37. **Where each invert first goes:** on the opposite side of the pipe to the label, 200 mm from the pit, the 200 a setting; if that clashes, the label's side, then slid further along; one invert alone may move, so the two ends can sit on opposite sides ("inverts can be on opposite sides to each other if clashing") [D-362, D-365, D-366].
38. **What the 200 mm is measured from** (the inner wall where the pipe ends, the outer line or the pit centre) and to which part of the text is not said [NOT RULED].
39. **The flow arrow:** on every pipe; a tick turns it off ("Every pipe, tick to turn off") [D-369].
40. **Where the arrow goes:** first, centred along the pipe on the opposite side to the label; second, on the label's side in line with the label; it slides along the pipe; with the label off it takes the label's spots and order ("if pipe label is off then arrow takes the pipe labels system") [D-369].
41. **The arrow's look** (an office block or drawn lines, its size, its layer) is not given [NOT RULED].
42. **The arrow points downstream** as the pipe was drawn [D-370].
43. **A pipe with one or more bends:** which straight length the label, invert levels and arrow sit on, and whether text may cross a bend, is not worked out; Tim made this blocking ("consider with all of this how pipe label and invert texts and arrow work with pipes that have one or multiple bends") [NOT RULED].
44. **Each piece of text has its own tick;** erasing one by hand is the same as unticking it; it stays off when the pipe changes; the figure is still known and still checked ("It stays gone: that turns it off") [D-377 item 6].
45. **With the label off,** the arrow takes the label's spots and the invert levels stay where they are [D-369].
46. **A label moved by hand stays where it was put** when the pipe changes; its wording updates [D-014].
47. **A missing figure:** "Not known" in the window, "TBC" on the sheet, never 0 and never a guess [D-178, D-295].
48. **An assumed figure** prints "APPROX." in front, with the office's standing note on the sheet ("LEVELS MARKED APPROX. ARE ASSUMED ...") [D-177, D-248].
49. **Who reminds the drafter to place the APPROX. note in Stage 1,** since that reminder lives on the Unfinished list (Stage 2), is not said [NOT RULED].

## 5. Flow direction and reversing

1. **The way he drew it:** the first click is the upstream end, the last click the downstream end, and the arrow points that way ("the way i drew it") [D-370].
2. **Reverse in the edit window** turns the flow and the arrow [D-370].
3. **The tool may work the direction out** where it can (levels, a joined outlet) but is never relied on and never fights a direction he set ("but remember we wont alwys be drawing into the system so it wont always be perfect") [D-370].
4. **Before a run reaches an outlet** its direction is "as drawn, not settled"; once it reaches one it follows the outlet, with a quiet "Turn round" offer where the levels disagree (the outlet is Stage 2) [DRAFT D-271].
5. **A direction he reversed by hand** is held against the tool's own working: not said [NOT RULED].
6. **What a reverse does** to typed inverts (do they swap ends with the flow), to MIN., to the "never smaller downstream" check, and whether a whole run can be reversed at once, is not said [NOT RULED].
7. **A pipe running uphill** (grade 0 or below) is Wrong; steeper than 1 in 1 is "Needs a look" [DRAFT D-276].
8. **Direction is what "arriving" and "never smaller downstream" read** [D-373].

## 6. Changing a pipe

1. **Double-click** a pipe to open its window; proof that AutoCAD's own polyline editor does not also open is owed in AutoCAD [D-061, D-383 item 1].
2. **CDEDIT:** a typed command that edits any CE part; pick it and the right window opens ("CDEDIT, EDITS ANY CE OBJECT SELECTING THE RIGHT EDIT WINDOW") [D-383 item 1].
3. **CDEDIT against the old plug-in's names,** and against D-056 ("Only placing has a name"), is not checked or reconciled [NOT RULED].
4. **Properties or a CD inspector window:** Tim asked "CAN WE EDIT IN PROPERTIES OR A CD INSPECTOR WINDOW?"; the answer is owed (Properties is not proven) [NOT RULED].
5. **The edit window is the same window the pipe was placed with,** opened on that pipe [D-061].
6. **Several pipes at once:** one window; a figure the same on all shows normally, one that differs reads "Varies"; what he types goes on all, what he leaves is untouched on each; one Undo; pits and pipes picked together open nothing and it says so ("One window, 'Varies' where they differ") [D-381 item 5].
7. **Opening one pipe of a run:** whether the edit window shows that pipe only or the whole run it was drawn with is not said [NOT RULED].
8. **Size typed in the edit window** is a hold [D-379].
9. **Typed smaller than a pipe arriving:** drawn as typed, amber "Needs a look", never blocked ("Draw it, amber 'Needs a look'") [D-373 item 2].
10. **Made bigger:** the window offers once to make the pipes downstream the same size, in the same Undo; "No" leaves them, each flagged "Needs a look"; a held size downstream is asked about before it is touched ("Offer once, then flag") [D-373 item 3, D-379 item 1].
11. **What follows a size change:** band width, edge lines, material (unless typed over), label wording (unless typed over by hand) and the cover check; a hand-placed label stays where it was put [D-014, D-182, D-239, D-264].
12. **The ends after a size change** still stop at the inner wall [D-102].
13. **Width changed by hand or in Properties:** the drawn width wins and the window shows "typed 300, now drawn 375" with one click to put the typed size back [D-380].
14. **Grade typed over:** whatever is not held re-works; a clash with held figures reads "Out by" and changes nothing [D-086, D-125].
15. **Levels typed over on one pipe of a run:** whether the pipes below re-work from the new level is not said for the edit window (it is ruled only for the run window) [NOT RULED].
16. **Label side:** flipped by a grip, and a flip must be discoverable, never only on a right-click [D-037, D-049].
17. **A label-side choice in the window** as well as the grip is not said [NOT RULED].
18. **Reverse flow** is in the edit window [D-370].
19. **Invert text edited by hand** (its words retyped in AutoCAD) never changes the level ("Levels and grades are never changed by editing their text") [D-185].
20. **What the tool then does with that retyped invert wording** (keep it and flag it like a label, or put it back) is not said [NOT RULED].
21. **A loose pipe later joined:** what can now be worked out fills in, and the window says what filled in [D-176].

## 7. Moving, stretching, grips, copying, mirroring, arraying, trimming, exploding, erasing, undo

1. **MOVE a pipe on its own:** it lets go of both pits and reads "not joined yet"; its label, levels and arrow go with it; dragging an end back onto a pit joins it again; one Undo puts it back ("It comes off, 'not joined yet'") [D-377 item 4].
2. **The label on a moved pipe** keeps its offset from the pipe [DRAFT D-271].
3. **A label moved by hand** keeps its own offset [D-014].
4. **MOVE a pit:** the joined pipe ends follow it [D-348, D-381 item 6].
5. **A pit moved so a pipe's length changes:** Tim wants a small window to pick which gives, the levels or the grade, showing the effect down the system ("window opens to select one or the other and how it will transpire down the system if it exists"); not settled, picture owed; and what Stage 1 does with a plain MOVE meanwhile is not said [NOT RULED].
6. **An auto-placed label on a pipe whose length or angle changed** is re-placed by the placing rules: not said [NOT RULED].
7. **A pit moved while a joined pipe is on a locked layer:** the pit goes back and the command line says, for example, "P3 not moved: its pipe P3 to P4 is on locked layer STORMWATER" ("Pit goes back") [D-348].
8. **AutoCAD's protections win:** the tool never changes how native objects behave and never goes round a locked layer, an xref or a reference edit [D-199, D-348].
9. **The words for a locked label, a pipe inside an xref, and a pipe in a reference edit,** beyond the one case ruled, are not given [NOT RULED].
10. **Moving the whole plan on the page:** nothing changes, no join, level, label position, held figure or number, and no window opens ("its shouldnt mess anything up"); proof in AutoCAD owed [D-381 item 7].
11. **STRETCH with a crossing window:** treated as moving the pits caught; every joined pipe follows at its end; a pipe end caught without its pit comes off ("treat it as moving those pits") [D-381 item 6].
12. **A bend moved on its own** (STRETCH round one corner, or the corner's grip): what happens to the length, levels and text is not said [NOT RULED].
13. **Dragging a pipe end by its grip:** let go on or inside a pit's outer wall line it joins and is trimmed exactly to the wall in line with the pipe; short of the outer line it stays loose ("FIRST OPTION AND IF THE PIPE IS WITHIN THE OUTER WALL LINE AS WELL") [D-270].
14. **Text grips:** the label, invert text and arrow move along or square to the pipe, and flip; extra grips with hover words and a menu; AutoCAD's own grip shapes researched and tested ("WE NEED ALL SCENARIOS"; "EXTRA GRIPS OPTION") [D-037, D-244].
15. **Which grips a pipe shows, where, how they look, and what the band's own midpoint grip does** is not drawn or ruled [NOT RULED].
16. **COPY a pipe on its own:** a new loose pipe with the same size, material, grade and label words, joined to nothing, its levels marked assumed; the original untouched ("A new loose pipe, same figures") [D-381 item 9].
17. **COPY pits and pipes together** (the mirror unit): sizes and grades copy as they are, levels copy marked assumed, copies take the next free numbers [D-179].
18. **How "assumed" shows** on the copied pipe in the window and on the drawing (beyond APPROX. on the sheet) is not drawn [NOT RULED].
19. **A label, invert text or arrow copied on its own** is the drafter's own plain text: never moved, renumbered or erased by the tool, said once at the end of the COPY ("Your own plain text") [D-340 item 2].
20. **MIRROR:** nothing reads backwards; each label, invert level and arrow is re-placed by the placing rules on its new pipe; arrows still point with the flow; a hand-moved label goes to the matching spot ("Text stays readable, re-placed by the rules") [D-381 item 8].
21. **ARRAY, or pipes inside an unexploded block:** not followed; said once ("Say so once") [D-340 item 3].
22. **ROTATE and SCALE** of a pipe or a whole system: not said [NOT RULED].
23. **TRIM, EXTEND, BREAK, FILLET, JOIN, PEDIT and OFFSET** on an ordinary pipe: not said (the twin-barrel TRIM rule is for detention pipes, Stage 2) [NOT RULED].
24. **EXPLODE:** the pipe becomes plain AutoCAD pieces on the right layers, looking exactly the same; the tool stops looking after it and says so once; one Undo makes it a pipe again ("Plain AutoCAD pieces, looks the same"); what EXPLODE really leaves is still to be shown in AutoCAD [D-376].
25. **ERASE a pipe:** the band, edge lines, label, both invert levels and the arrow go together, including a hand-moved or typed-over label; the pits and their numbers stay; one Undo brings it all back [D-377 item 5].
26. **ERASE a pit at a pipe's end:** the pipe stays and reads "not joined yet"; one Undo brings everything back [D-221].
27. **ERASE a pit from the middle of a run:** whether the two pipes are offered to be joined into one is not said [NOT RULED].
28. **ERASE one piece of text** is the same as unticking it [D-377 item 6].
29. **Undo:** one Undo per command; AutoCAD's own MOVE and the tool's follow-up must be one Undo, to be shown in AutoCAD [D-286 rule 18, D-348].
30. **REDO** after an Undo of a pipe command: not said [NOT RULED].
31. **A pit made bigger or smaller:** each pipe end moves to the new wall, lengths and labels update, one Undo puts it back ("Pipe ends follow the wall") [D-256].
32. **The end's angle after a pit resize:** it keeps its angle from the pit centre; an end placed by hand or not on the old wall is left alone and said [DRAFT D-260].
33. **A pit turned:** the pipe ends follow the turned walls [D-267].
34. **A pit dropped on the middle of a pipe:** the pipe splits into two pipes, each with its own label and levels; the typed upstream level stays with the upper half and the typed downstream level with the lower half; the two levels at the new pit are worked out with the 0.02 drop; both halves keep the size and material ("Worked out, with the 0.02 drop") [D-077, D-377 item 8].
35. **Which half's grade gives** once both outer levels are held and the 0.02 drop goes in is not said [NOT RULED].
36. **A pit dropped on a loose pipe end:** it joins that pipe, trims it to the wall, and the label updates ("Yes, join it and trim") [D-377 item 3].
37. **MATCHPROP or a hand layer change** on a pipe: not said [NOT RULED].
38. **Paste from another drawing, WBLOCK and INSERT** of pipes: not said [NOT RULED].
39. **PURGE, AUDIT and RECOVER** with pipes in the drawing: not said [NOT RULED].
40. **A part on an off or frozen layer** after an edit: the tool offers to turn the layer on [D-320].

## 8. Checks and words

1. **The ground line for cover:** a straight line between the two pits' cover levels, plus any points he adds along the pipe; the check reports the tightest spot; with no point added it says it was checked at the pits only ("pit levels, plus points i add") [D-383 item 6].
2. **The cover needed** comes from what is over the pipe, which opens "Not known" [D-383 item 7].
3. **A cover check with "what is over it" not known** reads grey "Cannot check yet: what is over it is not known", never amber [DRAFT D-383].
4. **The ten presets he may pick** (cover in mm): 1 garden, house, no vehicles 100; 2 garden or landscape, units and other sites 300; 3 footpath, walkers only 75; 4 house driveway, concrete 100; 5 house driveway, pavers 75; 6 common driveway or carpark 100; 7 basement carpark or ramp 100; 8 truck hardstand 100; 9 vehicles, no paving 450; 10 council road or nature strip, the council's cover; presets only, every figure changeable ("EVERYTHING WILL BE A GUIDE AND OR PRESET AND AN ENGINEER NEEDS TO HAVE ABILITY TO CHANGE") [D-287].
5. **Under a driveway:** 300 mm to the top of the pipe with concrete or paving, 450 mm where vehicles cross with no pavement ("300 paved, 450 unpaved") [D-330].
6. **Cover is measured to the top of the pipe** [D-330].
7. **The pipe's outside size** used for the top of the pipe (from which list, per material) is not given [NOT RULED].
8. **Cover under paving** is measured from the underside of the pavement; the slab thickness comes from the job's plans, set per job, and until it is set cover under paving reads "Not known" [D-146, D-293].
9. **Where a slab thickness is set in Stage 1,** with no Job window, is not said [NOT RULED].
10. **A council's own cover figure:** the larger of the council's and the standard's governs; Stage 1 has no council [D-144, D-381].
11. **Cover less than needed:** red "Wrong" in every window, never blocking [D-140].
12. **Checked at the exact figure with the tolerance:** cover really 297 mm against 300 reads "Within the 5 mm tolerance"; with the tolerance at 0 it reads "3 mm short"; still printed to two places ("Exact figure, with tolerance") [D-321, D-350].
13. **When cover is short:** the window says how short and where, then lists the ways out with what each would give (flatten a grade, reduce the drop at a pit, lower the connection); it never picks a number ("Say how short, list the ways; no figure") [D-280].
14. **Cover at a bend, or where the surface changes,** with no ground point added there: whether the ground is taken along the straight line between the pits and the bend checked as a station is not said [NOT RULED].
15. **Grade passes** when it meets the required figure at two decimal places (1 in 200.08 against a 1 in 200 limit is flagged) ("Pass: compare at two decimals") [D-321, D-380].
16. **Flatter than 1 in 200** on an ordinary pipe: amber "Needs a look" [D-142].
17. **Grade 0 or below:** Wrong; steeper than 1 in 1: "Needs a look"; flatter than 1 in 500: "Needs a look" [DRAFT D-276, D-288].
18. **A steepest grade or a speed limit** besides the flattest: not researched or ruled [NOT RULED].
19. **Never smaller downstream:** a pipe smaller than one arriving at its upstream pit is drawn as typed and shows amber "Needs a look", never blocked ("Draw it, amber 'Needs a look'") [D-263, D-373 item 2].
20. **Exceptions** (a detention pipe into an orifice or pump pit; a sleeve) come later [D-378, D-379 item 2].
21. **Other limits:** a pipe over 1,050 dia. is "Needs a look"; a zero or negative diameter or length is Wrong and checks built on it read "Cannot check yet"; a level below 0.00 is amber "check the datum" [DRAFT D-288].
22. **The tolerance:** 5 mm on levels and cover, a setting the engineer can change per job in the Job window; in Stage 1 the office default [D-321, D-381].
23. **Suits:** green, good [D-286 rule 14, D-295].
24. **Needs a look:** amber, a warning that never blocks [D-149, D-295].
25. **Wrong:** orange-red, a decided figure that fails, never blocking [D-140, D-295].
26. **Short:** the approved style lists it beside Wrong; for a pipe, whether a cover failure reads "Wrong" or "Short" in the answer band is not said [NOT RULED].
27. **Cannot check yet:** grey, a check that cannot run because a figure is missing ("Grey, like 'not known yet'") [D-219].
28. **Not known:** grey "Not known" in the window, "TBC" on the sheet [D-178, D-295].
29. **Every status comes with its word,** as a solid fill with dark text [D-286 rule 13, D-295].
30. **Exact figures:** every length and level is first taken to the nearest tenth of a millimetre, then rounded half up for display (10.0049 m shows 10.00, 10.0050 m shows 10.01) ("Yes, half up") [D-341, D-380].
31. **Levels print to two decimals; the grade prints as typed** [D-154].
32. **A printed working adds up as printed;** where the house places would make a printed figure disagree with its verdict, a place is added [DRAFT D-289].
33. **A checker working from the printed inverts** may get a slightly different grade from the label; whether a note says so is not said [NOT RULED].
34. **Where he sees a check result in Stage 1,** with no Unfinished list (the Pipe window only, a mark on the drawing, the command line) [NOT RULED].

## 9. Older drawings and hand-drawn pipes

1. **New jobs first:** old hand-drawn drawings still open and plot; a tool to adopt them comes later [D-027].
2. **New jobs start from the office template** [D-191].
3. **A hand-drawn polyline is taken up** by picking it as a run (section 2, lines 38 to 43) [D-356, D-375].
4. **A plain line on a stormwater layer drawn by someone without the plug-in:** one line on opening with a "take it up" click, never automatic [D-192].
5. **Whether that opening line is part of Stage 1** is not said [NOT RULED].
6. **Drawings made with the old plug-in's special pipe:** a one-off "make it ordinary" tool, later, on a copy first [D-119].
7. **A pit or pipe drawn with the old plug-in** is readable only; an edit is refused in words [DRAFT D-261].
8. **Existing (as-built) pipes on a job:** other existing drains stay hand-drawn in the first release [D-190].
9. **Whether existing pipes may be drawn with this tool** on an existing layer is not said [NOT RULED].
10. **A drawing edited by hand without the plug-in, then reopened with it:** the self-check reports what was changed by hand [DRAFT D-094].
11. **The drawing keeps the standards it was designed with;** on opening, one line says what changed in the office list and offers to switch; nothing changes unless a person says so [D-180].
12. **A drawing begun by SAVE AS of the last job,** with that job's pipes in it: not said (can wait) [NOT RULED].
13. **A pipe record that is damaged or written by a newer version:** whether it is refused in words is not said [NOT RULED].
14. **A drafter's own words on an older label** survive a size change, flagged [D-182].

## 10. What the pipe hands to other tools, and what waits for Stage 2

1. **To the Pit tool:** the pipes arriving and leaving, their sizes and inverts, so a pit's levels and a new pipe's opening size come from them [D-171, D-373].
2. **To the pit schedule (Stage 2):** each inlet and outlet's diameter and invert [D-109, D-113, D-347].
3. **To Detention (Stage 2):** detention pipes read off the drawing with their sizes and lengths [D-347, D-349].
4. **To the Unfinished list (Stage 2):** loose pipes, hand-typed labels no longer matching, overlapping text and APPROX. figures [D-176, D-182, D-311, D-368].
5. **To the legal point (Stage 2):** the end of the last pipe, where the system ends [D-274].
6. **To the inlets (Stage 2):** an inspection opening at a bend, a GIO anywhere along the pipe and slid by its grip; a pipe off a downpipe opens at 100 unless it joins a pipe [D-050, D-081, D-373 item 4].
7. **Plotting with open items:** one quiet command-line line with the count, never a stop (needs the Unfinished list) [D-188].
8. **Long section:** parked [D-338].
9. **Waits, other kinds:** charged ("100 DIA. UPVC PIPE CHARGED TO WATER TANK"), suspended ("150 DIA. UPVC SUSPENDED PIPE AT 1 IN 100 MIN."), detention on its own layer in colour 160 with twin barrels kept matched, and the rising main [D-082, D-083, D-156, D-268, D-349, D-377].
10. **Waits, the sleeve** over part of a pipe [D-378].
11. **Waits, sizing a run automatically,** changing size part way along [D-379 item 3].
12. **Waits, the survey read as a guide for ground levels, "what is over it" read off the plans, and the slab read off the drawings** [D-293, D-383 items 6 and 7].
13. **Waits, no "smaller downstream" warning at an orifice or pump pit** [D-379 item 2].
14. **Waits, pipe capacity:** how it is checked is not said [NOT RULED].

## 11. Settings

1. **New pipe size:** 100 dia. [D-263, D-373 item 4].
2. **New pipe grade:** 1 in 100 [D-143, D-263].
3. **Material by size:** 100 UPVC, 150 UPVC SN8, as an office list [D-239].
4. **Label gap from the pipe:** 75 mm [D-361, D-366].
5. **Invert offset from the pit:** 200 mm [D-362, D-366].
6. **Drop across a pit:** 0.02 m [D-141].
7. **Tolerance on levels and cover:** 5 mm [D-321].
8. **Grade pass:** at two decimal places [D-380].
9. **Flattest ordinary grade before amber:** 1 in 200 [D-142].
10. **Upper "Needs a look" limits:** grade flatter than 1 in 500, pipe over 1,050 dia. [DRAFT D-288].
11. **"What is over it" presets:** the ten lines, with the driveway figures of D-330 [D-287, D-330].
12. **Text size:** for a 1:100 viewport [D-381].
13. **Opening rule:** "follows what it joins", switchable per tool to "always office default" or "always last used" [D-263].
14. **Pipe kinds and label wordings:** rows in the office list [D-268, D-377].
15. **Flow arrow on by default; every known invert written by default** [D-369, D-383 item 9].
16. **The office list is one place,** editable by the office [D-013, D-055].
17. **The drawing keeps the values it was designed with** [D-180].
18. **Last used choices** are kept between AutoCAD sessions in a small CE file of the tool's own, never an AutoCAD setting, profile or registry entry [D-263].
19. **The path to the tool's own office blocks and set-up** is one data setting [D-352].
20. **Where the office list lives in Stage 1, who may change it, and how a drafter changes the 5 mm tolerance or the 75 and 200 offsets** with no Job window and no Manager: not said [NOT RULED].

---

## 12. Every gap

Each item: the line it comes from, the question as a drafter would answer it, a real drafting example, the recommended answer, and the matching unknown in `UNKNOWNS.md`.

1. **Section 1, line 3, the ribbon button.** Where does the Pipe button sit on the CE Civil tab, and what does it say? Example: a drafter who does not know CD looks for the pipe on the ribbon. Recommended: first button on the CE Civil tab, labelled "Pipe", beside "Pit". New.
2. **Section 1, line 6, old plug-in loaded second.** If the old plug-in loads after the new one, which answers CD? Example: a colleague's PC loads the old suite at start-up and the new one by NETLOAD. Recommended: Tim tries it once with his own hands; the release must say plainly if the old one wins. U-003.
3. **Section 1, line 7, CD typed on a layout.** What happens if he types CD on the sheet? Example: he is checking the layout and types CD out of habit. Recommended: refuse with "Pipes are drawn in the model; switch to Model and type CD again", drawing nothing. New.
4. **Section 1, line 8, read-only drawing.** Example: a drawing opened read-only from the job folder. Recommended: refuse before the first click, saying the drawing is read-only. New.
5. **Section 1, line 10, units not set.** Example: an architect's drawing with units left "unitless". Recommended: refuse like a metre drawing and say "set the drawing units to millimetres", since guessing could draw a pipe 1,000 times off. New.
6. **Section 1, line 12, office copy missing.** What does it say if the tool's own office blocks and set-up folder cannot be found? Example: a broken install on a laptop. Recommended: "The office set-up that comes with the CE tools cannot be found. Nothing was drawn. Reinstall the CE tools or tell the office." U-025.
7. **Section 1, line 15, pipe layer locked.** Example: the drafter locked the stormwater layer to protect it while moving the house. Recommended: refuse with words naming the layer; never unlock it for him. U-061.
8. **Section 1, line 16, something selected before CD.** Example: he selects a polyline sketch, then types CD. Recommended: use a single selected plain polyline as the run (as if picked); anything else selected is ignored and the normal prompt shows. New (U-024 asks the same for a pit).
9. **Section 1, line 17, speed limits.** Are 0.3 seconds to open and 0.1 seconds to follow typing right? Example: changing 100 to 150 and watching the preview. Recommended: yes, as drafted. New.
10. **Section 1, line 18, wording pass.** Who settles the exact command-line prompts and messages? Example: the first prompt after CD. Recommended: one wording sheet for the Pipe tool shown to Tim as a tick list before he drafts. New.
11. **Section 2, line 3, click or pick.** How does the first prompt tell a polyline pick from a start point on a polyline? Example: he wants to start a pipe on the corner of a plain sketch line that is not meant to be the run. Recommended: the prompt reads "Click the start, or [Polyline]"; typing P (or clicking the option) then picks a polyline; a plain click is always a start point. New.
12. **Section 2, line 8, bends "within the standards".** Which bend angles and how many bends does the standard allow, and should the tool warn? Example: a 100 dia. pipe with three 90 degree bends down the side of a house. Recommended: research the plumbing standard first; then an amber "Needs a look" only, never a block. U-098.
13. **Section 2, line 13, how a caught pit looks.** Example: drawing toward P3 in a crowded corner. Recommended: the pit's outline brightens in the CE highlight, with a hover tip "P3". U-103.
14. **Section 2, line 17, how long before an inspection opening is offered.** Example: a 100 branch joining a bend in a 30 m main. Recommended: research the standard and office practice; put the figure in the office list. U-041.
15. **Section 2, line 18, inspection opening offer in Stage 1.** Example: the branch joins at a bend but the Inlet tool is not in Stage 1. Recommended: Stage 1 shows nothing; the offer arrives with the Inlet tool in Stage 2. New.
16. **Section 2, line 20, starting on a loose pipe's open end.** Example: he drew a loose 100 from the back downpipe yesterday and now continues it to P2. Recommended: the new run joins that end as a pipe-to-pipe join and the window shows both, with the old pipe's size as the arriving size. New.
17. **Section 2, line 25, where the ends sit at a pit passed through.** Example: a run clicked P1 to P5 that passes straight through P3 off-centre. Recommended: each pipe meets the wall where the drawn line crosses it, so the plan shows exactly what he drew. New.
18. **Section 2, line 27, last click inside a pit.** Example: he ends the run with a click in the middle of P1. Recommended: the pipe ends on the wall facing where the run came from, square to it, at the inner wall (the mirror of the start rule). New.
19. **Section 2, line 30, crossing another pipe.** Example: a new 100 crosses an existing 150 with no pit. Recommended: a crossing, no join; the clearance check waits for the office figure. U-043.
20. **Section 2, line 31, passing a pit without joining it.** Example: a pipe must run past P2 to reach P1, clipping P2's corner. Recommended: the run splits at any pit it passes through; to pass by, draw round it; a "pass over" tick comes later if needed. U-042.
21. **Section 2, line 35, Escape, Close and one click then Enter.** Example: he clicks once, changes his mind and presses Escape. Recommended: Escape ends with nothing drawn; no Close option (a closed run is refused as for polylines); one click then Enter ends with nothing drawn and a line saying a pipe needs two points. New.
22. **Section 2, line 36, Undo while clicking.** Example: he clicks a wrong bend half way down the run. Recommended: U steps back one click, as PLINE does. New (D-324 predates draw-first).
23. **Section 2, line 40, a polyline's width.** Example: a 375 wide sketch polyline picked as the run. Recommended: as drafted, the width is ignored and the run opens at the biggest arriving, else 100. New.
24. **Section 2, line 41, a polyline's layer and colour.** Example: a sketch on layer 0 in red. Recommended: ignored; the pipes go on the pipe layer. New.
25. **Section 2, line 42, other objects as a run.** Example: a LINE, a spline or a 3D polyline picked. Recommended: a LINE is taken as a one-length run; a spline, a 3D polyline with varying height, or anything inside a block is refused with the reason. New.
26. **Section 2, line 46, the polyline after Cancel.** Recommended: left exactly as it was, as drafted. New.
27. **Section 2, line 47, clicked points after Cancel.** Example: he presses Cancel by mistake after clicking a long run. Recommended: one Undo-free retry: typing CD again offers "Use the last run" for that drawing until something else is drawn. New.
28. **Section 3, line 3, length never typed.** Example: a pipe whose real length on site differs from the plan. Recommended: as drafted, the length is always measured from the drawing; to change it, change the drawing. New.
29. **Section 3, line 5, naming a pipe.** Example: the window title for the pipe from P4 to P3. Recommended: "P4 to P3" and "free end" for a loose end, as drafted. New.
30. **Section 3, line 6, window title.** Recommended: "Pipe · P4 to P3", or "Pipe · 3 pipes, P6 to P3" for a run, matching the Pit window's "Pit · P1". New.
31. **Section 3, line 11, preview sizes.** How tall is the top strip and how big the side picture? Example: a run of five pipes down a long side boundary. Recommended: a picture of the window both ways for Tim, starting at a third of the height as Detention has. U-038.
32. **Section 3, line 12, the drawing behind lighting up.** Example: while the window is open, the run also glows on the real drawing. Recommended: ask Tim once with a picture; start with the preview panel only. U-100.
33. **Section 3, line 13, window size.** 80 per cent of the AutoCAD window, or two set sizes? May it scroll? Example: the window on a drafting laptop. Recommended: two set sizes, laptop and desktop, never scrolling, shown as a picture first. U-011, U-096.
34. **Section 3, line 15, where the window opens.** Example: a drafter with two monitors. Recommended: centred on the AutoCAD window the first time, then where he last left it. U-094, U-105.
35. **Section 3, line 16, Inspect.** Does every window still need Inspect? Example: he wants to look at the house wall while the window is open. Recommended: keep it, quiet, at bottom left, since the preview may not show everything. U-110.
36. **Section 3, line 17, Match.** Example: he wants a new pipe to take the settings of an existing 150 SN8. Recommended: keep a quiet Match button at bottom left beside Inspect. New.
37. **Section 3, line 19, the window line by line.** Recommended: one full-size picture of the Pipe window in the approved style for Tim to tick or correct, before it is built. U-037.
38. **Section 3, line 21, Kind box in Stage 1.** Recommended: hidden in Stage 1 (only one kind), shown when the second kind arrives. U-037.
39. **Section 3, line 23, the size and grade lists.** Example: the size list on a house job. Recommended: sizes 90, 100, 150, 225, 300, 375, 450; grades 1 in 50, 60, 80, 100, 150, 200; any other typed. New.
40. **Section 3, line 27, what "arriving" means.** Recommended: as drafted, only pipes whose downstream end joins the pit. New.
41. **Section 3, line 30, typed run size against a bigger arriving pipe.** Example: he types 150 for a run P1 to P5, but a 225 already arrives at P3. Recommended: all five stay 150 as typed (held, D-379), and P3 to P2 onwards show amber "Needs a look: smaller than the 225 arriving". New.
42. **Section 3, line 32, an existing pipe's size read off the drawing.** Recommended: as drafted, the drawn width; never 100 offered. U-115 (closed for the mismatch case).
43. **Section 3, line 34, the size's source words.** Recommended: as drafted: "worked out", "read off the drawing", or a solid typed box. New.
44. **Section 3, line 37, material above 150.** Example: a 225 pipe between pits. Recommended: research the office's issued sheets and fill the office list (likely UPVC SN8 for 225 and above). New.
45. **Section 3, line 47, typing at the other end turns the run.** Example: he types the connection invert at the bottom of a run being worked from the top. Recommended: yes, as drafted. New.
46. **Section 3, line 52, several pipes arriving at different levels.** Example: P4 has a 100 arriving at 12.40 and a 150 at 12.30. Recommended: the lowest arriving invert, less the 0.02 drop, sets the pipe leaving. New.
47. **Section 3, line 53, one grade or a grade per pipe in a run.** Example: a run of four pipes where one must be flatter to keep cover. Recommended: one grade box for the run, with a row per pipe below where any pipe can be typed over. U-037.
48. **Section 3, line 55, drop at a pipe-to-pipe junction.** Example: a 100 branch joining a 150 with no pit. Recommended: no drop; the branch invert sits at or above the main's invert at the join, checked. New.
49. **Section 3, line 60, where "what is over it" and ground points sit.** Recommended: both in step 1 under a quiet "Cover check (optional)" heading; "Add a ground point" steps the window aside for one click. U-037.
50. **Section 3, line 64, sleeve in Stage 1.** Example: a 100 sleeved in a 150 under a garage slab. Recommended: out of Stage 1; it comes with Stage 2 with a picture first. U-111, U-112.
51. **Section 3, line 65, rarely changed settings to Properties.** Recommended: explain with two pictures of the Pipe window, before and after, then ask. U-052.
52. **Section 3, line 66, the answer band.** What is the one answer for a pipe? Example: a pipe with good grade but 40 mm short of cover at the downstream end. Recommended: the worst result, named with its end ("Wrong: cover 40 mm short at P3"), else "Suits". New.
53. **Section 3, line 69, Escape.** Recommended: Escape equals Cancel, as drafted. U-051.
54. **Section 3, line 70, half-filled window offered back.** Recommended: no; Escape and Cancel leave nothing behind. U-051.
55. **Section 3, line 71, what carries to the next run.** Recommended: as drafted, the ticks and label choices carry, the size never does. New.
56. **Section 4, line 2, band width is the size.** Recommended: yes, as drafted (a 100 pipe is a 100 wide band, as drawn today). New.
57. **Section 4, line 4, layer, colour and lineweight.** Example: the ordinary pipe on an issued sheet. Recommended: read them off the office template and three issued jobs and show Tim one line to confirm. New.
58. **Section 4, line 7, inner wall distance.** Recommended: measure PIT BLOCK 3 in AutoCAD for all five sizes; show Tim one picture. U-031.
59. **Section 4, line 10, label as text.** Recommended: yes, as drafted. New.
60. **Section 4, line 11, ordinary label wording.** Is it "100 DIA. UPVC PIPE AT 1 IN 100 MIN."? Recommended: yes, as on the office's issued sheets. New.
61. **Section 4, line 15, unknown and Wrong grades on the label.** Recommended: as drafted, TBC for unknown, the typed figure kept when Wrong. New.
62. **Section 4, line 16, a worked-out grade on the label.** Example: inverts 12.40 and 12.30 typed over 7.3 m give 1 in 73.0. Recommended: print to the nearest whole number ("1 IN 73"), as the office writes grades. New.
63. **Section 4, line 18, unreadable existing size.** Recommended: label left as drawn, as drafted. New.
64. **Section 4, line 20, where a hand-typed label is flagged in Stage 1.** Recommended: an amber line in that pipe's window and one command-line line when the change is made. U-049.
65. **Section 4, line 22, label text style and height.** Recommended: read the office template's pipe text style and height at 1:100 and confirm with Tim in one line. New.
66. **Section 4, line 23, masks.** Recommended: yes, masked as the office draws them, as drafted. U-079.
67. **Section 4, line 24, mask margin.** Recommended: the office template's current mask margin, on from the first day. U-079.
68. **Section 4, line 27, which side is "above".** Example: a pipe running straight up the page. Recommended: "above" is the side that reads correctly, that is the left of a pipe running up the page; then flip. New.
69. **Section 4, line 28, text aligned and the right way up.** Recommended: label, invert levels and arrow always run along the pipe and never read upside down, as AutoCAD's own aligned text does. U-072.
70. **Section 4, line 31, where the overlap flag shows.** Recommended: the same place as other Stage 1 checks (gap 103). U-082.
71. **Section 4, line 32, what counts as a clash.** Example: the label lands on a hatch boundary. Recommended: pits, pipes and CE text only in Stage 1; hatches and other lines later. New.
72. **Section 4, line 36, invert text layer.** Recommended: the same layer as the label, read off the office template. New.
73. **Section 4, line 38, what the 200 mm is from.** Recommended: from the inner wall where the pipe ends to the near end of the text. New.
74. **Section 4, line 41, the arrow's look.** Recommended: the office's own arrow from the issued sheets, at the label's text height, on the label's layer. U-078 (closed for placing only).
75. **Section 4, line 43, text on a pipe with bends.** Example: a pipe with one bend, a 1 m leg and an 8 m leg. Recommended: the label on the longest straight length; each invert on the length that touches its pit; the arrow on the longest length opposite the label; no text crosses a bend. U-107.
76. **Section 4, line 49, the APPROX. note reminder in Stage 1.** Recommended: one command-line line the first time anything prints APPROX. in a drawing. New.
77. **Section 5, line 4, direction after the outlet.** Recommended: as drafted, for Stage 2 when the outlet exists. U-032 (closed for Stage 1).
78. **Section 5, line 5, a reversed direction held.** Example: he reverses a pipe the tool thought ran the other way. Recommended: yes, held like any typed figure; the tool may then only offer "Turn round", never turn it. New.
79. **Section 5, line 6, what a reverse does.** Example: a pipe with only the downstream invert typed is reversed. Recommended: typed levels stay at their physical ends (they are levels at a place, not "up" or "down"); MIN. and the size checks re-run; a whole run reverses when the run is opened. New.
80. **Section 5, line 7, uphill and very steep grades.** Recommended: as drafted. New.
81. **Section 6, line 3, CDEDIT.** Check CDEDIT against the old plug-in, and confirm it replaces D-056's "only placing has a name". Recommended: keep CDEDIT as Tim's newer word. New.
82. **Section 6, line 4, Properties or an inspector.** Recommended: answer Tim: Properties is not proven; offer a CE side panel as the fallback, picture first. U-052.
83. **Section 6, line 7, edit one pipe of a run.** Example: double-clicking the middle pipe of a run of four. Recommended: the window opens on that one pipe; selecting the four opens them together with "Varies". New.
84. **Section 6, line 15, edit a level and the pipes below.** Example: he lowers the upstream invert of the top pipe of a run. Recommended: pipes below re-work only where their levels were worked out, never where held, and the window lists what moved. New.
85. **Section 6, line 17, a side choice in the window.** Recommended: yes, a "Label side" pair of buttons beside the label tick, as well as the grip. U-037.
86. **Section 6, line 20, a retyped invert wording.** Example: he edits "IL 12.31" to read "IL 12.31 (EX)". Recommended: kept and flagged, as a label is (D-182). New.
87. **Section 7, line 2, label offset on a moved pipe.** Recommended: yes, as drafted. New.
88. **Section 7, line 5, a pit moved so a pipe's length changes.** Example: P2 moved 2 m on the architect's update, a 10 m pipe at 1 in 100 with both levels typed. Recommended: a picture of the small "levels or grade" window first; meanwhile in Stage 1 typed levels stay, the grade is worked again and shown changed in one command-line line. U-053, U-113.
89. **Section 7, line 6, re-placing an auto-placed label.** Example: a pit move turns a pipe 20 degrees. Recommended: a label never moved by hand is re-placed by the placing rules; a hand-moved one keeps its offset. New.
90. **Section 7, line 9, words for locks, xrefs and reference edits.** Recommended: one line each naming the part and the layer or xref, nothing changed. U-061.
91. **Section 7, line 12, moving one bend.** Example: he grips a bend to pull the pipe off a footing. Recommended: the length is read again, levels follow as for a length change, and labels re-placed unless moved by hand. U-057.
92. **Section 7, line 15, which grips.** Recommended: a picture of a pipe's grips (each end, each bend, label, each invert, arrow) for Tim, then a test in AutoCAD. U-057.
93. **Section 7, line 18, how "assumed" shows on a copy.** Recommended: APPROX. on the plan and an amber "Needs you: assumed level, copied from P3" in the window. U-063.
94. **Section 7, line 22, ROTATE and SCALE.** Example: rotating a whole unit's drainage 90 degrees. Recommended: ROTATE as a move (text re-placed, readable); SCALE refused on pipes with words, since it changes sizes. U-060.
95. **Section 7, line 23, TRIM, EXTEND, BREAK and the rest.** Example: TRIM cuts a pipe at a wall line. Recommended: the pipe is read again after any of these; a pipe cut in two by BREAK becomes two loose pipes with "not joined yet"; JOIN and PEDIT refused on pipes with words. New.
96. **Section 7, line 27, erasing a mid-run pit.** Recommended: both pipes stay "not joined yet", with one quiet offer to join them into one. U-070.
97. **Section 7, line 30, REDO.** Recommended: REDO puts back exactly what the Undo took, as one step. New.
98. **Section 7, line 32, pipe end angle after a pit resize.** Recommended: as drafted. U-050.
99. **Section 7, line 35, which half's grade gives.** Example: P7 dropped half way along a 10 m pipe at 1 in 100 with both ends typed. Recommended: split the difference evenly (both halves equal grade), shown as worked out. New.
100. **Section 7, line 37, MATCHPROP or a hand layer change.** Recommended: allowed; a pipe moved off its layer shows amber "Needs a look: not on the pipe layer". U-065.
101. **Section 7, line 38, paste and WBLOCK.** Recommended: pasted pipes are new loose pipes with levels assumed, as for COPY. U-064.
102. **Section 7, line 39, PURGE, AUDIT, RECOVER.** Recommended: test in AutoCAD that each leaves pipes and joins intact. U-071.
103. **Section 8, line 3, cover check with "what is over it" unknown.** Recommended: as drafted, grey "Cannot check yet". New.
104. **Section 8, line 7, the pipe's outside size.** Example: a 100 UPVC pipe's real outside diameter for cover. Recommended: research the makers' figures and keep an outside size per material and size in the office list. U-086.
105. **Section 8, line 9, slab thickness in Stage 1.** Example: a pipe under a 125 mm driveway slab. Recommended: typed on the pipe in its window in Stage 1, moving to the Job window in Stage 2. New.
106. **Section 8, line 14, cover at a bend.** Recommended: each bend is checked as a station on the straight ground line between the pits, so a deep bend cannot hide. New.
107. **Section 8, line 17, the extra grade limits.** Recommended: as drafted. New.
108. **Section 8, line 18, a steepest grade.** Recommended: research first; amber only. U-089.
109. **Section 8, line 21, other limits.** Recommended: as drafted. New.
110. **Section 8, line 26, "Short" or "Wrong".** Recommended: "Wrong" for a cover or grade failure, with the shortfall in words ("Wrong: 40 mm short at P3"); "Short" is kept for storage. New.
111. **Section 8, line 32, printed working adds up.** Recommended: as drafted. New.
112. **Section 8, line 33, a note about printed inverts and grade.** Recommended: nothing on the sheet; the grade is the design grade as typed. U-081.
113. **Section 8, line 34, where check results show in Stage 1.** Recommended: in the Pipe window, plus one command-line line after OK naming any Wrong or "Needs a look". U-082.
114. **Section 9, line 5, the opening "take it up" line in Stage 1.** Recommended: not in Stage 1; picking a polyline as a run covers it. New.
115. **Section 9, line 7, old plug-in parts read only.** Recommended: as drafted. U-091.
116. **Section 9, line 9, existing pipes with the tool.** Recommended: not in Stage 1; existing drains stay hand-drawn. U-045.
117. **Section 9, line 10, hand edits without the plug-in.** Recommended: as drafted, the self-check reports them; test it. U-092.
118. **Section 9, line 12, SAVE AS of the last job.** Recommended: can wait; jobs start from the template. U-006.
119. **Section 9, line 13, damaged or newer records.** Recommended: refuse the edit in words naming the pipe; never guess. New.
120. **Section 10, line 14, pipe capacity.** Recommended: later; sizes come from the standard until Tim says otherwise. U-090.
121. **Section 11, line 10, upper limits.** Recommended: as drafted. New.
122. **Section 11, line 20, where settings live in Stage 1.** Example: Tim wants the invert offset at 250 on one job. Recommended: the office list ships with the tool and only Tim changes it; per-job changes (tolerance) wait for the Job window; the drawing keeps what it was drawn with. New.

---

**Count:** 336 numbered lines in sections 1 to 11. Ruled 214, DRAFT 29, NOT RULED 93. Every DRAFT and NOT RULED line is in section 12 (122 gaps, checked line by line).

**Rulings in force that disagree (neither marks the other):** (1) D-287's driveway presets (house driveway concrete 100, pavers 75, common driveway 100) against D-330 ("300 paved, 450 unpaved" under a driveway, detention pipe or not); this page uses D-330 as the later word. (2) D-056 ("Only placing has a name") against D-383 (CDEDIT, a typed name for editing). Also: D-065 (every window always has an Inspect button) against the approved style of D-295, which has none; and D-041 (a clashing invert slides) against D-365 (flip first, slide second).
