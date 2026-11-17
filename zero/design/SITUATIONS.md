# Real-use situations: where the design would surprise, block or mislead a drafter

**Why this page exists.** Tim, 18 Nov 2026 (D-175, D-176), after the loose-pipe answer: "YOU NEED TO THINK ABOUT THESE THINGS BEFORE CREATING THE PLUGIN. THERE WILL BE OTHER USER EXPERIENCE THINGS THAT POP UP THAT NEED THE SAME KIND OF ATTENTION".

**What was done.** A read-only walk of the plug-in through messy real jobs (made-up houses and unit jobs; no real job, client or address). Read: DECISIONS D-001 to D-176, FOUNDATION, UI_PLAN, INPUT_AUDIT, UI_UX_RULES, CONCEPT_GAP_CHECK, OPEN_QUESTIONS, THE_PLAN, PERFORMANCE, TRIAL_RESULTS, the reference library (by search: SHEET_SETUP, ELEMENTS, TABLES_AND_BOXES, TITLE_BLOCK_AND_ISSUE, JOB_KINDS, CIVIL_JOB_FLOW, TOOLS_TODAY, Stage 1 evidence), `C:\CE_CIVIL\DESIGN.md`, the `acad\` design and DRAFTS pages, the brain's `joins.csv` and `tools.csv`, and the bench screenshots of the Pit, Pipe, Levels, Detention and Schedule windows.

**Status: DRAFT for Tim, 18 Nov 2026.** Nothing here is decided. Where the reference does not say how the office does something, it is marked UNKNOWN and asked. Nothing was built, run or installed.

---

## The short answer for Tim

1. **About 70 situations found.** Most of them are covered by about 15 general rules, like the loose-pipe rule. Each rule covers many cases (listed further down).
2. **The biggest hole:** joining later is not built. A free pipe end cannot be joined to a pit afterwards, and dragging an end onto a pit does not join it. That works against the loose-pipe ruling you just approved.
3. **Second:** there is no way to say "this is the outlet" (kerb, council pit, soakage). Without one, every run stays loose for ever, and head, orifice and storage never run.
4. **Third:** copying a unit's pits and pipes to the mirror unit carries the first unit's cover levels across as if they were measured there. That is a wrong sheet waiting to happen.
5. **Fourth:** the same drawing could show different figures on a colleague's PC, or after an update, because worked-out figures come from that PC's office list.
6. **Fifth:** how "assumed" and "not known yet" print on the sheet is still undecided. Today the office has no set way (D-030).
7. **18 questions for you** are below, most important first. Each has an example and a recommended answer.
8. **None of this stops the build starting.** Most items are gaps the builders close. Only the questions need you.

---

## The ten that matter most

1. **Joining later is missing.** As built, a free pipe end "cannot be joined to a pit later; draw it again" (DRAFTS_pipe_tool 11.2). Designing as you draw needs ends to join whenever they meet a pit or pipe, by the tool, a grip, MOVE or STRETCH.
2. **No outlet to aim at.** No tool places an outlet. The long section tool treats "the last pit" as the council connection, and it refuses runs under 3 pits, branches and runs over 5 pits. A house with one pit to the kerb is refused.
3. **Charged lines, downpipes, tanks and AG drains are not proper ends.** Pipes are two points only, and an end must be a pit or a point. So a charged line from a downpipe to a tank (D-038's own example) would sit in "not joined yet" for ever.
4. **"It used to follow and now it doesn't."** Pipe ends follow a plain MOVE only once the plug-in is switched on in that drawing (CEHOOKS, and PERFORMANCE 2.6 "starts only when a CE tool is first used"). Pit tags and cover texts never follow a MOVE (DRAFTS_pit 4).
5. **Copying to the mirror unit carries the wrong levels.** A copied pit keeps its held cover level and inverts. It becomes "not yet named", so on a two-unit job every pit needs renumbering by hand, and every copied level is wrong but looks right.
6. **A pit grows, its pipes do not move.** A size change does not move joined pipe ends to the new wall (DRAFTS_pit 10.2). Pit size worked out from depth (INPUT_AUDIT change 3) would make this happen on almost every job, and pipes would end inside the pit on the sheet.
7. **The design can change by itself on another PC.** Worked-out figures are never stored and are worked out again from that PC's office list. A colleague with a different list, or an update, silently changes drops, covers and labels.
8. **Assumed and unknown need one look, on screen and on paper.** Unknown checks show as amber "Needs a look: Cannot check yet" (DESIGN.md 5.6), not quiet grey (D-176). And the grey must never be written into the drawing, or it plots grey.
9. **A blank drawing cannot take a pit.** The Pit tool draws nothing if the office "Stormwater Pit" block is not already in the drawing. Orifice and pump pits draw nothing at all (DRAFTS_pit 1, 8). Starting from a blank drawing with only the xref would stop at the first pit.
10. **Edits made outside the windows have no single rule.** A label typed over by hand, a layer changed by MATCHPROP, a tag retyped, a colleague's edit with no plug-in: each is handled differently or not at all. One rule is needed: typed over means held and checked, never overwritten, never quietly stale.

---

## Questions for Tim

Each question has the context, a real-world example and the recommended answer. They are ordered by how much they affect the sheet.

1. **How does an ASSUMED figure print on the sheet?**
   **Context:** you design on assumptions (D-030), and the office has no set way of showing them. The office has written "APPROX. IL 1.14 ... BUILDER TO CONFIRM" and "TO BE CONFIRMED" on past sheets.
   **Example:** you assume the council pit invert is 4.95 before the letter arrives. On the sheet it could read "APPROX. IL 4.95", or "IL 4.95 (ASSUMED)", or just "IL 4.95".
   **Recommended:** the office's own word, "APPROX.", in front of every assumed level or figure. Add one standing note under the schedule: "FIGURES MARKED APPROX. ARE ASSUMED AND ARE TO BE CONFIRMED." It goes away by itself when the real figure is typed.

2. **How does a figure that is NOT KNOWN YET print when you plot?**
   **Context:** a pit with no cover level has no depth, so its schedule cells have nothing to show.
   **Example:** P4's cover level and depth cells. They could be left blank, or read "TBC".
   **Recommended:** "TBC". A blank looks like a drafting slip to a checker; "TBC" shows it was left open on purpose. A pipe label leaves out what it does not know (it already leaves out the grade when the grade is unknown).

3. **When you copy pits and pipes to the mirror unit, do the levels come across?**
   **Context:** a copied pit carries its held cover level and inverts, which belong to the other unit's ground.
   **Example:** unit 1's P2 has cover 5.70. You copy it to unit 2, where the ground is 5.40. The copy would print CL 5.70, which looks right and is wrong.
   **Recommended:** sizes, kinds, lids and grades come across as they are. Cover levels and held inverts come across marked "assumed: copied from P2" and print as APPROX. until you type or accept them. The copies take the next free numbers straight away.

4. **The drawing was designed with one office list, and a colleague's PC (or a plug-in update) has another. Which wins?**
   **Context:** standards such as the drop across a pit and the cover table fill in figures. They are not stored in the drawing.
   **Example:** your drawing used a 0.02 drop. The updated list says 0.03. Opened on the new list, every invert below P4 moves by 10 mm and every pipe label changes, with nobody touching it.
   **Recommended:** the drawing keeps the values it was designed with. On open it says one line: "This job used office list 12; this PC has list 13; 1 value differs (drop 0.02 to 0.03). Keep the job's / Use the new one." Keep is the default.

5. **Two separate systems on one site: how are pits numbered?**
   **Context:** D-075 says P1 at the outlet. Front and rear systems, or a basement pump system, each have their own outlet. How the office does this today is UNKNOWN.
   **Example:** the front system drains to the kerb, the rear to an easement drain. Is it P1 to P4 at the front and P5 to P8 at the rear, or P1 to P4 twice with a prefix (FP1, RP1)?
   **Recommended:** one number series across the site. Each system is numbered from its own outlet, the main (street) outlet first. Renumber does the lot.

6. **A pit is added in the middle of a run AFTER the drawing has been issued. What number does it take?**
   **Context:** Renumber would change numbers the council has already seen, and replies to council refer to them. What the office does today is UNKNOWN.
   **Example:** you add a pit between P3 and P4 at Rev B. It could become P13 (the next free number), P3A, or everything renumbers so it becomes P4 and the old P4 becomes P5.
   **Recommended:** before first issue, the plug-in offers Renumber (never runs it by itself). After first issue, the pit takes the next free number, and Renumber warns: "these numbers were issued at Rev A".

7. **When you MOVE a pit with plain AutoCAD, do its tag and cover level text go with it?**
   **Context:** pipe ends follow a moved pit. As built, the tag and the "CL" text stay behind (the same as today, where nothing is linked).
   **Example:** you nudge P3 600 mm to clear a path. The pipes follow, but "P3" and "CL 5.75" are left floating where the pit was.
   **Recommended:** yes, they follow and keep their place beside the pit. A label you have moved by hand keeps the spot you gave it, relative to the pit (D-014).

8. **You type over a pipe label by hand. What happens later?**
   **Context:** schedule cells already work like this: typed over means held, shown with a padlock (D-103). Labels have no rule yet.
   **Example:** you retype the label "150 DIA. UPVC PIPE AT 1 IN 100" as "... AT 1 IN 60 MIN." Then the grade changes to 1 in 80.
   **Recommended:** the same as schedule cells. Your wording is kept, never overwritten. When it no longer matches the pipe, it shows amber: "label says 1 IN 60, pipe is 1 in 80". One click lets it follow the pipe again.

9. **You retype a pit tag by hand (P3 to P7). Does that rename the pit?**
   **Example:** you double-click the tag text and type P7.
   **Recommended:** yes. A pit number is a name, not an engineering figure, so editing the tag renames the pit, and the schedule and pipe names follow. If P7 is already used, both show amber "two pits called P7". (A figure such as a grade or a level is never changed by editing its text: see question 8.)

10. **Placing many of the same thing: one window, then keep clicking?**
    **Context:** D-060 says the window opens every time, like Hatch. A two-unit job can have 24 downpipes.
    **Example:** type DP, set 100 dia once, then click 12 downpipes in a row, numbered DP1 to DP12, and press Enter to finish.
    **Recommended:** yes. The window opens once per command, then you keep placing with the same settings until Enter, the way Hatch takes several pick points. Typing DP again opens the window again.

11. **On a second issue, do you want the plug-in to list what changed since the last issue?**
    **Context:** title block and issue are not in the first release (D-097). Rework comes from architect changes and council send-backs (D-030), and the office clouds what changed now and then.
    **Example:** at Rev B only P3 (cover 5.75 to 5.80) and P4 (450 to 600) changed. A "Changed since Rev A" list shows exactly those two, so you know what to cloud.
    **Recommended:** yes, a small "Mark as issued" button and a "Changed since last issue" list in the first release. No title block work.

12. **When you plot with figures still assumed or not known, should the plug-in say so?**
    **Context:** nothing may block (D-140). There is no issue tool in the first release.
    **Example:** you plot C01 with the connection still assumed and P4's cover not known.
    **Recommended:** one line on the command line, never a stop: "Plotted with 1 assumed figure and 1 not known yet: see Unfinished." Plus the Unfinished count on the CE tab at all times.

13. **Charged lines and other pipes with bends: are they in the first release?**
    **Context:** the Pipe tool draws two-point pipes only. Charged lines are drawn today with 3 to 6 points, from downpipes to the tank (E-002).
    **Example:** a charged line from DP4 round the garage to WT1, with four bends.
    **Recommended:** yes. A charged, suspended or AG line may have bends. An ordinary gravity pipe stays two points, and a bend drawn in it brings one quiet offer of an inspection opening or a pit at the bend (as D-081).

14. **Existing pipes and pits, to be kept or removed: are they in the first release?**
    **Context:** existing drains are drawn by hand today on EX layers, labelled "225 DIA COUNCIL STORMWATER PIPE" (E-005, E-065). The office way of showing "to be removed" is UNKNOWN.
    **Example:** an old 100 dia line crosses the site and must be removed; the council pit at the front is kept.
    **Recommended:** first release: the existing council pit or pipe you connect to is an outlet (with assumed levels allowed). Other existing drains stay hand-drawn plain objects, which the plug-in ignores. "To be removed" waits until you say how the office shows it.

15. **Do drafters start a new job from the LAST job's drawing?**
    **Context:** the reference says jobs start from the civil template (SHEET_SETUP 13.1). Copying last job's drawing is UNKNOWN, and one "template" in the folder is really a finished two-unit job.
    **Example:** you SAVEAS last week's job and clear the layout. Its council, permitted discharge and connection come across inside the drawing.
    **Recommended:** whatever the answer, job facts that came from another file show as "assumed: from another drawing" until confirmed. Old pits and pipes left in the drawing are listed once: "12 pits from another job: erase them or keep them".

16. **Plain pipes drawn by hand on the stormwater layers: take them up?**
    **Context:** a colleague with no plug-in, or old habit, draws a pipe as a plain polyline. The plug-in does not see it, so the schedule and sums miss it.
    **Example:** a colleague on AutoCAD 2026 adds a 100 dia line on STORMWATER PIPE from DP7 to P2 and sends the drawing back.
    **Recommended:** on open, one line: "1 plain pipe on a stormwater layer is not part of the design: Take it up." Taking it up makes it a loose pipe, which joins if its ends meet pits. Never automatic.

17. **What screens do the office PCs and laptops have?**
    **Context:** windows are 80% of the screen at 1920 x 1080 and 2560 x 1440 (D-065). A laptop at 1920 x 1080 with Windows scaling at 125% or 150% has less usable room, and the window would be cut off. UNKNOWN which PCs run scaling.
    **Example:** a drafter on a 15-inch laptop at 150% scaling opens the Pit window and cannot see OK.
    **Recommended:** the smallest supported case is 1920 x 1080 at 125% scaling. Below that, the window moves its cards into tabs rather than cutting them off.

18. **Is the stormwater plan ever drawn at a scale other than 1:100?**
    **Context:** everything is in model space at 1:100, with text heights fixed for 1:100 and nothing annotative (SHEET_SETUP s7). A 40-unit site may not fit an A1 sheet at 1:100. JOB_A used three part plans with match lines instead.
    **Example:** a large unit site drawn at 1:200 would get 250-high text that prints 1.25 mm tall.
    **Recommended:** one job fact, "plan scale", default 1:100 and rarely touched. Text heights and offsets follow it. Part plans with match lines stay the normal answer for big sites.

---

## Rules this adds to the foundation

These sit beside "Unfinished is normal" in FOUNDATION.md. Each one covers many situations, so a new situation becomes a line in a list, not a special case.

1. **Every end is something.** A pipe end is at a pit, on another pipe (a junction), at an inlet (downpipe, overflow, floor waste, AG drain), at a tank, at an outlet, or loose. Only the last counts as "not joined yet". A charged line ending at a tank is finished, not loose.
2. **Ends join when they meet and part when they are pulled apart, whatever moved them.** The tool, a grip, MOVE, STRETCH, or a pit dropped on a free end all join. Pulling an end away unjoins it. Either way it happens quietly and the change is said once.
3. **Flow direction comes from the outlet, not from the order you clicked.** Until a run reaches an outlet, its direction is "as drawn, not settled". When it reaches an outlet, arrows and inverts follow the real direction, and a pipe drawn backwards turns round by itself.
4. **A figure tied to a place does not travel blindly.** A cover level, ground level, held invert or measured area that is copied, pasted from another drawing, or left behind by a long move becomes "assumed: came from P3" (or "from another drawing", or "before the move") until confirmed.
5. **A copy is a new thing.** It takes the next free number at once, quietly, and the command line says so. It never keeps the original's name.
6. **Plain AutoCAD edits are respected, never undone.** Afterwards one command-line line says what followed and what did not ("P3 moved: 2 pipe ends followed; P4 to P3 is now 9.20 m; 1 check changed"), and anything left broken goes into the Unfinished list.
7. **Every view can be typed over.** Labels, tags, cover texts and schedule cells: typed over means held, with a padlock. It is never overwritten, and it shows amber when it no longer matches the fact. One click lets it follow again.
8. **Status is never written into the drawing.** Grey, amber and red live only in the plug-in's windows, lists and temporary on-screen highlights. The DWG only ever holds office layers and colours, so it plots the same whatever state the design is in.
9. **The design changes only when a person changes it.** A different PC, a plug-in update or a new office list never moves a figure silently. The drawing keeps the standard values it was designed with, and a difference is said once with a choice.
10. **Never strip or rewrite what is not understood.** Notes written by a newer version, a note that cannot be read, old-plug-in objects, things on locked or frozen layers, and things inside xrefs are left exactly as they are and reported.
11. **The drawing needs a shape even when a fact is unknown.** The plug-in draws the standard or last-used shape (a pit at the last size, a pipe at 100 dia), marks that fact "assumed", and lists it.
12. **Nothing typed is lost.** Cancel keeps what was typed as a draft for the session. A clash never stops OK from saving what you typed; the clash stays red and listed.
13. **Not known is grey; only decided figures get amber or red.** "Cannot check yet" is a grey note, not amber "Needs a look".
14. **One change, every view follows, in one undo step.** That includes views outside the open window: the schedule, pipe labels across the sheet, the cover texts and the criteria box. The change list says how many texts changed.
15. **Following is always on** in a drawing that holds CE things, from the moment it opens. If following ever missed a move (plug-in not loaded, a colleague's PC), the next open says so and offers one click: "Bring 2 pipe ends back to their pits".
16. **Many at once.** Select several things, and one window opens showing "Varies" where they differ. Only what you change is applied. Match copies choices (size, kind, lid, material), never place-bound figures (levels, numbers).
17. **AutoCAD's protections win.** A locked layer, an xref or REFEDIT is never worked around. What could not be updated is said in words and listed.
18. **One Unfinished list.** It holds: not joined yet; not known yet; assumed; typed over and no longer matching; changed by hand outside the plug-in; changed since the last issue. It is shown on demand and when you plot, and it never blocks.

---

## The situations

Each situation gives: **Story** (the real-world case); **Today's design** (what the design as written does, with the file or decision, or UNKNOWN); **Drafter expects**; **Proposal**; **Ruling or gap** (a question for Tim, or a gap the builders close); **How serious** (stops a job / wrong sheet / annoying every day / rare).

### A. Starting a job

**A1. A blank drawing with only the architect's plan attached.**
1. **Story:** a new house. You start a drawing, attach the cleaned background, type PT and click where the pit goes.
2. **Today's design:** the Pit tool draws nothing if the drawing does not already hold the office block "Stormwater Pit" ("No symbol is ever invented", DESIGN_PIT_TOOL 3.1; DRAFTS_pit 1). Layers are made if missing, but blocks are not.
3. **Drafter expects:** the pit appears, as the office block does from the palette today.
4. **Proposal:** when the block is missing, bring in the office's own block definition from the plug-in's block library file (the office block, not a made-up symbol), and say so once: "Stormwater Pit block brought in from the office library." Same for every office block a tool needs (tank, downpipe, arrow).
5. **Ruling or gap:** builders' gap (it does not invent a symbol, so it keeps the rule's intent).
6. **How serious:** stops a job.

**A2. No levels yet.**
1. **Story:** the survey has not come through, but you want to lay out pits and pipes now.
2. **Today's design:** levels are simply not held, and checks say "Cannot check yet", shown as amber "Needs a look" (DESIGN.md 5.6). A new pit's size is picked by you; the preview draws a 450 square "as a preview default" (DRAFTS_pit 7).
3. **Drafter expects:** to draw freely, with nothing nagging.
4. **Proposal:** Rules 11 and 13. Unknown levels show grey "not known yet". Pit size, if it is to be worked out from depth (INPUT_AUDIT change 3), is drawn at the last-used size marked "assumed: depth not known yet" until levels arrive. Then it settles, and "What else changes" says "P3 becomes 600 x 600".
5. **Ruling or gap:** gap (amber versus grey conflicts with D-176).
6. **How serious:** annoying every day.

**A3. No council letter yet.**
1. **Story:** the discharge point and permitted discharge are not known, so you assume a kerb outlet at the front and 6 l/s.
2. **Today's design:** figures can be held with source "assumed" (FOUNDATION 3, D-150 source list), but the bench windows show the connection invert as "given" and give no visible way to mark a typed figure "assumed" (bench_run_1080_dark). Only the Detention window's site area has a source drop-down.
3. **Drafter expects:** to type a guess and have it clearly marked as a guess everywhere.
4. **Proposal:** every typed figure's source chip can be picked (given, measured, assumed) with one click. Job facts typed before the letter start as "assumed". Assumed figures are listed in Unfinished and print as question 1 decides.
5. **Ruling or gap:** question 1 for the print; gap for the chip.
6. **How serious:** wrong sheet (an assumed figure that looks given).

**A4. The architect's plan is a PDF underlay or exploded linework.**
1. **Story:** the architect sends a PDF only.
2. **Today's design:** reading roof, paving and boundary areas from the drawing (INPUT_AUDIT section 4) assumes hatches and outlines; PDF underlays appear only inside detail blocks today (SHEET_SETUP s8.9).
3. **Drafter expects:** to click pits and downpipes against the PDF as usual.
4. **Proposal:** placing works against anything you can snap to. An area that cannot be read stays "not known yet" and the window asks once for it typed or picked round by hand (D-107). Never a guess.
5. **Ruling or gap:** gap (say it in the area card).
6. **How serious:** rare.

**A5. The survey in another file, or levels inside the xref.**
1. **Story:** cover levels are survey text inside the background xref, on layers that differ per job.
2. **Today's design:** level reading is "low to medium" reliability and waits on Q-007 / INPUT_AUDIT question 7. The background is attached twice or three times, 50,000 apart (Site and Ground), with polygon clips (SHEET_SETUP s8.3).
3. **Drafter expects:** to click a level text and have it used.
4. **Proposal:** offer the nearest level text with the text it came from, accepted by you, then locked (D-078). Only count the copy of the background that sits under the plan being drawn, never the stacked upper-floor copy 50,000 above.
5. **Ruling or gap:** gap (stacked-copy filter); INPUT_AUDIT question 7 is still Tim's.
6. **How serious:** wrong sheet if the wrong copy is read.

**A6. Drawing units not millimetres.**
1. **Story:** a drawing set up in metres, or with no units.
2. **Today's design:** the Pit and long section tools refuse a drawing not in millimetres (DESIGN_ACAD 4; DESIGN_PIT_TOOL 4.4).
3. **Drafter expects:** to be told plainly, and shown how to carry on.
4. **Proposal:** never a dead end. Say "This drawing is in metres: pits would be drawn 1000 times too big. Change the drawing to millimetres (UNITS) or carry on in metres." Carrying on in metres scales the shapes and text correctly. A drawing with no units is treated as millimetres and said once.
5. **Ruling or gap:** gap (the memory "no hard blocks" rule).
6. **How serious:** rare.

**A7. Starting from last job's drawing with its old pits in it.**
1. **Story:** you SAVEAS last week's unit job, clear the plan, and start.
2. **Today's design:** UNKNOWN whether the office does this (A1 template is the recorded start, SHEET_SETUP 13.1). The old pits keep their notes and the old job facts come with the drawing. The old plug-in read parked template blanks as live design (Stage 1 digest s7).
3. **Drafter expects:** old pits not to be mixed into the new design, and old council figures not to carry over silently.
4. **Proposal:** question 15. Job facts set in another file show "assumed: from another drawing". Leftover pits and pipes are listed once to erase or keep.
5. **Ruling or gap:** question 15.
6. **How serious:** wrong sheet (wrong council or permitted discharge).

**A8. The template's parked kit.**
1. **Story:** the template carries about 600 sample objects outside the frame, and finished jobs keep 374 to 423 of them (SHEET_SETUP s1.4).
2. **Today's design:** they are plain objects, so the plug-in ignores them. If the office later parks plug-in samples (a sample pit and pipe) there, they would join the Unfinished list and the schedule.
3. **Drafter expects:** samples never to count.
4. **Proposal:** CE samples kept in a template are marked "sample" in their note and never count in lists, schedules or sums. One click turns a sample into a real thing (that is how it gets copied in).
5. **Ruling or gap:** gap.
6. **How serious:** rare now, annoying later.

**A9. The old plug-in's special pipes in an older drawing.**
1. **Story:** a Rev C of a job first drawn with the old plug-in.
2. **Today's design:** "make it ordinary" tool comes later (D-119); old hand-drawn jobs still open and plot (D-027).
3. **Drafter expects:** to carry on by hand beside the new tools without the new tools tripping over the old objects.
4. **Proposal:** Rule 10: old objects are left exactly as they are and listed once ("this drawing holds 9 old-plug-in pipes; new tools ignore them"). New pits never try to join to them.
5. **Ruling or gap:** gap.
6. **How serious:** rare.

### B. Drawing as you design

**B1. Pipes before pits.**
1. **Story:** you sketch the main line from the back of the house to the kerb, then decide where pits go.
2. **Today's design:** the Pipe tool allows [Point] ends (DESIGN_PIPE_TOOL 1.2). A free end "cannot be joined to a pit later" (DRAFTS_pipe 11.2). Placing a pit at a free end is not covered. A pit placed ON a pipe splits it (D-077).
3. **Drafter expects:** drop P2 on the end of the line and it joins; drop P3 part-way and the pipe splits.
4. **Proposal:** Rule 2. A pit dropped on a free end joins it; on the middle of a pipe, it splits it (D-077); near a pipe (within the pit's own outline), it asks nothing and snaps to the pipe.
5. **Ruling or gap:** gap (directly against D-176).
6. **How serious:** stops a job (the office's way of working).

**B2. Pits before pipes.**
1. **Story:** you place all four pits first, then the pipes.
2. **Today's design:** works (the Pipe tool picks a start and end pit). A pit with no pipes shows "no pipes joined yet" (DESIGN_PIT_TOOL 4.5).
3. **Drafter expects:** as designed.
4. **Proposal:** keep. In the Unfinished list, a lone pit is "not joined yet", grey.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**B3. A pipe drawn the wrong way round.**
1. **Story:** you click P1 first and P4 second, downstream to upstream.
2. **Today's design:** the first pick is the upstream pit ("Pick the pit the pipe starts at", DESIGN_PIPE_TOOL 1.2), so the grade works the wrong way and the cover check goes red, or levels run uphill.
3. **Drafter expects:** the plug-in to know which way water runs.
4. **Proposal:** Rule 3. Direction is "as drawn, not settled" until the run reaches an outlet; then it is worked out from the outlet, and the arrow and inverts follow. Where both ends are pits with levels and it is clearly backwards, one quiet line offers "Turn round".
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet.

**B4. A pipe drawn through a pit instead of to it.**
1. **Story:** you draw P4 straight to P2, and the line passes over P3.
2. **Today's design:** UNKNOWN. Nothing checks it; the sheet shows a pipe crossing a pit with no join, and the schedule leaves P3 off that line.
3. **Drafter expects:** either it joins at P3, or it tells you.
4. **Proposal:** one quiet line in "What else changes": "This pipe passes over P3: Join at P3 (makes P4 to P3 and P3 to P2)." Never automatic, because a pipe may truly pass beside a pit.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet.

**B5. Two pipes crossing.**
1. **Story:** a charged line crosses over a gravity line.
2. **Today's design:** UNKNOWN; no join is made, which is right.
3. **Drafter expects:** no join, and a warning only if they clash in level.
4. **Proposal:** never join at a crossing. When both levels are known, check the clearance and show amber if they clash; otherwise grey "not known yet". (The clearance figure is a new standard line: UNKNOWN office figure.)
5. **Ruling or gap:** gap, plus one office figure to find.
6. **How serious:** rare.

**B6. A branch added into the middle of an existing pipe.**
1. **Story:** a downpipe line joins the main line between two pits.
2. **Today's design:** D-081 allows a branch with no pit and offers an IO. But `joins.csv` has no pipe-to-pipe join, and the Pipe tool's end is a pit or a point, so the branch would be loose for ever. D-102 (pipe stops at the inner wall) is about pits, not pipe junctions.
3. **Drafter expects:** the branch to join; the main pipe NOT to split (there is no pit); its arrival level worked out.
4. **Proposal:** a "junction on a pipe" join: the main pipe stays one pipe, the branch arrives at the main pipe's level at that point (worked out), and D-081's quiet IO offer applies.
5. **Ruling or gap:** gap (one join line, one sum).
6. **How serious:** stops a job (branches are on almost every job: the bench schedule has DP, AGI and TG inlet rows).

**B7. A pit dropped onto an existing pipe.**
1. **Story:** you need a pit part-way down an 18 m line.
2. **Today's design:** splits the pipe in two (D-077). Which half keeps which held figure is not said.
3. **Drafter expects:** both halves keep the grade; the levels carry on.
4. **Proposal:** both halves inherit the grade and material. A held upstream invert stays with the upstream half, a held downstream invert with the downstream half. The new pit takes the standard drop. The label is kept on the longer half; the shorter gets a new one at its standard spot. "What else changes" lists it all.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet if done wrongly.

**B8. A run with a bend and no pit.**
1. **Story:** a gravity pipe doglegs round a garage corner.
2. **Today's design:** two points only; "a pipe with more points is drawn by hand" (DRAFTS_pipe 11.1), so the bent pipe is outside the design.
3. **Drafter expects:** to draw it, and to be reminded that a bend in a gravity line usually needs an IO or pit.
4. **Proposal:** question 13. Gravity pipes: a bend makes two joined pipes with a "bend" junction (no pit), and the quiet IO offer of D-081. Charged, suspended and AG lines: bends allowed within one pipe.
5. **Ruling or gap:** question 13.
6. **How serious:** stops a job for charged lines (see B11).

**B9. Changing your mind three times.**
1. **Story:** you place P3, move it, erase it, place it elsewhere, then undo twice.
2. **Today's design:** one undo step per tool command (route 1, TRIAL_RESULTS trial 1). Numbers: next free number = one more than the highest (DRAFTS_pit 5), so P3 erased and placed again becomes P5.
3. **Drafter expects:** the number to come back to P3 when nothing else took it.
4. **Proposal:** "next free" means the lowest unused number, not one more than the highest, so an erased P3 frees P3 again. Undo and redo restore numbers exactly.
5. **Ruling or gap:** gap (small, but numbers matter on the sheet).
6. **How serious:** annoying every day.

**B10. A second, separate system on the same site.**
1. **Story:** a four-unit job: front units to the kerb, rear units to an easement drain; or a basement with its own pump system (K-012).
2. **Today's design:** the brain allows several connections, but the Detention window has one site, numbering is "P1 at the outlet" (D-075, one outlet), and the long section tool has one end.
3. **Drafter expects:** each system worked separately, with its own outlet and checks; detention on the system the council restricts.
4. **Proposal:** a system is "everything that drains to one outlet", found from the joins, never typed. Each outlet has its own facts (kerb, council pit, easement, soakage), and the strip and Unfinished list name the system ("Rear system, to easement"). Detention joins to the system(s) the council restricts. Numbering: question 5.
5. **Ruling or gap:** question 5; the rest is a gap.
6. **How serious:** stops a job (unit sites, soakage jobs with several soak pits, K-008).

**B11. Charged lines and suspended pipes that do not fall the ordinary way.**
1. **Story:** a charged line from DP2 to WT1; a suspended 150 line under the slab of the upper unit.
2. **Today's design:** charged and suspended kinds exist with their layers (DESIGN_PIPE_TOOL 2.1). Their cover is "Cannot check yet" (DRAFTS_pipe 11.5). Their ends must be pits or points, so a downpipe or tank end is a "point", and the line counts as loose.
3. **Drafter expects:** a charged line is finished when it reaches the tank, with no fall or cover nagging; the office wording "100 DIA. UPVC PIPE CHARGED TO WATER TANK" on its label.
4. **Proposal:** Rule 1 (downpipe and tank are proper ends). A charged line has no grade or cover sums; its only check is that the tank inlet is below the lowest downpipe head (UNKNOWN office figure, ask later). Label wording per kind is a data line (DRAFTS_pipe 8 is still open).
5. **Ruling or gap:** gap; label wording is already an open item.
6. **How serious:** stops a job (D-038 asked exactly this).

**B12. An existing pipe to be kept, or removed.**
1. **Story:** the site has an old line to the kerb that is removed, and you connect into the existing council pit.
2. **Today's design:** no existing kind. Existing drains are hand-drawn on EX layers (E-005, E-065). The schedule has an "ExP" row for the council pit (D-110).
3. **Drafter expects:** the council pit to be the outlet; old lines left as drawn.
4. **Proposal:** question 14.
5. **Ruling or gap:** question 14.
6. **How serious:** annoying every day (the council pit), rare (removal).

**B13. Where you click on the pit wall.**
1. **Story:** you click the right-hand wall of P3 near its top corner to start a pipe.
2. **Today's design:** D-034 says the pipe comes "EXACTLY ON THE PIT WALL IN LINE WITH WHERE THEY CLICKED". The Pipe tool finds the wall point from "the centre-to-centre line" (DESIGN_PIPE_TOOL 2.4). These disagree.
3. **Drafter expects:** the pipe to start where clicked.
4. **Proposal:** follow D-034: the click point sets where on the wall the pipe meets, kept in the pit's own frame so it follows moves and turns. With running OSNAP on, a snap to the block's corner or centre is read as "this pit", never as the exact point.
5. **Ruling or gap:** gap (the build differs from a ruling).
6. **How serious:** wrong sheet (looks wrong at every pit).

### C. Plain AutoCAD edits

**C1. MOVE one pit.**
1. **Story:** you nudge P3 600 mm to clear a path.
2. **Today's design:** pipe ends follow at the end of the command, only when following is switched on (CEHOOKS; PERFORMANCE 2.6 "starts only when a CE tool is first used in that drawing"). Tag and cover text stay behind (DRAFTS_pit 4). Pipe lengths change, so the levels below may move; with no window, nothing says so.
3. **Drafter expects:** pit, tag, text and pipe ends all move; any level change is said.
4. **Proposal:** Rules 6, 15 and question 7. After the move, one command-line line: "P3 moved: 2 pipe ends followed; P4 to P3 is now 9.20 m; levels below changed by up to 0.01." A cover level that came from the survey and has moved more than a set distance (office figure, say 1 m) shows "check: pit moved 3.2 m since this level was set".
5. **Ruling or gap:** question 7; the rest is a gap.
6. **How serious:** annoying every day; wrong sheet when the cover level is stale.

**C2. MOVE a whole run.**
1. **Story:** the architect shifts the house 1 m; you window the whole system and move it.
2. **Today's design:** the mover moves joined ends "that were sitting at the old spot". Everything moved together should be fine. Not tested with labels.
3. **Drafter expects:** nothing to break.
4. **Proposal:** keep. Make sure an end already at the new spot is treated as fine, never reported. Survey-based cover levels all get the "moved since" note in one line, not 12.
5. **Ruling or gap:** gap (a test case).
6. **How serious:** wrong sheet if levels stay stale.

**C3. COPY a pit and its pipes to the mirror unit.**
1. **Story:** a two-unit job, units mirror images; you copy unit 1's three pits and pipes to unit 2.
2. **Today's design:** joins re-point correctly within the copied set (trial 1). Each copy becomes "not yet named (copy of P3)" (DESIGN_ACAD 3). Held cover levels and inverts come across unchanged.
3. **Drafter expects:** new numbers, and the levels flagged for checking.
4. **Proposal:** question 3, Rules 4 and 5.
5. **Ruling or gap:** question 3.
6. **How serious:** wrong sheet; annoying every day (renumbering).

**C4. MIRROR.**
1. **Story:** you mirror unit 1's system instead of copying it.
2. **Today's design:** joins held through MIRROR (trial 1). Label side, "Turned" and text reading direction after a mirror: not tested. The pit block mirrored has a negative scale; the self-check may read it as "changed".
3. **Drafter expects:** labels readable, on the sensible side; new numbers.
4. **Proposal:** treat it as C3. Labels that would read upside down are turned to read; the pit's mirrored block is not a fault.
5. **Ruling or gap:** gap (test).
6. **How serious:** annoying every day on unit jobs.

**C5. ROTATE the whole site.**
1. **Story:** you rotate everything 90 degrees to fit the sheet better.
2. **Today's design:** trial 1 held joins through ROTATE; labels "read left to right" is measured against nothing stated (CONCEPT_GAP_CHECK H6). Today the office rotates nothing (rotation 0 xref, SHEET_SETUP s8).
3. **Drafter expects:** labels stay readable.
4. **Proposal:** labels that end up upside down turn to read; "square to the sheet" pits stay square to the sheet.
5. **Ruling or gap:** gap.
6. **How serious:** rare.

**C6. STRETCH.**
1. **Story:** a crossing window round P3 and the ends of its two pipes, stretched 500 to the left.
2. **Today's design:** the pit and the pipe ends both move. The mover moves only ends still at the old spot, and an end "not at the old spot is never dragged back; it is reported" (DESIGN_ACAD 5). So a correct STRETCH could be reported as a broken join. Off-screen, STRETCH moved nothing (trial 1).
3. **Drafter expects:** it works like moving the pit.
4. **Proposal:** an end that is already on the moved pit's wall is fine. A STRETCH that pulls only a pipe end off its pit unjoins it (Rule 2). One that brings an end onto another pit joins it.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day (the office's wrapped STRETCH ran 112 times in the records).

**C7. SCALE.**
1. **Story:** someone scales a pit block by 2, or scales the whole drawing by 1000.
2. **Today's design:** UNKNOWN (CONCEPT_GAP_CHECK H3). The block shows 900 while the fact says 450.
3. **Drafter expects:** to be told.
4. **Proposal:** the self-check says "P3 is drawn at twice its size; its size is 450 x 450: Put back". A whole-drawing scale is reported once, not 40 times. Never a quiet fix.
5. **Ruling or gap:** gap.
6. **How serious:** rare; wrong sheet when it happens.

**C8. ERASE a pit in the middle of a run.**
1. **Story:** you erase P3 between P4 and P2.
2. **Today's design:** the pipes are reported, the ends stay (DESIGN_PIPE_TOOL 3.3). The schedule loses the row; numbering leaves a gap.
3. **Drafter expects:** the two pipes left loose, quietly; maybe the option to make them one pipe.
4. **Proposal:** the two pipes become "not joined yet", grey (the loose rule). One line: "P3 erased: 2 pipes now not joined; schedule row removed." Renumber is offered, never run.
5. **Ruling or gap:** gap (wording).
6. **How serious:** annoying every day.

**C9. ERASE, then UNDO.**
1. **Story:** you erase P3 by mistake and press U.
2. **Today's design:** one U brought everything back in trial 1 route 1.
3. **Drafter expects:** pit, labels, joins and schedule row all back.
4. **Proposal:** Rule 14: the schedule and labels are views, rebuilt from the facts, so they come back too.
5. **Ruling or gap:** gap (test the schedule).
6. **How serious:** wrong sheet if the row does not come back.

**C10. EXPLODE.**
1. **Story:** someone explodes a pit block to edit it, or explodes a pipe.
2. **Today's design:** an exploded pit leaves loose lines, every join reported erased (trial 1). Whether a typed EXPLODE keeps the pipe's note is NOT KNOWN (EXPLODE_GAP). An exploded wide polyline loses its width, so the dashed band disappears.
3. **Drafter expects:** to be warned that it has left the design.
4. **Proposal:** the self-check says "P3 was exploded: it is still drawn but is no longer in the design or the schedule". One click takes it up again as a pit only if its lines can be recognised; otherwise erase and place again.
5. **Ruling or gap:** gap (EXPLODE_GAP supervised check first).
6. **How serious:** wrong sheet (a pit on the plan missing from the schedule).

**C11. MATCHPROP, or a layer or colour changed by hand.**
1. **Story:** you MATCHPROP the detention pipe's layer onto an ordinary pipe, or force a colour on one pipe.
2. **Today's design:** the kind lives in the note; the layer follows the kind. A hand change makes them disagree, and nothing says which wins (CONCEPT_GAP_CHECK H13, H14). The office forces colours per object on some jobs (SHEET_SETUP s8.14).
3. **Drafter expects:** if you put a pipe on the detention layer, you probably meant it to be detention.
4. **Proposal:** never undo your change. The pipe shows amber: "P4 to P3 is on the detention layer but is an ordinary pipe: Make it detention / Put the layer back". A forced colour on its own is left alone and not reported.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet (storage counted or missed).

**C12. Editing the label text by hand.**
1. **Story:** you retype a pipe label to add "MIN.".
2. **Today's design:** D-014 keeps a moved label's position. Wording "changes in place" on an edit (DESIGN_PIT_TOOL 3.5), so your typed words would be overwritten next time the pipe changes.
3. **Drafter expects:** the words kept, and a warning if they go stale.
4. **Proposal:** question 8 and Rule 7.
5. **Ruling or gap:** question 8.
6. **How serious:** wrong sheet.

**C13. Freezing or locking a layer.**
1. **Story:** 25TEXT is frozen while you work; a pipe's layer is locked.
2. **Today's design:** UNKNOWN. The project's native-protection rule says never silently unlock.
3. **Drafter expects:** the plug-in never fights a lock.
4. **Proposal:** Rule 17. A label on a frozen layer is still updated (it is not locked). A pipe end on a locked layer is not moved; one line says "P4 to P3 is on a locked layer: its end was not moved", and it goes in Unfinished.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**C14. WBLOCK, or copy and paste into another drawing.**
1. **Story:** you copy unit 1's system from job A and paste it into job B, a similar unit job.
2. **Today's design:** joins survive for a whole set; a pipe pasted alone can drag its pit across as an orphan (trial 1, hard pointer). The drawing key tells a paste apart (DESIGN_ACAD 3). Where job facts live is open (Q-204). Pasted cover levels belong to another site.
3. **Drafter expects:** to reuse the layout, not the levels or the other job's council.
4. **Proposal:** Rules 4 and 5. Pasted things take new numbers; place-bound figures become "assumed: from another drawing"; the other drawing's job facts never come across.
5. **Ruling or gap:** gap (and Q-204 must keep job facts out of objects that get pasted).
6. **How serious:** wrong sheet.

**C15. PURGE, AUDIT, RECOVER.**
1. **Story:** the office CLEAN helper runs; a drawing is recovered after a crash.
2. **Today's design:** notes survived PURGE of registered apps and AUDIT (trial 1). RECOVER not tested. CLEAN forces text styles.
3. **Drafter expects:** nothing lost.
4. **Proposal:** after RECOVER, the self-check runs and lists anything half-made (a label with no pit, a pipe with a lost record). Text styles changed by CLEAN are left alone.
5. **Ruling or gap:** gap (test RECOVER).
6. **How serious:** rare.

**C16. Saving back to an older DWG version.**
1. **Story:** an architect asks for a 2013 file.
2. **Today's design:** notes, records and joins survived 2013 and 2000 formats (trial 1).
3. **Drafter expects:** fine.
4. **Proposal:** keep; nothing to add.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**C17. Someone with no plug-in edits the sheet and sends it back.**
1. **Story:** a colleague on AutoCAD 2026 (no plug-in, D-008) moves two pits, retypes a level and adds a pipe by hand.
2. **Today's design:** the position stamp says what moved; the join check says what no longer meets (trial 3). Retyped text: covered by stamps only in part. A hand-drawn pipe is invisible to the design.
3. **Drafter expects:** a short list of what changed, and the new pipe picked up.
4. **Proposal:** on open, one list: "Changed outside the plug-in: P3 and P4 moved (pipe ends no longer meet: Bring them back); P2 cover text retyped to CL 5.80 (pit says 5.75: Use 5.80 / Put back); 1 plain pipe on a stormwater layer (Take it up)." Question 16 for the last.
5. **Ruling or gap:** question 16; the rest is a gap.
6. **How serious:** wrong sheet.

### D. Numbering and names

**D1. Renumber from the outlet.**
1. **Story:** after laying out, you press Renumber.
2. **Today's design:** D-075. The bench schedule shows a "P0" row at the outlet and "P0 to P11 outlet first" (bench_schedule_1080_dark), which does not match "P1 at the outlet".
3. **Drafter expects:** P1 at the outlet, upward in order.
4. **Proposal:** P1 at the outlet; the bench's P0 is corrected. Renumber is one undo step and lists what changed ("P13 became P4; 8 others moved up").
5. **Ruling or gap:** gap (bench mismatch).
6. **How serious:** wrong sheet.

**D2. Inserting a pit mid-run; deleting one.**
1. **Story:** a pit added between P3 and P4; later P6 is deleted.
2. **Today's design:** next free number; duplicates refused (DRAFTS_pit 5).
3. **Drafter expects:** UNKNOWN office practice.
4. **Proposal:** question 6; B9 (lowest free number).
5. **Ruling or gap:** question 6.
6. **How serious:** annoying every day.

**D3. Hand notes that name a pit.**
1. **Story:** a plain note on the sheet says "CONNECT AG DRAIN TO P3"; then Renumber runs.
2. **Today's design:** UNKNOWN; the note is plain text and does not follow.
3. **Drafter expects:** to be warned.
4. **Proposal:** after Renumber, one line: "3 notes on the sheet mention old numbers (P3, P5): Show them." Never edits them.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet.

**D4. Pipe names after a renumber.**
1. **Story:** P4 becomes P5.
2. **Today's design:** "An edit renames the pipe if a pit was renumbered; the pit name kept inside a join (for words only) is not updated" (DRAFTS_pipe 7). So messages could name the old pit.
3. **Drafter expects:** all words to use the new numbers.
4. **Proposal:** names in messages are always read from the pit itself, never from a copy kept in the join.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**D5. Duplicate numbers.**
1. **Story:** a tag retyped by hand, or a paste, makes two P1s (a real schedule once had two P1 rows, E-012).
2. **Today's design:** the window refuses a duplicate; the long section tool refuses "two things with one name" and opens nothing (DRAFTS_levels 21).
3. **Drafter expects:** to be told, not stopped.
4. **Proposal:** never refuse: both show amber "two pits called P1", the schedule shows both, and the long section opens with the duplicate named.
5. **Ruling or gap:** gap (no-blocks rule); question 9 for tags.
6. **How serious:** annoying; stops a job when the long section refuses.

**D6. Downpipe numbers.**
1. **Story:** the sheet shows every downpipe as "DP" with no number (E-015), but the plug-in needs to tell them apart.
2. **Today's design:** the Inlet window has a Number box and a "Number shown" tick.
3. **Drafter expects:** the sheet to look as it does today.
4. **Proposal:** every thing has an internal number (DP1, DP2) whether it prints or not; printing is a tick, off by default for downpipes.
5. **Ruling or gap:** gap (default to match today).
6. **How serious:** annoying.

### E. The job changes

**E1. The architect moves the house or changes the roof.**
1. **Story:** a revised background arrives; downpipes and the roof outline moved.
2. **Today's design:** the job drawing does not change when the background is swapped, so nothing triggers a check (CONCEPT_GAP_CHECK G4). A roof area read from a linked outline updates (D-107) only if the outline is in the job drawing.
3. **Drafter expects:** to know what moved, and every area figure to stay honest.
4. **Proposal:** a measured area keeps the figure it last read. On open, any measured figure whose source outline changed is said once, old to new: "Site area 600.00 became 612.40 (background boundary changed): Use new / Keep 600.00." Downpipes are not moved; the plug-in cannot know where the architect's new ones are.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet (storage moves silently between issues).

**E2. The council moves the discharge point.**
1. **Story:** the letter says connect at the side street, not the front.
2. **Today's design:** UNKNOWN. With direction taken from the click order, the whole network reads backwards.
3. **Drafter expects:** to redraw the last length and have the rest sort itself out.
4. **Proposal:** Rule 3: move or replace the outlet; directions, inverts and arrows are worked out again from the new outlet; Renumber is offered (question 6 after issue). "What else changes" lists it.
5. **Ruling or gap:** gap.
6. **How serious:** stops a job without it.

**E3. The council changes the permitted discharge.**
1. **Story:** 6.00 l/s becomes 4.50 l/s.
2. **Today's design:** the orifice is worked out (D-173), so it changes by itself.
3. **Drafter expects:** the new orifice and its effect shown.
4. **Proposal:** keep; "What else changes": "Orifice 69 becomes 59 mm; storage needed 1.64 becomes 2.10 m³; tank share becomes 1.40." The criteria box follows.
5. **Ruling or gap:** none beyond Rule 14.
6. **How serious:** fine if Rule 14 holds.

**E4. Levels arrive after the layout is drawn.**
1. **Story:** the survey comes in two days after you drew the pits.
2. **Today's design:** cover levels are typed in each Pit window or the long section window. There is no way to fill many at once.
3. **Drafter expects:** to click through the pits quickly.
4. **Proposal:** a "Cover levels" pass: the long section window (or a pick-in-turn prompt) takes each pit's level, offering the nearest level text (A5). Pit sizes then settle (A2) and "What else changes" lists them.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day.

**E5. An assumed connection invert turns out 300 lower.**
1. **Story:** the letter gives 4.65, not the 4.95 you assumed.
2. **Today's design:** the held figure changes and worked-out figures follow on open. The long section tool rewrites labels only for pipes in its window; pit cover texts are "told about, never changed" (DRAFTS_levels 10).
3. **Drafter expects:** every level on the sheet updated in one go.
4. **Proposal:** Rule 14: one change updates every invert text, label, schedule row and the criteria box across the sheet, in one undo step, and says "14 texts changed".
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet.

**E6. The survey datum changes.**
1. **Story:** the survey moves from an assumed datum to AHD, so every level rises by 2.315.
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** one action, not 40 retyped levels.
4. **Proposal:** one job-level action, "Shift levels from the survey by +2.315", which moves survey-sourced figures only (cover levels, ground), never council-given ones, with a full "What else changes".
5. **Ruling or gap:** gap.
6. **How serious:** rare, but heavy when it happens.

**E7. A tank added or dropped.**
1. **Story:** the sustainability report drops WT2.
2. **Today's design:** downpipes joined to it lose their join (erased partner); storage recalculates.
3. **Drafter expects:** downpipes shown as needing a new destination.
4. **Proposal:** the downpipes become "not joined yet" (grey); storage and the tank note follow; the change list says so.
5. **Ruling or gap:** none beyond the loose rule.
6. **How serious:** fine.

**E8. Detention becomes required after the pipes are drawn.**
1. **Story:** the council letter arrives with 5 l/s on a house you drew as K-001.
2. **Today's design:** pipe kind can be changed one pipe at a time; the Detention window opens with "not known yet" figures.
3. **Drafter expects:** select three pipes, make them detention, open DET.
4. **Proposal:** Rule 16 (several at once). The orifice pit is suggested (INPUT_AUDIT item 15); pit sizes grow and pipe ends follow (see the ten, item 6).
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day.

**E9. The council asks for a long section.**
1. **Story:** the council sends it back asking for a long section of the outfall.
2. **Today's design:** nothing is drawn; a later separate command (DRAFTS_levels 16). Today about 300 loose lines and texts by hand (E-062).
3. **Drafter expects:** to draw it from the levels already designed.
4. **Proposal:** keep it later, but say it plainly in the tool's window ("A long section on the sheet is not drawn yet"). When built, it follows the run like the schedule follows the pits.
5. **Ruling or gap:** already open (DRAFTS_levels 16).
6. **How serious:** rare (2 of 30 jobs).

**E10. A second issue where only two pits changed.**
1. **Story:** Rev B; you need to cloud what changed.
2. **Today's design:** no issue tool in the first release (D-097). Nothing remembers what was issued.
3. **Drafter expects:** to know exactly what to cloud.
4. **Proposal:** question 11.
5. **Ruling or gap:** question 11.
6. **How serious:** wrong sheet (a change nobody clouded slips through).

**E11. A staged job.**
1. **Story:** a childcare centre built in stages, each stage on its own sheet (K-015).
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** stage 1 to work on its own, with stage 2 pipes shown as future.
4. **Proposal:** later. Note it so the outlet and system rules (B10) do not shut it out: a "future" pipe is a loose pipe that is meant to be loose.
5. **Ruling or gap:** gap, later release.
6. **How serious:** rare.

### F. Levels and unknowns

**F1. Half the cover levels known.**
1. **Story:** the survey covers the front half only.
2. **Today's design:** cover checks say "Cannot check yet" in amber (DESIGN.md 5.6).
3. **Drafter expects:** the known half worked, the rest quiet.
4. **Proposal:** Rule 13 (grey). The long section works what it can and shows the gaps as "not known yet" on the long section picture.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day.

**F2. How "assumed" shows on the sheet.**
1. **Story:** the connection and two cover levels are assumed at preliminary issue.
2. **Today's design:** no set way (D-030); the brain has the source word but no print rule.
3. **Drafter expects:** a council officer can tell an assumed figure from a real one.
4. **Proposal:** questions 1 and 2.
5. **Ruling or gap:** questions 1 and 2.
6. **How serious:** wrong sheet.

**F3. Going to issue with unknowns or assumptions still in.**
1. **Story:** the council wants the preliminary today and the letter is still not in.
2. **Today's design:** nothing blocks (D-140), but nothing reminds either.
3. **Drafter expects:** to issue, knowingly.
4. **Proposal:** question 12 and Rule 18.
5. **Ruling or gap:** question 12.
6. **How serious:** wrong sheet.

**F4. A run that cannot fall to the outlet.**
1. **Story:** the back pit is too deep and the connection too high: short by 0.22.
2. **Today's design:** the clash is named by stretch and amount (D-125). The long section tool writes NOTHING while held figures clash (DRAFTS_levels 11), so ten minutes of typing is lost on OK.
3. **Drafter expects:** to keep what was typed, see the problem, and see the ways out (raise covers, flatten grades, pump).
4. **Proposal:** Rule 12: OK saves what was typed; the clash stays red on the long section and in Unfinished. The "If it does not work" card lists the ways out (D-124: never applied by themselves), including "pumped system" (K-007).
5. **Ruling or gap:** gap (against D-124 and D-140).
6. **How serious:** stops a job (lost work every time).

**F5. Pit size when depth is not known.**
1. **Story:** pit size is worked out from depth (INPUT_AUDIT change 3), but the cover level is not known.
2. **Today's design:** the size would be unknown, yet the block must be drawn in some state.
3. **Drafter expects:** a pit on the plan.
4. **Proposal:** Rule 11: drawn at the last-used size, marked "assumed: depth not known yet", listed, and settled when levels arrive.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet if the assumed size is not marked.

**F6. Several standards could give way.**
1. **Story:** top, connection and all grades are held; only the drops can move.
2. **Today's design:** "the last one filled absorbs the whole difference" in the trial solver (trial 11 finding 4); the brain treats standards as held, so it shows a clash (DESIGN.md 1.4). That is right (D-124).
3. **Drafter expects:** told, not fixed.
4. **Proposal:** keep: a clash with the stretch and amount; the card suggests which drops could change.
5. **Ruling or gap:** none.
6. **How serious:** fine.

### G. Windows in use

**G1. Opening a window on something half-defined.**
1. **Story:** double-click a pipe with one free end.
2. **Today's design:** a free end shows no pit; figures unknown (DESIGN_PIPE_TOOL 1.3). Card 3 shows "no pipes joined yet" for a lone pit.
3. **Drafter expects:** the window to say quietly what is missing.
4. **Proposal:** keep; the system strip says "Loose run, not yet connected to an outlet" (D-176).
5. **Ruling or gap:** none.
6. **How serious:** fine.

**G2. Several things selected.**
1. **Story:** you select four pits and type PT, or select all pipes to change the material.
2. **Today's design:** "If exactly one pit is already selected ... that pit is edited." Several: UNKNOWN. The Properties palette, AutoCAD's own way to edit many, is not proven (trial 5).
3. **Drafter expects:** to change all four at once, as in Properties.
4. **Proposal:** Rule 16: one window, "4 pits", "Varies" where they differ; only changed boxes apply; one undo step.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day.

**G3. Match.**
1. **Story:** make P5 like P3.
2. **Today's design:** the Match button is not wired (DRAFTS_pipe 11.7).
3. **Drafter expects:** size, kind and lid copied; not the number or levels.
4. **Proposal:** Rule 16. Match copies choices only.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**G4. Cancel after a long edit.**
1. **Story:** five minutes in the Detention window, then a slip of the mouse on Cancel.
2. **Today's design:** Cancel draws nothing; what was typed is gone.
3. **Drafter expects:** a way back (UI rules: "Undo instead of 'Are you sure?'").
4. **Proposal:** Rule 12: the next open of the same thing offers "Open with what you typed at 10:42?" for the rest of the session.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**G5. Inspect, panning and zooming.**
1. **Story:** you press Inspect to check where the boundary is, and zoom around with the wheel.
2. **Today's design:** Inspect proven with a command-driven zoom only; mouse pan and zoom not tested (trial 6).
3. **Drafter expects:** normal wheel zoom and pan, then back.
4. **Proposal:** test with a person or Codex before the first tool is accepted.
5. **Ruling or gap:** gap (test).
6. **How serious:** annoying every day if it fails.

**G6. A held value that makes the run impossible.**
1. **Story:** you hold P4 invert 5.40 in the Pipe window, which the long section cannot meet.
2. **Today's design:** the Pipe window shows red and allows OK; the long section refuses to write (F4).
3. **Drafter expects:** the same behaviour in every window.
4. **Proposal:** one rule in every window: OK always saves; red stays.
5. **Ruling or gap:** gap (consistency).
6. **How serious:** annoying.

**G7. Second monitor or a laptop screen.**
1. **Story:** AutoCAD on the right-hand monitor; or a laptop at 150% scaling.
2. **Today's design:** 80% of "the screen", at 1920 x 1080 and 2560 x 1440 (D-065). Scaling and second monitors: not tested (trial 6).
3. **Drafter expects:** the window opens on AutoCAD's screen and fits.
4. **Proposal:** open on the screen AutoCAD is on; question 17 for the smallest size.
5. **Ruling or gap:** question 17.
6. **How serious:** stops a job on a small laptop.

**G8. A command typed in a drawing with no CE objects.**
1. **Story:** you type DET in a fresh drawing.
2. **Today's design:** the Job window "opens by itself the first time a tool needs a job fact that is unknown" (INPUT_AUDIT 3). Nothing else says what happens.
3. **Drafter expects:** a calm window with "not known yet", not an error.
4. **Proposal:** keep; every tool works in an empty drawing and says what it is waiting for.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**G9. Something already selected (AutoCAD's noun-then-verb way).**
1. **Story:** a pipe is selected and you type PT.
2. **Today's design:** PT with one pit selected edits it; with a pipe selected: UNKNOWN.
3. **Drafter expects:** probably "put a pit on this pipe".
4. **Proposal:** PT with one pipe selected places a pit on that pipe at the point you pick (D-077 split). Anything else selected is ignored, with one line saying so.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**G10. Repeating the last command with Enter or space.**
1. **Story:** 24 downpipes on a two-unit job.
2. **Today's design:** the window opens every time (D-060).
3. **Drafter expects:** to keep clicking.
4. **Proposal:** question 10.
5. **Ruling or gap:** question 10.
6. **How serious:** annoying every day.

**G11. Escape mid-pick.**
1. **Story:** you pick P4 for a new pipe, then press Escape.
2. **Today's design:** nothing drawn.
3. **Drafter expects:** the same.
4. **Proposal:** keep.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**G12. Right-click menus.**
1. **Story:** a drafter expects a right-click "Flip label" option.
2. **Today's design:** nothing may depend on a hidden right-click (D-049 item 5); custom grips crashed (trial 2).
3. **Drafter expects:** right-click to stay AutoCAD's.
4. **Proposal:** leave right-click as AutoCAD's; every action is visible in the window or the light tab.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**G13. OSNAP, ORTHO and transparent zoom while placing.**
1. **Story:** running snaps on, ORTHO on, 'Z mid-pick.
2. **Today's design:** UNKNOWN beyond B13.
3. **Drafter expects:** AutoCAD's normal behaviour.
4. **Proposal:** prompts accept snaps, ORTHO, polar and transparent zoom as normal; picking a pit by snapping to it reads "this pit" (B13). Test each.
5. **Ruling or gap:** gap (test).
6. **How serious:** annoying every day if broken.

### H. Sheets and output

**H1. Model space against layouts; scale.**
1. **Story:** a big site that will not fit A1 at 1:100.
2. **Today's design:** everything in model space at 1:100; nothing annotative; one locked viewport per layout (SHEET_SETUP s1.3, s4, s7). D-169 dropped the schedule scale choice.
3. **Drafter expects:** text that prints the right size.
4. **Proposal:** question 18.
5. **Ruling or gap:** question 18.
6. **How serious:** rare.

**H2. SH typed while in a layout.**
1. **Story:** you are in layout C01 and type SH to place the schedule.
2. **Today's design:** the office puts the schedule in model space; heights are model heights (250 at 1:100). Placing in paper space: UNKNOWN.
3. **Drafter expects:** it goes where you click, at the right printed size.
4. **Proposal:** placed in the space you click in; heights follow that space (2.5 mm in paper space).
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet (text 100 times too big).

**H3. "Not joined yet" grey and plotting.**
1. **Story:** you plot while a pipe is still loose.
2. **Today's design:** D-176 says loose shows "quietly as 'not joined yet' in grey"; it does not say where. Grey written into the drawing would plot grey.
3. **Drafter expects:** the sheet to plot normally.
4. **Proposal:** Rule 8.
5. **Ruling or gap:** gap.
6. **How serious:** wrong sheet.

**H4. A sheet copied to make an as-built.**
1. **Story:** SAVEAS to an as-built drawing; levels are changed to as-constructed values.
2. **Today's design:** UNKNOWN (Q-010). Two files may share the same drawing key.
3. **Drafter expects:** levels editable, marked as-built.
4. **Proposal:** later; the source word for an as-built figure is "given" (by the surveyor). Mark it in the plan as a later item.
5. **Ruling or gap:** gap, later (Q-010 is Tim's).
6. **How serious:** rare.

**H5. Xref'd into the architect's or a colleague's drawing.**
1. **Story:** the architect attaches your drainage drawing to theirs; a colleague attaches it to a structural sheet.
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** it shows like any xref and nothing in their drawing is touched.
4. **Proposal:** Rule 10: CE things inside an xref or a block are never counted, joined or changed in the host drawing.
5. **Ruling or gap:** gap.
6. **How serious:** rare.

**H6. Plotting the sheet.**
1. **Story:** plot C01 to PDF with the office pen table.
2. **Today's design:** looks and plots identical with or without the plug-in (trial 3). Pen width of the new layers is not known (DRAFTS_pipe 12).
3. **Drafter expects:** the same pen weights as today.
4. **Proposal:** keep; question 12 for the reminder.
5. **Ruling or gap:** open items already listed.
6. **How serious:** fine.

### I. More than one person, more than one PC

**I1. A colleague without the plug-in opens it.**
1. **Story:** a colleague on AutoCAD 2022 (no plug-in, D-008).
2. **Today's design:** plain objects; plots identical; edits reported on return (trial 3).
3. **Drafter expects:** it just works.
4. **Proposal:** C17.
5. **Ruling or gap:** none.
6. **How serious:** fine.

**I2. A colleague with an older version of the new plug-in.**
1. **Story:** your PC has 1.3; theirs still 1.2 and does not know a new fact.
2. **Today's design:** "A kind or fact the brain's lists do not have is refused" (DESIGN_ACAD 1).
3. **Drafter expects:** to work on it, and be told to update for the new parts.
4. **Proposal:** Rule 10: read what it knows, keep the rest untouched, and say "made with 1.3: update to change the 2 newer figures".
5. **Ruling or gap:** gap.
6. **How serious:** stops a job (refused drawing).

**I3. The office standards list differs between PCs, or the plug-in updates mid-job.**
1. **Story:** one PC still has last month's list.
2. **Today's design:** worked-out figures are never stored (DESIGN_PIT_TOOL 3.4), so they are worked out again from the local list.
3. **Drafter expects:** the drawing to read the same on every PC.
4. **Proposal:** question 4 and Rule 9.
5. **Ruling or gap:** question 4.
6. **How serious:** wrong sheet.

**I4. The old plug-in and the new one on the same PC.**
1. **Story:** during the change-over a PC has both; CD is the old pipe command and the new one (D-057).
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** typing CD to do one clear thing.
4. **Proposal:** on load, the new plug-in checks for the old one and says plainly which one owns CD; the install plan makes sure only one is loaded.
5. **Ruling or gap:** gap.
6. **How serious:** stops a job.

**I5. Two people in the same file, one after the other; OneDrive conflict copies.**
1. **Story:** two people edit copies; OneDrive makes a conflict copy (seen today, SHEET_SETUP s8.17).
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** no merge magic, but no silent loss.
4. **Proposal:** no merge. The self-check works on each file on its own. Nothing more in the first release.
5. **Ruling or gap:** none (said, not built).
6. **How serious:** rare.

### J. Mistakes and recovery

**J1. The wrong council picked at the start.**
1. **Story:** you picked Kingston; the site is in Glen Eira.
2. **Today's design:** standards follow the council (D-022), so changing it refills figures.
3. **Drafter expects:** to change it once and see what moved.
4. **Proposal:** "What else changes": "Cover needed under driveways 0.45 stays; minimum orifice 65 becomes none on file; method stays Boyd's." Typed-over figures are kept.
5. **Ruling or gap:** none beyond Rule 14.
6. **How serious:** fine if shown.

**J2. Pipe material changed on all pipes at once.**
1. **Story:** the builder wants PVC-U changed to HDPE everywhere.
2. **Today's design:** one pipe at a time.
3. **Drafter expects:** select all, change once.
4. **Proposal:** G2.
5. **Ruling or gap:** gap.
6. **How serious:** annoying.

**J3. Undoing a window's OK.**
1. **Story:** OK on the Pit window, then U.
2. **Today's design:** one undo step, proven only by a real typed U (DESIGN_PIT_TOOL 1.6).
3. **Drafter expects:** everything back.
4. **Proposal:** test with a real U before acceptance.
5. **Ruling or gap:** gap (test).
6. **How serious:** wrong sheet if half undone.

**J4. A crash mid-command.**
1. **Story:** AutoCAD dies while the OK plan is being applied.
2. **Today's design:** a half-drawn pit is put back if a step throws (DESIGN_PIT_TOOL 4.6), but a crash leaves whatever autosave caught. The records show 842 starts after unclean closes (CONCEPT_GAP_CHECK H18).
3. **Drafter expects:** the recovered drawing to say what is half-made.
4. **Proposal:** C15: self-check on open of a recovered or autosave file.
5. **Ruling or gap:** gap.
6. **How serious:** rare.

**J5. A corrupted hidden note.**
1. **Story:** a note cannot be read.
2. **Today's design:** UNKNOWN.
3. **Drafter expects:** not to lose the pit.
4. **Proposal:** Rule 10: treat it as a plain object, say "P3's note could not be read: it is drawn but not in the design", offer "Take it up again"; never delete.
5. **Ruling or gap:** gap.
6. **How serious:** rare.

**J6. "It used to follow and now it doesn't."**
1. **Story:** Monday morning, you open the drawing and MOVE P3 before typing any CE command. The pipes stay behind.
2. **Today's design:** following starts only when a CE tool is first used in that drawing (PERFORMANCE 2.6) or with CEHOOKS (DESIGN_ACAD 5). The self-check says the end no longer meets, and repairs nothing.
3. **Drafter expects:** it always follows.
4. **Proposal:** Rule 15. Trial 4 measured following at about 8 ms per move on 2,500 objects, so being on from open costs almost nothing.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day; trust-breaking.

### K. Speed and scale of a real drawing

**K1. A 40-pit unit development.**
1. **Story:** a ten-unit site with 40 pits and 60 downpipes.
2. **Today's design:** the long section tool takes 3 to 5 pits; the schedule runs long and you make room (D-114). Largest recorded jobs are 12 and 13 pits (E-008). The brain solves 200 pits in milliseconds (trial 11).
3. **Drafter expects:** every tool to cope.
4. **Proposal:** long section rows repeat for any length (DRAFTS_levels 4, recommended next); every list scales; night tests use a made-up 40-pit job.
5. **Ruling or gap:** gap.
6. **How serious:** stops a job on big sites.

**K2. An xref-heavy architect file.**
1. **Story:** the background holds 300 layers and three stacked plans.
2. **Today's design:** the "where on the plan" locator in every preview (D-167) draws the site; how it is produced is not proven.
3. **Drafter expects:** windows still open in 0.3 s (PERFORMANCE 2.3).
4. **Proposal:** draw the locator once when the window opens, not on every keystroke; scans read only this drawing's own objects, never inside xrefs.
5. **Ruling or gap:** gap.
6. **How serious:** annoying every day if slow.

**K3. Many layouts.**
1. **Story:** six sheets (plan, details, computations, basement plan).
2. **Today's design:** the plug-in works in model space; nothing reads layouts.
3. **Drafter expects:** no slow-down.
4. **Proposal:** keep; the plot reminder (question 12) counts once per plot, not per layout.
5. **Ruling or gap:** none.
6. **How serious:** fine.

---

## Where the documents disagree (found during this walk)

1. **Joining later.** D-176 (approved): a loose end joins when brought to a pit. DRAFTS_pipe_tool 11.2: "A free end cannot be joined to a pit later; draw it again."
2. **Where on the wall.** D-034: in line with where clicked. DESIGN_PIPE_TOOL 2.4: the centre-to-centre line.
3. **Unknown is quiet.** D-176: grey. DESIGN.md 5.6: amber "Needs a look: Cannot check yet".
4. **Never blocks.** D-124 and D-140: never blocks. DRAFTS_levels 11: OK writes nothing while a clash stands; DRAFTS_levels 3 and 21: runs with a branch or a duplicate name open nothing.
5. **P1 at the outlet.** D-075. The bench schedule shows "P0 to P11 outlet first".
6. **Next free number.** D-075: next free. DRAFTS_pit 5: one more than the highest (an erased number is never reused).
7. **Copies.** D-075: a new pit takes the next free number. DESIGN_ACAD 3: a copy is "not yet named".
8. **Following.** D-176 and the trials assume following works; PERFORMANCE 2.6 starts it only on the first CE tool use in that drawing.
9. **Colour scheme.** UI_PLAN section 5 still says one accent blue and "dark all through or light all through"; D-166 and D-168 replaced that with one grey scheme and a rose accent (the added section at the end of UI_PLAN says so, but section 5 was not marked superseded). The bench screenshots still show the blue accent.

## What this walk did NOT do

1. Nothing was run in AutoCAD; every "not tested" above comes from TRIAL_RESULTS or the acad pages.
2. TOOLS_TODAY, ELEMENTS, JOB_KINDS, SUMS and LIMITS were searched, not read end to end.
3. The office facts used here (mm, 1:100, model space, nothing annotative, revision rows, existing drains, charged lines) come from the measured reference. They are not yet confirmed by Tim (reference README).
4. Where the reference says nothing, the item is marked UNKNOWN and asked, never filled.

## Tim's answers, 18 Nov 2026 (rulings D-177 to D-195 in `DECISIONS.md`; his words are there)

1. Assumed prints "APPROX." in front, with one standing note (D-177).
2. Not known prints "TBC" (D-178). Cover levels are the engineer's, from house and pavement levels, never the survey (D-178); help with them is only ever a suggestion, the engineer has the final say (D-195).
3. Mirror or copied units: sizes and grades copy; levels copy marked assumed; next free numbers (D-179).
4. The drawing keeps the standard values it was designed with; a line on opening offers to switch (D-180).
5. Tags and level texts go with a moved pit; a hand-moved label keeps its offset from the pit in both directions (D-181).
6. A typed-over pipe label is kept, flagged, one click to follow again (D-182).
7. Two systems: one number series, street system first (D-183).
8. A pit added after issue: the drafter chooses among next free number, a letter, or renumber all (D-184).
9. Retyping a pit tag renames the pit (D-185).
10. Placing many: keep clicking, Enter to finish (D-186).
11. "Changed since last issue": yes, but later (D-187).
12. Plotting with open items: one quiet line, never a stop (D-188).
13. Bends on every kind of pipe (D-189).
14. Existing: the council pit or outlet you connect to is a proper outlet; other existing drains by hand (D-190).
15. New jobs start from the office template (D-191).
16. A hand-drawn line on a stormwater layer: one line on opening with a "take it up" click (D-192).
17. Some laptops are used for drafting: small screens put cards into tabs (D-193).
18. Plans are drawn 1:1 in the model; the layout scales them to 1:100 (D-194).
The 18 general rules above ("Rules this adds to the foundation") have NOT been put to Tim one by one; where one goes further than his answers it is still a proposal.
