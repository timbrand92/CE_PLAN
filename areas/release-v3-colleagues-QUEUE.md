# REL execution queue: the holiday run (29 Sep to about 26 Oct 2026)

**Owner:** `CE_ACAD / release-v3-colleagues / build + release / 06` (Sonnet 5.5) and its successors. **Written by**
plan/05 (Opus 5.5) on 29 Sep 2026 from Tim's answers in `decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` (29 Sep section).

**Status lives here.** Tick `[x]` with the date and PR/commit in the same step as the work, then commit and push
`C:\CE_PLAN` at once. The area file `release-v3-colleagues.md` keeps the charter, Lessons, "For Tim" and the log; this
file keeps the order. **Authority:** Tim's words in `decisions\` > `C:\TimOS\RULES.md` > the OPERATING CHARTER (area file
top) > this queue. If this queue disagrees with a ruling, the ruling wins: fix the queue and add a Lessons line.

**The goal (Tim, 29 Sep: "Everything first"; charter 28 Sep):** build the whole of V3 (the V3 plan and the V3 UX plan:
about 345 UX items plus the open bugs), Codex-test it in real AutoCAD, keep it fast and reliable, and have the colleague
copy staged for Tim's return. **Nothing is published to any colleague while he is away** (Tim, 29 Sep).

**Honest outlook (plan/05's estimate, not a promise):** building is not the limit (about 160 UX items went in over
25-29 Sep); checking is. Expect most of V3 built and Codex-tested by his return, the heaviest features (CE proposing
designs, Structural computations, reading mark-ups, Ask CE) possibly still being finished, and every
engineering-judgement item waiting for Tim.

---

## 0. Start of every session (10 minutes)

