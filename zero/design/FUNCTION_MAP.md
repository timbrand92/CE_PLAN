# Function map (revision 1)

**Written:** Wed 18 Nov 2026 (Melbourne time) by a read-only helper for the planning chat 'CE_ACAD / zero plan / 01'. **Status: DRAFT for Tim. Nothing here is a decision.** Nothing was built, run, installed or committed, AutoCAD was not started, and no git repository was changed. Promised in D-213 ('yes, write both'); the obstacle course is the other half.
**IDs in this file:** FM-001 onward, one per line of the map, never reused or renumbered; a later revision adds new numbers at the end. T- numbers are `reference\today\TOOLS_TODAY.md`; D- numbers are `DECISIONS.md`; ST-, MG-, TA- are the tools interview files.

**What was read for 'what exists today' (all read-only):**
1. **Civil 3.0.90.15** at commit 2c8b7b1a, **Structural 1.0.126.1** at d4edbc19, **Manager 1.1.89** at cf059dcf, all in `C:\Lisp Files\CE_ACAD_PLUGIN`. All three commits exist (checked with `git cat-file -t`), so the newest `rel-*` branch was not needed. Every `[CommandMethod]` was read with `git grep` at its commit, inside that module's own folder only (tests and other modules left out), then joined to that module's command-registry file for the plain description and the ribbon flag.
2. **Ribbon flag:** a command not marked hidden in its registry is on a ribbon; hidden means typed only. I checked this against the Civil ribbon code: the 'classic' layout has 56 buttons and the other layout carries the ten visible commands the classic one lacks, so every visible command is on one of the two. The Manager's CE Tools ribbon (read from its code) also carries MR, CR and CEBLOCKS. What a drafter sees on screen was not checked.
3. **Loose LISP:** every `defun c:` in the shared drafting folder `Lisp Files`, its `UPDATED LISP FILES` and `<owner> EXPORT` sub-folders and the personal sub-folder (superseded and saved folders left out): 183 typed names. Which copy a colleague's PC loads is still Unknown (TOOLS_TODAY, 'The three generations', item 4).
4. **Also read:** TOOLS_TODAY (T-001 to T-056), Tim's alias list, the parts-bin report, THE_PLAN, DECISIONS, the two tools-interview files, NAMING_DRAFT, SITUATIONS, FOUNDATION, UI_PLAN and R-007.
5. **'Uses':** runs recorded 20 Apr to 16 Nov 2026 on two PCs, from TOOLS_TODAY T-055. Only commands the plug-ins wrap are recorded, nearly all in April. 'None in the records' means no recorded run; it is weak evidence and never proves a command unused. Loose LISP and palette drags are not recorded at all, so for them it says 'not recorded'.
6. **How I used the SITUATIONS file:** it is a draft ('Nothing here is decided'). I used one of its rules for a (b) line only where FOUNDATION, THE_PLAN or one of Tim's rulings says the same thing; where only the draft says it, the line is (e).
7. **One line per command, with one exception:** where many near-identical names do one family job (the hatch names, the 21 pen quick-sets, the structural text tags and the other structural families) one line lists every name. Every typed name appears in exactly one line; a line says which module(s) hold it.

## 1. The short answer for Tim

1. **What exists today:** 648 typed names. That is 146 in Civil, 403 in Structural and 12 in the Manager (5 shared between them, so 556 different), 77 more that live only in loose LISP files, 4 in leftover test bundles and 11 that Tim's alias file points at. The map has 184 lines (it also lists the palettes, the ribbon, the settings store and the usage records, which are not typed names).
2. **Goes to a new tool (a):** 121 names on 41 lines. Includes the first-release tools, the shared tools of D-201 and D-209, and the small Manager. 8 of these lines carry a 'not covered' note: the new tool does not do the whole old job (section 4).
3. **Folded in (b):** 83 names on 33 lines: no longer their own command because the new design does the job another way (repair commands, edit-by-double-click, label grips, the checks).
4. **Parked (c):** 306 names on 53 lines, almost all structural-only, plus the imports, survey and old-drawing take-up.
5. **Proposed to retire (d):** 71 names on 20 lines, for Tim to tick or refuse in section 3. 3 of those names are already ruled by Tim (the one-piece pipe object and C).
6. **NOT DECIDED (e):** 67 names on 37 lines. These are the ones that could be lost: section 2, most-used first. The biggest are Open logs (9 runs), PITDELETE (8), the legal point of discharge (5), the fall symbol (4), and the site and inlet tools with no home (trench grate, agricultural and perimeter drains, strip drain, spoon drain, kerb, slab design, raingarden).
7. **Biggest single gap:** the computations sheet. No first-release tool prints it, and CDCALC is the only thing that makes it today (section 4, item 2). Until it exists the old plug-in has to stay installed side by side.
8. **Caution:** the usage counts come from April on two PCs and loose LISP is never recorded, so 'no recorded use' is weak evidence; and the sources disagree on 14 points (section 5), the most important being whether the Structural CLEAN saves, which the plan assumes.

## 2. Not decided: the ones that could be lost

Most-used first, then in map order. Each has one plain question, its context, a real-world example and my recommended answer. A recommendation is mine, not a decision.

1. **FM-163 CEMANAGERLOGS** (9 runs).
   - **Question:** Do you still want a button that opens the logs folder?
   - **Context:** the fault report collects the logs, but nothing says a drafter can open the logs folder.
   - **Example:** Tim or a colleague wanting to look at today's log without sending a report.
   - **Recommended answer:** Fold it into the fault-report window as 'Open logs folder'.
2. **FM-005 PITDELETE** (under 8 runs).
   - **Question:** When you ERASE a pit in the middle of a run, should its number tag, cover level text and schedule row go with it, and the two pipes show 'not joined yet'?
   - **Context:** nothing in the plan says what happens to a pit's tag and cover text when the pit is plainly erased. The planning chat's walk-through (SITUATIONS C8, a draft) proposes that the two pipes become grey 'not joined yet', the schedule row goes, and one line says so.
   - **Example:** Erase P3 between P4 and P2 on a unit job. Today PITDELETE tidies the tag and cover text; in the new design a plain ERASE would be the only way.
   - **Recommended answer:** Yes: tag, cover text and schedule row go with the pit; the two pipes turn grey 'not joined yet'; one line on the command line says so (SITUATIONS C8).
3. **FM-018 CDLPD** (5 runs).
   - **Question:** Does the new Outlet tool also carry the legal point of discharge label and invert, the way CDLPD does?
   - **Context:** the plan adds an Outlet tool for the council pit or kerb outlet a run reaches (D-190), but nothing says it also marks the legal point of discharge with its label, as CDLPD does.
   - **Example:** A unit job where council gives a discharge point at the kerb: CDLPD picks the connection, the pipe end and where the label sits.
   - **Recommended answer:** Yes: one Outlet tool, with the legal point of discharge as one of its kinds.
4. **FM-024 CDFALL, CDFALLSUGGEST** (CDFALL 4 runs).
   - **Question:** Is the fall symbol its own tool, or just a block placed from the Blocks palette? Is the 'suggest a fall arrow' idea wanted?
   - **Context:** no decision covers the fall symbol or the suggested fall arrow. Fall symbols exist as blocks in the office master drawing and on the palettes.
   - **Example:** A paved yard that falls to a grated pit: you drop a FALL arrow on it. Today CDFALL does that and CDFALLSUGGEST points it at the nearest grated pit.
   - **Recommended answer:** Let the Blocks palette place the fall symbol (no own command) and park the suggest-an-arrow idea.
5. **FM-032 CDTG, TG** (TG 2 runs).
   - **Question:** Is the trench grate one of the first-release inlets?
   - **Context:** the first-release inlet list stops at downpipe, overflow, FO, inspection opening, GIO and floor waste. A draft name TRENCHGRATE / TG exists, but Tim never reviewed that draft list (D-057).
   - **Example:** A trench grate across a driveway crossover or garage door.
   - **Recommended answer:** Yes, add it to the inlet family: it is one more list line and the block already exists in the office master drawing.
6. **FM-173 (no typed name: usage, machine and failure records the plug-ins write into the office IT folder)** (2,637 usage records, 1,029 failure records, 9 machine records (20 Apr to 16 Nov 2026)).
   - **Question:** Do the plug-ins keep writing a record of every command run, or only failures?
   - **Context:** the Manager keeps a fault report and an admin page with 'faults this week', which need failure records; Tim did not tick 'no usage records' and statistics are a future idea (FI-01). Nothing says whether per-command usage is still written.
   - **Example:** Today these records are the only evidence of what the office really uses (this map leans on them).
   - **Recommended answer:** Keep failure records now; keep one-line usage counts without client or job names so the next map is based on real use.
7. **FM-013 CDREVERSEFLOW, CDPIPEDIRECTION** (none in the records).
   - **Question:** When a pipe is drawn the wrong way round, should the plug-in turn it round by itself once the run reaches an outlet, or only offer a 'Turn round' line?
   - **Context:** no decision covers turning a pipe round or correcting a guessed direction. The planning chat's walk-through (SITUATIONS rule 3 and B3, drafts) proposes that direction comes from the outlet and a pipe drawn backwards turns itself round.
   - **Example:** You click P5 then P4 but the outlet is at P1: levels run uphill and the cover check goes red until the pipe is turned.
   - **Recommended answer:** Direction comes from the outlet; where both ends are pits and it is clearly backwards, one quiet line offers 'Turn round' (SITUATIONS B3).
8. **FM-014 CDSYSTEM** (none in the records).
   - **Question:** Is a pipe's system found automatically from where it drains to, with no typed choice?
   - **Context:** D-183 says each system is numbered from its own outlet, but nothing says how the plug-in learns which system a pipe belongs to. The planning chat's draft proposes a system is found from the joins and never typed.
   - **Example:** A four-unit job: front units drain to the kerb, rear units to an easement drain. Today CDSYSTEM tells CE which is which.
   - **Recommended answer:** Yes: found from the joins and each outlet's own facts; no typed system choice (SITUATIONS, drafts).
9. **FM-047 CDCALC** (none in the records).
   - **Question:** Does the first release print the computations sheet (PDF or Excel), or does it come straight after?
   - **Context:** The computations sheet: the sums are taken (D-095) and sit inside Detention and Pipe, and D-021 says the computations sheet prints from the same numbers, but no first-release tool prints it. Council calculators are parked (D-098).
   - **Example:** Every council submission has a computations sheet beside the layout plan; today CDCALC makes it.
   - **Recommended answer:** Build it straight after the first release; until then the old CDCALC stays available side by side (RULES rule 15.4).
10. **FM-089 CJSS** (under 8 runs).
   - **Question:** Do you still want to swap a joint between construction joint and saw cut?
   - **Context:** the joint tool description does not mention swapping a joint between construction joint and saw cut.
   - **Example:** A joint drawn as a construction joint that the engineer then calls a saw cut.
   - **Recommended answer:** Keep it as one button in the joint tool.
11. **FM-170 CDHELP, CESTARTHERE, CEHELP, CE_HELP, ?CE** (CDHELP under 8 runs).
   - **Question:** Does the new plug-in need its own help and picture tour, or only ribbon tips?
   - **Context:** no decision covers in-plug-in help or a tour. The old help pages describe the old commands. Every ribbon button will show its short name in its tip (naming rule).
   - **Example:** A new colleague opens the CE Civil tab for the first time.
   - **Recommended answer:** Tips on every button plus one short picture tour per tool, written after the tool is accepted.
12. **FM-016 CDSTRIP** (none in the records).
   - **Question:** Is the strip drain in the first release, or parked with the site tools?
   - **Context:** not in the first-release list. UI_PLAN already puts 'strip drain' in the wide-preview window family, but no decision brings it in or parks it.
   - **Example:** A garage-door strip drain with floor wastes running to a pit. It is on today's ribbon but is not in the usage records.
   - **Recommended answer:** Park it until Pit, Pipe and the inlets are accepted, then add it as one more line-shaped tool (one list line, the FOUNDATION test).
13. **FM-017 CDAGI, CDPERIMETER** (none in the records).
   - **Question:** Is the agricultural drain in the first release? It turns up on most unit jobs (the bench schedule has AGI inlet rows).
   - **Context:** not in the first-release list. Tim said AGI drains have no invert levels (D-040) and a draft name AGDRAIN / AG exists, but nothing brings it in or parks it.
   - **Example:** An AG drain behind a retaining wall tagged AGI1 and connected to a pit; no invert levels.
   - **Recommended answer:** Yes, build it as a kind of Pipe (line-shaped, no inverts), because jobs need it.
14. **FM-025 CDSL** (none in the records).
   - **Question:** Is the spot level its own tool, or a block placed from the Blocks palette?
   - **Context:** no decision covers spot levels. Spot level blocks exist on the palettes and in the office master drawing.
   - **Example:** A spot level on a driveway crossover.
   - **Recommended answer:** Let the Blocks palette place it; park any 'manage spot levels' behaviour.
15. **FM-033 CDSOURCE** (none in the records).
   - **Question:** Is there a generic 'other inlet' (roof drain, AC unit) in the first release?
   - **Context:** not in the inlet list.
   - **Example:** A roof drain or air-conditioner condensate drain that connects to the system but is not a downpipe.
   - **Recommended answer:** Yes: one 'other inlet' kind in the inlet family with a typed label; one list line.
16. **FM-034 CDRG** (none in the records).
   - **Question:** Is the raingarden in the first release, or parked until after it?
   - **Context:** raingarden is not mentioned in any decision (silt and soakage pits are parked, D-104). The concept notes marked it 'later', yet some councils need one on an ordinary job.
   - **Example:** A two-unit job in a council that wants a 100% water-quality rating.
   - **Recommended answer:** Park it, first in the queue after the first release.
17. **FM-038 CDDEST** (none in the records).
   - **Question:** Should the plug-in tell you where each downpipe ends up, and where a run stops short?
   - **Context:** the preview shows 'where in the system' as a strip (D-167) but nothing says the plug-in reports where each downpipe ends up or where a run stops short.
   - **Example:** DP2 drains to WT1 which overflows to the kerb; you want to check nothing stops half way.
   - **Recommended answer:** Yes, as part of the system strip and the Unfinished list.
18. **FM-045 CEFIND** (none in the records).
   - **Question:** Do you want a type-a-name-and-zoom find (P7, WT1)?
   - **Context:** the preview strip lights 'this object' in its run (D-167) but nothing gives a type-to-find.
   - **Example:** A 14-pit job: 'zoom to P11'.
   - **Recommended answer:** Park it; the Unfinished list's jump-to covers most of the need.
