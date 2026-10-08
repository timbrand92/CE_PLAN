**Code read on Structural rel-20261009f 9babe787** (installed Structural 1.0.110, train S-27; read with `git archive` into a scratch folder, no checkout; never master).

# Batch 13 card: the framing plans, roof down (first Structural roof-down batch), 9 Oct 2026

## Tim's answers (Fri 9 Oct about 08:30, INT-075; note added by design run 8)

Tim answered `TIM_BATCH_QUESTIONS_4_5_2026-10-09.md` by number. For this card (questions 9 to 15), verbatim: "9. p1 for purlins p1 for
timber posts both apply, typically they dont appear on the same jobs 10. depends on project and layouts 11. as recommended 12. as
recommended 13. as recommended 14. as recommended 15. as recommended". So:
1. **Question 9 OVERRIDES the recommendation:** "P1" is used for **both** purlins and timber posts; they typically do not appear on the same
   job. **No separate purlin letter.** If both appear on one job, CE warns (R-27) and never blocks. Card 13.2's "P is a timber post ...
   purlins tag P1 today ...: the clash is the question" and recommended answer 3 below are **superseded 9 Oct**: the roof groups keep P for
   posts AND purlins, and the member schedule lists whichever the job has.
2. **Question 10 OVERRIDES the recommendation:** the member schedule's position "depends on project and layouts". Desk interpretation: CE
   **asks each time, per layout, and remembers it per project** (offers the last answer for that layout as the default). Card 13.2's "first
   time asks Framing / Separate, default Framing" and recommended answer 4 below are **superseded 9 Oct**.
3. **Questions 11 to 15 as recommended:** beam hover status words "calc approved", "calc done, not approved", "no calc yet", "Unknown";
   tie-down TD1 strap / TD2 bolted / TD3 proprietary stay placeholders until Tim names them; one "Roof-down help" switch, trialled on Tim's PC
   for a week; beam layers stay BEAM / BEAM LOWER (no S); past-job counting later, after Tim sees the first ten counts.
4. **House rules from the same answers:** **no blue** in any window (gold, black, white / grey); **plain name and command name together**
   during the transition, e.g. "Member schedule from plan (CSMEMBERSCHEDULE)", behind a Settings switch "Show AutoCAD command names",
   default ON.
5. Builders build on these answers without waiting (INT-073, extended to this card by the desk at 08:05). Windows are Codex's.