1. `C:\TimOS\RULES.md` and `ROUTER.md`.
2. Area file top only: the charter, Lessons and "For Tim when he is around". Stop at "Item 39.1"; below is history.
3. This file: sections 1-4 in full; section 5 for the current checkpoint; sections 6-11 when needed.
4. `C:\Lisp Files\_CODEX_RUNNER\builder_rules.txt` (every builder) and `common.txt` (every Codex brief).
5. Meters: `get_usage` (weekly and 5-hour); `bash "C:/Lisp Files/_CODEX_RUNNER/codex_usage.sh"`; `daily_cap.sh explain`.
6. What is installed: the ProductVersion of the three Modern DLLs under `%APPDATA%\Autodesk\ApplicationPlugins\`, and
   GitHub #78. Never trust a remembered version.

## 1. Calendar and budgets

1. **Tim away** Wed 30 Sep, back about **Mon 26 Oct** (assumed; he has not confirmed it). While he is away, AutoCAD on
   his PC is free all day, every day. If a person is using the PC, don't start Codex: wait.
2. **Daylight saving starts Sun 4 Oct** (02:00 becomes 03:00). All times here are Melbourne local.
3. **Claude week** resets Fri 2 Oct 12:00, then Fri 9, 16 and 23 Oct at **13:00** (same instant, daylight time).
4. **Codex week** resets Sun 4 Oct **05:01** (it showed 04:01 before daylight saving), then Sun 11, 18 and 25 Oct.
   Read `resets_at`; don't assume.
5. **Claude cap while Tim is away: 90%** of each week (Tim, 29 Sep). **Pace line = % of the week elapsed x 0.90.**
   Over the line: no new builders except fixes for a failed Codex pass; Opus only for merge-blocking reviews. Under it:
   up to 4 Sonnet builders at once. If the 5-hour window passes 80%, pause new builders until it drops.
6. **Week 0 exception:** Claude was at 95% on 29 Sep about 17:00 (resets Fri 2 Oct 12:00), already over 90%. Until then only Codex launches and a
   five-line read of each result (target 1% in total, taken from Tim's 10%). No builders, no Opus, no install, no merge.
7. **Codex:** `daily_cap.sh` gives an even share (14% a day; an unused day carries forward). An AutoCAD pass costs about
   7-8%, a sol window build 1-2%. **Unused Codex expires at its reset:** in the last 36 hours, spend what is left on
   sweep parts.
8. **Costs (correct these from the meters; one Lessons line per new measurement):** 5 Sonnet builders cost about 2% of
   the Claude week (27 Sep, before Sonnet 5.5). Opus review: not yet measured, so record the before and after of the first
   three. This chat's own turns cost more as its context grows: sub-agents (Explore, model sonnet) read the big files.
9. **Planned Claude split per week (estimate, correct it after week A):** this chat about 10 points, builders about 55
   (roughly 100 builder runs), Opus reviews about 15 (roughly 8), reserve about 10.

## 2. Lanes and the daily loop (from Fri 2 Oct 12:00)

**Lanes.** Parallel builders never touch the same file; each brief lists the files it may change.
1. **F, fixes:** Codex FAILs and open bugs. Always first.
2. **C, Civil** (`Modules/Drainage`): waves C1-C6 in section 5.
3. **S, Structural** (`Modules/Structural`, its own branch chain): waves S1-S5.
4. **M, Manager, front door and packaging** (`Modules/Manager`): M1-M3. A CE_SHARED change goes to Civil and Manager
   byte-identical, lane for lane (memory "CE_SHARED is one assembly identity").
5. **L, big features:** one builder at a time, whenever under the pace line: L1-L4.
6. **W, windows (Codex, sol, ruling B):** every card lists its window work; Claude writes the contract in
   `04_REFERENCE\contracts\`; Codex builds the XAML through `queue3.sh`.

**The loop.**
1. **06:00, silent:** read both meters. Read the last Codex run (`out\<name>.last.txt`, then its report). File every
   FAIL as a bug (carpark template, next ID). Write every PASS as Codex-accepted (PENDING_TESTS row; carpark status
   `FIXED — date (Codex-accepted, pass N)`). Engineering-judgement items go to section 8's question list and are never
   accepted by Codex or Claude.
2. **Morning, dispatch builders** up to the pace line: lane F first, then the next items of lanes C, S, M and L in
   section 5's order. One family (2-6 related UX IDs) or one bug per builder. Brief = `builder_rules.txt` plus 5-15 lines:
   the IDs, the UX-plan line, the card, the files it may touch, the tests, Tim's AutoCAD check steps. Queue Codex window
   jobs (sol, medium) for the window half.
3. **Midday, reviews:** Opus (`Agent`, model opus) for anything touching reactors or overrules, Undo, caches or queues,
   save/close, link logic, grips, or schedule-reading rules; a Sonnet review for the rest. Every review also checks
   what ELSE changed in the drawing output and the command's properties (Lesson 10, the RC regression of 29 Sep).
   MERGE-WITH-FIXES goes to a Sonnet fixer on the same branch.
4. **17:00, the train:** new `claude/rel-YYYYMMDD` (Civil and Manager) from `master`, and `claude/rel-YYYYMMDD-struc`
   from `claude/struc-d1-prep`; merge the reviewed PRs; bump the version in the csproj AND `PackageContents.xml`
   (Lesson 6); build every lane (net48, net8, net10) with `-p:SkipDevBundle=true -nr:false --disable-build-servers`;
   run the full Civil net10, Manager and Structural suites; **count what ran** (zero discovered is a failure); compare
   failures **by name** with the known list in `builder_rules.txt`; pre-build the Structural candidate (install recipe,
   see A2).
5. **18:00, install on Tim's PC** (charter 5, Lesson 9): AutoCAD closed, checked twice 30 s apart; no Codex run live;
   rename the old bundles to `*_PRE_<commit>_<stamp>.backup`; copy; SHA256 every file; read ProductVersion back;
   CE_SHARED identical in Civil and Manager, lane for lane; native ARX unchanged; name the one-step undo; update #78 and
   the PENDING_TESTS "LIVE since" block.
6. **19:00, tonight's Codex brief** (template, section 6): the sweep part due, plus Part Z (every fix installed since the
   last pass, with its REGRESSION_LOG check steps), plus 5-10 old carpark re-tests. Launch with `queue3.sh` when the
   day's share allows, otherwise at 04:07. **No full test suites on the PC while a Codex pass runs, and no building at
   all during a long-session speed pass** (it would spoil the timings).
7. **After each pass, merge:** a PR with an independent review AND a Codex PASS on what it changed merges to `master`
   (Civil/Manager) or `claude/struc-d1-prep` (Structural). Merge commits only, never rebase. After merging, diff the
   content; don't trust green (memory "a rebase silently dropped work"). Engineering-judgement items still wait for Tim
   (decision of 28 Sep, item 3).
8. **After every Codex run:** copy the CE logs aside (memory "tests can touch Tim's real files"); check `CPROFILE` and
   `OSMODE` in the report ("Tim", 21759); diff `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` with the last baseline and
   put back only single values a test changed, never a blanket restore.
9. **Heartbeat** every 2 hours, silent unless something happened (Lesson 8). **One Lessons line per day.** Tick this
   file, the carpark, PENDING_TESTS and IDEAS_INBOX in the same step as the work; commit and push each time (ROUTER 1b).

## 3. Standing rules for this run (added to the charter, not replacing it)

1. **Base branch:** until A1 is done, builders branch from the live line named in #78 (29 Sep: `claude/rel-20260929b`;
   Structural `claude/rel-20260929b-struc`). After A1: `origin/master` and `origin/claude/struc-d1-prep`. Update
   `builder_rules.txt` in the same hour (on 29 Sep it still named `rel-20260929a`).
2. **Card before code** (AGENTS.md review gate). Each family gets a short card in `04_REFERENCE\ux-plan\cards\` first:
   what the drafter clicks and sees, prompts, window, preview, Escape, one Undo, save/reopen, tests, Codex steps. A card
   built only from Tim's rulings, with no open question, is approved in principle and may be built (practice since
   26 Sep, area log items 195 and 198; Tim can still reject it). A card with an open question: build the parts it
   doesn't touch, and put the question in section 8.
3. **Engineering judgement stays Tim's** (RULES 4.5): council values, design rules, sizing, Structural computations.
   Build them settings-first (R-00) with values tagged Assumed or with their source, mark them "Needs Tim's engineering
   acceptance", and let Codex accept the mechanics only.
4. **The 2022-2024 lane:** every change builds net48, but this PC cannot run AutoCAD 2022-2024. Every report says
   "2022-2024: built and unit-tested, not AutoCAD-tested". UX-MIX-03 stands: no automatic pipe upgrade on colleagues'
   PCs until the 2022-2024 enabler is proven.
5. **Opus reviews are not optional** on the risk list (Lesson 3), even under usage pressure: slow the builders instead.
6. **Unfinished features ship hidden:** anything not Codex-accepted at a train stays off the ribbon and out of Help (a
   switch, not a removal). Old typed names stay forever (UX-NAMES-01). Hiding an existing visible command needs Tim.
7. **Speed framework** (ENGINEERING_RULEBOOK): every PR states its [PERF] effect; any CE handler over 50 ms is a bug.
8. **Never:** install from a failed build; delete spine IDs; publish to colleagues; open or copy
   `C:\CE_DrawingIntelligence`; put a client name or address in a repo, commit, branch, PR or screenshot name; create a
   new build, deploy or versioning script (Codex briefs are not scripts); set up a persistent schedule or change a
   setting on the PC without Tim.
9. **Only this chat runs the queue.** No other chat installs, merges or launches Codex while it runs.

## 4. Week 0: Codex tests only (Tue 29 Sep to Fri 2 Oct 12:00)

- [ ] **W0-1 Tue evening:** chat 04 does ONE last install if it is pre-built and gated before Tim leaves: Civil 3.0.15
      (#383, #384) and Structural 1.0.86 (#385 reviewed + #386, the RC restore after Tim's "YOU RUINED RC", Lesson 10).
      Tim closes AutoCAD when it asks (his today-only rule). Then chat 04 starts no more builders (Claude at 95%). If it is
      not ready before Tim leaves, it waits for Friday's train (A4).
- [ ] **W0-2 Tim pastes the build/06 prompt.** build/06 renames itself, asks to turn on Remote Control (so Friday
      summaries reach Tim's phone), sets the timers below, then messages chat 04: "taken over your Codex timers; cancel
      yours and stop". Chat 04 confirms and stops.
- [ ] **W0-3 Wed 30 Sep: no Codex.** Wednesday's even share is spent (cap 58%, used 55%, a pass costs 8%).
- [ ] **W0-4 Thu 1 Oct 04:07,** in the background: pass 18 on whatever is installed (3.0.15 / 1.0.86 if W0-1 happened,
      else 3.0.14 / 1.0.85: add the RC check and #383/#384's steps to pass18.txt if W0-1 happened), then synthetic
      drafting test 1 (Tim's Thursday):
      `MAXC=1 bash "C:/Lisp Files/_CODEX_RUNNER/queue3.sh" "pass18|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6-astra|low|auto|8" "draft1|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6-astra|low|auto|8"`
      If the runner skips draft1 for the day's share, it goes first on Friday. Read the two `.last.txt` files only;
      filing waits for Friday 12:00.
- [ ] **W0-5 Thu:** write `sweepC1.txt`, `sweepC2.txt`, `sweepC3.txt` (section 6) and `bug160win.txt` (A5), short.
- [ ] **W0-6 Fri 2 Oct 04:07:** in this order until the day's share is used: `draft1` (if skipped), `sweepC1` (cost 8),
      `branchwin` (the queued window job, cost 2), `bug160win` (sol, medium, cost 2).
- [ ] **W0-7 Sat 3 Oct 04:07:** whatever Friday skipped, then `sweepC2` and `sweepC3`: this spends the last of Codex's
      week before Sun 05:01.

## 5. The queue

### 5a. Week A opening: Fri 2 Oct 12:00, in this order

- [ ] **A1 Converge the trunk.** Nothing has merged to master since 28 Sep; about 35 draft PRs (#349 to #385) sit on
      release branches.
      1. List every PR in the live lines (`rel-20260929b`, `rel-20260929b-struc`) with its review verdict, its Codex
         evidence (passes 16, 17, X1, 18 and sweep C1-C3) and the result. A sub-agent does the reading.
      2. Anything that FAILED a pass is fixed on top first (lane F).
      3. One converge PR each: the live Civil/Manager line into `master`, the live Structural line into
         `claude/struc-d1-prep`. Merge commits, never rebase. Afterwards diff `master` against the live line: it must be
         empty apart from what was deliberately held (#88 CDMOVETEST stays off).
      4. Close each constituent draft PR with "merged via #N". Delete nothing.
      5. Update `builder_rules.txt`: base branches, known-failure list. Same hour.
- [ ] **A2 Make the area file cheap to read.** First lift the two install recipes (Civil: memory
      `codex-runner-and-install-recipe`; Structural: area log item 323) into a short "Install recipes" section at the top.
      Then move log items 1-335 of `release-v3-colleagues.md`, word for word, to
      `archive/chat-records-2026-09/REL_LOG_ITEMS_001-335.md`, leaving a one-line pointer. Keep the charter, Lessons,
      "For Tim", sections 1 to 5c and the 29 Sep handoff. Same for PENDING_TESTS "LIVE since" blocks older than 28 Sep.
      Moving, never deleting.
- [ ] **A3 Carpark hygiene** (charter: "constantly being reduced"). A sub-agent sorts every entry not FIXED or WONT FIX:
      (a) V3-era and still real; (b) already fixed in code, with the evidence: goes to Part Z for a Codex re-test;
      (c) about code V3 retired: propose "WONT FIX — retired in V3", listed for Tim, NOT applied; (d) needs Tim. Bring
      the Status Summary table up to date (BUG-158, for example, still says OPEN though its fix merged in #347). Then 5-10
      re-tests a night until (b) is empty.
- [ ] **A4 Structural 1.0.86, only if W0-1 did not install it:** confirm #385's review covered the floor-prefix rule
      (1FB1, GB2, B1, PB1, level-prefixed tags) and the Insert blocking change, and that #386 restores RC exactly as it
      was before 8d382ec0 (Lesson 10: diff RC's properties before and after); then the next train.
- [ ] **A5 BUG-160 part 2, the pick window (Tim approved 29 Sep).** Claude: when a grip drag on a grade-held pipe with a
      typed bottom level ends, open the choice; the chosen value goes to the plan text, the stored levels and the project
      record together; one Undo. Codex (`bug160win`): a small one-page window "Keep your 10.30 / Use automatic 10.25",
      Enter and Esc both keep the typed value. Builds on part 1 (#354). Opus review (grips, Undo).
- [ ] **A6 XCIVIL level flag (Tim approved 29 Sep).** Imported pipes keep their imported levels. An end whose imported
      level disagrees with the grade at the pit wall by more than a Settings tolerance (R-00) is listed in Project Review
      ("Imported level - check"). Nothing is changed.
- [ ] **A7 Fix wave:** everything pass 18, draft1 and sweep C1-C3 found (lane F).
- [ ] **A8 V3-era open bugs,** after A7: BUG-192 (read pass 18's [REDO] line first), BUG-197, 200 and 201 (the rest of
      X1), BUG-069 (#369 held: decide with a review), BUG-180, BUG-172, BUG-171; then category (a) of A3.

### 5b. The waves (take the next item in each lane; the checkpoints are targets, not promises)

**Lane C, Civil** (the remaining IDs of each family are in section 10)
1. **C1 Foundations every command uses:** UX-LOOK-01 (every window gets the one-page shell, window by window, with the
   Codex review's item 19 "tabs, not scrollbars" folded in), UX-WIN-01..04, UX-CMD-01/03/04, UX-UNDO-01, UX-MSG-01..03
   (the CE bell), UX-FAIL-01/02, UX-PANEL-01/02, UX-SET-02/03/05/06 (06 is the LPD note box), UX-LYR-01..04, UX-LIVE-01,
   UX-VOICE-01 (message sweep), UX-SEL-01, UX-TIP-01, UX-PERF-01/02, UX-ACC-01..03, UX-START-01, UX-RCLICK-01,
   UX-PROP-01, UX-SHARE-01, UX-RECENT-01.
2. **C2 The everyday network:** UX-PIPE-01/02/03/07 (03 is the recent diameter, material and invert buttons), UX-PIT-01
   (catch reach = outline + 100 mm), UX-SRC-01..03, UX-LBL-01..04, UX-DI-01..04 (TRIM, EXTEND, BREAK and JOIN on
   pipes: Opus review), UX-EDIT-03, UX-SCHED-01b/03/04b/06, UX-TANK-01/02, UX-SURV-01/02/04, UX-RL-01..06.
3. **C3 Plan conventions and outputs:** UX-CPLAN still open (01-05, 08-12, 15-17, 24, 25, 31-34), UX-DET-07/09,
   UX-NOTES-05/06, UX-SHEETS-03/04, UX-LSEC-01/02, UX-STDS-01..03, UX-REP-02/03, UX-DWG-01..03, UX-MIX-02, UX-XREF-02.
4. **C4 Design and calculations:** UX-CALC-01..03, UX-SIZE-01..03, UX-DES-02/03.
5. **C5 Council and site:** UX-CR-01..17 (values stay on the Settings page with the CR-D1 "Assumed" tags), UX-RFI-01..03,
   UX-OLF-01..04, UX-SPS-01..04, UX-WSUD-01..04, UX-SITE-01..04, UX-SLAB-01/02, UX-POOL-01/02.
6. **C6 Across disciplines and issue:** UX-XDISC-01..04, UX-ARCH-01..03, UX-REG still open (01-03, 06, 08, 10-15).

**Lane S, Structural**
1. **S1 Front door:** UX-STRUC-01..11 and 13 (families on the ribbon, about 40 tools instead of 298; the CESTRUC
   launcher retires only once its unique functions have homes).
2. **S2 Schedules and framing:** UX-SSCHED still open, UX-FRM still open, UX-UNIT-01..04.
3. **S3 Notes, symbols, sections, details:** UX-NOTES-02..04 and 07..11, UX-SYM-02/03, UX-SEC-01..03, UX-DET-01..06,
   UX-SHEETS-01/02.
4. **S4 Foundations and walls** (Needs Tim's engineering acceptance): UX-FDN-01..05, UX-RAFT-01..04, UX-LOAD-01..03,
   UX-BSMT-04..06, UX-RW-01..11.
5. **S5 Computations and later-stage objects** (Needs Tim's engineering acceptance): UX-SCALC-01..08 (fold in the
   CE_COMPSHEET logic, idea of 20 Sep), UX-D2-05b (card only unless S1-S4 are done).

**Lane M, Manager, front door and packaging**
1. **M1 Manager:** UX-MGR-01..13.
2. **M2 First day and help:** UX-HELP-06/07, UX-FIRST-01..03, UX-RIBBON-03/05..07, UX-NAMES-01..03/05/06,
   UX-CHK-01..03, UX-NOTES-01.
3. **M3 The colleague package, not published:** REL-03 package audit on master (every lane, hashes, every file, CE_SHARED
   identity); REL-07 colleague notes filled from the Codex results; REL-09 rollback rehearsal on Tim's PC both ways
   (install, go back, install again); the candidate is copied from what was tested, never rebuilt separately.

**Lane L, big features (one builder at a time)**
1. **L1 The learning base:** UX-LEARN-01..04 (card exists): habit, office and correction store, the "why" line, each
   person's view and off switch. No corpus import (`C:\CE_DrawingIntelligence` is off limits); the features say "not
   enough learned yet" until an approved import exists.
2. **L2 CE proposes, Civil** (cards approved in principle): L3-LEVELS, then L3-SOURCES, L3-DETENTION, L3-NETWORK
   (UX-L3-01..26; the chooser is UX-L3-19/20).
3. **L3 Reading mark-ups and Ask CE:** UX-QA-01..08, UX-AI-01..07. First find out what the AI runtime needs (key, proxy,
   cost). A key, a paid service or a privacy choice is Tim's: park it with the question.
4. **L4 Structural proposals:** UX-SL3-01/02.

**Checkpoints**
1. **Fri 9 Oct:** A1-A8 done; C1 and S1 built; C2 half built; L1 built; the Civil sweep finished; fewer open bugs than
   on 2 Oct.
2. **Fri 16 Oct:** C2 and C3 built; S2 built; M1 built; L2 LEVELS and SOURCES built; the Structural sweep finished; real-job
   comparison 1 done.
3. **Fri 23 Oct:** C4 and C5 built; S3 built; M2 built; L2 finished; UX human-use pass 1 done.
4. **Tim's return:** C6 and S4 built; S5, L3 and L4 built or in progress; fix-out done; final full regression passed;
   the candidate staged (M3); the return page (section 11) written.
If a checkpoint slips, never cut checks to catch up: say so in the Friday summary with the new date.

## 6. The Codex programme

1. **The nightly pass** (one a day; a second when the week allows): the sweep part due, plus Part Z, plus carpark
   re-tests. About 8%.
2. **Civil sweep, from Fri 2 Oct, about one part a night.** Tim, 29 Sep: every feature, button, command and window,
   from a debugging AND a user-experience view.
   1. **C1 Front door:** start-up, the CE tab and contextual tabs, the CE panel, Help, What's New, Settings (every tab),
      Feedback, Manager status, the find box.
   2. **C2 Drawing the network:** CD in every mode (pit to pit, free end, branch onto a main, inside-wall snap, rising
      main, breakline, charged), PIT and New Pit, sources (DP, CDRG, OF/IO, strip, trench grate), CDSL, CDFALL, CDSLAB.
   3. **C3 Editing:** Edit Pipe, Edit 2 Pipes, batch edit, Edit Pit, grips, MOVE, STRETCH, COPY, MIRROR, ROTATE, ERASE,
      EXPLODE, U and REDO, CDPROPAGATE, CDRENUMBER, tidy labels, the Inspector.
   4. **C4 Schedules and review:** Pit Schedule (typing in cells), CDCHECK, Project Review and What CE Found, the
      dashboard, Checks, the Excel export.
   5. **C5 Design and calculations:** CDSETUP and CDDESIGN (job mode), CDRAINFALL, CDLPD, CDCALC (catchments, OSD,
      orifice), CDRUNSOLVE, sizing.
   6. **C6 Tanks, details and issue:** CDWT, detention pit, C02 details, CE Blocks, notes, sheets, print and issue,
      Drawing Standards.
   7. **C7 Import, repair and survey:** CDIMPORT and XCIVIL, CDSURVEY, CDSYNC, CDREBUILD, CDREPAIR, CDCHECKDWG, upgrade
      on open, and what a person without V3 sees (the core-console proxy check, UX-MIX-01).
   8. **C8 Long session:** 90 minutes of ordinary drafting with CE loaded, save, close and reopen, and the [PERF] summary
      compared with the last one (Tim's 29 Sep idea). No building on the PC during it.
3. **Structural sweep, from Sun 11 Oct:** S1 front door, ribbon families, settings, CSWAKE and staying quiet in Civil
   drawings; S2 beams and columns (commands 1, 2, 4, 5; D2 connected framing; grips; MOVE bringing beams); S3 schedules
   (XCLMTXT, STRSCHED*, member, footing, pier, lintel); S4 tags, marks, notes, symbols, sections, the detail library;
   S5 foundations, slabs, bracing, lintels, retaining; S6 CEARCHREVIEW (2027 native), sheets and issue, long session.
4. **Weekly:** a long-session speed pass, alternating Civil and Structural (C8 and S6 count in their sweep weeks).
5. **Drafting:** draft1, synthetic (Thu 1 Oct); RJ1, real job (section 7, week B); draft2, a harder synthetic job
   (week C); RJ2 (week D, if RJ1 went well).
6. **UX human-use pass** (week C, and again before staging): Codex acts as a colleague who has never seen CE, using only
   Help and the colleague notes on a synthetic job, and scores clicks, time, wording and dead ends.
7. **The brief template** (write `<name>.txt`; `queue3.sh` appends `common.txt`):

```
CODEX <SWEEP C3 | PASS 19 | ...> - AUTOCAD TEST ON TIM'S PC (<date>; Tim is away; charter 28 Sep 2026).
THIS IS A TEST PASS: IGNORE every builder instruction in the shared text below (worktree, merge, build, PR, file lists).
Change NO code, settings file, bundle or template. Evidence only. A PASS counts as Codex-accepted (Tim, 27 Sep);
engineering-judgement items are reported, never accepted.
FIRST: write down the ProductVersion of the three installed CE DLLs. Then read CPROFILE and OSMODE inside AutoCAD
(expected "Tim" and 21759). Read both again at the end.
WORK ONLY on copies under C:\Lisp Files\_TEST_COPIES_20260923\ (copy what you need; never open an office file in place).
STOP by <time> or at {CAP}% Codex weekly usage: close AutoCAD WITHOUT saving (No to every prompt), copy the CE logs,
save the report.
SCOPE: <this part's list>. For EVERY command, ribbon button, window, tab, field, grip, prompt and right-click item in scope:
 (1) does it work: run it on a real test drawing, including Cancel, Escape, one U, REDO, save / close / reopen;
 (2) would a drafter understand it: wording, clicks, defaults, where things are, speed (quote every [PERF] line over 50 ms);
 (3) PASS / FAIL / BLOCKED / NOT TESTED with the exact steps, what you saw, a screenshot path for every FAIL and window.
