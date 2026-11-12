# Area TRUST: a plugin you can trust (the full plan)

**Status: PROPOSAL, written Thu 12 Nov 2026 by chat CE_ACAD / trust plan / plan / 01.** Nothing here is built, tested, installed or accepted. The HOLD stands: no builds, installs or colleague releases until Tim lifts it himself.

**What is decided (Tim's words, `decisions\2026-11-05_TIM_PLUGIN_STRATEGY_TALK.md`):** a small core for colleagues; Civil first; the pilot date is off; "I want something that works. If it's going to take time to make that happen, then let's take the time."; the first colleague release waits for Check this drawing; testing goes Codex on a test set, then Tim on real jobs for about 3 days, then colleagues; two always-visible tabs, CE Drainage and CE Design; CE tools stay available on every drawing; card UX-OPEN-01's three decisions.

**What is NOT decided:** everything marked OPEN in `areas\TRUST_PLAN_INTERVIEW_12NOV.md`. Each step below says which open questions it waits on.

**Where this sits in the one plan:** this file is area TRUST in `MASTER_PLAN.md` section B. It replaces `areas\V3_TRUST_PLAN_06NOV.md` as the working plan; that file stays as the 6 Nov proposal and evidence. It is not a second plan (RULES 9.1).

---

# FOR TIM

**Eight steps, safest first. One step at a time. You approve each card before any code. Colleagues get nothing until step 8 has passed on about 10 real past jobs and you have had three clean days on it.**

```mermaid
flowchart TD
    A[1 Open line: read only] --> B[2 and 3 Core ribbon, same settings for all]
    A --> C[4 Safety fixes]
    A --> D[5 Sync made visible]
    D --> E[6 Guesses removed, Unknown shown]
    E --> F[7 Start point confirmed and stored]
    F --> G[8 Check this drawing]
    B --> H[First colleague release]
    C --> H
    G --> H
```

**What each step gives you, in one line each:**

1. **Open line:** you open a job and one line says "all linked" or "needs checking". Nothing in the drawing changes.
2. **Core ribbon:** two tabs, CE Drainage and CE Design, with only the buttons you keep.
3. **Same settings for all:** you and every colleague run one office setup, so the same clicks give the same result.
4. **Safety fixes:** the faults that lose work or leave things out without saying.
5. **Sync made visible:** the hidden update stops running inside tools that say they only read, and whenever it does run it prints one line saying what it changed.
6. **Guesses removed:** no more made-up "100 dia UPVC". Unknown shows as Unknown.
7. **Start point:** you confirm the outlet once. It is stored in the drawing and every tool reads it from there.
8. **Check this drawing:** one door. It lists what is Sure, what is Proposed (with the reason) and what is Unknown. You tick, it backs up, applies, and one U undoes it.

**Three things run beside the steps and must be ready before step 8 can be proven:**

1. **The test set:** about 10 real past jobs with the right answers written down (`areas\TRUST_TEST_SET_12NOV.md`).
2. **The reader:** fixed rules that recognise every older version of each CE block, with Unknown for the rest (`areas\TRUST_READER_DESIGN_12NOV.md`).
3. **The release process:** who looks after a release, how problems come back, how to go back a version (`areas\TRUST_RELEASE_PROCESS_DRAFT_12NOV.md`).

**How a tool earns its place:** the five trust rules, as a tick list, with a one-page note per tool (`areas\TRUST_RULES_CHECKLIST_12NOV.md`).

---

## 1. How every step runs (the same gate each time)

```mermaid
flowchart TD
    A[Card written, DRAFT] --> B[Tim approves the card]
    B --> C[Tim lifts the hold for this one step]
    C --> D[Built, small]
    D --> E[Robot on the test set, then Codex looks, copies only]
    E --> G[Installed on Tim's PC, undo named]
    G --> H[Tim: about 3 working days on real jobs]
    H --> I[Tim says it is in]
```

1. **One step in trial at a time.** A second step does not go on Tim's PC until he has said the first is in, or has rolled it back. Whether two no-risk steps may share a trial is question A4 (OPEN).
2. **The four states stay separate.** Every step's status line reads Built / Tested / Installed / Accepted, each yes or no. A green build proves nothing in AutoCAD.
3. **The same check before and after every step (RULES 15.6).** The robot reads all test-set jobs before the step and after it. Anything that read correctly before must read the same after. One item that got worse blocks the step.
4. **The stop rule.** Lost work, a crash, or a wrong value shown as a fact, on Tim's PC or a colleague's: the step is rolled back the same day, and the "clean days" count starts again. Which faults count is question A2 (OPEN).
5. **Every install names its undo** before it happens: where the backup is and the one action to go back (RULES 8.6).
6. **Windows are Codex's work, behaviour is Claude's** (ruling B, 15 Sep). Where a step needs a window, the behaviour side writes the contract first.
7. **AutoCAD 2022 to 2024 is checked at every step,** because those users are in scope and have no ribbon today.

---

## 2. The eight steps

Each step has its own card. Step 1's card is answered; the others are DRAFT in `04_REFERENCE\ux-plan\cards\`.

### Step 1: the open line (card UX-OPEN-01, decisions answered)

1. **Goal:** tell the drafter the state of a Civil drawing the moment it opens, changing nothing.
2. **What you see:** `CE: 14 pits, 22 pipes, all linked.` or `CE: needs checking. 3 pipes not linked, 2 pits with no object.` Nothing on a non-Civil drawing.
3. **Depends on:** nothing. Before code: time the existing check on copies of large jobs to set the size limit.
4. **Proven by:** robot, 8 cases on copies, including a deliberately broken version that writes to the drawing and must be caught; Codex, one look at the line; Tim, five jobs he knows, one messy job, one Structural drawing.
5. **Undo:** one Settings switch. Nothing to restore, because nothing was written.
6. **Risk: LOW.** Worst case is a misleading count on an old job, which is itself useful to learn before step 8.
7. **Waits on:** Tim lifting the hold for it. No open question.

### Step 2: the core ribbon (card TRUST-02, DRAFT)

1. **Goal:** colleagues see only what you keep, laid out in drafting order.
2. **What you see:** CE Drainage, left to right: pits, downpipes and tanks, pipes, Check this drawing, schedules, help. CE Design beside it. Hidden tools can still be typed.
3. **Depends on:** your answers to Civil sort questions 3 to 11 and the "CE tools on every drawing" list (interview F3 to F12). Step 1 for the Check button's first job.
4. **Proven by:** robot reads the ribbon back and compares it with the approved list, button by button, and fires each button once; Codex looks at both tabs on 2027; the 2022 to 2024 pull-down menu is checked against the same list; Tim uses it for three days.
5. **Undo:** the old layout is kept as the existing "Show the old CE tabs" switch. Switch it on and restart AutoCAD.
6. **Risk: LOW to MEDIUM.** Nothing in a drawing changes. The risks are a button you rely on going missing, and the 2022 to 2024 menu drifting from the ribbon because it is a separate list today.

### Step 3: same settings for everyone (card TRUST-03, DRAFT)

1. **Goal:** the same clicks give the same result on every PC, and you can tell in one glance whether a colleague is on the office setup.
2. **What you see:** after an update, one short window: "Office settings changed: 6 values. See them / Apply." One line in CE Health: "Office setup: yes" or "Office setup: no, 3 values differ".
3. **Depends on:** your choice of which finished-but-off features come on (D2), what happens to a colleague's own changes (D1), and remembered values (D3).
4. **Proven by:** robot on two Windows logins, one new and one with an old settings file, ends with identical office values (file comparison); the old file is kept as a backup; Codex looks at the window; Tim checks his own setup did not move.
5. **Undo:** the previous settings file is kept beside the new one. One button puts it back.
6. **Risk: MEDIUM.** A wrong office value reaches everyone at once. That is also the point: one place to fix it.

### Step 4: core safety fixes (card TRUST-04, DRAFT)

1. **Goal:** remove the faults that lose work or leave things out silently, before anything else is asked of colleagues.
2. **What you see:** CLEAN saves; a reminder when work has gone unsaved; Pit Schedule exports to Excel on 2027 and says which pits it left out; cancelling CDFW no longer clears pit inverts. Then the Structural schedule fixes.
3. **Depends on:** nothing in steps 1 to 3. Fixes are lifted one at a time out of the held builds (C-79c, C-80, S-46); those builds are not installed whole.
4. **Proven by:** each fix has its own robot case and a broken twin that must fail; Codex looks at anything seen on screen (the reminder, the schedule note, the Excel file opened); Tim on real jobs.
5. **Undo:** the previous build, by the install's named backup.
6. **Risk: MEDIUM.** Each fix is small, but they touch saving and the schedule, which are the things you can least afford to break. BUG-1255 has no fix written yet; its cause is only named in the bug title.

### Step 5: the sync made visible (card TRUST-05, DRAFT)

1. **Goal:** nothing changes CE's record behind your back.
2. **What you see:** CDGRAPH, CE Health, CDDIAG and the dashboard no longer change anything. When any tool does update the record, one line says so: `CE updated its record: 2 pipes added, 1 pit removed, 3 cover levels read from the drawing.` Silence when nothing changed.
3. **Depends on:** step 1 (the same counting). One probe first: how AutoCAD's U treats these changes, on a copy.
4. **Proven by:** robot compares the stored record before and after each "read-only" tool (must be identical) and checks each line's numbers against the real difference; Codex reads the line for plain words; Tim sees whether the lines match what he knows of his jobs.
5. **Undo:** two Settings switches, one for each half.
6. **Risk: MEDIUM.** A tool that leaned on the hidden update may show slightly older information. It must then say "needs checking" rather than update quietly.

### Step 6: guesses removed (card TRUST-06, DRAFT)

1. **Goal:** Unknown shows as Unknown, and CE never reaches further than you would expect.
2. **What you see:** a line on the pipe layer with no size shows "size Unknown" (the schedule shows "?"), not "100 dia UPVC". In a metre drawing CE no longer looks 2 km for a pit label.
3. **Depends on:** step 5 (so each change is reported). Your engineering word on each fill-in: size, material, lid class, pit number, flow direction (card decisions).
4. **Proven by:** robot on the test set: zero invented values, same result in a millimetre and a metre copy of the same job; a broken twin that fills "100" must fail; Tim checks the Unknowns are the ones he would expect.
5. **Undo:** one Settings switch returns the old fill-ins for new readings. Values already written are not changed back by the switch; the pre-step backup is the way back.
6. **Risk: MEDIUM to HIGH.** More "?" appear at first, on exactly the jobs that were quietly wrong. Calculations that meet a blank size have not been traced yet.

### Step 7: the start point, confirmed and stored (card TRUST-07, DRAFT)

1. **Goal:** one start point per network, confirmed once, stored in the drawing, read by every tool.
2. **What you see:** "CE proposes P1 as the outlet because the LPD is drawn at its outlet pipe. Confirm?" After that CDRENUMBER, the schedule, the solver and the long section stop asking, and a marker shows where it is.
3. **Depends on:** step 6 (a proposal must never be a guess presented as fact). Your word on jobs with two outlets (B4).
4. **Proven by:** robot: confirm once, save, close, reopen, every reader gives the same outlet; two-outlet job; job with no outlet drawn; Codex looks at the question and the marker; Tim on real jobs.
5. **Undo:** the confirmation is one U. A Settings switch sends the readers back to today's behaviour.
6. **Risk: MEDIUM.** Two stored forms of the LPD exist today and each refuses to be written while the other is there. The safe design reads both and migrates neither at first.

### Step 8: Check this drawing (card TRUST-08, DRAFT)

1. **Goal:** one door for bringing any drawing, old or new, into a state you can trust.
2. **What you see:** a list in three groups, Sure, Proposed (each with its reason) and Unknown. You tick what to accept and confirm the outlet. CE backs up, applies, and one U undoes it. CE does not save; you do.
3. **Depends on:** steps 5, 6 and 7, the reader, the test set, and your word on the 25 Sep ruling that keeps CDSYNC and CDREBUILD as direct commands (C1).
4. **Proven by:** Codex and the robot on all test-set jobs against the written answers; then Tim on real jobs for about three days; then colleagues. This is the gate for the first colleague release.
5. **Undo:** one U for an Apply; the backup file made before Apply; the old typed commands stay until this is accepted.
6. **Risk: HIGH.** It writes to real drawings. That is why it is last, built in slices (read-only list first), and proven on copies before any live job.

---

## 3. What must be true before the first colleague release

All of these, none optional. The exact bar is question A1 (OPEN); this is the recommendation.

1. **Steps 1 to 8 accepted by Tim,** each after its own trial.
2. **The test set passes:** on every job, nothing wrong shown as a fact; Unknowns within the limit Tim sets (B3).
3. **Three clean working days** for Tim on the whole core: no lost work, no crash, nothing unexplained.
4. **Every core tool passes the five trust rules** and has its one-page note.
5. **The release process is agreed** (who, how problems come back, how to go back) and going back a version has been rehearsed once on a colleague-style PC.
6. **Each first colleague's AutoCAD year is known** (A3), and the core has been checked on that year.

---

## 4. Findings since 6 Nov that change the plan

Read from the installed code (Civil and Manager cf059dcf, Structural 8de95c34) by three readers on 12 Nov. "Checked" means this chat re-read the line itself.

1. **The hidden sync has about 60 ways in, not about 36.** Two different calls reach the same writer; the earlier count mixed them. (Reader's count, not re-counted here.)
2. **The sync reports nothing because it returns nothing.** Its counts exist only in the log, and some changes (cover levels read back, pipes re-joined) are not counted at all. Step 5 has to add the counting, not only print it.
3. **The existing "hold" does not hold everything.** Three tools already keep record changes back until you accept. Link changes made during a sync are not held. Step 8 therefore uses the "work on a copy, then apply once" pattern that CDSPINEUPGRADE uses.
4. **The 5,000 label reach is already a Setting and already unit-safe.** Checked. The 6 Nov audit was wrong on that one. The pit width plus 2000 and plus 2500 reaches are still hard-coded and unit-blind. Checked for 2000.
5. **Two more unit-blind items the audit missed:** the 200 restore distance, and a pipe's size read from its drawn width (a 0.225 wide line in a metre drawing reads as 0, not 225).
6. **CDFIXPIPEENDS defaults to Yes, not No.** Checked. Enter applies the fix. It is not the model of caution the audit called it.
7. **The outlet has two real homes, not four.** CDLPD's record does link to a pipe end and a pit. A second, newer record holds several outlets and is written from Design. Each refuses to be written while the other exists. The other two "homes" are about one pit's outlet pipe, not the network's.
8. **CDRUNSOLVE finds the outlet by looking for a pit whose number contains "LPD".** Checked. It does not read the stored LPD at all.
9. **The oldest pit and pit label symbols have no master drawing in the plugin.** Only PIT BLOCK 2, PIT BLOCK 3 and PIT LABEL 2 ship. Checked. The reader cannot compare the oldest ones against a file.
10. **No old LISP tools were found on this PC** in the two places the readers looked. What the LISP era left in drawings has to be learnt from the test-set jobs themselves.
11. **Saving Settings writes every value.** So anyone who has ever pressed Save is frozen on the values of that day, and later office changes never reach them. Colleague starting values apply only to a login that has never had a settings file. Checked.
12. **There is no way to send one setup to everyone today.** No export, no import, no office file.
13. **The "hidden" mark does not hide a ribbon button.** 76 of 141 Civil commands carry it (checked), but the ribbon ignores it. The ribbon is a hand-written layout.
14. **One tab per plugin today.** Two Civil tabs need a second entry in the tab list; nothing hides tabs by drawing type, so both already show everywhere.
15. **The 2022 to 2024 pull-down menu is a separate list** from the ribbon, so the two can drift. New Job is on neither.
16. **Pit symbols are swapped on opening with no check that the drawing is Civil,** and with no line on screen. Checked.
17. **The backup made before pipe conversion copies the last saved file.** Work since the last save is not in it.

---

## 5. Probes needed before some cards can be final

These need AutoCAD on copies, so they wait for Tim to lift the hold for them. None changes a real job.

1. **P1, timing:** how long the read-only check takes on the largest jobs (sets step 1's size limit).
2. **P2, Undo:** what one U does after a sync, after an open-time change, and after an Apply from a window. The code cannot answer this. Steps 5 and 8 need it.
3. **P3, old drawings:** open each test-set copy and list every block name and attribute on the drainage layers. This builds the reader's list of older versions.
4. **P4, the 2022 to 2024 menu:** what a colleague on those years actually sees today.
5. **P5, colleague PCs:** which build, which AutoCAD year, and which settings each first colleague has. Never read so far.

---

## 6. Rules and earlier answers this plan touches

Nothing here is changed by this plan. Each needs Tim's word (interview section H and C).

1. **UX-REP-01 (25 Sep):** CDSYNC and CDREBUILD stay direct typed commands. The plan keeps them typed and working; putting them behind a preview needs his word.
2. **Pipe conversion on opening:** 16 Sep "EVERYTIME YOU OPEN AN EXISTING JOB" against 4 Nov "ASK USER WHEN OPENS".
3. **Rule 15 (AutoCAD never idle), the 17 Oct switch-on ruling, percentages in every message:** in force until he says otherwise. Under this plan, robot and Codex evidence comes first but cannot let a tool into the core.
4. **The plastic pit rule (5 Sep, item 58):** kept. Step 4 only makes the schedule say which pits it left out.
5. **CE never saves for you (UX-STD-03):** kept in every step.
6. **No hard blocks (R-27):** kept. Every step warns and records.
7. **Settings-first (R-00):** steps 6 and 3 move hard-coded values onto Settings.

## 7. RULES 15.8, the six foundations

The plugin does not own the drawings, so most do not apply (15.9). Stated, not skipped:

1. **One fact in one place:** APPLIES and is a GAP. The record, the links, the labels and the outlet can disagree. Steps 5 to 8 are the cure.
2. **A restore that has been run:** APPLIES to CE's own backups. GAP: the pre-conversion backup misses unsaved work, and no restore has been rehearsed. Step 8 proves one.
3. **Platform watch:** not applicable here; AutoCAD years are covered by the 2022 to 2024 check at each step.
4. **Tight access:** not applicable; no browser or shared store.
5. **Alerts:** APPLIES in a small way. GAP: nothing tells Tim a colleague is on a different build or setup. Step 3's health line is the cure.
6. **No dead data:** APPLIES. GAP: one recovery routine has no caller, and the old per-PC project files are still read in rare cases. Noted for step 8.

---

## 8. Status

1. **Step 1:** card answered. Built no. Tested no. Installed no. Accepted no.
2. **Steps 2 to 8:** cards DRAFT. Built no. Tested no. Installed no. Accepted no.
3. **Test set, reader, release process, trust checklist:** DRAFT documents. No jobs picked yet.
4. **Interview:** started 12 Nov; A1 asked; no answers yet.

## 9. What this plan has not checked

1. **Nothing was run.** Every behaviour is read from code or a log.
2. **No colleague PC was read.**
3. **No real old drawing was opened.**
4. **The readers' findings** were spot-checked on ten lines (marked "Checked" above and listed in the desk log). The rest is their reading.
5. **Structural and Manager** have only the 6 Nov audit behind them; they follow Civil and have no step cards yet.
6. **The held builds (C-79c, C-80, S-46)** were not re-read for step 4.
