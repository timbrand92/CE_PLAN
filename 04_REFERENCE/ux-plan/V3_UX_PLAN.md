# CE Version 3 — the UX plan (one page per area)

**What this is:** the consolidated user-experience plan for the CE plugin (Civil, Structural, Manager), built from
Tim's answers of 25-26 Sep 2026 in `CE_ACAD / V3 PLAN / DISCUSSION / 01`. Every line cites the ruling ID; Tim's words
and the full wording are in `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`. Earlier approvals still stand
unless a ruling here says it supersedes them (July cards in `04_REFERENCE\CARDS\`, 14 Sep Structural journey, 5 Sep
design pack, 4 Sep rulebook R-00..R-30).

**The bar (Tim):** *"i want users to feel like theyre using a polished product similar to something apple or
autodesk would design"*. Plan talk is about what the drafter clicks and sees; engineering numbers live on the
Settings page and are not re-asked.

**Status:** planning only. Nothing here is built, tested, installed or Tim-accepted unless the area file says so.
Builders: the release chat writes a card per item before code.

---

## 1. The whole plugin — rules every command follows

1. **Look:** every CE window uses the one-page New Pipe header (CE logo, one-line summary, status top right) and
   footer (tools bottom left, Cancel and the gold button bottom right); tabs only for separate topics. (UX-LOOK-01)
2. **Placing commands carry on** until Enter or Escape, and the window opens for every item; CD and PIT too, no
   Batch tick. (UX-STD-01, 01b)
3. **Preview is enough:** no "Are you sure?" after a preview; only deleting CE link records asks. (UX-STD-02)
4. **CE never saves the drawing** for you. (UX-STD-03) Exception: closed sheet drawings updated by Sheets sync, with
   a notice. (UX-STRUC-01)
5. **Override reasons:** quick picks (Survey, Council requirement, Engineer's judgement, Other) plus an optional
   note. (UX-STD-04)
6. **Fix lists:** safe drafting fixes pre-ticked; anything touching levels, sizes or links never pre-ticked.
   (UX-STD-05)
7. **Selection:** editing part of a selection never changes what you selected. (UX-STD-06)
8. **Quiet when OK:** one green line when checks pass, passes folded. (UX-STD-08)
9. **Words:** "Free end" / "Not connected yet"; "Suggestion only: not an office rule yet"; "Send report" with an
   honest result line; "Decide later". (UX-WORD-01..03b)
10. **Old typed names work forever** as silent shortcuts; never shown in ribbon, Help or tooltips. (UX-NAMES-01)
11. **Learning:** CE learns from your habits, the whole office, past CE projects (anonymised) and corrections; every
    suggestion says why; never silently changes an engineering rule; office learning is anonymous; each person sees,
    corrects or removes what CE learned from them and can switch it off. (UX-LEARN-01..04)
12. **Speed:** anything over a second shows status-bar progress with Cancel; a slow CE feature offers to pause
    itself for that drawing. (UX-PERF-01, 02)
13. **Approvals:** any CE user can approve calculations, apply proposals and issue, always recorded, naming the
    engineer where a sheet goes out. (UX-CALC-APPROVE-01, UX-CALC-03, UX-REG-06, UX-STRUC-11, UX-REV-05)
14. **Mixed versions:** V3 drawings must stay visible to colleagues without V3 (prove on the 2022 VM); 2027-only
    tools greyed with "needs AutoCAD 2027"; the automatic pipe upgrade is held on colleagues' PCs until the
    2022-2024 enabler is proven. (UX-MIX-01..03)
15. **Job mode, not person role:** each job (per discipline) is "From markup / supplied design" or "Design from
    scratch", suggested by CE, shown on the CE panel and switchable without person locks. From-markup work follows
    the instructions; extras are allowed and listed quietly as "Not in markup" (agree and remember, or remove).
    A late markup offers a switch, keeps drawn work and adds QA. All Civil proposals remain suggestions, marked
    "differs from supplied design" where relevant, and never alter it until accepted. (UX-MODE-01..04)
16. **Everyday AutoCAD edits:** ERASE a pit leaves its pipes with free ends and says so; COPY/paste makes real CE
    copies renumbered with levels flagged to check; MIRROR/ROTATE keeps CE text readable and re-slid; EXPLODE is
    allowed with a status-bar note of what left the schedule. One Undo restores each. (UX-EDIT-01..04)
17. **When things go wrong or clash:** a failure opens a window: plain line first, the log, "Send to admin" (the
    one Report a problem) and a Fix button where CE knows the fix; the drawing is untouched. A drawing open by a
    colleague names them and opens read-only, Issue waits with "Notify me when free". Nothing selected: the
    command asks to pick, filtered. Ribbon tooltips are Autodesk style (line, then picture). (UX-FAIL-01,
    UX-SHARE-01, UX-SEL-01, UX-TIP-01)
18. **Around the object:** right-click shows a short CE group on top of AutoCAD's menu; Ctrl+1 shows editable CE
    values with the same rules and one Undo; failure reports go to the office admin named in Manager; a brief
    self-closing CE splash while AutoCAD loads. (UX-RCLICK-01, UX-PROP-01, UX-FAIL-02, UX-START-01)
19. **Windows:** Enter applies, Esc cancels; each window reopens where it was left; the preview follows typing live;
    editors hold AutoCAD until Apply/Cancel, palettes (Properties, Checks, Proposals) stay open. (UX-WIN-01..04)
20. **Command line and cursor:** AutoCAD-style prompts with clickable options and defaults; size, grade and length
    beside the cursor, warning colour on a fail; Enter repeats with last values; subtle glow plus CE snap marker
    on the connection target. (UX-CMD-01..04)
21. **Layers and colour:** CE objects go on office layers (made if missing, current layer untouched); a wrong layer
    is a pre-ticked safe fix in Checks; colour ByLayer always, preview colour only until Apply; existing greyed
    on EX layers, demolished dashed on DEMO with "TO BE REMOVED". (UX-LYR-01..04)
22. **Civil and Structural together:** each discipline reads the other's CE objects from the job folder, read-only;
    pipes in a footing's zone of influence are flagged with a suggestion; an FFL/slab change gives Civil a quiet
    heads-up; downpipes are Civil-owned, Structural sees and suggests. Nothing moves on its own.
    (UX-XDISC-01..04)
23. **Finding your way:** CE find box (P7, WT1, beam marks) zooms and highlights; clicking any schedule/Checks/
    Properties row zooms with Back; up/down arrows walk the network with a gentle screen-only guide (flow dashes,
    next-stop ring, ticked trail), also on Checks jumps, switchable off; right-click selects a run or network.
    (UX-NAV-01..05)
24. **Messages:** one CE bell on the status bar collects every quiet message with one action each; only failures,
    a colleague holding the DWG and update-ready show a self-fading balloon; job messages follow the job, personal
    ones the person. (UX-MSG-01..03)
25. **Undo and resuming:** CE Undo steps have plain names; palettes and last pipe size/type come back next day;
    the CE panel job button lists the last 10 jobs. (UX-UNDO-01, UX-RESUME-01, UX-RECENT-01)
26. **First day:** one welcome card on the very first start; a one-line tip the first time each command is used;
    an anonymised practice job in Help, never counted. (UX-FIRST-01..03)
27. **Beam marks:** gaps stay after deletes with a previewed renumber offered before issue; identical beams share a
    tags placed at the learned office spot. Beams, lintels and rafters get their own mark each; columns and footings
    share marks by size, most common size is 1; column and footing tags show the mark only. (UX-MARK-01, 03..07)
    Schedules copy the office layout: footing and pier schedules sideways (one column per mark, f'c band), marks
    prefixed by type and numbered per prefix, live wall schedule, standard lintel table, beam schedule table on
    the framing sheet; framing member schedule per floor, MARK | SIZE blocks side by side with group subheadings,
    built on the office MEMBER SCHEDULE block (1/2/3 columns, plain title at one column), with a second block beside it
    (or next sheet) instead of refusing past 3 columns; RC beam schedule from the office typical file; slab legend
    boxes live, one per slab type drawn; schedule blocks come from the office typical file (footing version by sheet
    size and comments, Block Wall Schedule), new work follows file changes and old drawings get an offer.
    (UX-SSCHED-01..13, UX-SCHED-04b)
    Plan notes: learned note picker with leaders; office boxed notes per sheet type; "(O)" = over the current level,
    "Ex." = existing, "(U)" = under. Each plan is given its level once; over/under columns and walls come across
    automatically from the levels above/below in the office red style. (UX-NOTES-07..09, UX-LEVEL-01, 02)
    Plan symbols: CE pier object with automatic tags and centres; step symbol, level tags and a magenta SLAB STEP
    line offered at level changes; a section mark offers its linked detail. (UX-SYM-01..03)
    Framing plan: joists and rafters as one span arrow with tag; beam hover shows mark, size, span and calc status;
    beams at level on BEAMS, lower beams on BEAMS LOWER, nothing more; bracing walls tagged with a live required vs
    provided total per direction; tie-down symbols feed an automatic schedule. (UX-FRM-11..15)
28. **Other people's drawings:** foreign pits/pipes get a quiet Review offer in the bell; older CE drawings upgrade
    on open with one line and one Undo (colleague hold stands); recipients without CE see clean plain linework,
    no proxy box. (UX-DWG-01..03)
29. **Settings feel:** search box on the Settings page; job values tagged with their source (Council / Job override /
    Office); office standard changes hit new work only, with a previewed bell offer per job. (UX-SET-07..09)
30. **Ask CE day to day:** dockable palette plus ASKCE; its changes use the normal preview/Apply/one Undo; the current
    selection shows as removable chips. (UX-AI-05..07)
31. **Voice and timing:** live updates straight after each edit (batched with Cancel on big jobs); every message calm,
    direct and plain, saying what and what to do, no blame; every value shown with its unit. (UX-LIVE-01,
    UX-VOICE-01, UX-UNIT-04)
32. **Ribbon look:** AutoCAD-style line icons with one CE accent; large buttons for about five daily tools per panel;
    fixed layout, changed only between releases from office use counts. (UX-RIBBON-05..07)
33. **Comfort:** windows follow Windows scaling; every status has a symbol as well as a colour; every control
    reachable by keyboard with Alt shortcuts. (UX-ACC-01..03)
34. **Proposals feel:** options worked out in the background with a bell when ready; unchosen options kept until
    issue; parts can be mixed across options and are rechecked before Apply. (UX-L3-24..26)
35. **Architect's drawing:** revised background raises a "what moved" review, nothing moves itself; "Replace
    background" swaps the file keeping position, layers and clip; one-click office background layer preset.
    (UX-ARCH-01..03)
36. **Naming:** new commands CD (Civil), CS (Structural), CE (shared); ribbon buttons in plain words with the code
    in the tooltip; about ten office short aliases, clash-checked. Old names forever; Structural moves to CS names in
    its stage; Civil short codes (CDWT, CDLPD) stay. (UX-NAMES-01..06)
37. **Schedule tables:** a long schedule continues on the next sheet with repeated headers; typing in a cell edits
    the object; natural mark order (P1, P2 ... P10). (UX-SCHED-04..06)
38. **Pit numbering:** P1 at the outlet, rising uphill; main line first, then branches from nearest the outlet;
    later pits take the next free number with a previewed renumber offered before issue. (UX-CPLAN-18..20)
    C02: orifice pit detail live from the design; one tank detail per tank type; reuse and detention zones
    dimensioned on the tank section, matching the OSD block; bedding detail per pipe material; penetration and sawcut
    details offered when needed. Outfall drains (off-property, client-paid) are their own run checked to council rules,
    with the OUTFALL DRAIN PLAN C02 and their own schedule; outfall pits CP1, CP2; the outfall long section is generated
    live in the office layout. (UX-CPLAN-28..34)
    Surface levels come from the survey, interpolated (Unknown outside it), with design levels winning where set and
    a small source tag in windows; with no survey CE asks for an assumed datum and fall (marked Assumed); a later
    survey fills in and lists new failures; suspect spot levels are flagged and skipped. (UX-RL-01..06)
    Long sections for site runs on request in the outfall layout, crossing services shown with clearance.
    (UX-LSEC-01, 02)
    Lid class suggested from the surface a pit sits in; a moved pit is flagged with a one-click upgrade. (UX-LID-01, 02)
    Downpipes detected from the architect's Xref and confirmed in one preview; DP connection pipes drawn by the
    drafter; roof split between downpipes automatically as an adjustable overlay. (UX-DP-01..03)
    Trench drains by two points; fall arrows suggested from levels; grated pit catchments overlaid with an overload
    warning; AG and perimeter drains as simple CE runs; charged and suspended set as pipe properties; new sewer is not
    CE's job. (UX-SURF-01..06)
    Paving: a quick hatch when CE designs it, the architect's outline read when they do; pavement detail offered with
    concrete paving; kerbs and spoon drains as legend linework. (UX-PAVE-01..03)
    Retaining walls: pick a line and CE lays out the three office blocks (sleeper wall, post, bored pier, each with
    its hatch): posts centred on piers, piers offset inward at boundaries, PFC+UC corner posts, PFC end posts where
    a wall stops against something; heights from levels; AG drain offered. (UX-RW-01..06)
    Pit labels show number and cover level at the learned office spot; pipe labels run along the pipe at mid-length,
    leader out when too short, every pipe labelled (no TYP.); one IL text per pipe end at the pit, always shown.
    (UX-CPLAN-21..27)
39. **CE panel:** job name and mode with recent jobs, a one-line health indicator into Checks, the bell count and
    the find box; the discipline switch follows the drawing. (UX-PANEL-01, 02)

## 2. The front door — ribbon, names, help

1. **One CE tab** whose middle panels switch for Civil or Structural drawings (4 Sep). Selecting a pipe, pit or
   source jumps to its green contextual tab. (UX-RIBBON-01)
2. **Plain labels** on buttons; the typed command shows only at the end of the tooltip (5 Sep).
3. **Toolbars kept** (icons match the ribbon); the CE CVL pull-down menu retired once the one tab works on 2022.
   (UX-RIBBON-03)
4. **Structural ribbon shows families** (Beam ▾, Text ▾ size + compass, Tag, Hatch gallery), about 40 tools instead
   of 298; duplicates merged, shortest code wins; "Legacy" tools sorted into families. (UX-STRUC-02..05, 07, 08)
5. **CESTRUC's button launcher retires**; its unique functions get proper homes first. (UX-STRUC-10)
6. **First run:** a lit "Start here" button with a 2-minute tour (it no longer asks a role: UX-MODE-01).
   What's New opens once after an update. F1 opens help for what you're doing. (UX-HELP-02..05)
7. **Learning help:** short clips for the main tasks; tips on the first three uses; the faster way suggested once;
   no practice drawing. (UX-HELP-06..09)

## 3. Civil — drawing the network

1. **Pipes:** auto-join to a pit or pipe end within 75 mm (Settings), never guessing between two; "Keep separate"
   and "Keep as a free end" both kept and remembered for the job; recent diameter, material and invert buttons;
   Escape at CD's third point cancels; Hide grade on every type; one grade for several pipes with a preview that
   offers "Only these pipes" (default) or "Carry downstream". (UX-PIPE-01..08)
2. **Pits:** a pit catches pipe ends within its outline + 100 mm; plastic pits keep their label; typed schedule
   values update the pit with a preview. (UX-PIT-01, 02, UX-SCHED-01, 01b)
3. **Sources:** DP and CDRG place like pits, before pipes; OF/FO one symbol; strip drain its own type; RG tags;
   trench grate drag or type. (UX-SRC-01..05)
4. **Labels:** hand-placed labels stay; CE labels re-tidy in the edit's own U; "Tidy labels" for a sheet; only CE
   labels move, avoiding everything else. (UX-LBL-01..04)
5. **After ordinary AutoCAD edits** CE re-checks quietly; AutoCAD's own TRIM, EXTEND, BREAK, JOIN work on pipes;
   ignored findings stay ignored until something changes; Show where zooms and glows. (UX-DI-01..04)
6. **Tanks:** one-line callout without detention; R1/D1 kept; an existing detention pit gets a real record
   (CDPITDETENTION). (UX-TANK-01..04b, DETENTION-PIT card)
7. **Site and slab:** arborist report read for tree zones; learned advisory joint proposals; spoon drains dragged
   with live fall; slab outlines offered from the background; "Meets 1 in 100" wording kept. (UX-SITE-01..04,
   UX-SLAB-01, 02)
8. **Survey:** levels filled from the survey marked "Survey"; revised surveys compared; spot level shows existing;
   anyone approves the survey, recorded. (UX-SURV-01..04)
9. **Pump stations:** one Pump Station tool; rising main as a pipe; SPS detail filled from the job; CE gives the
   duty point. (UX-SPS-01..04)
10. **WSUD:** tanks, buffer strips and raingardens only; checked against the rating report. (UX-WSUD-01..04)
12. **C02 details:** CE offers the details C01 uses, filled with job sizes and kept live with preview; hand edits kept
    and flagged. Sheets: C01 plan with notes, fixed legend and Pit Schedule; C02 details. (UX-DET-07, 08, UX-SHEETS-03,
    04, UX-CPLAN-01..03). Civil notes are the full template every time, plus council-required notes from the council
    profile. (UX-NOTES-05, 06)
13. **Civil conventions:** pipe labels "100 DIA. UPVC PIPE AT 1 IN 100" (no MIN./MAX.); pits P1, EP/SEP, JP1; Civil
    details titled not numbered; three standard remarks under the Pit Schedule. Pit Schedule copies the office layout
    exactly; OSD criteria block filled live; C01 note blocks picked by council; tank callout placed automatically in
    office wording; LPD note auto at the connection; existing services labelled with a clash check; legend gaps
    flagged in checks; CE level text updates live, hand text only flagged; sources DP/IO/OF unnumbered; C02 titled by
    content, details auto-packed then draggable; charged lines get the C02 detail and charged linetype.
    (UX-CPLAN-04..17, UX-DET-09)
11. **Overland flow:** route proposed from levels; neighbour warning; every overflow must go somewhere; floor
    freeboard checked. (UX-OLF-01..04)

## 4. Civil — design and calculations

1. **Design (CDDESIGN/CDSETUP):** opens straight on a known job; fixed CE area colours; opens on "During".
   Setup suggests a mode per job and discipline from the job-folder evidence and shows it on the CE panel,
   switchable at any time. In From-markup mode, Confirm setup returns to drafting. (UX-STD-07,
   UX-DES-01..03, UX-MODE-01/03; [Design/CDSETUP card](cards/UX-DES-01_CDSETUP_JOB_MODE_CARD_2026-09-26.md))
2. **Calculations card approved:** catchments from the rating report computed automatically with one confirmation,
   fix any catchment in place; you pick what Apply replaces, one U; anyone issues naming the engineer. (UX-CALC-01..04)
3. **Council tools:** CE writes discharge enquiries; lid class suggested from the surface; implied easements shown;
   AGI its own system; short offcut warnings; shared council base with overrides; outfall and detention-needed at
   Design start; velocity, class, material, refused items, contours, basements, rear fall and floor freeboard
   checked per council; council settings swept for copied values. (UX-CR-01..17, CR-D1)
4. **Council RFI reader:** found in the job folder; a to-do tab in Project Review; CE checks what it can; learns.
   (UX-RFI-01..03)
5. **Pipe-size suggestions:** one advisory line in the Pipe window and a network review in Proposals; tied to
   the Civil job mode. Design from scratch offers Accept all after preview. From markup shows the supplied-design
   check and every sizing suggestion, marks differences and changes nothing unless individually accepted.
   (UX-SIZE-01..03, UX-MODE-01/04)

## 5. Level 3 — CE proposes design

1. **All four proposals, in this order:** levels for a drawn network; downpipes and sources; detention and tank
   layout; full network layout. (UX-L3-01, 02)
2. **Visual:** options shown side by side as plan pictures; the chosen one as a full-size ghost in the drawing;
   nothing drawn until Accept, one U. Reference sketch `PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg`. (UX-L3-19, 20)
3. **Levels:** fit between the outlet and minimum cover at the top of every branch; typed levels fixed; shortfall
   shown with options. (UX-L3-03..06)
4. **Downpipes:** architect's positions else roof; destination from the rating report; numbering orders offered;
   ghost DPs with lines. (UX-L3-07..10)
5. **Detention:** 2-3 options, each can mix storage pipes on several runs, pit detention and tanks; learned from the
   best past jobs (council approved first time, least pipe and depth, no later redraws); complete system including
   orifice pit and overflow; "Draft" until the calculation is approved. (UX-L3-11..14, 21..23)
6. **Full layout:** 2-3 options; routes learned from previous drawings; builds around existing work; says so when
   not enough is learned yet. (UX-L3-15..18)

## 6. Review, schedules, issue

1. **One Project Review** for Civil and Structural; Proposals button opens Proposals; ranked by confidence then
   size; PDF export default; approver recorded. (UX-REV-01..05)
2. **Pit Schedule:** matches the printed schedule column for column; Excel adds a checking sheet. (UX-SCHED-02, 03)
3. **Issue (both disciplines):** changed sheets suggested from the last issue; next revision pre-picked; clouds
   proposed after A; register on the Structural cover sheet lists civil sheets (Civil sets have no register or
   notes page); separate revision letters per discipline; status words from the revision; one combined PDF in
   register order; council submission pack; office plot setup; a DWG snapshot per issue; check plots with an
   optional "For engineer" version. (UX-REG-01..15)
3b. **Standards at issue:** off-standard layers, styles and pens listed with safe fixes pre-ticked; optional clean-up
   with preview; standards live in Settings > Drawing Standards. (UX-STDS-01..03)
4. **Import and repair:** Compare only compares; CDCHECKDWG summary plus list; survey files chosen in the window;
   import report kept plus PDF; expert repair commands warn; "Decide later" is a Repair tab; admin-only delete.
   (UX-IMP-01..04, UX-REP-01..03)

## 7. Structural

1. **Beams (D1 approved, D2 building):** one name system with Civil; column and beam grips start in Edit together;
   MOVE on a column brings its beams; labels follow; mismatches go to QA quietly; XCLMTXT schedule now, phased out
   as computations move into CE; 2027 first. (D1 choices 1-12, UX-D2-01..06)
1b. **Whole-plan proposal:** one proposal following the engineer's markup (14 Sep); learned from past framing with
   few engineer mark-ups, no later redraws and the fewest members for the spans. (UX-SL3-01, 02)
2. **Later stage:** beams and columns become CE's own kind of object (safe hover menu). (UX-D2-05b)
3. **Beam failures** say the plain reason and next step; STRUCDEBUG; 5 and BDL move to the one engine. (UX-BEAM-01..03)
4. **Priority after D1:** QA against the engineer's markup; register and issue; background preparation (also for
   Civil); detail library. (UX-STRUC-06)
5. **QA against the markup:** CE reads the handwriting (Claude only, page only, title block blanked or not sent);
   faded markup under the plan with a side list; on demand and at issue; To do / Drafted / Needs clarification /
   Checked; one list across rounds; clarification PDF; engineer-drafted changes compared. (UX-QA-01..08)
6. **Tags:** smart tag places the right tag from the object, learned from past drawings. (UX-STRUC-09, 09b)
7. **Detail library:** one CE Library palette (Blocks | Details); any engineer approves standards; PDF details as
   marked reference; detail numbers and callouts tracked. (UX-DET-01..04)
7b. **Sections:** section marks create linked, numbered section frames; simple member sections generated from member
   data; steel connections from the library with sizes filled. (UX-SEC-01..03)
7c. **S01 general notes:** assembled from relevant office note blocks; geotechnical note filled from the report; full
   concrete cover table always. (UX-NOTES-02..04)
7d. **Details sheets:** CE offers the standard details each plan uses, laid out in a neat learned grid, numbered and
   linked; re-packs with preview. (UX-DET-05, 06)
8. **Computations in CE:** start from the drawing; the same CE sheet as Civil; timber, then footings, steel,
   bracing; wind class proposed; geotech report read; loads traced from the drawing; results previewed then
   applied. (UX-SCALC-01..08)
8b. **Foundations and rebar:** footings, pads and thickenings proposed from what sits above; footing grips like
   beams; piers set out from the calc; bar marks and bar schedule automatic. (UX-FDN-01..04)
8c. **Rafts, infill, band beams:** EB/IB raft beams auto-scheduled; infill slab a tracked area (100 mm, top mesh, IB/EB
   ribs); BB band beams for suspended slabs over basements in the RC beam schedule; the footing-plan legend built
   automatically; footing schedule in office columns; drafted top-down with load markers, sheeted notes then footings
   up. (UX-RAFT-01..04, UX-LOAD-01..03, UX-SHEETS-01..04, UX-STRUC-13)
8d. **Framing plans:** office tags (FB, RB, LRB, PB, L, RL, CANT/CONT; C, P, DS1, TS1); automatic legend and
   "MEMBER SCHEDULE" (MARK, SIZE, grouped); bracing Type A/B tool with totals; bracing on the framing plan; lintels,
   roof framing by area and stud supports proposed. (UX-FRM-01..08)
8d2. **Multi-unit jobs:** draft one unit, CE copies to identical/mirrored units, tags renumbered by unit and linked;
   tag prefix (level / unit / none) set once in the job record; one member schedule grouped by unit; schedules show
   full names under headings. (UX-UNIT-01..03, UX-FRM-09, 10)
8e. **More foundation tools:** waffle pod slabs, timber subfloors, screw piles, suspended/basement slabs, each with office
   tags, schedules and notes. (UX-FDN-05)
9. **2022 colleagues** get full Structural with 2027-only tools greyed. (UX-STRUC-12)

## 8. Jobs, Manager, settings

1. **One job record** for both disciplines; title blocks kept in sync; "New job drawing" from the office templates;
   learned file names; shared-record changes shown and chosen. (UX-JOB-01..05)
2. **Xrefs:** background changes offered for comparison; broken paths offered for repair. (UX-XREF-01..03)
3. **Manager:** one-glance status page; quiet updates at next start; colleague rollback with notice; one "Report a
   problem"; updates to picked colleagues first; admin page of who's on what; Tim the only administrator for now.
   Approving a build shows one page (changes, tests, not-yet-accepted, rollback); problem reports arrive with version and
   one-click rollback; What's New drafted by CE, approved by Tim. (UX-MGR-01..10, UX-ADMIN-01)
4. **Settings:** any engineer changes firm values, recorded; search; per-value history; gold "This job" tag; LPD note
   box. (UX-SET-01..06)
6. **Layouts and viewports:** "New sheet" makes the layout, title block, viewport at office scale, plan title and
   north point; office scale list, viewports locked; titles and scales linked; labels plot at the office height at
   every scale. (UX-LAY-01..04)
5. **Job time and notes:** timer starts per job drawing; idle asks on return; hours to CE Project Manager; own time
   plus admin summary; checklist auto-ticks what CE can prove, drafted office list; job notes once then an icon.
   (UX-TIME-01..04, UX-CHK-01..03, UX-NOTES-01)

---

**Manager day to day:** admin home shows office health (versions, reports, update state); colleagues see version,
Report a problem and Roll back only; reports open as a plain summary with "Send to Claude chat". (UX-MGR-11..13)

## 9. Ask CE (AI assistant)

1. July card AI-01 stands (permissions, preview then one U, no raw commands). New: "Draw these" from QA-against-markup
   items as a proposal; an "Explain" button on every finding; rule and standard questions answered with the source
   cited; voice after V3. (UX-AI-01..04)

---

*Kept current by the V3 plan discussion chat. When a ruling changes, update the line here and the decisions file in
the same commit.*
