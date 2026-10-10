# Build queue V3, run 2: refilled queues for all three lanes (desk plan/03 planner, Sat 10 Oct 2026, written 16:30 to 17:20 PC clock, Fable, read-only)

**Why this exists.** Run 1 (`release-v3-colleagues-BUILD_QUEUE_V3_2026-10-10.md`, 09:03) gave each lane 25 items. By 16:20 all three had drained them: build/02 runs 132 to 147 (last three runs built nothing: "needs AutoCAD or a driver, Codex windows, or Tim's tables"), build/03 runs 59 to 63 ("nearly every queue item already has a PR"), build/04 runs 73 to 80 (runs 76 to 80 built nothing: "every remaining item is AutoCAD-bound, blocked on build/03, Tim's options ruling or Codex"). Tim's end state (INT-079) is everything in the V3 plan, UI and UX built, then full Claude and Codex testing. So this file refills all three queues under INT-073 (build on the recommended answer as a DRAFT behind a Settings switch, OFF or hidden where it changes what a drafter sees) and puts every "needs Tim" item into one question batch.

**What I read.** The run-1 file, the three TEAMLANE logs from their 10 Oct entries (TEAMLANE2 runs 130 to 147 in full), TIM_DESK items 233 to 235, decisions INT-071 to INT-081, the roof-down memory (Tim, 4 Oct: "WE NORMALLY DRAFT AND DESIGN FROM ROOF DOWNWARDS"), the R-00 Structural and Civil lists, HUNT2 and HUNT3, the Batch 13 to 15 cards, the S4, STRUC-REGISTER-ISSUE, ROOF-DOWN-PRODUCTION, TITLEBLOCK-NEWJOB and L3-NETWORK cards, STRUCTURAL_LEVEL3_PLAN.md, the rulebook, the 25 Sep rulings file, the UX plan, BUG_CARPARK (BUG-448 up in full), the Set C, Batch 8/9 and markup question files, the newest recount (PROGRESS_COUNT_2026-10-09b), `gh pr list`, and the rel-* heads after a fetch. Three read-only helper agents did the file-by-file sweeps; I checked their key claims (the S3 notes commands on the Structural head, the beam-layer answer, the L3-NETWORK open question, the installed DLL versions) myself. **Nothing was run in AutoCAD. No code was read beyond command names.**

**The facts that change fastest (read 16:35 to 16:50 today).** Installed on Tim's PC: Civil 3.0.45 and Manager 1.1.45 (build f34abfeb, rel-20261009r, installed 08:23 to 08:28), Structural 1.0.114 (build 0f00f5fb, rel-20261009q, installed 08:14). Newest assembled heads: Civil rel-20261009w (C-36 assembly, 09:52) and Structural rel-20261009v (S-33 merged, 08:03). Open PRs 721, newest #1133, 122 opened today after 09:00 (all drafts), one GitHub merge since 1 Oct. Carpark: 515 entries, 23 fixed, about 492 open, next free BUG-566. No Opus review verdict has landed since REVIEWLANE entry 971 (09:35).

---

## 0. Four things the lanes got wrong or that run 1 got wrong (fix before the queues)

1. **The S3 notes family is already built.** Run 1 said "no log mentions any of it". PR #405 (hidden, OFF) put CSGENNOTES, CSLEADERNOTE, CSBOXNOTES and CSSLABSTEP on the Structural head; I read the command names on rel-20261009t myself. Only the leftovers are queued below (the "(O)" reader, the slab-step offer, section marks, sheet order).
2. **build/03 is duplicating older council-rule PRs.** #1130 repeats #701 (UX-CR-11), #1131 repeats #714 (UX-CR-13), #1132 repeats #712 (UX-CR-14); the lane itself found #1082 vs #716 and #1084 vs #707 at run 60. Desk action: close the newer copy of each pair, and the lane runs `gh pr list --search` before every after-queue item (its own lesson, run 60).
3. **Two roof-down help switches exist.** #851 (run 118) and #1045 (run 133) both add the master switch. Queue item build/02 2 merges them.
4. **One Batch 14 item is overruled.** Card 14 "bored piers in their own schedule" is dead: Tim, INT-077 item 12, "bored piers are part of footing schedule most of the time". Nobody builds it.

---

## 1. build/02, Structural: the next 25, in order (roof down where it applies)

