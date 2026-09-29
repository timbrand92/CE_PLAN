# S4 Foundations and walls: workflow card (30 Sep 2026, Opus card writer)

Queue lane S4 (`areas/release-v3-colleagues-QUEUE.md` line 416), **Needs Tim's engineering acceptance**.
Covers UX-FDN-01..05, UX-RAFT-01..04, UX-LOAD-01..03, UX-BSMT-04..06, UX-RW-01..11.
Authority: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` (cited as RUL + line), `V3_UX_PLAN.md` lines 152, 158,
308, 312, 320, `04_REFERENCE/CARDS/ST-06_FOUNDATIONS_REBAR.md` (ST6-1..15), `ENGINEERING_RULEBOOK.md` (R-00, R-27,
API guardrails, speed framework). Later rulings checked: `decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` (nothing
supersedes an S4 ID). Code read on `origin/claude/rel-20260929c-struc`.
**Every engineering value in this card: Needs Tim's engineering acceptance.** Codex accepts the mechanics only (RULES 4.5).

## 0. What already exists (read in code, not assumed)

1. **Foundation registry (ST-06, July):** `Modules/Structural/Services/FoundationService.cs` (3,696 lines) with
   `FoundationRegistryService.cs` (drawing dictionary `CE_FOUNDATION_DATA`, per-entity link `CE_FOUNDATION_LINK`),
   `FoundationMonitor.cs` (regenerates on driver edit), `Models/FoundationModels.cs` (kinds EB, IB, TH, SF, PF, BP;
   ScrewPile, StumpFooting, Hob, BlockWall reserved). Commands in `Commands/CeTextCommands.cs`: FST (FstManagerWindow),
   THC, PFC, SF, REB, RIB, FADOPT, FREGEN, FREGENALL, FEDIT, BP, SCREWPILE, STUMPFOOTING, FDELETE, FSTEXPORT,
   CSMARKSRENUMBER (marks by size, UX-MARK-06/08). No preview, no proposal. Layers hard-coded (`SLAB PERIMETER`,
   `SLAB INTERNAL BEAM`, `STRIP FOOTINGS`, `BORED PIER`, `25TEXT`): R-00 migration item.
2. **FSTEXPORT schedule:** a vertical MText list MARK / TYPE / SIZE / DEPTH / QTY. Does NOT match the office sideways
   schedule (`STRUCTURAL_SCHEDULES_PRACTICE_2026-09-27.md` items 1, 12, 13) or UX-RAFT-04's columns.
3. **Load path check (UX-LOADP-01/02, not S4):** CSLOADPATH, `Services/FoundationService.LoadPath.cs` +
   `Structural.DesignCore/LoadPathEngine.cs`. Same-drawing only; its header says UX-LEVEL-01/02 are not built. Offers a
   pad labelled "assumed size" from `LoadPathSettings` (AssumedPointLoadKN 20, AssumedAllowableBearingKPa 100).
4. **Loads from the roof (UX-SUB-04):** `Core/Roofs/RoofPointLoadCarryDown.cs`. **Loadbearing walls:** LBW
   (`Commands/LoadBearingWallCommands.cs`, block LOADBEARINGWALL). **Piers as plan symbols (UX-SYM-01):** CSPIER
   (`Services/BoredPierPlacementService.cs`, row with "N @ spacing CTS" dimension, live Bored Pier Schedule).
5. **Rebar:** RBL/RBC (`Commands/RebarCommands.cs`, `Services/RebarService.cs`); `Assets/Config/rebar-catalogue.json`
   (mass per metre, source stated in the file as AS/NZS 4671; laps as AS3600 Table 13.2.2). STR and BWT still
   registered although ruled for retirement (ST6-14). No bar marks, no bar schedule, no bar-note tool.
6. **Slab types (UX-SSCHED-10):** `UserSettings.SlabSettings` (per type: layer, hatch, thickness, mesh, cover, f'c,
   membrane, sand; all empty = Unknown) and `Structural.DesignCore/SlabLegendTextBuilder.cs` (tested, **not wired to any
   command**).
7. **Basements UX-BSMT-01..03 (built 27 Sep, commit 022aae5a, outside S4):** CSBSMTWALL, CSPUMPPIT, CSPUMPPITSCHEDULE,
   `BasementWallLayoutEngine.cs`, `BasementSuspendedSlabEngine.cs` (band beams never proposed). **Timber subfloor
   (UX-SUB-01/02):** CSSUBFLOORGRID, CSTAGBEARERS, CSSUBFLOORSET. **Waffle:** only the WAFFLE_HIDDEN hatch.
8. **Retaining walls:** no code. Block names exist only in the typical-file snapshot
   (`Docs/CEMARKUP_Template/ce_typical_blocks_layers_schedules_notes.snapshot.json`): SLEEPER RETAINING WALL, SLEEPER
   RETAINING WALL HATCH, 100UC15 SRW, 150UC23 SRW, 200x75 SRW, Bored Pier Retainin Wall (spelled as in the file),
   RETAINING WALL, WALLS BLOCK FENCE, HATCH 11 - FENCE WALL OVER, HATCH 231 - FENCE WALL UNDER, REINFORCEMENT ADDITIONAL.
9. **CE grips:** 2027 only, beams and columns (`Services/StructuralFrameGripOverrule.cs`, D2 slice 2). None on footings.

## 1. Classification (review gate)

1. **UX-FDN-01 propose footings (RUL 1432):** **Missing.** Strip under loadbearing walls (LBW), pad under columns,
   thickening under walls on slab; preview with marks; accept or adjust; one U. Sizes "from the footing calculation":
   that calculation is S5 (UX-SCALC-05, RUL 1266). Until it exists sizes are **Unknown, never invented** (ST6-4), or
   picked by the drafter from the FST size library (project information, ST6-3), tagged Manual.
2. **UX-FDN-02 footing grips (RUL 1435):** **Missing.** Same as beams: grips resize/move with live preview, supported
   walls/columns highlighted, Edit together default, Edit this only on right-click, one U.
3. **UX-FDN-03 piers along strips (RUL 1437):** **Missing** (CSPIER row placement **Keep**, reused). Spacing from the
   calc (Unknown until S5), plus corners and point loads; each pier adjustable.
4. **UX-FDN-04 bar marks + bar schedule (RUL 1439):** **Missing.** Each drawn bar (RBL/RBC) gets its mark; schedule of
   size, shape, length, number, mass builds and updates; changes highlighted. **Retire** STR/BWT registration
   (ST6-14, hide first; BWT's job moves into the schedule).
5. **UX-FDN-05 four tools (RUL 1604, conventions RUL 1629):** waffle pod slab **Missing** (pods 300 deep, ribs min 110,
   EB/IB/TH tags, numbered "WAFFLE POD RAFT SLAB NOTES"); timber subfloor **Keep** (UX-SUB built) + legend/schedule
   entries; screw piles **Modify** SCREWPILE (SP1-SP4 by design load, "SCREW PILE SCHEDULE (SAFE WORKING LOADS)",
   supplier certification note; missing block = warn and record, never a substitute circle: ST6-12 as limited by R-27);
   suspended/basement slabs **Keep** BSMT-03 + the RC beam schedule (RAFT-01).
6. **UX-RAFT-01 RC beam schedule (RUL 1548, BB facts 1557, 1600):** **Missing.** EB/IB/BB rows automatic, plan tags stay.
7. **UX-RAFT-02 infill as tracked area (RUL 1550, facts 1594):** **Missing.** Area, hatch 11IH, thickness + mesh note
   from Settings, IB/EB ribs with raft tags, excluded from raft checks and the footing proposal.
8. **UX-RAFT-03 footing-plan LEGEND (RUL 1597):** **Modify** (wire `SlabLegendTextBuilder` + symbol keys): bottom-left,
   raft slab note, keys for saw cuts, set-downs, columns, stud walls, thickness callouts, infill note; editable.
9. **UX-RAFT-04 footing schedule (RUL 1601):** **Modify** FSTEXPORT into the one schedule engine (ST6-14): office
   columns PF / EB / IB / TH / BP with width, depth, reinforcement, comments; sideways, typical-file block choice
   (UX-SSCHED-11/13, RUL 2145-2151).
10. **UX-LOAD-01 markers from above (RUL 1535):** **Missing.** Non-printing markers (posts, point loads, loadbearing
    walls) with their source on the level below. Needs a per-plan level (UX-LEVEL-01/02, RUL 2166): not built.
11. **UX-LOAD-02 (RUL 1538):** **Modify** CSLOADPATH into a quiet QA item with Show where when the level below is drafted.
12. **UX-LOAD-03 (RUL 1540):** **Missing.** Proposal uses every load traced down all levels; lists Unknowns above.
13. **UX-BSMT-04 reo bar tool (RUL 2354):** **Missing.** Draw extent; CE writes e.g. "3-N16-100 CTS x 5500 LG, TOP &
    BOTTOM" with extent arrows; length live with the extent.
14. **UX-BSMT-05 (RUL 2356):** **Keep as a rule:** no re-entrant corner bars on plan; additional-bar symbol
    (REINFORCEMENT ADDITIONAL) only from the reo bar tool.
15. **UX-BSMT-06 mesh from slab type (RUL 2360):** **Modify:** legends/notes read `SlabSettings` mesh, update on change.
16. **UX-RW-01..11 retaining walls (RUL 2298-2333, plan line 152):** **Missing**, grouped in section 3.

## 2. Foundations, rafts, loads, reinforcement: what the drafter does

1. **Load markers (LOAD-01/02):** the drafter sets the plan's level once (UX-LEVEL-01). Opening the level below shows
   grey non-printing markers "P1 from First floor", "Point load from roof R3". Anything with nothing under it is a quiet
   QA line with Show where. Nothing prints; nothing moves.
2. **Propose footings (FDN-01/03, LOAD-03):** ribbon Foundations > Propose footings (typed CSFDNPROPOSE). Pick the
   footing plan area (or Enter = whole plan). Preview: ghosted strips, pads, thickenings, piers at corners and under
   point loads, each with its mark; the Codex window lists every item with size or **Unknown**, source, and "Loads
   still Unknown above: 3". Accept all / Accept ticked / Adjust (pick an item, change size or move) / Cancel.
   From-markup jobs follow the markup and show differences (UX-MODE-01, RUL 1505); the proposal also feeds the
   one whole-plan proposal (UX-SL3-01, lane L4).
3. **Grips (FDN-02):** click a footing: CE grips at ends, middle and corners; drag = live preview, supported
   walls/columns highlighted; right-click the grip for Edit this only. 2022-2024: AutoCAD's plain grips, the registry
   regenerates after (as today), no preview.
4. **Raft pieces:** REB/RIB/THC keep working; infill = Foundations > Infill slab: pick or draw the area, CE hatches
   11IH, writes the thickness/mesh note, ribs tagged IB/EB. Legend and footing schedule update after each accepted
   change (changed objects only, speed framework item 2).
5. **Schedules:** Foundations > Footing schedule / RC beam schedule / Bar schedule: pick a point once; afterwards they
   update themselves. FSTEXPORT and BWT typed still work and point to the same schedule.
6. **Reo bar tool (BSMT-04/05, FDN-04):** Foundations > Reo bar: pick two points for the extent, choose count, size,
   spacing, face (command line keywords, defaults from RebarSettings); preview shows the arrows and the exact note;
   Enter places it with its bar mark; stretching the extent changes "x 5500 LG" and the bar schedule row.
7. **Prompts:** plain English, keywords in brackets, Enter = the shown default, Escape = nothing written.

## 3. Retaining walls UX-RW-01..11 (grouped)

1. **Start (RW-03):** Walls > Retaining wall (typed CSRW). Pick a line or polyline, or draw one; choose type (sleeper
   wall first: the three office blocks sleeper wall, post, bored pier, each with its hatch, RW-01).
2. **Layout rules (RW-02, RW-06):** posts at spacing along the line; post centred on pier, sleepers on the retained
   side; near a boundary: wall face on or just inside the boundary, pier offset inward; corners: PFC + UC post; a wall
   end against a wall/building/structure: PFC end post. Side of retained soil asked once with an arrow in the preview.
3. **Heights (RW-04):** retained height along the wall from survey and design levels both sides, split into height
   bands; each band picks post, pier and sleeper from the Settings table. Source order: Civil CE levels through the job
   (UX-XDISC-02, RUL 1868); where none, the drafter types levels at points (tagged Manual). No level = band Unknown,
   shown red in the preview, never guessed.
4. **Drainage (RW-05):** a tick "Add AG drain behind" (on) draws a CE AG run (UX-SURF-04) to a pit the drafter confirms.
5. **Plan tag and schedule (RW-07):** CE places the rotated dimension along the wall carrying the wall type; the
   retaining wall schedule is the office typical-file block filled per wall (UX-SSCHED-13).
6. **Section (RW-08):** the office retaining wall section from the library, post, pier and height filled (as UX-SEC-03).
7. **Either set (RW-09):** the tool lives in Structural; typed in a Civil drawing, Structural wakes by itself (Tim, 29 Sep
   16:20, item 4.4, HOLIDAY file); the other discipline sees it read-only.
8. **Fences (RW-10/11):** masonry fence walls: tag, footing, schedule row like other walls; timber/Colorbond fences:
   post footings. A "Fence on top" tick on a retaining wall adds the fence load, re-picks the post size, adds a plan note.
9. **Apply:** one Apply writes sleepers, posts, piers, hatches, dimension tag, AG run and schedule row: **one U**.
   Editing the wall line later re-lays it through a preview; manual moves of single posts are kept and flagged.

## 4. Cancel, Undo, save, protection, lanes

1. **Escape/Cancel** anywhere before Accept/Apply writes nothing (transients only). **One accepted operation = one U**:
   a proposal accept, a grip drag, one wall layout, one reo bar, one infill area.
2. **Save/reopen:** footing items stay in `CE_FOUNDATION_DATA`; new kinds (Infill, WafflePod, Bar, RetainingWall,
   FenceWall) extend the same registry with a schema version bump, old drawings read unchanged. Level and load markers
   are rebuilt from the records, never stored as loose geometry only.
3. **Protection:** locked layers, Xrefs, REFEDIT respected; nothing silently unlocked or exploded (AGENTS.md rule).
4. **2022-2024 lane:** everything except FDN-02's CE grips builds and runs on net48 too. Report "2022-2024: built and
   unit-tested, not AutoCAD-tested". **Unfinished items ship hidden** (queue section 5 item 5).
5. **R-27:** every check warns and records; no hard block anywhere in S4.

## 5. Settings page values (R-00): every one Needs Tim's engineering acceptance

1. **Existing, keep with tags:** LoadPathSettings (support tolerance 150 mm, assumed load 20 kN, assumed bearing 100 kPa,
   min pad 450 mm: all Assumed); RebarSettings defaults (Tim's PC values); rebar-catalogue mass per metre (source
   AS/NZS 4671 per file) and lap lengths (source AS3600 Table 13.2.2 per file); SlabSettings types (Unknown until filled);
   BoredPierPlanSettings.
2. **New, Foundations:** footing size library per type (from FST, Manual); pier spacing (Unknown until S5 calc);
   piers at corners (on, RUL 1437); thickening under wall on slab (Unknown); marker layer and colour; footing schedule
   default f'c text (seen in office drawings, schedules practice item 1: Assumed); all layer names (moved out of code).
3. **New, Raft/infill:** infill thickness 100 mm (Tim 26 Sep, RUL 1595); infill mesh (Unknown); infill hatch 11IH (RUL
   1550); infill edge beam 200x200 "often" (RUL 1595, office typical); legend wording (office template text).
4. **New, Reo bar:** note template ("{n}-{size}-{spacing} CTS x {length} LG, {face}", from RUL 2354); length rounding
   (Unknown, open question 3); shape list (open question 4).
5. **New, Retaining/fence walls:** height band limits; post, pier (dia, depth) and sleeper per band; post spacing;
   boundary pier offset; fence-on-top load and its effect; fence post footing sizes; block names (typical file). All
   **Unknown** until Tim fills them (open questions 1, 2).

## 6. Window contract for Codex (ruling B: Codex builds windows; no XAML here)

1. **Proposal window (CSFDNPROPOSE):** list rows: tick, mark, kind, size or "Unknown" (red), source (Calc / Manual /
   Unknown), Show. Footer line "Loads still Unknown above: N" with Show list. Buttons: Accept all, Accept ticked,
   Adjust, Cancel. Returns the ticked item ids; Cancel returns nothing.
2. **Retaining wall window (CSRW):** type, retained side, bands list (from-to chainage, height, post, pier, sleeper or
   Unknown), ticks "Add AG drain behind", "Fence on top", Apply / Cancel. Height-band edits are per job, recorded.
3. **Foundation workspace (FST, ST6-2):** extend the existing FstManagerWindow with the new kinds; no new window.
4. **Settings page:** sections Foundations, Raft and infill, Reinforcement, Retaining and fence walls; every value shows
   its tag (Assumed / source / Unknown). Cockpit rules: no scrolling layout, plain words, colour on Unknown.

## 7. Tests and Codex steps

1. **Pure tests (DesignCore / Core, no AutoCAD):** proposal rules (strip under LBW, pad under column, thickening
   under wall on slab, Unknown when no calc); pier planner (corners, point loads, spacing); load trace (markers,
   unsupported list, Unknowns listed); bar note formatter and bar schedule quantities (mass from catalogue);
   footing/RC beam schedule columns and ordering (marks by size, most common first); legend content; retaining wall
   layout (post centred, boundary offset, PFC+UC corner, PFC end, bands, Unknown band); no re-entrant bars placed.
2. **Command guards:** one transaction per accept; Escape writes nothing; registry round-trip save/reopen (core-console
   probe, memory `accoreconsole-plugin-probe`); FSTEXPORT and BWT route to the one schedule.
3. **Example drawings (synthetic, in `C:\Lisp Files\_TEST_COPIES_*`, no real job):** E1 single-storey raft with EB/IB,
   two columns, loadbearing walls, one infill area; E2 two-storey with first-floor posts and a roof point load over a
   ground footing plan; E3 30 m sleeper wall on a boundary with a return corner, an end against a building, levels both
   sides, one fence-on-top length; E4 basement suspended slab with engineer-placed band beams.
4. **Codex steps (2027, then note 2024):** E2: set levels, open ground plan, markers show, one QA line for the orphan
   post. E1: CSFDNPROPOSE, Escape (nothing), again, Accept all, U (all gone, one step), redo, save, reopen, schedules
   and legend still right; grip-drag a strip, preview, one U. E1: infill area, legend gains the infill note. E4: reo
   bar, stretch extent, note length and bar schedule change. E3: CSRW, check corner/end/boundary posts, Unknown band
   red, Apply, one U, rotated dimension tag, schedule row, AG run. Record screenshots; engineering values not judged.

## 8. Build order and builder brief split

1. **Slice 0, UX-LEVEL-01 per-plan level record** (not in any queue lane; LOAD-01 needs it): Sonnet, Opus review
   (ProjectData/Persistence paths).
2. **Slice 1, schedules RAFT-04, RAFT-01:** Sonnet, Opus review (Schedule paths).
3. **Slice 2, infill RAFT-02, legend RAFT-03, BSMT-06:** Sonnet (wiring the existing DesignCore builder, no change to it).
4. **Slice 3, reo bar BSMT-04/05, bar marks + schedule FDN-04, STR/BWT hidden:** formatter/quantities are new
   DesignCore logic: **Opus builder**; drawing side Sonnet.
5. **Slice 4, LOAD-01/02:** trace engine in DesignCore: **Opus builder**; markers and QA Sonnet.
6. **Slice 5, proposal FDN-01/03, LOAD-03:** **Opus builder** (design engine); Codex window.
7. **Slice 6, grips FDN-02:** Sonnet on the D2 slice 2 pattern, Opus review (Grip/Overrule/Undo).
8. **Slice 7, retaining walls RW-01..09:** layout engine **Opus builder**; blocks, schedule, dimension, section Sonnet.
9. **Slice 8, fences RW-10/11 and FDN-05 tools:** tags, schedules, legends Sonnet; any sizing/load logic Opus.

## 9. Opus-review triggers

1. Any file the queue's risk check flags (Structural.DesignCore/, Schedule, Grip, Overrule, Undo, Persistence,
   ProjectDataService, FoundationMonitor as a reactor path).
2. Any change to a size, spacing, load, bearing, mass or lap path, or to CSLOADPATH's assumed pad.
3. Any registry schema change; any proposed hard block (R-27 allows none here).

**Risk to watch:** CSLOADPATH already places a pad labelled "assumed size" from 20 kN / 100 kPa; FDN-01 must not reuse
that sizing (ST6-4: CE never invents a footing size). Proposal sizes stay Unknown until S5 or the drafter's pick.

## 10. Open questions (plan silent; one line each)

1. **Retaining wall sizing method:** RW-03 "sized from the height", RW-07 "typical schedule", RW-11 "adds the fence
   load to the design"; no retaining wall calc in UX-SCALC-03. Rec: a Settings table by height band with a "fence on
   top" column, Unknown until Tim fills it; a calc later in S5. Checked: RUL 2298-2333, 1214-1273, UX plan 152.
2. **Fence post footings "designed" (RW-10):** same silence. Rec: Settings table by fence type and height, Unknown until
   filled. Checked: RUL 2330, UX-SCALC-03.
3. **Bar length rounding in the note ("x 5500 LG"):** not stated. Rec: Settings value, Unknown = exact length shown
   until Tim sets it. Checked: RUL 2354, ST-06, rulebook Structural section.
4. **Bar shapes in the bar schedule (FDN-04 "shape"):** no office shape list recorded. Rec: straight bars first; other
   shapes Unknown until Tim confirms the office shapes as short questions. Checked: RUL 1439, ST6-13, rebar catalogue.
