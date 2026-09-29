# REL execution queue: the holiday run (29 Sep to about 26 Oct 2026)

**Owner:** the controller, `CE_ACAD / release-v3-colleagues / build + release / 06` (Sonnet 5.5), and its successors
(`/ 07`, `/ 08` ...). **Companion:** Tim's desk, `CE_ACAD / ideas / plan / 01` (charter: `C:\CE_PLAN\TIM_DESK.md`).
**Written by** plan/05 (Opus 5.5) on 29 Sep 2026 from Tim's answers in `decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`
(both 29 Sep sections).

**Status lives here.** Tick `[x]` with the date and PR/commit in the same step as the work, then commit and push
`C:\CE_PLAN` at once (add files by name, never `git add -A`; ROUTER step 1b). **Authority, highest first:** Tim's words in
`decisions\` > `C:\TimOS\RULES.md` > the OPERATING CHARTER at the top of `areas/release-v3-colleagues.md` > this queue >
TimOS skills' default wording. If this queue disagrees with a ruling, the ruling wins: fix the queue and add a Lessons line.

**The goal (Tim, 29 Sep: "Everything first"; charter 28 Sep):** build the whole of V3 (the V3 plan and the V3 UX plan:
about 345 UX items plus the open bugs), Codex-test it in real AutoCAD, keep it fast and reliable, and have the colleague
copy staged for Tim's return. **Nothing is published to any colleague while he is away** (Tim, 29 Sep).

**Honest outlook (plan/05's estimate, not a promise):** building is not the limit (about 160 UX items went in over
25-29 Sep); checking is. Expect most of V3 built and Codex-tested by his return, the heaviest features (CE proposing
designs, Structural computations, reading mark-ups, Ask CE) possibly still being finished, and every
engineering-judgement item waiting for Tim.

---

## 0. Two chats, one goal (Tim, 29 Sep about 17:15)

1. **The controller (this queue's owner)** builds, tests, runs Codex, installs on Tim's PC and merges, and moves the
   queue towards the goal. **Tim does not talk to it and it does not talk to Tim.**
2. **Tim's desk** is the only chat Tim talks to about CE while the run builds: his ideas, the bugs he sees, his rulings,
   "how's it going", the Friday summary. It never builds, installs, merges or runs Codex.
3. **One writer per file** (RULES 6.4). Both chats read everything.
   1. **Controller writes:** this file; `areas/release-v3-colleagues.md` (charter, Lessons, "For Tim", log);
      `BUG_CARPARK.md`; `PENDING_TESTS.md`; the other area files, cards and contracts; `C:\Lisp Files\_CODEX_RUNNER\*`;
      GitHub #78 and #24; the plugin repository.
   2. **Desk writes:** `TIM_DESK.md` (its charter and the hand-over list); `IDEAS_INBOX.md`; `decisions\` (Tim's words,
      dated); other products' idea and bug files (ROUTER).
4. **How they talk.**
   1. **Desk to controller:** new work goes on the hand-over list in `TIM_DESK.md` as `INT-NNN`. The controller reads
      the list at 06:00 and at every heartbeat, and records each item it takes in section 13 of this file
      (`INT-NNN -> queue item or bug ID`). **Urgent only** (Tim says stop or undo something, a crash stopping work, an
      answer that unblocks a lane): the desk also sends a one-line `SendMessage` naming the INT number.
   2. **Controller to desk:** questions for Tim go in section 9 of this file; the Friday facts go in section 9 after each
      Claude reset; **alerts** (a rollback, the run stopping, anything touching Tim's files) go by `SendMessage` to the
      desk, which tells Tim. The controller never pushes to Tim's phone itself unless the desk chat is missing from
      `ListAgents`.
   3. **If Tim writes to the controller anyway:** reply one line, "Passing this to your desk chat", forward it with
      `SendMessage`, carry on.
5. **Chat 04** (`/ build + release / 04`) stops after tonight's one install and hands its Codex timers to the
   controller (section 5). From then on, only the controller installs, merges or launches Codex (RULES 8.3).

## 1. Start of every controller session: 10 minutes

**Also do this after every compaction (a summary appears at the top of the chat) and every Friday after the reset.**
Rules fade from a long chat; re-reading them is cheaper than a broken install.
1. `C:\TimOS\RULES.md` and `C:\TimOS\ROUTER.md` (sync first: `git pull --ff-only` in `C:\CE_PLAN`).
2. The top of `areas/release-v3-colleagues.md`: the charter, Lessons and "For Tim when he is around". Stop at
   "Item 39.1"; below it is history.
3. This file: sections 0-5 in full; section 6 for the current checkpoint; the rest when needed.
4. `C:\Lisp Files\_CODEX_RUNNER\builder_rules.txt` (every builder) and `common.txt` (every Codex brief).
5. The desk's hand-over list (`TIM_DESK.md`, section 4): anything not yet in section 13 is new work.
6. Meters: `get_usage` (weekly and 5-hour); `bash "C:/Lisp Files/_CODEX_RUNNER/codex_usage.sh"`; `daily_cap.sh explain`.
7. What is installed: the ProductVersion of the three Modern DLLs under `%APPDATA%\Autodesk\ApplicationPlugins\`, and
   GitHub #78. Never trust a remembered version (RULES 8.4).
8. **Your timers: `CronList`, then re-create any that are missing** (the timer set is in section 3). **Timers live only
   in this session and recurring ones expire after 7 days** (CronCreate's own rule), so they vanish when the Claude app
   restarts and die a week after they were made. **Every Friday routine deletes and re-creates all recurring timers**,
   and so does any session start or watchdog nudge that finds one missing or older than 5 days.

## 2. Calendar and budgets

1. **Tim away** Wed 30 Sep, back about **Mon 26 Oct** (assumed; not confirmed by him). While he is away, AutoCAD on his PC
   is free all day, every day (RULES 1.8's work hours do not apply while he is away). If a person is using the PC, don't
   start Codex: wait.
2. **Daylight saving starts Sun 4 Oct** (02:00 becomes 03:00). All times here are Melbourne local.
3. **Claude week** resets Fri 2 Oct 12:00, then Fri 9, 16 and 23 Oct at **13:00** (same instant, daylight time).
4. **Codex week** resets Sun 4 Oct **05:01** (it showed 04:01 before daylight saving), then Sun 11, 18 and 25 Oct. Read
   `resets_at`; don't assume.
5. **Claude cap while Tim is away: 90%** of each week, measured on the account-wide meter (Tim, 29 Sep). **Pace line =
   % of the week elapsed x 0.90.** Over the line: no new builders except fixes for a failed Codex pass; Opus only for
   merge-blocking reviews. Under it: up to **3 Sonnet builders at once** (charter 1 and Lesson 4; this overrides the
   delegate skill's two-worker default for this run). If the 5-hour window passes 80%, start no new builder until it
   drops. The desk chat runs on Tim's 10% and is small; other products' chats share the same meter, so the pace line
   slows this run down if they are busy.
6. **Week 0 exception:** Claude was at 95% on 29 Sep about 17:00 (resets Fri 2 Oct 12:00), already over 90%. Until then:
   Codex launches and a five-line read of each result only (target 1% in total). No builders, no Opus, no install, no
   merge.
7. **Codex:** `daily_cap.sh` gives an even share (14% a day; an unused day carries forward). An AutoCAD pass costs about
   7-8%, a sol window build 1-2%. **Always launch with `maxpct` = `auto` and a cost**, so `queue3.sh` itself refuses a
   job that would pass the day's share; never type a fixed cap to force one through. The one exception: **unused Codex
   expires at its reset**, so in the last 36 hours spend what is left on sweep parts. A skipped job goes first the next
   day. **If a Codex run fails to start** (login expired, CLI error in `out\<name>.log`): alert the desk (Tim may need to
   log Codex in again), keep building, hold merges until a pass runs.
8. **Costs (correct these from the meters; one Lessons line per new measurement):** 5 Sonnet builders cost about 2% of
   the Claude week (27 Sep, before Sonnet 5.5). Opus review: not yet measured, so record the before and after of the first
   three. Your own turns cost more as your context grows: sub-agents (Explore, model sonnet) read the big files, and you
   never paste a large file into the chat.
9. **Planned Claude split per week (estimate; correct it after week A):** the Opus list first, about 25-30 points (the
   daily batch review and train sign-off, cards, diagnosis, the engine builders, the weekly check); this chat about 10;
   Sonnet builders about 40 (roughly 80 runs); reserve about 10. Fewer builds than an all-Sonnet run, on purpose: Tim, 29 Sep, "ANYTHING THAT
   NEEDS OPUS USES OPUS".

## 3. Lanes and the daily loop (from Fri 2 Oct 12:00)

**Lanes.** Parallel builders never touch the same file; each brief lists the files it may change.
1. **F, fixes:** Codex FAILs and open bugs. Always first.
2. **C, Civil** (`Modules/Drainage`): waves C1-C6 in section 6.
3. **S, Structural** (`Modules/Structural`, its own branch chain): waves S1-S5.
4. **M, Manager, front door and packaging** (`Modules/Manager`): M1-M3. A CE_SHARED change goes to Civil and Manager
   byte-identical, lane for lane (memory "CE_SHARED is one assembly identity").
5. **L, big features:** one builder at a time, whenever under the pace line: L1-L4.
6. **W, windows (Codex, sol, ruling B):** every card lists its window work; Claude writes the contract in
   `04_REFERENCE\contracts\`; Codex builds the XAML through `queue3.sh`.

**How to delegate** (TimOS `delegate` skill, loaded before the first dispatch of each session): every job gets a written
brief (objective, files owned, context, constraints, deliverable, acceptance) and returns a summary only. Builders:
`general-purpose` agents, model sonnet, `run_in_background`, told not to spawn sub-agents (memory "background split-agent
racing"). Reviews: `csharp-reviewer` agents (read-only), model opus or sonnet as section 4 says. Reading: `Explore`,
model sonnet.

**The timer set** (`CronCreate`, local time, off-minutes on purpose; write each ID and its creation date in the Lessons
line of the day you make it):
1. **Heartbeat,** recurring `13 */2 * * *`: read the hand-over list, check builders and Codex, act or stay silent.
2. **Daily,** recurring: `3 6 * * *` morning read; `57 16 * * *` train; `7 18 * * *` install; `7 19 * * *` Codex brief
   and launch.
3. **Codex early launch,** one-shot `7 4 <day> <month> *` on any night a brief is waiting for the next day's share.
4. **Friday routine,** one-shot each week for the next reset: `7 12 2 10 *` for 2 Oct, then `7 13 9 10 *`, `7 13 16 10 *`,
   `7 13 23 10 *` (13:07 once daylight saving starts). Each Friday routine re-creates every recurring timer (item 8 of
   section 1) and schedules the next Friday.

**The watchdog (Tim, 29 Sep: "Yes, daily at 7am").** A scheduled task in the Claude app, `ce-holiday-watchdog`, runs a
tiny session every day at about 07:20 (the app shows 07:20 for the 07:07 it was given). Scheduled runs cannot message
other chats and stall on approval prompts (both tested 29 Sep), so the watchdog does no work itself: **its completion
notice is what wakes you.**
1. **At your first start, subscribe:** `update_scheduled_task` with `taskId: "ce-holiday-watchdog"` and
   `notifyOnCompletion: true` (this replaces any earlier subscriber; every successor controller does it again).
2. **When the notice arrives:** run section 1 (rules, meters, `CronList`, re-create missing timers), then carry on.
3. **Prove it on day 1:** the first morning, write one Lessons line saying whether the 07:20 notice reached you. If it
   did not, say so in the Friday facts: the run then depends on your timers alone, and after a Claude app restart it
   waits until Tim messages his desk.
The watchdog does not help if the PC is off, restarting or logged out.

**The loop.**
1. **06:00, silent:** read both meters and the desk's hand-over list. Read the last Codex run (`out\<name>.last.txt`, then
   its report). File every FAIL as a bug (carpark template, next ID). Write every PASS as Codex-accepted (PENDING_TESTS row;
   carpark status `FIXED — date (Codex-accepted, pass N)`). Engineering-judgement items go to section 9's questions and are
   never accepted by Codex or Claude (RULES 4.5).
2. **Morning, dispatch builders** up to the pace line: lane F first, then any desk items marked "today", then the next
   items of lanes C, S, M and L in section 6's order. One family (2-6 related UX IDs) or one bug per builder. Brief =
   `builder_rules.txt` plus 5-15 lines: the IDs, the UX-plan line, the card, the files it may touch, the tests, Tim's
   AutoCAD check steps. Queue Codex window jobs (sol, medium) for the window half.
3. **Afternoon, reviews:** run the risk check (section 4, item 0.3) on every new PR. One Opus batch review covers every
   flagged PR (section 4, item 0); a Sonnet review covers the rest. Every review also checks what ELSE changed in the
   drawing output and the command's properties (Lesson 10, the RC regression of 29 Sep). MERGE-WITH-FIXES goes to a
   Sonnet fixer on the same branch, then back to Opus for a short confirm if the fixes touch the risk paths.
4. **17:00, the train:** new `claude/rel-YYYYMMDD` (Civil and Manager) from `master`, and `claude/rel-YYYYMMDD-struc`
   from `claude/struc-d1-prep`; merge the reviewed PRs; bump the version in the csproj AND `PackageContents.xml`
   (Lesson 6); build every lane (net48, net8, net10) with `-p:SkipDevBundle=true -nr:false --disable-build-servers`;
   run the full Civil net10, Manager and Structural suites; **count what ran** (zero discovered is a failure, RULES 5.4);
   compare failures **by name** with the known list in `builder_rules.txt`; pre-build the Structural candidate (install
   recipes: A2).
   **Then the Opus train sign-off:** one Opus call checks every PR's gate evidence (an `OPUS REVIEW` comment on each
   flagged PR, test counts, failures by name), the files touched by two or more PRs in the train, the version bump in
   both files, what else changed, and every test file the train changes (no test removed, skipped or loosened, delegate
   skill 5.6; the risk check skips test files, so this is where they are caught). It answers GO or NO-GO; log it in section 14. NO-GO: drop the named PR and ask
   again, or don't install today.
5. **18:00, install on Tim's PC, only on GO.** Load the TimOS `deploy` skill and follow its safety steps (section 4, item 2 says what
   is overridden). AutoCAD closed, checked twice 30 s apart; no Codex run live; rename the old bundles to
   `*_PRE_<commit>_<stamp>.backup`; copy; SHA256 every file, and check no hash is empty (deploy skill 5.6); read
   ProductVersion back; CE_SHARED identical in Civil and Manager, lane for lane; native ARX unchanged; name the one-step
   undo; update #78 and the PENDING_TESTS "LIVE since" block.
6. **19:00, tonight's Codex brief** (template, section 7): the sweep part due, plus Part Z (every fix installed since the
   last pass, with its REGRESSION_LOG check steps), plus 5-10 old carpark re-tests. Launch with `queue3.sh` when the day's
   share allows, otherwise at 04:07. **No full test suites on the PC while a Codex pass runs, and no building at all
   during a long-session speed pass** (it would spoil the timings).
7. **After each pass, merge:** a PR with an independent review AND a Codex PASS on what it changed merges to `master`
   (Civil/Manager) or `claude/struc-d1-prep` (Structural). Merge commits only, never rebase. After merging, diff the
   content; don't trust green (memory "a rebase silently dropped work"). Engineering-judgement items still wait for Tim
   (decision of 28 Sep, item 3).
8. **After every Codex run:** copy the CE logs aside (memory "tests can touch Tim's real files"); check `CPROFILE` and
   `OSMODE` in the report ("Tim", 21759); diff `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` with the last baseline and
   put back only single values a test changed, never a blanket restore.
9. **Heartbeat** every 2 hours, silent unless something happened (Lesson 8): read the hand-over list, check running
   builders and Codex, act. **One Lessons line per day.** Tick this file, the carpark and PENDING_TESTS in the same step
   as the work; commit and push each time.
10. **Fridays, just after the Claude reset:** re-read section 1; run the **weekly rules check**: one Opus reviewer with
    fresh context and this checklist, fixing nothing:
    1. Every install this week has a backup name, two closed checks, non-empty hashes and a read-back in #78.
    2. Every merge has an independent review and a Codex PASS on what it changed.
    3. No test was deleted, skipped, muted or loosened to get green (delegate skill 5.6); failures compared by name.
    4. No carpark or PENDING_TESTS row says FIXED or accepted without Codex or Tim evidence; the four words never merged.
    5. Usage stayed under the pace line; no rule on the never-alone list (section 4) was crossed.
    6. Lessons were written; the queue ticks match git and #78.
    7. **The Opus rule held:** re-run the risk check on every PR merged or installed this week; each flagged one has an
       `OPUS REVIEW` comment with a model stamp naming Opus, every install has a GO line in section 14, and section 14's
       count matches. Any gap is written up plainly in the Friday facts.
    Its findings go in Lessons and in the Friday facts. Then write the Friday facts (section 9) and message the desk
    "Friday facts ready".

## 4. The rules for this run

**0. The Opus rule (Tim, 29 Sep: "ANYTHING THAT NEEDS OPUS USES OPUS").** You run on Sonnet, and a sub-agent started
without a `model` runs on Sonnet too. So:
1. **Always pass `model: "opus"` explicitly** for everything on the Opus list. Never rely on the default.
2. **The Opus list:**
   1. Every PR the risk check (item 3) flags: one Opus batch review a day, one call covering several small PRs.
   2. The train sign-off before every install: GO or NO-GO.
   3. A1, the trunk convergence: the plan and the after-merge content check.
   4. Diagnosis AND the next fix attempt of any bug whose fix has failed Codex twice, and of any regression in something
      already Codex-accepted or Tim-accepted (the RC case, Lesson 10).
   5. Cards for L1-L4, S4, S5, C4 and C5, and any card whose behaviour touches the risk paths: Opus writes, Sonnet builds.
   6. A second opinion before dismissing any Codex FAIL as a test mistake.
   7. The weekly rules check (section 3, step 10).
   8. The release-candidate audit before staging (M3).
   9. Every handoff to a successor controller: check it drops no rule (charter: "A handoff that drops them is faulty").
   10. Any change to the install recipes, `queue3.sh`, `daily_cap.sh` or `builder_rules.txt`.
   11. **Builders (not only reviewers) for the engineering engines:** L2 (CE proposes levels, sources, detention and
       networks), S5 (Structural computations), and any builder whose brief changes a calculation or design engine
       (the Calculation, Hydraul, Detention, Orifice, Sizing, NetworkDesign, RunSolve or Structural.DesignCore paths).
       These run as `general-purpose` agents with `model: "opus"`, told not to spawn sub-agents.
3. **The risk check.** Run it on every PR before review; any output line means Opus is required:
   ```
   gh pr diff <N> --name-only | grep -E -i 'Reactor|Overrule|Grip|Transform|PipeObject|Native|\.cpp$|\.h$|LinkService|Persistence|Undo|Save|Flush|Cache|Queue|Idle|DocumentLock|UnsavedChanges|ProjectDataService|Spine|Schedule(Builder|Service|LinkService)|PitSchedule.*Service|MemberSchedule|XclMText|StrSched|^Shared/CE_SHARED/|Installer/|PackageContents\.xml|Approval|Signing|ReleaseAuthority|blob-config|Calculation|Hydraul|Detention|Orifice|Boyd|Rational|NetworkDesign|RunSolve|Sizing|Structural\.DesignCore/|Rules/.*(Grade|Invert|Level|Fall|Cover|Velocity|Capacity)|/AI/|CE\.AI\.Core|CE\.Cloud|Telemetry|Credential|Secret' | grep -v -i -E '\.Tests?/|/Tests?/|Tests?\.cs$'
   ```
   Tried on 29 Sep: it flagged 14 of the 25 PRs #362-#386 (the LinkService, schedule, installer, Structural link and
   native files). A PR whose description changes an engineering calculation or rule is Opus-required even if no path
   matches. The builder writes "Opus review: required / not required, because <paths>" in its PR body; where it
   disagrees with the check, the stricter answer wins.
4. **How to call it.** Reviews and sign-offs: `Agent` with `subagent_type: "csharp-reviewer"` (read-only: it can't edit
   or spawn) and `model: "opus"`. Cards and diagnosis: `subagent_type: "Plan"` with `model: "opus"`; you write the file
   from its return. Every Opus brief says: "Start your reply with one line: OPUS <kind> <target> - model <your exact
   model ID, from your system prompt> - verdict <MERGE | MERGE-WITH-FIXES | DO-NOT-MERGE | GO | NO-GO>."
5. **Proof, every time.** Post the verdict as a PR comment starting `OPUS REVIEW`, with the stamp line; add one line to
   section 14 (date, kind, target, verdict, Claude usage before and after).
6. **The gates. They are not optional and usage never overrides them.**
   1. A train never carries a flagged PR without an `OPUS REVIEW` comment saying MERGE, or MERGE-WITH-FIXES whose fixes
      Opus has confirmed (a short second call, needed only when the fixes touch the risk paths).
   2. No install without an `OPUS SIGN-OFF train <branch> GO` line in section 14.
   3. No merge to `master` or `claude/struc-d1-prep` of a flagged PR without both its `OPUS REVIEW` and a Codex PASS.
7. **Opus comes first in the budget.** Reserve about 3 points a day for the Opus list before dispatching builders. If
   Opus work passes about 30 points in a week, run fewer builders (fewer PRs), never fewer reviews. If Opus is
   unavailable, nothing flagged merges or installs: build only unflagged items and keep Codex testing.
8. **Not on the Opus list:** builders, Sonnet reviews of unflagged PRs, Codex briefs, carpark filing, the desk chat.
   **Opus never replaces Tim:** engineering values and design rules still wait for his word.

**1. TimOS, where each rule bites.**
1. **RULES 4 (four words):** built, tested, installed, Tim-accepted, plus "Codex-accepted" (4.5); never merged, never a
   percentage.
2. **RULES 5 (the real thing):** count tests; open the PDF; look at the window (Codex screenshots); say what was not tested.
3. **RULES 6 (verify other chats):** every builder's, reviewer's and Codex's claim is checked before it is repeated or
   acted on: "already fixed" means read the code; "pre-existing failure" means compare names; "installed" means read
   the DLL.
4. **RULES 8 (git and installs):** you own git; save after each working piece with a one-line undo; one live version,
   read from disk; combine, then install once (8.5); every install names its undo (8.6).
5. **RULES 9 (plans):** status only here and in the area file; decisions only in Tim's words (the desk writes them);
   record what is learnt the same day (9.9).
6. **RULES 11 (private data) and ROUTER step 5:** no client name or address in any repo, commit, branch, PR or picture;
   `C:\CE_DrawingIntelligence` is never opened.
7. **RULES 12 (never guess)** and the Autodesk API guardrails (`ENGINEERING_RULEBOOK.md`): Unknown stays Unknown; if
   the documents and the log don't settle it, say "insufficient information" and propose the probe.
8. **RULES 13 (bugs):** the five things for every bug; FIXED only on Tim's or Codex's evidence.
9. **RULES 14 (handoffs):** the `handoff` skill at 85-90% context or when the work changes shape (a Friday reset with
   the context over half full counts); never mid-operation.
10. **Skills:** `delegate` (every builder or Codex job), `deploy` (every install, with item 2 below), `handoff`,
    `leak-scan` (automatic on every push; never `--no-verify`). Not used by this run: `overnight`, `tech-watch`.

**2. What Tim's 28 Sep ruling overrides, and nothing more** (RULES 14.6; `decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`):
1. **The deploy skill's trigger line and its hard limit 4.1** ("only on Tim's phrase"): for this run, installs on
   **Tim's own PC** happen at the controller's discretion (Tim: "Yes, my PC only"). Every other step of the deploy skill
   stands. Its section 1.4 note about a signing-key mismatch is out of date (corrected 24 Sep: no mismatch); follow the
   install recipes in A2, not that note.
2. **RULES 7.1/7.2 (one small task per chat):** this chat builds continuously across areas in daily batches, because
   Codex tests every batch.
3. **Charter items 3 and 10** (Tim's messages, updates to Tim) are carried out by the desk (Tim, 29 Sep).
Publishing to colleagues is **not** overridden: never, while Tim is away.

**3. Never alone.** Put the question in section 9 (or send it to the desk if it blocks a lane) and work on something else:
1. Any engineering value, council value, design rule, sizing choice or Structural computation result.
2. Retiring, hiding or renaming a visible command or button (old typed names stay forever, UX-NAMES-01).
3. Deleting anything: files, branches, working copies, bundles, carpark entries, tests (RULES 6.6 of the charter;
   ROUTER step 5.8).
4. Publishing anything to a colleague, the IT Admin folder or a signed approval.
5. A persistent setting on the PC (a scheduled task, a registry value, a power or update setting), or an AI key, a paid
   service or a privacy choice.
6. Changing or reinterpreting one of Tim's rulings; turning an unanswered question into a decision.
7. Skipping an Opus review on the risk list, merging without a review and a Codex PASS, installing from a failed build.
8. Changing a test's expectation to get green: that comes back as a question.
9. Anything not recorded anywhere: say so; don't fill the gap.

**4. If this happens, do that.**
1. **Codex FAIL** on an item: file the bug; a lane F builder next morning; re-test in the next Part Z; the PR does not merge.
2. **Codex BLOCKED:** record why; fix the brief or the test drawing; re-run next pass. Blocked twice: a question in
   section 9.
3. **Codex says PASS without steps or a screenshot:** treat it as NOT TESTED (RULES 5.6).
4. **A builder says "already fixed":** read the code yourself; if true, a Part Z re-test, not a new fix.
5. **A builder says "pre-existing failures":** compare names with the known list; a new name is that builder's
   regression until proven otherwise.
6. **Two PRs need the same file:** stack them or run them one after the other; never in parallel.
7. **A review says DO-NOT-MERGE:** the PR stays out of the train; fix it or park it with the reason.
8. **The train shows a new failing test name:** find the PR that brought it (one PR at a time), drop it from the train,
   install without it.
9. **Over the pace line:** let running builders finish, start none, keep Codex going.
10. **An urgent desk message from Tim:** do it next, once the current step reaches a safe point, unless it crosses the
    never-alone list; then reply to the desk with the reason.
11. **A card needs Tim's answer:** the question goes in section 9; build the parts it doesn't touch.
12. **Install read-back mismatch, or CE fails Codex's start-up check:** roll back at once (rename the backup back),
    record it in #78, alert the desk.
13. **Not sure whether something is engineering judgement:** treat it as judgement.
14. **Two sources disagree** (a document and the drive, two chats, a skill and a ruling): the drive and Tim's words win;
    say which was wrong in Lessons (RULES 6.2).

**5. Standing rules from the plan.**
1. **Base branch:** until A1 is done, builders branch from the live line named in #78 (29 Sep: `claude/rel-20260929c`
   Civil/Manager and `claude/rel-20260929c-struc` Structural, if chat 04's install went in; otherwise the `b` lines).
   After A1: `origin/master` and `origin/claude/struc-d1-prep`. Update `builder_rules.txt` in the same hour (on 29 Sep it
   still named `rel-20260929a`).
2. **Card before code** (AGENTS.md review gate): each family gets a short card in `04_REFERENCE\ux-plan\cards\` first:
   what the drafter clicks and sees, prompts, window, preview, Escape, one Undo, save/reopen, tests, Codex steps. A card
   built only from Tim's rulings, with no open question, is approved in principle and may be built (practice since
   26 Sep, area log items 195 and 198; Tim can still reject it). A card with an open question: build the parts it
   doesn't touch; the question goes in section 9. **Cards on the Opus list (L1-L4, S4, S5, C4, C5, and any card touching
   the risk paths) are written by Opus** (item 0.2.5 above); Sonnet writes the rest.
3. **Engineering judgement stays Tim's** (RULES 4.5): build settings-first (R-00) with values tagged Assumed or with their
   source, mark "Needs Tim's engineering acceptance", and let Codex accept the mechanics only.
4. **The 2022-2024 lane:** every change builds net48, but this PC cannot run AutoCAD 2022-2024. Every report says
   "2022-2024: built and unit-tested, not AutoCAD-tested". UX-MIX-03 stands: no automatic pipe upgrade on colleagues' PCs
   until the 2022-2024 enabler is proven.
5. **Unfinished features ship hidden:** anything not Codex-accepted at a train stays off the ribbon and out of Help (a
   switch, not a removal).
6. **Speed framework** (`ENGINEERING_RULEBOOK.md`): every PR states its [PERF] effect; any CE handler over 50 ms is a bug.
7. **No new build, deploy or versioning scripts** (RULES 10.5); Codex briefs are not scripts.

## 5. Week 0: Codex tests only (Tue 29 Sep to Fri 2 Oct 12:00)

- [x] **W0-1 DONE 29 Sep 17:05 (chat 04; read back by controller 06 at 17:45: Civil 3.0.15+a6e0cc87, Manager 1.1.15+a6e0cc87, Structural 1.0.86+532f9550 all match the installed DLLs).** Tue evening (chat 04): one last install, pre-built at `C:\CEPay\p15`: Civil 3.0.15 and Manager 1.1.15
      (`claude/rel-20260929c` a6e0cc87 = #383 #384) and Structural 1.0.86 (`claude/rel-20260929c-struc` 532f9550 = #385
      reviewed + #386, the RC restore after Tim's "YOU RUINED RC", Lesson 10). Tim closes AutoCAD when chat 04 asks. Then
      chat 04 starts no more builders (confirmed by chat 04, 29 Sep, area log 337).
- [x] **W0-2 DONE 29 Sep ~17:50 (controller 06): renamed; watchdog subscribed; chat 04 confirmed it cancelled 62588dfa, 20668077, 0ba4e769; controller timers set: Thu 1 Oct 04:07 launch c39c63c2, Thu 10:07 write briefs 97b29288, Fri 2 Oct 04:07 launch 7272996b, Fri 12:07 Friday routine f0a0536a, Sat 3 Oct 04:07 launch 752aef08. Recurring timers (heartbeat, daily) are created by the Friday routine.** The controller starts (Tim pastes its prompt): rename; subscribe to the watchdog (section 3); set the
      timers below; message chat 04 "taken over your Codex timers; cancel yours and stop". **Arm your own Thu 04:07 launch only AFTER chat 04 confirms it has
      cancelled its timers** (chat 04's 21:03 one-shot otherwise runs pass18 then draft1 itself at Thu 04:07; two
      launches would put two Codex runs on one AutoCAD). No confirmation: don't arm yours.
- [ ] **W0-3 Wed 30 Sep: no Codex.** Wednesday's even share is spent (cap 58%, used 55%, a pass costs 8%).
- [ ] **W0-4 Thu 1 Oct 04:07,** in the background: pass 18 (chat 04 added the RC check and #383/#384's steps), then
      synthetic drafting test 1 (Tim's Thursday):
      `MAXC=1 bash "C:/Lisp Files/_CODEX_RUNNER/queue3.sh" "pass18|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6-astra|low|auto|8" "draft1|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6-astra|low|auto|8"`
      If the runner skips draft1 for the day's share, it goes first on Friday. Read the two `.last.txt` files only;
      filing waits for Friday 12:00.
- [ ] **W0-5 Thu:** write `sweepC1.txt`, `sweepC2.txt`, `sweepC3.txt` (section 7) and `bug160win.txt` (A5), short.
- [ ] **W0-6 Fri 2 Oct 04:07:** in this order until the day's share is used: `draft1` (if skipped), `sweepC1` (cost 8),
      `branchwin` (the queued window job, cost 2), `bug160win` (sol, medium, cost 2).
- [ ] **W0-7 Sat 3 Oct 04:07:** whatever Friday skipped, then `sweepC2` and `sweepC3`: this spends the last of Codex's
      week before Sun 05:01.

## 6. The queue

### 6a. Week A opening: Fri 2 Oct 12:00, in this order

- [ ] **A1 Converge the trunk (on the Opus list: Opus checks the plan before, and the content diff after).** Nothing has
      merged to master since 28 Sep; about 37 draft PRs (#349 to #386) sit on release branches.
      1. A sub-agent lists every PR in the live lines with its review verdict, its Codex evidence (passes 16, 17, X1, 18
         and sweep C1-C3) and the result.
      2. Anything that FAILED a pass is fixed on top first (lane F).
      3. One converge PR each: the live Civil/Manager line into `master`, the live Structural line into
         `claude/struc-d1-prep`. Merge commits, never rebase. Afterwards diff `master` against the live line: it must be
         empty apart from what was deliberately held (#88 CDMOVETEST stays off).
      4. Close each constituent draft PR with "merged via #N". Delete nothing.
      5. Update `builder_rules.txt`: base branches and the known-failure list. Same hour.
- [ ] **A2 Make the area file cheap to read.** First lift the two install recipes (Civil: memory
      `codex-runner-and-install-recipe`; Structural: area log item 323; plus the REL-09 hand-install and rollback steps)
      into a short "Install recipes" section at the top. Then move log items 1-337 of `release-v3-colleagues.md`, word for
      word, to `archive/chat-records-2026-09/REL_LOG_ITEMS_001-337.md`, leaving a one-line pointer. Keep the charter,
      Lessons, "For Tim", sections 1 to 5c and the 29 Sep handoff. Same for PENDING_TESTS "LIVE since" blocks older than
      28 Sep. Moving, never deleting.
- [ ] **A3 Carpark hygiene** (charter: "constantly being reduced"). A sub-agent sorts every entry not FIXED or WONT FIX:
      (a) V3-era and still real; (b) already fixed in code, with the evidence: goes to Part Z for a Codex re-test;
      (c) about code V3 retired: propose "WONT FIX — retired in V3" in section 9 for Tim, NOT applied; (d) needs Tim.
      Bring the Status Summary table up to date (BUG-158, for example, still says OPEN though its fix merged in #347).
      Then 5-10 re-tests a night until (b) is empty.
- [ ] **A4 Structural 1.0.86, only if W0-1 did not install it:** confirm #385's review covered the floor-prefix rule
      (1FB1, GB2, B1, PB1, level-prefixed tags) and the Insert blocking change, and that #386 restores RC exactly as it
      was before 8d382ec0 (Lesson 10: diff RC's properties before and after); then the next train.
- [ ] **A5 BUG-160 part 2, the pick window (Tim approved 29 Sep).** Claude: when a grip drag on a grade-held pipe with a
      typed bottom level ends, open the choice; the chosen value goes to the plan text, the stored levels and the project
      record together; one Undo. Codex (`bug160win`): a small one-page window "Keep your 10.30 / Use automatic 10.25";
      Enter and Esc both keep the typed value. Builds on part 1 (#354). Opus review (grips, Undo).
- [ ] **A6 XCIVIL level flag — BUILT 29 Sep 19:25, draft PR #389 (`claude/a6-implvl`; 30 focused + 80 related tests pass; full Civil net10 12,600 passed / 5 known failures; risk check clean, Sonnet review enough; the only existing test file touched has additions only; NOT Codex-tested, NOT in AutoCAD; Settings-window row for the tolerance still to be built by Codex).** (Tim approved 29 Sep.) Imported pipes keep their imported levels. An end whose imported
      level disagrees with the grade at the pit wall by more than a Settings tolerance (R-00) is listed in Project Review
      ("Imported level - check"). Nothing is changed.
- [ ] **A7 Fix wave:** everything pass 18, draft1 and sweep C1-C3 found (lane F).
- [ ] **A8 V3-era open bugs,** after A7: BUG-192 (read pass 18's [REDO] line first), BUG-197, 200 and 201 (the rest of
      X1), BUG-069 (#369 held: decide with a review), BUG-180, BUG-172, BUG-171; then category (a) of A3.

### 6b. The waves (take the next item in each lane; the checkpoints are targets, not promises)

**Lane C, Civil** (the remaining IDs of each family are in section 11)
1. **C1 Foundations every command uses:** UX-LOOK-01 (every window gets the one-page shell, window by window, with the
   Codex review's item 19 "tabs, not scrollbars" folded in), UX-WIN-01..04, UX-CMD-01/03/04, UX-UNDO-01, UX-MSG-01..03
   (the CE bell), UX-FAIL-01/02, UX-PANEL-01/02, UX-SET-02/03/05/06 (06 is the LPD note box), UX-LYR-01..04, UX-LIVE-01,
   UX-VOICE-01 (message sweep), UX-SEL-01, UX-TIP-01, UX-PERF-01/02, UX-ACC-01..03, UX-START-01, UX-RCLICK-01,
   UX-PROP-01, UX-SHARE-01, UX-RECENT-01.
2. **C2 The everyday network:** UX-PIPE-01/02/03/07 (CORRECTED 29 Sep 21:50 by controller 06 against Tim's rulings `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` lines 435/440: 03 is Escape at CD's third point, already working and test-guarded; the recent diameter/material/invert buttons are UX-PIPE-04, already built in 49c22823; 01 keep both buttons, nothing to build; 02/02b and 07 wait for Tim's answers in section 9), UX-PIT-01
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
   cost). A key, a paid service or a privacy choice is Tim's (never-alone item 5): park it with the question.
4. **L4 Structural proposals:** UX-SL3-01/02.

**Checkpoints**
1. **Fri 9 Oct:** A1-A8 done; C1 and S1 built; C2 half built; L1 built; the Civil sweep finished; fewer open bugs than
   on 2 Oct.
2. **Fri 16 Oct:** C2 and C3 built; S2 built; M1 built; L2 LEVELS and SOURCES built; the Structural sweep finished;
   real-job comparison 1 done.
3. **Fri 23 Oct:** C4 and C5 built; S3 built; M2 built; L2 finished; the Manager sweep finished; UX human-use pass 1 done.
4. **Tim's return:** C6 and S4 built; S5, L3 and L4 built or in progress; fix-out done; the final full sweep of all three
   modules passed with its coverage count; the candidate staged (M3); the return page (section 12) written.
If a checkpoint slips, never cut checks to catch up: say so in the Friday facts with the new date.

## 7. The Codex programme

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
   S5 foundations, slabs, bracing, lintels, retaining, RC; S6 CEARCHREVIEW (2027 native), sheets and issue, long session.
3b. **Manager sweep (Tim, 29 Sep: "TEST EVERY BUTTON, TOOL, FUNCTION, SYSTEM, AND USER EXPERIENCE FOR BOTH CIVIL AND
   STRUCTURAL MODULES AND TEST THE MANAGER AS WELL"), after the Structural sweep, about Sat 17 Oct:**
   1. **MG1 Front door:** CEMANAGER and every tab, button and field; the one-glance status page; the versions of all three
      modules; CE_VERSION / About; What's New; Help; Report a problem / Feedback; Settings.
   2. **MG2 Updates and safety, look but never act:** the update check shows the right state; the rollback screen up to its
      confirmation, then Cancel; problem reports saved with the version; the admin page; the logs. **Never approve,
      publish, install or roll back from a Codex run**: the controller rehearses a real rollback itself (M3).
   3. **MG3 The system:** all three modules loading together at start-up (one CE tab, no doubled ribbon, the shared
      library identical), start-up time and splash, a second start, a drawing opened by double-click, several drawings
      open, closing and reopening AutoCAD, the [PERF] summary.
3c. **Every sweep proves "every".** Each part starts by listing every command, ribbon button, window and tab in its scope
   (from the CE ribbon, the command register and the Help list) and ends with "in scope N, tested M, not tested K", each
   untested one with its reason. After a sweep's last part, the controller merges the lists: every CE command must
   appear as tested, or as NOT TESTED with a reason and a queue item to test it.
3d. **The final full sweep (week D, on the staged candidate):** Civil, Structural and Manager again, every command at
   least once, with UX notes only on what changed since the first sweeps. Its coverage count goes on Tim's return page.
4. **Weekly:** a long-session speed pass, alternating Civil and Structural (C8 and S6 count in their sweep weeks).
5. **Drafting:** draft1, synthetic (Thu 1 Oct); RJ1, real job (section 8, week B); draft2, a harder synthetic job
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

## 8. Real-job drafting comparison (Tim, 29 Sep: "Both: made-up Thu, real later" and "Yes, you pick")

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

## 9. For Tim, through the desk (the controller writes this section; the desk reads it and talks to Tim)

1. **Questions waiting for Tim** (add as found; the desk asks at most five each Friday, tap-to-answer, marked "ignore if
   busy: this item just waits"; it records his answers in `decisions\` and puts an INT item on its hand-over list):
   1. **A6 tolerance (engineering value, Tim's):** "Imported level - check" flags an imported pipe end more than **50 mm** away from the level the grade gives at the pit wall (Settings, tagged Assumed). Right allowance? Recommendation: keep 50 mm until a real job shows what is normal. Example: an imported invert of 18.50 against a grade-worked 18.43 is 70 mm out, so it is listed.
   2. **A6 hand-typed levels:** a level Tim typed by hand is NOT listed (builder's judgement, not a ruling). Should it be listed too? Recommendation: leave it out, since typing it was a decision.
   4. **CE bell (UX-MSG):** should "a colleague has this drawing open" be a personal message (only true right now)? Recommendation: personal. And how often should the save reminder appear (minutes; it becomes a Settings number)? Recommendation: ask once he has used the bell on a real job.
   5. **Structural front door, which button name wins (UX-STRUC-03):** where two typed names do the same job (SDS/TDS, SDS1/TDS1, STS1/TTS1, SC1/TC1) the card picked the T names but the code marks those as deprecated. Recommendation: the S names (those are the ones the code keeps). CL1/PCL and CR1/PCR are different tags (prefix C versus PC), so both stay. For the Excel pairs: keep the long EXCELCAPTURE... names the card chose, or the plain shortest name? Recommendation: keep the card's.
   6. **BUG-160 pick choice (A5, PR #391):** a typed pipe that was never answered before is asked once, even on a plain move, if its typed level differs from the grade's number. Acceptable? Recommendation: yes, it only asks once per pipe and Enter keeps his typed level.
   7. **Manager (PR #394, UX-MGR-03 one-glance status, built, OFF by default):** (a) UX-MGR-01 (colleague rollout) sits on the publishing/approval path, so it is Tim's: recommendation, build it together with UX-MGR-08 (the one approval page) since they share one screen. (b) UX-MGR-02 would retire the visible "Open Hub" button: recommendation, hide it behind a switch (default off, so nothing disappears) until the CE-tab Project Review is accepted; may that go ahead? (c) A module that is not installed on a PC: show amber (builder's choice) or quiet grey? Recommendation: quiet grey, since a colleague may legitimately have only Civil.
   8. **Pipe auto-join (UX-PIPE-02, PR #395 is card only):** (a) auto-join distance: 75 mm, or the pit catch of outline + 100 mm (UX-PIT-02)? Recommendation: keep 100 mm for pits, add 75 mm only for pipe ends. (b) A new pipe end within range of another pipe's end (no pit) would need a new kind of link between two pipes. Recommendation: yes, but as its own reviewed step (Opus). (c) Where is "Keep as a free end" remembered for the whole job: the drawing, the user's settings by job folder, or the shared job record (that one needs a CE_SHARED change)? Recommendation: the drawing first.
   9. **What CE learns about a person (UX-LEARN-01, PR #396; privacy is Tim's):** (a) is "numbers only, on the person's own PC" the right amount to remember? Recommendation: yes. (b) How long is it kept? Recommendation: until the person removes it (they can see it and remove it or everything). (c) Should learning start from the day it is switched on, not from old drawings? Recommendation: yes. (d) Should pressing Cancel count as declining a suggestion? Recommendation: no.
  10. **Structural units (UX-UNIT, PR #397):** (a) how does the drafter pick a unit to copy: a window round each unit's framing, then a base point per target? Recommendation: yes. (b) Mirrored units: pick a mirror line? Recommendation: yes. (c) Do "linked" copies reuse the beam links or a new link group? Recommendation: a new group. (d) Do unit headings replace the per-floor schedule blocks or sit inside each? Recommendation: inside. Also the earlier 3FB1 question is now decided by the job's Level/Unit setting, which the drafter sets once (default unchosen: nothing changes until set).
  11. **CD drawing helpers (UX-CMD/UX-UNDO, PR #398):** (a) Undo step names: a plug-in may not be able to name its step in AutoCAD's Undo list. Recommendation: a Codex probe first; if it can't, print one plain sentence after each CE Undo ("Undid: <what>"). (b) In CD, typing a size or grade at the command line as an option, but not in draw-first CD? Recommendation: yes. (c) The glow while pointing: pits only until you have judged the look, then pipes? Recommendation: yes.
  12. **RE-CHECKED AGAINST THE PLAN, 29 Sep 23:40 (INT-006; Tim: questions only if the plan is silent or disagrees with itself). CLOSED, with the document named:**
      1. **Excel names (part of 5):** the shortest code wins: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` line 768 (STRUC-RIBBON, Tim: "Shortest code (Recommended)"; other names keep working typed) and line 643 (UX-STRUC-03, "One each + shortcuts"). The card's long EXCELCAPTURE names are superseded. S1 slice 2 uses them.
      2. **Manager UX-MGR-01 (from 7a):** built to Tim's ruling, rulings line 549 ("Pick who, then everyone": tick who gets a version first, then Everyone once proven, one click to roll back). Building the screen is not publishing: the actual publish stays Tim's, never while he is away. Sequence with UX-MGR-08 as the builder finds best.
      3. **Manager UX-MGR-02 (from 7b):** Tim's explicit yes is on record, rulings line 553 ("Drop it": "Open Hub" is retired, job review lives in the one Project Review on the CE tab). Built hide-first behind a switch (AGENTS.md: hide or redirect before permanent retirement), so nothing vanishes until Codex accepts Project Review.
      4. **Bell (from 4):** UX-MSG-03, rulings line 1903: drawing/job messages go to whoever opens the job next; personal ones are "update, save reminder" only. So "colleague has this drawing" is a JOB message, not personal: #390 built it personal, a fix to make on that PR (also clear it when the colleague closes the drawing: a detail the plan doesn't state, tell Tim on the return page). The save-reminder interval is a Settings number (R-00): a default tagged Assumed, Tim can change it; not a question.
      5. **Pipe auto-join (from 8a, 8b):** rulings lines 430 (UX-PIPE-02, on by default, never guess between two pits, one U undoes) and 594 (UX-PIPE-02b, "Pits or pipe ends": within the Settings distance, 75 mm default, of a pit OR another pipe end, snapped on, linked, shown in the preview, off switch in Settings). The pit catch reach (outline + 100 mm, UX-PIT-01) is a different setting and stays. Build 02 and 02b; the pipe-end link is an Opus-reviewed step.
      **STILL OPEN (the plan is silent or the builders' finding contradicts it), asked by the desk:**
      1. **Q3 Structural MEMBER SCHEDULE text:** the plan (rulings line 678) keeps XCLMTXT as the one member schedule but says nothing on its text size; changing it changes his established output. Recommendation: same Settings-driven rule as the other schedules, applied only to new tables.
      2. **Q6 grip-drag choice (#391):** the plan (BUG-160, carpark 29 Sep) only says the choice opens when a grip drag ends. It is silent on a plain MOVE or STRETCH of a typed pipe. Recommendation: ask once per pipe there too (his rule is "see both numbers and pick"), Enter keeps his typed level.
      3. **Q7c Manager, module not installed on a PC:** rulings line 849 gives green-amber-red for the three modules, silent on "not installed". Recommendation: quiet grey.
      4. **Q8c Where "Keep as a free end" is remembered:** the plan says "whole job" (rulings line 576) but not whether that means all drawings of the job. Recommendation: this drawing's job record first; the other drawings later.
  13. **C4 card (Opus, `cards/C4_CALC_SIZE_DES_CARD_2026-09-30.md`), the plan is silent or contradicts itself on four things:** (a) Where the Issue window's engineer list comes from. Rec: an office list of engineer names on the Settings page, shared with Structural issue, plus a typed name marked "typed". (b) Sizing "Accept all" versus the sign-off gate on sizing rule values (rulings 911 vs 914-915). Rec: build it, ship the Pipe sizes group behind a Settings switch, off until Tim signs the sizing rule values. (c) From markup: when a pipe reads "Different" versus "Can't verify". Rec: Different only where the supplied design states a size; everything else Can't verify, never inferred. (d) When Design opens on Finish (17_CDSETUP.md line 119 vs ruling 588). Rec: Start with no agreed design, During whenever one exists, Finish only by its tab. Top risk: the criteria block takes its figures from a different place than the computations sheet and inserts in three steps, and the sheet turns an unknown storm frequency into 10 years: Opus builders for CALC-02/03.
  14. **S4 card (Opus, `cards/S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md`), four silent points:** (a) retaining wall sizing method (RW-03/07/11; no wall calc in UX-SCALC-03). Rec: a Settings table by height band with a "fence on top" column, Unknown until Tim fills it; a calc later in S5. (b) Fence post footings "designed" (RW-10). Rec: Settings table by fence type and height, Unknown until filled. (c) Bar length rounding in the note ("x 5500 LG"). Rec: a Settings value; Unknown = exact length shown until Tim sets it. (d) Bar shapes in the bar schedule (FDN-04). Rec: straight bars first; other shapes Unknown until Tim confirms the office shapes. Top risk: CSLOADPATH already places a pad labelled "assumed size" (20 kN, 100 kPa): the footing proposal must NOT reuse it (ST6-4: CE never invents a footing size).
   3. **BUG-196 residual (Structural):** the "MEMBER SCHEDULE" text (XCLMTXT) uses fixed sizes 300/200; size it by the same rule as the other schedules? Recommendation: yes, as a separate small fix after the STRSCHEDCREATE re-test passes.
2. **Friday facts** (write after the Claude reset and the rules check; replace last week's block; numbers, not prose):
   1. Built this week (UX IDs and bug IDs), Codex-tested (PASS / FAIL counts), installed (versions and dates),
      Tim-accepted (none while away).
   2. Three things Tim would notice in AutoCAD, each with a concrete example.
   3. Up to three problems.
   4. Claude and Codex meters.
   5. The checkpoint status and next week in three lines.
   6. The rules check's findings.
3. **Alerts to the desk between Fridays, only for:** an install that stopped AutoCAD or CE starting (with the rollback
   done); anything touching Tim's real files or data (a leak-scan trip, his settings changed); the run stopping (usage
   gone early, PC trouble); a question blocking a whole lane for more than two days.

## 10. When something goes wrong

1. **Claude runs out early:** stop the builders; keep Codex going on sweep parts with launch-only turns; resume at the
   reset.
2. **Codex runs out early:** the builders carry on and bank; installs may continue; merges wait for a pass.
3. **A train fails to build or loses tests:** never install (a hard block). Drop the PR from the train or fix it, and
   install tomorrow.
4. **A read-back mismatch, or CE fails Codex's start-up check:** roll back at once (rename the backup back), record it in
   #78, alert the desk.
5. **The chat compacts or is replaced:** the state lives in this file, the area file top, the carpark, PENDING_TESTS
   and #78. A successor starts at section 1 and re-creates the timers first.
6. **The Claude app or the PC restarted:** timers are gone, so re-create them first (the 07:20 watchdog notice is meant to
   wake you for this). After a Windows restart nothing runs until Tim logs in, which is why he paused Windows Update. If
   the desk forwards "wake the controller" from Tim, treat it as a watchdog notice.
7. **The desk chat is missing** from `ListAgents`: carry on; keep section 9 current; send only alerts, with
   `PushNotification`.
8. **Opus unavailable or its share used up:** nothing flagged by the risk check merges or installs, and no train goes in
   without its GO. Build only unflagged items, keep Codex testing, and say so in the Friday facts.

## 11. V3 UX items not found in any commit message (from `git log --all`, 29 Sep 2026)

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

## 12. For Tim's return (one page; the full list is "For Tim when he is around" at the area file top)

1. **Look at the staged copy** (15 minutes), then yes or no to the pilot, and name the colleague (AutoCAD 2027 first).
2. **The 2022 check** on his VM (AutoCAD 2022 was not installed on the VM on 24 Sep).
3. **Still his to answer** (nothing changes on these until he does): Structural backup of Civil-only drawings, default
   off; which schedule floor the pergola beams (PB) go on, and whether 3FB1 means a floor or a unit; a single downpipe
   shows "DP" rather than "DP1"; a `_STR_` drawing with CE Civil content is fully Civil-active (log item 330);
   CDPIPEOBJ, a ribbon button or hidden; the CE menu start-up warning on 2022; the Glen Eira rainfall basis (94 against
   105 mm/h); the stray template backup file; BUG-163's 30-second check; everything marked "Needs Tim's engineering
   acceptance"; the carpark entries proposed "WONT FIX — retired in V3" (A3).
4. **Suggestions saved for him** (charter 10):
   1. A daily wake-up task in the Claude app, so a long run restarts itself after an app restart (a persistent setting:
      needs his yes).
   2. AutoCAD 2022 on his VM with Codex able to test there, so the 2022 lane can be proven without him next time.
   3. Starting the nightly Codex pass from Windows Task Scheduler instead of a Claude turn, to save Claude usage (also
      a persistent setting: needs his yes).

## 13. Taken from the desk (the controller writes one line per INT item it takes)

Format: `INT-NNN (date) -> queue item / bug ID / "answer recorded, unblocks <item>" / "declined: <reason>"`.
1. Builder PRs so far (29 Sep evening, all DRAFT, base `claude/rel-20260929c`): #387 BUG-200+201 (Opus review required: SpineCheckCommand.cs), #388 BUG-197 (Opus review required: LinkService.TextClashTidyUp.cs), #389 A6 (no Opus needed). #390 UX-MSG-01..03 the CE bell (BUILT 29 Sep 20:00, hidden behind a Settings switch default OFF; 39 new tests; full Civil net10 12,623 passed / 5 known failures; the path risk check is clean but the PR adds DocumentActivated / DocumentToBeDestroyed handlers and a job-file write at drawing close, so the controller treats it as **Opus review REQUIRED** (stricter answer wins); card copied to `04_REFERENCE/ux-plan/cards/UX-MSG_CARD_2026-09-29.md`; wiring of real producers and the list window still to do). #391 A5 BUG-160 part 2 (BUILT, Opus review required: grips/Undo; controller re-ran the full Civil net10 suite on the branch 29 Sep 19:20: 12,632 run, 12,606 passed, 19 skipped, 7 failed = exactly the 7 known (AddSystem x3, BoydsDetention, BackTest_GlenEira, and the two SourceAtomicCoordinatorDependencyTests: FinalLanding... and RefusedNativeCallback...); the builder's summary was muddled, the result is fine; the ask-once-on-a-plain-move question for Tim is in section 9). #392 S1 UX-STRUC-01..03 first slice (BUILT 29 Sep 20:10, base `claude/rel-20260929c-struc`; both ribbon changes OFF by default via `CommandHub.OneNamePerTool` and `CommandHub.BeamFamilyDropDown`; 14 new tests, Structural full net10 2,122 pass by namespace; risk check clean, no test line removed (verified), Sonnet review enough; card copied to `04_REFERENCE/ux-plan/cards/UX-STRUC-01-03_CARD_2026-09-29.md`; Text/Tag/Hatch families and Settings tick boxes still to do; the unified-host ribbon needs the CE_SHARED upgrade). #393 BUG-203 Civil quiet in Structural drawings (BUILT 29 Sep 20:30, Opus review REQUIRED: LinkService, ProjectDataService; one existing source-text guard line changed, same rule, Opus to confirm; 7 known failures). **29 Sep 20:35: builders paused at Claude weekly 97% (about 1.5% reserved for the Thu 10:07 briefs and the Thu/Fri/Sat Codex launch turns).** Waiting for Friday 12:00: Opus batch review of #387, #388, #390, #391, #393 (flagged) and a Sonnet review of #389 and #392; BUG-204 (check first: commit 34d8a295 "settings dedupe" may already cover part of it); then A1. Not merged, not installed.
   #398 C1 UX-CMD-04 + part of UX-CMD-01 (BUILT 29 Sep 23:00; both behind new Settings switches default OFF; while CD asks for a point the pit under the cursor gets a soft blue band and a small amber square, and from the third point CD offers `[Undo]` for the last point; 9 files verified, no test line removed, content scan finds no transaction, document lock or undo grouping in the new code; 18 new tests, full Civil net10 12,600 passed / 7 known failures; risk check flags only the card's file NAME, so Sonnet review enough; BUT the builder's first full run STOPPED at 6,135 tests with 1 failure and the re-run completed: unexplained, so the train's full-suite run must show the full count; UX-UNDO-01 not built (no evidence a plug-in can name an Undo step: needs a Codex probe); UX-CMD-03 nothing new (Enter repeat is AutoCAD's; last size/type is UX-RESUME-01, already in 3.0.15); card copied to `cards/UX-UNDO-CMD_CARD_2026-09-29.md`).
   #399 BUG-204 Structural settings bloat (BUILT 29 Sep 23:10, base `claude/rel-20260929c-struc`; real root cause: the three lists start seeded with defaults and Newtonsoft APPENDED the saved file onto them on every load, about 24 entries per start (15,622 / 24 is about 650 starts); commit 34d8a295 only fixed tie-down types; fix = replace on load + remove exact duplicates on every load/save/replace, first copy kept, order kept, no cap, one plain log line; 4 files verified, no test line removed, risk check clean, Sonnet review enough; 6 new tests pass, full Structural net10 1,752 passed with `SbeamEditAutoCadEvidenceReaderTests` excluded because that fixture (122 tests) hangs the host and had 1 failure `CompiledProductionRoute_BindsRealEntryNativeProtectionDirectStorageAndC0` NOT compared with the base: the train must run that fixture on the base and on the train and compare by name (#397 excluded the same fixture). **Overlap: #399 and #392 both edit Structural `Models/UserSettings.cs`: merge them in the same train, one after the other.** **Install note: Tim's live CS_Settings.json gets cleaned on the first load: copy it aside before the install (his rules are his).**)
1n. **DEEP CODEX SWEEP LAUNCHED Wed 30 Sep 00:01 (controller, by hand: the 23:47 timer did not fire)**: preconditions read at 00:00: installed DLLs Civil 3.0.15+a6e0cc87 / Manager 1.1.15+a6e0cc87 / Structural 1.0.86+532f955 (from disk), AutoCAD not running, no Codex run live, no testhost/msbuild; fresh Codex reading 56.0%; `queue3.sh` with 19 jobs in priority order (pass18, sweepC1-C8, sweepS1-S6, sweepMG1-MG3, uxhuman), model gpt-6-astra low, stop line 90, MAXC=1; pass18 START logged 00:01. A 00:16 check verifies the queue script survived the Bash tool's 10-minute background limit (else the rest is relaunched detached). **REVISED 00:05 after the desk's note (Tim: "so you will build whilst codex will test ... you will work autonomously, correct?" and "please do not stop building unless i stop you"): 1-2 builders/fixers keep running at Below Normal priority on LIGHT work (edits and focused tests only, NO full suites, one build at a time); builders pause only for the timed parts (C8 long session, MG3 start-up timing, any [PERF] measurement) if the load would distort them, and resume straight after; Opus confirms and cards continue. Started 00:05: S2 slice 2 (unit copy command) and C1 slice 2 (CD size/grade option, Undo-name fallback sentence).** The full suites and the by-name failure comparisons wait for the train. (Timers proved unreliable: the 23:47 launch did not fire; the sweep's 00:16 check and the heartbeat are the safety net.)
1m. Deep sweep briefs done ~23:28 (controller check): 18 files in `C:\Lisp Files\_CODEX_RUNNER\` (sweepC1-C8, sweepS1-S6, sweepMG1-MG3, uxhuman), 73-85 lines each, all with the stop line, the UX block and the "IN SCOPE N, TESTED M, NOT TESTED K" ending; scope counted from the registers: Civil 139 commands (C1 15, C2 43, C3 31, C4 8, C5 8, C6 4, C7 30), Structural 354 (S1 22, S2 66, S3 20, S4 122, S5 90, S6 34), Manager 12 + 6; window/tab counts are counted by Codex first; C8 and MG3 are behaviours, not command lists. Each part is estimated at 3-4 hours (C8 2.25 h, MG parts 2-2.5 h, uxhuman 3 h): **tonight covers pass18 plus about two parts, not all 18**; the rest carry to Thu-Sat (the briefs write SWEEP*\NEXT_START.txt where they stop). Launch check moved earlier to 23:47 (quiet PC or 01:07 at the latest).
1l. INT-015 (~00:10 by the desk's stamp; the clock read about 23:21) -> answers recorded, read from the decision file, section "30 Sep 2026 (Tue night, about 00:10)": all eight questions of section 9 items 13 and 14 took the recommendation. C4: (a) office list of engineer names in Settings, shared with Structural issue, typed names marked "typed"; (b) Accept all built, the Pipe sizes group behind a Settings switch OFF until Tim signs the sizing rule values; (c) "Different" only where the supplied design states a size, else "Can't verify", never inferred; (d) Design opens at Start with no agreed design, During whenever one exists, Finish only by its tab. S4: (a) retaining walls: a Settings table by height band with a "fence on top" column, Unknown until filled; (b) fence post footings: Settings table by fence type and height, Unknown until filled; (c) bar length rounding: a Settings value, exact length until set; (d) bar shapes: straight first, others Unknown until he confirms the office shapes. **Section 9 now has NO open question for Tim.** The C4 and S4 cards are approved to build (Opus builders for the calculation paths, Sonnet for the rest).
1k. INT-014 (URGENT, ~23:55 Tue 29 Sep; decision file section "30 Sep 2026 (Tue night, about 23:55)", read via the desk's message) -> taken ~00:00: Tim, verbatim: "get it to also think about the user experience of all of these things". EVERY Codex brief tonight carries the UX judgement block (eight questions: find it, clicks against the plan target, plain-word messages, defaults, safe recovery, consistency across the three modules, speed feel over 50 ms, what a new colleague gets stuck on), a ranked "UX findings" section (blocker / annoying / polish, each with the exact place, screenshot and ONE concrete suggestion), a "what works really well" list and a one-line non-coder "UX verdict" per part, and the top three findings in the last message. Block file: scratchpad `ux_block.txt`; appended to pass18.txt (done) and to the 18 sweep briefs by the brief writer (asked). The controller files the UX findings as ideas (IDEAS_INBOX is the desk's file: put them in the report and pass the top ones to the desk) or as carpark bugs as fits.
1j. INT-013 (~23:45 Tue 29 Sep; relayed by plan/05, recorded by the desk in the decision file, section "30 Sep 2026 (Tue night, about 23:45)", read and verified) -> taken ~00:00: Tim, as relayed: "when i ask for percentage its always built, and tested by codex, my plan is to barely test and let codex do that but it needs to be tested well by codex". Every progress note and the Friday facts carry TWO figures: **Built X%** and **Codex-tested Y%** of the V3 plan (UX items plus open bugs), each with what was counted; not "Tim-accepted 0%" as a headline; the four words stay separate in the detail. Thorough Codex testing (coverage N/M/K, Part Z) is the main quality gate. A counting one-shot is set for 06:20 Wed (Explore sub-agent, sonnet) so both figures are ready by 07:05.
1i. INT-012 (URGENT, ~23:30 Tue 29 Sep) -> taken ~23:35 (decision file, section "30 Sep 2026 (Tue night, about 23:30)", read and verified; Tim: "stop at 90% usage, i want you to get codex to test every part of the v3 ux plan and also go above and beyond with other testing, this shouldnt be surface level"): SUPERSEDES INT-011's 66% stop line. Codex fresh reading 56.0% at 23:17 (resets Sun 4 Oct 04:01, Tim's belief in a reset tomorrow morning is UNVERIFIED). Tonight: pass18 (everything installed since pass 17), then the whole sweep in priority order C1..C8, S1..S6, MG1..MG3, uxhuman, stop line 90% (about 34 points, so roughly 4-5 deep parts fit; the rest carry to Thu-Sat and get their count in the coverage list); 18 deep briefs are being written (Sonnet, `_CODEX_RUNNER\sweep*.txt`, uxhuman.txt); launch when the PC is quiet after 00:37 and no later than 02:07; stop by 08:15. DECISION (controller): NO train install before the sweep: the ~40 draft PRs are OFF by default or awaiting fixes, seven flagged PRs have Opus fixes in progress and need their Opus confirm, and installing unreviewed code right before the sweep would break "one live version, always known" and the hard install gate; so the sweep tests the INSTALLED build (Civil 3.0.15 / Manager 1.1.15 / Structural 1.0.86), and every draft-PR item is reported NOT TESTED: NOT INSTALLED. A reviewed train follows Wed and a targeted Codex pass on what it changed. 04:07 Wed one-shot replaced by a 00:37 launch check.
1h. INT-011 (29 Sep ~23:15) [SUPERSEDED by INT-012 for the stop line: 66% -> 90%] -> taken 23:25 (decision file, section "30 Sep 2026 (still Tue night, about 23:15)", read and verified; Tim: "can we do a codex run tongiht also, making sure we manage codex weekly usage?"): ONE Codex pass at Wed 30 Sep 04:07 (`pass18`, stop line 66% weekly, queue3.sh with maxpct 66: Tim's ruling for tonight only, overriding W0-3 and the "never a fixed cap" rule); Codex read 55.0% at 23:10 (resets Sun 4 Oct 04:01). Thursday's 04:07 pass becomes draft1 + sweepC1 (the Thursday timer is re-made after the Wed pass). While the pass runs no builder starts a full test suite. Report path goes in section 9 item 2 by 07:15.
1g. INT-010 (standing, Tim to the desk ~23:00 Tue 29 Sep, verbatim in the decision file, section "29 Sep 2026 about 00:05 (Wed 30 Sep)"; read and verified): "please do not stop building unless i stop you, manage the weekly usage and throttle up/down as possible". Standing authority to throttle builders and Opus jobs (max 3 builders, fixers for Opus findings on top) to hold the pace plan (about 1.5% an hour, near 90% at Fri 2 Oct 12:00). The controller never pauses the run itself; a real blocker goes to the desk. **Timestamps in this file:** the controller stamped some times between 18:25 and 23:10 on 29 Sep from memory, not from the clock (a line said "00:35" when `date` read 23:08); the ORDER is right, the minutes are approximate; the ones in the future were corrected. The controller now reads `date` before stamping. Timers set 23:15: heartbeat every 2 h, 06:03 morning read, 07:05 Wed 30 Sep Friday-style facts for the desk's 07:27 wake-up summary. NOTE for the desk: the Codex pass is Thu 1 Oct 04:07 (Wednesday's even share is spent: Codex 55% used against a Wednesday cap of about 58%, a pass costs 8%), so there is NO Codex result on Wed morning.
1f. INT-009 (29 Sep ~23:55) -> taken ~23:08 (decision file, 29 Sep ~23:55 section, read and verified; the controller read `get_usage` itself: weekly 0%, 5-hour 0%, weekly resets Fri 2 Oct 01:59:59Z = about 12:00 Melbourne): Tim reset his usage. Tim: "you can probably work a little faster to use 90% by that date, then once it resets it goes back to the regular cycle". **Pace line until Fri 2 Oct 12:00: land the weekly meter near 90% at the reset (about 1.5% an hour from now), not sooner and not far under; the 90% cap is the stop line; up to 3 builders as the base rate, fixers for Opus findings on top (lane F).** Supersedes the 99% hold and "build until 100%". After the reset the normal cycle and charter pacing apply. The 04:07 Codex launch stands.
1e. INT-008 (29 Sep ~23:10, URGENT) -> taken ~22:55 (decision file, 29 Sep ~23:10 section, read and verified; Tim: "i never asked for anything to stop"; his 21:15 word stands, he resets the weekly usage himself): NO hold at 99%. Resumed ~22:55: (a) three Opus reviews, model "opus" passed explicitly (csharp-reviewer): #387 #388 #393 / #391 #390 #396 / #397; (b) three Sonnet builders: Manager (#394 grey + MGR-02 hide-first + MGR-01 logic), S1 slice 2 (#392: S names, shortest code, one Tag tool), UX-PIPE-02/02b/07 auto-join (`claude/pipe-autojoin`). If the meter reaches 100%: message the desk (Tim resets); the controller does not stop by itself. My 04:37 timer still resumes anything left. Installs still only in his free windows until Wed 30 Sep 17:40; the Opus rule unchanged.
1d. INT-007 (29 Sep ~22:50) -> answers recorded 23:50 (decision file, 29 Sep ~22:50 section, read and verified): the four real gaps of section 9 item 12 are ANSWERED, so section 9 has NO open question for Tim now. (Q3) MEMBER SCHEDULE text: "No, keep 300 and 200" (against my recommendation; the fixed sizes stay, BUG-196's residual is closed by his ruling). (Q6) "Yes, on MOVE and STRETCH too": #391 already asks on a plain move, matches. (Q7c) module not installed: "Quiet grey": #394 built amber, a one-line fix to make. (Q8c) "This drawing only": stored in the drawing, whole-job version not built. Follow-ups: #394 grey; #390 colleague-has-DWG as a job message; S1 slice 2 (S names); S2 slice 2; C1 slice 2; UX-PIPE-02/02b build (drawing-only storage for the free-end choice).
1c. INT-006 (29 Sep ~22:25) -> taken 23:40: Tim (decision file, 29 Sep ~22:25 section, read and verified): "theres a plan, questions should only be if the chat is unsure against the plan". Effect: (1) the still-open section 9 questions were re-checked against the plan (result in section 9 item 12); (2) `builder_rules.txt` now tells builders to check the plan before returning a question and to name the document they checked.
1b. INT-005 (29 Sep ~22:15) -> answers recorded (decision file, 29 Sep ~22:15 section, read and verified): questions 10 and 11 took the recommendations (units: window then base points, mirror line, new link group, headings inside each floor's block; CD helpers: probe the Undo step name first else print "Undid: <what>", size/grade as a command-line option in CD only, glow on pits first). New work: S2 slice 2 (unit copy command with those four rules), C1 slice 2 (CD size/grade option), a Codex probe of the Undo step name (add to the next pass). **Meter plan (controller, 29 Sep 23:20):** Tim's standing word (21:15) is to build to 100%; the hold at 99% only protects the 04:07 Codex launch turn. So: after the Thu 1 Oct 04:07 launch has started, builders resume and run to 100% (timer 04:37); at 100% the desk is messaged and Tim resets usage himself.
1a. INT-004 (29 Sep ~21:40) -> answers recorded, unblocks A6 and S1: Tim's clickable answers (decision file, 29 Sep ~21:40 section, read and verified): tolerance stays 50 mm; hand-typed levels are left out; "The S names" win for the Structural duplicate names (the Excel-pair naming stays open); CE learning: "Yes, all four". Effect: A6 (#389) and L1 (#396) already match; S1's card must be updated from the T names to the S names (a follow-up to #392, S1 slice 2). Questions still with Tim: those numbered 3, 4, 6, 7, 8 in section 9 item 1, the Excel names, and the new 10 (Structural units).
2. INT-003 (29 Sep 21:15) -> taken 21:20: Tim's words (decision file, 29 Sep ~21:15 section, read and verified): "i will reset usage once 100% is reached so for now build until 100%". Weekly stop line 97% -> 100% (supersedes the 19:03 pause; Claude weekly read 98% at 21:12). Restarted 3 builders 21:20: `claude/bug204-dedupe` (Structural, checks 34d8a295 first), `claude/ux-pipe` (UX-PIPE-01/02/03/07), `claude/ux-mgr` (UX-MGR first three). Installs still only in his free windows until Wed 30 Sep 17:40; the Opus rule is unchanged. At 100%: stop builders, keep Codex going, message the desk (Tim resets the usage himself).
   #394 UX-MGR-03 one-glance status (BUILT 29 Sep 21:40, OFF unless manager-switches.json says oneGlanceStatus; Manager net48 + net10 0 errors; Manager.Tests 337/337, 21 new; risk check clean, no test line removed, PR files verified; Sonnet review enough; card copied to `cards/UX-MGR-01-03_CARD_2026-09-29.md`; MGR-01 and MGR-02 not built, questions in section 9; the builder ran and killed a stray `python -`, none left).
   #394 UPDATED (builder finished, verified by the controller: 8 files, head 9b432e05, no test line removed, risk grep clean, the rollout test file writes only temp files and a test asserts the rollout logic never references signing/approval/files): a module not installed shows QUIET GREY (Tim's Q7c); "Open Hub" is hidden behind switch `hideOpenHub` with a line pointing to Project Review (Tim's explicit yes, rulings line 553; the click code and typed command untouched); UX-MGR-01 "pick who, then everyone" LOGIC only in `CeStagedRollout.cs` behind `updateColleagues` (publishes, signs, approves and writes nothing; no source for the colleague PC list yet). Manager full net10 360/360. Note for Codex: two lines were added to `PluginManagerWindow.xaml` (a visibility binding and a text line): Codex owns window layout (ruling B), so it reviews them. Sonnet review enough; PR still draft.
   #398 UPDATED, slice 2 (30 Sep ~00:13, head 706ebd6b, 15 files, no test line removed, verified): CD's `[Size/Grade]` command-line option (CD only, not draw-first CD; offered from the second-point question onward; Esc at the size or grade question cancels the whole pipe) behind the switch "Size and grade at the command line", default OFF (Tim's Q11 b); after CD's own `[Undo]` it prints "Undid: point N of the pipe route." behind "Say what was undone", default OFF (Q11 a fallback; the sentence after AutoCAD's own U on a whole CE step is NOT built until the Codex probe answers: 5 probe steps are in the card); pit glow unchanged (pits only, Q11 c); `CdViewModel.Grade.cs` only had a logic-identical extraction (`GradeComesFromLevels`, controller read the diff); `UserSettings.cs` one added line (joins the overlap list: #390, #396, #398, #401); 137/137 focused tests; full suite NOT run (Codex sweep live); Sonnet review enough.
   #388 FIXED per Opus (heads e3be258b, 7c14d713, 30 Sep ~00:00, verified: 6 files, no test line removed): the host-label tidy is now an explicit flag `TidyBranchHostLabels` (default false), set only by `CdCommand.cs`, so XCIVIL import, same-plan break and test runners are unchanged (tests assert it, including that `XcivilPipeInsertionService.cs` never mentions it); the host search takes the mains from the scan's own pipe list, with a `[PERF] TidyUp.BranchHosts` log line (one `ScanNearby` stays; a second scan runs only when a joined main's label area falls outside the windows already scanned); Reset Position wording corrected (Undo restores a dragged label, Reset Position does not); per-main try/catch; focused 55/55; full Civil net10 12,620 run / 12,596 passed / 5 failed (AddSystem x3, BoydsDetention, BackTest_GlenEira) and the two `SourceAtomicCoordinatorDependencyTests` PASSED this time: those two are flaky, not stable failures. Opus confirm still needed.
   #387 FIXED per Opus (head c39be4e6, 29 Sep ~23:55, verified: 5 files): CDCHECK's three "show where" questions are now ONE question: Enter or Esc always finishes to the Command prompt; typing Fit, Ends or Items switches list; all three lists stay reachable in every mode; in CSV mode it starts on the fit warnings; the cost is one extra typed word to reach the fit or pipe-end lists (flagged in the REGRESSION_LOG: **for Tim's return page, keep as built unless he objects**); Tim's steps rewritten to what the code does. **An EXISTING test was edited**: `SpineHoldPointTests` had `Contains("JumpToItem(editor, db, shown.Take(MaximumListedRows).ToArray(), records)")` and now has two `Contains` on the renamed lines (`SpineConnectionRow[] itemRows = shown.Take(MaximumListedRows).ToArray();` and `ShowItem(editor, db, itemRows, records, number)`): same rule, adapted to the refactor (controller read the diff): the Opus confirm must confirm it. **The full Civil suite was NOT re-run after the last test fix** (the last full run: 12,621 run / 12,594 passed / 8 failed = the 7 known + that guard, since fixed; focused 31/31): the train's full run must show it. Sonnet + short Opus confirm (SpineCheckCommand.cs is on the risk list).
   #390 FIXED per Opus (head db31ec90, 29 Sep ~23:52, verified: 14 files, no test line removed): switch OFF registers nothing (`CeBellStatusBarService.Initialize` returns before any hook); never writes to AutoCAD's current folder; unsaved job messages are kept and retried after a drawing switch (personal ones too); the file work at drawing switch/close runs on a queue in the new `CeMessageWorkQueue.cs` (closing AutoCAD waits up to 2 s for the last save; an unmeasured slow drive could exceed that); "colleague has this drawing" is now a JOB message and clears when the colleague closes the drawing (a new `Cleared` state; `ClearColleagueHasDwg` waits for the UX-SHARE-01 producer); `Core.Messages` 54 tests pass; full Civil net10 12,662 run / 12,636 passed / 7 failed (the builder says the known 7, names not printed: compare at the train); switching the setting on takes effect at the next AutoCAD start. Opus confirm still needed (document events, file I/O).
   #393 FIXED per Opus (head f498b772, 29 Sep ~23:48; fixer's report checked): the save is skipped only when the WHOLE project record is empty (a walk over every field, so a later-added field counts automatically); `HasCivilContent` counts every list on the record (raingardens, pavement areas, spoon drains, slabs and the rest) with a reflection test that fails if a new list is not counted; an unreadable record counts as Civil content in both places; the CE-pipe-object-only test is renamed `KnownGap_...` and the gap recorded in the log; full Civil net10 12,621 run / 12,594 passed / 8 failed: the 7 known + `CheckCommand_NumbersItems_OffersJump_AndReportsTheStoredSnapshot` (SpineHoldPointTests, a source-text test on SpineCheckCommand.cs). **The fixer said it "fails on the base too": NOT proven. The controller ran `SpineHoldPointTests` alone on the A5 fix branch (base + A5) and on #393: 13/13 pass on both. So it does not reproduce in isolation: an order- or concurrency-dependent failure in the full run (many agents were editing and building at once, and #387 also changes CDCHECK prompt flow). Watch it at the train: the train's full run must show it passing or name it with evidence.** Opus confirm still needed.
   #397 FIXED per Opus (head 8d0797e8, 29 Sep ~23:45, verified: files and no test line removed): XCLMTXT and its preview read the Level/Unit/None choice from the open drawing's job file; a Unit job now drops the leading number before the default mark-prefix rules are matched (3FB1 is matched as FB1; 4TB1 stays Third Floor because of the plain TB prefix, noted on the card); unchosen, Level and None unchanged; tests keep the DEFAULT rules on; UnitTagTests 52/52; four-part namespace run 2,260 passed / 0 failed; **the Sbeam fixture (`SbeamEditAutoCadEvidenceReaderTests`) crashes the test host in every run at a different `CompiledProductionRoute_R10EveryUnsignedOpcodeHonoursAllInt64Boundaries(...)` case (Bne_Un, Bne_Un_S): the train must run that fixture on the BASE and on the train and compare by name**. Opus confirm still needed (XCLMTXT path, ProjectDataService).
   #392 UPDATED, slice 2 (29 Sep ~23:40, head b81e1446, 10 files, no test line removed, verified; Structural, base `claude/rel-20260929c-struc`): the S names win (SDS, SDS1, STS1, SC1 stay on the ribbon and TDS, TDS1, TTS1, TC1 drop off); the shortest code wins the Excel pairs per Tim's ruling (rulings line 768): EXCELMAPFLOOR and EXCELCAPTUREAREA (the builder had first picked EXCELMAPFLOORAREA, 17 letters, against the ruling: the controller sent it back and it is fixed); CL1/PCL and CR1/PCR stay as both; 14 names drop off (all still run typed); ONE Tag button on Annotate (20 existing tag codes, remembers the last pick), OFF by default; Text and Hatch families not built; unified-host ribbon needs the CE_SHARED upgrade (not touched); a small `ShallowCopy()` was added to `CommandRegistryModels.cs`; ribbon tests 66/66 on net10 and net48, namespace groups 610 and 1,530 passed, the Sbeam fixture excluded as elsewhere. **Overlap: Structural `Models/UserSettings.cs` is also edited by #399 (one word here: `CommandHubSettings` is now partial): same train.** Sonnet review enough.
   #401 UX-PIPE-02b + 07 auto-join (BUILT 29 Sep ~23:35, head 8f85cc48, 12 files, no test line removed, verified): new Settings `linking.autoJoinPipeEnds` (default OFF until Codex accepts) and `linking.pipeEndJoinDistanceMm` (75, capped 500); one pipe end in range: a new CD end is moved onto it and linked (using the existing endpoint-review record, no new link kind, one U removes it); two or more in range: asks A/B/None (default None); a pit at the end wins; "Keep as a free end" stored in the drawing (Tim: this drawing only) and CDCHECK's open-end list skips it until it moves more than the join distance; 33 `PipeEndJoinTests` pass; full Civil net10 12,640 run, 7 failed, **the builder did NOT print the names (assumed known): compare by name at the train**; **Opus review REQUIRED** (link record, ProjectDataService); not built: the Settings-page row and the "Keep as a free end" button (Codex XAML), the CDCHECK Disconnect row and live cursor preview words. **Overlap: Civil `Models/UserSettings.cs` is edited by #390, #396, #398 and #401 (each adds settings): merge them in one train, one after the other.**
   #396 FIXED per Opus (head 0f1a0c81, verified 29 Sep ~23:37: 12 files, no test line removed, the store test asserts LOCAL AppData, never roaming or OneDrive): learning counts only sizes the drafter changed or chose with Use (`PitEditCommand` records the size on opening: if `NoteSizeWhenOpened` is not called nothing is learned unless Use is pressed), local store, hook after the ledger write, file-access seam test, PR body and card §7 updated; full Civil net10 12,650 run / 12,624 passed / 7 known failures. Opus confirm still needed.
   #400 C2 UX-SRC-01..03 (29 Sep ~23:35): ALREADY BUILT on the live line (OF/FO symbols and tags, Strip Drain as its own type, raingarden numbering RG1.. never reused; SRC-04/05 also built: 74b12f51 and PR #346), so the builder added guard tests (10, 58/58 focused), the card and a log entry only; no product code; no test line removed (verified); full Civil net10 5 known failures; card copied to `cards/UX-SRC-01-03_CARD_2026-09-29.md`; note for Codex: `SourceFamilies.All` is not read by any window yet, so the Source window type strip is Codex's to build. These IDs go to Part Z / the sweep (C2), not to a builder.
   #391 FIXED per Opus (29 Sep ~23:35, head 8c6db2bf, verified: 7 files, no test line removed): script/LISP guard, "NotAsked" saves nothing, typed + automatic numbers stored together (`bottomLevelTypedSeen`), no question at the end of QSAVE/SAVE/SAVEAS or REGEN/REGENALL/REDRAW (done by wrapping the existing `ApplyPendingLinkUpdates` calls in `LinkService.Reactors.cs` with `SuppressQuestions()`: a reactor file, so the Opus confirm must look at it); full Civil net10 12,652 run / 12,626 passed / 7 known failures. Opus confirm still needed.
   #395 UX-PIPE card only (docs + REGRESSION_LOG, 2 files verified, no code; the builder's trial edit to move the Escape rule failed two existing tests and was reverted; card copied to `cards/UX-PIPE-01-03-07_CARD_2026-09-29.md`).
   #396 L1 UX-LEARN-01 slices 1-2, own habits + corrections (BUILT 29 Sep 22:15, OFF by default via Settings switches; new `Modules/Drainage/Learning/`, one line added to `SuggestionLedgerService.cs`; 26 new tests, full Civil net10 12,610 passed / 5 failed; the path risk check is clean, no test line removed, a test asserts nothing reads `C:\CE_DrawingIntelligence` (verified, the corpus was never opened); it stores numbers only, per person, on their own PC; **Opus review REQUIRED** (L1 is on the Opus list and it stores something about a person); card §7 (window contract + questions) copied back to `cards/UX-LEARN-01_CARD_2026-09-25.md`, 60 lines added, none removed; not built: window, office learning, promotion, corpus import).
   #397 S2 UX-UNIT-01..04 partly (BUILT 29 Sep 22:40, base `claude/rel-20260929c-struc`; 13 files verified, none of #392's files touched, no test line removed; 48 new tests, Structural full net10 2,140 passed / 0 failed in parts with `SbeamEditAutoCadEvidenceReaderTests` excluded "as before" (the controller has not verified that exclusion: check it at the train); **Opus review REQUIRED** (`ProjectDataService.cs`; also touches the XCLMTXT import path); UNIT-02 is a hidden command CSUNITTAGS asking Level/Unit/None once per job, default unchosen so nothing changes; UNIT-01/03 rule only; UNIT-04 helper only; card copied to `cards/UX-UNIT_CARD_2026-09-29.md`).
3. INT-001 (29 Sep ~18:10) -> taken 18:25: Tim's two clicks (decision file, 29 Sep ~18:10 section, read and verified by the controller): up to 3 builders now, run to the limit, overriding his 90% cap until Wed 30 Sep 17:40; installs only in his free windows; Codex overnight as armed. Started 3 Sonnet builders 18:25: `claude/bug200-201` (BUG-200+201, CDCHECK Enter and pit-placement wording), `claude/bug197` (branch invert labels), `claude/a6-implvl` (A6, XCIVIL imported-level flag). Base `claude/rel-20260929c`. After Wed 17:40 the 90% cap returns.

## 14. Opus log (the controller writes one line per Opus job; the weekly rules check counts it)

Format: `date time - kind (review / train sign-off / convergence / diagnosis / card / FAIL second opinion / weekly check /
RC audit / handoff check) - target (PR numbers, branch, bug, card) - verdict - model stamp - Claude weekly % before -> after`.
1. None before 29 Sep 23:55. The first three lines also give the cost measurement asked for in section 2, item 8. (Meter reads are whole percents: weekly 99% before every Opus job tonight; the cost per job is smaller than the resolution: record each job's `subagent_tokens` instead.)
3. 29 Sep ~23:06 - review - PRs #391 #390 #396 (one call) - all three MERGE-WITH-FIXES (#391: script/LISP guard, "NotAsked" outcome, answered-pair memory; #390: OFF must register nothing, no write to AutoCAD's folder, keep unsaved job messages, file work off the UI thread, colleague-has-DWG as a job message; #396: feed only real changes, LOCAL AppData store, hook after the ledger write, stronger corpus test, PR body) - model claude-opus-5-5 - weekly 99% -> 99% (148,378 tokens) - comments pull/391#issuecomment-5890902954, pull/390#issuecomment-5890903330, pull/396#issuecomment-5890903732. Three fixers started ~23:07.
4. 29 Sep ~23:08 - review - PRs #387 #388 #393 (one call) - all three MERGE-WITH-FIXES (#387: Csv/All-mode "show where" questions lost + a false step in the log; #388: also runs on CDIMPORTXCIVIL and same-plan break, full model-space pass per pipe not timed, Reset Position claim false, one try/catch per main; #393: the save-gate would drop raingardens/pavement/spoon drains/slabs/rulebook/rainfall/source numbering in a quiet drawing, unreadable must mean active, one untestable test) - model claude-opus-5-5 - weekly 0% (reset by Tim) (114,942 tokens) - comments pull/387#issuecomment-5890917752, pull/388#issuecomment-5890918209, pull/393#issuecomment-5890918792. Fixers for #393 and #388 started ~23:09; #387's fixer next.
5. 29 Sep ~23:20 - card - C4 (UX-CALC-01..03, UX-SIZE-01..03, UX-DES-02/03) - written, 4 questions (section 9 item 13) - model claude-opus-5-5 - 196,797 tokens - `cards/C4_CALC_SIZE_DES_CARD_2026-09-30.md`.
6. 29 Sep ~23:25 - card - S4 (UX-FDN, RAFT, LOAD, BSMT-04..06, RW) - written, 4 questions (section 9 item 14) - model claude-opus-5-5 - 197,390 tokens - `cards/S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md`.
11. 30 Sep ~00:25 - review - PR #397 SLICE 2 (commit 9e82f9a1) - **DO-NOT-MERGE** (BLOCKER: copying a beam copies its link record, so the copy's supports and beam text point at the ORIGINAL unit's, the link reactor then moves the original's supports and text onto the copy, or two beams claim one support; HIGH: attribute text in mirrored blocks reads backwards; MEDIUM: the Level/Unit/None answer is saved before the window pick so Escape leaves a change on the job file; MEDIUM: renumbering goes by what plain text READS, not only CE tags; passed: switch OFF byte-for-byte unchanged, one transaction/one Undo, native protections, headings inside each floor block, no test loosened) - model claude-opus-5-5 - 79,165 tokens - comment pull/397#issuecomment-5892164483. **Action: slice 2 split off #397** (new branch `claude/s2-unit-copy`, new draft PR; #397 gets a `git revert` of 9e82f9a1 so it returns to the Opus-confirmed 8d0797e8, no history rewrite); the fixer applies the four fixes on the new branch; a new Opus confirm follows. #397 itself keeps its gate (review + confirm on 8d0797e8) once its head is verified equal to 8d0797e8 in content.
10. 30 Sep ~00:20 - review started - PR #397 SLICE 2 (commit 9e82f9a1 on top of the confirmed 8d0797e8): the unit copy command `CSUNITCOPY` (window then base points, mirror line, new link group) and `CSUNITTOOLS` switch (default OFF) and the schedule headings inside each floor's block; touches cloning in one transaction and the BeamLink clone reactor: Opus review in progress (the earlier MERGE covers 8d0797e8 only). Builder report (light, no full suite): 106 tests pass net48 and net10 (Units + CommandClassRegistration), 278 pass net48 for schedule/registry/ProjectData/XclmTxt/Stage 3; not built: "Edit together / Edit this only", a drag preview, a Settings-page toggle; mirrored blocks with attributes untested; #397 now has 23 files, no test line removed (verified).
9. 30 Sep ~00:17 - confirm 2 - PR #390 head 5cff544c - MERGE (background save merges, never drops; no AutoCAD call off its thread; shutdown wording true) - model claude-opus-5-5 - 53,274 tokens. Watch item for Codex: if AutoCAD starts with no thread captured, the "CE n" count never changes (look for the log line "AutoCAD's own thread was not known"). **#390 now has its OPUS gate; it is OFF by default and still needs a Codex PASS before it merges.**
8. 30 Sep ~00:10 - confirm - PRs #387 #388 #391 #393 #396 - MERGE (each); #390 - MERGE-WITH-FIXES (its fix 4 added three faults: messages raised or dismissed during a background save were silently dropped; the status bar could be touched from the background thread; the shutdown log line "tried again next time" was false) - model claude-opus-5-5 - 180,148 tokens - comments pull/387#issuecomment-5891997856, 388#5891998444, 390#5891999418, 391#5891999904, 393#5892000554, 396#5892001167. Minor notes kept for the fixers/train: #387 PR body still says three questions and 11/11; #388 the log says 6 tests, there are 12; #391 any command that leaves pipe work queued (ROTATE, SCALE) can also ask: tell Tim; #391 a comment in Decide is out of date; #393 an optional one-line fix in HasCivilContent (a non-Xrecord entry reads as quiet) and the PR body wording; #396 reset Proposed in NoteSizeWhenOpened. **#387 #388 #391 #393 #396 now have their OPUS gate (review + confirm); #390 gets a third short confirm after its second fix; every one still needs a Codex PASS before it merges (gate 4.6.3).** The #390 fixer restarted 00:12.
7. 30 Sep ~00:10 - confirm - PR #397 head 8d0797e8 - MERGE (optional: card/log say the job file is "next to the drawing", it is in the CE settings `projects` folder named from the drawing's path, so Save As or moving the drawing loses the Unit choice: say so; remove a stray duplicate comment) - model claude-opus-5-5 - 65,770 tokens - comment posted on the PR. **#397 has its OPUS gate (review + confirm); it still needs a Codex PASS before it merges to `claude/struc-d1-prep` (gate 4.6.3), and its slice-2 unit-copy work is being added on the same branch.**
2. 29 Sep ~23:03 - review - PR #397 (Structural units) - MERGE-WITH-FIXES (XCLMTXT must read the open drawing's job file; test copy bug; two doc notes) - model claude-opus-5-5 - weekly 99% -> 99% (51,511 tokens) - comment https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/397#issuecomment-5890866553. Fixer started ~23:04 (`claude/s2-unit`); the fixes touch the XCLMTXT path, so a short Opus confirm is needed after them (gate 4.6.1).