Base: the newest Structural rel-* head holding 1.0.114 (today rel-20261009v or q). Every item: DRAFT PR, RED test first, Settings-backed, OFF or hidden where it changes what a drafter sees, Opus review, REGRESSION_LOG in AutoCAD words. Windows go to Codex: build the engine, the command and the Settings rows and say in the PR which window is still owed. Search PRs and branches before starting any item.

1. **BUG-519 the start-up banner.** When AutoCAD opens, Structural prints one line ("CE Structural 1.0.x loaded. Type CE_HELP"), not 44 lines naming commands that do not exist. S. Depends on nothing. Tim number: no.
2. **One roof-down help switch, and the tooltip line (Batch 13 card 13.1).** #851 and #1045 become one switch; the Foundations and Framing ribbon tooltips and the Start Here Structural page gain a "Roof down: roof, floors, ground, footings last" line. S. Depends on #851, #1045, #1049. Tim number: no. Roof.
3. **The job-folder plan-level reader (Level 3 plan, the piece that blocked run-1 item 9 pieces 3 and 4).** CE reads every drawing in the job folder and lists its plan level ("Roof: S07. First: S05. S09: level not set"); CSLOADPATH and CSLEVELCARRY end with "3 drawings read, 1 with no level". M. Depends on #430, #735. Tim number: no. Roof (feeds every band).
4. **BUG-468 (HUNT-S-03) posts count on the floor below with linking off.** A post placed by C1, TS1, DS1 or C2 counts as a support for the plan below even when beam linking is off; CSLOADPATH stops saying "No beam-end or post supports found". M. Depends on #927 (Opus MERGE). Tim number: no. Upper.
5. **BUG-471 (HUNT-S-06) metre, centimetre and inch drawings.** R1, BT1, C1 and TS1 convert the drawing's units instead of only holding (INT-026 "convert units automatically"). M. Depends on #902. Tim number: no. Roof and upper.
6. **Bracing tags and a schedule with no handles (BUG-503 S-09, UX-FRM-14).** Each bracing wall gets a "A 2400" tag (type and length); the schedule prints wall line, type, length and count, never a handle, layer or rotation. Built as the DRAFT default from question 4 of today's batch. M. Depends on #1008, #1011, #935. Tim number: yes, default = wall line plus type plus count.
7. **Tie-down schedule in office form (UX-FRM-15, Batch 14).** CSTIEDOWN symbols feed a schedule with TD1 to TD3 type names (placeholders stay until Tim names them). S-M. Depends on #854. Tim number: no. Upper.
8. **BUG-548 lintel tolerances and schedule placement memory live with the job.** A Save As or a colleague's PC keeps the lintel tolerances (Set A Q8, per job) and the member schedule's last place (INT-075 Q10). Same drawing-record route as #1024, switch OFF. S-M. Depends on #1024, #860, #861. Tim number: yes, default (a) in the drawing (question 15 of the batch).
9. **Beam shorten choices from Settings (R-00 item 23, BUG-536 part 4).** The 45 and 100 offered at all seven prompt sites (including the connected-design adapters) read one Settings list. One dedicated run. M. Tim number: no (default 45 and 100; question 6 only confirms). Upper.
10. **Member schedule sizes and beam-layer readers (R-00 item 26, Batch 13 13.5 second step).** Row and text sizes of the member schedule come from Settings with today's numbers; the lintel proposals, CELAYERS template, Markup AI planner and rafter tool read the Settings beam layer names (BEAM / BEAM LOWER, Tim INT-075 Q14 "as recommended") instead of their own text. S-M. Depends on #1001. Tim number: no. Upper.
11. **Mark reader fixes and grammar guards.** XCLMTXT reads "(O)" as over and "Ex." as existing through the one shared reader from #405 (today "(O)" reads as existing); the mark grammar LEVEL FAMILY number letter (O)/(U) is pinned by tests on the mark engine and the reader. S-M. Depends on #405, #906. Tim number: no. Upper.
12. **CSSLABSTEP offers the step where two levels meet (UX-LEVEL-01 now exists).** On a plan with two slab levels, CE proposes each step line and its magenta SLAB STEP symbol instead of the drafter clicking every one; Esc draws nothing. M. Depends on #405, #430. Tim number: no. Ground.
13. **Section marks numbered and linked (UX-SYM-03, UX-SEC-01).** Placing a section mark gives the next number on that sheet and makes a linked, numbered section frame; renumber keeps them together. M. Tim number: no.
14. **Sheet order in the register and Publish (UX-SHEETS-01/02).** S01 notes and register first, then footings, floors up, roof, each plan's details after it; the register and the publish set follow the same rule. S-M. Depends on #702, #1074. Tim number: no.
15. **Footing schedule strength band row and FEDIT strength prompt (Batch 14 card 14.4, run-1 item 12 remainder).** The schedule draws the "40 MPa CONCRETE" heading row; FEDIT asks on the command line "Concrete strength in MPa, or Enter for the schedule's <25>" (the window field stays Codex's). M. Depends on #1055. Tim number: no (INT-077 item 14). Footings.
16. **Footing and bracing table sizes from Settings (Batch 14 EXPLORE item 3, R-00 item 27 rest).** STRSCHEDCREATE cells sized from the text height so "incompatible sizes" stops; footing schedule text 250 and row 350 on Settings (#1110 did widths only). S-M. Depends on #1008, #1110. Tim number: no. Footings.
17. **FADOPT Raft asks for an unlabelled beam's kind (BUG-503 S-13).** Instead of quietly making it an internal beam, CE asks once, or says it took "edge beam" from the perimeter. S-M. Depends on #906. Tim number: no. Footings.
18. **Old pads, screw piles and bored piers say Unknown instead of inventing (BUG-530, BUG-536 parts 1 and 2).** An old pad with no recorded size shows "size unknown" (switch OFF); a screw pile redrawn without a size uses the Settings size it was offered; the BP hatched choice is not limited to 450. S each, one PR. Depends on #939, #940, #924. Tim number: yes for BUG-530, default = show Unknown. Footings.
19. **Plain sentences across Structural prompts (BUG-503 S-15, BUG-523 items 1.10 and 1.11, Esc at CSWINDCLASS).** "codebase", "planning-only", "S5", "this version", "entities" and "database" leave the prompts; the 71 raw error lines become one plain sentence plus "details are in the CE log"; Esc at a Yes/No means No. M, two PRs. Depends on #1015, #1012. Tim number: no.
20. **BUG-534 standards and editions named on everything printed.** AS 3600 cover and spacing, the AS/NZS 4671 catalogue, the AS 2870 founding note, the AS 4055 wind ladder and the AS/NZS 1170.1 checklist loads carry their standard and edition; the subfloor span table says "not checked against AS 1684.2". M. Tim number: yes for editions, default = the edition the file already names (AS 3600-2018), otherwise "edition not set".
21. **Privacy leftovers (BUG-550/557 Structural remainder, route 12).** "Enable MarkupAI" becomes the real switch, default OFF; "Share learning data" (read by nothing) goes OFF; Structural time logs never fall back to a personal OneDrive and say so. S. Depends on #949, #1122. Tim number: no (25 Sep rule).
22. **CEMARKUPCLARIFY and the compare record (run-1 items 15 and 16 remainders, Batch 15 cards 15.7 and 15.8).** Typing CEMARKUPCLARIFY prompts "Clarification list for round <P2>:", Esc gives "Nothing was made.", otherwise the PDF is made and opened; the compare record is taken on save, "Compare with [Saved/Issued]" falls back to the last issue and says so, and the result ends "Only CE objects were compared." M. Depends on #1057, #1006, #1071, #700. Tim number: no.
23. **Markup count line and superseded items (Batch 15 cards 15.3 and 15.6).** The CE panel shows "Markup: 3 open (P2), 12 checked"; items replaced by a later round stay, struck through, "superseded by P3"; the same-place distance is a Settings value, blank until Tim types it (question 12). S-M. Depends on #957, #1060. Tim number: yes, default blank, 15 mm recommended.
24. **Markup Fix, Delete and "add a missed mark" engine (Batch 15 card 15.1).** Each action saves who, when and the before-and-after words to a local learning record; the list window is Codex's. M. Depends on #957, #993. Tim number: no.
25. **Issue hardening (Level 3 plan S10, STRUC-REGISTER-ISSUE slice 9).** An interrupted Publish Issue ends "incomplete" and never reports a complete issue; a calculation-only change and a title-only change give different affected-sheet lists (tests on #1074); one click makes a dated council submission folder with the PDF set and the register. M-L. Depends on #702, #1074. Tim number: no.

After these: UX-STEEL-01/02 searchable steel and timber catalogue engine (M, edition "not set"), UX-DET-04/05 detail numbering and the details-a-plan-needs list (M each), the locked-rule guard tests (rulebook lines 174 to 181: 100 mm pull-back, 50 minimum, 5 degree snap, SC and RL not members, pier colours, layer number equals text height times ten, 135 degree hooks, hollow steel inner walls; S), the remaining CEAUTOSUPPORT numbers (4000 span, 50 to 600 gaps; S), wrong-units thresholds and beam offsets through a tuning object like #1115 (S-M), the read-only footing outlines reader for Civil's clash check (M, with build/03), BUG-518 "Beam (1)" ribbon names behind the INT-075 switch (S-M), BUG-527 one job timer (M, shared), the small PR leftovers (#825 LOWs, #802 tag moves aside, #804 legend lines, #792 truss manufacturer, #806 joined lintel, #798 read-only sheet), BUG-503 S-12 folder half, and the retaining wall and fence tables once Tim fills them (questions 1 and 2). Still AutoCAD-bound, for the tester lane's driver window, not for this lane: CSMEMBERSCHEDULE draw step, the Block Wall Schedule geometry, the markup underlay, revision clouds on the drawing, BUG-564.

---

## 2. build/03, Civil engine and Manager: the next 25, in order

Base: the newest Civil rel-* head (today rel-20261009w). Same rules. First action of the next run: close the three duplicate PRs named in section 0 item 2, then `gh pr list --search` before every item below.

1. **BUG-543 one orifice coefficient and one gravity.** The Detention System tab takes the orifice coefficient from the council profile like the other tabs; 9.81 everywhere (one file still says 9.8). S-M. Tim number: no (ruled 17 Jul, rulebook B6/B7).
2. **BUG-527 item 5.2 one pipe-speed limit.** The Inspector, the Design Check Dashboard and CDRULES judge pipe speed against the same per-material limit, so a pipe never passes in one place and fails in another. M. Tim number: no.
3. **BUG-541 and BUG-545 part 2.** Slab minimum falls (1 in 50, 67, 100) and the three pit-drop values become Settings values with their source named, read by CDSLAB, the slab flow check, the Inspector and the drawing check. S each. Tim number: no (defaults = today).
4. **BUG-547 part 1 (R-00 Civil 69, 79, 80).** Twin detention pipe gap 50 mm on Settings; the connection pipe sized on its drawn length and material, not "10 m uPVC"; an X-Civil level outside 0 to 250 m warns instead of vanishing. M. Tim number: no.
5. **BUG-547 part 2 (R-00 Civil 67, 73, 74).** The office rainfall curve is named and cited on the sheet; the WSUD tab targets and the charged-system coefficients read Settings with today's defaults. M. Tim number: no.
6. **BUG-547 part 3 (R-00 Civil 87 to 91).** Strip drain floor-waste spacing and width, trench grate length, LPD search distances, JOIN label reach, SPS 2 m search and 200 mm wall clearance on Settings. M. Tim number: no.
7. **Civil speed (run-1 item 1, still open).** Moving 20 pipes in a 300-pit job stops taking two seconds; #991 is the first piece. Needs AutoCAD closed for the before-and-after numbers: take it in tonight's or Sunday's free window and say so in the log. M. Tim number: no.
8. **Start-up honesty (BUG-522, BUG-528).** One line when Civil and Manager carry different CE_SHARED copies; a guard test when Civil and Structural ship different Microsoft helper versions in the 2022 to 2024 lane. S. Tim number: no.
9. **BUG-555 and BUG-491 A8.** CDHELP says "help guide missing, reinstall" instead of opening a web address; the Civil log records only the attribute tag, never its value. S. Tim number: yes for the web fallback, default = remove it.
10. **Manager privacy and safety (BUG-556, BUG-557 route 8, BUG-554).** The unused Azure upload code goes; the fleet heartbeat gets a switch (default ON, today's behaviour); the installer refuses a WebView2 download not signed by Microsoft, in plain words. S-M. Tim number: no.
11. **Computations sheet volume tables and one computed record (civil-D-F F1 and F2).** The sheet gains the pipe and pit volume tables from CDTWL's collector, and the sheet, the OSD criteria block and the orifice detail all read one record. M. Depends on #1042, #1123. Tim number: no (same figures as the V3 sheet).
12. **One orifice-head reader (rulebook B11).** The four engines that read "TWL minus orifice invert, 0.45 m fallback" share one reader. M. Tim number: no.
13. **UX-OLF-01 and OLF-04 overland route and freeboard.** CE proposes the overflow route from surface levels for the drafter to confirm; floors beside it are checked against the council freeboard ("not checked" when unset). Read #716 and #1082 first (TWL versus floor). L plus M. Depends on #958 to #972, #1127. Tim number: no.
14. **UX-CPLAN-33/34 run half: outfall drain as its own run.** Off-property pipes are their own run numbered CP1, CP2 and checked against the council rule in #1097. M. Tim number: no.
15. **UX-CPLAN-11 clash half.** Surveyed service lines on plan are checked for clashes with drawn pipes; "clearance not set, not checked" until question 11 is answered. M. Depends on #997, #1125. Tim number: yes, default blank.
16. **UX-SITE-02 and UX-POOL-01.** Advisory construction-joint proposals on a slab (saw-cut spacing "not set" until typed); the pool's zone of influence flagged with the angle blank (question 10). M. Depends on #1038, #1133. Tim number: yes, defaults blank.
17. **UX-WSUD-01 buffer strip and raingarden areas.** Drawn as areas linked to what drains to them, counted in the WSUD tab. M-L. Tim number: no.
18. **Council rulings 02, 03, 04, 06, 07, 10 and 16 sourced values (run-1 after-list, BUG-431).** Each value filled from the cited council document and marked Confirmed or Unknown; read-only research first, numbers only in the repo. M. Tim number: no.
19. **UX-STDS-01 to 03 Civil issue standards clean-up.** At issue, off-standard layers, styles and pens are listed with safe fixes pre-ticked; "Clean up drawing" tick OFF; standards live in Settings. M-L. Tim number: no.
20. **UX-REG Civil half.** A Civil issue compares with the last issue, suggests the next revision, proposes clouds after A and records who issued and which engineer approved, reusing build/02's #1074 and #1083 engines. M. Tim number: no.
21. **UX-DWG-02 and UX-ARCH-01/03.** An older CE drawing lists what will upgrade and upgrades on open with one line and one Undo (planner); a revised background lists what moved; one-click office background layer preset. M. Tim number: no.
22. **Checks "Explain" and UX-CHK-02.** Every Checks finding carries a plain explanation citing its rule source (no AI call); CE drafts the job checklist from past issued jobs and the council for the drafter to edit. M. Depends on #1128. Tim number: no.
23. **UX-SET-03/06 settings provenance.** A firm-wide change records who changed it and why; each value carries a source tag (Council, Job, Office) for the gold "This job" mark. S-M. Window Codex. Tim number: no.
24. **Manager M03, M04, M06.** A fresh PC with a missing standard file gets the exact repair offered; offline reports queue and a file in a folder is never taken as "received"; report states run Draft, Saved, Awaiting transfer, Received, Confirmed with retries that never duplicate. M-L. Tim number: no.
25. **Manager M05, M07 and UX-MGR-02, plus the disposable test suite.** Each update attempt's per-PC outcome recorded; a failed tool links to scoped support evidence; "Open Hub" hidable by a switch (OFF); tests for old-loaded-new-staged, corrupt download, low disk, locked activation, offline reconnect, duplicate retry. M. Tim number: no.

After these: BUG-478 the real update route (Opus design read first; default (a) activator at next closed start), M-SET-01 the deliberate 100-file merge, UX-LEARN-01 slice 5 (needs the corpus import), UX-SPS slice 2 rising main (card Q4, default duty flow typed), UX-RIBBON-07 button-use counts, drawing-production step 5 (list only the affected network, details and outputs after a change), the footing outlines reader with build/02, BUG-565's Pit Schedule path (only the plain message is unproven).

---

## 3. build/04, Civil UI side: the next 25, in order

Base as for build/03. Before any Batch 7 to 9 item, read TEAMLANE3's newest entry (RULES 6.4: two chats never touch the same file). No Batch 7 to 12 or 16 to 23 card exists yet (the cards folder shows a bulk touch at 04:03 and nothing newer except the two question files); these items rest on Tim's 25 Sep rulings, cited by line, which is enough under INT-073.

1. **Drafting words (BUG-523 items 1.6 to 1.12, BUG-524 item 2.7).** CDIMPORTCOMPARE, CDIMPORTXCIVIL's refusal, CDSLABIMPORT, the Pit Schedule status and Dashboard lines, and the Civil ribbon tooltips lose "Export Entities", "compound entity" and the like. S-M. Depends on #971, #1000, #1040, #1101. Tim number: no.
2. **UX-CPLAN-01 the office legend block on C01 (rulings line 1644).** The CIVIL WORKS LEGEND is placed whole, always the same, from the CE A1 template. M. Tim number: yes for the block's file, default = the CE A1 template already used by the LPD note.
3. **UX-CPLAN-12 legend gaps (rulings 1772).** Checks lists any symbol on the plan that the legend does not show. M. Depends on item 2. Tim number: no.
4. **UX-CPLAN-08 and UX-NOTES-05/06 note blocks on C01 (rulings 1724, 1726, 1761).** GENERAL, CIVIL WORKS, STORMWATER DRAINAGE and SITE PREPARATION blocks always go on C01 plus the council's block from the council profile. M-L. Tim number: yes for the source file, default = the A1 template.
5. **UX-CPLAN-10 the LPD note (rulings 1767, UX-SET-02).** The CONNECTION TO LPD note is placed at the connection, worded from a Settings box (the row is Codex's). S-M. Tim number: no.
6. **UX-CPLAN-09 the tank callout (rulings 1764).** WT1, capacity, make, size and split placed in office wording. S-M. Tim number: no.
7. **UX-CPLAN-11 labels half (rulings 1770).** Surveyed services get office labels ("Ex. SEWER DRAIN", S, W, T line codes). M. Tim number: no.
8. **UX-CPLAN-03 existing items grey (rulings 1647).** Existing pits, sewer and easements from the survey draw grey and labelled EX. M. Depends on #912, #948. Tim number: no.
9. **UX-CPLAN-02 and UX-SHEETS-03/04 the sheet rule (rulings 1574, 1576, 1646).** C01 = plan, Pit Schedule, notes, OSD block, LPD note; C02 = details; Checks lists what is on the wrong sheet. M. Tim number: no.
10. **UX-CPLAN-15 and UX-DET-09.** C02 is titled "OUTFALL DRAIN PLAN AND DETAILS" or "STORMWATER DRAINAGE DETAIL SHEET" by its content; a guard keeps Civil details titled by description with no numbers. S plus S. Tim number: no.
11. **UX-CPLAN-16 details packing (rulings 1780).** C02 details pack on a tidy grid in office order, then stay draggable (packing engine only). M. Tim number: no.
12. **UX-CPLAN-17 charged pipes (rulings 1782).** A charged pipe gets the C02 charged detail and the charged linetype. M. Tim number: no.
13. **UX-DET-07 the details a plan needs (rulings 1715).** CE lists the standard details the C01 uses, filled with job sizes, for the drafter to confirm. M. Tim number: no.
14. **UX-CPLAN-31 bedding per material (rulings 2207).** One bedding detail offered per pipe material on the job. M. Depends on item 13. Tim number: no.
15. **UX-CPLAN-32 penetration and sawcut details (rulings 2209).** Offered when a pipe crosses a footing or wall. M. Depends on #1061. Tim number: no.
16. **UX-CPLAN-33/34 schedule half (rulings 2211, 2219).** A separate OUTFALL DRAIN schedule with CP1, CP2 (build/03 numbers the run). M. Tim number: no.
17. **Rulebook B9 and B5.** CDSTRIP's corner floor waste always uses the 0, 25, 50 mm inset and the centreline path is retired; a guard proves CD and CDEDIT both label the achieved grade. S-M plus S. Tim number: no (ruled 17 Jul).
18. **UX-L3-25 options kept with the job (rulings 1997).** Options not chosen stay with the job and can be reopened in the chooser. M. Tim number: no.
19. **UX-L3-26 mixing parts (rulings 1999).** B's pipes with A's tank, rechecked before Apply. M. Depends on item 18. Tim number: no.
20. **L3-NETWORK slices 3, 5 and 6 as a DRAFT on the recommended option set.** Option A fewest pits, option B shortest total pipe, option C the person's usual set-off; chooser rows show pit count, total length and deepest invert; Accept applies ticked rows as one Undo. This is question 14 of the batch; INT-073 says build the recommendation now. L. Depends on #693, #754, #1067, #699, #708. Tim number: yes, default as above.
21. **UX-SITE-03 spoon drain live text engine (rulings 880).** Length and fall shown live while picking (the engine; the on-screen jig needs AutoCAD). S-M. Tim number: no.
22. **UX-NAMES-01/06 guard.** Every old typed Civil name and the short codes (CDWT, CDLPD) still run and never show in the ribbon or help. S. Tim number: no.
23. **BUG-416 item 1 guard.** "Select this run" straight after U keeps REDO; source-shape test. S. Tim number: no.
24. **BUG-430 item 1 double-click a pit label.** Opens Edit Pit, not AutoCAD's attribute editor, the BUG-166 way (#107); proof needs a driver run. M. Tim number: no.
25. **Free-end whole-job record (UX-PIPE-07 remainder) and the UX-UNDO-01 probe request.** "Keep as a free end" is remembered across the job's drawings through the shared job record; a one-line probe brief for the tester lane on what AutoCAD shows in the Undo list. M. Depends on #1069, build/03's CDSETUP record. Tim number: no.

After these: Batch 21's L3 feel items, UX-SET-05, and the AutoCAD-bound remainders that belong to the tester lane's driver window, not to this lane: the ROTATE/MIRROR hook (#850), Edit Pipe preview re-tidy (#839), the footing-plan Xref command, the sources command, Area E, the bell producers (.dwl read), E-HOLD-01 probe #88.

---

## 4. Questions for Tim: one batch of 15

Written as `C:\CE_PLAN\04_REFERENCE\ux-plan\cards\TIM_BATCH_QUESTIONS_STRUC_LANES_2026-10-10.md`. Each is answerable by a number, a name or "as recommended"; no build waits on any of them. In short:

1. Retaining wall sizes by height band (S4 Q1): as recommended = leave Unknown, fill the Settings table later.
2. Fence post footing sizes (S4 Q2): same.
3. One layer name per object (R-00 items 28 and 29): recommended BORED PIER UNDER, FLOOR JOISTS, STUMP FOOTING, pads and strips stay on STRIP FOOTINGS.
4. Bracing schedule rows without marks (HUNT2-S-09): recommended wall line plus type plus count.
5. Tie-down real names TD1 to TD3: recommended keep placeholders.
6. Beam shorten distances: recommended keep 45 and 100 on Settings.
7. Floor arrow order and "DENOTES POST UNDER" (plain re-ask of Set A Q10).
8. Clearance from a footing to detention storage, metres.
9. Clearance from an existing service to detention storage, metres.
10. Zone of influence angle, degrees, from the horizontal.
11. Minimum clearance to a crossing service on the long section, mm.
12. Markup same-place distance, mm: recommended 15.
13. Office minimum cover, 300 or 600 (Set C Q5).
14. What makes the Level 3 network options differ (L3-NETWORK OPEN 3): recommended fewest pits, shortest length, usual set-off.
15. Three one-line confirmations: job record in the drawing (#1024), markup per drawing (#1068), Boroondara outfall reading (#1097).

Checked first, not re-asked (INT-074 to INT-081): beam layers stay BEAM / BEAM LOWER (INT-075 Q14 "as recommended"), beam linking ON, BT1 any width, lintel table on S01, strength band as recommended, learning from own drawings first, a layout may propose changing a drawn pit as an unticked row.

---

## 5. How much of V3 is built, in two figures (estimates, counted the recount way)

1. **Built: about 60 percent. Installed: about 53 percent.** Denominator = 509 UX plan IDs plus about 492 open carpark bugs = about 1,001. "Built" = the ID is named in a commit on the live release lines or in an open draft PR. "Installed" = named in a commit inside the installed builds (Civil 3.0.45 build f34abfeb, Structural 1.0.114 build 0f00f5fb, read from the DLLs at 16:40).
2. **How I got there.** The newest recount file (PROGRESS_COUNT_2026-10-09b, Fri 9 Oct 14:40) gave Built 54 percent (532 of 984) and Installed 50.5 percent (497 of 984). Run 1 moved that forward to about 56 and 52 for the Friday-night and Saturday-morning trains. Since 09:00 today 122 draft PRs opened; their titles name 53 distinct plan IDs (13 bugs, 40 UX IDs) and their bodies name more, and most queue items were unbuilt by definition, so I count about 45 newly built IDs (Built to about 605 of 1,001). Installs since run 1 are one Civil train (3.0.45: C-31 and C-35 finalizers) and one Structural train (1.0.114: S-32), about 10 IDs (Installed to about 530 of 1,001). I did not re-run the recount scripts; treat both figures as plus or minus three points, and the next recount helper run as the real number.
3. **The honest third figure.** Codex-tested about 7 percent, PASS-only about 1 percent, Tim-accepted 0, and nearly every item built today is OFF or hidden. Built, tested, installed and accepted stay four separate words (RULES 4).

---

## 6. The biggest risks to "everything built by about 20 Oct" (refreshed)

1. **The review pipe is now the wall.** 721 open PRs, 122 opened today, and no Opus verdict since 09:35. Every item above adds to a queue that is not draining. The desk's lever is a second review lane on the Team account (INT-081 allows 100 percent there) and treating the Claude driver pass as the install check.
2. **Duplicates are creeping in.** Five pairs found today (section 0 item 2). Each costs a review and a close. The `gh pr list --search` step before every item is now mandatory in all three queues.
3. **The design lane wrote no card today.** The cards folder has nothing newer than 04:03 except question files. The build/04 queue above is written straight from the 25 Sep rulings so the lane need not wait, but Batches 16 to 23 still want cards for the windows.
4. **AutoCAD-bound remainders are piling up for one driver.** About twelve items across the three lanes (member schedule draw step, Block Wall Schedule geometry, underlay, clouds, ROTATE/MIRROR hook, preview re-tidy, Xref command, sources command, bell producers, BUG-564, BUG-430 proof, Civil speed numbers) need AutoCAD closed or a driver run. The free windows (tonight after 17:30, Sunday) are the only place they move; the tester lane should take them as one block.
5. **Windows are still Codex's and Codex is testing.** Every engine above lands behind a window that does not exist. Unchanged from run 1.
6. **Stage 1 is still open** (REDO after U, the save-close crash). Unchanged.
7. **The denominator keeps growing** (492 open bugs today, 475 yesterday afternoon). Watch the open and installed counts, not the percentage.

---

## 7. What I could not check

1. Nothing was opened in AutoCAD. Every "not built" is a reading of plan files, logs, PR titles and command names on the rel heads.
2. I did not re-run the recount scripts; section 5 is the Friday count moved forward by hand twice.
3. The helper agents matched PRs by title and commit subject, not PR bodies; a feature built under another name could be missed. Structural bugs were matched by hunt and R-00 numbers because the lane logs rarely cite BUG IDs.
4. Carpark entries below BUG-448 were not re-read one by one; an older OPEN entry may be stale.
5. `areas\drawing-production.md` and `areas\level3-external-tools.md` are empty templates; the Structural drawing-production items come from DRAWING_PRODUCTION_PLAN.md and two cards. The C01 to C10 rows that plan refers to were not found anywhere.
6. I could not confirm whether CSGENNOTES already shows wind and site class, how many of the 23 text-height sites #921 moved, or whether #1008 also fixed the cell sizes (build/02 items 16 and 11 say "check first").
7. No decision file exists for 9 or 10 Oct; every Tim ruling I relied on is in `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` lines 524 to 620. Anything Tim said in chat after INT-081 that the desk has not logged is not reflected here.
8. The rel-20261009w head carries Civil 3.0.45 unchanged (C-36 assembly, not yet versioned); whether C-36 has been finalised since 09:52 was not checked.

---

## Summary

All three lanes drained their run-1 queues by mid-afternoon, so this run refills all three: build/02 gets 25 Structural items in roof-down order (the start-up banner, one roof-down switch, the job-folder level reader that unblocks the cross-drawing pieces, the HUNT bugs on posts, units and bracing tags, the Settings-ification of beam, schedule and footing numbers, the notes-family leftovers now that #405 is known to exist, the markup QA commands and the issue hardening); build/03 gets 25 Civil-engine and Manager items (the R-00 Civil numbers, one orifice and one speed rule, overland flow, the outfall run, survey clashes, council sourced values, issue standards and register, settings provenance, the Manager M03 to M07 behaviours); build/04 gets 25 drafting items written straight from Tim's 25 Sep rulings because no Batch 7 to 9 card exists yet (legend, notes blocks, LPD note, tank callout, existing items grey, the C01/C02 sheet rule, details packing and selection, the Level 3 option-keeping and the network options as a DRAFT on the recommended set). Fifteen questions go to Tim in one file, led by the two S4 tables, the layer names, four engineering numbers and the network-option rule, and none of them stops a build. V3 stands at roughly 60 percent built and 53 percent installed by the recount method, Tim-accepted still zero; the real limits now are a review pipe that has not moved since 09:35 with 721 open PRs, duplicate PRs creeping in, no new design cards today, and a dozen AutoCAD-bound remainders that only the free windows can clear.
