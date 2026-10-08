**Code read on Structural rel-20261009f 9babe787** (installed Structural 1.0.110, read from the bundle DLL product version on Fri 9 Oct
about 08:42; read with `git show` / `git grep` on that commit, no checkout; never master).

# Batch 14 card: the Structural schedules, roof down (second Structural roof-down batch), 9 Oct 2026

**Status: DRAFT. Not approved by Tim.** Under INT-073 (Tim, Fri 9 Oct about 05:50: "the builds should not be hung on me answering
questions"), extended by the desk at 08:05 to every batch card with recommended answers, builders MAY build this card on the
**Recommended** answers below, as DRAFT PRs, tests red first, every new behaviour behind a Settings value and OFF where it changes what a
drafter sees, nothing retired, no old command removed, locked layers / Xref / REFEDIT protection unchanged. Tim's answer by number in
`TIM_BATCH_QUESTIONS_6_7_2026-10-09.md` (questions 9 to 15) replaces a recommended default in a follow-up. **Engineering values are not
covered:** the lintel specifications, concrete strengths and wall reinforcement are never typed by CE; they stay blank / UNKNOWN until Tim or
the drafter types them (RULES 12, R-00, ST6-4).
Written by design lane run 8 (headless, Opus), Fri 9 Oct 2026 about 08:55 Melbourne (PC clock). Read-only on plugin code. Code lines are
not proof of what installed Structural 1.0.110 does on screen.
**Numbering:** this is **Batch 14** in `REVIEW_BATCHES_2026-10-09.md` ("member schedules"), the second Structural batch after Batch 13. The
question file calls it "card 7": same thing.

**House rules from Tim's answers of 9 Oct (INT-075), apply to everything below:**
1. **No blue** in any window this card touches (gold, black, white / grey).
2. **Plain name and command name together during the transition**, e.g. ribbon "Lintel table (CSLINTELTABLE)", behind the Settings switch
   "Show AutoCAD command names", default ON; the plain name stays the main name.
3. **Roof down** (UX-STRUC-13, Tim 26 Sep and 4 Oct): this card is ordered the way a job is drafted: roof and upper floor schedules first,
   then the ground floor walls, footings and piers last.
4. **Tim's Batch 13 answers that touch schedules (INT-075):** "P1" is used for BOTH purlins and timber posts (no separate purlin letter;
   warn if both appear on one job); the member schedule's position "depends on project and layouts": ask each time per layout and remember
   it per project.

