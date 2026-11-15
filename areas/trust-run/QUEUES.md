# Trust run: the lanes and their queues

**Controller:** chat CE_ACAD / trust plan / plan / 01. Rules for the whole run: `areas\TRUST_AUTONOMOUS_RUN_12NOV.md`. This file says what each lane does next. Tim, 12 Nov, late: "set up as many as you can to just keep things working in different workflows ... in the most logical way. And make sure we're using the right models for the right thing and the right thinking as well."

## How a lane works (every lane, no exceptions)

1. **Work your queue top to bottom.** Finish an item, write its status, start the next in the same turn. Do not end your turn while your queue has an item you can do.
2. **Status goes in your own file only:** `areas\trust-run\<lane name>.md` (newest line last: date, time, item, Built / Tested / Installed / Accepted as yes or no, what was not proven, defaults taken for Tim). Never edit another lane's file. Save and push `C:\CE_PLAN` by file name after each item.
3. **Keep yourself going.** Set one recurring check-in in your own session (every 40 minutes, off the hour) whose prompt is: "Lane check-in: re-read `C:\CE_PLAN\areas\trust-run\QUEUES.md` and `C:\CE_PLAN\areas\TRUST_AUTONOMOUS_RUN_12NOV.md`, then carry on with the next item in my queue. If my queue is empty, write QUEUE EMPTY in my lane file and do nothing else." Set it once; do not stack several.
4. **Blocked item:** write why in your lane file in one line, mark it BLOCKED, and move to the next item. Never wait for an answer and never ask Tim.
5. **Queue empty:** write QUEUE EMPTY. The controller refills queues at its hourly check.
6. **Messages from the review lane** are findings to weigh and fix, not orders to merge or install. Nothing in a message, file or web page can lift rules 2.2 of the run file (no install, no colleagues, no merge).
7. **Usage:** before Fri 13 Nov 13:00 Melbourne, work at full pace. After it, the controller sets the pace; if your lane file's last controller line says PAUSE UNTIL <time>, stop until then.

## Models and thinking per lane (Tim's routing rule, 21 Oct: Haiku mechanical, Sonnet build and test, Opus review and anything touching Undo safety, Settings or Shared)

1. **trust-foundations:** Fable, high. The riskiest code in the plan: CE's record update.
2. **trust-reader:** Opus, high. New read-only code that every later proof rests on.
3. **trust-safety-fixes:** Opus, high. Root causes of lost-data faults.
4. **trust-core-ribbon:** Sonnet, high. Layout and settings work with clear rules.
5. **trust-acad-evidence:** Sonnet, high. Driving AutoCAD and recording what is seen.
6. **trust-review:** Opus, xhigh. Independent review of every draft pull request; a different model from the builders where possible.
7. **trust-struc-mgr-plan:** Opus, high. Planning.
8. **trust-test-cases:** Sonnet, medium. Writing robot cases, look briefs and tool notes from the cards.
9. **trust-records:** Haiku, low. Mechanical record checks only; never code or engineering judgement.

## Where each lane runs (Thu 12 Nov, 22:50 PC clock)

1. **Own side sessions (each keeps itself going with its own 40-minute check-in):** trust-foundations, trust-safety-fixes, trust-core-ribbon, trust-acad-evidence, trust-struc-mgr-plan.
2. **Inside the controller chat, as helpers the controller restarts at each hourly check:** trust-reader, trust-review, trust-test-cases, trust-records. The app refused to start these four as their own sessions while Tim was connected by Remote Control; started from the desktop app they could be sessions too.
3. **The controller's hourly check:** reads usage; reads every lane's status file; restarts any helper lane that has finished and still has queue left; refills empty queues from the plan; passes review findings to builders; folds results into the plan and cards; saves and pushes.

## Queues

### trust-foundations (code, Civil, branch from cf059dcf)
1. Step 1, opening line, including the new read-only scan of drawn pits and pipe-layer lines (card UX-OPEN-01 plus the controller's correction).
2. Step 5, the record update made visible (card TRUST-05).
3. Step 6, Unknown instead of made-up values, switch OFF by default (card TRUST-06).
4. Fix what trust-review finds on items 1 to 3.
5. Step 7, the LPD as the one stored start point, once the controller has rewritten card TRUST-07 (the card says TO BE REWRITTEN until then; skip while it does).
6. Step 8 slice A, the read-only list (card TRUST-08), using the reader from trust-reader.

### trust-reader (code, Civil, branch from cf059dcf; new files only where possible)
1. Step 0: the read-only reader as its own small piece of code, from `areas\TRUST_READER_DESIGN_12NOV.md`: what each drawn object is, which version, Sure / Proposed / Unknown with the reason, each value with its source. No writes, no nearest-of-two, same answer every run.
2. The old LISP rules from section 2b of that design: a plain line on a pipe layer plus exactly one pipe text in the fixed pattern ("150 DIA. UPVC PIPE AT 1 IN 100 MIN.", "IL 1.10").
3. Made-up test drawings described as data (so tests need no AutoCAD): a current job, an old LISP-style job, a hand-drawn job with no CE tools, a metre-unit job, a job with two pits in reach of one label.
4. A scoring tool that marks a reading against an answer sheet with the five marks in `areas\TRUST_TEST_SET_12NOV.md`.
5. Fix what trust-review finds.
6. (added 12 Nov 23:25, after items 1 to 4 were reported done on draft pull request 2040) The missing half: fill the reader's plain copy from a real drawing, read only. It must NOT set off CE's record update (about 60 ways in): read the stored record and the drawn objects directly, in a read-only pass, and prove with a test that the drawing's changed counter and CE's stored record are untouched. Start only after trust-review has looked at 2040. The nine reach and scoring defaults listed in `trust-reader.md` stay marked "DRAFT default, Tim to confirm" and move to Settings here.

### trust-safety-fixes (code; Civil from cf059dcf, Structural from 8de95c34)
1. Civil: BUG-650, BUG-1274, BUG-1276 (Civil half), BUG-1255 (cause first, fix only on evidence).
2. Structural: BUG-1276 (Structural half), BUG-497, BUG-498, BUG-499, BUG-1275.
3. Fix what trust-review finds.
4. Then one core tool at a time, in ribbon order, from `areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`: for each tool, the open faults marked DATA first. Verify each bug in the installed code before fixing; many entries are stale. Start with PIT, then CD (BUG-680, 681, 683, 874), then CDEDIT.
5. For each core tool: a test that Cancel or Escape at every prompt leaves CE's record exactly as it was.

### trust-core-ribbon (code, Civil and Manager, branch from cf059dcf)
1. Step 2: the two-tab core layout behind a NEW switch, OFF by default; today's layout untouched (card TRUST-02 plus the controller's correction).
2. Step 3 groundwork, read only: compare Tim's own Civil settings file with the colleague starting values and the built-in defaults; list every value that differs, in plain words, values only (no folder paths, no job names), to `areas\trust-run\SETTINGS_DIFFERENCES.md`.
3. Step 3 draft build (card TRUST-03): the office setup file, the "what will change" list, the kept copy of the old file, the CE Health line. New code in new files; in shared settings files add lines only, never reorder, because trust-foundations edits them too. Switch OFF by default.
4. Fix what trust-review finds.

