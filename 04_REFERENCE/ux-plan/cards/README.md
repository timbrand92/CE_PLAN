# UX plan — workflow cards

Eleven workflow cards written 25-26 September 2026 for Tim's V3 UX plan discussion
(`decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`), following the command/workflow review gate in
`C:\Lisp Files\CE_ACAD_PLUGIN\AGENTS.md`. The five Level 3/sizing cards below are **APPROVED as plans** by
the 26 Sep release-chat choices; remaining cards retain their own status. None of the underlying work is
built, tested in AutoCAD, installed or Tim-accepted.

1. **[`UX-RIBBON-01_CARD_2026-09-25.md`](UX-RIBBON-01_CARD_2026-09-25.md)** — selecting a CE pipe/pit/source
   jumps straight to its own contextual ribbon tab, like AutoCAD's Hatch Editor. Corrects a stale premise:
   the memory note calling this a CE_SHARED blocker is out of date — the contextual-tab contract and all
   three Civil contextual tabs already exist and are tested; the only change is one flag
   (`ActivateOnSelect`) already built to carry exactly this decision.
2. **[`UX-RIBBON-04_CARD_2026-09-25.md`](UX-RIBBON-04_CARD_2026-09-25.md)** — merge and automate the seven
   Structural `Administration ▸ Workspace`/`Administration ▸ System` commands, moving what remains into
   Manager. Corrects a second stale premise: the design pack's "install and repair the CE workspace, menu
   and toolbars" description does not match what these seven commands actually do (four window/palette
   openers, a notes browser, two drawing-editing utilities) — the card proposes a merge based on their real
   behaviour instead. Its OPEN 2 (`CESTRUC`'s fate) is answered 25 Sep 2026 (UX-STRUC-10): the launcher role
   is retired, the family ribbon covers it; OPEN 1, 3, 4 and 5 remain open.
3. **[`K-REQ-01_CARD_2026-09-25.md`](K-REQ-01_CARD_2026-09-25.md)** — CDPROFILE Apply and the Pit Schedule
   rows it touches update together: one preview, one Undo. CDPROFILE PR #187's open decision 5.
4. **[`REPAIR-DECIDE-LATER_CARD_2026-09-25.md`](REPAIR-DECIDE-LATER_CARD_2026-09-25.md)** — a "Decide later"
   tab in Drawing Repair for parked findings; anyone can resolve, only an administrator can delete outright;
   Tim is the only administrator on day one. Answers the question draft PR #240 (`claude/ux-repair`) stopped
   and asked for before it would build this. Verified directly against `origin/master`: today's admin-policy
   fallback makes *any* current Windows user an administrator when no policy file exists anywhere — a real
   gap this card's first slice closes on its own.
5. **[`UX-LEARN-01_CARD_2026-09-25.md`](UX-LEARN-01_CARD_2026-09-25.md)** — CE decisions get a machine-learning
   element: a drafter's own habits, the whole office (via Manager), past CE projects (anonymised, DATA-01)
   and corrections, every suggestion showing why, never silently changing an engineering rule. Builds on an
   existing local suggestion ledger (`SuggestionLedgerService`, "FEATURE 10 SEED") that already records the
   right signals privately but has nothing reading them back yet.
6. **[`DETENTION-PIT-ANNOTATE_CARD_2026-09-25.md`](DETENTION-PIT-ANNOTATE_CARD_2026-09-25.md)** — UX-TANK-03: a
   new pit-side command (`CDPITDETENTION`, working name) gives an existing pit a real detention record, so the
   Pit Schedule and the ON SITE DETENTION CRITERIA block count it; the pit stays a pit, CDWT stays
   water-tanks-only. Corrects the premise CDCALC reads a typed litres figure: storage volume comes from the
   pit's own footprint and levels, already wired into `PitScheduleBuilder`/`DetentionTwlService` — the real gap
   is a guided entry point onto that existing mechanism, not a new data model. Flags one narrower, separate
   gate: CDCALC's own interactive Detention tab additionally needs the pit's connected pipes typed Detention,
   which this card leaves to the existing pipe-edit control (OPEN 4).
7. **[`L3-LEVELS_CARD_2026-09-26.md`](L3-LEVELS_CARD_2026-09-26.md)** — Level 3 proposal 1: levels and grades
   for a drawn network (UX-L3-03..06). Fits grades between the held outlet/LPD invert and minimum cover at the
   top pits, treats hand-typed levels as fixed controls, shows ghost invert labels plus a pit/was/now/why list
   (accept all or per pit, one Undo), and states the exact shortfall and options when no solution exists. Builds
   directly on the existing CDRUNSOLVE ("Solve Run") engine and `NetworkDesignService` — the same one hydraulic
   authority CV-02 already requires — plus the existing `EditGhostPlan` ghost renderer (18 Sep ruling); the real
   gaps are fixed-control pits mid-run, per-pit accept in the existing preview dialog, and worst-pit shortfall
   reporting, not a new solver. **APPROVED**; minimum cover at every branch's top pit, branches joined at
   junctions; Hold grade fixed in CDRUNSOLVE is an implementation call.
8. **[`CV-02A_SIZING_CARD_2026-09-26.md`](CV-02A_SIZING_CARD_2026-09-26.md)** — pipe-size suggestions: one
   advisory line in the Pipe window (never changes the pipe) plus a whole-network review in Project Review >
   Proposals, Engineer mode (Keep/Upsize/Unknown/No size works) and Draftsperson mode (Matches/Different/Can't
   verify) tied to the job's existing `CivilDesignRoute`. `Accept all` applies the clear suggestions in one
   Undo, excluding Unknown/no-feasible pipes — supersedes the July plan's "visit every pipe first" gate.
   Corrects nothing stale: the July CV-02A plan and the approved `CV-02_HYDRAULIC_DESIGN.md` card both already
   exist on `origin/master`; this card is what changes for the advisory UI, reusing the already-built
   `PipeFlowSizingAdvisorService` engine rather than adding a second one. **APPROVED**; Accept all is Engineer
   mode only; Unknown and sizing sign-off details are implementation calls. Production sizing stays blocked
   exactly as July ruled.
9. **[`L3-SOURCES_CARD_2026-09-26.md`](L3-SOURCES_CARD_2026-09-26.md)** — Level 3 proposal 2: downpipes and
   source placement (UX-L3-07..10). Uses the architect's DP symbols where present, else roof edges/gutters
   learned from past jobs; destination from the rating report's catchment names (reusing PR #233's existing
   reader), Unknown with a suggested tank/pit when a name doesn't say; all three numbering orders offered with
   one-click renumber; ghost DPs with a thin line to destination and catchment area, accept all or per DP, one
   Undo. Builds on `UX-SRC-05` (DP/CDRG place like pits, before any pipe) and the same `EditGhostPlan` renderer
   as L3-LEVELS. **APPROVED**; learned-pattern default numbering is an implementation call.