**Items (5):** UX-SSCHED-04 (beam schedule table), UX-SSCHED-03 (masonry lintel table, and the live wall schedule), UX-SSCHED-12 (wall
schedule from the typical-file block), UX-SSCHED-01 (footing and bored pier schedules, sideways), UX-SSCHED-02 (mark prefixes per type).
**Commands touched:** the member schedule from the plan (Batch 13.2), XCLMTXT; new Lintel table and Wall schedule commands; FSTEXPORT /
CSFOOTINGSCHEDULE, CSRCBEAMSCHEDULE, STRSCHEDCREATE / STRSCHEDREFRESH / STRSCHEDSYNC; FPFC, FSF, BP, CSPIER, FEDIT; CSMARKSRENUMBER; LBW,
CSBSMTWALL.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`: "Structural schedules layout" 27 Sep 10:10 (UX-SSCHED-01..04), "Framing
member schedule and beam marks" 27 Sep 10:58 (UX-SSCHED-05..10, UX-MARK-07, 08), "Office typical-file schedules" 27 Sep 11:10
(UX-SSCHED-11..13), "Plan notes and the (O) / Ex. tags" 27 Sep 17:07 (UX-NOTES-09 corrects "(O)"); `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_
RUN.md` INT-062, INT-073, INT-075. Evidence: `04_REFERENCE\structural\STRUCTURAL_SCHEDULES_PRACTICE_2026-09-27.md` items 1-6, 12-13 (one job,
anonymised); `JOBS_PROCESS_STUDY_2026-10-04.md` section 2.2 item 6, 2.3 item 5, 2.5 item 4 (six jobs).
**Related cards (do not build twice):** `BATCH13_STRUC_ROOF_DOWN_FRAMING_CARD_2026-10-09.md` card 13.2 (the member schedule command);
`UX-SSCHED-05_MEMBER_SCHEDULE_FROM_PLAN_CARD_2026-10-04.md` (its rows and groups); `S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md` (UX-RAFT-01,
RAFT-04: the footing and R.C beam schedules, built in S4 slice 1); `CARD_UX-FRM-04-06_LINTEL-SUPPORT-PROPOSALS_2026-10-07.md` (lintel marks).
**Flag for the builder:** the two member schedule cards name the command differently (CSMEMBERSCHED in the 4 Oct card, CSMEMBERSCHEDULE in
Batch 13.2). **Recommended: CSMEMBERSCHEDULE**, matching CSFOOTINGSCHEDULE and CSRCBEAMSCHEDULE; one name only.

**Who does what (INT-073: windows stay Codex's):**
1. **Claude (behaviour):** every command, prompt and command-line answer; the schedule engines (which rows, which columns, UNKNOWN cells,
   typed cells kept by mark, update in place); the prefix list and numbering; filling the office blocks; Settings values; tests. A schedule
   table or block drawn in the drawing is drawing output, so Claude's.
2. **Codex (windows):** the concrete strength field in the footing editor (FEDIT / Foundations Manager window) if one is added; the Settings
   page rows' look (prefix list, lintel table rows); and every AutoCAD acceptance run (it looks at the printed schedule in a layout).

---

## Card 14.1 — UX-SSCHED-04: the beam schedule table on the framing sheet (roof and upper floors first)

1. **Tim ruled (27 Sep 10:10):** "Beam schedule table". Beam sizes live in a beam schedule table on the framing sheet; its layout "will be
   read from more jobs and confirmed with Tim (not yet seen in the sample)".
2. **What the later evidence showed (27 Sep 10:58 and 4 Oct):** on the office framing sheets, beam sizes sit in the **member schedule**
   ("FIRST FLOOR MEMBER SCHEDULE", MARK | SIZE, groups such as Floor Beams, Lintels, Lower Roof Beams; practice items 8-11). The six-job study
   found that member schedule on 4 of 6 jobs and **no separate beam table** (section 2.2 item 6). The only other beam table seen is the
   **R.C BEAM SCHEDULE** for band beams on suspended slabs (2 of 6, section 2.2 item 8), which sits on the footing / slab sheet.
3. **Today:** XCLMTXT fills the office MEMBER SCHEDULE block from Excel (Batch 13.2 has the detail); the schedule-from-plan engine exists with
   no command (`Core/Schedules/MemberScheduleFromPlan.cs:132-218`, Settings `MemberSchedule.Enabled = false`); CSRCBEAMSCHEDULE places the
   sideways R.C beam schedule for raft beams EB / IB (`Commands/FoundationScheduleCommands.cs:20-21`; band beams BB join "once CE has a band
   beam tool", `Assets/Config/command-registry.json` around line 5570).
4. **Interpretation (desk, not Tim's words; question 9):** the "beam schedule table" Tim ruled IS the member schedule's beam groups; nothing
   separate is built.
5. **Classification: KEEP** (covered by Batch 13.2, no second table).
6. **Proposed:** no new command. Batch 13.2's member schedule (roof title "ROOF MEMBER SCHEDULE" from the plan level) carries every beam
   group; its position follows Tim's Batch 13 answer (asked per layout, remembered per project). If Tim answers that a separate beam table
   exists, the builder reads its layout from the live typical file first (as UX-SSCHED-09 says for the R.C beam schedule) and this card is
   re-opened.
7. **Undo / Esc:** as Batch 13.2.

## Card 14.2 — UX-SSCHED-03 (lintel part): the masonry lintel table, placed as a standard

1. **Tim ruled (27 Sep 10:10):** the masonry lintel table is placed as a standard from Settings.
2. **Evidence:** "Masonry lintel schedule and windowsill trimmer schedule in the notes. Seen in 6 of 6 (office boilerplate)" (six-job study,
   2.5 item 4); rows by SPAN range (under 1200, 1200-1500 ...) with LINTEL SPECIFICATION (practice item 5).
3. **Today:** nothing places a lintel table. The only lintel settings are mark prefixes (`Models/UserSettings.cs:628-631` "L,RL"; lintel
   proposals' `LintelPrefix` "L" at line 1193). The 26 Mar typical-file snapshot lists no block named for a lintel table
   (`Docs/CEMARKUP_Template/ce_typical_blocks_layers_schedules_notes.snapshot.json`; it lists "Block Wall Schedule", "A3 Footing Schedule",
   "Footing Schedule - Added Comments", "FIRST FLOOR MEMBER SCHEDULE - 2 COLUMNS", "SCHEDULE"). Where the office table lives is **not
   recorded** (a block under another name, or text in a notes block): question 10.
4. **Classification: MISSING.**
5. **Proposed:**
   - New command **CSLINTELTABLE**, ribbon Schedules > "Lintel table (CSLINTELTABLE)". It places the office masonry lintel table **exactly
     as the office has it**: from the live typical file when Tim names the block or drawing (question 10); CE copies it, never retypes it.
   - Until the source is named, the command says: "The office lintel table is not set up yet (Settings > Structural > Schedules > Lintel
     table source). Nothing was drawn." It does **not** build a table from invented spans or specifications (engineering values).
   - Prompts: "Pick the top-left corner of the lintel table:"; placed once per drawing; run again: "The lintel table is already on this
     drawing. Show where" (no second copy). Layer: the schedule layer Setting (today's footing schedule uses 25TEXT).
   - The windowsill trimmer schedule (seen beside it, 6 of 6) goes the same way once its source is named; not built now.
6. **Cancel / Esc / Undo:** Esc at the corner: "Nothing was drawn." One placement = one U. Locked schedule layer: "The schedule layer is
   locked. Nothing was drawn." (never unlocked).

## Card 14.3 — UX-SSCHED-03 (wall part) and UX-SSCHED-12: the wall schedule, live, in the office Block Wall Schedule

1. **Tim ruled:** 27 Sep 10:10, the wall schedule is live from the walls drawn, one row per wall (type, thickness, vertical / horizontal
   reinforcement, starter bars, fire rating); 27 Sep 11:10, "Use the typical-file block": CE fills the office **Block Wall Schedule** from the
   walls drawn, keeping its look.
2. **Evidence:** practice item 4 (one job): "one ROW per wall mark; columns WALL TYPE | WALL TYPE (THICKNESS) | WALL REINFORCEMENT (VERTICAL,
   HORIZONTAL) | STARTER BARS | FIRE RATING; notes box under it". Marks W / BW; "(O)" over this level and "(U)" under (UX-NOTES-09,
   UX-LEVEL-02).
3. **Today:**
   - The office block **"Block Wall Schedule"** is in the typical file (snapshot above). Nothing fills it.
   - **No wall record carries a mark, type, thickness or reinforcement.** LBW draws a loadbearing wall line from two picks ("Select LBW start
     point (bottom of wall line):", `Commands/LoadBearingWallCommands.cs:16, 33-100`); CSBSMTWALL draws a basement wall system with its
     thickness from Settings ("Basement wall drawn: reinforced wall, ... mm thick", `Services/BasementWallService.cs:204`); WALLREO and
     WALLSTRS are placeholders (`Commands/ReinforcementDetailCommands.cs:15-16`).
4. **Classification: MISSING.**
5. **Proposed (question 11):**
   - **Which walls:** masonry and concrete walls that carry a W or BW mark (prefixes on Settings, card 14.5), including the basement wall
     from CSBSMTWALL; timber stud walls (LBW) are **not** in the wall schedule.
   - **A wall mark:** a new option on the wall tools and a small command **CSWALLMARK** ("Select the wall:", "Wall mark <W1>:", "Wall type
     [Block/Concrete/Other] <Block>:", "Thickness in mm, or Enter for Unknown <Unknown>:"); same size and type share a mark, most common first
     (UX-MARK-06, as footings).
   - New command **CSWALLSCHEDULE**, ribbon Schedules > "Wall schedule (CSWALLSCHEDULE)": fills the office Block Wall Schedule, one row per
     mark, keeping its look. CE fills what it knows (mark, type, thickness); **reinforcement, starter bars and fire rating are typed by the
     drafter into the schedule and kept by mark on every update**, exactly as the footing schedule keeps typed reinforcement today
     (`Services/FoundationScheduleBuilder.cs:72-74`). Anything not known shows UNKNOWN, never a guess.
   - Updates in place after a wall is marked, changed or erased; run again = update, not a second copy. Over / under walls from another level
     (W1(O)) are listed only if Tim says so (not in this batch).
6. **Cancel / Esc / Undo:** Esc at any prompt: "Nothing was changed." One mark or one schedule placement / update = one U. Locked layer:
   refused with the layer named. The office block is used as it is, never exploded.

## Card 14.4 — UX-SSCHED-01: footing and bored pier schedules, sideways (footings last)

1. **Tim ruled (27 Sep 10:10):** "Copy exactly". Sideways: one column per mark with its type written under it; rows FOOTING TYPE, WIDTH
   MINIMUM, DEPTH MINIMUM, REINFORCEMENT, COMMENTS; a band grouping columns by concrete strength; default f'c in the title ("U.N.O.").
   Bored pier schedule the same (practice item 2: own title "BORED SCHEDULE (F'c = 40MPa)", capping beam included).
2. **Today:**
   - **The footing schedule is built (S4 slice 1, PR #431):** FSTEXPORT (ribbon "Footing schedule") and the hidden typed name
     CSFOOTINGSCHEDULE (`Commands/CeTextCommands.cs:97`, `Commands/FoundationScheduleCommands.cs:16-17`). One column per mark in the order
     pad, strip, edge beam, internal beam, thickening, bored pier (`Services/FoundationScheduleBuilder.cs:81-100`); rows FOOTING TYPE / WIDTH
     MINIMUM (mm) / DEPTH MINIMUM (mm) / REINFORCEMENT / COMMENTS (`129-135`); title "FOOTING SCHEDULE (F'c = 25MPa) U.N.O." from the strength
     typed, no strength at all when Unknown (`116-124`); missing width or depth UNKNOWN; reinforcement and comments typed into the cells and
     kept by mark; the most common size of a mark is the one shown, with a warning (`182, 233-243`). Prompts: "Concrete strength for the
     footing schedule title, in MPa, or Enter to leave it Unknown:", "Pick the top-left corner of the footing schedule:"
     (`Services/FoundationScheduleService.cs:303-304, 359`); REFEDIT and locked layers refused in plain words (`282, 294, 367`). Codex S4:
     "Footing schedule placed with 1 mark(s). CE updates it after each footing command." The type under the mark = the FOOTING TYPE row:
     matches the ruling.
   - **Missing from the footing schedule:** the **strength band** (columns grouped under "40 MPa CONCRETE" when some footings differ from the
     title strength). No footing carries its own strength today.
   - **Bored piers:** sit as BP columns inside the footing schedule. The separate **"BORED PIER SCHEDULE"** made by STRSCHEDCREATE is a
     different thing: one ROW per pier with columns MARK, DIA MM, **VISIBILITY, LAYER, HANDLE** (`Services/ScheduleService.cs:371-412`):
     software words on a printed schedule. STRSCHEDCREATE places **three new tables every run** (bracing, bored pier, tie-down) with no check
     for a set already there (`ScheduleService.cs:196-235`), no pre-flight in that path, and Codex found: REDO lost after U (VERIFYR2 R2.d03,
     VERIFYS1 W9.10), "schedule cells and text have incompatible sizes" (EXPLORE1 item 3).
   - The R.C beam schedule (EB / IB) is CSRCBEAMSCHEDULE (S4 card, RAFT-01): not this card.
3. **What works:** the footing schedule, its UNKNOWN rule and typed-cell memory; the title strength.
4. **Classification: KEEP** (footing schedule) / **MODIFY** (strength band; bored pier schedule) / **KEEP, hidden later** (STRSCHEDCREATE's
   bracing and tie-down tables, which Batch 13.3 and the tie-down schedule FRM-15 replace; nothing retired now).
5. **Proposed:**
   - **Strength band (question 14):** a footing may carry its own concrete strength (FEDIT option "Concrete strength in MPa, or Enter for the
     schedule's <25>:"; blank = the title strength). When any footing differs, the schedule groups those columns under a band "40 MPa
     CONCRETE" above them, exactly as the office drawing. No strength is ever invented: Unknown stays out of the band and is warned.
   - **Bored pier schedule in the office layout (question 12):** recommended, piers get **their own sideways schedule** "BORED PIER SCHEDULE
     (F'c = 40MPa)" (title strength typed, Unknown = no strength), one column per BP mark, rows PIER TYPE / DIAMETER (mm) / DEPTH (mm) /
     REINFORCEMENT / COMMENTS, capping beams CB as columns after the piers. Settings switch "Bored piers in their own schedule" (default
     **OFF** = today: BP columns stay in the footing schedule, INT-073); when ON, the BP columns leave the footing schedule.
   - **STRSCHEDCREATE (question 13):** it keeps working; its bored pier table becomes the office sideways schedule above (the VISIBILITY /
     LAYER / HANDLE columns are no longer printed; CE keeps that link inside the drawing where the drafter never sees it); a second run
     updates the set already there instead of placing three more; the whole command is one U and keeps REDO (fix of Codex R2.d03 / W9.10);
     cell sizes follow the text height (EXPLORE1 item 3). The bracing and tie-down tables are unchanged in this batch.
6. **Cancel / Esc / Undo:** Esc at the strength or corner prompt: "Nothing was drawn." One placement or update = one U. REFEDIT and locked
   layers refused as today.

## Card 14.5 — UX-SSCHED-02: mark prefixes per type, numbering restarts per prefix

1. **Tim ruled (27 Sep 10:10):** "Yes, per prefix". Marks carry type prefixes (PF, SF, CF, PC, BP, CB, EB, IB, RC, W ...); numbering
   restarts per prefix; the most common size within a type is 1 (UX-MARK-06); **the prefix list is a Settings value**. "(O)" = over the
   current level (UX-NOTES-09 corrects the first reading).
2. **Today:**
   - Footing prefixes are **fixed in the code**: EB, IB, TH, SF, PF, BP, SP (screw pile), ST (stump), anything else "F"
     (`Services/FoundationService.cs:4542-4556`). The pier tool's prefix is a Setting ("BP", `Models/UserSettings.cs:1574-1578`, marked
     "ASSUMED, Tim to confirm"). Missing from the code: **CF** continuous footing, **PC** pile cap, **CB** capping beam, the **G** forms seen
     on the office drawing (GEB, GIB, GPF: what G means is not recorded), **W / BW** walls, **RC** columns.
   - Numbering per prefix, most common first and gaps kept: **built** for footings and footing beams (CSMARKSRENUMBER,
     `Commands/CeTextCommands.cs:100`, `Services/FoundationService.Marks.cs:12-37`, `Core/Marks/MemberMarkEngine.cs:10-20`); columns have no
     registry yet (same file, lines 23-28).
   - Framing marks (FB, L, RB ...) have their own Settings lists (member schedule groups `UserSettings.cs:997-1030`; lintel, stud, joist,
     rafter prefixes at 1134-1254).
3. **Classification: KEEP** (numbering engine) / **MODIFY** (prefix list into Settings, missing prefixes added).
4. **Proposed (question 15):**
   - One Settings list "Foundation and wall mark prefixes": each row = prefix, what it is, which schedule it goes in. Seeded with today's EB,
     IB, TH, SF, PF, BP, SP, ST (no drawing changes) **plus** CF continuous footing, PC pile cap, CB capping beam, W wall, BW block wall, RC
     column. The G forms are added only when Tim says what G means.
   - `GetPrefixForKind` reads the Settings list (one code path); the footing, pier and wall tools offer the prefix from it.
   - "(O)" / "(U)" stay suffixes meaning over / under (UX-NOTES-09, UX-LEVEL-02), never part of the prefix.
   - P1 for purlins and timber posts (Tim, INT-075 item 9): framing, not this list; the warning when both appear on one job is Batch 13's.
5. **Undo / Esc:** changing the list changes no existing mark; a renumber stays the previewed, one-U CSMARKSRENUMBER.

---

## Recommended answers a builder may use now (INT-073)

1. No separate beam table: the member schedule (Batch 13.2, command name CSMEMBERSCHEDULE) carries the beams.
2. CSLINTELTABLE copies the office lintel table from the typical file once its source is named; until then it says so and draws nothing.
3. Wall schedule = masonry and concrete walls with W / BW marks (not stud walls); CSWALLMARK + CSWALLSCHEDULE fill the office Block Wall
   Schedule; reinforcement, starter bars and fire rating typed by the drafter and kept by mark.
4. Strength band from an optional per-footing strength (blank = title strength).
5. Bored piers in their own sideways schedule behind a switch, default OFF.
6. STRSCHEDCREATE's pier table in the office layout; second run updates; one U; REDO kept; bracing and tie-down tables unchanged.
7. Prefix list on Settings seeded with today's eight plus CF, PC, CB, W, BW, RC; G forms wait for Tim.

## Tests (automated, before Codex)

1. Member schedule on a roof plan includes every beam group; no other beam table is created by any command.
2. CSLINTELTABLE with no source set: the one "not set up yet" line and nothing drawn; with a test source block: one copy placed, a second run
   offers Show where and places nothing.
3. CSWALLMARK on two 190 block walls and one 150: W1 x2 (most common), W2 x1; CSWALLSCHEDULE rows W1, W2 with thickness, UNKNOWN reinforcement;
   a typed reinforcement survives a re-run and a wall erase / U; a stud wall (LBW) never appears.
4. Footing schedule with PF1 at the title strength and PF2 at 40: PF2 under a "40 MPa CONCRETE" band; an Unknown strength is warned and not in
   a band; the title unchanged.
5. Switch "Bored piers in their own schedule" ON: BP columns leave the footing schedule and appear in "BORED PIER SCHEDULE"; OFF: today's
   output byte for byte.
6. STRSCHEDCREATE twice: still one set of three tables; U removes the set; REDO restores it; the pier table has no VISIBILITY, LAYER or HANDLE
   text.
7. Prefix list: default list gives today's labels for every footing kind; adding CF lets FSF offer CF1; removing a prefix in use changes no
   existing mark.

## Example drawings

1. Synthetic only (no real job, DATA-01): Codex's Structural copies in `C:\Lisp Files\_TEST_COPIES_20260923` (the DWG-S family used by
   VERIFYS4 and DRIVER_RUN11, which already hold PF footings and a placed footing schedule), copied to a fresh two-drawing test job (roof
   and ground floor, INT-062), plan levels set.
2. Ground floor copy with: PF1-PF3 (one at 40 MPa), SF1, EB1, IB1, BP1-BP2 with a capping beam, two block walls (190, 150) and one stud wall.
3. A copy of the office typical file's lintel table source, once Tim names it (question 10): never a client drawing.

## Tim's AutoCAD checklist (about 10 minutes; Codex first; roof first, footings last)

1. **Roof sheet:** run the member schedule. **Should see:** "ROOF MEMBER SCHEDULE" with the roof beams in it; no other beam table appears.
2. **Framing sheet:** Schedules > Lintel table. **Should see:** your office lintel table, exactly as in your typical file (after you have
   named where it lives); run again: "already on this drawing".
3. **Ground floor walls:** mark two block walls, run Wall schedule. **Should see:** your Block Wall Schedule with W1 and W2, thickness filled,
   reinforcement UNKNOWN; type a reinforcement, run again: it stays.
4. **Footings:** give PF2 40 MPa in FEDIT, run Footing schedule. **Should see:** PF2's column under "40 MPa CONCRETE", title still "(F'c =
   25MPa) U.N.O.".
5. **Piers (after switching "Bored piers in their own schedule" on):** **Should see:** "BORED PIER SCHEDULE" sideways with BP1, BP2 and the
   capping beam; no LAYER or HANDLE words anywhere on the sheet.
6. **Old command:** STRSCHEDCREATE twice. **Should see:** one set of tables, not two; U then REDO brings it back.

## Code references (Structural release commit 9babe787)

Under `Modules\Structural\`: `Commands/FoundationScheduleCommands.cs:16-21`; `Commands/CeTextCommands.cs:97, 100`;
`Services/FoundationScheduleBuilder.cs:13-15, 65-75, 81-100, 106-111, 116-135, 182, 217, 233-243`;
`Services/FoundationScheduleService.cs:270, 282, 294, 303-304, 359, 367`; `Services/FoundationService.cs:4542-4556`;
`Services/FoundationService.Marks.cs:12-37`; `Core/Marks/MemberMarkEngine.cs:10-20`; `Services/ScheduleService.cs:196-235, 371-412`;
`Commands/UtilityCommands.cs:62-94`; `Core/Schedules/MemberScheduleFromPlan.cs:132-218`; `Models/UserSettings.cs:628-631, 997-1030, 1134-1254,
1574-1578`; `Commands/LoadBearingWallCommands.cs:16, 33-100`; `Services/BasementWallService.cs:204`;
`Commands/ReinforcementDetailCommands.cs:15-16`; `Assets/Config/command-registry.json:5525-5575`;
`Docs/CEMARKUP_Template/ce_typical_blocks_layers_schedules_notes.snapshot.json` (block and layer names only).
Not found on that commit: any lintel table or windowsill trimmer schedule, any wall schedule or wall record with mark / type / reinforcement,
a strength band or per-footing strength, a sideways bored pier schedule, CF / PC / CB / W / BW / RC footing-registry prefixes, a separate
beam schedule table.
Codex and driver: `CODEX_VERIFYS4_2026-10-02.md` S5-03; `CODEX_VERIFYR2_2026-10-01.md` R2.d03; `CODEX_VERIFYS1_2026-10-01.md` W9.10;
`CODEX_EXPLORE1_REPORT_2026-09-29.md` item 3; `CODEX_TEST_REPORT_PASS7_2026-09-24.md` items 53, 199, 210, 211; `DRIVER_RUN11_2026-10-03.md`
step 4.