19. **FM-053 CDSLAB, CDSLABEDIT, CDSLABEREGEN, CDSLABFLOW** (none in the records).
   - **Question:** Do the slab fall tools wait until after the first release?
   - **Context:** slabs are not in the first-release list and no decision parks them by name. Tim's rulings are only that slabs and size changes must be shown (D-049) and that nothing optional is ever forced (D-050); a draft name SLAB / SB exists. CDSLABEDIT is already labelled 'known unsafe' in the registry.
   - **Example:** A garage slab or hardstand that needs falls to a grated pit; today CDSLAB works out the falls and places fall symbols and spot levels.
   - **Recommended answer:** Park the whole slab group until after the first release and rebuild it through the command review gate; nothing forced; never copy 'known unsafe' CDSLABEDIT.
20. **FM-055 CDJOINT** (none in the records).
   - **Question:** Does the automatic saw-cut grid survive, or are all joints drawn by hand with the new joint tools?
   - **Context:** the shared joint tools (CONSTRUCTIONJOINT / CJ and SAWCUT / SSC) replace the civil joint commands but draw lines by hand. Nothing says the automatic grid survives; Tim said saw cuts are only drawn if the drafter draws them (D-050).
   - **Example:** A 6 m x 9 m slab: today one command lays out the whole saw-cut grid at the spacing for the slab type.
   - **Recommended answer:** Keep it as a later option of the joint tool, never automatic and never forced.
21. **FM-057 CDSPOON, CDSPOONDRAIN** (none in the records).
   - **Question:** Is the spoon drain in the first release?
   - **Context:** not in the first-release list. UI_PLAN lists 'spoon drain' as a wide-preview tool type; no decision brings it in.
   - **Example:** A spoon drain along the side of a driveway, with its length and fall in the label.
   - **Recommended answer:** Park with the site group (see the slab line).
22. **FM-058 CDKERB** (none in the records).
   - **Question:** Is the kerb line in the first release?
   - **Context:** not in any decision.
   - **Example:** A kerb line at the front boundary beside the discharge point.
   - **Recommended answer:** Park; it is plain linework a drafter can draw with the office layer.
23. **FM-059 CDPAVE, CDCATCHMENT** (none in the records).
   - **Question:** Do the paved-area tool and the catchment overlay come into the first release?
   - **Context:** site areas picked off the drawing are covered (D-107) and reading hatched roof and paving is planned later (D-171 item 5), but the paved-area tool and the catchment overlay with its warning are not mentioned.
   - **Example:** A 60 m2 driveway draining to one grated pit; today the overlay warns if the paving is more than the grate can take.
   - **Recommended answer:** Park the overlay; take the paved area through the site-area route (D-107) and the Job window.
24. **FM-060 CDTPZ, CDSRZ** (none in the records).
   - **Question:** Are the tree zone circles wanted in the first release?
   - **Context:** not in any decision.
   - **Example:** A street tree on the front boundary needs its protection zone shown.
   - **Recommended answer:** Park; place them from the Blocks palette or as plain circles on the office layer.
25. **FM-064 CDXREFCOMPARE, CDXREFREPAIR** (none in the records).
   - **Question:** Should the plug-in compare a changed background and repair broken xref paths when a drawing opens?
   - **Context:** nothing says whether the plug-in compares a changed architect's background or repairs xref paths. The 'changed since last issue' list is later (D-187).
   - **Example:** The architect sends a new plan; which pits are now under a wall? Or the xref path breaks when a job folder moves.
   - **Recommended answer:** Park the compare with the 'changed since last issue' list; offer the xref path repair in the self-check on open.
26. **FM-065 CDNEWDWG** (none in the records).
   - **Question:** Is 'new job drawing from the template' a CE tool, or do drafters keep copying the template by hand?
   - **Context:** Tim said drafters start a job 'from the office template' (D-191) but no tool is named; the title block part belongs to the title block and issue group, which is parked.
   - **Example:** Starting a new house job: pick the job folder, A1, civil; the right template arrives named and filled in.
   - **Recommended answer:** Park with title block and issue; drafters copy the template by hand until then.
27. **FM-066 CDDISCIPLINE** (none in the records).
   - **Question:** Does a drawing still need a Civil or Structural switch?
   - **Context:** three tabs are ruled, with the structural tab hidden until it has tools (D-208), but nothing says what stops a civil tool being used on a structural drawing.
   - **Example:** A structural sheet open on a PC with the civil tab showing.
   - **Recommended answer:** Retire it: a drawing needs no discipline setting if each tab only offers its own tools.
28. **FM-076 DSET, DSET1** (none in the records).
   - **Question:** Do you still need the commands that set a dimension's measuring factor (DSET) and convert to one fifth (DSET1)?
   - **Context:** the dimension tool's description lists LD, AD, QD, DUP and the arc dimension but not DSET or DSET1. Tim said dimensions 'work fine'; whether the measuring-factor tools were meant to stay is not recorded.
   - **Example:** A detail drawn at 1:5 inside a 1:100 sheet whose dimensions must still read true sizes.
   - **Recommended answer:** Keep both as options inside the Dimensions tool if you use them; otherwise retire.