**Status: DRAFT. Not approved by Tim.** Under INT-073 (Tim, Fri 9 Oct about 05:50: "the builds should not be hung on me answering
questions") builders MAY build this card on the **Recommended** answers below, as DRAFT PRs, tests red first, every new behaviour behind
a Settings value and OFF where it changes what a drafter sees, nothing retired, no old command removed, locked layers / Xref / REFEDIT
protection unchanged. Tim's answer by number in `TIM_BATCH_QUESTIONS_4_5_2026-10-09.md` (questions 9 to 15) replaces a recommended
default in a follow-up.
Written by design lane run 7 (headless, Opus), Fri 9 Oct 2026 about 06:10 Melbourne (PC clock). Read-only on plugin code. "Today" is
read from the Structural release commit `9babe787` (branch `claude/rel-20261009f`) and the Codex reports in
`C:\Lisp Files\_TEST_COPIES_20260923`. Code lines are not proof of what installed Structural 1.0.110 does on screen.
**Numbering:** this is **Batch 13** in `REVIEW_BATCHES_2026-10-09.md` ("framing plan, roof down"), the first Structural batch. The
desk's question file calls it "batch 5" (the fifth batch carded): same thing.

**Items (9):** UX-STRUC-13 (the order), UX-FRM-02, UX-FRM-03, UX-FRM-07, UX-FRM-08, UX-FRM-12, UX-FRM-13, UX-SL3-02, UX-D2-05b.
**Commands touched:** CSPLANLEVEL, CSLOADPATH, CSPOINTLOAD, CSLEVELCARRY, CSFDNPROPOSE (the roof-down chain); beam commands `1`, `2`,
BDL; AB, BB, BT1, CSBRACINGPANEL, CSBRACINGREQUIRED, CSTIEDOWN, CSTIEDOWNTYPES; XCLMTXT, STRSCHEDCREATE / REFRESH / SYNC; CSFRAMINGLEGEND;
the 2027 beam and column grips (CESTRUCGRIPEDIT). New: a **member schedule from the plan** command (engine exists), a **beam hover
line**, a **Bracing** pick-a-wall option.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`: UX-STRUC-13 (26 Sep 10:10), UX-D2-05b (26 Sep 09:41), UX-SL3-01/02
(26 Sep 09:54), "Framing plans" 26 Sep 10:43 (UX-FRM-02, 03), "Framing plan conventions confirmed" 26 Sep 11:09 (UX-FRM-07, 08, tags),
"Framing plan display" 27 Sep 17:18 (UX-FRM-12, 13, 14); `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` INT-053 (roof-down
production card: go), INT-059 item 15 (markers from the floor above: "Trial 1 week"), INT-062 (member schedule groups, roof title,
roof and floors are SEPARATE drawings). Evidence: `04_REFERENCE\structural\JOBS_PROCESS_STUDY_2026-10-04.md` section 2 (six jobs,
anonymised), `FRAMING_PLAN_PRACTICE_2026-09-26.md`.
**Related cards (do not build twice):** `STRUC-ROOF-DOWN-PRODUCTION_CARD_2026-10-04.md` (the whole flow and the boring-end assistant);
`UX-SSCHED-05_MEMBER_SCHEDULE_FROM_PLAN_CARD_2026-10-04.md` (answered INT-062; the schedule's rows and groups); `UX-SUB-04_POINT_LOAD_
CARRY_DOWN_CARD_2026-10-04.md` (answered INT-062); `CARD_UX-FRM-01_FRAMING-LEGEND_2026-10-07.md`; `CARD_UX-FRM-04-06_LINTEL-SUPPORT-
PROPOSALS_2026-10-07.md`; `CARD_UX-FRM-05_ROOF-AREA-SETOUT_2026-10-07.md`; `CARD_UX-FRM-11_FLOOR-SPAN-ARROW_2026-10-07.md`;
`CARD_UX-LEVEL-02_OVER-UNDER-ITEMS_2026-10-07.md`; `S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md` (footings, last).

**Who does what (INT-073: windows stay Codex's):**
1. **Claude (behaviour):** every command, prompt and command-line answer; the member schedule command and its per-job memory; the beam
   hover line (it is a cursor line, not a window); layer names as Settings values; the bracing pick-a-wall option and the per-wall-line
   totals sum; Settings; tests.
2. **Codex (windows):** the bracing panel window (CSBRACINGPANEL: its layout, the per-wall-line list, bringing it to the front, Pass 18
   item 68), the Propose footings window (CSFDNPROPOSE, comments only today), any Settings page rows' look; and every AutoCAD acceptance run.

---

## Card 13.1 — UX-STRUC-13: roof first, then upper floors, ground floor, footings last

1. **Tim ruled (26 Sep 10:10):** "Structural jobs are drafted and designed top down (roof, upper floors, ground floor, footings last);
   loads traced downward; the footing plan is the last plan." Repeated 4 Oct: "WE NORMALLY DRAFT AND DESIGN FROM ROOF DOWNWARDS". INT-062:
   roof and floors are **separate drawings** from the start.
2. **Today, the chain exists in pieces, nearly all switched OFF:**
   - **Plan level:** CSPLANLEVEL, live. "Pick a number, type a new level name, or type Unknown to clear. Enter confirms <X>:"; Esc "Level
     not changed."; office list Ground, First, Second, Roof (`PlanLevelCommands.cs:14`, `UserSettings.cs:1741`).
   - **Roof point load:** CSPOINTLOAD: "Pick the roof point load position (for example the girder truss seat):", "Load in kN, or press
     Enter for Unknown <Unknown>:", one U per marker; carry-down OFF (`RoofPointLoads.MarkerEnabled`, `CarryDown`, `DrawingsShareOrigin`
     all false, `UserSettings.cs:1281-1299`; called from `PointLoadCommandService.cs:113, 139`).
   - **Markers from the level above:** inside CSLOADPATH, OFF (`LoadPath.TraceFromLevelAbove = false`, `UserSettings.cs:1330`), grey on
     layer "CE LOAD FROM ABOVE"; with no level set: "This plan's level is not set, so the markers say "from the level above". Type
     CSPLANLEVEL to set it." (`FoundationService.LoadPath.cs:120`). Tim chose a one-week trial on his PC (INT-059 item 15): not yet done.
   - **Columns and walls carried across as (O) / (U):** CSLEVELCARRY, OFF (`LevelCarry.Enabled = false`, `UserSettings.cs:1366-1380`):
     "Carry from the level [Above/Below] <Above>:", "Accept? [Yes/No] <Yes>:". The Settings comment at line 1362 still says "engine only,
     no command": out of date.
   - **Propose footings:** CSFDNPROPOSE, OFF: "Propose footings is not switched on in this version. Nothing was proposed or drawn."
     (`FoundationService.Proposal.cs:34`).
3. **What works:** each piece has Esc = nothing changed and one U; the plan level record; the honest "level not set" line.
4. **Wrong or missing:** nothing tells the drafter the ORDER or where they are in it; four switches must be found and turned on one by one;
   the carry-down across separate drawings (INT-062 item 2) is a build prerequisite still open in the UX-SUB-04 card.
5. **Classification: MODIFY** (join the pieces; no new engine).
6. **Proposed:**
   - **One switch** in Structural Settings: "Roof-down help (markers from the level above, carried items, footing proposals)" that turns the
     four existing switches on together (each still settable alone). Default OFF; Tim's trial turns it on for his PC (INT-059 item 15; question 13).
   - **CSPLANLEVEL asks itself**: the first time any roof-down command runs on a plan with no level, it asks the CSPLANLEVEL question in
     the same command (no "type CSPLANLEVEL" detour). Esc there: the command stops, "Level not set. Nothing was changed."
   - **Where am I line:** CSLOADPATH's first line names the plan and the level above it: "First floor plan. Level above: Roof (S07 roof
     framing.dwg, 4 point loads, 6 posts)." When the level above has not been drawn yet: "Level above: Roof, not found in the job folder.
     Draw the roof first, or carry on." It never blocks (R-27).
   - Footings stay last: CSFDNPROPOSE on a plan whose level above has items with no support under them lists them first ("2 posts on First
     floor have nothing under them on Ground: Show where") and still lets the drafter carry on.
7. **Cancel / Esc / Undo:** unchanged: every piece writes nothing on Esc; each accepted step is one U.
8. **Discovery:** a "Roof down" line on the Structural ribbon's Foundations / Framing panel tooltip; the Start Here tour's Structural page.

## Card 13.2 — UX-FRM-07 and UX-FRM-02: the member schedule, and where it goes on each job

1. **Tim ruled:** FRM-07 (26 Sep 11:09) "Yes, like that": CE builds and updates "MEMBER SCHEDULE" (and "ROOF MEMBER SCHEDULE") on each
   framing sheet: MARK and SIZE, grouped by function, spec notes after the size. FRM-02 (26 Sep 10:43) "Varies": on each framing sheet or a
   separate schedule sheet; CE learns it per job and offers the job's pattern. INT-062: Recommended grouping, by mark number, same command for
   the roof with the title from the plan level, keep XCLMTXT too.
2. **Today:**
   - **XCLMTXT (Excel to schedule) is the live route** (`ExcelMTextCommands.cs:81`): fills the office MEMBER SCHEDULE block (1, 2 or 3
     columns, 31 rows a column; titles "ROOF MEMBER SCHEDULE", "FIRST FLOOR MEMBER SCHEDULE" ...; `ExcelMTextService.cs:3931-3941,
     4341-4353`). "Specify schedule block insertion point (or press Enter for 0,0,0):" (line 3574). Placement Settings: stacked from a base
     point, or a pick point per floor; "combine roof and first floor" off (`UserSettings.cs:826-854`). No undo mark found.
   - **The schedule from the plan is written but not reachable:** `Core/Schedules/MemberScheduleFromPlan.cs:132-218` builds MARK / SIZE
     rows from the marks drawn, groups from Settings, title from the plan level (a roof plan gives "ROOF MEMBER SCHEDULE"), Unknown when one
     mark is drawn with two sizes. **No command calls it.** Settings `MemberSchedule.Enabled = false`; groups "STRUCTURAL SUPPORTS" [C, PC,
     SC, DS, TS], "{LEVEL} MEMBERS" [FB, L, OR, PB, RB, RL, RA, WT, BB, GB, GL, MB, LBR], "COMMON MEMBERS" [FJ, TR, WP]
     (`UserSettings.cs:997-1030`). Rafters R, roof joists RJ, girder trusses RT and lower roof beams LRB are in no group.
   - **STRSCHEDCREATE / REFRESH / SYNC** make bracing, bored pier and tie-down tables only (`UtilityCommands.cs:62-94`).
   - No memory of where a job's schedules go.
3. **What works:** XCLMTXT and the office block; the engine's grouping and Unknown rule.
4. **Wrong or missing:** a command; the roof groups; per-job placement memory.
5. **Classification: MISSING** (command, memory) / **KEEP** (XCLMTXT, unchanged, INT-062 item 8).
6. **Proposed:**
   - New command **CSMEMBERSCHEDULE** (name per UX-NAMES rules; ribbon Schedules > "Member schedule from plan"): reads the marks on this
     plan, shows the rows on the command line as a preview ("ROOF MEMBER SCHEDULE: 3 groups, 14 marks, 1 size Unknown (RB3 drawn as two
     sizes)"), "Place it [Here/Last place/Sheet] <Last place>:", then "Accept? [Yes/No] <Yes>:". Run again: the same schedule updates in
     place (no second copy).
   - **Roof groups** (Settings, used when the plan level is Roof): "ROOF BEAMS" [RB, LRB, RGB], "LINTELS" [L, RL], "RAFTERS AND PURLINS"
     [R, RJ, RT], "STRUCTURAL SUPPORTS" [C, PC, SC, DS, TS, P]. Question 9 (P is a timber post; purlins tag P1 today in
     `RafterJoistCommands.cs:54-66`: the clash is the question).
   - **FRM-02 memory:** after a schedule is placed, CE records in the job (not the drawing alone): which layout or sheet and which corner.
     Next plan in the same job: "Last place" = the same corner of that plan's own framing sheet, or the same separate schedule sheet if that is
     where the last one went. First time on a job: asks "On this framing sheet or a separate schedule sheet? [Framing/Separate]
     <Framing>" (question 10).
   - More than 3 columns: a second block beside it (UX-SSCHED-07, already ruled).
7. **Cancel / Esc / Undo:** Esc or No: "Nothing was drawn." One accepted placement or update = one U. A locked schedule layer: "The
   schedule layer is locked. Nothing was drawn." (never unlocked).
8. **Discovery:** ribbon; the first-use tip; CSFRAMINGLEGEND's last line "Member schedule: CSMEMBERSCHEDULE".

## Card 13.3 — UX-FRM-03 and UX-FRM-08: bracing and tie-downs on the framing plan

1. **Tim ruled:** FRM-03 (26 Sep 10:43) "On the framing plan" (not a separate bracing plan). FRM-08 (26 Sep 11:09) "Yes": pick a wall,
   choose Type A (strap) or Type B (ply); CE draws the symbol, keeps the legend entry and totals bracing per wall line for the bracing
   calculation. FRM-14 (27 Sep 17:21, later): tag + running total, required vs provided per direction, green when enough.
2. **Today:**
   - **AB, BB, BT1** (`BracingCommands.cs:13, 130, 246`; also STRUCAB, STRUCBB): two clicks, "Specify first point of bracing:", "Specify
     second point of bracing (drag preview):", then "Toggle flip? [Yes/No] <No>:" (skipped when CE can tell the side). Layers "WALL BRACING
     TYPE A", "... TYPE B", "... TYPE BT1". Esc: "Operation cancelled." **No undo group found.**
   - **CSBRACINGPANEL** (a window that stays open) and **CSBRACINGREQUIRED**: required vs provided **per direction** (North-South,
     East-West); "Required North-South bracing (mm), or blank to leave <...>:". No per-wall-line totals. Codex Pass 18 item 68 FAIL: "says
     Bracing panel shown, no panel visible"; the release code carries the BUG-218 fix (opened through AutoCAD's own modeless call, placed
     top-right) but **Codex has not re-tested it** (a Codex task, not a question for Tim).
   - **Legend:** "DENOTES TYPE A BRACING" / "DENOTES TYPE B BRACING" via CSFRAMINGLEGEND, OFF (`FramingLegend.Enabled = false`,
     `UserSettings.cs:1048, 1091-1098`).
   - **CSTIEDOWN:** "Tie-down type [TD1/TD2/TD3] <TD1>:", "Specify tie-down location:", block CE_TIEDOWN on layer "TIE DOWN"; types are
     placeholders (TD1 Strap, TD2 Bolted, TD3 Proprietary) managed by CSTIEDOWNTYPES. Codex Pass 18: placement PASS, "TD1/TD2/TD3 require
     another command to learn descriptions; label crowds the symbol". No undo group found.
3. **What works:** bracing and tie-downs already go on the framing plan (FRM-03 holds today); the per-direction panel; the layers.
4. **Wrong or missing:** pick a wall (today: two clicks); one U per placement; per-wall-line totals; tie-down type names in the prompt.
5. **Classification: KEEP** (FRM-03) / **MODIFY** (FRM-08).
6. **Proposed:**
   - AB and BB gain a **Wall** option: "Specify first point of bracing or [Wall]:". Wall: "Select the wall line:" (a loadbearing wall line or
     any line on the wall layers), then "Bracing length along the wall, or Enter for the full wall <3600>:", then the side if CE cannot tell.
     The two-click way stays exactly as today (default).
   - Every AB, BB, BT1 and CSTIEDOWN placement becomes **one U** (an undo group around it), and Esc says "Nothing was drawn."
   - **Per wall line totals:** the bracing panel lists each wall line (grouped by direction) with its bracing length, plus today's required vs
     provided per direction, green when enough (FRM-14). A wall line = bracing symbols on one straight line within 300 mm (Settings).
   - CSTIEDOWN prompt shows names: "Tie-down type [TD1 strap/TD2 bolted/TD3 proprietary] <TD1>:" (the names come from Settings; still
     placeholders until Tim or the computations name them, question 12).
   - Turning on CSFRAMINGLEGEND is that card's business (UX-FRM-01); this card only keeps the bracing lines in step.
7. **Cancel / Esc / Undo:** as above. **Native protection:** a locked bracing layer refuses with the layer named; nothing unlocked.

## Card 13.4 — UX-FRM-12: hover over a beam shows mark, size, span, status

1. **Tim ruled (27 Sep 17:18):** "Mark, size, span, status", e.g. "FB3 · 250 x 90 PFC · 3.6 m · calc approved".
2. **Today:** no hover line on beams (no PointMonitor or beam tooltip found). On AutoCAD 2027 only, the beam and column **grips** have
   tooltips: "CE: move this beam end; its label keeps its place. Right-click while moving for Edit this only or Disconnect."
   (`StructuralFrameGripOverrule.cs:145-156`). A click-to-inspect palette exists (`SelectedBeamInspectorPresenter.cs`, "No beam selected").
   No beam carries a "calc approved" status anywhere.
3. **Classification: MISSING.**
4. **Proposed:**
   - When the cursor rests on a CE beam (after a short rest, Settings, default 0.5 s), one line beside the
     cursor: "FB3 · 250 x 90 PFC · 3.6 m · status". Only CE beams (found through CE's own link record), never other lines, so AutoCAD's own
     hover and right-click menus are untouched (the UX-D2-05b lesson).
   - **Status words** (question 11): "calc approved", "calc done, not approved", "no calc yet", "Unknown". Until the Structural computations
     store a result per beam (UX-SCALC), every beam says "no calc yet". Span = the beam's drawn length between its supports, to 0.1 m.
   - Settings: "Show beam details under the cursor" default **OFF** until Codex accepts it (R-27, INT-073); speed guard: off by itself in a
     drawing where it would take over 50 ms.
5. **Undo:** nothing written. **Esc:** nothing to cancel.

## Card 13.5 — UX-FRM-13: beam lines at the plan's level, and lower beams

1. **Tim ruled (27 Sep 17:18), typed:** "at level on layer beams, beams lower on beams lower layer thats it". Layer names are Settings
   values seeded from Tim's words; the block "BEAM LOWER" already exists in the typical file.
2. **Today:** beams go on layer **"BEAM"** (colour 4, Continuous) and lower beams on **"BEAM LOWER"** (colour 2, HIDDEN), text on "25TEXT"
   (`BeamDraftingStandards.cs:18-27`, `LayerService.cs:87-88`). These names are fixed in the code, not Settings. Which layer is decided by
   the command typed: `1` regular, `2` lower (`BeamPlacementCommands.cs:55-69`); BDL draws one of each ("BEAM LOWER offset side [...]:",
   line 136). "BEAMS" / "BEAMS LOWER" (with an S) appear nowhere as layer names.
3. **What works:** the rule Tim typed already holds: at-level beams on one layer, lower beams on another, nothing else.
4. **Wrong or missing:** the names are not Settings values; Tim's words say "BEAMS" while every drawing CE makes says "BEAM".
5. **Classification: KEEP** (behaviour) / **MODIFY** (names into Settings).
6. **Proposed:** two Structural Settings values, "Beam layer" and "Lower beam layer", **seeded with today's "BEAM" and "BEAM LOWER"**
   (so no drawing changes; question 14 asks Tim whether he meant the S). The beam commands, the lintel proposals (`LintelProposalSettings
   .BeamLayer`) and the beam admission check read the Settings value (one code path). If Tim picks "BEAMS", old drawings are not renamed;
   Checks lists a beam on the other name as a pre-ticked safe fix (UX-LYR-02).
7. **Undo / Esc:** unchanged.

## Card 13.6 — UX-SL3-02: which past framing layouts CE learns from

1. **Tim ruled (26 Sep 09:54):** learn from layouts where the **engineer marked up little**, that were **issued without later changes**,
   with the **fewest members for the spans**. Not ticked: "Council/certifier had no RFI". UX-SL3-01: one whole-plan proposal following the
   engineer's markup.
2. **Today:** no whole-plan framing proposal and no learning from past layouts (no SL3 or ranking code). The nearest: CSLINTELPROPOSE is
   rule based (`Core/Framing/LintelProposalPlanner.cs`); XCLMTXT has a past-job index for Excel schedules only.
3. **Classification: MISSING** (later; it needs the drawing-intelligence corpus, `C:\CE_DrawingIntelligence`, local only, DATA-01).
4. **Proposed now (a builder can start without Tim):** only the **pure ranking rule**, tested, no AutoCAD: given a past job's three numbers
   (count of engineer markup items on the framing sheets, revisions after the first construction issue, members per 10 m2 of floor),
   rank layouts best first; any number not known is Unknown and that layout ranks below known ones (never guessed). The weights are Settings
   values, default equal. Nothing reads real jobs until the corpus step is approved (question 15).
5. **Undo / Esc:** not applicable (no command yet).

## Card 13.7 — UX-D2-05b: beams and columns as CE's own kind of object (later, separate stage)

1. **Tim ruled (26 Sep 09:41):** "Yes, plan it": a later, separate stage with its own card and a 2027-first rollout; not scheduled against the
   D2 work.
2. **Today:** no custom object; a 2027-only grip overrule filtered to CE beams and supports, with a deliberate comment that a hover menu would
   replace AutoCAD's own on every line (`StructuralFrameGripOverrule.cs:31-41, 59-80`); grip click runs CESTRUCGRIPEDIT with Together / Only /
   Disconnect, one U, Esc changes nothing (`ConnectedGripJig.cs:82-88`, `StructuralGripEditCommands.cs:90-163`).
3. **Classification: KEEP as planned-later.** **No build in this batch.** Recommended: it waits until Civil's one-piece pipe (C7) has
   passed Codex on 2022 and 2027 (the same technique, proved once first). This card only records that 13.4's hover line is done WITHOUT it.

---

## Recommended answers a builder may use now (INT-073)

1. One "Roof-down help" switch, default OFF; Tim's PC trial turns it on.
2. CSPLANLEVEL asked inside the first roof-down command on an unlevelled plan.
3. ~~Roof groups as in 13.2; P stays a post (purlins keep P1 only as the rafter tool's tag until Tim answers).~~ *(superseded 9 Oct by
   Tim's answer 9: P1 for purlins and timber posts both; warn if both on one job; see "Tim's answers" at the top)*
4. ~~Member schedule "Last place" memory per job; first time asks Framing / Separate, default Framing.~~ *(superseded 9 Oct by Tim's
   answer 10: ask each time per layout, remember per project; see the top)*
5. Bracing Wall option added beside today's two clicks; one U per placement.
6. Wall line = within 300 mm on one straight line (Settings).
7. Beam hover OFF by default; every beam "no calc yet" until UX-SCALC stores results.
8. Beam layer names Settings, seeded "BEAM" and "BEAM LOWER".
9. SL3-02: pure ranking rule only.
10. D2-05b: not built.

## Tests (automated, before Codex)

1. The "Roof-down help" switch sets the four existing switches; each can still be set alone; OFF leaves CSLOADPATH exactly as today.
2. A roof-down command on a plan with no level asks the level once; Esc says "Level not set. Nothing was changed." and writes nothing.
3. CSMEMBERSCHEDULE on a roof plan with RB1-RB3, L1, R1, C1, DS1: title "ROOF MEMBER SCHEDULE", groups in Settings order, marks by number;
   RB3 drawn twice with two sizes gives Unknown; re-run updates the same block (block count unchanged); one U removes the placement.
4. Placement memory: second plan in the same job offers the first plan's corner; a plan in another job asks Framing / Separate.
5. AB with Wall on a 3.6 m wall line: one symbol along the wall, one U removes it; two-click AB unchanged; Esc writes nothing.
6. Bracing per wall line sums equal the per-direction totals.
7. Hover line text for a test beam is "FB3 · 250 x 90 PFC · 3.6 m · no calc yet"; no line for a plain AutoCAD line.
8. Beam layer Settings: `1` and `2` draw on the Settings names; the default names equal today's.
9. Ranking rule: equal numbers tie; an Unknown ranks last.

## Example drawings

1. Synthetic only (no real job, DATA-01): Codex's Structural copies in `C:\Lisp Files\_TEST_COPIES_20260923` (DWG-S_X1 from Explore 1;
   the C1 column copies from W28), copied to a new test job folder holding **two separate drawings**, roof and first floor (INT-062 item 2),
   both with the plan level set.
2. A framing plan with at least: RB1-RB3, L1, R1, FJ1, C1, DS1, TS1, one loadbearing wall line 3.6 m, two bracing walls, one tie-down.

## Tim's AutoCAD checklist (about 10 minutes; Codex first, on the two-drawing test job)

1. **Order:** open the roof drawing, place a girder truss point load (CSPOINTLOAD). Open the first floor drawing, run CSLOADPATH. **Should
   see:** "First floor plan. Level above: Roof ..." and a grey marker where the load lands; nothing prints.
2. **No level:** on a new drawing, run CSLOADPATH. **Should see:** CE asks which level this plan is, right there.
3. **Member schedule:** on the roof drawing, Schedules > Member schedule from plan. **Should see:** "ROOF MEMBER SCHEDULE", grouped, by
   mark; Accept; U removes it; run again on the first floor: it offers the same corner.
4. **Bracing by wall:** AB, then Wall, pick a wall line, Enter. **Should see:** Type A along the wall; the bracing panel shows that wall line
   and the direction total; U removes it in one go.
5. **Hover (after switching it on):** rest the cursor on FB3. **Should see:** "FB3 · size · span · no calc yet". Rest on a plain line:
   nothing.
6. **Layers:** draw a beam with `1` and a lower beam with `2`. **Should see:** BEAM and BEAM LOWER, as today.

## Code references (Structural release commit 9babe787)

Under `Modules\Structural\`: `Commands/PlanLevelCommands.cs:14`; `Services/PlanLevelCommandService.cs`; `Commands/LoadPathCommands.cs:12`;
`Services/FoundationService.LoadPath.cs:86, 120`; `Services/FoundationService.LoadTrace.cs:66`; `Services/PointLoadCommandService.cs:113,
139`; `Services/LevelCarryCommandService.cs:24`; `Commands/FootingProposalCommands.cs:12`; `Services/FoundationService.Proposal.cs:34`;
`Core/Schedules/MemberScheduleFromPlan.cs:132-218` (no caller outside tests); `Core/Schedules/MemberScheduleBlockSplitter.cs:54`;
`Commands/ExcelMTextCommands.cs:81`; `Services/ExcelMTextService.cs:2675, 3574, 3931-3941, 4341-4353, 5309-5313`; `Services/
XclmTxtService.cs:273, 325`; `Commands/UtilityCommands.cs:62-94`; `Services/ScheduleService.cs:193-236`; `Commands/BracingCommands.cs:13,
124, 130, 240, 246`; `Services/BracingService.cs:552-554, 1739`; `Commands/BracingPanelCommands.cs:20-40, 89`; `Commands/TieDownCommands.cs:16,
56`; `Services/TieDownService.cs:139`; `Services/StructuralFrameGripOverrule.cs:31-41, 59-80, 145-156`; `Services/ConnectedDesign/
SelectedBeamInspectorPresenter.cs`; `Services/StructuralGripEditQueue.cs:30`; `Services/ConnectedGripJig.cs:82-88`;
`Commands/StructuralGripEditCommands.cs:24, 90-163`; `Services/BeamDraftingStandards.cs:18-27`; `Services/LayerService.cs:87-88`;
`Commands/BeamPlacementCommands.cs:55-69, 136, 1446`; `Commands/SupportBlockCommands.cs:66-114`; `Commands/RafterJoistCommands.cs:54-66`;
`Commands/FramingLegendCommands.cs:13`; `Core/Framing/LintelProposalPlanner.cs`; `Models/XclmTxtFloorConvention.cs:38-55`;
`Models/UserSettings.cs:743-748, 826-854, 997-1030, 1048, 1091-1098, 1205, 1281-1299, 1330, 1362-1380, 1741`. Under
`Modules\Structural.DesignCore\ConnectedDesign\BeamAtomicCommitAdmission.cs:28, 37` (the "BEAM" / "BEAM LOWER" names again).
Not found on that commit: a member schedule command, per-job schedule placement memory, a beam hover line or beam calc status, per-wall-line
bracing totals, a pick-a-wall bracing option, any custom beam object, any whole-plan framing proposal or ranking code.
Codex: `CODEX_TEST_REPORT_PASS18_2026-09-28.md` items 68 and 69 and ANNOYING items 12 and 20; `CODEX_TEST_REPORT_PASS17_2026-09-28.md` R8;
`CODEX_EXPLORE1_REPORT_2026-09-29.md` items 2, 3 (XCLMTXT, STRSCHEDCREATE).
