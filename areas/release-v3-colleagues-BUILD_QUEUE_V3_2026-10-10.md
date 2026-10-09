# Build queue V3, per lane (desk plan/03 planner run 1, Sat 10 Oct 2026, written 08:50 to 09:10 PC clock, Fable, read-only)

**Why this exists.** The three builder lanes keep ending runs with "nothing left that needs no Tim number" (build/03 run 83, build/04 run 65, build/02 run 131). Tim's end state (INT-079) is everything in the V3 plan, UI and UX built, then full Claude and Codex testing. This file turns the real remaining work into an ordered queue each lane can start on its next run, under INT-073 (build on the recommended answer as a DRAFT behind a Settings switch, OFF or hidden where it changes what a drafter sees; Tim's later answer replaces the default).

**What I read.** START_HERE, MASTER_PLAN, IMPLEMENTATION_ROADMAP, the REL area file and its release gate, QUEUE entries 200 to 260, the three TEAMLANE logs (newest runs in full, older by search), NEXT_FIXES to its end, decisions INT-059 to INT-081, BUG_CARPARK (open HIGH entries and BUG-549 to 563), the V3 UX plan, REVIEW_BATCHES, every BATCH, UX, L3, C4, S4, SPS, WSUD, CR, REPAIR, DETENTION-PIT and K-REQ card, the TIM_SET_A/C and TIM_BATCH question files, the Civil area files A to M, structural.md, manager.md, the 9 Oct 14:40 progress count, `gh pr list` (newest 400 of 976 PRs plus whole-repo counts) and the rel-* heads after a fetch. Four read-only helper agents did the file-by-file comparison; I checked their key claims against the logs, the decisions file and the cards myself. **Nothing was run in AutoCAD. No code was read beyond command names.**

**The three facts that change fastest (read 08:30 to 08:55 today).** Installed on Tim's PC: Civil 3.0.44 and Manager 1.1.44 (build b7eed253, rel-20261009o), Structural 1.0.113 (build 2e0cf385, rel-20261009p). Newest assembled heads: Civil rel-20261009r (3.0.45), Structural rel-20261009q (1.0.114) and the unversioned rel-20261009t (S-33: CSWALLMARK, CSWALLSCHEDULE, CSLINTELTABLE). Open PRs 599, merged on GitHub since 1 Oct: one (trains merge PR heads into rel branches, so PRs stay open after they ship). Carpark next free ID BUG-564.

---

## 0. The one finding that matters most

1. **The lanes are not out of work. They are out of cards they recognise as approved.** Three cards Tim approved on 25 Sep (K-REQ-01, REPAIR-DECIDE-LATER, DETENTION-PIT-ANNOTATE; rulings file lines 608 to 617) still carry a DRAFT header, and build/03 run 32 logged them as "all DRAFT". The C4 card is approved with no open question (QUEUE 883) and its steps B5 to B8 were never started. Tim's 8 to 9 Oct answers (INT-071 12c Level 3 place in Project Review, INT-074 Q6 and Q12 tidy rules, INT-077 item 7 footing-plan Xref command, INT-072 (5) both tank options) were logged by the lanes as "needs a card" or "waits on Tim".
2. **About 100 UX items have no card at all** (Batches 7 to 12 and 16 to 23 of REVIEW_BATCHES, plus the S3 notes/symbols/sections/details family). Under the INT-073 extension the design lane can write them with recommended answers; until it does, no builder will touch them. Section 3 names a lane for each.
3. **Most of what is "built" is invisible.** Engines land OFF or hidden; the windows that would show them (Checks palette, L3 choosers, Settings rows, Batch 3 look, Batch 4 splash and welcome card, Manager pages) are Codex's and almost none exist. Codex is busy testing. This is the biggest single reason Tim sees so little change for 599 PRs.

---

## 1. build/02, Structural: the next 25, in order

Base: the newest Structural rel-* head holding 1.0.113 or newer (today rel-20261009q or t). Every item: DRAFT PR, RED test first, Settings-backed, OFF or hidden where it changes what a drafter sees, Opus review, REGRESSION_LOG in AutoCAD words. Windows go to Codex: build the engine, the command and the Settings rows and say in the PR which window is still owed.