29. **FM-082 MD** (not recorded (loose LISP is not tracked)).
   - **Question:** Do you use MD (offset between two points at a maximum spacing)?
   - **Context:** it is in no interview and no decision.
   - **Example:** Spreading offset lines at 1,200 mm maximum between two picked points.
   - **Recommended answer:** Ask you; retire if not used (AutoCAD's own Offset, Array and Divide cover close cases).
30. **FM-085 CEHATCHCHANGE, CEHATCHBATCH, CEHATCHGAP, CEHATCHAUDIT** (none in the records).
   - **Question:** Do you want 'change these hatches to another preset', 'hatch many outlines at once', 'hatch across small gaps' and 'check hatches against the office standard' in the new hatch tool?
   - **Context:** the one hatch window is described as picking a hatch from a named list and laying it at the right scale; none of these four jobs is mentioned.
   - **Example:** Changing a floor's concrete hatch to the earth hatch after the engineer swaps the slab type; or hatching a plan with a 2 mm gap in the outline.
   - **Recommended answer:** Yes to 'change preset' and 'many at once' as buttons in the one window; park 'across gaps' and 'check'.
31. **FM-098 CIVILEXCELMTEXT** (not recorded (loose LISP is not tracked)).
   - **Question:** Do you still bring pit schedules in from a spreadsheet, or does the Pit schedule tool replace that?
   - **Context:** the new Pit schedule is placed once and then follows the pits (D-109), so it does the same job another way, but nothing says whether bringing in a spreadsheet's rows is still wanted.
   - **Example:** A pit schedule prepared in Excel by someone else, to be dropped on the sheet.
   - **Recommended answer:** Retire it: the Pit schedule is drawn from the pits themselves.
32. **FM-103 TP** (not recorded (loose LISP is not tracked)).
   - **Question:** Do you still need the tool-palette group switcher TP once the Blocks palette exists?
   - **Context:** Tim said regular tool palettes 'just work better' but are slow to edit; the new Blocks palette is to replace the palette sets, yet nothing says the group switcher goes.
   - **Example:** Switching to the CIVIL palette group on a new drawing.
   - **Recommended answer:** Retire it once the Blocks palette is accepted.
33. **FM-104 3DF2L** (not recorded (loose LISP is not tracked)).
   - **Question:** Do you use 3DF2L (3D faces to lines)?
   - **Context:** not in any interview or decision.
   - **Example:** Turning a surveyor's 3D faces into plain lines.
   - **Recommended answer:** Retire it (a free third-party routine, not CE's); ask you first.
34. **FM-105 <owner first name> (in NEW.lsp), CDJ, TEXTONANGLELEFT, TEXTONANGLERIGHT, TEXTONLINE** (not recorded (loose LISP is not tracked)).
   - **Question:** What do these five personal-folder commands do and do you still use them?
   - **Context:** purpose not found and not mentioned in TOOLS_TODAY or any decision. The three TEXT names suggest text placed at an angle or on a line, which may overlap the new TEXT window.
   - **Example:** TEXTONANGLELEFT may place text along an angled line, close to the new TEXT window's angle choice.
   - **Recommended answer:** Tell me, then fold the text ones into the TEXT window and retire the rest.
35. **FM-106 (no typed name: the old menu file TB2024.MNU and the bought-in structural toolkit it calls)** (not applicable).
   - **Question:** Does anyone still load the old TB2024 menu and the bought-in toolkit?
   - **Context:** whether anyone still loads this menu is Unknown (TOOLS_TODAY T-018); nothing in the plan mentions it.
   - **Example:** A colleague using a toolbar for a structural routine.
   - **Recommended answer:** Leave it alone (it is bought-in, not ours); do not carry it into CE.
36. **FM-176 (no typed name: the office alias file of 68 short names for AutoCAD's own commands)** (not applicable).
   - **Question:** Do the new short names (PT, CD, DP, CN, QL and so on) ship inside the plug-in, or as lines Tim adds to the office alias file on each PC?
   - **Context:** the plug-in never edits Tim's own alias file (D-170) and the new short names are checked against it, but nothing says where the plug-in's own short names live (the plug-in itself, or lines added to the alias file).
   - **Example:** Typing PT for a pit on a colleague's PC where the alias file is a different copy.
   - **Recommended answer:** Ship them inside the plug-in from one office list, and leave the alias file alone.
37. **FM-177 Wall-l, Wall-t, WX, L2ML, mltim, Dimsmallauto, Dimsmallorig, movedim, Grabcopy, _Pkser, MTE** (not recorded).
   - **Question:** What are the commands behind your WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial and ET aliases, and do you still use them?
   - **Context:** I found no definition of these commands in the shared LISP folder or in any plug-in code, and no plan document mentions them. Where they live and whether they are used is Unknown.
   - **Example:** Tim said WT already means the wall tool 'Wall-t' while the new Tank is WT (D-170).
   - **Recommended answer:** Tell me what they are; keep them untouched in your alias file.

## 3. Proposed to retire

Tick or refuse each in one go. 'Already ruled' lines are listed for the record and need no tick. Use counts are from the records and are weak evidence (see the notes at the top).

**A. Already ruled by Tim (for the record):**
1. **FM-009 CDPIPEOBJ** (none in the records): PROPOSED TO RETIRE (already ruled by Tim): the special one-piece pipe object is left behind. Reason: Tim ruled 'leave all 5 behind', and a drawing must work for people with no plug-in. **Evidence:** D-094; D-015.
2. **FM-010 CDC7UPGRADE** (none in the records): PROPOSED TO RETIRE (already ruled by Tim): it exists only to feed the one-piece pipe object that is left behind. The one-off 'make it ordinary' tool for drawings made with that pipe is the next line. **Evidence:** D-094; D-119.
3. **FM-078 C** (355 runs (April, two PCs; recorded as a structural shortcut)): PROPOSED TO RETIRE (already ruled by Tim): 'Retire it, use Copy'. Replaced by AutoCAD's own Copy, which repeats until Enter. **Evidence:** D-203; TA-005; D-054.

**B. For Tim to tick or refuse:**
1. **FM-039 CDSOURCECHANGETYPE** (Civil; none in the records): change a selected source's type (reserved; it refuses today). **Reason:** it does nothing today (it refuses). Changing the kind of an inlet is a choice in its own window. **Evidence:** D-061.  **Tick to retire / refuse:** ____
2. **FM-042 CDCHECKIGNORE, CDCHECKIGNOREAPPLY** (Civil; none in the records): hide one Checks finding with a reason (survey, council requirement, engineer's judgement), saved in the drawing; 'not switched on yet'. **Reason:** never switched on in the installed build. The idea (hide a finding with a reason) is not lost if Tim wants it: D-003 already asks for a short justifying note when two sources disagree. **Evidence:** D-003; PARTS_BIN item 18.  **Tick to retire / refuse:** ____
3. **FM-044 CDFOCUS** (Civil; none in the records): bring CE windows back to the foreground. **Reason:** only needed because the old windows float behind the drawing. New windows have an Inspect button that hides and returns them with everything typed kept. **Evidence:** D-065.  **Tick to retire / refuse:** ____
4. **FM-049 CDSETUP** (Civil; none in the records): old name for CDDESIGN (prints one line and opens CDDESIGN). **Reason:** old name of CDDESIGN; old names are gone from day one. **Evidence:** D-053.  **Tick to retire / refuse:** ____
5. **FM-079 COPYMULTI, COPYM, CEMCOPY** (Civil; Structural; none in the records): longer names for the repeat copy that C ran. **Reason:** the same job as C, which Tim retired in favour of AutoCAD's own Copy. **Evidence:** D-203; TA-005.  **Tick to retire / refuse:** ____
6. **FM-093 CDD, CDD3, CDDE, CDD-VERSION, CDD-OSNAP** (LISP; not recorded (loose LISP is not tracked)): draw a drainage pipe with size, grade, invert text and flow arrow (the 11,540-line file dated Nov 2025), its variants and its version and snap helpers. **Reason:** a third way to draw a drainage pipe beside CD in the Civil program and the older LISP CD; the new Pipe tool replaces all of them. Real use in the office is Unknown (loose LISP is not recorded). **Evidence:** TOOLS_TODAY T-015; THE_PLAN section 3 item 2.  **Tick to retire / refuse:** ____
7. **FM-094 CD (older LISP 'Civil Pipe Creation', in a personal sub-folder)** (LISP; not recorded (loose LISP is not tracked)): older drainage pipe command, six copies, all in old folders. **Reason:** duplicate of the plug-in's CD (and of CDD). It also shares a typed name with the plug-in's CD, so which one answers is Unknown. **Evidence:** TOOLS_TODAY T-015; THE_PLAN section 3 item 2.  **Tick to retire / refuse:** ____
8. **FM-097 TBDRAIN-INPUT** (LISP; not recorded (loose LISP is not tracked)): older pipe-data input dialog. **Reason:** duplicate of the Pipe window. **Evidence:** TOOLS_TODAY T-015.  **Tick to retire / refuse:** ____
9. **FM-100 EXCELMODULES, EXCELRESET, EXCELSTATUS, CHECKCONFIG, SELECTFILE, SETBASEPOINT, CREATEMTEXT, CREATEWIPEOUTBLOCKS, CREATEDOUBLEWIPEOUT, TOGGLEBGWIPEOUT** (LISP; not recorded (loose LISP is not tracked)): build steps and switches of the Excel importer (modules 1 to 10): status, reset, file picker, base point, text and wipeout block creation. **Reason:** development steps of the Excel importer, not staff tools. **Evidence:** TOOLS_TODAY T-014 (names not itemised there).  **Tick to retire / refuse:** ____
10. **FM-101 TESTBASICTEXT, TESTADVANCEDFORMAT, TESTSPECIALCASES, TESTTITLEFORMAT, TESTFILEOPS, TESTCSVPARSE, TESTDEPTHANALYSIS, TESTWIDTHCALC, TESTPOSITIONING, TESTMTEXTCREATE** (LISP; not recorded (loose LISP is not tracked)): test routines for the Excel importer modules. **Reason:** developer test routines. **Evidence:** none (found only in the shared LISP folder).  **Tick to retire / refuse:** ____
11. **FM-102 CHECKWIPEOUTBLOCK, TESTWIPEOUTBLOCKS, CHECKDOUBLEBLOCKS, TESTDOUBLEWIPEOUT, TXTDEBUG, CRHELP, SUPDEBUG** (LISP; not recorded (loose LISP is not tracked)): check and test routines for wipeout blocks, text tags, move-rotate help and support blocks. **Reason:** developer check, test and debug routines. **Evidence:** none (found only in the shared LISP folder).  **Tick to retire / refuse:** ____
12. **FM-109 (no typed name: 'OLD TOOL PALETTES', 43 palette files, 2022 to Sep 2024)** (Palettes; not recorded): earlier versions of the palette set, several with duplicates. **Reason:** earlier versions of the current set. **Evidence:** TOOLS_TODAY T-021.  **Tick to retire / refuse:** ____
13. **FM-110 CEPALETTE, CETOOLS, CETOOLSTOGGLE** (Structural; CETOOLS under 8 runs): a command hub palette (CETOOLS) and a fuzzy search that finds and runs any CE command (CEPALETTE). **Reason:** replaced by the three tabs and ribbon tips (D-200); Tim did not tick 'command search' as a shared tool (TA-031); CETOOLS has under 8 recorded runs. **Evidence:** D-200; TA-031; TOOLS_TODAY T-033.  **Tick to retire / refuse:** ____
14. **FM-172 CEASK, CDASK** (Civil; none in the records): ask a question about the drawing (the optional Ask CE assistant, switched off by default). **Reason:** no decision asks for an assistant; its path can send drawing text off the PC (privacy review flagged in the code); never used in the records. **Evidence:** PARTS_BIN item 30.  **Tick to retire / refuse:** ____
15. **FM-181 CDDEBUG, CDGRIPROUTE, CDGRIPDIAG, CEPERFDIAG, CETRUSTREAD, CDPIPEATTACHMENTACTION, CDUSEPLANLABEL, CDCLOSETAB, CE_TEST_RUN, CDEXPORTCORPUS** (Civil; CDDEBUG under 8 runs): internal and fault-finding commands: debug switches, grip and performance diagnostics, the trust reader, internal routes for grips and the Inspector, the test runner, a developer export. **Reason:** internal fault-finding for the old objects, not staff tools. The new build keeps its own checks (speed and 'native AutoCAD untouched' tests) instead. **Evidence:** TOOLS_TODAY T-049; PARTS_BIN item 19; THE_PLAN section 9 (speed is checked).  **Tick to retire / refuse:** ____
16. **FM-182 CEW03TESTEXTRACT, CELINKSTATUS, CETESTCR, CETESTMR** (Test bundle; none in the records): leftover test pieces: a synthetic read-only link test (loads at every start-up) and a trial Copy+Rotate / Move+Rotate. **Reason:** leftover test bundles that never shipped as tools; the fifth home of Move+Rotate. **Evidence:** TOOLS_TODAY T-053; T-054.  **Tick to retire / refuse:** ____
17. **FM-184 BEAMLINKDEBUG, BEAMLINKMIGRATE, STRUCDEBUG, CEDEBUG, JOBTIMERDEBUG, CERECOVERY, CSWAKE, CESTRUC_PALETTE_RESTORE** (Structural; none in the records): Structural fault-finding and plumbing: dump or migrate beam link data, beam and text tag diagnostics, time tracking diagnostics, review and clear incomplete command snapshots, wake Structural for a drawing, restore the Structural palette at start-up. **Reason:** internal fault-finding and plumbing for the old Structural objects, not staff tools. Structural is rebuilt on the new foundation when it is unparked, with its own checks. **Evidence:** D-006; D-094 (repair and linking code left behind); registry texts.  **Tick to retire / refuse:** ____

## 4. Functionality that would be LOST if nothing changes

Each is something today's tools do that the tool covering them (or no tool at all) does not yet do. Part A: a tool covers the job but not all of it. Part B: no tool in the plan covers it. Part C: parked on purpose, so it is not lost but it does not come in the first release (the old plug-in must stay installed side by side until each is built).

**A. Parts of covered jobs that the new tool does not yet cover:**
1. **FM-021.** The long section drawn onto the sheet. LONGSECTION shows the long section and plan in its window, but nothing says it draws the long section onto the sheet as CDPROFILE does. Evidence: D-129, D-131, D-030 (council asks for them on some jobs).
2. **FM-023.** The list of every level a detention system could be held to, with where each came from (CDTWL). Tim did not answer how a top water level is chosen (D-175).
3. **FM-050.** Entering a job's own rainfall coefficients from a text file or from what is copied (CDRAINFALL). How a site's rainfall table arrives is an open question (INPUT_AUDIT item 8).
4. **FM-035.** The riser and dropper block link under the tank tag (CDWT). Not mentioned in D-100, D-170 or the tank window decisions.
5. **FM-036.** Registering a foreign block (an AGI line, a council block, a water tank block drawn by someone else) as a source (CDTAG, 64 runs). D-192 only covers a plain line on a stormwater layer.
6. **FM-001.** Pit kinds: silt pit and soakage pit (not first release, D-104).
7. **FM-071.** The XRL settings and information variants (XRLCONFIG, XRLINFO, XRLSILENT): only 'a step of CLEAN' is described.
8. **FM-161.** The Admin Dashboard's Usage, Machines, Failures, Policies, Support Bundles tabs, Canary Rollout and Promote to All buttons: dropped by Tim's own answer (TA-013), listed so he sees them go.
9. **FM-156.** The Manager pages Status, Settings, Help, Project / Sheets, Project QA, Survey Intake and Drawing Repair: dropped on purpose (MG-06, TA-012).
10. **FM-056.** CDCJ and CDSC are replaced by CONSTRUCTIONJOINT and SAWCUT, but the automatic grid is a separate loss (B, item 1) and how the label should 'learn' is still open.
11. **FM-083.** Which of the roughly 40 hatches survive: Tim's tick list (TA-045) is not done, so today nothing says the hatch window will offer every hatch the office uses.

**B. Functions no tool in the plan covers (all are on today's ribbon or typed commands):**
1. **FM-055.** The automatic saw-cut grid (CDJOINT). The joint tools draw by hand.
2. **FM-047.** The computations sheet as PDF or Excel (CDCALC). The sums are taken (D-095) but nothing prints the sheet.
3. **FM-018.** The legal point of discharge label and connection (CDLPD, 5 runs).
4. **FM-032.** Trench grate (CDTG / TG), generic source (CDSOURCE) and raingarden (CDRG): FM-033, FM-034.
5. **FM-017.** Agricultural and perimeter drains (CDAGI, CDPERIMETER) and the strip drain (CDSTRIP: FM-016).
6. **FM-053.** The slab fall tools and the spoon drain, kerb, paved area, catchment overlay and tree zone tools: FM-057, FM-058, FM-059, FM-060.
7. **FM-025.** Spot levels and the fall symbol with its 'suggest a fall arrow' (CDSL, CDFALL, CDFALLSUGGEST): FM-024.
8. **FM-005.** Tidying a pit's tag and cover text when the pit is erased (PITDELETE).
9. **FM-013.** Turning a pipe round and correcting a guessed flow direction (CDREVERSEFLOW, CDPIPEDIRECTION), and CDSYSTEM (FM-014).
10. **FM-038.** Reporting where each downpipe ends up (CDDEST).
11. **FM-064.** Comparing a changed background xref and repairing xref paths (CDXREFCOMPARE, CDXREFREPAIR).
12. **FM-076.** The dimension measuring-factor tools DSET and DSET1.
13. **FM-085.** Change hatches to another preset, hatch many outlines at once, hatch across small gaps, check hatches against the standard (CEHATCHCHANGE, BATCH, GAP, AUDIT).
14. **FM-089.** Swapping a joint between construction joint and saw cut (CJSS).
15. **FM-082.** MD, TP, 3DF2L and the owner-folder commands FM-103, FM-104, FM-105.
16. **FM-042.** 'Hide a finding with a reason' (CDCHECKIGNORE): proposed to retire in section 3 but it is an idea Tim may want.
17. **FM-167.** Per-PC personal defaults (CDS): the plan only has the office list.
18. **FM-170.** In-plug-in help and the 2-minute picture tour.
19. **FM-173.** Per-command usage records, the only evidence of real use that this map and the earlier studies rely on.
20. **FM-163.** The Open logs button.

**C. Parked on purpose (not lost, not in the first release):**
1. **FM-062.** Import of another civil package's drawing, LandXML, compare import and consultant drawing check (CDIMPORTXCIVIL was run 9 times on one PC).
2. **FM-061.** Survey load and the Manager's survey review (FM-164).
3. **FM-054.** Take-up of old things: slab adoption, upgrade of legacy drawings, identity upgrade, the 'make it ordinary' tool for the one-piece pipe (FM-180, FM-011).
4. **FM-111.** Plot to PDF, Excel into schedule, the Structural job checklist, sheets list, job time editing and every structural-only tool: the structural lines in section 6.

## 5. Where the sources disagree

1. **Civil count.** The Civil code at 2c8b7b1a declares 150 commands under 146 different names (MR, MOVEROT, CR and COPYROT are each declared twice). TOOLS_TODAY says 145 typed names and 143 in the list. The Civil registry has 143 rows, 142 of which match the code; the 143rd, CEBLOCKS, is a Manager command that the Civil registry lists. Four code names are not registry rows but are registry aliases (CDASK, LINKPIPEPIT, CLEARPIPEPITLINK) or a test runner (CE_TEST_RUN). I cannot say why TOOLS_TODAY is one short of 146.
2. **Structural count.** The Structural code at d4edbc19 declares 510 commands under 396 different names (one is the typed name ?CE); the registry has 375 rows plus 35 alias spellings, and 7 more registry names are delivered by LISP rather than C# (XCLMTXTINDEX, BMT2TXT, BTXT2MT, MR, CR, MOVEROT, COPYROT), giving 403 different typed names. TOOLS_TODAY says 376. That is 27 names more than TOOLS_TODAY.
3. **Structural coverage in TOOLS_TODAY.** TOOLS_TODAY itemises Structural only as general helper groups (T-025 to T-033). Only 147 of the 403 Structural names appear anywhere in it, so about 256 (the CS-tools, footings, markup, section details, beams and so on) have no T- item. That is deliberate in TOOLS_TODAY ('outside this record') but means this map is the first full list.
4. **CLEAN saves or does not.** The Structural registry text for CLEAN says 'Does not save: save the drawing yourself' while its own long description and note (B-178, Tim, 5 Nov 2026) say it saves at the end; the LISP CLEAN (SAVE OP.lsp) saves with QSAVE; TOOLS_TODAY T-004 says it saves; the new plan (ST-01) says 'then save'. Tim said he uses it as his main save. Which behaviour the installed Structural CLEAN really has is Unknown without running it.
5. **C.** TOOLS_TODAY lists C as a Structural shortcut with 355 recorded runs, and T-001 says it exists in several homes. The Structural code at d4edbc19 has no command C (it has COPYM and CEMCOPY), and the Civil code says COPYMULTI is 'retained when C was returned to Circle'. The 355 runs are from April builds. Tim has retired C either way (D-203).
6. **CEBLOCKS has three homes.** It is declared in the Manager, declared again in Structural, and listed in the Civil registry. TOOLS_TODAY gives it only to the Manager (T-023, T-051).
7. **Alias list size.** The list Tim pasted has 68 live lines; R-003 trial 7 says 77 entries in the file on his PC.
8. **Two Civil ribbon layouts.** TOOLS_TODAY T-050 notes two layouts; the code confirms it: ten visible commands (CDCATCHMENT, CDCHECK, CDDEST, CDFALLSUGGEST, CDIMPORTLANDXML, CDIMPORTXCIVIL, CDPERIMETER, CDTIDYLABELS, CDTWL, CESTARTHERE) are only on the layout that is not the 'classic' one. Which layout a drafter sees depends on a setting; not checked.
9. **Usage names with no T- item.** TOOLS_TODAY says STRETCH, CE_STRUC_SUITE, PFC, 18B, 18T, C1 and DS are Unknown. The code says: CE_STRUC_SUITE is the Structural command window, PFC is the pad footing outline and tag, 18B and 18T are 1.8 mm text, C1 is the column marker, DS is the double stud marker; STRETCH is AutoCAD's own command, which the plug-ins watch and which is counted only because they wrap it.
10. **Loose LISP names missing from TOOLS_TODAY.** About 60 typed names in the shared LISP folder have no T- item, mainly: the Excel importer's development modules (27 development, check and test routines: Excel importer modules, wipeout blocks, debug switches), CDD-MOVE-ARROW, CDD-OSNAP, CDD-SETTINGS, CDD-VERSION, CDJ, the personal-folder text routines (TEXTONANGLELEFT, TEXTONANGLERIGHT, TEXTONLINE), SUPDEBUG, TXTDEBUG, CRHELP and the owner-named command in NEW.lsp. TOOLS_TODAY counts 156 names in non-superseded files; I count 183 across the root, UPDATED, <owner> EXPORT and the personal sub-folder.
11. **Names in TOOLS_TODAY T-056 and NAMING_DRAFT that later decisions changed.** T-056 still shows TANK = TK (changed to WT by D-170) and LEVELS = LV (renamed LONGSECTION / LG by D-196). NAMING_DRAFT item 2 still shows PIPE short PI (D-057 kept CD); its draft list was never reviewed by Tim (D-057).
12. **THE_PLAN section 3 contradicts itself.** The line 'Not in the first release' still lists 'CE everyday helpers; Manager changes' directly above the 18 Nov change note that brings them in (D-200, D-201, D-204). The change note wins (it is later).
13. **Where an old command's job sits.** The interview file says the structural CJ / SSC / CJSS and the civil CDJOINT / CDCJ / CDSC are replaced by the new joint tools (ST-09), but describes only hand-drawn joint lines; CDJOINT is an automatic grid (section 4, B item 1).
14. **Not found.** The commands behind Tim's WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial and ET aliases (Wall-l, Wall-t, WX, L2ML, mltim, Dimsmallauto, Dimsmallorig, movedim, Grabcopy, _Pkser, MTE) are defined nowhere I could read.

## 6. The full map

Order: civil drainage; civil other; shared everyday tools; structural; Manager, updates and settings; test, repair and developer commands. Letters: (a) new tool, (b) folded in, (c) parked, (d) proposed to retire, (e) not decided.

### Civil drainage

**FM-001.** **PIT** (Civil; 45 runs (median 29 s; 8 not completed); on the ribbon): place a pit with its kind, size, cover level and schedule values. **Goes to:** (a) NEW TOOL: Pit (PIT, short PT). Whole job covered for junction, grated, plastic, orifice (control), pump and bought-in pits. Not covered: silt pits and soakage pits (later, D-104). **Evidence:** THE_PLAN section 3 item 1; D-101; D-104.

**FM-002.** **PP** (Civil; none in the records; on the ribbon): place a pit already filled in as a 350 x 350 plastic pit. **Goes to:** (b) FOLDED IN: no own command. The Pit window opens already filled in with what was used last (D-060) and plastic is one of its kinds (D-104). The name PP also clashes with the office Pedit alias (NAMING_DRAFT). **Evidence:** D-053; D-060; D-104.

**FM-003.** **CDPIT350, CDPIT450, CDPIT600, CDPIT900, CDPIT1200** (Civil; none in the records; typed only): place a pit at one preset size. **Goes to:** (b) FOLDED IN: pit size is a choice in the Pit window and the size is worked out from depth by the office table (350 to 0.45 m, 450 to 0.60 m, 600 to 0.90 m and so on). **Evidence:** D-053; D-135; D-171 item 3.

**FM-004.** **CDEDIT, PITEDIT, PIPEEDIT** (Civil; PITEDIT 74, CDEDIT 67, PIPEEDIT 66 runs (8 of the PIPEEDIT runs not completed); 1 on the ribbon, 2 typed only): pick a pit or pipe and open the right edit window for it. **Goes to:** (b) FOLDED IN: no typed name. Click the thing and change it in Properties, or double-click it to get the window it was placed with. Not yet proven: the Properties route and double-click need a real mouse trial (THE_PLAN section 6a item 3). **Evidence:** D-056; D-061; D-048.

**FM-005.** **PITDELETE** (Civil; under 8 runs; typed only): delete a pit together with its number tag and cover level text. **Goes to:** (e) NOT DECIDED: nothing in the plan says what happens to a pit's tag and cover text when the pit is plainly erased. The planning chat's walk-through (SITUATIONS C8, a draft) proposes that the two pipes become grey 'not joined yet', the schedule row goes, and one line says so. **Evidence:** none (SITUATIONS C8 is a draft, not Tim's word).

**FM-006.** **CDPITCOVERFLIP** (Civil; none in the records; typed only): move a pit's cover level text to another corner (the invert text moves with it). **Goes to:** (b) FOLDED IN: grips on the label parts. Cover level text can be flipped and moved by its own grip (D-037). The custom-grip trial failed once and is not yet proven (D-155). **Evidence:** D-037; D-155.

**FM-007.** **CDRENUMBER** (Civil; none in the records; typed only): preview and renumber the pits from the outlet upstream (P1 nearest the outlet). **Goes to:** (a) NEW TOOL: a Renumber button in the Pit tool (PIT / PT). Whole job covered: P1 at the outlet, renumber on request, one series with the street system first, and the choice of next free number, letter (P3A) or full renumber. **Evidence:** D-075; D-183; D-184; D-185.

**FM-008.** **CD** (Civil; 155 runs (median 21 s; 14 not completed); on the ribbon): draw a drainage pipe with size, grade and invert controls, flow arrow and labels. **Goes to:** (a) NEW TOOL: Pipe (PIPE, short CD, kept as the one exception to 'old names are gone'). Covers new stormwater, charged, suspended and detention pipes, twin pipes as one, bends on every kind. Not covered: strip, agricultural and perimeter drains (separate commands today). **Evidence:** THE_PLAN section 3 item 2; D-057; D-082; D-083; D-189.

**FM-009.** **CDPIPEOBJ** (Civil; none in the records; typed only): draw a pipe as one single AutoCAD object (2027 only). **Goes to:** (d) PROPOSED TO RETIRE (already ruled by Tim): the special one-piece pipe object is left behind. Reason: Tim ruled 'leave all 5 behind', and a drawing must work for people with no plug-in. **Evidence:** D-094; D-015.

**FM-010.** **CDC7UPGRADE** (Civil; none in the records; typed only): turn a drawing's existing pipes into one-object pipes, with a dated copy first. **Goes to:** (d) PROPOSED TO RETIRE (already ruled by Tim): it exists only to feed the one-piece pipe object that is left behind. The one-off 'make it ordinary' tool for drawings made with that pipe is the next line. **Evidence:** D-094; D-119.

**FM-011.** **(no old command: a one-off 'make it ordinary' tool for drawings made with the one-piece pipe)** (Civil; none in the records; not on a ribbon): turn the one-piece pipe in an old drawing into ordinary linework, one drawing at a time, on a copy first. **Goes to:** (c) PARKED with old-drawing take-up: after the first release, one drawing at a time, on a copy first. **Evidence:** D-119; THE_PLAN section 3.

**FM-012.** **CDBREAK** (Civil; none in the records; typed only): record a branch pipe joining a main at a chainage (the main stays one pipe). **Goes to:** (b) FOLDED IN: a branch is always allowed; a pit placed on a drawn pipe splits it into two pipes joined to the pit; a join is a pointer kept on the object itself. **Evidence:** D-077; D-081; FOUNDATION block 4; THE_PLAN section 6a item 2.

**FM-013.** **CDREVERSEFLOW, CDPIPEDIRECTION** (Civil; none in the records; typed only): turn a pipe around (From/To, inverts, arrow and labels swap), and correct or reverse a flow direction CE only guessed from the click order. **Goes to:** (e) NOT DECIDED: no decision covers turning a pipe round or correcting a guessed direction. The planning chat's walk-through (SITUATIONS rule 3 and B3, drafts) proposes that direction comes from the outlet and a pipe drawn backwards turns itself round. **Evidence:** none (SITUATIONS rule 3 and B3 are drafts, not Tim's word).

**FM-014.** **CDSYSTEM** (Civil; none in the records; typed only): put the picked pipes in a system (property drainage, outfall drain, council connection) or follow the upstream pipe. **Goes to:** (e) NOT DECIDED: D-183 says each system is numbered from its own outlet, but nothing says how the plug-in learns which system a pipe belongs to. The planning chat's draft proposes a system is found from the joins and never typed. **Evidence:** none (SITUATIONS 'a system is everything that drains to one outlet' is a draft).

**FM-015.** **CDCONFIRM, CDPIPEOVERRIDE, CDPIPEOVERRIDECLEAR, PIPEPITLINK, LINKPIPEPIT, PIPEPITUNLINK, CLEARPIPEPITLINK** (Civil; none in the records; typed only): join or un-join a pipe end to a pit or tagged source by hand, and record that a pipe end connects or does not. **Goes to:** (b) FOLDED IN: a join is a pointer kept on the object itself; a pipe end joins when it meets a pit and parts when pulled away. Proven in the 16 Nov trial through move, copy, mirror, rotate, stretch, save and reopen. **Evidence:** FOUNDATION block 4; THE_PLAN section 6a items 1 and 2.

**FM-016.** **CDSTRIP** (Civil; none in the records; on the ribbon): draw a 100 mm strip drain with floor wastes at every corner and at 12 m along straight runs. **Goes to:** (e) NOT DECIDED: not in the first-release list. UI_PLAN already puts 'strip drain' in the wide-preview window family, but no decision brings it in or parks it. **Evidence:** none (UI_PLAN section 3 mentions it as a later tool in the wide-preview family).

**FM-017.** **CDAGI, CDPERIMETER** (Civil; none in the records; on the ribbon): draw an agricultural drain or perimeter drain line and tag it automatically (AGI1, PD1). **Goes to:** (e) NOT DECIDED: not in the first-release list. Tim said AGI drains have no invert levels (D-040) and a draft name AGDRAIN / AG exists, but nothing brings it in or parks it. **Evidence:** none (D-040 is a fact about AGI drains; NAMING_DRAFT item 11 is a draft name that Tim never reviewed).

**FM-018.** **CDLPD** (Civil; 5 runs; on the ribbon): choose the legal point of discharge connection, then pick its pipe end and label position. **Goes to:** (e) NOT DECIDED: the plan adds an Outlet tool for the council pit or kerb outlet a run reaches (D-190), but nothing says it also marks the legal point of discharge with its label, as CDLPD does. **Evidence:** D-190 (outlet only); none for the legal point of discharge label.

**FM-019.** **CDLPDRESET** (Civil; none in the records; typed only): reset the legal point of discharge (repair). **Goes to:** (b) FOLDED IN: repair command, not needed: one fact held once. **Evidence:** D-094; PARTS_BIN item 19.

**FM-020.** **CDRUNSOLVE** (Civil; none in the records; on the ribbon): pick a start pit, work out inverts and grades down the whole run, preview and apply. **Goes to:** (a) NEW TOOL: Long section (LONGSECTION, short LG; it was Levels along a run). Whole job covered, and it now works from either end with held values and a padlock on every number. **Evidence:** THE_PLAN section 3 item 3; D-086; D-129; D-196.

**FM-021.** **CDPROFILE** (Civil; none in the records; on the ribbon): pick an upstream pit and draw a long-section block onto the drawing. **Goes to:** (a) NEW TOOL: Long section (LONGSECTION / LG), PART only. The window shows the long section with the plan beneath it. Not covered: nothing says the tool draws the long section onto the sheet as CDPROFILE does today. **Evidence:** THE_PLAN section 3 item 3; D-129; D-131; D-030 (long sections only when council asks).

**FM-022.** **CDPROPAGATE, CDRECOVERINVERTS** (Civil; none in the records; typed only): push invert levels down a run, or rebuild invert text from the stored data. **Goes to:** (b) FOLDED IN: sums have no direction and work either way; invert text is a view of one held fact, so there is nothing to rebuild. **Evidence:** D-086; FOUNDATION blocks 1, 2 and 7; D-094.

**FM-023.** **CDTWL** (Civil; none in the records; on the ribbon): work upstream from a detention pit or tank outlet, list every level the system could be held to and where each came from, then report the storage. **Goes to:** (a) NEW TOOL: Detention (DETENTION, short DET), PART only. The top water level is a fact in the Detention window with its own box (baffle top equals top water level, D-172). Not covered: the list of candidate levels with where each came from; Tim did not answer how a top water level is chosen (D-175). **Evidence:** THE_PLAN section 3 item 6; D-099; D-105; D-172; D-175.

**FM-024.** **CDFALL, CDFALLSUGGEST** (Civil; CDFALL 4 runs; on the ribbon): insert a fall symbol, or suggest a fall arrow from a spot level toward the nearest grated pit. **Goes to:** (e) NOT DECIDED: no decision covers the fall symbol or the suggested fall arrow. Fall symbols exist as blocks in the office master drawing and on the palettes. **Evidence:** none.

**FM-025.** **CDSL** (Civil; none in the records; on the ribbon): insert and manage spot levels. **Goes to:** (e) NOT DECIDED: no decision covers spot levels. Spot level blocks exist on the palettes and in the office master drawing. **Evidence:** none.

**FM-026.** **DP** (Civil; 2 runs; on the ribbon): insert a downpipe block and tag it automatically. **Goes to:** (a) NEW TOOL: Downpipe (DOWNPIPE, short DP). Whole job covered; keep clicking, Enter to finish. **Evidence:** THE_PLAN section 3 item 4; D-101; D-186.

**FM-027.** **IO** (Civil; 2 runs; on the ribbon): insert an inspection opening block and tag it automatically. **Goes to:** (a) NEW TOOL: Inspection opening (INSPECTION, short IO, kept by Tim). Whole job covered; an inspection opening is offered, never forced, at a bend on a long run. **Evidence:** THE_PLAN section 3 item 4; D-054; D-081; D-101.

**FM-028.** **OF** (Civil; none in the records; on the ribbon): insert an overflow block and tag it automatically. **Goes to:** (a) NEW TOOL: Overflow (OVERFLOW, short OF). Whole job covered. How FO and OF are drawn is still an open item (THE_PLAN section 7 item 4). **Evidence:** THE_PLAN section 3 item 4; D-101.

**FM-029.** **FO** (Civil; none in the records; on the ribbon): insert a front overflow block and tag it automatically. **Goes to:** (a) NEW TOOL: FO (typed FO only, no longer name). Whole job covered. **Evidence:** THE_PLAN section 3 item 4; D-059; D-101.

**FM-030.** **GIO** (Civil; none in the records; on the ribbon): insert a gross inlet block and tag it automatically. **Goes to:** (a) NEW TOOL: GIO (typed GIO). It goes exactly where clicked on the pipe, slides along the pipe by its grip, and can sit off a pipe. **Evidence:** THE_PLAN section 3 item 4; D-050; D-101.

**FM-031.** **CDFW** (Civil; none in the records; on the ribbon): place a floor waste block and give it the next FW tag. **Goes to:** (a) NEW TOOL: Floor waste (FLOORWASTE, short FW). Whole job covered. **Evidence:** THE_PLAN section 3 item 4; D-101.

**FM-032.** **CDTG, TG** (Civil; TG 2 runs; 1 on the ribbon, 1 typed only): insert a trench grate block and tag it automatically. **Goes to:** (e) NOT DECIDED: the first-release inlet list stops at downpipe, overflow, FO, inspection opening, GIO and floor waste. A draft name TRENCHGRATE / TG exists, but Tim never reviewed that draft list (D-057). **Evidence:** none (NAMING_DRAFT item 8 is a draft; UI_PLAN lists it as a wide-preview tool).

**FM-033.** **CDSOURCE** (Civil; none in the records; on the ribbon): insert a generic source block (roof drain, AC unit) with a typed source ID, not added to the pit schedule. **Goes to:** (e) NOT DECIDED: not in the inlet list. **Evidence:** none.

**FM-034.** **CDRG** (Civil; none in the records; on the ribbon): draw a raingarden outline with solid hatch and a GIO block. **Goes to:** (e) NOT DECIDED: raingarden is not mentioned in any decision (silt and soakage pits are parked, D-104). The concept notes marked it 'later', yet some councils need one on an ordinary job. **Evidence:** none (CONCEPT_GAP_CHECK gap 7 is a draft concern, not a decision).

**FM-035.** **CDWT** (Civil; none in the records; on the ribbon): tag a water tank, ask total, detention and reuse litres, place a callout, and link riser and dropper blocks under the same tank tag. **Goes to:** (a) NEW TOOL: Tank (TANK, short WT; TK was replaced, D-170). Covers the tank, its note and leader. Not covered: the riser and dropper link is not mentioned in any decision I read. **Evidence:** THE_PLAN section 3 item 5; D-100; D-170; D-039.

**FM-036.** **CDTAG** (Civil; 64 runs (7 not completed); on the ribbon): tag, re-tag or repair source names, and register non-standard blocks (AGI, water tank, council blocks) in CE's records. **Goes to:** (b) FOLDED IN for tagging and re-tagging: tags are given in turn when placing, and retyping a tag renames the pit or source. Not covered: registering a foreign block (an AGI line, a council block) as a source; D-192 covers only a plain line on a stormwater layer ('one line on opening, a take-it-up click'). **Evidence:** D-185; D-186; D-192; FOUNDATION.

**FM-037.** **CDFIXTAGS** (Civil; none in the records; typed only): list every source name used twice, show the renames and rename only on Yes. **Goes to:** (b) FOLDED IN: a duplicate number shows amber on both and retyping one renames it; it is never refused. **Evidence:** D-185; D-183.

**FM-038.** **CDDEST** (Civil; none in the records; on the ribbon): follow the drawn pipes and say where each downpipe ends up (a tank, or out to the legal point of discharge) and where the trail stops. **Goes to:** (e) NOT DECIDED: the preview shows 'where in the system' as a strip (D-167) but nothing says the plug-in reports where each downpipe ends up or where a run stops short. **Evidence:** D-167 (strip only).

**FM-039.** **CDSOURCECHANGETYPE** (Civil; none in the records; typed only): change a selected source's type (reserved; it refuses today). **Goes to:** (d) PROPOSED TO RETIRE: it does nothing today (it refuses). Changing the kind of an inlet is a choice in its own window. **Evidence:** D-061.

**FM-040.** **PITSCHEDULE** (Civil; 39 runs (median 22 s); on the ribbon): review, override, compare and place the pit schedule. **Goes to:** (a) NEW TOOL: Pit schedule (SCHEDULE, short SH). Placed once, then follows the pits; typed-over cells are held with a padlock; rows for the council pit, a pump well and ticked plastic pits. 'Compare' is not a separate step because the schedule follows; the 'changed since last issue' list is later (D-187). **Evidence:** THE_PLAN section 3 item 7; D-103; D-109; D-110; D-187.

**FM-041.** **CDCHECK, CDCHECKCURRENT, CDDASHBOARD, CDHUB, CDRULES, CDCHECKS** (Civil; none in the records; 4 on the ribbon, 2 typed only): list every pit and pipe connection the drawing can prove and cannot; show what CE can read; design-check dashboard; read-only network health hub; check against the rulebook (velocity, grade, cover, pit drop). **Goes to:** (b) FOLDED IN: a self-check when a drawing opens, a status on every fact (Suits / Needs a look / Wrong, never blocking) and one Unfinished list shown on request and, as one quiet line, when plotting. A typed name CHECK / CK is only a draft name. **Evidence:** THE_PLAN section 3 (self-check on open); FOUNDATION block 6; D-140; D-142; D-176; D-188.

**FM-042.** **CDCHECKIGNORE, CDCHECKIGNOREAPPLY** (Civil; none in the records; typed only): hide one Checks finding with a reason (survey, council requirement, engineer's judgement), saved in the drawing; 'not switched on yet'. **Goes to:** (d) PROPOSED TO RETIRE: never switched on in the installed build. The idea (hide a finding with a reason) is not lost if Tim wants it: D-003 already asks for a short justifying note when two sources disagree. **Evidence:** D-003; PARTS_BIN item 18.

**FM-043.** **CDINSPECTOR** (Civil; 42 runs; on the ribbon): open the Inspector side palette for the picked CE thing. **Goes to:** (b) FOLDED IN: one thing's facts show in AutoCAD's own Properties palette under a CE heading; the CE side panel is for whole-job things; every window has an Inspect button. Not yet proven: the Properties route (THE_PLAN section 6a item 3). **Evidence:** D-048; D-065; THE_PLAN section 6a item 3.

**FM-044.** **CDFOCUS** (Civil; none in the records; typed only): bring CE windows back to the foreground. **Goes to:** (d) PROPOSED TO RETIRE: only needed because the old windows float behind the drawing. New windows have an Inspect button that hides and returns them with everything typed kept. **Evidence:** D-065.

**FM-045.** **CEFIND** (Civil; none in the records; typed only): type a pit id, source tag or pipe (P7, WT1, P3-P4) and CE zooms to it and highlights it. **Goes to:** (e) NOT DECIDED: the preview strip lights 'this object' in its run (D-167) but nothing gives a type-to-find. **Evidence:** D-167 (strip only).

**FM-046.** **CDRULEBOOK** (Civil; none in the records; typed only): set the project pit drop, council profile and cover override for the rule check. **Goes to:** (b) FOLDED IN: the drop across a pit is an office standard typed over per pit, the council is a job fact in the Job window, and a council cover figure never lowers the standard's minimum. **Evidence:** D-084; D-141; D-144; D-171.

**FM-047.** **CDCALC** (Civil; none in the records; on the ribbon): open the drainage calculations suite, which also makes the computations sheet as PDF or Excel. **Goes to:** (e) NOT DECIDED for the computations sheet: the sums are taken (D-095) and sit inside Detention and Pipe, and D-021 says the computations sheet prints from the same numbers, but no first-release tool prints it. Council calculators are parked (D-098). **Evidence:** D-021; D-095; D-098 (council calculators later); none for the computations sheet.

**FM-048.** **CDDESIGN** (Civil; none in the records; on the ribbon): review the drawing's design inputs and work out the design (nothing is drawn). **Goes to:** (a) NEW TOOL: the Job window (one window typed once per job: council, discharge, site areas, rainfall, top water level). Its typed name is not ruled (JOB is only a draft). The working out happens in the Pipe and Detention windows. **Evidence:** D-171 item 4; D-107; D-108; INPUT_AUDIT.

**FM-049.** **CDSETUP** (Civil; none in the records; typed only): old name for CDDESIGN (prints one line and opens CDDESIGN). **Goes to:** (d) PROPOSED TO RETIRE: old name of CDDESIGN; old names are gone from day one. **Evidence:** D-053.

**FM-050.** **CDRAINFALL** (Civil; none in the records; on the ribbon): show which rainfall curve the job is designed to and record the job's own coefficients from a text file or from what is copied. **Goes to:** (a) NEW TOOL: the Job window holds the rainfall table, one per job, shown 'assumed' until entered. Not covered: how a site's rainfall table arrives (Bureau table, pasted, or a text file) is an open question. **Evidence:** D-095 (rainfall data taken); INPUT_AUDIT item 8; D-171 item 4.

**FM-051.** **CDANNOTATIONEDIT, CDMA, CDTEXTSEG** (Civil; none in the records; 1 on the ribbon, 2 typed only): move, rotate, mirror or flip one label or arrow; move a flow arrow or pipe text to another segment. **Goes to:** (b) FOLDED IN: grips on the label parts move text, invert text and arrow along or across the line and flip the cover text; a hand-moved label keeps its offset from its pit or pipe. **Evidence:** D-037; D-014; D-181.

**FM-052.** **CDTIDYLABELS** (Civil; none in the records; on the ribbon): slide CE pipe labels, invert texts and arrows clear of other text on a sheet or a selection. **Goes to:** (b) FOLDED IN: each part sits at its standard spot and slides when labels clash. Not covered: a sheet-wide 'tidy afterwards' button is not mentioned. **Evidence:** D-041; D-012.

### Civil other (pavement, site, survey, imports, job set-up)

**FM-053.** **CDSLAB, CDSLABEDIT, CDSLABEREGEN, CDSLABFLOW** (Civil; none in the records; 1 on the ribbon, 3 typed only): design slab or hardstand falls (places fall symbols and spot levels), edit and regenerate a slab, show where a slab's water goes. **Goes to:** (e) NOT DECIDED: slabs are not in the first-release list and no decision parks them by name. Tim's rulings are only that slabs and size changes must be shown (D-049) and that nothing optional is ever forced (D-050); a draft name SLAB / SB exists. CDSLABEDIT is already labelled 'known unsafe' in the registry. **Evidence:** D-049; D-050 (rules only); none for the tools.

**FM-054.** **CDSLABIMPORT** (Civil; none in the records; on the ribbon): adopt a hand-drawn slab outline with its saw cuts and fall arrows into CE's records. **Goes to:** (c) PARKED with old-drawing take-up: taking up something drawn by hand is the take-up group (the plan says one line and a 'take it up' click, never automatic). **Evidence:** D-027; D-192; THE_PLAN section 3 (taking up old drawings not in the first release).

**FM-055.** **CDJOINT** (Civil; none in the records; on the ribbon): automatically draw a saw-cut joint grid on a slab outline, clipped to the slab, avoiding pits, with SC labels. **Goes to:** (e) NOT DECIDED: the shared joint tools (CONSTRUCTIONJOINT / CJ and SAWCUT / SSC) replace the civil joint commands but draw lines by hand. Nothing says the automatic grid survives; Tim said saw cuts are only drawn if the drafter draws them (D-050). **Evidence:** D-050; D-203; ST-09 (hand-drawn lines only).

**FM-056.** **CDCJ, CDSC** (Civil; none in the records; on the ribbon): draw one construction joint or one saw cut line with its label. **Goes to:** (a) NEW TOOL: Construction joint (CONSTRUCTIONJOINT, short CJ) and Saw cut (SAWCUT, short SSC), shared. Whole job covered with upgrades: dashes right at 1:100, bends, full-word label placed like 25T / 25B. How the label should 'learn' is still open. **Evidence:** D-203; ST-09; TA-025; TA-033; D-210.

**FM-057.** **CDSPOON, CDSPOONDRAIN** (Civil; none in the records; on the ribbon): draw a closed spoon drain outline inside a slab, or a spoon drain run with length and fall. **Goes to:** (e) NOT DECIDED: not in the first-release list. UI_PLAN lists 'spoon drain' as a wide-preview tool type; no decision brings it in. **Evidence:** none (UI_PLAN section 3 only).

**FM-058.** **CDKERB** (Civil; none in the records; on the ribbon): draw a two-point kerb line in the office legend style, with an optional label. **Goes to:** (e) NOT DECIDED: not in any decision. **Evidence:** none.

**FM-059.** **CDPAVE, CDCATCHMENT** (Civil; none in the records; on the ribbon): quick-hatch a paved area and record its pavement type for lid classes and catchments; show a grated pit's paved catchment as a light overlay and warn when it is too big. **Goes to:** (e) NOT DECIDED: site areas picked off the drawing are covered (D-107) and reading hatched roof and paving is planned later (D-171 item 5), but the paved-area tool and the catchment overlay with its warning are not mentioned. **Evidence:** D-107; D-171 item 5 (reading only); none for the tools.

**FM-060.** **CDTPZ, CDSRZ** (Civil; none in the records; on the ribbon): draw a tree protection zone or structural root zone marker circle on its layer. **Goes to:** (e) NOT DECIDED: not in any decision. **Evidence:** none.

**FM-061.** **CDSURVEY** (Civil; none in the records; on the ribbon): load a surveyor's drawing and store ground levels for cover level suggestions. **Goes to:** (c) PARKED with imports. Tim also ruled that a pit's cover level does not come from the survey (D-178); any help is only a suggestion (D-195). **Evidence:** D-178; D-195; PARTS_BIN item 20; THE_PLAN section 3.

**FM-062.** **CDIMPORTXCIVIL, CDIMPORTLANDXML, CDIMPORTCOMPARE, CDCHECKDWG** (Civil; CDIMPORTXCIVIL 9 runs (one PC); on the ribbon): bring in another civil package's drawing or a LandXML file after a review, compare imported data with the drawing, read-only check of a consultant's drawing. **Goes to:** (c) PARKED with imports. Tim reopened how existing projects are taken up (D-049) and said new jobs first (D-027). The old reader went wrong in August (lost the control pit, made 47 false pits from labels): keep its test cases, not its code. **Evidence:** D-027; D-049; PARTS_BIN item 20; R-007 section 1.

**FM-063.** **CDEXPORTENTITIES** (Civil; none in the records; on the ribbon): export entity geometry and schedule references. **Goes to:** (c) PARKED with imports (the export side of the same group). **Evidence:** PARTS_BIN item 20; R-007 section 1.

**FM-064.** **CDXREFCOMPARE, CDXREFREPAIR** (Civil; none in the records; typed only): compare a changed background xref with its previous version and list the pits, pipes and levels near what moved; find missing xref files in the job folder and repair paths (both also offered when a drawing opens). **Goes to:** (e) NOT DECIDED: nothing says whether the plug-in compares a changed architect's background or repairs xref paths. The 'changed since last issue' list is later (D-187). **Evidence:** D-187 (later); none for xref compare or repair.

**FM-065.** **CDNEWDWG** (Civil; none in the records; typed only): pick a job folder, discipline and sheet size, copy the office template in, name it from the job's drawings and fill the title block (2027 only). **Goes to:** (e) NOT DECIDED: Tim said drafters start a job 'from the office template' (D-191) but no tool is named; the title block part belongs to the title block and issue group, which is parked. **Evidence:** D-191 (a fact about practice); THE_PLAN section 3 (title block and issue parked).

**FM-066.** **CDDISCIPLINE** (Civil; none in the records; on the ribbon): view or set whether a drawing is Civil or Structural, keeping civil tools out of structural drawings. **Goes to:** (e) NOT DECIDED: three tabs are ruled, with the structural tab hidden until it has tools (D-208), but nothing says what stops a civil tool being used on a structural drawing. **Evidence:** D-208 (tabs only).

### Shared everyday tools (and the loose LISP files and tool palettes they come from)

**FM-067.** **CLEAN** (LISP; Structural; 26 runs; on the ribbon): Tim's everyday save: purge, tidy the xrefs onto the office xref layer, force text styles to standard, regenerate and save (the LISP file saves; the Structural registry text contradicts itself, see the sources section). **Goes to:** (a) NEW TOOL: CLEAN (short CN), first in order of importance. One tool, steps as ticks in a small window remembered from last time, one line printed afterwards. Adds: audit, zero stray Z heights, set the drawing units, then save. Still to do before building: measure what today's CLEAN does step by step and how long each step takes on a real drawing; make it quick enough for every save. **Evidence:** D-201; D-204; D-210; ST-01; TA-014; TA-020; TA-035; interview section 9 item 3.

**FM-068.** **FASTSAVE** (LISP; Structural; none in the records; on the ribbon): quick version of CLEAN that also saves. **Goes to:** (b) FOLDED IN: no own command; CLEAN is one tool. **Evidence:** ST-01; D-204 ('should be one tool').

**FM-069.** **MTS** (LISP; Structural; none in the records; on the ribbon): merge text styles into one. **Goes to:** (b) FOLDED IN: a step of CLEAN (today's MTS). **Evidence:** ST-01.

**FM-070.** **LU** (LISP; Structural; under 8 runs; on the ribbon): bring the office layers and styles in by inserting a settings block, then purge it. **Goes to:** (b) FOLDED IN: a step of CLEAN (today's LU). **Evidence:** ST-01.

**FM-071.** **XRL, XRLFAST, XRLSILENT, XRLCONFIG, XRLINFO, XRLHELP** (LISP; Structural; none in the records; on the ribbon): put xrefs on the office xref layer and tidy their layers, with fast, silent, settings, information and help variants. **Goes to:** (b) FOLDED IN: a step of CLEAN (today's XRL). Not covered: the settings and information variants are not mentioned; they become ticks in the CLEAN window at best. **Evidence:** ST-01.

**FM-072.** **CXREF, PXREF** (Structural; none in the records; on the ribbon): copy and paste xref data (workflow to carry things across xrefs). **Goes to:** (a) NEW TOOL: Xref copy and paste (ST-13; name to be given by the same naming rule). Whole job covered as a tool Tim ticked; its design is still to be interviewed. **Evidence:** D-209; TA-029; ST-13.

**FM-073.** **LD, AD, QD, DUP** (LISP; Structural; LD 133 runs, QD 12, AD under 8; on the ribbon): linear dimension, aligned dimension, dot leader (all on the office dimension layer and style), and switch dimensions from the 1:20 set-up to 1:100. **Goes to:** (a) NEW TOOL: Dimensions and leaders (shared): LD, AD, QD and DUP kept. Dimension size follows the viewport and must also update dimensions already drawn. Brought across as they work today, one copy only. **Evidence:** D-201; D-210; ST-02; TA-004; TA-039; D-194.

**FM-074.** **Q** (LISP; Structural; 32 runs; on the ribbon): leader with a closed filled arrow. **Goes to:** (a) NEW TOOL: the arrow leader becomes QL; Tim keeps his own Q alias. **Evidence:** TA-021; D-208; ST-02.

**FM-075.** **CE_ARCDIM, RD** (Structural; none in the records; on the ribbon): arc, radius or diameter dimension. **Goes to:** (a) NEW TOOL: Arc dimension in the shared Dimensions tool (the one new thing Tim asked for). Name proposed ARCDIM / RD, not yet ruled. **Evidence:** TA-004; ST-02; D-201.

**FM-076.** **DSET, DSET1** (LISP; Structural; none in the records; on the ribbon): set the measuring factor on picked dimensions; convert dimension measurements to one fifth. **Goes to:** (e) NOT DECIDED: the dimension tool's description lists LD, AD, QD, DUP and the arc dimension but not DSET or DSET1. Tim said dimensions 'work fine'; whether the measuring-factor tools were meant to stay is not recorded. **Evidence:** none (ST-02 omits them).

**FM-077.** **MR, MOVEROT, CR, COPYROT** (LISP; Civil (typed only); Structural; CR under 8 runs; typed only): move the picked objects then rotate them at the new spot (MR); copy then rotate the copy (CR). **Goes to:** (a) NEW TOOL: Move and rotate (MR, long name MOVEROTATE proposed) and Copy and rotate (CR, COPYROTATE): exactly one copy of each (today five homes). No upgrades asked ('fine as they are'). **Evidence:** D-201; ST-03; TA-036; TOOLS_TODAY T-024.

**FM-078.** **C** (LISP; 355 runs (April, two PCs; recorded as a structural shortcut); typed only (loose file)): AutoCAD COPY forced to repeat ('multiple'). **Goes to:** (d) PROPOSED TO RETIRE (already ruled by Tim): 'Retire it, use Copy'. Replaced by AutoCAD's own Copy, which repeats until Enter. **Evidence:** D-203; TA-005; D-054.

**FM-079.** **COPYMULTI, COPYM, CEMCOPY** (Civil; Structural; none in the records; 2 on the ribbon, 1 typed only): longer names for the repeat copy that C ran. **Goes to:** (d) PROPOSED TO RETIRE: the same job as C, which Tim retired in favour of AutoCAD's own Copy. **Evidence:** D-203; TA-005.

**FM-080.** **CPB** (LISP; Structural; 10 runs; on the ribbon): copy the picked objects and paste them back as one block on a blocks layer. **Goes to:** (a) NEW TOOL: Copy as block (CPB, long name COPYASBLOCK proposed). Upgrades suggested in the interview, then Tim said 'fine as they are' (TA-036); today the block is named by date and time (two such blocks already sit in the office master drawing). **Evidence:** D-201; ST-04; TA-036.

**FM-081.** **DIV, DIVX** (LISP; Structural; DIV 10 runs; on the ribbon): divide a line with cross marks (DIV) or with a block (DIVX). **Goes to:** (a) NEW TOOL: Divide (kept; name not yet settled). Upgrades: follows bends and arcs, the cross is sized for the sheet, previews the marks and reports the spacing. End offsets and numbering each one were not wanted. **Evidence:** TA-022; TA-032; ST-05; D-201.

**FM-082.** **MD** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): offset the picked objects repeatedly between two picked points at a set maximum spacing. **Goes to:** (e) NOT DECIDED: it is in no interview and no decision. **Evidence:** none.

**FM-083.** **10H, 141H, 201H, 21DH, 21H, 21LH, 238H, 242H, 31H, 51H, 74H, 9DH, BLH, CH, EH, LBH, LBUH, PH, WH, 11BH, 11CH, 11FH, 11IH, 121H, 138H, 140H, 150H, 174H, 213H, 231DH, 253EH, 253H, 47PH, 47TH, 6DH, 6H, 8H, CEHATCH** (LISP; Structural; 21H 9 runs; on the ribbon): about 40 number-named and letter-named hatch commands, each laying one office hatch (pen colour, pattern, scale) for the drawing, plus CEHATCH that chooses and places a standard hatch visually. **Goes to:** (a) NEW TOOL: one hatch window (OFFICEHATCH, short OH). Tim ruled 'too many names' and 'wrong scale'; every hatch the tool makes is always linked to its outline. WHICH of these hatches survive is not decided: Tim is to tick them from a visual list (TA-045); until then the window's list is empty of decisions. **Evidence:** D-201; TA-003; TA-044; TA-045; TA-046; ST-06; D-199 (grips and hatch behaviour researched first).

**FM-084.** **H2A** (LISP; Structural; none in the records; on the ribbon): re-attach hatches to their outlines. **Goes to:** (b) FOLDED IN: every new hatch is always linked (associative) to its outline, so re-attaching is not a separate command (the interview said it 'becomes a button in the same window or goes'). **Evidence:** TA-046; ST-06.

**FM-085.** **CEHATCHCHANGE, CEHATCHBATCH, CEHATCHGAP, CEHATCHAUDIT** (Structural; none in the records; on the ribbon): change selected hatches to another office preset; apply one preset to many closed outlines; hatch through small gaps in a boundary; report or repair non-standard hatches. **Goes to:** (e) NOT DECIDED: the one hatch window is described as picking a hatch from a named list and laying it at the right scale; none of these four jobs is mentioned. **Evidence:** none (ST-06 does not mention them).

**FM-086.** **RC** (LISP; Structural; 9 runs; on the ribbon): rectangular revision cloud at the office arc size; asks about object snap first, then returns to the layer you were on. **Goes to:** (a) NEW TOOL: Revision box (REVBOX, short RV). Keeps its snap question; can now cloud round any picked shape. **Evidence:** D-203; TA-008; TA-024; TA-040; ST-07.

**FM-087.** **BL** (Structural; none in the records; on the ribbon): draw the office break line symbol. **Goes to:** (a) NEW TOOL: Break line (BREAKLINE, short BL; Tim moves his own Bl alias). It now trims the lines it crosses. **Evidence:** TA-023; D-208; TA-040; ST-08.

**FM-088.** **CJ, SSC, SCC** (LISP; Structural; SSC 21 runs; on the ribbon): draw a construction joint line and label (CJ), or a saw cut line and label (SSC; SCC is the older LISP spelling). **Goes to:** (a) NEW TOOL: Construction joint (CONSTRUCTIONJOINT, short CJ) and Saw cut (SAWCUT, short SSC). Fixes asked for: dashes right at 1:100, joint lines with bends, the label in full words placed like 25T / 25B depending on what is around; a hand-moved label keeps its offset. How the label should 'learn' from issued sheets is still open. **Evidence:** D-203; D-210; TA-025; TA-033; ST-09.

**FM-089.** **CJSS** (Structural; under 8 runs; on the ribbon): swap construction joint and saw cut lines and labels. **Goes to:** (e) NOT DECIDED: the joint tool description does not mention swapping a joint between construction joint and saw cut. **Evidence:** none (ST-09 omits it).

**FM-090.** **18B, 18L, 18R, 18T, 25B, 25C, 25L, 25LC, 25R, 25RC, 25T** (LISP; Structural; 18B, 18T, 25C under 8 runs each; on the ribbon): place ready text at 1.8 mm or 2.5 mm: below, above, left, right, centred, horizontal left or right. **Goes to:** (a) NEW TOOL: Text 25 and 18 set (names kept, plus a TEXT window for size, side and angle that remembers the last used). **Evidence:** D-209; TA-028; TA-034; ST-11.

**FM-091.** **SL25C, SL25CTR, SL25D, SL25H, SL25P, SL35C, SL35CTR, SL35D, SL35H, SL35P, SL50C, SL50CTR, SL50D, SL50H, SL50P, SL70C, SL70CTR, SL70D, SL70H, SL70P, SLALL** (Structural; none in the records; on the ribbon): make the layer for that pen width and line type current (0.25, 0.35, 0.50, 0.70 pen; continuous, centre, dashed, hidden, phantom); SLALL matches a picked object then starts LINE. **Goes to:** (a) NEW TOOL: Pen quick-set (ST-12), ticked by Tim; its names are to be given by the same naming rule. **Evidence:** D-209; TA-029; ST-12.

**FM-092.** **SCAB, SCABBLE** (Structural; none in the records; on the ribbon): draw the scabble line symbol. **Goes to:** (b) FOLDED IN: small office symbols (scabble, wipeout, cut tube) are placed from the Blocks palette, with no own command. **Evidence:** TA-031; ST-18.

**FM-093.** **CDD, CDD3, CDDE, CDD-VERSION, CDD-OSNAP** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): draw a drainage pipe with size, grade, invert text and flow arrow (the 11,540-line file dated Nov 2025), its variants and its version and snap helpers. **Goes to:** (d) PROPOSED TO RETIRE: a third way to draw a drainage pipe beside CD in the Civil program and the older LISP CD; the new Pipe tool replaces all of them. Real use in the office is Unknown (loose LISP is not recorded). **Evidence:** TOOLS_TODAY T-015; THE_PLAN section 3 item 2.

**FM-094.** **CD (older LISP 'Civil Pipe Creation', in a personal sub-folder)** (LISP; not recorded (loose LISP is not tracked); not on a ribbon): older drainage pipe command, six copies, all in old folders. **Goes to:** (d) PROPOSED TO RETIRE: duplicate of the plug-in's CD (and of CDD). It also shares a typed name with the plug-in's CD, so which one answers is Unknown. **Evidence:** TOOLS_TODAY T-015; THE_PLAN section 3 item 2.

**FM-095.** **CDDS, CDD-SETTINGS, SETOFFSET, SETODIST, GETODIST, SETCVLODIST, GETCVLODIST** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): settings for the LISP pipe command and remembered text offset distances. **Goes to:** (b) FOLDED IN: offsets and sizes are standards on the office list (a setting, normally always the same). **Evidence:** D-012; D-013; FOUNDATION block 5.

**FM-096.** **CDDA, MFA, CDD-MOVE-ARROW** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): move the flow arrow along the pipe. **Goes to:** (b) FOLDED IN: the arrow has its own grip and moves along or across the line. **Evidence:** D-037; D-041.

**FM-097.** **TBDRAIN-INPUT** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): older pipe-data input dialog. **Goes to:** (d) PROPOSED TO RETIRE: duplicate of the Pipe window. **Evidence:** TOOLS_TODAY T-015.

**FM-098.** **CIVILEXCELMTEXT** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): bring a civil pit schedule from a CSV file into drawing text. **Goes to:** (e) NOT DECIDED: the new Pit schedule is placed once and then follows the pits (D-109), so it does the same job another way, but nothing says whether bringing in a spreadsheet's rows is still wanted. **Evidence:** D-109 (schedule follows the pits); none for importing a spreadsheet.

**FM-099.** **EXCELMTEXT, XCLMTXT, EXCELMTEXTNEW, XCLMTXTINDEX, VALIDATECSV, FIXCSV, CREATETEMPLATE, EXCELHELP, EXCELLOAD, EXCELMAPFLOOR, EXCELMAPFLOORAREA, EXCELCAPTUREAREA, EXCELCAPTURESELECTION** (LISP; Structural; none in the records; 6 on the ribbon, 2 typed only): bring a member schedule from Excel into drawing text, with the helpers that check and fix the CSV, make the template and assign drawing areas to floors. **Goes to:** (c) PARKED with structural-only: Tim did not tick 'Excel into text / schedule' as a shared tool (the two interview lists), so it stays with the structural program. **Evidence:** TA-002; TA-030; D-006; CX-03.

**FM-100.** **EXCELMODULES, EXCELRESET, EXCELSTATUS, CHECKCONFIG, SELECTFILE, SETBASEPOINT, CREATEMTEXT, CREATEWIPEOUTBLOCKS, CREATEDOUBLEWIPEOUT, TOGGLEBGWIPEOUT** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): build steps and switches of the Excel importer (modules 1 to 10): status, reset, file picker, base point, text and wipeout block creation. **Goes to:** (d) PROPOSED TO RETIRE: development steps of the Excel importer, not staff tools. **Evidence:** TOOLS_TODAY T-014 (names not itemised there).

**FM-101.** **TESTBASICTEXT, TESTADVANCEDFORMAT, TESTSPECIALCASES, TESTTITLEFORMAT, TESTFILEOPS, TESTCSVPARSE, TESTDEPTHANALYSIS, TESTWIDTHCALC, TESTPOSITIONING, TESTMTEXTCREATE** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): test routines for the Excel importer modules. **Goes to:** (d) PROPOSED TO RETIRE: developer test routines. **Evidence:** none (found only in the shared LISP folder).

**FM-102.** **CHECKWIPEOUTBLOCK, TESTWIPEOUTBLOCKS, CHECKDOUBLEBLOCKS, TESTDOUBLEWIPEOUT, TXTDEBUG, CRHELP, SUPDEBUG** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): check and test routines for wipeout blocks, text tags, move-rotate help and support blocks. **Goes to:** (d) PROPOSED TO RETIRE: developer check, test and debug routines. **Evidence:** none (found only in the shared LISP folder).

