# Engineering fix proof plan: BUG-905, BUG-1097, BUG-1095, BUG-1091, BUG-1088 (Thu 29 Oct 2026)

**Who and how.** CE 02 Robot and Codex Testing, headless Team job "CE_ACAD / robot / plan / 19" (Opus), started 12:11 Melbourne by the PC clock. Reading and writing documents only. AutoCAD, the runner, the driver, the settings guard and the lock were not touched. Source was read with `git show` / `git grep` only.

**Builds read:** `origin/claude/rel-20261026z` (the installed Civil 3.0.85 line, as the brief states; I did not read the DLL version string). `origin/claude/rel-20261029a` (the C-76 train) exists. For these five bugs its files match 26z.

---

# ANSWER FIRST

1. **The robot can prove none of the five today.** Every number these fixes change shows up in only three places, and the robot can read none of them. These are a window tab it cannot switch to (CDCALC Boyd's, CDCALC Charged System, the CDDESIGN Results tab, the CDHUB redesign preview), a record hidden inside the drawing, or nowhere. Nothing goes to the command line, the CE log or a saved file. So I drafted **no robot cases**, as the brief says to when a case cannot be driven. The drafts folder was not created.
2. **The quickest honest proof is three Codex looks, with a twin taken for free.** Today's build (3.0.85) still has all five faults, so a look run on it now is the "broken twin" reading. The same look run after the fix gives the "fixed" reading.
3. **H1 (BUG-1097) is updated and ready.** It now judges against your ruling, the head left after losses. It reports NOT TESTED until a build with the change is installed. I also found and fixed a trap in it: the tab shows only one warning line, and the capacity warning was hiding the head warning.
4. **None of the five rewrites your remembered values (CD_RecentValues.json).** This is from reading the source.
5. **Status: built 0 of 5 as asked for.** BUG-905 is built but switched OFF and must be flipped ON. BUG-1097 is built against the typed head and needs changing to the head after losses. BUG-1095 has a fix branch (`cx6/bug-1095-bd21`), not in any train. BUG-1091 and BUG-1088 have nothing built yet.

---

# FOR TIM

1. **What you will see when each is right.**
   1. **BUG-905:** in CDCALC Boyd's, a 746 m2 lot with 414 m2 hard and 332 m2 garden, 7.9 L/s permitted. It shows C 0.633 and 2.08 m3 of storage, the same hard-ground 0.9 as CDDESIGN. Today it shows 0.689 and 2.56 m3, because it uses 1.0 for hard ground.
   2. **BUG-1097:** in CDCALC Charged System, a typed head of 0.40 m loses about 0.22 m in the pipe and leaves about 0.18 m. That is under 300 mm, so the 300 mm warning must appear. Today it stays quiet because 400 mm is over 300.
   3. **BUG-1095:** on a Darebin job, a 600 m2 lot with 400 m2 roof and paving and 200 m2 garden comes out at C 0.80 with a "council minimum C governs" note. Today it is 0.70. In the Boyd's tab, at a 5 L/s permitted discharge, storage goes from 2.97 m3 to 3.86 m3.
   4. **BUG-1091:** an existing DN450 pipe carrying 30 L/s is redesigned at 1 in 200, as Edit Pipe says. Today it is 1 in 1,509.
   5. **BUG-1088:** a 40 L/s connection pipe comes out DN225 at 1 in 200. Today it is DN100 at about 1 in 3, which runs at 5.1 m/s.
2. **The quickest honest proof for each.**
   1. **BUG-1097:** Codex look H1 (written, ready). It needs only the fixed build installed.
   2. **BUG-905 plus the Boyd's half of BUG-1095:** one new Codex look at the Boyd's tab, about 1 hour.
   3. **BUG-1088, BUG-1091 and the CDDESIGN half of BUG-1095:** one Codex look at CDDESIGN and the redesign preview, on a prepared Darebin test job. About 2 to 3 hours including making the job.
   4. **Robot:** none possible, as answer 1 above explains.
3. **What is still your engineering call.**
   1. **BUG-1088:** the sizing policy itself. Monday question 21(a) asks: use each size's flattest allowed grade, and go up a size before going steeper. "Build all three" says build it, not which policy. CE 01 builds on that recommendation. A Codex PASS shows it does what was built. Your word says it is the right design rule.
   2. **BUG-905:** none left. You said 0.9. The guidebook page is still to be checked.
   3. **BUG-1097:** none left for the warning. The Settings box and the CDRULES line are still not built.
   4. **BUG-1095:** none left. It is the council's own rule. **Tell, not ask:** past Darebin, Maribyrnong and Boroondara designs never had it applied, so they may be small.
   5. **BUG-1091:** none left. The fix follows whatever your Settings grade ladder says.
4. **The order to prove them.** First BUG-1097, because H1 is already written. Second BUG-905 with the Boyd's half of BUG-1095, in one look. Third BUG-1091, then BUG-1088, then the CDDESIGN half of BUG-1095, all in one CDDESIGN look. BUG-1088 needs BUG-1091 built first.
5. **Days of work.** Proofs: about 1 day in total, after CE 01 has built and installed (target Thu 5 Nov). That is half a day of Codex looks plus half a day to make the Darebin test job and write the two new looks. Optional: about 1 day to give the robot a reviewed "switch window tab" step. With it, the robot could read the CDCALC numbers itself and earn "Claude-accepted" on the numbers.
6. **What the robot cannot reach, and why.** The answers sit on window tabs the robot cannot switch to, or in a record inside the drawing that it cannot read. CDRUNSOLVE also gives the sizer no flow (BUG-999), so it cannot show BUG-1088 either.
7. **Nothing for you to test.** All of this is for Codex and the robot.

---

# BELOW THE LINE: per-bug proof detail

Every figure below is **DERIVED**: my arithmetic from the rule and the installed source formulas. None has been proven on screen, unless the line says a card, the rulebook or a bug entry states it. Formulas, read from `origin/claude/rel-20261026z`:

1. **Boyd's tab** (`ViewModels/BoydsCalcViewModel.cs:235-266`):
   1. Effective area = hard area x hardC + garden area x 0.30.
   2. Inflow (L/s) = I x effective area / 3600.
   3. Storage per storm row = (inflow − permitted discharge) x duration in seconds / 1000 m3. The tab takes the largest row.
   4. Storm rows (fixed starting figures): 5 min 113, 10 min 85.3, 15 min 69.7, 20 min 59.4, 25 min 52, 30 min 46.5 mm/h.
2. **Charged System tab** (`ViewModels/ChargedSystemCalcViewModel.cs:190-252`):
   1. Design flow Q = C x I x A / 3600 (L/s).
   2. Friction (Hazen-Williams) = 10.67 x q^1.852 / (HW^1.852 x d^4.87) x L, with q in m3/s and d in metres.
   3. Minor loss = K x v² / 2g, with v in the 0.15 m pipe.
   4. Qmax = 0.82 x downpipe area x √(2g x (head − total loss)) x 1000.
   5. **Only the FIRST warning line shows.** "Qmax is less than design flow rate." is listed before the head warning.
3. **Sizer** (`Services/PipeSizingSolver.cs`, `DesignValidationService.cs:133-147`):
   1. Manning full bore: v = (1/n)(D/4)^(2/3)√S, with D the nominal DN in metres and n 0.010 for UPVC.
   2. It tries sizes smallest first. The grade gives max(0.6 m/s, Q/A), capped only by 6 m/s (`designStandards.maximumPipeVelocity`), with nothing steeper than 1 in 1.

## 1. BUG-905: Boyd's tab hard-ground C 1.0 → 0.9 (Tim item 30: "yes, 0.9")

1. **Switch:** `detention.boydsUsesHardGroundC`, default **false** (`Models/UserSettings.cs:2584-2585`). It is still false on `rel-20261029a`. The desk must flip it to true in the next train (decisions item 30).
   1. ON reads `detention.hardGroundRunoffC`, default 0.9 (`:2577-2578`). A bad value falls back to 0.9.
2. **Numbers the proof checks.** These are the old sample figures: lot 746 m2, hard 414 m2, garden 332 m2, permitted discharge 7.9 L/s.
   1. **Fixed (ON):** effective area 414 x 0.9 + 332 x 0.30 = 372.6 + 99.6 = **472.2 m2**. C = 472.2 / 746 = **0.633**.
      1. 5 min: 113 x 472.2 / 3600 = 14.82 L/s; (14.82 − 7.9) x 300 s = **2.077 m3**, the largest row.
      2. 10 min: (11.19 − 7.9) x 600 = 1.973 m3.
   2. **Twin (OFF, today):** effective area 414 x 1.0 + 99.6 = **513.6 m2**. C = **0.689**.
      1. 10 min: 85.3 x 513.6 / 3600 = 12.17 L/s; (12.17 − 7.9) x 600 = **2.562 m3**, the largest row.
      2. 5 min: 2.466 m3.
   3. **Difference:** today's tab says 23 per cent more storage than the fixed one. The critical storm moves from 10 to 5 minutes.
3. **Preconditions:**
   1. A blank test copy. The Boyd's tab starts blank (`boydsStartsBlank` true).
   2. Settings with no `detention` section (Tim's file on 29 Oct had none), so the defaults apply.
   3. For a twin on the fixed build: a settings pass with `detention.boydsUsesHardGroundC false`. Easier: run the same look on 3.0.85 today.
4. **Remembered values:** not touched. CDCALC writes its draft into the test copy's own project record when the window closes with changes. The copy is never saved.
5. **Proof route:** Codex look, a new one (not written by this job). Type the four inputs into Boyd's. Read the effective area, C, storage and critical duration.
   1. PASS = 472.2 / 0.633 / 2.077 at 5 min, each within the last shown digit.
   2. Twin = 513.6 / 0.689 / 2.562 at 10 min.
6. **Robot:** cannot. It cannot select the "Boyd's Method" tab (CDCALC opens on its first tab), and the answer is not written anywhere else it can read.
7. **Status in this plan:** BUILT (switched OFF) → NEEDS TRAIN FLIP → NEEDS LOOK. The guidebook page check for 0.9 is still open (decisions item 30).

## 2. BUG-1097: the 300 mm head check uses the head LEFT AFTER LOSSES (Tim item 31)

1. **Switch:** `detention.chargedMinHeadWarning`, default **true** (`UserSettings.cs:2547-2548`). The minimum comes from `designStandards.chargedMinHeadMm`, which is 300 (`:2303-2304`; Tim's file holds 300).
   1. Today it compares the TYPED head (`ChargedSystemCalcViewModel.cs:243-252`, called with the raw `head`).
   2. No branch has the after-losses change yet. CE 01 builds it. Whether it gets a switch of its own is unknown: CE 01 decides.
2. **Numbers the proof checks.** Tab starting figures: C 0.9, I 126 mm/h, area 390 m2, HW 150, pipe 0.15 m by 48.5 m, K 2.95. **Downpipe typed as 0.15 m** (see item 5 below).
   1. Q = 0.9 x 126 x 390 / 3600 = **12.29 L/s**.
   2. Friction = **0.1438 m**. Minor: v = 0.01229 / 0.01767 = 0.695 m/s, so 2.95 x 0.695² / 19.62 = **0.0727 m**. Total loss = **0.2165 m** (about 0.22).
   3. Each typed head, and the head left after the 0.2165 m loss:
      1. Typed 0.28: about 64 mm left. Qmax 16.2 L/s. **Warn.**
      2. Typed 0.40: about 184 mm left (about 0.18 m). Qmax 27.5. **Warn.** This is the deciding reading.
      3. Typed 0.30: about 84 mm left. Qmax 18.6. **Warn.** Also deciding.
      4. Typed 0.84: about 624 mm left. Qmax 50.7. **No warning.**
   4. **Bug entry's own example:** 100 m2, 0.1 m downpipe, typed 0.25. Q = **3.15 L/s**, total loss 0.0163 m, 234 mm left, Qmax **13.79 L/s**. **Warn** under either meaning.
      1. The entry states 3.15 and 13.79. My formulas reproduce both, which checks the arithmetic.
3. **Twin:** today's build. It warns at 0.28 and at the bug example only, and stays silent at 0.40 and 0.30. If CE 01 adds a switch, that switch OFF is the second twin.
4. **Remembered values:** not touched.
5. **Trap found (fixed in H1):** the tab shows one warning line only, and the capacity warning comes first. With the tab's own 0.1 m downpipe, Qmax falls below the 12.29 L/s design flow at typed 0.25, 0.30 and 0.40 (about 5.2, 8.3 and 12.2 L/s). So the head warning would never be visible in those readings.
   1. The downpipe does not enter the loss formulas. Typing 0.15 m lifts Qmax clear and changes nothing else.
   2. **For CE 01:** consider showing every warning, not just the first. Otherwise a drafter on a real job with low capacity never sees the head warning.
6. **Proof route:** Codex look **H1-02** (`C:\Lisp Files\_CODEX_RUNNER\verifyH1_c85_full.txt`), updated today. It has a FIX-IN gate: the desk writes in the first Civil version carrying the change.
7. **Remainder not covered:** the Settings box with project override (BUG-546) and the CDRULES R-13 line. The carpark's "Steps to confirm" (a typed 250 mm) is now stale against the ruling. The desk should rewrite it to the 0.40 m example (I did not edit the carpark).
8. **Status in this plan:** BUILT (typed head; ruling changes it) → NEEDS BUILD (CE 01) → LOOK READY (H1).

## 3. BUG-1095: council minimum after-development C (Darebin 0.80, Maribyrnong 0.75, Boroondara 0.65)

1. **Today:** `CouncilRuleValues.PostDevelopmentC` (`Rules/CouncilRuleValues.cs:99-114`, max of calculated and floor) has no caller. The floors are in `Assets/Config/council-profiles.json`: Boroondara 0.65 (line 518), Darebin 0.8 (581), Maribyrnong 0.75 (1167), all mode "floor".
2. **Fix branch:** `origin/cx6/bug-1095-bd21` (`434468ca`). It was built on 3.0.80, is in no train, and has never been run in AutoCAD. What it does (helper's source reading, not re-read by me line by line):
   1. Adds the switch `detention.councilMinimumRunoffCApplied`, default ON.
   2. CDDESIGN, pump sizing and Boyd's all go through the floor.
   3. CDDESIGN notes "[CE] council minimum C governs" and "[CE] Runoff C = 0.8."
   4. Boyd's shows C 0.800 and an effective area of 480 m2.
3. **Numbers the proof checks** (Darebin; lot 600 m2, hard 400 m2, garden 200 m2; the bug entry's example):
   1. **Calculated C:** (400 x 0.9 + 200 x 0.30) / 600 = 420 / 600 = **0.70**. The bug entry states this.
   2. **Fixed:** **0.80**, with the note. Inflow rises by 0.80 / 0.70 = 1.143 (today's inflow is 87.5 per cent of the council's).
   3. **Boyd's tab, permitted discharge typed as 5.0 L/s** (my choice, so a number can be checked):
      1. Fixed: effective area 480 m2, 15 min row (69.7 x 480 / 3600 − 5.0) x 900 = **3.864 m3**.
      2. Twin with BUG-905 ON: area 420 m2, 10 min row = **2.971 m3**.
      3. Twin with BUG-905 OFF (today's 3.0.85): area 460 m2, C 0.767, **3.540 m3**.
   4. **CDDESIGN storage:** not derived. CDDESIGN uses the job's own rainfall curve or the office curve, and a different method (`DetentionSizingService.cs`). The look checks "Weighted C (post-dev)" reads 0.80 with the note, and that storage rises against the twin.
4. **Twin:** the switch `detention.councilMinimumRunoffCApplied false`, or today's build.
5. **Preconditions:** a test job whose council is Darebin. **None exists among the robot fixtures, and no document names one.** How the Boyd's tab learns the job's council is not confirmed from the source (UNKNOWN). Codex or the desk must make a Darebin test job once (CDDESIGN Setup, council Darebin, land use, the three areas). Then save it as a fixture outside Tim's hours.
6. **Remembered values:** not touched.
7. **Proof route:** two halves.
   1. **Boyd's half:** in the BUG-905 look.
   2. **CDDESIGN half:** in the CDDESIGN look (the Results tab text "Weighted C (post-dev)" and the notes).
8. **Robot:** cannot. The Results tab and Boyd's tab are unreachable, and the CDDESIGN results go to the window only (`CivilDesignWindowViewModel.cs:810`). The saved design record holds inputs only.
9. **Tell Tim, not ask:** past Darebin, Maribyrnong and Boroondara designs may be small. CE 01's triage asks the desk to list them.
10. **Status in this plan:** FIX BRANCH (not in a train) → NEEDS TRAIN → NEEDS TEST JOB → NEEDS LOOK.

## 4. BUG-1091: DN450 and larger keep the Settings minimum grade in redesign and auto-design

1. **Today:** `SettingsSizingStandards.cs:32-33, 97-105, 138` passes only DN90 to DN375 to the sizer. The comment there reads "DISAGREEMENT with the Edit Pipe screens … kept as today, listed for Tim".
   1. Settings ladder (`UserSettings.cs:2278-2282`), as 1 in N: DN100/150 = 100, DN225 = 200, DN300 = 250, DN375 = 300, DN450 to DN750 = 200.
2. **Switch:** none exists. Whether CE 01 adds one is unknown.
3. **Numbers the proof checks:**
   1. **Redesign, preserve existing sizes, DN450 UPVC at 30 L/s.** The speed is 0.030 / 0.159 = 0.19 m/s, so the 0.6 m/s minimum governs. The grade for 0.6 m/s is (0.6 x 0.010 / 0.1125^(2/3))² = 1/1,509, giving **1 in 1,509** today (1 in 893 with n 0.013). The bug entry states both.
      1. **Fixed: 1 in 200**, from the ladder. At 1 in 200 the DN450 full-bore capacity is 262 L/s at 1.65 m/s.
   2. **CDDESIGN connection pipe at 150 L/s** (only once BUG-1088 is also fixed):
      1. DN375 at 1 in 300 carries 131.6 L/s, too small. DN450 at 1 in 200 carries 262 L/s.
      2. **Fixed: DN450 at 1 in 200.** With BUG-1088 fixed but BUG-1091 not: DN450 at 1 in 611, the grade for exactly 150 L/s, with no ladder floor.
      3. With neither fixed (today): DN225 at about 1 in 15, at the 6 m/s cap.
4. **Twin:** today's build, or a switch if CE 01 adds one.
5. **Preconditions:** a redesign test copy with an existing DN450 carrying 30 L/s, through the CDHUB network redesign preview. **No such fixture is known.**
6. **Remembered values:** not touched.
7. **Proof route:** the CDDESIGN look (connection pipe at 150 L/s) and/or a CDHUB redesign preview look. Both are windows. The robot cannot reach either.
8. **Status in this plan:** NO FIX → NEEDS BUILD → NEEDS FIXTURE → NEEDS LOOK.

## 5. BUG-1088: the sizer picks the smallest pipe at any grade

1. **Today:** `PipeSizingSolver.cs:76, 84-88, 221-246` returns the smallest size that works at any grade, up to 1 in 1. The only limit is the 6 m/s cap.
   1. **Note for CE 01:** rulebook R-01 caps UPVC at 3.0 m/s, but the sizer reads one 6 m/s value (`designStandards.maximumPipeVelocity`). CE 01's triage asked about this.
2. **Policy being built:** the recommended answer to Monday question 21(a), which is NOT formally answered. Each size runs at its Settings ladder grade, flattest first. The sizer steps up a size before going steeper, and goes steeper only when no size on the ladder works.
3. **Switch:** none exists. The name and default are CE 01's to choose.
4. **Numbers the proof checks** (UPVC, n 0.010, nominal diameters, as the source uses):
   1. **40 L/s today:** DN100. The speed is 40 / 7.854 = 5.09 m/s. The grade for that is (5.09 x 0.010 / 0.025^(2/3))² = 1/2.82, so **1 in 2.82** (CDDESIGN prints "Grade 1:3"). The bug entry states both.
   2. **40 L/s fixed, from the ladder capacities:**
      1. DN100 at 1 in 100 carries 6.7 L/s. DN150 at 1 in 100 carries 19.8 L/s.
      2. **DN225 at 1 in 200 carries 41.3 L/s**, which is enough, at 1.04 m/s.
      3. The grade for exactly 40 L/s would be 1 in 213. That is flatter than the 1 in 200 floor, so **1 in 200** governs.
      4. **Expected: DN225, Grade 1:200.**
   3. **Other ladder capacities**, for any flow the look meets: DN300 at 1 in 250 = 79.5 L/s; DN375 at 1 in 300 = 131.6 L/s; DN450 at 1 in 200 = 262 L/s; DN525 at 1 in 200 = 395 L/s; DN600 at 1 in 200 = 564 L/s.
      1. **Rule for the look:** for the flow the window prints, the right size is the smallest whose ladder capacity is at least that flow. The grade is its ladder grade.
5. **Twin:** today's build (DN100 at 1:3), or CE 01's switch OFF.
6. **Preconditions:** a CDDESIGN test job whose connection pipe flow is about 40 L/s. How CDDESIGN arrives at the connection flow from the job's areas was not traced (UNKNOWN). So the look reads the flow the window prints and applies the rule above.
7. **Remembered values:** not touched.
8. **Proof route:** the CDDESIGN look. Read the Results tab "CONNECTION PIPE" lines "Diameter … mm" and "Grade 1:…" (`DesignProposalReport.cs:300-318`). The redesign preview (CDHUB) is the second place to look.
9. **Robot:** cannot. CDRUNSOLVE feeds no flow (BUG-999), and the CDDESIGN and CDHUB results are window only.
10. **Status in this plan:** NO FIX → NEEDS BUILD (after BUG-1091) → NEEDS TIM'S WORD ON THE POLICY → NEEDS LOOK.

---

# What a robot route would need (not built, not asked for)

1. **A reviewed "select window tab" step** for "Creative Engineering*" windows. The v3 driver already reads which tab is selected (`acad_driver_v3.ps1:616, 664`). ROBOT_NEXT_CASES_SPEC_B3 section B item 1 already asks for this.
2. **With it,** the robot could:
   1. Open CDCALC and select Boyd's or Charged System.
   2. Type the inputs with `ui2-set`.
   3. Read the numbers and the warning with `control-text`. The Calculations window is already on the allow-list ("Creative Engineering*").
3. **What that would earn:** BUG-905, BUG-1097 and the Boyd's half of BUG-1095 could become **Claude-accepted for the numbers**. That needs two sessions, the twin, and a reviewer.
4. **What it would not cover:** whether the drafter can SEE the warning (the one-line trap above). That stays a Codex look.
5. **The CDDESIGN Results tab** would also need the job's inputs typed across the Setup and Areas tabs. That is a much bigger case.

---

# Task 2: draft cases

**None drafted.** All five fail the "robot can drive it" test, for the reasons above. This follows the brief: a case that cannot be driven is written up, not drafted.

1. **Drafts folder:** `cases\drafts_engineering_29oct\` was not created, so there is no empty folder.
2. **Format check:** the offline check (`case_runner.ps1 validate`, `Invoke-CaseRunnerMain` line 422 → `Read-CaseFile` / `Test-CaseFile` in `case_runner_lib.ps1`) was read. It parses files and checks that the fixture exists, and starts no AutoCAD. Loading it does dot-source the v3 driver library, which only sets variables and loads types (`-Library` skips `Invoke-V3Main`, line 1154). It was not run, because there is nothing to check.

---

# Task 3: the H1 change (before and after)

Files changed:
1. `C:\Lisp Files\_CODEX_RUNNER\verifyH1_c85_full.txt`: title line, the "WHAT THIS RUN UNLOCKS" paragraph and H1-02. H1-02 gained one new line (EXPECTED).
2. `C:\Lisp Files\_CODEX_RUNNER\verifyH1_c85.txt`: the title phrase.

That folder is not under git. The untouched copies are at `C:\Users\TimothyBrand\AppData\Local\Temp\ce_plan19\verifyH1_c85_full.BEFORE.txt` and `verifyH1_c85.BEFORE.txt`. **Undo:** copy those two back over the originals.

1. **Title (full brief, line 1).**
   - BEFORE: "… AND WHAT THE CHARGED SYSTEM TAB SAYS ABOUT THE 300 MM MINIMUM HEAD (BUG-1097, REPORTED ONLY) - FULL BRIEF (Thu 29 Oct 2026, written by the Opus desk assistant, job CE_ACAD / robot / draft / 15)."
   - AFTER: "… AND WHETHER THE CHARGED SYSTEM TAB'S 300 MM MINIMUM HEAD WARNING USES THE HEAD LEFT AFTER PIPE LOSSES (BUG-1097, JUDGED AGAINST TIM'S RULING OF 29 OCT; NOT TESTED UNTIL THE FIX IS INSTALLED) - FULL BRIEF (… job CE_ACAD / robot / draft / 15; H1-02 rewritten 12:14 Melbourne the same day by job CE_ACAD / robot / plan / 19 after Tim ruled)."
2. **"WHAT THIS RUN UNLOCKS" item (2).**
   - BEFORE: "Tim has NOT yet said which head the 300 mm rule means: the head you type (as built) or the head left after the pipe losses. So H1-02 JUDGES NOTHING: it reports exactly what the window shows for typed heads chosen so that the two meanings give different answers, and the desk takes those facts to Tim. Its result word is SEEN."
   - AFTER: "TIM HAS RULED (decisions item 31, his words): "the head left after losses, because that's the real head at that point." It stays a warning, never a block (rulebook R-27). That change is NOT in Civil 3.0.85: CE 01 builds it for train C-76 or C-77. So H1-02 now JUDGES the window against the ruling, but ONLY on a build that carries the change (the FIX-IN gate in H1-02); on any other build it is NOT TESTED: FIX NOT INSTALLED and the readings are still written for the desk."
3. **H1-02 heading and background.**
   - BEFORE: "H1-02 WHAT THE CHARGED SYSTEM TAB SAYS ABOUT THE 300 MM MINIMUM HEAD, UNDER BOTH MEANINGS OF THE RULE (BUG-1097; REPORTED ONLY, result word SEEN). … The other possible meaning, which Tim has not ruled on, is the head LEFT after the pipe losses …"
   - AFTER: the heading says the warning "MUST USE THE HEAD LEFT AFTER PIPE LOSSES (… JUDGED …)", followed by:
     1. Tim's ruling in quotes.
     2. 3.0.85's typed-head warning, named as the OLD behaviour.
     3. "the warning wording may change with the fix, so copy whatever it says, word for word".
     4. **FIX-IN GATE:** "FIX-IN = NOT YET KNOWN (the desk replaces these three words with the first Civil ProductVersion that carries the head-after-losses change …). If FIX-IN still reads NOT YET KNOWN, or the installed Civil ProductVersion is lower …, run every step … but the result line is "H1-02 NOT TESTED SURE FIX NOT INSTALLED (Civil <version read>)": this OVERRIDES the N14 sentence about writing FAIL for an old fault".
     5. A new **ONE WARNING LINE ONLY** paragraph. It explains that the capacity line hides the head warning with the 0.1 m downpipe, and gives the DERIVED Qmax figures. It says to type a 0.15 m downpipe, and to mark any reading where the capacity line still shows as "CAPACITY LINE ON TOP" (not judged).
4. **H1-02 steps.**
   - BEFORE: "(2) For EACH typed head in this order: 0.25 , 0.40 , 0.30 , 0.84 …" and "(3) The bug entry's own example, REPORTED: … type 100, Tab ; click "Available head (m)" …" and "(4) … computed by you from the numbers on the screen, never judged".
   - AFTER: "(2) Click "Downpipe dia (m):", Ctrl+A, type 0.15, press Tab once. Then for EACH typed head in this order: 0.28 , 0.40 , 0.30 , 0.84 …" and "(3) The bug entry's own example: … type 100, Tab ; click "Downpipe dia (m):", Ctrl+A, type 0.1, Tab ; click "Available head (m)" …" and "(4) … computed by you from the numbers on the screen". The TYPED-HEAD and HEAD-LEFT lines are kept word for word.
5. **New EXPECTED line.** It applies only when the gate is open, and uses the Total loss shown on screen. The head warning shows when typed minus Total loss is under 300 mm. The DERIVED readings are:
   1. 0.28 leaves about 60 mm: SHOWN.
   2. 0.40 leaves about 180 mm (about 0.18 m): SHOWN.
   3. 0.30 leaves about 80 mm: SHOWN.
   4. 0.84 leaves about 620 mm: NOT SHOWN.
   5. C5 (100 m2, 0.1 m downpipe, 0.25): 3.15 L/s, loss about 0.016 m, 234 mm left, Qmax about 13.79 L/s: SHOWN.
   6. OLD FAULT: it shows for 0.28 and C5 but NOT for 0.40 or 0.30.
6. **RESULT line.**
   - BEFORE: "RESULT: SEEN = all five readings written with both lines each. … Never write PASS or FAIL for H1-02: whichever meaning Tim chooses, the desk judges it from your lines. Write DIFFERENT only if the window has no head warning at all for a typed 0.25 …"
   - AFTER:
     1. **PASS:** on a build past the gate, the warning is SHOWN exactly when HEAD-LEFT says UNDER. Readings marked CAPACITY LINE ON TOP are left out, and PASS needs C2 (0.40) and C3 (0.30) judged. The flow results stay on screen, and any head figure named agrees with typed minus Total loss within 10 mm.
     2. **FAIL:** "FAIL (keys on the typed head)" (shown at 0.28, not at 0.40 or 0.30), or "FAIL (no warning at <h> mm)".
     3. **DIFFERENT:** the right timing but the typed head named, a minimum other than 300, or the results vanishing.
     4. **NOT TESTED:** the gate is shut.
     5. **BLOCKED:** a box could not be typed into (N7).
     6. "In EVERY case, PASS or not, copy every warning line word for word."
7. **Short launcher.**
   - BEFORE: "… and what the Charged System tab says about the 300 mm minimum head, reported for Tim)".
   - AFTER: "… and whether the Charged System tab's 300 mm minimum head warning uses the head left after pipe losses, as Tim ruled on 29 Oct; NOT TESTED until a build carrying that change is installed)".

Unchanged in H1: H1-01 (BUG-1101), the settings and switch reading, the fixture, N1 to N17 and the clean end. The launcher still says no setting is changed: the 0.15 m downpipe is a value typed into the window, not a setting.

---

# REPORT

1. **Done:**
   1. This plan.
   2. H1 updated in both files. I found and fixed the one-warning-line trap, which would have made H1-02's judgement meaningless with the old inputs.
   3. No robot drafts, because none can be driven.
2. **Read:**
   1. `C:\TimOS\RULES.md`.
   2. Decisions items 29 to 34.
   3. The test list entries 7, 11, 31, 32 and 39.
   4. The five BUG_CARPARK entries.
   5. Batch 3 and 4 reports, and the no-fix triage.
   6. Monday question 21(a).
   7. Rulebook detention block and R-01, R-03, R-13, R-27.
   8. Both H1 files.
   9. The runner's validate path.
   10. Source on 26z and 29a: the Charged System view model read by me; the rest through a helper's source reading with file and line references, cross-checked against the bug entries' own figures.
3. **Learnt (recorded here):**
   1. CDCALC's Charged System tab shows only the first warning, so the capacity line hides the head warning.
   2. None of CDCALC, CDDESIGN or the sizer reports anything to the command line, log or a file.
   3. The `pr/905`, `pr/1088` … remote branches are PR numbers, not bug numbers.
4. **NOT verified:**
   1. Any figure on screen.
   2. The installed DLL version.
   3. The `cx6/bug-1095-bd21` behaviour, beyond the helper's reading.
   4. How Boyd's learns the job's council.
   5. How CDDESIGN gets the connection flow.
   6. That H1 reads cleanly to Codex. It has not been run.
   7. PR #1772's live state on GitHub (the `gh` tool is not on this PC's path; I used git history).
5. **Not edited:** the test list, BUG_CARPARK, the driver, the runner, existing cases, the ledger and DESK_LOG.
