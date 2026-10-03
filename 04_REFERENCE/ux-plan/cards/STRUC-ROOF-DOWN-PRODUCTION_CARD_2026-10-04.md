# STRUC-ROOF-DOWN-PRODUCTION: roof-down drafting, the boring-end assistant and learned office standards (card, 4 Oct 2026)

Status: **DRAFT, not approved.** No code. Tim's answers to section 7 come first.
Class: **Missing** (the flow and the assistant) plus **Modify** (existing CE commands joined into the flow).
Written by study/01 run 1 (headless, documents only). Revised by study/01 run 2 (4 Oct) after the controller review
`STRUC-ROOF-DOWN-PRODUCTION_CARD_CONTROLLER_REVIEW_2026-10-04.md` (six fixes, two question changes).

**Authority:** Tim, 4 Oct 2026, verbatim: "LETS GO WITH YOUR RECOMMENDATION, MAKE SURE FROM PREVIOUS JOBS IN JOBS FOLDER
THAT YOU UNDERSTAND THE PROCESS AND HOW IT WORKS THEN SEE HOW YOU CAN IMPLEMENT AI or MCP assistant drives only that
boring end, and never the design decisions. WHAT ABOUT HELPING PLACEMENT AND LOGIC AND DRAFTING STANDARDS FROM CURRENT CE
DRAWINGS?" and earlier "WE NORMALLY DRAFT AND DESIGN FROM ROOF DOWNWARDS". Rulings used:
`decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` UX-STRUC-13 (top-down), UX-LOAD-01..03, UX-RAFT-01..04,
UX-SHEETS-01/02, UX-MODE-01..04, UX-LOADP-01/02. Rules: R-00, R-27, R-LEARN (`ENGINEERING_RULEBOOK.md`), EV-03
(`03_DRAWING_INTELLIGENCE/EV-03_EVIDENCE_MODEL.md`), DATA-01. Evidence: `04_REFERENCE/structural/JOBS_PROCESS_STUDY_2026-10-04.md`
(six jobs, anonymised). Related card: `S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md`.

**Facts used, and where they come from:**
1. Command names: the CE STRUC ribbon list in `areas/release-v3-colleagues-TEAMLANE2_LOG.md` (3 Oct, base rel-20261015s),
   checked again in the plugin repo on `origin/claude/rel-20261015w` (5807a1a9), read only.
2. Installed status (as reported to me on 4 Oct, not read from the DLLs by me):
   UX-LOAD-01/02 built, installed, **switched off** by default (Settings `LoadPath.TraceFromLevelAbove = false`;
   seen in `UserSettings.cs` line 952). UX-LOAD-03 footing proposal engine (`Structural.DesignCore/FootingProposalEngine.cs`)
   built, installed, off; **no command or window shows it**. `Core/Roofs/RoofPointLoadCarryDown.cs` built as a pure
   matcher, installed, **not called by any command** (only its own tests use it). UX-LOADP load-path check (CSLOADPATH) live.