**FM-103.** **TP** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): show one group of tool palettes (CIVIL, FRAMING, GROUND, SECTIONS). **Goes to:** (e) NOT DECIDED: Tim said regular tool palettes 'just work better' but are slow to edit; the new Blocks palette is to replace the palette sets, yet nothing says the group switcher goes. **Evidence:** TA-010; ST-10 (palette, not the switcher).

**FM-104.** **3DF2L** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): turn 3D faces into lines (a third-party tool whose prompts are not in English). **Goes to:** (e) NOT DECIDED: not in any interview or decision. **Evidence:** none.

**FM-105.** **<owner first name> (in NEW.lsp), CDJ, TEXTONANGLELEFT, TEXTONANGLERIGHT, TEXTONLINE** (LISP; not recorded (loose LISP is not tracked); typed only (loose file)): typed names found in personal-folder LISP files (NEW.lsp, DEFUN COMMANDS 2.lsp, TEXT INSERT.lsp); purpose not found. **Goes to:** (e) NOT DECIDED: purpose not found and not mentioned in TOOLS_TODAY or any decision. The three TEXT names suggest text placed at an angle or on a line, which may overlap the new TEXT window. **Evidence:** none.

**FM-106.** **(no typed name: the old menu file TB2024.MNU and the bought-in structural toolkit it calls)** (LISP; not applicable; not on a ribbon): an old-style menu (4 pull-downs, about 30 toolbars) that calls 903 routines of a bought-in structural toolkit kept in the IT folder. **Goes to:** (e) NOT DECIDED: whether anyone still loads this menu is Unknown (TOOLS_TODAY T-018); nothing in the plan mentions it. **Evidence:** none.

