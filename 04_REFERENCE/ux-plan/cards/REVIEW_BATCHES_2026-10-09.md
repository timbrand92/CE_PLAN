# UX items with no card and not built: review batches (Fri 9 Oct 2026)

**Written by:** design lane run 4 (headless, Opus), 9 Oct 2026 about 02:45 Melbourne (PC clock). Read-only on plugin code.
**Why:** the builders have run out of approved cards. This file groups every V3 UX plan item that has neither a card nor a
commit into review batches of 5 to 10 related commands, the way the AutoCAD command review gate in the plugin's `AGENTS.md`
asks. Order: Stage 1 and the Day 1 workflow first, then Civil pits, pipes and long sections, then Structural roof-down,
then the rest.

## How the list was made (and its limits)

1. **Plan items:** every UX ID written in `V3_UX_PLAN.md`, with ranges such as "01..04" expanded: 508 IDs.
2. **Built:** the ID is named in any commit message on any `origin` branch of `CE_ACAD_PLUGIN` (fetched 9 Oct 02:42). This
   includes draft branches, so it is generous: 244 named.
3. **Carded:** the ID is named in any card in `04_REFERENCE\ux-plan\cards` or `04_REFERENCE\CARDS` (question lists left out):
   202 named. A card that only mentions an ID counts, so this is generous too.
4. **Neither: 173 IDs.** Text matching only. "Named in a commit" is not "works", and an item here may be partly coded under
   another name: each card says what the code does today.
5. Recount PROGRESS_COUNT_2026-10-09 gives 268 UX IDs not named in commits; the difference is the 95 that have a card.

## The batches

**Day 1 and Stage 1 (Civil drafting every user meets on the first day)**

1. **Batch 1, labels on the plan (cards written, DRAFT):** UX-PIT-01, UX-LBL-01, 02, 03, 04, UX-CPLAN-24, 25, UX-SCHED-06,
   UX-EDIT-03. Commands: PIT, CD, CDEDIT, PITEDIT, PITSCHEDULE, AutoCAD MIRROR/ROTATE, a new Tidy labels command.
   Card: `BATCH1_DAY1_PLAN_LABELS_CARD_2026-10-09.md`.
2. **Batch 2, checking the network:** UX-DI-01, 03, 04, UX-SEL-01, UX-PERF-01, 02. Commands: CDCHECK, CDRULES, Checks
   palette, Show where, "nothing selected" prompts, progress bar with Cancel.
3. **Batch 3, how every window feels:** UX-LOOK-01, UX-WIN-01, 02, 03, 04, UX-ACC-01, 03, UX-TIP-01. New Pipe, Edit Pit,
   Pit Schedule windows; ribbon tooltips.
4. **Batch 4, first start and getting help:** UX-START-01, UX-FIRST-01, 02, 03, UX-HELP-06, 07, UX-FAIL-02, UX-RECENT-01,
   UX-PANEL-01, 02. Splash, welcome card, first-use tips, CE panel, recent jobs, who "Send to admin" reaches.

**Civil pits, pipes and long sections**

5. **Batch 5, layers and around the object:** UX-LYR-01, 02, 03, 04, UX-RCLICK-01, UX-PROP-01, UX-XDISC-01, 04.
6. **Batch 6, surface levels and long sections:** UX-RL-01, 02, 03, 04, 05, 06, UX-LSEC-01, 02.
7. **Batch 7, C01 plan conventions:** UX-CPLAN-01, 02, 03, 04, 05, 08, 09, 10, 11, 12.
8. **Batch 8, C01 notes, legend and sheets:** UX-CPLAN-15, 16, 17, UX-NOTES-05, 06, UX-SHEETS-03, 04, UX-SCHED-03.
9. **Batch 9, C02 details, outfall and tanks:** UX-DET-07, 09, UX-CPLAN-31, 32, 33, 34, UX-TANK-01, 02.
10. **Batch 10, site: overland flow, slab, pool:** UX-OLF-01, 02, 03, 04, UX-SITE-02, 03, UX-SLAB-01, 02, UX-POOL-01, 02.
11. **Batch 11, council tools:** UX-CR-01, 02, 04, 06, 07, 16.
12. **Batch 12, survey and WSUD:** UX-SURV-01, 02, 04, UX-WSUD-01, 04.

**Structural, roof down**

13. **Batch 13, framing plan (roof down):** UX-FRM-02, 03, 07, 08, 12, 13, UX-SL3-02, UX-D2-05b.
14. **Batch 14, member schedules:** UX-SSCHED-01, 02, 03, 04, 12.
15. **Batch 15, QA against the engineer's markup:** UX-QA-01 to 08, UX-STRUC-06.
16. **Batch 16, detail library, details sheets and tags:** UX-DET-01, 02, 03, 04, 05, 06, UX-STRUC-09b.

**Shared, later**

17. **Batch 17, issue and drawing standards:** UX-REG-01, 02, 03, 06, 08, UX-STDS-01, 02, 03.
18. **Batch 18, names and ribbon:** UX-NAMES-01, 02, 03, 05, 06, UX-RIBBON-05, 06, 07.
19. **Batch 19, other people's drawings:** UX-DWG-02, 03, UX-ARCH-01, 02, 03, UX-MIX-02.
20. **Batch 20, Ask CE:** UX-AI-01 to 07.
21. **Batch 21, proposals feel, checklist, job notes:** UX-L3-25, 26, UX-CHK-01, 02, 03, UX-NOTES-01.
22. **Batch 22, Manager day to day:** UX-MGR-04, 05, 06, 07, 09, 10, 11, 12, 13.
23. **Batch 23, Settings page (small, 4):** UX-SET-02, 03, 05, 06.

Total 173. Batch 1 has cards; Tim's questions for it are in `TIM_BATCH_QUESTIONS_2026-10-09.md`.