PART Z (re-tests): <each installed fix with its REGRESSION_LOG check steps>.
CARPARK RE-TESTS: <5-10 bug IDs with their steps>.
REPORT: C:\Lisp Files\_TEST_COPIES_20260923\CODEX_<NAME>_<yyyy-mm-dd>.md - the four counts, the FAIL list first (command,
what happened, what was expected), then UX findings ranked, then the slow [PERF] lines.
LAST MESSAGE: the report path, the four counts, the FAIL list one line each, both profile checks.
```

## 7. Real-job drafting comparison (Tim, 29 Sep: "Both: made-up Thu, real later" and "Yes, you pick")

1. **When:** once CD-BRANCH-01 (branch pipes, free ends) and the speed work are Codex-accepted; about week B.
2. **Pick** an easy single-dwelling stormwater job with an issued C01, from the office Projects folder (path in
   `ROUTER.md`). DATA-01 exception for this test only: read the folder and copy **inputs only** (architectural
   background, survey, STORM report) to `C:\Lisp Files\_TEST_COPIES_<date>\RJ1\`, renamed to neutral names. The job's
   name stays in a local note in that folder only: never in a repo, commit, branch, PR, Codex brief text or screenshot
   name.
3. **Codex drafts** the C01 from the inputs with CE commands only, without being told which job it is. A separate step
   compares it with the issued drawing: pits, pipes, sizes, grades, levels, labels, schedule, notes, time and clicks.
4. **Record** the anonymised lessons in the repo (what CE got wrong, what took longest); client detail stays local
   (RULES 9.9).

## 8. Tim while he is away

1. **The Friday summary**, just after the Claude reset: a one-line phone push, then in the chat, FOR TIM style,
   numbered, no tables:
   1. The four words, counted separately: built, Codex-tested, installed (version), Tim-accepted.
   2. Three things he would notice in AutoCAD, each with a real example.
   3. Up to three problems.
   4. Both meters.
   5. Next week in three lines.
   6. Up to five tap-to-answer questions (AskUserQuestion) that would unblock building, each marked "ignore if busy:
      this item just waits".
2. **Pings between Fridays only for:** an install that stopped AutoCAD or CE starting (with the rollback done); anything
   touching his real files or data (a leak-scan trip, his settings changed); the run stopping (usage gone early, PC
   trouble); a question blocking a whole lane for more than two days.
3. **His messages never stop the work** (charter 3): classify, file, give a rough time or %, carry on.
4. **Questions waiting for the next Friday** (add as found; ask at most five): none yet (29 Sep).

## 9. When something goes wrong

1. **Claude runs out early:** stop the builders; keep Codex going on sweep parts with launch-only turns; resume at the
   reset.
2. **Codex runs out early:** the builders carry on and bank; installs may continue; merges wait for a pass.
3. **A train fails to build or loses tests:** never install (a hard block). Drop the PR from the train or fix it, and
   install tomorrow.
4. **A read-back mismatch, or CE fails Codex's start-up check:** roll back at once (rename the backup back), record it in
   #78; ping Tim only if the rollback failed.
5. **The chat compacts or is replaced:** the state lives in this file, the area file top, the carpark, PENDING_TESTS
   and #78. A successor starts at section 0 and re-creates the timers first.
6. **The Claude app or the PC restarted:** timers are gone, so re-create them first. After a Windows restart nothing runs
   until Tim logs in, which is why he paused Windows Update.
7. **Context:** keep this chat's context small (sub-agents read the files). At a Friday reset with the context over half
   full, hand off (RULES 14.2, "when the work changes shape"): the handoff goes at the end of the area file; the next chat
   is `CE_ACAD / release-v3-colleagues / build + release / 07`.

## 10. V3 UX items not found in any commit message (from `git log --all`, 29 Sep 2026)

About 160 of the plan's roughly 505 item IDs appear in commit messages; the roughly 345 below do not. A commit message can
mis-name things, so confirm each family in the code before building it, and tick the family here when it is built.

1. **Civil, C1 foundations:** LOOK 01; WIN 01-04; CMD 01, 03, 04; UNDO 01; MSG 01-03; FAIL 01, 02; PANEL 01, 02;
   SET 02, 03, 05, 06; LYR 01-04; LIVE 01; VOICE 01; SEL 01; TIP 01; PERF 01, 02; ACC 01-03; START 01; RCLICK 01;
   PROP 01; SHARE 01; RECENT 01.
2. **Civil, C2 everyday network:** PIPE 01-03, 07; PIT 01; SRC 01-03; LBL 01-04; DI 01-04; EDIT 03; SCHED 01b, 03, 04b,
   06; TANK 01, 02; SURV 01, 02, 04; RL 01-06.
3. **Civil, C3 conventions and outputs:** CPLAN 01-05, 08-12, 15-17, 24, 25, 31-34; DET 07, 09; NOTES 05, 06;
   SHEETS 03, 04; LSEC 01, 02; STDS 01-03; REP 02, 03; DWG 01-03; MIX 02; XREF 02.
4. **Civil, C4 design:** CALC 01-03; SIZE 01-03; DES 02, 03.
5. **Civil, C5 council and site:** CR 01-17; RFI 01-03; OLF 01-04; SPS 01-04; WSUD 01-04; SITE 01-04; SLAB 01, 02;
   POOL 01, 02.
6. **Civil, C6 across disciplines and issue:** XDISC 01-04; ARCH 01-03; REG 01-03, 06, 08, 10-15.
7. **Structural, S1-S5:** STRUC 01-09, 09b, 10, 11, 13; SSCHED 01-06, 08, 11-13; FRM 01-04, 06-10, 12, 13;
   UNIT 01-04; NOTES 02-04, 07-11; SYM 02, 03; SEC 01-03; DET 01-06; SHEETS 01, 02; FDN 01-05; RAFT 01-04; LOAD 01-03;
   BSMT 04-06; RW 01-11; SCALC 01-08; D2 05b.
8. **Manager and front door, M1-M2:** MGR 01-13; HELP 06, 07; FIRST 01-03; RIBBON 03, 05-07; NAMES 01-03, 05, 06;
   CHK 01-03; NOTES 01.
9. **Big features, L1-L4:** LEARN 01-04; L3 01-26; QA 01-08; AI 01-07; SL3 01, 02.

## 11. For Tim's return (one page; the full list is "For Tim when he is around" at the area file top)

1. **Look at the staged copy** (15 minutes), then yes or no to the pilot, and name the colleague (AutoCAD 2027 first).
2. **The 2022 check** on his VM (AutoCAD 2022 was not installed on the VM on 24 Sep).
3. **Still his to answer** (nothing changes on these until he does): Structural backup of Civil-only drawings, default
   off; which schedule floor the pergola beams (PB) go on, and whether 3FB1 means a floor or a unit; a single downpipe
   shows "DP" rather than "DP1"; a `_STR_` drawing with CE Civil content is fully Civil-active (log item 330);
   CDPIPEOBJ, a ribbon button or hidden; the CE menu start-up warning on 2022; the Glen Eira rainfall basis (94 against
   105 mm/h); the stray template backup file; BUG-163's 30-second check; everything marked "Needs Tim's engineering
   acceptance".
4. **Suggestions saved for him** (charter 10):
   1. A daily wake-up task in the Claude app, so a long run restarts itself after an app restart (a persistent setting:
      needs his yes).
   2. AutoCAD 2022 on his VM with Codex able to test there, so the 2022 lane can be proven without him next time.
   3. Starting the nightly Codex pass from Windows Task Scheduler instead of a Claude turn, to save Claude usage (also
      a persistent setting: needs his yes).