1. **BUG-558 Structural sweep leftover (sweep item 5).** After any erase with beam linking on, CE's quiet read no longer breaks REDO. S. Depends on #990 and #984 Opus review. Tim number: no.
2. **INT-078 beam linking ON by default (#927 fixes, then the flip).** A new install moves a beam and its columns together without ticking anything. S. Depends on the two Opus fixes on #927 (tick label, fingerprint bump) landing. Tim number: no (answered).
3. **BUG-497 HUNT2-S-03 (HIGH): STRSCHEDCREATE tables one row short.** Every schedule shows every pier or brace, none missing. S-M. Tim number: no.
4. **BUG-498 and BUG-499 (HUNT2-S-04, S-05).** Refreshing a schedule removes erased piers; roof trusses placed with BT1 no longer count toward the wall bracing totals. S each. Tim number: no.
5. **BUG-500 to BUG-502 (HUNT2-S-06, S-07, S-08).** Required bracing is a per-job value not a per-PC one; C1/C2 sizes come from the right floor; the subfloor grid offers Settings sizes, not invented ones. S each. Tim number: no (R-00 defaults = today's numbers).
6. **BUG-503 and BUG-504 (HUNT2-S-09 to S-15).** Bracing schedule prints marks not handles or layer names; the bracing panel reads drawing units; CSWINDCLASS never saves a blank class; Publish Issue folder line and date right; FADOPT Raft leaves an unlabelled beam alone; lintel preview matches what is drawn. S-M, about three PRs. Tim number: no.
7. **BUG-496 HUNT2-S-02: the job record lives with the job.** A colleague opening the job, or a Save As, keeps the wind class and soil values. M. Tim's call on where; DRAFT on option (a) store it inside the drawing, behind a switch, old per-PC path kept. Tim number: yes, default (a).
8. **Batch 13 card 13.2 CSMEMBERSCHEDULE.** Type the command on a framing plan: CE reads the marks, previews the list on the command line, asks "Place it [Here/Last place/Sheet]", fills the office MEMBER SCHEDULE block and updates it in place next time. L. Depends on #859 and #860 (in S-32). Tim number: no (INT-062, INT-075 9 and 10).
9. **Batch 13 card 13.1 three small pieces.** The first roof-down command on a plan with no level asks the level itself (Esc: "Level not set. Nothing was changed."); CSLOADPATH's first line says which plan and level above it is reading; CSFDNPROPOSE lists items with nothing under them first. S each. Depends on #825. Tim number: no.
10. **Batch 13 card 13.3 per-wall-line totals wired to the bracing panel.** The panel shows required versus provided per wall line, not only per direction. M. Depends on #999 and item 4. Panel list window is Codex's. Tim number: no.
11. **Batch 14 card 14.3 fill the office Block Wall Schedule block.** CSWALLSCHEDULE writes into the office block from the typical file instead of a plain table. M. Depends on S-33 (#929, #930). Tim number: no (INT-077 11: every wall type).
12. **Batch 14 card 14.4 concrete strength band.** Footings whose strength differs group under their own "40 MPa CONCRETE" heading; FEDIT gets a strength choice (the field is Codex's). M. Tim number: no (INT-078).
13. **Batch 14 card 14.2 windowsill trimmer schedule.** Copied from S01 the way the lintel table is. S-M. Depends on #933. Tim number: no (assumption: it sits on S01 like the lintel table; say so in the PR).
14. **Batch 15 slice: read member tags on the plan.** CEMARKUPCHECK marks an item Drafted from the tag on the plan, not only from the saved schedule. M. Depends on #957 and #993. Tim number: no.
15. **Batch 15 card 15.7 CEMARKUPCLARIFY.** One command makes "Clarifications P2 2026-10-10.pdf" in the job's Markups folder from the Needs-clarification items and opens it; nothing is sent anywhere. M. Depends on #1006. Tim number: no.
16. **Batch 15 card 15.8 CEMARKUPCOMPARE.** CE keeps the last saved copy of each sheet and lists what the engineer added, removed, resized or moved more than 100 mm since. M-L. Depends on #995. Tim number: no (100 mm default).
17. **Batch 15 slice 8 warning before issue.** Publish Issue says "3 markup items are still open (P2). Issue anyway?" and carries on if told to. S-M. Depends on #966 (S-36). Tim number: no.
18. **Per-drawing loaded markup.** Each open drawing remembers its own markup; switching drawings never mixes them. S. Tim number: yes, default (a) per drawing in memory (TIM_QUESTION_MARKUP_PER_DRAWING).
19. **Batch 15 card 15.2 faded markup page under the plan.** A non-plotting underlay lined up by the sheet border (or two clicked points), a Show/Hide toggle, removed before any plot. L. No underlay code exists yet. Tim number: no (recommended answers 11 and 12).
20. **STRUC-REGISTER-ISSUE slices 3, 4, 10, 11.** Issue suggests which sheets changed (from item 16's compare), suggests the revision wording, keeps Civil and Structural issue state apart, and makes a CHECK PLOT set. M each. Depends on item 16 for slice 3. Tim number: no (card APPROVED).
21. **STRUC-REGISTER-ISSUE slice 5 revision clouds and triangles after Revision A, showing only the current changes.** L. Depends on item 16. Tim number: no.
22. **S4 slice 7 retaining walls (CSRW) with the size table left Unknown.** Pick a wall line: sleepers, posts and piers laid out by height band, corner and end rules, AG drain offered, tag, schedule row, one U. L. Tim number: yes for the band table (sizes stay "Unknown, engineer to fill" until Tim types them; the layout works now).
23. **S4 slice 8 fences, waffle pod slab, screw pile schedule.** Masonry fence wall and post footings with their tags and schedule rows; pod and rib tags with the notes block; SP1 to SP4 by load with the safe-working-load schedule. M each. Tim number: fence table yes (Unknown until filled); the rest no.
24. **R-00 Structural leftovers (R00_STRUC items 3, 5, 8 and the item-4 rows).** Remaining labels, the member schedule lists, concrete window defaults and pad wording read from Settings with today's numbers as defaults. M. Tim number: no.
25. **UX-STRUC-02/05 ribbon families.** Text family, Tag family with smart tag, Hatch picture gallery, the 29 Legacy tools sorted into families, diagnostics hidden. L. Depends on the CE_SHARED drop-down upgrade (ribbon card slice 5). Retiring CESTRUC itself waits for Tim. Tim number: no for the sort.

After these: UX-SUB-04 arrow on the member below (M, check whether the drawing half exists first), Structural speed measured with AutoCAD closed (#986 drafted), the Sheets "Update drawings" write through a registered command (S-M, needs a driver walk), D2 QA leftovers (quiet flags, COPY and ERASE rules, XCLMTXT link; M), CSMARKSRENUMBER preview-to-report (S-M), the overnight assistant job queue and hand-over (L, shared with build/03), and the S3 family once carded (section 3).

---

## 2. build/03, Civil engine and Manager: the next 25, in order

Base: the newest Civil rel-* head holding 3.0.44 or newer (today rel-20261009r). Same rules as above. BUG-558 is owned by the dedicated 'bug558' job from 08:20 today: build/03 only answers Opus fix rounds on its own #982, #994 and #998.

1. **Civil speed (Tim's first pick, decompile idea 1).** Moving 20 pipes in a 300-pit job stops taking two seconds: one pit index per command end, an is-pit cache per block definition, merged passes; #991 (block-name cache) is the first piece. M. Depends on AutoCAD closed for the AcadProbe before-and-after numbers (free windows: 2 to 3 pm, after 5:30 pm, weekends). Tim number: no. PINNED unchanged-output tests first.
2. **Set C items 1 to 7 as one small DRAFT family.** The FLAT label, the long section speeds, the Detention tab starting C, the pipe-flow roughness, the minimum cover, the X-Civil size list (675 recognised) and the SPS radius all read the Settings value; today's number stays reachable behind the switch. S each. Tim number: yes in principle, but INT-078 "the rest I am happy with" covers the recommendations: default = the Settings value, old number reachable.
3. **Set C item 8 LandXML circular pits.** A standards-correct circular pit comes in at its real size: read "diameter" first, then diamWidth. S. Depends on #892 (BUG-505 units). Tim number: no (default: diameter first).
4. **DETENTION-PIT-ANNOTATE, CDPITDETENTION slices 1 to 3 (APPROVED 25 Sep).** Pick an existing pit: it gets a real detention record, the Pit Schedule and the OSD criteria block count it, the indicative volume shows, a warning if its pipes are not typed Detention. M-L. Tim number: no (every OPEN answered the recommended way).
5. **REPAIR-DECIDE-LATER slices 2 to 4 (APPROVED 25 Sep).** Drawing Repair gets a "Decide later (n)" list; a finding can be parked with a reason; anyone resolves, only the administrator deletes, with who, when and why recorded. M-L. The tab itself is Codex's. Tim number: no.
6. **K-REQ-01 slices 2 and 3 (APPROVED 25 Sep).** CDPROFILE Apply writes the long section and the Pit Schedule rows together as one U; pinned rows show in the preview; unlisted pits and Esc handled. M. Depends on #733. Tim number: no.
7. **C4 B6 = D+F slice 3, Apply to drawing (UX-CALC-02).** From the Detention tab, pick or place the criteria block, the orifice pit detail fills, a before-and-after preview, one U. L. Tim number: no (card approved, no open question). L3-DETENTION's writer waits on this.
8. **C4 B7 = D+F slice 4, Issue (UX-CALC-03).** An Issue step with engineer, revision and date; a warning when drawn storage differs from the issued figure; the "unknown ARI becomes 10 years" fault fixed. M-L. Depends on item 7. Tim number: no (engineer list from Settings).
9. **C4 B8 = D+F slice 5, whole-set catchment review (UX-CALC-01).** Every catchment in one list, typed values marked "Your value", Confirm all. M. Tim number: no.
10. **C4 B5 and CV-02A slice 4.** The Pipe window's one advisory size line and the From-markup mode words (Matches / Different / Can't verify). S-M. Tim number: no (Different only where the supplied design states a size).
11. **UX-CR-09 refused storage items, UX-CR-08 pipe class, I-WSUD-02 rating-report check.** A detention record carries storage type and location and CDCHECK warns where a council refuses it; a pipe carries a Class defaulted from the council minimum with a warning; a drawn tank is checked against the rating report (tanks first). M each. Tim number: no (each card's OPENs have recommendations; DRAFT OFF).
12. **UX-SPS-01 slice 1, pump duty point engine (CDPUMP).** The duty point is worked out from typed duty flow, static lift and Hazen-Williams friction with blank Settings values that say "not set". M. Tim number: yes for where the SPS master detail lives and the storage rule; default = blank with "detail not set", engine still runs.
13. **Batch 6 card 6.5 late survey, list and Apply.** When a survey arrives after assumed levels, CE lists every pit whose level would change (typed levels unticked), Apply is one U, new failures go to Checks. M. Depends on #996 (planner). The list window is Codex's. Tim number: no.
14. **Batch 6 card 6.8 crossing services on the long section.** Surveyed sewer, water, gas, power and telecom crossings are marked on the section with their clearance; "clearance not set, not checked" until Tim types a number. M. Depends on #997. Tim number: yes (the mm), default blank.
15. **Batch 6 leftovers 6.7 and 6.4.** The "Pick the end pit, or Enter to run to the outfall" prompt, a run title, scales and pit-bottom depth on Settings; the CE panel line "Levels: ASSUMED" and the plotted note. S-M. Tim number: no.
16. **Batch 2 card 2.1 and 2.3 feeders.** The live off-pit watcher feeds the shared check result after a MOVE; the Ignore writer (#838) has a command that calls it. M-L. Depends on #834, #838, #858. Tim number: no.
17. **Batch 2 card 2.7 pause a slow feature and tell the admin.** A slow feature offers to pause itself for that drawing, a report with feature name and delay goes to the admin folder (no drawing names), and Manager shows a paused-features line (needs a machine-level mirror of the paused list). M. Tim number: no (INT-075 Batch 2 item 6).
18. **BUG-478 HUNT-M-03 the real update route.** After "Get update ready", a colleague can finish the update without an installer nobody can run: Manager runs the existing activator when AutoCAD next closes, with the honest wording of #936 until then. M-L. Needs an Opus design read first. Tim number: no for the wording; the route choice is flagged in section 4 as Tim's call, default = the activator at next closed start.
19. **UX-MGR-08 and UX-MGR-01 approval page engine.** Approving a build shows one page (changes, tests, not-yet-accepted items, rollback copy) and a tick-list of who gets it first, then "Promote to all". M. Pages are Codex's. Depends on the update channel (section 4). Tim number: no.
20. **UX-MGR-06, 09, 10 reporting.** One "Report a problem" that merges Feedback and the support zip; reports arrive with the version and a one-click rollback; What's New drafted by CE for Tim to approve. M each. Tim number: no.
21. **UX-MGR-07, 11, 12, 13 Manager pages (contracts only).** Who is on which version and AutoCAD year; the admin home with office health; the colleague view (version, Report, Roll back only); the report view with "Send to Claude chat". M total for the engine and contracts; windows Codex. Tim number: no.
22. **UX-MGR-05 colleague-side "Go back one version".** One click, with "are you sure", and it actually happens at the next start. M. Depends on BUG-441 (installer accepts an older version) being proven. Tim number: no.
23. **M-SET-01 Move My Settings onto the release line.** The Save and Load my settings buttons (built as #424/#425, Opus MERGE) reach a Civil train. S. Tim number: no (INT: everyone sees the button, folder "CE Settings Transfer").
24. **Area B import wiring and UX-SURV-01/02/04.** The ribbon's import button opens the new import window; levels filled from a survey are marked "Survey"; a revised survey is compared with the old one and the effects listed; anyone approves the survey, recorded. M. Tim number: no.
25. **CDSETUP later slices and UX-DES-01 deferred parts.** Council rule review, area confirmation, accepted-design hand-off to CDCALC, During and Finish; the "Not in markup" list wired to real drawn items; "differs from supplied design" marks. L. Tim number: no.

After these: BUG-061 evidence search (read-only study, job numbers only, Tim authorised INT-071 15a; M), the privacy leftovers A9 (rename project-record files) and the #954 outbox switch, UX-LEARN-01 slices 3 to 5 (office learning through Manager, promote to an office rule, cite past projects; L), the council rulebook rulings 02, 03, 04, 06, 07, 10 and 16 that still need sourced values (M), UX-OVERNIGHT-01 slices 2 to 7 (L), and Batches 10, 11, 12, 19, 20, 22 once carded (section 3).

---

## 3. build/04, Civil UI side (drafting behaviour; the windows themselves are Codex's): the next 25, in order

Base as for build/03. build/04 owns Batch 1, 2 (drafting side), 4, 5, the L3 engines and the C01/C02 conventions once carded. Before taking any Batch 2 or 6 item, read TEAMLANE3's newest entry: both Civil lanes pick from NEXT_FIXES and two chats must never touch the same file (RULES 6.4).

1. **BUG-561, BUG-560, BUG-559 fix rounds (#987, #989, #988).** A number-only Edit Pit Save no longer swaps a detention pit's grate and solid sides; a click on a pit body counts as that pit; the re-import explanation line appears. S. Depends on Opus review. Tim number: no.
2. **Opus fix rounds on #983 (Settings > AI section), #985 (CDASK on the Model tab offers From file only) and #992 (contextual tab stays put, DRAFT OFF).** S. Tim number: no.
3. **Batch 1 card: Tidy labels moves pit labels and cover levels (INT-074 Q6).** CDTIDYLABELS re-places pit number and cover text in the same preview as pipe labels. M. Depends on #837. Tim number: no (answered).
4. **Batch 1 card: no clear spot, move it out with a leader (INT-074 Q12).** When a label cannot fit, CE first rearranges neighbouring CE labels, then moves it out with a leader, and only then lists it. M. Depends on item 3. Tim number: no (answered).
5. **Batch 1 card 1.9 ROTATE and MIRROR keep CE text readable (INT-074 Q10).** After an AutoCAD ROTATE or MIRROR, pipe and pit text reads the right way up and stays where it was. M-L. Depends on #850 (rule exists, not hooked). Settings switch, OFF. Tim number: no.
6. **Batch 1 leftovers: PP cover text in tidy, flip and checks (INT-074 Q3); Edit Pipe re-tidies inside its preview and batch Edit Pipe cleans markers.** S-M. Depends on #849, #839, #823. Tim number: no.
7. **Batch 2 card 2.2 the Checks palette command.** CDCHECKS opens a docked list of findings that stays open while you work (the list is Codex's; the command, the palette host and the feed are build/04's). M. Depends on #836. Tim number: no.
8. **Batch 2 card 2.6 wire the progress line.** Anything over a second shows status-bar progress with Cancel. M. Depends on #1003. Tim number: no.
9. **Batch 5 card 5.2 wrong-layer reader for pipes and text, with the Fix.** Checks lists a CE object on the wrong layer, pre-ticked, one U to fix. M. Depends on #926, #960. Tim number: no.
10. **Batch 5 card 5.4 existing and demolished status.** Edit Pit's status field (Codex) sets EX or TO BE REMOVED; removed items leave the checks and the schedule; "TO BE REMOVED" text placed. M. Depends on #912, #948. Tim number: no (INT-077 4: connected existing council pits do go on the schedule).
11. **INT-077 item 7, bring the footing plan in.** One command attaches the Structural footing plan as a read-only Xref and reads the footings. M. Tim number: no (options first in the PR comment, as the desk asked).
12. **Batch 5 card 5.7 zone of influence engine.** Pipes inside a footing's influence line are listed with a suggestion; "angle not set, pipes near footings were not checked" until Tim types the angle. M. Depends on item 11. Tim number: yes (the angle), default blank.
13. **L3-LEVELS: the "Level 3 proposals" place in Project Review (INT-071 12c) and the one-engine check.** Project Review gets a Proposals page with the levels proposal; CDRULES and the solver read one rulebook. M. The page is Codex's; build/04 does the feed. Tim number: no.
14. **L3-SOURCES PlaceMany remainder and entry.** Each proposed downpipe shows its line to the tank or pit, a failed batch rolls back whole, the hidden CDPROPOSESOURCES command calls it. M. Depends on #821, #751, #755. Tim number: no (INT-071 12a to c).
15. **L3-DETENTION slice 6 combination options and the both-tank-types view (INT-072 5).** An option may mix pipe storage on several runs with pit storage and a tank; a council like Glen Eira sees the fully underground tank and the split option side by side. M. Depends on #752, #756. Tim number: no.
16. **L3-DETENTION slice 2 footing and service clearances, blank.** The clash check reads two Settings clearances that say "not set" and lists "not checked" until typed. S-M. Tim number: yes (two numbers), default blank.
17. **L3-DETENTION slice 4 the writer.** Accept an option: CDWT tank, the storage pipes and the D+F Apply preview land as one U. L. Depends on build/03 item 7 (C4 B6). Tim number: no (INT-071 13a).
18. **L3-NETWORK slices 4, 5, 3, 6.** CE counts each person's own networks (five before it proposes), learns fewest pits / shortest pipe / usual set-off, feeds the clash check and chooser, and Accept applies ticked changes as one U with changes to existing pits as unticked rows. M, L, S-M, M-L. Tim number: no (INT-059 7 and 8, INT-071 14a to c).
19. **Area E: New Pit plan anchor, Edit Pit pending preview, Inspector compact Edit hand-off.** New Pit ghosts where it will land; Edit Pit previews before Save; Edit works from the compact Inspector. M. Tim number: no.
20. **UX-PIPE-07 "Keep as a free end" for the whole job.** The choice is remembered across the job's drawings, not one drawing. M. Depends on a shared job record (build/03 CDSETUP). Button is Codex's. Tim number: no (ruled whole job).
21. **Batch 4 engine remainders.** First-use tip lines for about ten more commands; the CE panel health line (after item 7), find box and bell count feeds; the Civil/Structural button that follows the drawing. M. Depends on #853, #855, #856. Tim number: no.
22. **UX-MSG producers.** The bell actually receives a failure, a colleague-holds-the-drawing notice and an update-ready notice. M. Depends on the C-1 bell (OFF). Tim number: the save reminder minutes only; default none.
23. **UX-CMD-03 pit half and UX-UNDO-01.** PIT opens on the last pit size and type; CE Undo steps carry plain names in the Undo list (needs a Codex probe of what AutoCAD shows). S, S-M. Tim number: no.
24. **Transition names switch (INT-075).** "Tidy labels (CDTIDYLABELS)" style on ribbon labels, menus, tooltips, window titles and help, behind "Show AutoCAD command names" default ON. M, Civil half (build/02 takes the Structural half). Tim number: no.
25. **No blue on anything printed (BUG-517, Civil half).** The computations sheet prints the practice name and rule line in black or gold; the Civil light-theme accent token changes once; the 406 ribbon icons and window chrome are Codex's. M. Tim number: no.

After these: CD-BRANCH-01 second long-section profile (M), UX-CR-02 lid class from the surface, UX-CR-04 AGI as its own system, UX-CR-06 shared council base, UX-CR-16 Banyule rear fall (M each), E-HOLD-01 cascade preview after MOVE (L, blocked on the #88 probe being run in AutoCAD by the tester, not on Tim), and Batches 7, 8, 9, 21 once carded.

---

## 4. What truly needs Tim's own answer (one batch for the desk; builders do not wait)

Each carries the default the lanes build on now. Numbers Tim has not given are never invented: the feature says "not set".

1. **Two clearance distances for detention and storage pipes and tanks, in metres:** (a) from a footing, (b) from an existing service (INT-072 4, INT-076 6, INT-078: still open). Default now: blank, "clearance not set, not checked". Example: a storage pipe 0.4 m from a footing would be flagged if your number is 0.6.
2. **Zone-of-influence angle for pipes near footings, in degrees, and whether from the horizontal** (INT-077 8). Default now: blank, "angle not set". Example: with 45 degrees from the horizontal, a pipe 1 m below a footing is flagged within 1 m of it.
3. **Minimum clearance to a crossing service on the long section, in mm, one number or per service** (Batch 8/9 Q8). Default now: blank. Example: a sewer crossing P2-P3 at 120 mm turns red if your minimum is 150.
4. **Markup "same place" distance between rounds, in mm on the printed sheet** (Batch 8/9 Q13). Suggested start 15 mm. Default now: every new comment is a new item (safe).
5. **Where the loaded markup belongs: per drawing in memory (a), saved in the drawing (b), or one at a time with the drawing named (c).** Recommend (a). Builders go on (a).
6. **BUG-496 where the job record lives:** in the drawing (a), in the job folder (b), or this PC only, said plainly (c). Recommend (a). Builders go on (a).
7. **BUG-478 the update route a colleague follows:** Manager runs the existing activator when AutoCAD next closes (a), or a separate double-click installer is rebuilt (b). Recommend (a). Builders draft (a) behind the honest wording.
8. **Update channel, Tim's own actions in Azure and the signing set-up:** re-mint the admin key (the write key returns "forbidden"), fix the signing-key mismatch, publish the three-lane build, write the read key back into Manager. Nothing in UX-MGR-01, 04, 05 or 08 can be seen working until this is done.
9. **BUG-483 move the old install scripts and builds in the office folder to an OLD folder** (publishing, so Tim's call). Recommend yes.
10. **Retaining wall band table and fence table (S4 open questions 1 and 2).** Default: layout built, every size "Unknown, engineer to fill".
11. **SPS master detail: which file, and the storage rule** (UX-SPS Q1, Q3). Default: "detail not set"; the duty-point engine still runs.
12. **CDWT four-tab hydraulics and detail scope:** go or park. Recommend park until the C02 details batch (9) is carded.
13. **Retire CESTRUC and settle the duplicate pairs SDS/TDS, THC/PFC/SFC, EXCELCAPTURE** (UX-STRUC-05, 03). Recommend keep the S names and retire the launcher once the families exist.
14. **UX-UNIT-01 how a unit is picked and where the copies go.** Recommend window pick, then base points, mirror line.
15. **STRUC-COMPS calculation methods** (every method needs engineer sign-off before any size is proposed). Recommend timber beams first, from the CE_COMPSHEET spreads.
16. **Tie-down real names for TD1, TD2, TD3.** Default placeholders stay.
17. **Max Mishchenko's write access to "CE Plugin Pilot Results" on SharePoint** (Tim grants it himself).
18. **Master branch copy-forward after you have seen Civil 3.0.44 at your desk** (TIM_BATCH_TESTING Q1). Recommend yes, after.
19. **Window pictures of Edit Pit and Edit Pipe as the reference** (TIM_BATCH_TESTING Q5). Approve when you next look.
20. **Other AutoCAD versions:** skip until a colleague on an older version reports, Autodesk cloud runner before they install (TIM_BATCH_TESTING Q3). Recommend (c) now, (a) later.
21. **Confirm that "the rest I am happy with" (INT-078) covers the Set C list** (eight places where a code number and your Settings number disagree). If not, say which to keep.

---

## 5. Plan items with no builder yet (orphans) and who should take them

Source: REVIEW_BATCHES_2026-10-09 (173 UX items with no card and no commit on 9 Oct; Batches 1 to 6 and 13 to 15 have cards since). The design lane writes each batch card with recommended answers first (about two cards a run); the named lane builds on them under INT-073.

1. **Batch 7, C01 plan conventions (UX-CPLAN-01 to 05, 08 to 12):** fixed legend block, Pit Schedule on C01, EX items greyed, the three standard remarks, no MIN., note blocks by council, tank callout, LPD note at the connection, existing services labelled with a clash check, legend gaps in Checks. Lane: build/04. L.
2. **Batch 8, C01 notes, legend and sheets (UX-CPLAN-15 to 17, NOTES-05/06, SHEETS-03/04, SCHED-03):** C02 titled by content, details auto-packed then draggable, charged linetype, the full notes template plus council notes, Excel checking sheet. Lane: build/04. L.
3. **Batch 9, C02 details, outfall and tanks (UX-DET-07/09, CPLAN-31 to 34):** CE offers the details C01 uses filled with job sizes, bedding per material, penetration and sawcut details, the outfall drain plan and schedule. Lane: build/04. L.
4. **Batch 10, site (UX-OLF-01 to 04, SITE-02/03, SLAB-01/02, POOL-01/02):** overland route proposed from levels, neighbour warning, every overflow goes somewhere, floor freeboard, joint proposals, spoon drag with live fall, pool backwash note. Lane: build/03. L.
5. **Batch 11, council tools (UX-CR-01, 02, 04, 06, 07, 16):** discharge enquiry letter, lid class from surface, AGI own system, shared council base, outfall distance at Design start, Banyule rear-fall question. Lane: build/03. M-L.
6. **Batch 12, survey and WSUD (UX-SURV-01/02/04, WSUD-01/04):** build/03 (items 24 above and the WSUD details from the CE Library). M.
7. **Batch 16, detail library, details sheets and tags (UX-DET-01 to 06, STRUC-09b):** one CE Library palette, any engineer approves standards, numbered linked details in a learned grid, smart tag placement. Lane: build/02 (engine), Codex (palette). L.
8. **Lane S3 family (UX-NOTES-02 to 04 and 07 to 11, SYM-02/03, SEC-01 to 03, SHEETS-01/02):** S01 notes assembled from office blocks, geotech note filled, step and level symbols, section marks with linked frames, member sections, footing-plan legend. No log mentions any of it. Lane: build/02 after cards. L.
9. **Batch 17, issue and drawing standards (UX-REG-01 to 03, 06, 08, STDS-01 to 03):** build/02 for the register side, build/03 for the Civil standards clean-up at issue. M-L.
10. **Batch 18, names and ribbon (UX-NAMES-01 to 03, 05, 06, RIBBON-05 to 07):** build/04 Civil, build/02 Structural, Codex for the icons and the final tooltip pictures (Tim: final images before the colleague release). M.
11. **Batch 19, other people's drawings (UX-DWG-02/03, ARCH-01 to 03, MIX-02):** older CE drawings upgrade on open with one U, clean linework for people without CE, revised background "what moved" review, Replace background. Lane: build/03 (Civil half), the STRUC-ARCH-BACKGROUND evidence study first (design lane, read-only on 2 to 3 real job folders, job numbers only). L.
12. **Batch 20, Ask CE (UX-AI-01 to 07):** only after the privacy gate items 10 and 11 are green; "Draw these" from markup items, Explain on every finding, rule questions with the source cited. Lane: build/03. L.
13. **Batch 21, proposals feel, checklist, job notes (UX-L3-25/26, CHK-01 to 03, NOTES-01):** build/04 for the L3 part, build/03 for the job checklist and notes. M.
14. **Batch 22, Manager day to day (UX-MGR-04 to 13):** build/03 items 19 to 22 above cover the engines; cards still wanted for the pages. M.
15. **Batch 23, Settings page (UX-SET-02, 03, 05, 06):** search box, per-value history, the gold "This job" tag, the LPD note box. Lane: Codex (window) with build/03 for the history store. M.
16. **Drawing production packages DP-0 to DP-7** (DRAWING_PRODUCTION_PLAN, all "planned", nothing measured): fold into Batches 7 to 9 and 16 to 17 rather than run as a separate workstream. No lane today; desk decision.
17. **Manager product plan M01 to M07:** planned only; fold into Batch 22. No lane today.
18. **UX-SL3-01/02 whole-plan framing proposal and the learned framing study (Batch 13 card 13.6):** build/02 after DATA-01 clearance and the first ten counts Tim asked to see. L.
19. **UX-LEARN-01 slices 3 to 5 and UX-OVERNIGHT-01 slices 2 to 7:** build/03 (listed after its 25). L each.
20. **E-HOLD-01 and BUG-160 (the Keep-your-number / Use-automatic window after a grip drag):** the probe #88 has never been run; tester lane runs it, then build/04 builds the preview and Codex the small window. L.
21. **UX-MIX-01 to 03 (V3 drawings on a 2022 to 2026 PC):** no AutoCAD below 2027 on this PC; tester lane, Autodesk cloud runner is Tim's decision (section 4 item 20).

---

## 6. The biggest risks to "everything built by about 20 Oct"

1. **The pipe after building is narrower than building.** 599 open PRs, one GitHub merge since 1 Oct; every PR needs an Opus review, a train, a finalizer, a payload and an install, and installs are one Civil and one Structural per Codex check. Codex sits at 82 percent with a 95 stop until the Wed 14 Oct reset. Building another 75 items by 20 Oct is possible; reviewing, installing and seeing them is not at today's rate. Suggested lever: a second Opus review lane on the Team account, and the Claude driver pass counted as the install check (already ruled 10 Oct 05:55).
2. **Windows are Codex's and Codex is testing.** Every engine above lands OFF behind a window that does not exist: Checks palette, Level 3 choosers, the Batch 3 look, splash and welcome card, Manager pages, Settings rows for about 30 new switches. "Built" will keep rising while Tim sees nothing new. This needs a Codex build allocation, or Tim's word that Claude may build named windows (the CDWT exception already exists).
3. **Stage 1 of the master plan is still open.** REDO after U (BUG-256, BUG-558) and the save-close crash (BUG-224) are unaccepted. Until they pass, nothing built on top can be accepted, and the sweep keeps finding REDO killers in Idle and activation paths in both modules.
4. **The denominator grows faster than the builds.** Open bugs went from 340 (7 Oct) to about 490 (10 Oct) as the hunts and audits filed findings. The percentage will fall even on good days; watch the open count and the installed count, not the percentage.
5. **About 100 plan items have no card.** The design lane writes about two cards a run. Batches 7 to 12 and 16 to 23 plus the S3 family need roughly 14 cards before any builder can start them; at two a run that is a week of design runs on its own.
6. **Stale headers idle the lanes.** Cards approved in the rulings file still say DRAFT; the lanes trust the header. Desk action today: update the status line of K-REQ-01, REPAIR-DECIDE-LATER, DETENTION-PIT-ANNOTATE, C4, UX-RIBBON-01 and the Batch 1 to 6 and 13 to 15 cards to "approved for build under INT-073, answers in <file>".
7. **Two Civil lanes, one file set.** build/03 and build/04 both read NEXT_FIXES and both touch LinkService, the Pit Schedule and the Batch 2 and 6 files. RULES 6.4 says name the owner before a line changes; the queue above splits them, but the lanes must read each other's newest log entry before starting.
8. **Four engineering numbers are Tim's and missing** (two clearances, the angle, the service clearance, the markup distance). The features ship saying "not set", which is safe but looks unfinished and cannot be tested for real.
9. **Privacy gate items 10 and 11 are still OPEN** until the driver pass on 3.0.44 and 1.0.113 is green; the Claude page sender (Batch 15 slice 5) needs a DATA-01 sign-off before it is written. No colleague install before then, whatever else is built.
10. **AutoCAD on the PC blocks the speed work.** Both speed items need AutoCAD closed for before-and-after numbers; only the free windows work for them.
11. **Only AutoCAD 2027 is installed.** The 2022 to 2026 lanes are built and unit-tested and have never run anywhere.

---

## 7. How much of V3 is built, in two figures (estimates, counted the recount way)

1. **Built: about 56 percent. Installed: about 52 percent.** Denominator = the 509 UX plan IDs plus the open carpark bugs (about 490 today), roughly 1,000. "Built" = the ID is named in a commit on the live release lines or in an open draft PR. "Installed" = named in a commit inside the installed builds (Civil 3.0.44 build b7eed253, Structural 1.0.113 build 2e0cf385).
2. **How I got there.** The recount helper's last run (PROGRESS_COUNT_2026-10-09b, Fri 9 Oct 14:40) gave Built 54 percent (532 of 984) and Installed 50.5 percent (497 of 984) at Civil 3.0.41 and Structural 1.0.110. Since then three Civil trains (C-28/29, C-30, C-35) and three Structural trains (S-28/29, S-30/31, S-35) were installed, about 45 PRs, and about 30 more draft PRs were opened (#977 to #1007), while about 15 bugs were added. I did not re-run the recount scripts; the two figures are that count moved forward by those deltas, so treat them as plus or minus three points.
3. **The plan-only view (UX IDs, no bugs):** about 265 of 509 named in any commit (52 percent), about 240 of 509 inside the installed builds (47 percent), 173 with neither a card nor a commit on 9 Oct, about 100 of those still without a card today.
4. **The honest third figure.** Codex-tested 7 percent, PASS-only about 1 percent, Tim-accepted 0, and most "built" items are switched OFF or hidden. The four words stay separate: built, tested, installed, accepted (RULES 4).

---

## 8. What I could not check

1. Nothing was opened in AutoCAD; every "not built" is a reading of plan files, logs, PR titles and command names on the rel heads, not of the drawing.
2. I did not re-run the recount scripts; section 7 is the 9 Oct count moved forward by hand.
3. `gh pr list` returned the newest 400 of 976 PRs in detail; older PRs are counted, not read.
4. The TEAMLANE2 log is 320 KB; runs 102 to 131 were read in full, earlier runs by search. TEAMLANE3 and 4 were read from their 7 Oct entries on.
5. Whether INT-078 "the rest I am happy with" covers the Set C file is not recorded anywhere; section 4 item 21 asks.
6. Whether UX-SUB-04's arrow half and S4 slice 5's piers-along-strips exist in code is unclear from the plan; build/02 checks the code before building them.
7. The September window PRs (#125, #126, #139 to #149, #172, #173) are "built, not Tim-accepted" in the area file; I did not trace them into the installed builds.
8. The four helper agents' lists were checked against the logs and decisions where they mattered (the approved-but-DRAFT cards, the lane "not done" lines, the rel heads, the installed DLL versions), not line by line.

---

## Summary

The lanes are idle because the plan's approval state is scattered, not because the plan is built: three cards Tim approved on 25 Sep, the C4 steps B5 to B8, and a dozen of his 8 to 9 Oct answers are sitting unbuilt behind DRAFT headers and "needs a card" log lines, and about 100 UX items have no card for the design lane to hand over. The queue above gives build/02 25 Structural items (nine HUNT2 bugs, the member schedule command, the markup QA chain, the register slices, retaining walls), build/03 25 Civil-engine and Manager items (speed first, Set C, the three approved cards, the C4 Apply and Issue steps, the Manager pages, the update route) and build/04 25 drafting-side items (the Batch 1, 2 and 5 leftovers, the Level 3 slices Tim already answered, the panel and bell feeds), each buildable now as a DRAFT behind a Settings switch with the recommended answer as its default. Twenty-one questions genuinely need Tim, led by four engineering numbers and the Azure update-channel keys, and none of them stops a build. V3 stands at roughly 56 percent built and 52 percent installed by the recount method, with Tim-accepted still zero; the real limits on "everything built by 20 Oct" are the review-and-install pipe, Codex owning every window while it is busy testing, and Stage 1's REDO and crash bugs still open.