**FM-107.** **(no typed name: the current tool palette set, 17 palettes, 358 block tools, 10 Dec 2024)** (Palettes; not recorded (palette drags are not tracked); not on a ribbon): blocks dragged from the office master drawing: pit, downpipe, overflow, inspection opening, floor waste, trench grate, level and invert tags, hatches, notes, schedules, title sheets. **Goes to:** (a) NEW TOOL: Blocks palette (BLOCKS / BLK), built from one office list read from the master drawing, replacing the palette sets. Not covered: which of the 453 master blocks (279 machine-named) stay is Tim's later decision. **Evidence:** ST-10; TA-010; TA-038; TA-042; D-211.

**FM-108.** **(no typed name: the 'NEW' palette set, 12 palettes, 307 block tools, 24 Sep 2026)** (Palettes; not recorded; not on a ribbon): a regrouped copy of the current set (BLOCKS CIVIL and BLOCK CIVIL 2 have identical tool lists). **Goes to:** (b) FOLDED IN: one Blocks palette from one list; a regrouped copy is not carried across. **Evidence:** ST-10; TOOLS_TODAY T-020.

**FM-109.** **(no typed name: 'OLD TOOL PALETTES', 43 palette files, 2022 to Sep 2024)** (Palettes; not recorded; not on a ribbon): earlier versions of the palette set, several with duplicates. **Goes to:** (d) PROPOSED TO RETIRE: earlier versions of the current set. **Evidence:** TOOLS_TODAY T-021.