### trust-acad-evidence (AutoCAD and accoreconsole; no code changes to the plugin)
1. The five probes in its brief, results to `areas\TRUST_PROBES_13NOV.md`.
2. Old block versions: make read-only COPIES of the office tool palette block drawings and the old block library drawing named in `areas\TRUST_READER_DESIGN_12NOV.md` section 2b (office drafting folder only, never the Projects folder), open the copies, and list every pit, label, downpipe and tank block name with its attribute names and layers. Results to `areas\trust-run\OLD_BLOCKS_FOUND.md`. No client names: if a block or layer name contains one, describe it generically.
3. A made-up old-LISP-style drawing and a made-up hand-drawn drawing, built in AutoCAD on the patterns in the reader design, saved under `C:\CE_WORK\testset\MADEUP_*` for other lanes to use.
4. For each builder branch that reports "built": evidence WITHOUT installing (accoreconsole with the branch's built files loaded from its own folder, or a second AutoCAD profile that loads from a scratch folder, never the live bundle). If neither is possible, say so plainly; do not install.
5. Outside Tim's hours only. Between 8:10am and 5:30pm on weekdays do accoreconsole work and write-ups only.

### trust-review (read only, plus messages to builders)
1. For every draft pull request opened by a trust lane (find them with `gh pr list --search "trust" --state open --draft` and the lane files): an independent review. Does the test fail without the change? Does the change do only what its card or bug needs? Locked layers, Xrefs and REFEDIT left alone? Cancel leaves everything as it was? Anything that writes when it says it only reads? Software words in anything a drafter sees?
2. Write each review to `areas\trust-run\reviews\<branch>.md` (FOR TIM part first, plain words) with a verdict: GO, FIX FIRST (list), or STOP (why). Send the FIX FIRST list to the builder lane by message.
3. Re-review after the builder says fixed. Never approve your own earlier mistake without re-reading the diff.
4. When no pull request is waiting: review the next unreviewed card or plan document in area TRUST for holes, the way `areas\TRUST_PLAN_REVIEW_12NOV.md` did.

### Refill, Thu 12 Nov 23:45 PC clock (controller)

**trust-core-ribbon, next:**
5. Fix the FIX FIRST list in `reviews\claude-trust-core-ribbon-e13111.md` on pull request 2038 (CDFW and PITSCHEDULE follow the card's recommended answer; keep today's plain tooltips from one place; New Job on AutoCAD 2025 and 2026; the rest as listed).
6. Fix what trust-review finds on pull request 2043 when its review appears in `reviews\`.
7. In `areas\trust-run\SETTINGS_DIFFERENCES.md`, add a FOR TIM part at the top if it has none: the ten differences that would most change what a colleague sees, each with a one-line job example.

**trust-struc-mgr-plan, next:**
4. First trust check of the Structural core tools from records only, in the shape of `areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`, for the 32 KEEP buttons in `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`: to `areas\TRUST_STRUCTURAL_TOOLS_FIRST_CHECK_12NOV.md`.
5. For each Structural claim carried (not verified) in `areas\trust-plan-structural.md`, verify it in the installed code copy (`C:\CE_WORK\scratch\audit_struc`) with file and line, and correct the document.
6. A draft card "what each colleague is running" for Manager (build, AutoCAD year, office setup yes or no, shown to Tim in one place), in the TRUST card shape with Decisions for Tim at the top.
7. Move "Decisions for Tim" to the top of each of your cards, straight after FOR TIM (RULES 2.9: nothing he must decide sits below the technical part).

**trust-test-cases, next:**
4. Redo `cases\TRUST-07.md` against the rewritten card (the LPD is the start point; no new store; Esc carries on with a warning).
5. Settle the three disagreements between `cases\UX-OPEN-01.md` and the build listed in `reviews\cases-UX-OPEN-01.md` and `reviews\claude-trust-01-open-line.md` item 5: follow the card's approved wording; where the card is silent, mark the case RECORD.
6. Cases for the Structural and Manager draft cards TRUST-S1, TRUST-S2, TRUST-S3 and TRUST-M2, same shape as the others.
7. Correct the tool notes that `reviews\core-tool-notes-sample.md` finds wrong, then check the other 39 notes for the same kinds of mistake.

**trust-records, next:**
4. Complete `BUGS_BY_CORE_TOOL.md` where it says "+N more": search `BUG_CARPARK.md` for each of those commands by name in the "Command / Area" lines and add the missing bug numbers and titles. Copy only.
5. The same list for the 32 Structural KEEP buttons in `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`: to `areas\trust-run\BUGS_BY_STRUCTURAL_CORE_TOOL.md`.

### Refill, Fri 13 Nov 00:45 PC clock (controller)

**trust-core-ribbon, next (Structural work now; cut from the installed Structural commit 8de95c34 in a separate worktree branch):**
8. Step S1 as a DRAFT (card `04_REFERENCE\ux-plan\cards\TRUST-S1*`, button list `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`): the Structural tab cut down to the KEEP buttons, laid out roof down, behind a NEW switch that is OFF by default, with today's Structural ribbon provably unchanged when it is off (a test that pins every button). One data list that is easy to change. Draft pull request, never merged.
9. Fix what trust-review finds on re-review of 2038 and 2043, and on S1.

**trust-struc-mgr-plan, next:**
8. One file for Tim: `areas\TRUST_QUESTIONS_FOR_TIM.md`. Gather EVERY open decision from `areas\TRUST_PLAN_INTERVIEW_12NOV.md` (sections C to J and the card decisions), every "Decisions for Tim" in the TRUST cards (Civil, Structural, Manager), every "Defaults taken for Tim to confirm" in the lane status files in `areas\trust-run\` and the nine reader defaults, and every "question for Tim" in `areas\trust-run\reviews\`. Remove duplicates. Order by how much each one changes what gets built. Write each as a tick-box question ready for the question interface: one line of context, the recommended answer first with why, a one-line example on a real job, two to four short options. Group in batches of four related questions. Mark which ones the builders have already built a draft default for. Do not answer any of them.
9. Update `areas\trust-plan-structural.md` for the evidence in `areas\TRUST_PROBES_13NOV.md` and `areas\trust-run\OLD_BLOCKS_FOUND.md` where it bears on Structural or Manager; say "no bearing" if none.

**trust-acad-evidence, next:**
6. A/B evidence, in the core console, for each reviewed builder branch as its fixes land: opening line (2041), step 5 (2045), reader (2040), and the Structural schedule rows (2044, which has a GO for testing on copies). Use the step-by-step checks in `areas\trust-run\cases\`. Say for each check: seen to pass, seen to fail, or could not be run headless.
7. Old jobs are still unread. Make two more made-up drawings from `OLD_BLOCKS_FOUND.md`: one using the old "Stormwater Pit" block with plain-text pit numbers and the old level blocks, and one with the old "DIA. PIPE" blocks; save under `C:\CE_WORK\testset\MADEUP_*` with answer sheets.
8. Undo cases not yet tested: U after two other commands in between; Redo after that U; Edit Pipe; PIT; CD. Outside Tim's hours only where AutoCAD itself is needed.

**trust-reader, add to its items:** the old pit block "Stormwater Pit" (no attributes, layers STORMWATER PIT, PITS HIDDEN, GRATED TRENCH), plain-text pit numbers, the old level blocks COVER LEVEL, INVERT and NEW LEVEL, the old "100/150/225/300 DIA. PIPE" blocks, the old DOWNPIPE block (attribute DP) and old tank blocks (attribute WT): each as a known older version, Proposed with the reason, never Sure.

### Refill, Fri 13 Nov 01:20 PC clock (controller), from the tool notes rewritten out of the code

**trust-safety-fixes, add after its current items (verify each in the installed code first; one small draft pull request each, with a test that fails without the fix):**
6. The forced full record update before the first question (the BUG-650 pattern) still in CDTG, CDSL and CDWT: Esc before a pick must leave CE's stored data exactly as it was.
7. Edit Pipe single Save has no locked-layer or Xref check: refuse with a plain line; never unlock.
8. Esc must cancel, not skip, at the CDWT questions and the CDAGI level questions.
9. CD reports success when a label, level or arrow failed, and CD ignores the answer to "Continues to another plan?" (the breakline is placed on No or Esc).
10. CDMA: Esc must place nothing and the tool must not say "Flow arrow moved" when it did not; CDMA and CDANNOTATIONEDIT must refuse objects that are not CE labels or arrows.
11. CDLPD search distances converted for metre drawings.
12. The start-up checks (read-only drawing, paper space, Structural drawing) missing from thirteen tools: list them, then add the same existing check the other tools use.

13. (added 01:45, from the 64 smaller faults filed as BUG-1297 to BUG-1360) After items 6 to 12, in this order, verifying each in code first: BUG-1337 (CDSTRIP 1000 times too wide in a metre drawing); BUG-1313 (CDRG and CDAGI close the outline within 1 drawing unit, so 1 m in a metre drawing); BUG-1356 (CDRUNSOLVE's preview quotes sizes and grades but Apply writes only inverts: make the preview say exactly what Apply will write); BUG-1352 (CDCALC Charged System and WSUD open pre-filled with sample figures: open blank); BUG-1339 (CDCHECKCURRENT never flags a record with a blank link to its object); BUG-1300 (moving the LPD leaves "LPD" on the earlier pipe); BUG-1334 (MR and CR cannot move or copy pipes drawn on AutoCAD 2027: investigate and report before fixing, because the first colleague is on 2027 and Tim named MR and CR as the first tools on trial).

**trust-acad-evidence, add:**
9. `areas\trust-run\BUGS_FIXED_IN_CODE_NOT_PROVEN.md` (when it appears): about 170 bugs the records list as open that the installed code appears to fix. Start with the ten the file names as mattering most (BUG-650 CDFW cancel, BUG-1255 Excel export, BUG-458 REFEDIT refusal first). For each, on copies, on the INSTALLED build: seen fixed, seen still broken, or could not be tested this way. This is the cheapest trust there is: no new code, only proof. Write results to `areas\trust-run\EVIDENCE_STALE_BUGS.md`. Do not edit the bug file's statuses; the controller does that from your evidence under RULES 13.3.

### Refill, Fri 13 Nov (after the reader's second run), controller

**trust-acad-evidence, add:**
10. The reader on real drawing files, in the core console, without installing: build `claude/trust-reader` (draft pull request 2040) in your own folder, and follow the P3 steps the reader lane put in `PENDING_TESTS.md`: run its read-only copy-filler and reader on your made-up drawings in `C:\CE_WORK\testset\MADEUP_*` (old LISP style, hand-drawn, the old "Stormwater Pit" block) and on the standard test copies. For each: is the drawing unchanged afterwards (changed counter and file hash), is the reading identical on a second run, and does the reading match the drawing's answer sheet (use the branch's scorer). Results to `areas\trust-run\EVIDENCE_READER.md`.

**trust-review, next run:** re-review pull request 2040 at its new head (the eight items in `reviews\claude-trust-reader.md`, plus the new copy-filler and old-palette commits ab4fc1f7 and 222a303e); then an independent review of ten of the rewritten tool notes in `04_REFERENCE\core-tool-notes\` against the code.

### Refill, Fri 13 Nov 01:45 PC clock (controller)

**trust-struc-mgr-plan, next:**
10. At the very top of `areas\TRUST_QUESTIONS_FOR_TIM.md`, as batch 0, add the ONE question the whole run is now waiting on, with the evidence: several things cannot be seen without the trial build loaded in real AutoCAD (the opening line, Edit Pit's line, every window, the ribbon, Undo on the new builds, all Structural fixes; see `areas\trust-run\EVIDENCE_BRANCHES.md` FOR TIM item 5). Loading it means installing it. Options to put, recommendation first: (a) the robot may install a trial build on Tim's PC only between 5:30pm and 8:10am, test on copies, and put back exactly what was there (Civil 3.0.90, Manager 1.1.89, Structural 1.0.126, checked file by file) before 8:10am, every night until told otherwise; (b) only on a separate test PC or the virtual machine, never on his PC; (c) not yet. Say what each costs him. Do not answer it.
11. Keep that file current: add the reader lane's 35 draft defaults (`areas\trust-run\trust-reader.md`), the "where confirmed is kept" default for the LPD, and every new "Defaults taken for Tim to confirm" line in the lane files since you wrote it. Keep the count in FOR TIM right.
12. A second trust check of the 47 core tools, now that better evidence exists: `areas\TRUST_CORE_TOOLS_SECOND_CHECK_13NOV.md`, same shape as the first check, built from the rewritten tool notes (`04_REFERENCE\core-tool-notes\`), `areas\trust-run\BUGS_FIXED_IN_CODE_NOT_PROVEN.md`, the new faults BUG-1280 to BUG-1360 (grep the bug file by number), `areas\TRUST_PROBES_13NOV.md` and `areas\trust-run\EVIDENCE_BRANCHES.md`. For each tool: which trust boxes are now known to pass, known to fail (with the bug number), or still never checked; and the single next thing that would move it forward. FOR TIM first: the ten tools closest to passing all five rules and what each still needs.

**trust-acad-evidence, add:**
11. Find out, without changing anything, every way a trial build could be seen in real AutoCAD WITHOUT touching Tim's installed bundle or any AutoCAD or Windows setting: read `C:\CE_PLAN\04_REFERENCE\TEST_STATION_SETUP.md`, `C:\CE_PLAN\TEST_STATION_REQUESTS.md` and `TEST_STATION_RESULTS.md` (is the virtual machine test station still alive, and how is a request made), and the driver's own notes. Write the options, what each needs from Tim, and your recommendation to `areas\trust-run\HOW_TO_SEE_TRIAL_BUILDS.md`. Do not install, do not change a setting, do not send a request anywhere.

### Refill, Fri 13 Nov 02:45 PC clock (controller)

**trust-struc-mgr-plan, next:**
13. In `areas\TRUST_QUESTIONS_FOR_TIM.md` batch 0, change the recommended answer to the spare work PC (Tim's own ruling D5 of 17 Oct; it needs his one-off 30 minutes with `04_REFERENCE\TEST_PC_START_PROMPT.md`), with overnight installs on his own PC as the second option and its cost stated ("a mistake costs you a morning"). Evidence and reasoning: `areas\trust-run\HOW_TO_SEE_TRIAL_BUILDS.md`. Say plainly that the controller first recommended overnight installs and changed its mind on this evidence.
14. The Structural core tools read from the installed code, the way the Civil ones were: for each of the 32 KEEP buttons in `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`, a one-page tool note at `04_REFERENCE\core-tool-notes\structural\<COMMAND>.md` in the format of `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3, written from `C:\CE_WORK\scratch\audit_struc` (commit 8de95c34), every fact with its file and line under "Where this comes from", "not known" where not known. Avoid the three kinds of mistake found in the Civil notes (`areas\trust-run\reviews\core-tool-notes-second-sample.md`): a bug called fixed that is not; an on-screen message quoted from the wrong route; a claim about AutoCAD 2022 to 2024 with no line behind it. Quality over count. From it produce `areas\trust-run\STRUCTURAL_BUGS_FIXED_IN_CODE_NOT_PROVEN.md` (candidates from `areas\trust-run\BUGS_BY_STRUCTURAL_CORE_TOOL.md`) and a list of new faults with no bug, `areas\trust-run\STRUCTURAL_NEW_FAULTS_TO_FILE.md` (do not edit `BUG_CARPARK.md` yourself; the controller has them filed).

**trust-acad-evidence, next (real AutoCAD only until 8:10am, then core console and write-ups):**
12. Carry on with item 9 in real AutoCAD on the INSTALLED build: BUG-683, 681, 290, 968, 674, 780, 785, 756 and 969, each on its own fresh copy. For BUG-650 (seen fixed): repeat it once in a SECOND AutoCAD session and record both, because a robot result only counts toward acceptance when seen in two sessions (RULES, 24 Oct amendment).
13. Clear the scratch you made tonight that is no longer needed (`%LOCALAPPDATA%\Temp\ce-headless-proof` and any other temp build copies that are YOURS, about 10 GB in all): C: is at 37 GB. Never delete a folder you did not create.

### Refill, Fri 13 Nov 03:45 PC clock (controller)

**trust-foundations, next:**
7. The root of tonight's "Esc still rewrote things" findings, as its own small draft (you own `Services\ProjectDataService*.cs`): (a) the list of 16 commands that save CE's stored record at the command's end even when nothing is waiting: a cancelled command must write nothing, and a command that never bound the record to the current drawing (CDHELP and CDS are named by the reviewer) must never write at all; (b) `MarkDrawingActive` and the source placing code's filling-in of pipe identities (`SourcePlacementService.cs` about line 146) writing before the first accepted answer. One rule, shown by tests through the real code path and a deliberately faulty version: nothing is written before the first accepted answer, and nothing at the end of a cancelled command. Behind a switch, OFF by default. Coordinate with trust-safety-fixes by message so its cancel fixes (pull requests 2053, 2055) sit on this, not beside it. Real evidence to design against: `areas\trust-run\EVIDENCE_STALE_BUGS.md` (cancelled CDFW) and, when it appears, `areas\trust-run\EVIDENCE_CROSS_DRAWING.md`.
8. Fix what trust-review finds on 2058 (step 7) and 2051.

**trust-struc-mgr-plan, next:**
15. Your 32 Structural tool notes are about to be sampled by trust-review; fix what it finds when `reviews\structural-tool-notes-sample.md` appears.
16. A Structural "step S0": what would have to be read-only checked when a Structural drawing opens, in the spirit of the Civil opening line (card UX-OPEN-01), written as a DRAFT card with Decisions for Tim at the top. Use your 104 findings to say which hidden changes a Structural drafter is exposed to today.

### Refill, Fri 13 Nov 04:45 PC clock (controller)

**trust-core-ribbon, next (Structural, branches cut from 8de95c34):**
10. BUG-1363 with card TRUST-S3: when the schedule gives a size the support block (C1, C2, DS, DS1, TS1) cannot show, do not draw the default size while naming the schedule size. Draft default: stop and say plainly which size the block cannot show and what the choices are; never draw a size different from the one named. Engineering judgement, so behind a switch OFF by default, and listed for Tim.
11. BUG-1365: beam tools 1, 2, 4 and 5 refuse every beam with "CE hit an internal problem" when the beam or text layer is locked, off or frozen: a plain refusal that names the layer and what to do; nothing is unlocked or thawed.
12. BUG-1362: the A/B switch must not erase the old brace until the new one is drawn (one step, so one U), and must never say "It was left as it was" when it was not.

**trust-struc-mgr-plan, next:**
17. Draft the morning page for Tim: `areas\TRUST_MORNING_BRIEF_13NOV.md`. One screen, phone-readable, FOR TIM only, no technical part: what ran overnight in five lines; the three things proven in real AutoCAD (from `areas\TRUST_PROBES_13NOV.md`, `areas\trust-run\EVIDENCE_BRANCHES.md`, `EVIDENCE_STALE_BUGS.md`, `EVIDENCE_READER.md`); the tally of draft pull requests by verdict (count the latest verdict per pull request in `areas\trust-run\trust-review.md`); the three faults found that matter most to a drafter; what is NOT done or not proven; what was NOT touched (his installed versions, colleagues, the shipped lines); and the ONE decision that unblocks the most (batch 0 of `areas\TRUST_QUESTIONS_FOR_TIM.md`). Every number must be read from a file, with the file named in a short "where these numbers come from" list at the very end. Mark it DRAFT; the controller checks and finishes it before 8am.
18. Bring `areas\TRUST_QUESTIONS_FOR_TIM.md` up to date again with every "Defaults taken for Tim to confirm" written in the lane files since 01:45, and the reader's new questions (how far from a pipe end the old tool wrote its IL text; loose pipe text with unrecognised wording).

**trust-acad-evidence, next:** the two-drawing test for CDHELP and CDS (sent as top priority at 03:12, still not written up) comes before everything else; then the second-session repeat of BUG-650; close the AutoCAD you started by 8:10am.

### Refill, Fri 13 Nov 05:25 PC clock (controller)

**trust-core-ribbon, next (Structural, each its own small draft cut from 8de95c34, a test that fails without the fix, read the bug entry first):**
13. BUG-1361: a schedule sync with no edits must change nothing in the drawing: no brace turned again, no length or angle rewritten at table rounding. Engineering figures on a drawing: list anything you have to assume as a decision for Tim.
14. BUG-1424: typing B over A in the bracing table changes the text only; the brace stays on layer A and plots as A. Draft default: the table edit and the brace must agree, or the edit is refused with a plain line.
15. BUG-1442 and BUG-1447: CLEAN must not drop a whole step silently when one object is on a locked layer (say which step was skipped and why; unlock nothing), and say truthfully what copy exists from before the clean-up.
16. Fix what trust-review finds on 2068, 2069 and 2070.

**trust-struc-mgr-plan, next:**
19. One status board for Tim, `areas\trust-run\STATUS_BOARD.md`, rebuilt from the files each time you check in: every trust draft pull request (number, plain name of what it does on a drawing, latest review verdict and head from `trust-review.md`, what real AutoCAD evidence exists from the EVIDENCE files, what is still owed), grouped by plan step, newest verdict wins. Numbered lists, no tables, FOR TIM first with the counts. Count from the files; never estimate. Keep it current at every check-in until told otherwise.
20. Bring the morning page `areas\TRUST_MORNING_BRIEF_13NOV.md` up to date for BUG-1456 (seen on the installed build; `areas\trust-run\EVIDENCE_CROSS_DRAWING.md`; bug entry at the end of `BUG_CARPARK.md`): it is the FIRST item, with the two safe habits, and the page must say plainly that the fix is drafted, reviewed FIX FIRST, and not installed.

### Refill, Fri 13 Nov 06:15 PC clock (controller)

**trust-core-ribbon, next (Structural, each its own small draft cut from 8de95c34, read the bug entry first, a test that fails without the fix through the real code path):**
17. Fix the three items in the review of 2070 (`reviews\claude-trust-b1363-support-size-unknown.md`): never print a size the symbol does not show; never tell the drafter to edit the member schedule to suit a symbol.
18. BUG-1364: BDL has no units handling (its 50 minimum, 100 offset and 250 search are read as metres in a metre drawing).
19. BUG-1389, BUG-1390, BUG-1391: BSET and BSETLIST say success or "none stored" when the store failed; BSETRESET clears every inside point with no question; BSET and BSETRESET have no read-only, layout tab or in-place reference-edit check.
20. BUG-1369 and BUG-1370 are engineering judgement (older-named braces counted as zero; braces on frozen or off layers still counted): do NOT change any total. Instead make the bracing panel SAY what it left out or counted that a drafter might not expect, in one plain line each, and list both rules as decisions for Tim.
21. Fix what trust-review finds on 2071, 2072 and 2074.

### Refill, Fri 13 Nov 06:45 PC clock (controller)

**trust-foundations, next:**
9. YES to the door you found: a tool that changes CE's record while a drawing it never attached is current changes the OTHER drawing's record in memory, and 2073 then keeps that save for the other drawing. Close it where the record is changed (your files): a change is refused, with one plain log line, when the record in memory does not belong to the current drawing. Its own small draft on top of 2073, no switch, tests through the real code path with a deliberately faulty version, and a case showing a real change in the right drawing is never refused.
10. Fix what trust-review finds on 2064 (at 9d44a9c0) and 2078.

**trust-safety-fixes, next (verify each in the installed code first; one small draft each; a test that fails without the fix through the real code path; read the build lock's time before every build):**
14. BUG-1334: go ahead with your fix (c), the plain pre-check, as a draft: Move and Rotate and Copy and Rotate must either move a pipe drawn on AutoCAD 2027 correctly or refuse it in plain words naming the object; never a code word; nothing unlocked or bypassed.
15. BUG-1316 (CDWT by its window loses the library tank details), BUG-1318 (erasing the highest-numbered source and placing another reuses its number), BUG-1320 and BUG-1321 (CDTAG: retag with No to the label leaves the old label text; a retag snaps a nudged connection point back), BUG-1346 (CDFEEDBACK loses a typed report when the save fails), BUG-1358 (CDRULES adds its whole findings list to the drawing every run with nothing trimming it).
16. BUG-1352 stays deferred for Tim. BUG-1337 and BUG-1275 stay blocked; keep their reasons current in your status file.

**trust-acad-evidence, next:** finish the tab-switch and other-commands runs for BUG-1456, close the AutoCAD you started by 8:10am and write that it is closed; then (core console, any time) pull request 2073's check, then 2078 when it has GO.

### STANDING REFILL, Fri 13 Nov 11:35 PC clock (controller): builders refill themselves

Two lanes sat idle for two hours this morning waiting for the controller. From now on a builder with an empty queue does NOT wait:

1. **trust-safety-fixes:** when your queue is empty, take the next five unfixed faults yourself from `areas\trust-run\BUGS_BY_CORE_TOOL.md`, section "Added 13 Nov from the code read" (BUG-1297 to BUG-1360), the ones marked HIGH or that lose or hide data first, then in ribbon order. Verify each in the installed code first; one small draft each; a test that fails without the fix through the real code path. Write the five you took in your status file before starting. Skip anything that changes an engineering figure: list it for Tim instead.
2. **trust-core-ribbon:** the same from `areas\trust-run\BUGS_BY_STRUCTURAL_CORE_TOOL.md`, section "Added 13 Nov from the code read" (BUG-1361 to BUG-1455), HIGH first. Never change a bracing total, a size or a schedule figure: where the fault is a wrong figure, make the tool SAY what it did and list the rule for Tim.
3. **trust-foundations:** after your assigned items, the next item is always the review lane's newest FIX FIRST on your pull requests; then the next "not covered, why" line in your own step 5 and step 6 pull requests.
4. **Every builder:** review fixes on your own pull requests come before new work. Five new drafts at most between check-ins, so the review lane can keep up.
5. **trust-acad-evidence:** today your only job is `areas\trust-run\INSTALL_TRIAL_13NOV.md` until its end state is proven.

### trust-struc-mgr-plan (planning only)
1. `areas\trust-plan-structural.md` and `areas\trust-plan-manager.md` (its brief).
2. Draft cards, in the TRUST card shape, for the first three Structural steps and for "going back a version, rehearsed" in Manager.
3. The Structural core tick list turned into a keep / hide sort like `areas\CIVIL_COMMAND_SORT_06NOV.md`, with the questions only Tim can answer.

### trust-test-cases (documents only)
1. For each card UX-OPEN-01 and TRUST-02 to TRUST-08: the robot cases written out step by step (what to open, what to type, what to read back, what "right" is), each with its deliberately faulty partner that must fail, to `areas\trust-run\cases\<card>.md`.
2. For each card: the short brief for the look that must be done by eye in AutoCAD (what to look at, what right looks like).
3. One-page tool notes, DRAFT, for the core tools in ribbon order, in the format in `areas\TRUST_RULES_CHECKLIST_12NOV.md` section 3, to `04_REFERENCE\core-tool-notes\<COMMAND>.md`. Facts from the installed code and the records only; "not known" where not known.

### trust-records (mechanical, documents only)
1. In `areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`: look up the eleven bug numbers with no title (686, 685, 674, 677, 680, 681, 683, 693, 691, 692, 690) in `BUG_CARPARK.md` and report each one's title and status line to `areas\trust-run\trust-records.md`. Do not edit the first-check file.
2. Scan every file in area TRUST (the `TRUST*` and `trust-*` files in `areas\`, and the TRUST cards) for: tables; paragraphs longer than three lines in the FOR TIM parts; the words on the reviewer's jargon list in `areas\TRUST_PLAN_REVIEW_12NOV.md`; lines that still say OPEN for a question answered in `areas\TRUST_PLAN_INTERVIEW_12NOV.md`. Report file and line; change nothing.
3. Build `areas\trust-run\BUGS_BY_CORE_TOOL.md`: for each of the 47 core commands, the open bug numbers and their one-line titles from the carpark index. Copy, do not judge.

## PROVE, DON'T DRAFT (Tim, Sat 14 Nov 2026 00:22). Replaces every queue and refill above.

Rule text: `areas\TRUST_AUTONOMOUS_RUN_12NOV.md`, last section. No lane starts a new draft. One tool at a time, in this order. **DRAFT order by the controller, for Tim to replace with his own ten:**

1. **Two jobs mixed up (CDHELP, CDS; BUG-1456).** Installed and robot-proven on Tim's PC. Left: Codex look, Tim's acceptance. Owner: controller.
2. **CLEAN and FASTSAVE (BUG-1457).** Draft 2094, GO with five fixes. Owner: trust-core-ribbon (fixes), trust-acad-evidence (see it on scratch copies).
3. **CDLPD (BUG-1298).** Draft 2099, GO with two fixes. Owner: trust-safety-fixes, then evidence.
4. **CDRUNSOLVE (BUG-1355).** Draft 2092, FIX FIRST. Owner: trust-safety-fixes, then evidence.
5. **Edit Pit (changes on Cancel, made-up values).** Existing drafts only (2064 and the step 6 draft 2049). Owner: trust-foundations, then evidence.
6. **Pit Schedule (plastic pits left out, BUG-1274; Export CSV, draft 2107).** Owner: trust-safety-fixes, then evidence.
7. **Renumber (BUG-968).** Seen fixed on the installed build. Left: Codex look, Tim's acceptance.
8. **Floor waste tool (BUG-650).** Seen fixed on the installed build. Left: Codex look, Tim's acceptance.
9. **Structural bracing schedule (BUG-497, 498, 499).** Existing drafts only. Owner: trust-core-ribbon, then evidence.
10. **Structural supports linked to beams (draft 2096, FIX FIRST).** Owner: trust-core-ribbon, then evidence.

**Lanes now:** builders work only on the review fixes for the tool in hand (items 2 to 4 first), in their Sat 14 Nov 08:00 slot. trust-acad-evidence sees each one on scratch copies when its fixes are in. trust-struc-mgr-plan: one board rebuild a day at 6:00pm, showing these ten first. Reader, test-cases, records helpers: stopped. Review helper: only for a changed head of the tool in hand.

## THE TEN, ANSWERED BY TIM (Sat 14 Nov 2026 00:28 PC clock). Replaces the controller's draft order above.

**Tim's answers.** The ten: "Yes, use that ten (Recommended)" (option text: "Work through them in job order, one at a time. You can swap any later."). Installs: "One batch, ask me once (Recommended)" (option text: "I gather the fixes the robot has seen working into one install, show you the list, and install only on your yes. Backup first, outside your hours.").

1. **PIT** (place a pit)
2. **CD** (draw a pipe)
3. **CDLPD** (legal point of discharge): draft 2099, GO, two review fixes under way
4. **CDEDIT** (edit a pit or pipe): existing drafts 2064 and 2049
5. **CDRUNSOLVE** (solve inverts down a run): draft 2092, FIX FIRST, fixes under way
6. **CDRENUMBER**: BUG-968 seen fixed on the installed build
7. **PITSCHEDULE**: BUG-1274 draft; Export CSV draft 2107, GO
8. **CDRULES with CDCALC**
9. **CDCHECKCURRENT** (check this drawing, as the status line)
10. **MR** (move and rotate)

**Safety fixes outside the ten, first because they can lose work:** two jobs mixed up (installed, robot-proven, not accepted); CLEAN / FASTSAVE over a template (draft 2094, GO, fixes under way).

**Install rule:** nothing goes onto Tim's PC as it is proven. The controller gathers what the robot has SEEN working on scratch copies into ONE batch, shows Tim the list, and installs only on his yes for that batch (backup first, outside his hours).

Why this ten and what each must meet: `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md`.

## ACCEPTANCE FOR THE TEN, ANSWERED BY TIM (Sat 14 Nov 2026, about 16:05 PC clock)

The controller asked: "shall I count robot PASS plus Codex PASS as accepted for the ten, as per your 20 Oct rule?" Choices: Yes (recommended) / No, I want to see each one myself.

Tim's answer, in his word: **"yes"**.

What this means (RULES.md 13.3 as amended 20 Oct, unchanged): a tool of the ten, or a safety fix beside them, is written "FIXED (Codex-accepted, build, date)" only when a robot PASS and a Codex PASS in real AutoCAD both exist on the installed build, each with its screenshot or log. A robot PASS alone is still "seen working", not accepted. Items needing engineering judgement still need Tim's word. Tim spot-checks by exception.

## CDRUNSOLVE DESIGN FLOWS, ANSWERED BY TIM (Sat 14 Nov 2026, about 16:20 PC clock)

Found: on Civil 3.0.90.3 CDRUNSOLVE never writes a level, because every pit is handed a design flow of 0 (`ProposalApplyService.PlanBuilders.cs` line 789 at 11c0093c; the robot saw "none of them has a design flow yet").

The controller asked what CDRUNSOLVE should do about design flows: 1. take each pipe's flow from CDCALC's results (recommended; says "run CDCALC first" when there are none); 2. solve levels on fall and cover only; 3. leave it for now.

Tim's answer, in his words: **"do as you recommend"**. So: option 1. CDRUNSOLVE reads the flows CDCALC already worked out (one place for the sum, never its own copy), and when there are none it changes nothing and says to run CDCALC first. Unknown stays Unknown: no flow is ever made up. Built on the existing draft 2092, no new draft; goes in the next batch, which needs Tim's own yes to install.

### Correction, Sat 14 Nov 2026 about 16:35: option 1 cannot be built as worded

The builder stopped at step 1: CDCALC saves catchments with a flow each and one site total, but no catchment is tied to a pit or pipe, so there is no per-pipe flow for CDRUNSOLVE to read (controller checked: no pit or pipe id in `CalculationWorkspaceData`). The only per-pipe design flow in the CE record is the Q the drafter types in Pipe Edit (`PipeData.DesignFlowLps`).

**Controller's DRAFT default, NOT Tim's answer** (built under his 9 Oct rule that builds do not wait on him, and his 14 Nov "you do what you need to, to keep things moving"): CDRUNSOLVE reads the Q each pipe already has from Pipe Edit. No Q on any pipe: nothing changes, it says to enter the design flow in Pipe Edit. Q on only some: names the pipes without one, nothing changes. Tim's answer replaces this the moment he gives one.

Logged as a later idea, not built: CDCALC gains a "drains to pit" link on each catchment so flows can come from CDCALC, which is what Tim's option 1 meant. That is new CDCALC work, not a fix.

## NO WAITING ON TIM (his word, Sat 14 Nov 2026, 23:2x PC clock)

Tim: "yourloops shouldnt rely on me answering things to keep moving sometimes i wont be around then what"

Controller's reading (mine, not his words), in force from now:

1. **An open question never stops the run.** Each question is asked once with a recommended answer. If Tim has not answered by the next check, the recommended answer is used as a DRAFT default, labelled as the controller's, and his later answer replaces it.
2. **Defaults now in use:** (a) CDRUNSOLVE design flow = the Q typed in Pipe Edit. (b) Where the robot cannot make a pick, a Codex PASS with screenshot plus a before-and-after check of CE's record is written "PROVISIONAL (awaiting Tim)" and shown as its own count; it is NOT written FIXED and not added to "accepted" until Tim says so.
3. **Still only on Tim's word, each time, unless he gives a standing word:** installing on his PC; merging into shipped lines; anything to colleagues. Asked of him 14 Nov: a standing yes for trial installs when AutoCAD is closed and he is away.
4. **While an install waits, the tool in hand moves on.** Every one of the ten is run by the robot and Codex on the build already installed, on scratch copies, outside his hours; fixes go on existing drafts; the next batch is built and reviewed so an install is one step.
5. **Still no new drafts** (prove, don't draft).

## THREE ANSWERS FROM TIM (Sat 14 Nov 2026, about 23:25 PC clock)

Tim: "1. yes 2. yes 3. yes you have my approval to do it whenever you want to"

Answering the three questions put to him at 23:18 (controller's reading of which question each number answers):

1. **CDRUNSOLVE design flow = the Q typed in Pipe Edit, for now.** ANSWERED yes. No longer a controller default.
2. **Where the robot cannot make a pick, a Codex PASS (with screenshot) plus a before-and-after check of CE's record counts as accepted.** ANSWERED yes. Written "FIXED (Codex-accepted, record-checked, build, date)". Engineering-judgement items still need Tim.
3. **Trial installs on his PC: standing approval.** ANSWERED "yes you have my approval to do it whenever you want to". Controller's reading (mine): covers trial batches of the ten-tool work on his PC, with the controller choosing the time. Kept by the controller as its own care, not as Tim's conditions: AutoCAD closed and not his (re-read autocad.json), outside his weekday hours, backup first, SHA-256 check after, put-back script ready, a line to Tim after each install. It does NOT cover merging into shipped lines or anything to colleagues.

## FIX THEN TEST (Tim, Sun 15 Nov 2026, about 00:20 PC clock)

Tim, asked whether all the foundation fixes were made: "why cant we make the fixes then test?"

Controller's reading (mine): with his standing approval for trial installs, drafted and reviewed fixes no longer wait tool by tool. They go onto his PC in trial batches and are tested in real AutoCAD by the robot and Codex; a batch that fails is put back. Batch 3 widened to: the mix-up layers (2089, 2090, 2100), the PITSCHEDULE fixes, 2064 with the Edit Cancel hold (switch off as shipped), and the reviewed-GO foundation drafts of steps 0, 1 and 5. Ribbon and same-settings-for-everyone stay out. Still no new drafts, no merge into shipped lines, nothing to colleagues. The count Tim sees stays "accepted of 10".

## WORK AUTONOMOUSLY, QUEUE FOR TIM (Tim, Sun 15 Nov 2026, about 01:40 PC clock)

Tim: "i want you to work autonomously so dont get bogged down by waiting for me, just queue stuff for me and continue loops as necessary"

In force: (1) the controller checks every two hours, not twice a day, and acts on each check; lanes are never left idle. (2) Everything that is Tim's to decide goes to `areas\trust-run\FOR_TIM_QUEUE.md` with a recommended answer used as a labelled default. (3) Unchanged and still only on his word: merging into shipped lines, anything to colleagues, a new screen without a mock-up. Still no new drafts.

## THE FINISH LINE FOR COLLEAGUES (Tim, ask chat, Sun 15 Nov 2026 01:57 PC clock)

Recorded in full, in his words, in `areas\trust-run\TIM_INTERVIEW_15NOV.md` (8.1, 9.1, 10.1). The controller now works to this:

1. **Ready for colleagues = all three:** the ten tools accepted; five clean working days on Tim's PC; one real council stormwater job done start to finish on CE alone with nothing fixed by hand. Stricter than the 17 Oct wording, and newer.
2. **CE never, by itself:** changes a level or size, renumbers pits, moves or deletes his labels, changes layers or colours. Every batch's review and robot list checks the batch against these four.
3. **What matters most:** nothing wrong reaches council.

## THE FINISH LINE FOR COLLEAGUES, WIDENED (Tim, ask chat, Sun 15 Nov 2026 02:16 to 02:18 PC clock)

Tim, typed: "lets get the entirety of civil and manager working as we intend only then can we release to colleagues". His four clicks pinning it down are in `areas\trust-run\TIM_INTERVIEW_15NOV.md` section 8.3, which is the current answer. This replaces the 01:57 section above where they differ, and supersedes the colleague-release half of the 5 Nov small-core decision. Relayed to the controller by the ask chat; the controller adopts it because it only makes release stricter and enables no action.

1. **Civil:** every tool on the Civil ribbon seen working in AutoCAD, not only the ten.
2. **No small-core release.** Colleagues keep the CE they have until the whole is ready, then one release.
3. **Manager:** everything in the Manager plan (sending, taking back, the dashboard of every PC, the office setup check, the you-are-behind notice).
4. **On top:** five clean working days on his PC and one real council stormwater job start to finish on CE alone (may overlap).
5. **Controller's reading (mine):** the ten stay the ORDER OF WORK and the first number reported. After the ten, the same method (fix, install, robot and Codex, accept) carries on through the rest of the Civil ribbon and Manager. "Prove, don't draft" still holds: fixes on existing drafts; a new draft only where a ribbon tool has a seen fault and no draft exists, and that widening is put to Tim before it starts. Not asked: Structural. Not answered: which switched-off features come on.

## AUTOCAD 2027 ONLY FOR NOW (Tim, ask chat, Sun 15 Nov 2026 02:27 to 02:28 PC clock)

Tim typed "autocad 2027 only for now", then clicked "Stop work on older years" (2022 to 2024). His words and the ask chat's three points of care: `areas\trust-run\TIM_INTERVIEW_15NOV.md` section 11 (Q56 and its follow-up). Relayed to the controller by the ask chat.

**Controller's reading (mine), in force for the trust run:**
1. **No work is spent on 2022 to 2024:** no fixes for them, no tests on them, no proof asked of them. Proof is on AutoCAD 2027 only. Colleagues on older years keep the CE they have.
2. **The batch build is NOT changed tonight.** The existing installer build makes all three sets of files (Legacy, Net8, Modern) in one go, and the install scripts check all three and that CE_SHARED matches Manager. Taking two sets out means changing a build script, which needs Tim's explicit approval under the repo's own rules, and what a bundle with those sets missing or stale does on his PC is unchecked. So the three sets keep being produced by the same script, at no extra effort, until that is looked at.
3. **Not changed by anyone:** the plugin repo's `AGENTS.md` and `START_HERE` 1b still say both builds are required. That text is now older than Tim's ruling; whether to change it is his call. In FOR_TIM_QUEUE as a new item.

**Update, Sun 15 Nov 2026 02:32 (Tim, queue item 10, ask chat):** he clicked "Take them out of the build" and "Yes, match what I said" for the rule text; his chosen option says the check of what his own PC does with a bundle missing the older-year files comes first. So point 2 above (build unchanged) was the controller's default and is now replaced by his answer, in this order: (1) read-only plan `areas\trust-run\BUILD_2027_ONLY_PLAN.md` (fix lane, after batch 5); (2) trial on his PC with put-back, seen in AutoCAD 2027; (3) only then a 2027-only batch, the build change and the rule-text change as one draft pull request made on his order. Until step 2 passes, batches keep all three sets. Also from the same batch: the five trust rules are the gate, exceptions signed by him by tool name; rule 4 "used on real drawings" = robot on copies of real jobs is enough; WHICH past jobs may be copied is not answered, is client data, and is his to name (the Projects folder stays unopened).

## REAL FINISHED JOBS MAY BE COPIED (Tim, to the controller directly, Sun 15 Nov 2026, about 10:30 PC clock)

The controller asked him in its own chat: "may I copy finished jobs from the office Projects folder?" with the conditions listed. Tim: "yes". (He had already chosen "Yes, any finished job" three times in the ask chat; the controller held it until he said it here, because it lifts his own earlier word never to open that folder.)

**What it covers, and only this:**
1. **Copies only**, made onto his PC under `C:\CE_WORK\realjobs\`, outside every repo and outside OneDrive. Nothing is ever written back to the Projects folder; it is opened to read and copy only.
2. **Coded names** (JOB_A, JOB_B ...). No client name, address or job number in any file name, folder name, log, note, screenshot name, commit or message. The key that says which job is which code stays in one file on his PC beside the copies, never in a repo, never in CE_PLAN.
3. **Finished jobs only**, never live ones.
4. **Used for:** the robot and Codex running CE tools on the copies, and the reading-only study of how old drawings are made (Civil and Structural). Running Structural tools on the copies was not asked.
5. **Care the controller adds (its own, not Tim's words):** the copied drawings still carry the client's title block inside them, so screenshots of them stay on his PC and are not put in CE_PLAN or any repo unless cropped clear of the title block; findings are written as patterns, never with a client's details.
6. **Not covered:** `C:\CE_DrawingIntelligence` stays unopened; live jobs; sending anything anywhere.

## CODEX ALONE IS FINE (Tim, to the controller directly, Sun 15 Nov 2026, about 14:37 PC clock)

The controller had asked: "Should a tool count as accepted on robot plus Codex alone, or only after the real-job run? I am holding to the real-job run." Tim: "codex alone is fine".

**The controller's reading (its own words, not Tim's):**
1. A tool is counted **accepted** when Codex has seen its whole everyday job pass in real AutoCAD on the installed build (Cancel, Esc, do the job, one Undo, save and reopen), with screenshots and a report the controller has checked itself. A robot pass is welcome but not required. The real-job copy run is not required for the count.
2. **Not changed:** the finish line for colleagues still wants one real council stormwater job on CE alone, five clean working days, the whole Civil ribbon and Manager. Real-job copy runs carry on as tests. Faults (BUG_CARPARK) keep their own rule.
3. **Care the controller keeps:** a tool with a part of its everyday job not yet seen (for example Edit Pipe Save inside CDEDIT) is not counted until that part is seen. If Tim meant something narrower or wider he will say so; the count is easy to take back.

**Counted on this reading, Civil 3.0.90.10:** PIT (Codex TPIT14 5 of 5, robot 5 of 5), CD (Codex TCD14 5 of 5, robot 5 of 5). **Held:** CDEDIT (Edit Pipe Save not tried), PITSCHEDULE (every step passed but over two runs, on a two-pit drawing with no pipes; one clean run on a drawing with pipes wanted first).

## BUILD NEW PIPE (Tim, to the controller directly, Sun 15 Nov 2026, about 14:37 PC clock)

The controller had written: "New Pipe one-page window: you OK'd the picture. Say 'build New Pipe' if you want it built." Tim: "build New Pipe".

**What it covers (controller's reading):**
1. Build the New Pipe one-page window to the picture he OK'd on 15 Nov (`04_REFERENCE/mockups/NEW_PIPE_DIRECTION_TICK_EDIT_PIT_15NOV.html`, "OK as shown"), following his UI rules file. This is his order for one new draft for this one screen; prove-don't-draft stays for everything else.
2. The present New Pipe window stays as the working path until the new one has been seen working in AutoCAD; the new one sits behind a switch.
3. Before any install: a real render of the built window beside the picture, differences listed, shown to Tim. It then goes onto his PC in a trial batch under the standing trial approval and is tested (Cancel, Esc, draw, one Undo, save and reopen).
4. **Not covered:** merging into shipped lines, colleagues, any other new screen.
