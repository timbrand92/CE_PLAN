# UX plan — workflow cards

Six DRAFT workflow cards written 25 September 2026 for Tim's V3 UX plan discussion
(`decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`), following the command/workflow review gate in
`C:\Lisp Files\CE_ACAD_PLUGIN\AGENTS.md`. Each is **DRAFT — awaiting Tim's approval before any code starts.**
None of the underlying work is built, tested in AutoCAD, installed or Tim-accepted.

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
   behaviour instead.
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

Each card follows the same shape: what works today (Keep/Modify/Rebuild/Retire/Missing, read from
`origin/master` in `C:\Lisp Files\CE_ACAD_PLUGIN`, never from AutoCAD), the full drafter experience,
example drawings (the labelled test copies DWG-A/B/S), automated guards versus Tim's own AutoCAD checklist,
smallest-first build slices, and OPEN questions each with a recommended answer. No client name or site
address appears in any of them.