### Structural

**FM-110.** **CEPALETTE, CETOOLS, CETOOLSTOGGLE** (Structural; CETOOLS under 8 runs; on the ribbon): a command hub palette (CETOOLS) and a fuzzy search that finds and runs any CE command (CEPALETTE). **Goes to:** (d) PROPOSED TO RETIRE: replaced by the three tabs and ribbon tips (D-200); Tim did not tick 'command search' as a shared tool (TA-031); CETOOLS has under 8 recorded runs. **Evidence:** D-200; TA-031; TOOLS_TODAY T-033.

**FM-111.** **STRUCEXPORTPDF** (Structural; none in the records; on the ribbon): plot the current layout to a PDF file (the only plot-to-PDF command found in any CE plug-in). **Goes to:** (c) PARKED with title block and issue: Tim did not tick plot to PDF as a shared tool (TA-030); title block and issue is not in the first release. **Evidence:** TA-030; D-097; THE_PLAN section 3; TOOLS_TODAY T-046.

**FM-112.** **CEARCHREVIEW, CEMARKUP, CEMARKUPBENCH, CEMARKUPCHECK, CEMARKUPDWGEXPORT, CEMARKUPLOAD, CEMARKUPPARSE, CEMARKUPPLAN, CEMARKUPPREVIEW, CEMARKUPREGISTER, CEMARKUPRUN, CEMARKUPSTATUS, CEMARKUPUNDO, CEMARKUPVIEW** (Structural; none in the records; 13 on the ribbon, 1 typed only): markup review: read a markup PDF, plan, preview and apply changes group by group, undo the last group, check reading accuracy, set a drawing for markup, review architectural changes, export drawing standards for markup. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; Structural Level 3 plan (docs, 5 Sep 2026); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-113.** **STRIPLAYERSMERGE, STRUCLINKTEXT** (Structural; none in the records; on the ribbon): two utility commands whose registry text says only 'Run utility command ...' (strip layers merge, link text); purpose not found. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-114.** **CECHECKLIST, CENOTES** (Structural; none in the records; on the ribbon): the job checklist (23 templates) and the shared notes workspace across all users and jobs. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-115.** **CESTRUC, CE_STRUC_SUITE** (Structural; CE_STRUC_SUITE 33 runs; on the ribbon): the Structural command window (CE_STRUC_SUITE, 33 runs in the records) and its palette. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-116.** **CEPROJECTPROPS, CEPROPS, CESHEETS, CESHEETSCLASSIC, CESHEETSMANAGER** (Structural; none in the records; on the ribbon): drawing sheets list and manager, project drawing properties. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-032; Manager's Project / Sheets page dropped (MG-06).