3. **The per-plan level is BUILT and installed** (checked by run 2 in the repo, read only, on
   `origin/claude/rel-20261015w` 5807a1a9, Structural 1.0.99): command **CSPLANLEVEL** ("Records which level this plan
   is (Ground, First, Roof ...). Set once per plan", `PlanLevelCommands.cs`, UX-LEVEL-01), the in-drawing record
   `PlanLevelRecord`, and the office level list in Settings (`PlanLevel.LevelNames`, Settings > Plan levels). The load
   trace already uses it (`LoadTraceEngine.LevelAbove`, called from `FoundationService.LoadTrace.cs`). If a plan's level
   is not set, or only recorded and not confirmed, the markers say "from the level above" and CE tells the drafter to
   type CSPLANLEVEL. UX-LEVEL-02 (columns and walls carried across as (O) and (U)): its engine and in-drawing record are
   in the code; I found no command that draws the carried items yet. (`rel-20261015f` is the Civil and Manager line and
   has no Structural module.)
4. **Tim has accepted none of this in AutoCAD yet.**

---

## 1. ANSWER FIRST: what changes for the drafter, roof down

1. **You draw the roof first, then each floor below, then the ground floor or slab, then footings last.** CE follows you.
2. **When you open the level below, CE shows grey, non-printing markers** where something from above lands:
   "post from roof", "point load R3", "loadbearing wall from First floor". You draw the support under it. Nothing prints.
3. **Anything from above with nothing under it** is a quiet line in the QA list with "Show where". It never blocks.
4. **On the footing plan, CE offers footings** under everything that came down (strips under walls, pads under posts,
   thickenings under point loads on a slab). Sizes stay **Unknown** until the engineer's calculation or the drafter's
   pick. CE never invents a size.
5. **The sheets still print bottom-up** (notes, footings, floors up, roof, details), as now (UX-SHEETS-01).
6. **The boring end can run without you:** refresh schedules, renumber marks, check the set, export PDFs, build the
   issue folder, write a morning report. It works on a copy, or on a drawing you saved and handed over. It never changes
   a size, a span, a load or a footing. Everything it finds is a proposal you accept or ignore.
7. **CE learns the office's own way of placing tags, text and notes** from your past drawings, asks Tim to confirm, then
   uses it as the default and checks against it. It never blocks you for being different.

---

## 2. The flow, roof down: what CE has today and what is missing

### 2.1 Roof framing plan (drafted first)

1. **Today:** Beam [1] and the Beam Drafting menu; Rafter Marker [R1], Floor Joist Marker [FJ1], Rafter/Joist Settings
   [RJSET]; Column Marker [C1], Double Stud [DS1], Triple Stud [TS1]; Bracing menu (A-Bracing [AB], B-Bracing [BB],
   Bracing Truss [BT1], Set Required Bracing [CSBRACINGREQUIRED]); Place Tie-Down [CSTIEDOWN]; Set Wind Class
   [CSWINDCLASS]; Create Schedule [STRSCHEDCREATE].
2. **Missing:** the roof point loads are not carried down. `RoofPointLoadCarryDown` exists but no command calls it.
3. **Today (built, installed):** the plan level command [CSPLANLEVEL] ("this plan is the Roof"), set once per plan, from the
   office level list in Settings. Every plan needs it set once before the markers can name the level above.

### 2.2 Upper floor framing plan(s)

1. **Today:** the same beam, column, stud, bracing and tie-down tools; Load-Bearing Wall [LBW]; Member Label
   [CE_MEMBERLABEL]; Excel to Schedule [XCLMTXT]; Refresh / Synchronise Schedule [STRSCHEDREFRESH] [STRSCHEDSYNC].
2. **Built but off:** markers from the level above (UX-LOAD-01/02). Switched off by `LoadPath.TraceFromLevelAbove`.
   They use the plan level set with CSPLANLEVEL. With no level set, they say "from the level above" instead of "from Roof".
3. **Missing:** a MARK / SIZE member schedule grouped the office way (Structural Supports, First Floor Members, Common
   Members). Seen on 4 of 6 studied jobs. The 26 Sep framing study already lists it as a gap.

### 2.3 Ground floor: raft, slab, subfloor or basement

1. **Today:** Tracked External Raft Beam [REB], Internal Raft Beam [RIB], Slab Thickening [FTHC]; Infill Slab hatch;
   Basement wall layout [CSBSMTWALL]; Pump pit [CSPUMPPIT]; RC Beam [RCBEAM]; Column [RCRECTCOL]; Level Mark
   [CE_LEVELMARK]; Structural Slab Level Mark [CE_SSL]; Read Geotechnical Report [CSSOILREPORT].
2. **Built (on PRs, see S4 card and the Team lane 2 log):** footing legend [CSFOOTINGLEGEND], infill slab [CSINFILL].
   Their installed state I did not read.
3. **Missing:** markers from the floor above on this plan (same switch as 2.2).

### 2.4 Footing plan (last)

1. **Today:** Footing [FPFC], Pad Footing [PFC], Tracked Strip Footing [FSF], Bored Pier [BP], Pier [CSPIER], Screw
   Pile [SCREWPILE]; Foundations Manager [FST]; Footing schedule [FSTEXPORT]; Regenerate All Systems [FREGENALL];
   Renumber marks [CSMARKSRENUMBER] (already a preview, then Yes or No, then one U, UX-MARK-01; it waits for the
   drafter's answer, so it is interactive); **Check load path [CSLOADPATH] (live)**.
2. **Built but hidden:** the footing proposal engine (UX-LOAD-03). No command, no window.
3. **Missing:** "Propose footings" (CSFDNPROPOSE in the S4 card) that uses every load traced down all levels and lists
   anything above still Unknown.

### 2.5 After the plans: details, notes, sheets, issue

1. **Today:** Drawing Sheets [CESHEETS]; Project Drawing Properties [CEPROPS]; Drawing Notes [CENOTES]; Drawing
   Checklist [CECHECKLIST]; Export Layout to PDF [STRUCEXPORTPDF]; Export Schedule to Excel [STRUCEXPORTCSV]; Markup
   Review [CEMARKUP] and its menu; Review Architectural Changes [CEARCHREVIEW].
2. **Missing:** one "issue this revision" step that bumps the revision letter and status together, fills the register on
   S01, plots every layout to a dated issue folder and lists what changed. In the study, one job's Rev C sheets still said
   "PRELIMINARY ISSUE" (one job only): this is the kind of slip the step would catch.

---

## 3. THE BORING-END ASSISTANT

### 3.1 The boundary (hard)

**It MAY run only steps that are mechanical, repeatable and reversible:**
1. Refresh schedules: STRSCHEDREFRESH, FSTEXPORT update. STRSCHEDSYNC too, but it **writes the schedule table:
   copy only, locked layers reported**.
2. Run the checks: CSLOADPATH, CECHECKLIST, and the QA lists, CDCHECK-style (a list, never a fix).
3. Renumber marks: CSMARKSRENUMBER, **as a proposal list** the drafter accepts. Needs a non-interactive form first
   (section 3.3 item 4).
4. Regenerate footing graphics from their records: FREGENALL. It **erases and redraws CE footing outlines: copy only,
   locked layers reported** (skipped and listed, never unlocked).
5. Export: STRUCEXPORTPDF (every layout to PDF), STRUCEXPORTCSV (schedules to Excel).
6. Build the sheet set and the issue folder (dated, as the office does: "YYYY-MM-DD_STR_REV X").
7. Write one overnight report per job.

**It NEVER:**
1. Makes a design decision: member sizes, spans, load assumptions, footing sizes, pier depths, bracing counts, slab
   thickness, mesh, wind class, site class.
2. Edits a drawing the drafter has not handed over (saved and closed, or named in the job queue).
3. Changes anything silently. Every change is in the report. (A headless run on a saved copy has no Undo; the safety is
   the copy, the report and the untouched original. One U per step applies only when a step is run by hand in AutoCAD.)
4. Unlocks a layer, detaches or binds an Xref, explodes, or works inside REFEDIT. Locked or foreign content is reported
   and skipped (native AutoCAD protection rule, AGENTS.md).
5. Issues anything to a client. It prepares the folder; a person sends it.

**Where it works:**
1. **Today: on COPIES only** (a copy of the job DWG in a test folder). The driver's own rule (TIM_DESK item 11) is test
   copies only.
2. **Later, with Tim's yes:** in a job DWG the drafter has saved and handed over in the job queue file.

**How it reports:** one report per job listing every change, results as proposals ("Renumber FB3 to FB2: accept?").
Today the original drawing is never touched. Safety comes from three things: copies only, the full report, the untouched
original. Undo is not promised for a saved copy.

### 3.2 How it is run

1. **Our own CLI driver:** `C:\Lisp Files\_ACAD_DRIVER\acad_driver.ps1` (TIM_DESK item 11). Rules that bit before:
   typed commands sent as **complete one-line chains**, never a prompt left waiting (that wedged AutoCAD twice);
   test copies only.
2. **The headless console** (accoreconsole) for non-interactive batch work: schedules, checks, exports, reports.
   It must never run while an install is waiting for it to be absent.
3. **An MCP wrapper only if needed** later (so an AI chat can ask "run the checks on Job X"). It would only call the
   same driver and the same allow-list. Built by us; **no third-party code** (desk rule, INT-035).
4. **AI's part:** reading the report and writing the plain-English morning summary. AI never picks a size or a value.
5. **It works by commands and files only, never by watching or polling windows.** Tim's PC lag finding (driver run 16):
   a screen-reading or computer-control tool polling AutoCAD costs about 1 CPU core while it reads. So the assistant
   sends typed commands, reads files (report, queue, exported PDFs and CSVs), and never reads the screen.

### 3.3 What it needs

1. **Settings keys (R-00, nothing hard-coded):** assistant on/off (default off); allowed steps list; job queue file path;
   report folder; copy folder; quiet hours; maximum run time per job. **Quiet hours are a Settings value**, default
   after 5:30 pm and before 8:40 am. (The 8:40 to 5:30 hours in AGENTS.md are Tim's drafting hours for long test runs,
   not a product rule.) The assistant runs only inside its quiet hours, so it never takes AutoCAD time from a drafter.
2. **A job queue file:** one line per job: DWG path, steps wanted, "handed over by" and when. Written by the drafter
   from a CE button, not by hand.
3. **A morning report:** per job, what ran, what changed (as proposals), what was skipped and why, what needs a person.
4. **Build prerequisite: a non-interactive renumber.** CSMARKSRENUMBER today shows its preview and then waits for Yes
   or No (UX-MARK-01). A waiting prompt is exactly what wedged the driver before. The assistant needs a form that writes
   the preview into the report and changes nothing; the renumber is applied only when the drafter accepts it later.
   Same numbering engine, one code path (design rule 1).

### 3.4 Risks

1. **Wrong drawing:** a live job edited while someone has it open. Guard: copies first; later only queued and closed files.
2. **AutoCAD hangs on a prompt:** guard: complete one-line commands only, time-out, kill the session, report it.
3. **Silent drift:** renumbering or schedule refresh changing what the engineer marked up. Guard: proposals, not edits.
4. **An install collision** with the headless console. Guard: check before starting; never start if an installer waits.
5. **Privacy:** reports name jobs. Guard: reports stay on Tim's PC, never in a repository.
6. **Trust creep:** "it's only boring" slowly becoming design. Guard: the allow-list is a Settings list Tim owns; design
   steps are not on it and cannot be added by the assistant.

### 3.5 What Codex must check

1. Each allowed step on a copy: the result equals doing it by hand; the original is unchanged (file hash the same);
   run by hand in AutoCAD, one U removes it.
2. A locked layer, an Xref and an open REFEDIT: skipped and reported, nothing unlocked.
3. A drawing not in the queue: untouched.
4. A prompt left open by a bad command: the run times out and says so.
5. The report lists every change; nothing changed that is not in it.

---

## 4. PLACEMENT, LOGIC AND DRAFTING STANDARDS LEARNED FROM CURRENT CE DRAWINGS

### 4.1 What CE can learn

1. **From the issued PDFs (already readable, done in the study):** sheet order, sheet titles, notes headings, schedule
   types and columns, tag families (FB, L, RB, RL, EB, IB, TH, BB...), scales (plans 1:100, details 1:20 or 1:10),
   title block fields, revision letters (P, T, A...), legend wording.
2. **From the DWGs (needs the headless read, section 5 of the study):** layer usage, text heights per scale, tag offsets
   and sides relative to members, block names, note positions on the sheet, schedule placement, viewport scales.
3. **From the office masters:** `Drafting\Drawings Templates` (A1 horizontal and vertical title blocks, A3 job templates,
   basement sheet set, the typical blocks-layers-schedules-notes file, Xref templates per level) and
   `Drafting\Standard Details` (footing, raft on-ground and suspended, waffle, timber subfloor, remedial, base plates,
   framing and bracing, block / fence / retaining walls, retention and suspended slabs, stairs, pools, industrial).
4. **From markups (EV3-10):** "before, markup instruction, after" pairs; the instruction is the trusted signal.
5. **Existing pieces it joins:** the CEMARKUP corpus (now local in `C:\CE_DrawingIntelligence`, R-LEARN), the AS-01
   standards catalogue (one schema, `06_Machine_Catalogue`), EV-03 (relationships, not nearness; Unknown stays Unknown).

### 4.2 How it is stored

1. **Every learned number is a Settings value** (R-00): tag offset per scale, text height per scale, layer per object
   kind, note block position, schedule position.
2. **Learned values are proposed, Tim confirms, then they become defaults.** Each shows its tag: Learned (N drawings),
   Tim-confirmed, or Unknown.
3. **Frequency never makes an engineering rule** (EV3-8). Drafting conventions only.
4. **Client-identifying evidence stays local-only** (DATA-01): counts and positions may come back to the plan; names,
   addresses and raw text never do.

### 4.3 How CE uses it

1. **To propose placement:** a new FB tag goes where the office puts it (side, offset, height), shown in the preview.
2. **To check standards:** a QA list of deviations ("text 2.0 high where the office uses 2.5 at 1:100"; "Rev C sheet
   says PRELIMINARY"). **Never a block** (R-27). The drafter can accept, fix, or mark "deliberate".

### 4.4 Phased plan

1. **P1: read-only study of layers, blocks and tags from COPIES** via the headless console. 6 to 10 recent jobs, copies in
   a local test folder, nothing saved back, results local-only, anonymised counts into the plan. Scheduled by the desk.
2. **P2: standards catalogue proposed to Tim** as short typed questions ("FB tags above the beam at 1:100, 2.5 high: right?").
3. **P3: proposals in the plugin:** placement defaults and the deviation QA list, all from Settings.
4. **P4: the boring-end assistant** (section 3), copies first, then handed-over job drawings.

---

## 5. Cancel, Undo, save, locked layers

1. **Escape or Cancel** before Accept writes nothing.
2. **One accepted step = one U** when run by hand in AutoCAD. The assistant's headless run has no Undo once the copy is
   saved: it works on a copy only, lists every change in the report, and leaves the original untouched.
3. **Save:** the assistant saves only copies today. In handed-over drawings (later) it saves once at the end and keeps
   the drawing's own format; it never saves a drawing someone has open.
4. **Locked layers, Xrefs, REFEDIT:** respected; reported and skipped; nothing unlocked, detached, bound or exploded.
5. **Markers from above** are non-printing and rebuilt from records; erasing one by hand is reported, not repeated silently.

---

## 6. Tests and the Codex check list, in roof-down order

### 6.1 Pure tests (no AutoCAD)

1. Load trace roof to first floor to ground to footings: every source listed; Unknowns listed.
2. `RoofPointLoadCarryDown` matcher wired to a command: same results as its existing tests.
3. Proposal engine: strip under a loadbearing wall, pad under a post, thickening under a point load on a slab; size
   Unknown with no calc.
4. Assistant allow-list: a design step is refused; an unknown step is refused; every allowed step writes a report line.
5. Learned-standard check: a deviation is a QA line, never a refusal.

### 6.2 Codex in AutoCAD (synthetic example drawings only, no real job)

1. **Roof:** set the plan level Roof with CSPLANLEVEL; place two girder truss point loads and a post.
2. **First floor:** set level First with CSPLANLEVEL (and once with no level set: markers say "from the level above"
   and CE asks for CSPLANLEVEL); switch `LoadPath.TraceFromLevelAbove` on; markers appear for the roof loads; one
   post with nothing under it shows in the QA list with Show where; nothing prints.
3. **Ground slab:** markers for first floor posts and loadbearing walls; draw EB / IB / TH; legend updates.
4. **Footings:** Propose footings; preview; Escape (nothing); again; Accept all; U (all gone in one step); sizes Unknown.
5. **Boring end on a copy:** queue the copy; run refresh, checks, renumber (non-interactive: preview into the report,
   nothing applied), FREGENALL, STRSCHEDSYNC, PDF export; no prompt is left waiting; a locked layer and an Xref are
   skipped and reported; the report matches the changes; the original drawing is untouched.
6. **Standards QA:** a tag at the wrong height shows one deviation line; nothing blocks.
7. Report "2022-2024: built and unit-tested, not AutoCAD-tested" wherever true.

---

## 7. QUESTIONS FOR TIM (short, typed)

1. **Turn on "markers from the floor above" now?** Rec: yes, on your PC only, for a week. Example: open First floor, see
   "post from roof R3" in grey.
   First, set each plan's level once with CSPLANLEVEL (Roof, First, Ground), or the markers only say "from the level above".
2. **May the assistant run overnight on COPIES of live jobs?** Rec: yes, copies only, report each morning. Example: "Job X:
   schedules refreshed, 2 marks to renumber, PDF set ready".
3. **Which boring steps first?** Rec: schedules refresh, checks, PDF export. Renumbering later. Example: tick 3 of 7.
4. **Renumber marks automatically or as proposals?** Rec: proposals only. Example: "FB3 is now FB2: accept?"
5. **Should CE learn tag and text placement from your last 10 jobs (copies, local only)?** Rec: yes, then you confirm by
   short questions. Example: "FB tags above the beam, 2.5 high at 1:100: right?"
6. **One "Issue revision" step** (revision letter, status, date, register, PDF folder)? Rec: yes, as a preview you confirm.
   Example: "Rev C: status CONSTRUCTION ISSUE, 14 sheets to 2026-10-05_STR_REV C".
7. **Which title block is the DEFAULT for NEW jobs: A1 horizontal or the A3 classic?** Rec: tell me; both are in use (3 of
   the six jobs each). Old jobs keep theirs. Example: "New jobs start on A1 horizontal".
8. **Who may hand a live drawing to the assistant?** Rec: the drafter, by a CE button, per drawing. Example: "Hand over
   S03 tonight".
9. **Copies only for the first month, then live drawings you hand over?** Rec: yes, copies only for the first month.
   Example: in month one it refreshes schedules on a copy of S03; from month two, on S03 itself once you hand it over.