10. **[`L3-DETENTION_CARD_2026-09-26.md`](L3-DETENTION_CARD_2026-09-26.md)** — Level 3 proposal 3: detention and
    tank layout (UX-L3-11..14, 19-23). Two-or-three storage options side by side (plan picture, storage, depth,
    council check, e.g. % underground — already a Settings/council value), clash-checked against easements,
    tree zones, footings and services; a complete system (orifice pit sized per `CR-A3`, overflow, the OSD
    criteria block per `UX-CR-10`) in one preview, one Undo; a "Draft: calculation not approved" banner when
    the D+F calculation isn't yet Issued; an option may combine several differently-sized pit-to-pit detention
    runs with pit storage and tanks, every piece listed (UX-L3-23). Uses the Tim-approved chooser sketch
    (`../PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg`, UX-L3-20) and "best learned layout" scored by three named
    signals (UX-L3-22): least pipe/depth/pits (built first, no dependency), issued-without-redraws, and no
    council RFI (depends on the separate, also-unbuilt council RFI reader, built last). **APPROVED**;
    Draft means not approved or not issued (implementation call).
11. **[`L3-NETWORK_CARD_2026-09-26.md`](L3-NETWORK_CARD_2026-09-26.md)** — Level 3 proposal 4: full network
    layout (UX-L3-15..18), last in the build order after levels, sources and detention. Proposes with whatever
    inputs exist and lists the gaps as Unknown; routes/pit positions/set-offs learned from CE's previous
    drawings, not a fixed rule, still avoiding footings/tree zones/easements; always 2-3 options side by side;
    builds around existing drawn work, only the missing parts proposed, any change to existing work shown
    separately and applied only if ticked. Uses the same UX-L3-19/20 visual chooser as L3-DETENTION.
    **APPROVED**; before enough jobs are learned, say so and offer no layout.

**Shared with Structural:** the revision and issue workflow (UX-REG-09 refined, 26 Sep 2026) is one
shared card, not a Civil-specific one — see
[`../../structural/cards/STRUC-REGISTER-ISSUE_CARD_2026-09-26.md`](../../structural/cards/STRUC-REGISTER-ISSUE_CARD_2026-09-26.md),
now extended for Civil/whole-plugin use. Civil has no register or notes page; Civil sheets appear in the
Structural register on combined jobs, and revisions stay separate. It also covers the council pack, issue
plot settings, locked DWG snapshot and Check plot (UX-REG-10..15). **APPROVED**.

**Shared background preparation:** see
[`../../structural/cards/STRUC-ARCH-BACKGROUND_CARD_2026-09-26.md`](../../structural/cards/STRUC-ARCH-BACKGROUND_CARD_2026-09-26.md)
for Civil's own colour/visibility preset, old/new Xref comparison and relative-path repair (UX-XREF-01..03).

Each card follows the same shape: what works today (Keep/Modify/Rebuild/Retire/Missing, read from
`origin/master` in `C:\Lisp Files\CE_ACAD_PLUGIN`, never from AutoCAD), the full drafter experience,
example drawings (the labelled test copies DWG-A/B/S), automated guards versus Tim's own AutoCAD checklist,
smallest-first build slices, and OPEN questions each with a recommended answer. No client name or site
address appears in any of them.

- **[UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md](UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md)** : one read-only line on opening a Civil drawing. Awaiting Tim's approval, not built.