**FM-117.** **JOBTIMEREDIT** (Structural; none in the records; on the ribbon): edit recorded job time. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-072 (time counted by itself, with a check); THE_PLAN section 3 (job tracking hand-over not in the first release).

**FM-118.** **CE_INSPECT** (Structural; none in the records; on the ribbon): inspect selected objects. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-119.** **CE_MLEADERLEFT, CE_MLEADERRIGHT, MLL, MLR** (Structural; none in the records; on the ribbon): left and right multileader callouts (MLL, MLR). **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** TA-028 (Tim did not tick multileaders as shared tools); D-006.

**FM-120.** **CENTERLINE, CENTRELINE, CE_FFL, CE_LEVELMARK, CE_LEVELUPDATE, CE_NGL, CE_RL, CE_SECTIONMARK, CE_SSL, CL, CLINE, FFL, FFLMARKER, FLMK, LM, LMU, NGL, RL, SECTION, SM, SSL** (Structural; none in the records; on the ribbon): level marks (FFL, RL, SSL, NGL and batch level update), section marks with bubbles, centreline symbol. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** TA-001; TA-028 (not ticked as shared tools); D-006.

**FM-121.** **CHECKML, CML, ML, SML** (Structural; LISP; none in the records; on the ribbon): closed-end and standard multilines, draw multiline, check the current multiline style. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** TA-028 (Tim did not tick multilines as shared tools); D-006.

**FM-122.** **CSBOXNOTES, CSGENNOTES, CSLEADERNOTE** (Structural; none in the records; typed only): office boxed notes, general notes (S01) and leader notes from the office notes library. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-123.** **CSSLABSTEP** (Structural; none in the records; typed only): the STEP symbol, level tags and the magenta slab step line where two slab areas change level. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-124.** **BEBB, BEBT, BIBB, BIBT, BPCL, BPCR, BPFCL, BPFCR, BPL, BPR, BSFB, BSFCB, BSFCT, BSFT, BTHCL, BTHCR, CL1, CR1, DSL, DSR, EBB, EBT, IBB, IBT, PCL, PCR, PFCL, PFCR, PFL, PFR, R2LTXT, SFB, SFCB, SFCT, SFT, SL, SR, THCL, THCR, THL, THR, TSL, TSR** (Structural; LISP; none in the records; on the ribbon): about 45 structural text tags: edge and internal beam, strip footing, slab thickening, pad footing, bored pier, column, stiffener, double and triple stud tags, left and right, over and under, with and without the footing outline. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-010.

**FM-125.** **1, 1A, 2, 2A, 4, 4A, 5, 8, BDL, BEXT, BEXTEND, BMT2TXT, BPC, BPFC, BSET, BSETLIST, BSETRESET, BSFC, BTHC, BTX, BTXT2MT** (Structural; LISP; none in the records; 16 on the ribbon, 2 typed only): beam placement and labels (1, 2, 4, 5, 8; paired beams), extend beam, inside-point commands, beam text conversion and the column, pad footing and strip footing over-tags. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-012.

**FM-126.** **AB, ABBLOCKS, ABCHECK, ABCOMPARE, ABDEBUG, ABFLIPAUTO, ABS, ABSWITCH, ABTEST, BB, BT1, CSBRACINGPANEL, CSBRACINGREQUIRED, STRUCAB, STRUCABS, STRUCBB** (Structural; LISP; none in the records; on the ribbon): A and B wall bracing, flip labels, switch types, bracing panel (provided against required). **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-013.

**FM-127.** **C1, C2, CEAUTOSUPPORT, CEAUTOSUPPORTCLEAR, CEAUTOSUPPORTREF, CEAUTOSUPPORTREFCLEAR, DS, DS1, ICA, IDS, IDSA, ITSA, LBW, SC1, SC2, SCA, SDS, SDS1, SDSA, STS1, STSA, SUPTEXTAUTO, TC1, TDS, TDS1, TS1, TTS1** (Structural; LISP; C1 under 8 runs; DS under 8 runs; 16 on the ribbon, 4 typed only): column and stud support markers (columns, double and triple studs), changing one support type to another, automatic support proposals, load-bearing wall. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-011.

**FM-128.** **FJ1, P1, R1, RJSET** (Structural; none in the records; on the ribbon): rafter and joist blocks, purlin marker, their settings. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-129.** **CSFLOORSETOUT** (Structural; none in the records; typed only): floor bay joist or bearer span arrow. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-130.** **CSROOFSETOUT** (Structural; none in the records; typed only): roof area rafter or truss span arrow. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-131.** **CSLEVELCARRY, CSPLANLEVEL, CSPOINTLOAD** (Structural; none in the records; typed only): plan level, carry the level above down, roof point loads. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-132.** **CSFRAMINGLEGEND, CSLINTELPROPOSE** (Structural; none in the records; typed only): framing plan legend, lintel proposals. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-133.** **CSLINTELTABLE, CSMEMBERSCHED, CSWALLMARK, CSWALLSCHEDULE** (Structural; none in the records; typed only): lintel table, member schedule, wall marks and wall schedule. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-134.** **CSSOILREPORT, CSUNITCOPY, CSUNITTAGS, CSUNITTOOLS, CSWINDCLASS** (Structural; none in the records; 2 on the ribbon, 3 typed only): geotechnical report, wind class, copy one unit's framing to other units with renumbered tags. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-135.** **BATLINE, BATTER** (Structural; none in the records; on the ribbon): batter lines between top and bottom curves. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-136.** **CSTIEDOWN, CSTIEDOWNTYPES** (Structural; none in the records; on the ribbon): tie-down symbols and their types. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-137.** **CSSUBFLOORGRID, CSSUBFLOORSET, CSTAGBEARERS** (Structural; none in the records; typed only): timber subfloor bearer, stump and pier grid, defaults and span table, tag hand-drawn bearers. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-138.** **CESTRUCGRIPEDIT** (Structural; none in the records; typed only): clicking a CE grip on a column or beam: move it with a live preview. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-139.** **CSFOOTINGGRIPEDIT** (Structural; none in the records; typed only): clicking a CE grip on a pad, thickening, strip footing or raft beam. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-140.** **FPFC, FSF, PFC, SCREWPILE, SF, SFC, STUMPFOOTING, THC** (Structural; PFC under 8 runs; on the ribbon): registered footing elements: pad, strip, thickening and their outline-and-tag commands, screw pile, stump footing. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-141.** **BP, CSPIER, SPW, SPW3, SPW6, SPWC** (Structural; LISP; none in the records; on the ribbon): bored piers (450, 300, 600, with concrete hatch), pier rows with automatic mark and centres dimension. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'; TOOLS_TODAY T-008.

**FM-142.** **FTHC, REB, RIB** (Structural; none in the records; on the ribbon): registered raft elements: thickening, external beam, internal beam. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-143.** **CSFDNPROPOSE, CSLOADPATH, CSMARKSRENUMBER, FADOPT, FDELETE, FEDIT, FREGEN, FREGENALL** (Structural; none in the records; 7 on the ribbon, 1 typed only): foundation system management: footing proposals, load path check, renumber marks, adopt, delete, edit, regenerate. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-144.** **CSFOOTINGLEGEND, CSFOOTINGSCHEDULE, CSINFILL, CSRCBEAMSCHEDULE, FST, FSTEXPORT** (Structural; LISP; none in the records; 2 on the ribbon, 4 typed only): footing sizes manager window, footing and R.C. beam schedules, footing legend, infill slab. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-145.** **CSBSMTWALL, CSPUMPPIT, CSPUMPPITSCHEDULE** (Structural; none in the records; on the ribbon): basement wall system, basement pump pit with a charged main, pump pit schedule. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-146.** **BARWEIGHT, BWT, CE_BARWEIGHT, CE_REBARCIRCLE, CE_REBARLINE, CE_STIRRUP, CSBARSCHEDULE, CSREOBAR, RB, RBC, RBL, REBAR, REBARCIRCLE, REBARLINE, STIRRUP, STR** (Structural; none in the records; 8 on the ribbon, 8 typed only): rebar: bar weight, circular bar layouts, rebar lines, stirrup symbols, reo bar extent with the office bar note, the bar schedule. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-147.** **STRSCHEDCREATE, STRSCHEDREFRESH, STRSCHEDSYNC** (Structural; none in the records; on the ribbon): create, refresh and synchronise a schedule. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-148.** **CE_MEMBERLABEL, LABEL** (Structural; none in the records; on the ribbon): leadered member label. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-149.** **CEMEMBER, RCBEAM, SBEAM, SBEAMEDIT** (Structural; none in the records; 3 on the ribbon, 1 typed only): steel and R.C. beam section details, the CEMEMBER steel member drawing, editing an owned section. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-150.** **RCCIRCCOL, RCRECTCOL** (Structural; none in the records; on the ribbon): circular and rectangular concrete column sections. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-151.** **COLTIES, LIGS, WALLREO, WALLSTRS** (Structural; none in the records; typed only): column ties, stirrup and ligature details, wall reinforcement. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-152.** **BSSLAB** (Structural; none in the records; typed only): reinforced concrete slab cross-section. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-153.** **ANGLES, BASEDET, BOLTS, BRACE, GUSSETS, KNEE, PORTAL, PPURLINS, PURLINS, RIDGE, STLCONN, STLCONN1, STLCONN3, SWBRACE, SWELD, TRUSS** (Structural; none in the records; 1 on the ribbon, 15 typed only): steelwork details: angles, base plates, bolts, bracing, gussets, knee, portal frame, purlins, ridge, connections, truss, weld ticks. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-154.** **CEEXPORTNOTES, STRUCEXPORTBLOCKS, STRUCEXPORTCSV** (Structural; none in the records; on the ribbon): exports: bracing and pier schedules to Excel, blocks, drawing notes to Markdown or HTML. **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

**FM-155.** **CEADMIN** (Structural; none in the records; on the ribbon): the central admin and diagnostics entry (CEADMIN). **Goes to:** (c) PARKED with structural-only: waits until structural is unparked (D-006); shared tools are in, structural-only tools stay parked. **Evidence:** D-006; CX-03 (shared tools in, structural-only tools stay parked); TOOLS_AND_MANAGER_INTERVIEW 'Not shared tools'.

### Manager, updates and settings

**FM-156.** **CEMANAGER** (Manager; 68 runs (3 PCs); on the ribbon): open the CE Suite Manager home screen with its eight pages. **Goes to:** (a) NEW TOOL: the small Manager (updates and version, health and fault report, office lists, job link, one admin page). Its typed name is not ruled. Pages left out on purpose: Status, Settings, Help, Project / Sheets, Project QA, Survey Intake, Drawing Repair (no drawing tools in the Manager). **Evidence:** D-204; MG-01 to MG-06; TA-011; TA-012.

**FM-157.** **CE_VERSION** (Manager; 63 runs; on the ribbon): show the exact loaded CE versions, paths and status. **Goes to:** (a) NEW TOOL: Manager, updates and version: it says which version is running. **Evidence:** MG-01; TA-011.

**FM-158.** **CEHEALTH** (Manager; 29 runs; on the ribbon): run a plain-English health check on all installed CE plug-ins. **Goes to:** (a) NEW TOOL: Manager, health and fault report ('one button for something is wrong'). **Evidence:** MG-02; TA-011.

**FM-159.** **CESUPPORT, CEMANAGERDIAG** (Manager; none in the records; on the ribbon): zip the CE logs and diagnostics on this PC; write a plain-English diagnostic report. **Goes to:** (a) NEW TOOL: Manager, health and fault report. The fault report keeps the scrub of private text before logs leave the PC (parts bin item 29); log file names must stop carrying client or job names. **Evidence:** MG-02; PARTS_BIN item 29.

**FM-160.** **CEMANAGERUPDATES** (Manager; under 8 runs; on the ribbon): open the administrator dashboard focused on approved releases and rollout state. **Goes to:** (a) NEW TOOL: Manager, updates and version: a new version is offered when AutoCAD starts, one click to install or go back with no administrator rights, plus one admin page with one 'approve for everyone' button. No canary rollout page. **Evidence:** MG-01; MG-05; D-028; TA-013.

**FM-161.** **CEMANAGERADMIN** (Manager; 10 runs; on the ribbon): open the administrator dashboard (usage, machines, failures, updates, policies, support bundles). **Goes to:** (a) NEW TOOL: Manager, one admin page that only Tim sees (each PC's version, faults this week, one approve button), PART only. Left out on purpose: usage, machines, policies and canary pages (statistics and wider admin control are future ideas). **Evidence:** MG-05; TA-013; D-205.

**FM-162.** **CEMANAGERREFRESH** (Manager; under 8 runs; on the ribbon): re-check what is installed, send waiting usage reports and rebuild the ribbon. **Goes to:** (b) FOLDED IN: the Manager checks for a new version when AutoCAD starts. Sending usage reports is a separate open point (see the records-writer line). **Evidence:** MG-01; D-028.

**FM-163.** **CEMANAGERLOGS** (Manager; 9 runs; on the ribbon): open the CE support data folder for this machine. **Goes to:** (e) NOT DECIDED: the fault report collects the logs, but nothing says a drafter can open the logs folder. **Evidence:** MG-02 (collects logs only).

**FM-164.** **CESURVEYREVIEW** (Manager; under 8 runs; on the ribbon): open the Manager at the survey just brought in with CDSURVEY so it can be checked before use. **Goes to:** (c) PARKED with imports: the Manager takes no survey intake page; it goes with the survey import. **Evidence:** MG-06; TA-012; D-178.

**FM-165.** **CEBLOCKS** (Manager; Structural; 1,017 runs (985 from one PC in Oct to Nov that looks like a test PC; 32 from two PCs in April); on the ribbon): open the office blocks palette; picking a block there places it. **Goes to:** (a) NEW TOOL: Blocks palette (BLOCKS, short BLK): built from one office list read from the office master drawing, so adding a block is one line; blocks with a CE tool are placed by that tool. Which of the 453 master blocks stay is Tim's decision after the look-through (D-211). **Evidence:** D-208; ST-10; TA-010; TA-037; D-211.

**FM-166.** **CEBLOCKINSERT** (Manager; none (the palette runs it); typed only): place the block you clicked in the CE Blocks palette (typing it does nothing). **Goes to:** (b) FOLDED IN: the Blocks palette places the block itself; no helper command. **Evidence:** ST-10.

**FM-167.** **CDS, CESETTINGS** (Civil; Structural; none in the records; on the ribbon): open your CE defaults on this PC (drafting, pipes and pits, design checks, survey, display), and Structural's CE Settings. **Goes to:** (b) FOLDED IN: values live in one office list of standards, edited by the administrator in the Manager; the window opens already filled in with what was used last. Not covered: per-PC personal defaults are not mentioned. **Evidence:** D-013; D-060; THE_PLAN section 3 (the office list of standards); MG-03.

**FM-168.** **CDMANAGER, CEADMINSETTINGS, CEADS, CDLABELSTYLE** (Civil; Structural; none in the records; 3 on the ribbon, 1 typed only): open the CE drafting standards manager (layer colours, draw order, label styles); CDLABELSTYLE is the old name folded into CDS. **Goes to:** (b) FOLDED IN: one office list of standards (layers, colours, text sizes, label offsets), edited in the Manager. The plug-in never edits Tim's own alias file (D-170). **Evidence:** D-013; D-012; MG-03; PARTS_BIN item 7.

**FM-169.** **CDPARTS** (Civil; none in the records; on the ribbon): open the civil parts and materials catalogue. **Goes to:** (b) FOLDED IN: sizes, materials and grades are lines in the office list (material and grade are pick-or-type); the tank library data is taken. **Evidence:** D-079; D-095; FOUNDATION block 5.

**FM-170.** **CDHELP, CESTARTHERE, CEHELP, CE_HELP, ?CE** (Civil; Structural; CDHELP under 8 runs; on the ribbon): open the help centre or the 2-minute picture tour of the CE tab, or browse command documentation. **Goes to:** (e) NOT DECIDED: no decision covers in-plug-in help or a tour. The old help pages describe the old commands. Every ribbon button will show its short name in its tip (naming rule). **Evidence:** none (NAMING_DRAFT rule 7 only).

**FM-171.** **CDFEEDBACK, CDDIAG, CDTRIAGE** (Civil; none in the records; 2 on the ribbon, 1 typed only): report a bug or suggestion (saves a report file to send), count the pits and pipes CE has recorded, collect diagnostics for a difficult drawing. **Goes to:** (a) NEW TOOL: Manager, health and fault report (one button, logs attached, private text scrubbed). **Evidence:** MG-02; PARTS_BIN item 29.

**FM-172.** **CEASK, CDASK** (Civil; none in the records; typed only): ask a question about the drawing (the optional Ask CE assistant, switched off by default). **Goes to:** (d) PROPOSED TO RETIRE: no decision asks for an assistant; its path can send drawing text off the PC (privacy review flagged in the code); never used in the records. **Evidence:** PARTS_BIN item 30.

**FM-173.** **(no typed name: usage, machine and failure records the plug-ins write into the office IT folder)** (Manager; Civil; Structural; 2,637 usage records, 1,029 failure records, 9 machine records (20 Apr to 16 Nov 2026); not on a ribbon): write one record per command run and one per failure into the shared IT folder; the source of all the usage counts in this map. **Goes to:** (e) NOT DECIDED: the Manager keeps a fault report and an admin page with 'faults this week', which need failure records; Tim did not tick 'no usage records' and statistics are a future idea (FI-01). Nothing says whether per-command usage is still written. **Evidence:** MG-02; MG-05; FI-01; TA-012 (the 'no usage records' option was not ticked).

**FM-174.** **(no typed name: the CE Tools tab, the CE Civil ribbon with its two layouts, and the three contextual tabs)** (Manager; Civil; not applicable; not on a ribbon): the ribbon: CE Tools tab (Product, Health & Support, Updates, Shared Drafting), the Civil CE tab (9 panels, two layouts) and three extra tabs when a pipe, pit or source is selected. **Goes to:** (a) NEW TOOL: three tabs CE Civil, CE Tools, CE Structural (structural hidden until it has tools), with a light tab for the picked thing. Which buttons sit on each tab is not settled. **Evidence:** D-200; D-208; D-051; TA-018; TA-019.

**FM-175.** **(no typed name: the settings store, 577 settings in 49 groups)** (Civil; not applicable; not on a ribbon): the store behind CDS: 577 separate settings, 250 of them on/off switches. **Goes to:** (b) FOLDED IN: the settings store is left behind (a new value there needs new code); every value lives on the office list as one line. **Evidence:** D-094; PARTS_BIN item 7; FOUNDATION.

**FM-176.** **(no typed name: the office alias file of 68 short names for AutoCAD's own commands)** (Alias file; not applicable; not on a ribbon): short names the office types for AutoCAD's own commands (C copy, E extend, Pp pedit and so on). **Goes to:** (e) NOT DECIDED: the plug-in never edits Tim's own alias file (D-170) and the new short names are checked against it, but nothing says where the plug-in's own short names live (the plug-in itself, or lines added to the alias file). **Evidence:** D-170; D-052; NAMING_DRAFT 'Still open' item 1.

**FM-177.** **Wall-l, Wall-t, WX, L2ML, mltim, Dimsmallauto, Dimsmallorig, movedim, Grabcopy, _Pkser, MTE** (Alias file; not recorded; not a CE command): commands that the office alias file points at but that are not AutoCAD's own short names (WL, WT, WX, MLL, q, Dsa, Dss, Ds, Gr, Serial, ET). **Goes to:** (e) NOT DECIDED: I found no definition of these commands in the shared LISP folder or in any plug-in code, and no plan document mentions them. Where they live and whether they are used is Unknown. **Evidence:** none.

### Test, repair and developer commands

**FM-178.** **CDREPAIR, CDSYNC, CDREBUILD, CDREBUILDLINKS, CDLINKDANGLINGPIPES, CDFIXPIPEENDS, CDFIXFLATPIPES, CDREFRESHBLOCKS, CDREFRESHLINKS** (Civil; CDSYNC 10 runs, CDREPAIR 8, CDREBUILD under 8; 1 on the ribbon, 8 typed only): the repair centre and the repair commands: relink pits and pipes from geometry, rebuild project data, fix pipe ends and flat pipes, refresh blocks and pit-linked text. **Goes to:** (b) FOLDED IN: repair command, not needed: one fact held once, with a self-check when a drawing opens. The list of drift cases found is kept as input to the self-check. **Evidence:** D-094; PARTS_BIN item 19; THE_PLAN section 3.

**FM-179.** **CDAUDIT, CDAUDITDETAIL, CDGRAPH, CDIMPORTAUDIT, CDLEGACYAUDIT, CDSTARTUPAUDIT, CDTRENCHGRATEAUDIT, CDMENU** (Civil; none in the records; typed only): audits of the network, schedule, imports, legacy data, start-up and trench grates; the old Civil menu. **Goes to:** (b) FOLDED IN: audits are replaced by the self-check on open and the Unfinished list; the old menu is replaced by the three-tab ribbon. **Evidence:** D-094; PARTS_BIN item 19; D-200.

**FM-180.** **CDUPGRADE, CDSPINEUPGRADE** (Civil; none in the records; typed only): upgrade legacy or external drawings into CE-managed data; give every pit and pipe a permanent identity (dry run, apply, roll back). **Goes to:** (c) PARKED with old-drawing take-up: one line on opening and a 'take it up' click, after the first release. **Evidence:** D-027; D-192; THE_PLAN section 3.

**FM-181.** **CDDEBUG, CDGRIPROUTE, CDGRIPDIAG, CEPERFDIAG, CETRUSTREAD, CDPIPEATTACHMENTACTION, CDUSEPLANLABEL, CDCLOSETAB, CE_TEST_RUN, CDEXPORTCORPUS** (Civil; CDDEBUG under 8 runs; typed only): internal and fault-finding commands: debug switches, grip and performance diagnostics, the trust reader, internal routes for grips and the Inspector, the test runner, a developer export. **Goes to:** (d) PROPOSED TO RETIRE: internal fault-finding for the old objects, not staff tools. The new build keeps its own checks (speed and 'native AutoCAD untouched' tests) instead. **Evidence:** TOOLS_TODAY T-049; PARTS_BIN item 19; THE_PLAN section 9 (speed is checked).

**FM-182.** **CEW03TESTEXTRACT, CELINKSTATUS, CETESTCR, CETESTMR** (Test bundle; none in the records; typed only): leftover test pieces: a synthetic read-only link test (loads at every start-up) and a trial Copy+Rotate / Move+Rotate. **Goes to:** (d) PROPOSED TO RETIRE: leftover test bundles that never shipped as tools; the fifth home of Move+Rotate. **Evidence:** TOOLS_TODAY T-053; T-054.

**FM-183.** **STRETCH (and other native AutoCAD commands the plug-ins watch)** (AutoCAD's own; STRETCH 112 runs; not on a ribbon): AutoCAD's own commands that the plug-ins react to when a pit, pipe or footing moves; recorded in the usage counts only because the plug-ins wrap them. **Goes to:** (b) FOLDED IN: no CE command exists. The new design follows plain MOVE, COPY, MIRROR, ROTATE and STRETCH quietly (joins and labels follow) and never changes how native objects behave. **Evidence:** THE_PLAN section 6a item 1; D-199; SITUATIONS rule 6 (draft).

**FM-184.** **BEAMLINKDEBUG, BEAMLINKMIGRATE, STRUCDEBUG, CEDEBUG, JOBTIMERDEBUG, CERECOVERY, CSWAKE, CESTRUC_PALETTE_RESTORE** (Structural; none in the records; 3 on the ribbon, 5 typed only): Structural fault-finding and plumbing: dump or migrate beam link data, beam and text tag diagnostics, time tracking diagnostics, review and clear incomplete command snapshots, wake Structural for a drawing, restore the Structural palette at start-up. **Goes to:** (d) PROPOSED TO RETIRE: internal fault-finding and plumbing for the old Structural objects, not staff tools. Structural is rebuilt on the new foundation when it is unparked, with its own checks. **Evidence:** D-006; D-094 (repair and linking code left behind); registry texts.

## 7. New tools with no old command (not counted above)

1. **Outlet** (D-190): the council pit or kerb outlet a run reaches.
2. **Job window** (D-171 item 4): one window typed once per job.
3. **Self-check on open** and the **Unfinished list** (THE_PLAN section 3; D-176; D-188).
4. **Shared tools with no old command (D-209):** put on office layer (ST-14), viewport scale set and lock (ST-15), find and replace across layouts (ST-16), live area and length labels (ST-17).
5. **Manager:** the fault-report window and the one admin page (MG-02, MG-05).

## 8. What I did not do

1. **No AutoCAD was run**, so what a drafter sees on the ribbon, which LISP copy loads and what each command really does are read from code and registry text only.
2. **I did not read the Structural, Manager or Civil code beyond command declarations, registry text and the ribbon layout files**, so 'what it does' is the registry's own words, shortened. Where a registry line was only a title I say so (a few Structural ones read 'Run utility command ...').
3. **The 279 machine-named master-drawing blocks** and the hatch visual list (TA-045) are other chats' work.
4. **Section 5 item 9 and the usage counts** rest on TOOLS_TODAY T-055, which I did not re-derive from the IT folder.
