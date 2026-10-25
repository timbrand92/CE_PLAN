# Runner case review, B3 fixes: R01 to R10 and R31 to R40 re-checked on Civil 3.0.75 (Opus independent review, Sun 25 Oct 2026)

Written Sun 25 Oct 2026, about 15:10 to 15:45 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, lock, case, variant, settings, run report or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched, nothing committed or pushed. The Team job tester_run59 was using the runner (ledger rows b3bd1 and b3bd2 for R12, R19b and R28 appeared at 15:16 and 15:20 while I worked); I did not touch it and did not judge those rows. The only files written are this one and six `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Contract: the asks of `RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md` (R01 to R10) and `RUNNER_CASE_REVIEW_B3_2026-10-25.md` (R31 to R40). Shape: `RUNNER_CASE_REVIEW_B2FIX_2026-10-25.md`.

## FOR TIM

1. **6 more cases are ready to count as Claude-accepted on today's build (Civil 3.0.75):** a new pipe joins a pit at either end and the Pit Schedule shows it (R02 and R02b), Settings Cancel throws a change away (R07), "ignore a finding" switched off changes nothing (R10), the Pit Schedule row of P3 matches the plan (R38), and CD "use a line I drew" works on a plain line (R39).
2. **Everyday tools accepted on today's build: 5 of 40** (was 4). New: D03, "a new pipe joins the pit it lands on". 7 of 40 on any build.
3. **2 bugs may now be written "FIXED (Claude-accepted)":** BUG-863 ("ignore a finding" switched off still saved the drawing's CE record) and BUG-697 (CD, E refused every plain line as "already a CE pipe").
4. **The four faults the robot found are real, but one is different from what the report says.** The double-click on a new downpipe (BUG-859): CE's own log shows the new fix DOES catch the double-click, but AutoCAD's attribute editor still opens first, and CE's window only comes after you close AutoCAD's one. You would see two windows in a row.
5. **One new bug should be filed:** CDFW typed at an inspection opening is refused with "A nearby pipe's Civil record changed while you picked. Pick again." Nothing changed. CE's own log shows CE itself rewriting pipe end records during the pick, so picking again gives the same refusal forever.
6. **One wording fault:** copying a pit with the cover-text layer locked, CE says the copy got "no label or cover text", but it does draw the label (P8). Only the cover text is missing. This belongs to BUG-672, which asks CE to name only the one thing it skipped.
7. **The "1 IN 54" label in R01 is not a CE fault.** The robot drew a 5.4 m pipe by mistake, and 0.1 m over 5.4 m really is 1 in 54.
8. **Nothing for you to decide now.** Your Monday question about the Settings tick for ROTATE Copy and SCALE Copy still stands. With the tick on, ROTATE Copy gives the copy its own number but still no label and no cover text.

---

**What I read:** the builder's report `release-v3-colleagues-RUNNER_B3_FIXES_REPORT.md` (all of it); the harden, batch 3 and B2FIX reviews; RULES.md and the Claude-accepted decision; the case files R02, R02b, R04, R06, R07, R09, R10, R32, R32b, R33, R34s, R34sn, R34so, R36, R36e, R37b, R38, R39, R40 and the variants R02b, R04_SAVE, R06, R07_SETTING, R09_OFF broken; `SETUP-P8.setup.txt`; `R16_tidy_labels_names_the_pipe.review.txt` (format) and the existing review files of R02, R04, R07, R10, R15, R16, R17, R20; the review gate in `case_runner.ps1` (lines 116 to 122); `runner-reports\ledger.json` (378 rows at 15:12, 389 at 15:20) joined row by row to today's file hashes, which I took myself with sha256sum; the check lines of the run reports b3z1, b3z2, b3z3, b3z4, b3z5, b3y1, b3y2a, b3y2b, b3x1, b3x2, b3a2, b3v2, b3p4; the Civil structured log `ce_cvl_structured_20261025.log` at every R09 double-click (10:11, 12:38, 12:48, 14:20, 14:33) and every CDFW refusal (10:44 to 14:47); cards D03, D15, D18 and the D-card title list in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; the gap plan's 40 checks (section 3 item 7); BUG-102, BUG-132, BUG-147, BUG-236, BUG-460, BUG-665, BUG-672, BUG-697, BUG-859, BUG-863 and BUG-1222 in `BUG_CARPARK.md`; `git merge-base --is-ancestor dee2744f 2c805a39` (BUG-859 round 3 is in the installed build); the product version of every installed Civil DLL and the creation time of the live bundle folders.

## ANSWER FIRST

1. **Counts (one main verdict per case, 20 cases in the report; R01's "1 IN 54" is a probe item, judged separately in item 4):**
   1. **CLAUDE-ACCEPTED-READY: 6.** R02, R02b, R07, R10, R38, R39. All on **Civil 3.0.75**. Review files written.
   2. **NEEDS BROKEN VARIANT: 0.** R04's red now exists inside AutoCAD and is a true red.
   3. **NEEDS STRONGER ASSERTION: 1.** R33 (it passes while CE prints a sentence that BUG-672 forbids).
   4. **PARTIAL (part only): 4.** R04 (CDREBUILD not driven), R34sn (D15 assertion 2 under a non-default setting), R36 (CDFW in open space only; still claims BUG-147), R37b (renumbering and text height not driven).
   5. **NEEDS CODEX LOOK: 2.** R06, R40.
   6. **FAIL = real fault: 7.** R32 and R32b (BUG-1222), R34, R34s and R34so (BUG-665), R09 (BUG-859, new shape), R36e (new bug, item 6).
2. **Build and ledger checks: true, with the notes below.**
   1. **Build:** the live Civil and Manager bundle `Contents` folders were created at **03:33:02** today; all three Civil DLLs (Legacy, Modern, Net8) read **3.0.75+2c805a39** now. Every ledger row of this job is 08:53 to 14:49 and stamped civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39. No run straddles an install.
   2. **Hashes:** every case and variant hash in the report equals today's file hash. Every PASS and FAIL I count carries it.
   3. **Two separate sessions, current text:** R02 and R02b b3y1 + b3y2b; R04 b3z1-s4 + b3z2-s3; R06 b3z1 + b3z2; R07 b3z4 + b3z5; R10 b3z1 + b3z2; R33, R36, R37b, R38 b3x1 + b3x2; R39, R40 b3y1 + b3y2a; R34sn b3v2 + b3v3. Each pair is two different runs, each its own AutoCAD start. No FAIL on 3.0.75 for any of these texts.
   4. **Reds on the current variant text, each from a check, for the intended reason:** R02_BROKEN (b3y1, b3y2b), R02b_BROKEN (b3y2b, b3x3), R04_SAVE_BROKEN (b3z1, b3z2: only `copy-unchanged` failed, "SHA-256 DE9F338DD743 vs 34BBE37C2EA4"), R06_BROKEN (flipped), R07_SETTING_BROKEN (b3z2, b3z3: "CHANGED: TIM_CE_CADTOOLS\CD_Settings.json"), R07_BROKEN, R10_BROKEN and R10_SAVE_BROKEN (b3z1, b3z2), R33_BROKEN and R33_NUM_BROKEN, R36_BROKEN and R36_AGI_BROKEN, R37b_BROKEN and R37b_COPY_BROKEN, R38_BROKEN and R38_NEAR_BROKEN, R39_BROKEN and R39_SECOND_BROKEN, R34sn_BROKEN.
   5. **Control characters:** my scan of 136 files (cases, variants, setups and review files) finds no C0 or C1 character. R40's backspace is gone. The report says "166 case files"; I count 136 in those folders (the rest may be in `previous`, which I did not scan).
3. **Daily tools (D-numbers) and gap-plan checks accepted ON CIVIL 3.0.75: 5 of 40.**
   1. **D03** (a new pipe joins the only pit at its end), **new**: R02 (start on the pit, card assertions 1 to 4 including the Pit Schedule row) plus R02b (the other end, which UX-PIPE-02 names). Passes b3y1 and b3y2b for both.
   2. **D04** (Esc at CD's third point): R17, b2c1 and b2c2. Unchanged text, review hash matches.
   3. **D17** (CDEDIT leaves your selection): R20, b2c1 and b2c2. Unchanged.
   4. **Recover Inverts** (named check, spec C38): R15, b2a1 and b2a2. Unchanged.
   5. **Tidy labels names the pipe** (named check, spec C37): R16, b2b1 and b2b2. Unchanged; only with Tidy labels switched on, which is OFF in Tim's file.
   6. **How I counted:** one per gap-plan item. An item counts only when its case or cases cover the whole card, have two PASS rows in separate sessions on Civil 3.0.75 with today's file hash, no FAIL on 3.0.75, a red on the current variant text, and a review file naming today's hash. **Reconciliation with the earlier 4 of 40:** the same four (B2FIX review) plus D03. **On any build: 7 of 40** (those 5, plus D01 from R01 and D12 from R03 on 3.0.74; the ledger still has no 3.0.75 row for R01 or R03). Denominator 40 as written in the gap plan (the B2FIX review noted the list adds up to 38).
   7. **Not counted, with the reason:** D18 (R04, CDREBUILD not driven); D15 (no case runs a plain COPY with no setting change plus U; R34sn needs the tick on, R33 needs a locked layer); D28 (R40 is a look case); D07, D21, D23 (R36, R37b, R38 are neighbours only).
   8. **Other Claude-accepted-ready cases on 3.0.75, not among the 40:** R07 (spec C14 plus the eight Settings tabs of C13), R10 (spec C16 switch-off), R38 (Pit Schedule row P3 guard), R39 (BUG-697), plus the earlier R23, R31, R35, R37, R39b.
4. **R01 "1 IN 54" (special item b): I agree it is not a CE fault.**
   1. **The numbers fit exactly.** PRB_ZOOM (b3p4) read VIEWSIZE 30000 before a typed CD pipe and 8149.7 after, centre 160000,-85000 then 160000,-80000. 30000 / 8149.7 = 3.68. The robot's blind clicks meant for 20 m therefore land 20 / 3.68 = 5.43 m apart. PRB_R01 (b3p2) read pipe 2's box from x 157425.8 and its IL texts at x 157625.8 and 162599.2, so about 5.4 m. 0.1 m over 5.4 m is 1 in 54. The label is right for the pipe that exists.
   2. **Limits:** one probe session each, not the ledger. The harden review's doubt (the pointer was exact to the pixel) is answered: the pixel was exact, but the stored view was stale.
   3. **For the runner owner:** SETUP-P8x2 must type the second pipe's points (or re-read the view after pipe 1). **Gap found while checking:** the case hash does not cover the SETUP file, so a SETUP edit changes what an accepted case does without changing its hash. The review gate should hash the SETUP file too.
   4. **Seen in passing, not judged:** something zooms the view to each new typed CD pipe. Whether CE means to do that to a drafter's view is not recorded anywhere I found.
5. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)": 2.**
   1. **BUG-863** (R10): the switch-off path is the whole bug. "Ignoring a finding is switched off in CE Settings. Nothing was changed.", no "Project data saved to DWG" line in the CE log, DBMOD and the selection unchanged, one "Command outcome: CDCHECKIGNORE refused" line. Passes b3z1, b3z2; reds R10_BROKEN and R10_SAVE_BROKEN. Suggested wording: "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026): R10 b3z1 + b3z2, reds R10_BROKEN and R10_SAVE_BROKEN; never run on a build before the fix, the red is a simulated save." Never close or delete the entry (D6).
   2. **BUG-697** (R39 with R39b): the bug tried an open 3-point line and a closed rectangle. R39: the open line is accepted ("[CE] Using the drawn line (3 points) as the pipe route.", New Pipe opens, one pipe), and a line that already is a CE pipe still gets "That line is already a CE pipe" exactly once, with no second pipe. R39b (accepted in the batch 3 review): the closed line is taken with a warning. Suggested wording: "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026): R39 b3y1 + b3y2a, reds R39_BROKEN and R39_SECOND_BROKEN; closed line R39b."
   3. **Not yet, with the reason:**
      1. **BUG-460:** proved by R33's two PIT refusals (label layer, then cover-text layer, count unchanged, true red). But R33's own claim line says CE "reports the one thing skipped", which its evidence shows is false (item 6.3). Correct that line, two passes, a review file: then BUG-460 can be written.
      2. **BUG-672:** the copy now gets its own label (P8) and only the cover text is skipped (behaviour fixed), but CE's sentence says "no label or cover text". BUG-672's expected is "report the one skipped". Stays OPEN.
      3. **BUG-862:** CDCHECKIGNORE logs "refused", but CDEDIT refusals still log "completed" (B2FIX) and the downpipe command is not run.
      4. **BUG-236:** move, erase and copy proved (R37b); renumbering and the text height from Settings not driven.
      5. **BUG-1222, BUG-665, BUG-859:** real faults on 3.0.75 (item 6).
      6. **BUG-147, BUG-132, BUG-102:** R36 runs CDFW in open space only; CDSOURCE never runs; the endpoint-claim route (BUG-147's own words) is refused in R36e for a different reason.
6. **The faults (special item a), owner and what to write:**
   1. **BUG-1222 is wider than filed (R32, R32b), real.** R32: after a reversing save turns the arrow (rotation 3.14), a SECOND Edit Pipe save with nothing typed ("Pipe updated.") puts it back to rotation 0, for the 18.000 / 17.900 pipe and for the 0.00 / 0.50 pipe (b3a1, b3a2). R32b: after the diameter-only save the IL texts stay where they were typed (17.900 at x 150200 west, 18.000 at x 169800 east) while the arrow points east, so uphill. The Edit Pipe window itself said "The levels fall from point 2 to point 1; CE records that as the flow direction." **Text for the desk to add to BUG-1222:** "Wider (runner R32 and R32b, Civil 3.0.75, b3a1 + b3a2, 25 Oct 2026): a second Edit Pipe Save with nothing typed also turns a flipped arrow back; the window's own header says the levels fall from point 2 to point 1, yet the Save draws the arrow from point 1. BUG-223 and BUG-686 stay OPEN: their first save looks right but does not last."
   2. **BUG-665 ROTATE Copy half with the tick ON (R34s, R34so), real.** With `linking.cleanUpGripRotateScaleCopies` true (the guard's SETTING line; SCALE Copy behaving differently from R34 proves the setting took effect): COPY and SCALE Copy each get a PIT LABEL and "CL 18.88"; ROTATE Copy prints "1 pit copied and numbered as new" and adds one pit block, but no PIT LABEL and no cover text. Same with the pivot 5 m away (R34so: the new block sits at 58777.7,-30569.9, the rotated place, so it is the copy that lacks them). Owner BUG-665 (its words name ROTATE Copy). **Text for the desk:** "Civil 3.0.75, 25 Oct 2026, tick ON (R34s b3v2 + b3v3, R34so b3v3 + b3v4): COPY and SCALE Copy right; ROTATE Copy gets its own number but no label and no cover text, about its own centre or a point 5 m away. Tick OFF (R34): ROTATE and SCALE Copy both wrong." No new bug.
   3. **BUG-859 still reproduces for the drafter, but the cause is now different (R09), real.** The report says CE's Edit source window does not open. CE's log says more, at every R09 double-click (10:11:14, 12:38:02, 14:20:27): "double-click hit-test: 1 block(s) under the pointer; source tag = DP1", "pick set emptied so EATTEDIT stops at its prompt", "CANCELCMD posted=true for EATTEDIT", "CDEDIT scheduled at Idle". Then "starting CDEDIT in command context" only 21 to 37 s later, after the robot had closed AutoCAD's Enhanced Attribute Editor. So round 3 finds the block, but AutoCAD's editor still opens, and CE's edit starts only once it is closed. **Text for the desk to add to BUG-859:** "Runner R09 on Civil 3.0.75 (round 3 installed; b3r09a, b3w1, b3z4, 25 Oct 2026): AutoCAD's Enhanced Attribute Editor still opens on a double-click of DP1's outer circle. CE's log shows round 3 catching it (hit-test finds DP1, EATTEDIT cancel posted, CDEDIT scheduled) but CDEDIT starts only after AutoCAD's editor is closed, 21 to 37 s later. The drafter sees AutoCAD's editor first, then CE's." I state nothing about how AutoCAD handles the cancel inside itself.
   4. **CDFW at an inspection opening (R36e): a NEW bug, not BUG-147.** BUG-147 is a rollback on a duplicate tag; this is a refusal that blames a change that never happened. CE's log at 14:46:50 to 14:46:59 (b3x3) shows, between CDFW's preview and its point: about 20 lines "CDRG index filled pipe <handle> ... end key ... from physical start/end", then "[Source] Landing index changed between preview and pick (observations); re-reading once.", the same 20 fills again, then "[Source] The pick was refused: A nearby pipe's Civil record changed while you picked. Pick again." The same pattern at 10:44, 10:45, 11:14 and 13:18. So CE's own filling of missing pipe end records during the pick looks like the change it then refuses. I have not read the code. Full entry in "New bug to file" below.
   5. **The ROTATE Copy schedule lines:** ROTATE Copy and SCALE Copy also print "Pit schedule cell for P3 (inlet from) not updated: the pit or pipe it was placed for no longer matches this drawing's record" for the ORIGINAL P3. Same family as the B3 review's note (a drafter reads lines about pits he did not touch). Not judged.
7. **Things the desk should know first (RULES 6.2):**
   1. **The report is wrong that R09's OFF red "does not discriminate".** It does not at window level, but CE's log does: "EATTEDIT left to AutoCAD: the double-click switch reads OFF" (12:48:55, 14:33:01) against "CDEDIT scheduled at Idle" with the switch on. A log check gives R09 a true red (lines in R09 below).
   2. **R36e is tagged to the wrong bug** (BUG-147). It needs the new bug's number.
   3. **R33's claim line is false by its own evidence** (item 6.3 of the cases).
   4. **R36 still claims BUG-147** in PROVES_BUGS, although the batch 3 review said its floor waste claims no pipe end, and R36e now shows that route is refused.
   5. **R04's top comment is stale:** it still says "no red run is possible inside a case". Cosmetic (changes the hash).
   6. **"Each has a failing broken twin"** (FOR TIM item 1) is not quite true: R32b, R34s, R34so and R36e have none. They are real-fault cases, so their own FAIL is the red; nothing rests on it.

## How I applied the four conditions

1. **Nothing seen on screen.** Met for R02, R02b, R07 (window read as text only; the page look is a Codex item), R10, R38, R39. R06 and R40 are look cases.
2. **Two passes in separate AutoCAD sessions on one build.** ANSWER FIRST item 2.3.
3. **Red before green.** ANSWER FIRST item 2.4. True reds (a real change, not a flipped word): R02_BROKEN and R02b_BROKEN (pipe misses the pit), R04_SAVE_BROKEN (the drawing really saved), R07_SETTING_BROKEN (the settings file really changed), R10_BROKEN (switch on), R10_SAVE_BROKEN (a real save line), R38_NEAR_BROKEN (wrong place), R39_BROKEN (point off the line), R39_SECOND_BROKEN is a flipped red. Flipped: R06_BROKEN, R07_BROKEN, R38_BROKEN.
4. **Compared with the card or bug, and full coverage.** Line by line below.

## The cases

1. **R02: a new pipe started on pit P8 joins it, and the Pit Schedule shows it (D03, UX-PIPE-02).** Verdict: **CLAUDE-ACCEPTED-READY** for D03's start half, on Civil 3.0.75. Hash 807FCF12EFBA. Review file written.
   1. **Asks met:** the harden review's probe and row checks: the schedule opens, row "Pit P8" exists, a cell in that row matches 18.00 (outlet IL) and one reads 225, Close closes it (b3y1, b3y2b). D03 assertions 1 to 4 now all held: the flow line once, one "End is free" line, the box corner at 150225, -80112.5 (the pipe end on the pit wall), the row, no "Flow: Open end".
   2. **Small, optional at the next edit:** the IL pattern `name.:.18\.0+.` would also accept 18.01 to 18.09. Tighter: `name.:.Pit P8.,.id(?:(?!name.:.Pit ).)*?name.:.18\.0+.,.id` and the same `.,.id` ending after `225`.
   3. **Stale NOT_AUTOMATED line (cosmetic):** "a pipe whose SECOND end lands on a pit is not covered" is now covered by R02b.
2. **R02b: a new pipe that ends on pit P8 joins it (D03 other end).** Verdict: **CLAUDE-ACCEPTED-READY** on Civil 3.0.75. Hash 2EF087A67698. Review file written.
   1. **Asks met:** the harden review's twin exactly: CD from 130000,-80000 to the pit, "Flow: Open end -> P8" exactly once, one pipe. The recorded box ends at x 149775, so CE pulled the end back to the pit wall (225 short of the centre).
   2. **The red** (R02b_BROKEN) stops 2 m short and also uses 18.090 to avoid the Grade mismatch question. Two changes, but the levels cannot make "-> P8" appear. Accepted.
   3. **Note:** the y check (-80112.5) does not prove a join by itself (any pipe on that row has it). The proof is CE's flow line plus the recorded box end. Optional: make the box end a check when the runner can read a box's right edge.
3. **R04: CE never saves the drawing (D18, UX-STD-03).** Verdict: **PARTIAL.** It counts for "after PIT, CD, CDSYNC, CDRECOVERINVERTS and PITSCHEDULE the file on disk is byte-identical and nothing new appears beside it".
   1. **The red (special item d):** R04_SAVE_BROKEN is the twin the harden review asked for. The new `save-copy` step is refused unless the case is a broken variant. It failed only `copy-unchanged` in both runs, for the right reason. A true red.
   2. **PITSCHEDULE (D18 assertion 1 route):** done, opened and closed.
   3. **Still missing, D18 assertion 2:** CDREBUILD. **Lines:** probe CDREBUILD's prompts once (record only); then after CDRECOVERINVERTS `type "CDREBUILD" -Force -TimeoutSec 120 -> $rb`, answer its prompts as the probe shows, `wait`, and ASSERT `contains $rb "it does not save the drawing itself"` and `history has "It does not save the drawing."`. Copy the same lines into R04_SAVE_BROKEN.
   4. **Cosmetic at that edit:** the top comment ("no red run is possible inside a case").
4. **R06: About CE Suite (spec C12).** Verdict: **NEEDS CODEX LOOK.** Hash 6D94611EC40B; passes b3z1, b3z2; flipped red. PLAN_ITEM relabelled and "AutoCAD" / ".NET" checks added, as asked. The look note and picture exist (`case_RUN-20261025-1349-C3.0.75-b3z2\looks\R06.md`). Cosmetic: EXPECTED still quotes v3.0.70 as its example.
5. **R07: Settings opens, Cancel throws a change away (spec C14; C13 tab list).** Verdict: **CLAUDE-ACCEPTED-READY** for spec C14 and the eight-tab part of C13, on Civil 3.0.75. Hash 7D08DB109F80. Review file written.
   1. **Gap 1 closed:** the box reads 125 before the change and 125 again on a second open after the Cancel, with "No changes. Everything shown is saved." (b3z4, b3z5). A Cancel that kept 123 in memory would now fail.
   2. **Gap 2 closed:** `hashes-unchanged` has now gone red (R07_SETTING_BROKEN, CD_Settings.json ACD64E79A33B to 9D27B04C87C3, file restored after). It proves the check sees a changed file. It does not prove that a Save press writes the file. That is not R07's claim (Cancel writes nothing), so I accept it.
   3. **Not covered:** C13's page look (Codex). **For the runner owner:** the v2 allow-list still names "Save"; the button is now "Settings, Save". Not a case fault.
6. **R09: double-click on DP1 (BUG-859, spec C04).** Verdict: **FAIL = real fault** (ANSWER FIRST item 6.3), and **NEEDS STRONGER ASSERTION** for its red.
   1. **Asks met:** run first unchanged on 3.0.75 (b3r09a); Cancel by `ui-press` and `window-closed`. Not done: the Tag box name (the window never opened while the robot looked), the red centre and the angled text (runner gap).
   2. **Lines to add:**
      1. ASSERT `log civil has "TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle"` (shows CE caught the double-click).
      2. After `close-windows`: `sleep 10`, `windows-snapshot -> $w_after`, `ui-dump "Edit source" -Optional -TimeoutSec 30 -> $es2`, `record $w_after "windows after AutoCAD's editor was closed"`, `ui-press "Edit source" "Cancel" -Optional -> $esc2`, `close-windows`. This records whether CE's window opens second, which is BUG-859's new shape.
      3. In R09_OFF_BROKEN: the same log line. It will fail there ("EATTEDIT left to AutoCAD: the double-click switch reads OFF"), so the variant becomes a true red.
   3. **Cosmetic:** the top comment still speaks of Civil 3.0.70 and round 2.
7. **R10: CDCHECKIGNORE with the switch off (spec C16; BUG-863; BUG-862 refused half for this command).** Verdict: **CLAUDE-ACCEPTED-READY** on Civil 3.0.75. Hash AB3377887B1D. Review file written.
   1. **Asks met:** both pick-first reads "0 object(s)"; no "Command outcome" text on the command line; the outcome line once in the CE log, "refused". All C16 lines held.
   2. **Limit, not a blocker:** the selection was empty before, so the check cannot show a selection being cleared. C16 says "equal baseline", which holds.
8. **R32: Edit Pipe flips the arrow (BUG-223, BUG-686; now EXPECT-FAIL BUG-1222).** Verdict: **FAIL = real fault**, b3a1 and b3a2 (27 of 29). The batch 3 review's lines were added word for word; they fail as predicted. IL ends pinned by x. **Optional line:** after `$arrowA2`, re-read the IL texts and their x (`select ... "text~^IL 17\.900$"`, `field ... x`), so the record shows the levels also stayed after the plain save (R32b already shows it for the size-only save).
9. **R32b: size-only save turns a flipped arrow back (BUG-1222).** Verdict: **FAIL = real fault**, b3a1 and b3a2 (19 of 20). Retagged BUG-1222, ui-dump added, IL ends pinned: all asks met.
10. **R33: locked pit text layers (BUG-460, BUG-672, BUG-262 half).** Verdict: **NEEDS STRONGER ASSERTION** (special item c).
    1. **Asks met:** the copy's label is read (`text":"P8"`, tag PIT_LABEL, layer STORMWATER PIT LABEL); the whole COPY reply is recorded. True reds for both (no lock; expects P3).
    2. **Is "no label" a wording bug? Yes.** COPY selected 1 object (the pit). CE then added a PIT LABEL block (index 1035, after the pit) and numbered it P8. CE's sentence is "[CE] 1 copied pit(s) got their own number but no label or cover text: layer 25TEXT is locked, and CE does not draw on it. Undo (U), unlock layer 25TEXT, then copy again." A drafter told "no label" would undo good work. BUG-672's expected is "copy what sits on open layers and report the one skipped"; CE does the first and not the second. It is BUG-672's message half, not a new bug.
    3. **Why stronger, not ready:** R33's PROVES_BUGS says CE "reports the one thing skipped, the cover text", and its evidence shows the opposite. The case passes because it pins only part of the sentence.
    4. **Lines:**
       1. In R33, change the BUG-672 part of PROVES_BUGS to "BUG-672 behaviour half only: the copy gets its own number label, only the cover text is skipped; the message half is R33m".
       2. New case **R33m** (R33's COPY part only, `EXPECT-FAIL BUG-672`): ASSERT `not-contains $cp1 "no label"` and `contains $cp1 "layer 25TEXT is locked"`.
       3. Two passes of R33 on its new text; then R33 is ready for BUG-460 and the COPY behaviour, and BUG-460 can be written FIXED.
11. **R34: ROTATE and SCALE Copy, tick OFF (BUG-665).** Verdict: **FAIL = real fault**, unchanged text, five FAIL rows on 3.0.75.
12. **R34s: the same, tick ON (BUG-665).** Verdict: **FAIL = real fault**, b3v2 and b3v3 (20 of 21: only the ROTATE Copy label). The tick was really on (SCALE Copy behaves differently from R34). Item 6.2.
13. **R34so: ROTATE Copy about a point 5 m away, tick ON (BUG-665).** Verdict: **FAIL = real fault**, b3v3 and b3v4. Shows the missing label belongs to ROTATE Copy itself.
14. **R34sn: the copies' numbers, tick ON.** Verdict: **PARTIAL.** It counts for "with the tick on, the COPY and the SCALE Copy of P3 each get a label that is not P3" (P8 and P12, b3v2 and b3v3; flipped red).
    1. **Why not D15:** D15 is a plain COPY with no setting changed, and it also asks for the "Check levels" line, the original still reading P3, and one U back. This case changes a setting and does none of those.
    2. **Line for D15 (the batch 3 review's R34a, still to do):** fresh DRV1_B1, no SETTING; `pick-first "109D56"`, `_.COPY` 0,0 to 0,-5000; ASSERT `contains $cp "1 pit copied and numbered as new. Check levels: they came across from the originals"`; the copy's PIT LABEL read as in R34sn and `matches ... P(?!3.,)`; the original's label read by `near=53777.7,-25569.9` and `matches ... "text.:.P3.,"`; then `type "U"`, `ms-count` equal to before. A flipped red expecting P3.
    3. **Small:** the title says the two numbers differ; that is recorded, not asserted. The SETTING line appears twice (cosmetic).
15. **R36: CDFW with four AGI blocks (BUG-147, BUG-132, BUG-102).** Verdict: **PARTIAL.** It counts for "CDFW in open space, with four blocks tagged AGI, places one floor waste, says 'The source name 'AGI' is on 4 blocks. Nothing was stopped by it.', Esc places nothing, one U takes it back" (b3x1, b3x2; two reds).
    1. **Gap 1 closed** (the duplicate tag line asserted).
    2. **Not covered:** the endpoint-claim route (R36e, refused), and CDSOURCE, which all three bugs name.
    3. **Line:** drop BUG-147 from R36's PROVES_BUGS (its route is R36e's). Then it is part of BUG-132 and BUG-102 (the CDFW half) only.
16. **R36e: CDFW typed at an inspection opening.** Verdict: **FAIL = real fault** (b3x2, b3x3), owner a new bug (item 6.4 and the entry below).
    1. **Its expectation needs Tim's intent for one word:** the case expects "Floor waste placed." Whether a floor waste may sit on an inspection opening's point is a design choice, not recorded. The fault itself (a refusal naming a change that never happened, which repeats every time) is real either way.
    2. **Lines:** retag `EXPECT-FAIL BUG-<new>`; add `log civil has "Landing index changed between preview and pick"` as a record (it names the cause); EXPECTED says "one U takes the floor waste back" but the case has no U step (add one after a placement, or drop the words).
    3. **Not driven:** a real mouse pick at the same place.
17. **R37b: the PD text follows MOVE, ERASE and COPY (BUG-236).** Verdict: **PARTIAL.** It counts for move, erase and copy: the text moves exactly 1000, goes with the drain, and a COPY gets "Perimeter drain copy is PD2: it has its own record and its own PD2 text." with "PD1 | PD2" and the copy's text 3000 higher (b3x1, b3x2; true red and a flipped copy red).
    1. **Not covered:** renumbering, and the text height from Settings, both in BUG-236's own words.
    2. **Lines:** find the Settings key for the perimeter drain text height (R-00); a SETTING twin with a different height; a runner step that reads an MText's height (the runner owner; `ent-read` gives none today); ASSERT the new height. Renumbering: probe first how a drafter renumbers a drain.
18. **R38: Pit Schedule row P3 against the plan.** Verdict: **CLAUDE-ACCEPTED-READY** for "Pit Schedule row P3 guard", on Civil 3.0.75. Hash 2A94934EBE91. Review file written.
    1. **Asks met:** both levels tied to P3: exactly one IL 17.30 text (1155B6) and one IL 17.25 text (1101B8) within 2.5 m of P3. The BUG-376 claim dropped and the plan item renamed, as the batch 3 review allowed if the probe found no 18.10 cell.
    2. **Small, optional:** the three chunk handles are joined with no separator, so two texts in different chunks would read as one long hex string and still pass. Use `"{$inh0}|{$inh5}|{$inh10}"` and match `^\|*[0-9A-F]+\|*$`.
    3. **For the desk (Unknown, file nothing):** P3 has six pipe ends, but its row lists one inlet (from P4). Whether the schedule should also list the IO8 inlet (IL 18.10, 750 mm west of P3) is not recorded.
19. **R39: CD, E on a plain line (BUG-697).** Verdict: **CLAUDE-ACCEPTED-READY** for BUG-697 (with R39b for the closed line), on Civil 3.0.75. Hash 0FBBAD9920F0. Review file written.
    1. **Asks met, all three:** the bug's own line asserted; the label anchored ("AT 1 IN 101"); the other half (a second CD, E on the CE pipe says "already a CE pipe" once, no New Pipe, still one pipe). Two true reds.
    2. **Recorded, not judged:** the drawn straight polyline is gone after Start Pipe (replaced by the pipe); arc and closed lines are kept (R39b). No card says which is right.
20. **R40: CDCHECKDWG (D28).** Verdict: **NEEDS CODEX LOOK.** Hash CAB6A794E695; b3y1, b3y2a. Asks met: backspace removed (my scan agrees), the stale REVIEWED_AGAINST sentence replaced, C1 dropped, the never-red folder check said in the case. BUG-606's approved report location is still unrecorded (desk question).

## New bug to file (the next free id; the carpark header says BUG-1221 but BUG-1222 is already used, so the desk checks)

**Command / Area:** CDFW (floor waste), typed point on an inspection opening that sits on pipe ends, Civil 3.0.75 (runner case R36e, two runs b3x2 and b3x3, probes b3p2 and b3p3, 25 Oct 2026).

**Symptom:** MEDIUM, BLOCKS WORK. Type CDFW and give the point of an inspection opening on DRV1_B1. CE prints "[CE] A nearby pipe's Civil record changed while you picked. Pick again, or press Esc." and places nothing. Nothing changed: no other command ran. Picking again gives the same answer. CE's own log, between the preview and the point, shows about 20 lines "CDRG index filled pipe <handle> ... end key ... from physical start/end", then "[Source] Landing index changed between preview and pick (observations); re-reading once.", the same fills again, then "[Source] The pick was refused: A nearby pipe's Civil record changed while you picked. Pick again." So CE's own filling of missing pipe end records looks like the change it refuses (log 25 Oct 2026 14:46:50 to 14:46:59; same at 10:44, 10:45, 11:14, 13:18). Code not read.

**Expected behaviour:** either the floor waste is placed and joined, or CE gives one plain reason naming what stops it (for example "an inspection opening already sits on this pipe end"). Never "changed while you picked" when nothing changed, and never "Pick again" when picking again cannot succeed. Which of the two (place or refuse) is right is Tim's call.

**Reference:** areas/RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md item 6.4; runner case R36e; areas/release-v3-colleagues-RUNNER_B3_FIXES_REPORT.md item 5(d). Related, not duplicates: BUG-147 (rollback on a duplicate AGI tag via endpoint claims), BUG-132, BUG-102.

**Test that catches it:** runner case R36e (retag `EXPECT-FAIL BUG-<this id>`); it asserts no "Civil record changed" line.

**Steps to confirm in AutoCAD:** fresh copy of DRV1_B1. Type CDFW, Enter, then type 51777.389,-46593.223, Enter. Right looks like: a floor waste placed, or one plain sentence saying why not; wrong is "A nearby pipe's Civil record changed while you picked". Repeat at 51777.389,-30233.425, 55879.087,-30233.481 and 80936.111,-30304.267. Esc ends it ("CDFW cancelled - nothing was placed.").

**Status:** OPEN

## For the runner owner (not case faults, listed so they are not lost)

1. **Hash the SETUP file in the review gate** (item 4.3): today a SETUP edit changes an accepted case's behaviour without changing its hash.
2. **SETUP-P8x2:** type the second pipe's points, or re-read the view after the first pipe.
3. **The v2 allow-list** names "Save" in Settings; the button is now "Settings, Save".
4. **A step that reads an MText's height** (BUG-236) and a box's right edge (R02b).
5. **Still open from earlier reviews:** a red only for `BUG` cases; case-blind text checks; `folder-new-only` passes when nothing appears; the build stamp read before the lock wait.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Results are read from the ledger, the run reports and the CE log.
2. **I looked at no picture.** R06's and R40's pictures are untouched.
3. **Installed code:** not read. The BUG-859 and CDFW explanations come from CE's own log lines, not the code.
4. **The runner change** (`save-copy`, `settings-set`, hash A229DC0BAFA1): I did not diff it against the backup; I judged only that both reds failed for the right reason.
5. **Tim's four settings files:** I relied on each run's end-of-session fingerprints (0 differences in every session I read).
6. **The probe runs b3p1, b3p3, b3pz, b3z1s** were not read, except the CE log lines at their times.
7. **Not re-reviewed:** R01, R03, R05, R08, R11 to R31, R35, R37, R39b; the tester_run59 rows (R12, R19b, R28, after 15:08).

## Files written

1. `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md` (this file).
2. `C:\Lisp Files\_ACAD_DRIVER\cases\R02_pipe_joins_pit.review.txt` (replaced; case hash 807FCF12EFBA...).
3. `C:\Lisp Files\_ACAD_DRIVER\cases\R02b_pipe_ends_on_pit.review.txt` (new; 2EF087A67698...).
4. `C:\Lisp Files\_ACAD_DRIVER\cases\R07_settings_window_cancel.review.txt` (replaced; 7D08DB109F80...).
5. `C:\Lisp Files\_ACAD_DRIVER\cases\R10_cdcheckignore_switch_off.review.txt` (replaced; AB3377887B1D...).
6. `C:\Lisp Files\_ACAD_DRIVER\cases\R38_pit_schedule_il_cells_match_plan.review.txt` (new; 2A94934EBE91...).
7. `C:\Lisp Files\_ACAD_DRIVER\cases\R39_cd_existing_line_opens_new_pipe.review.txt` (new; 0FBBAD9920F0...).

No review file for any other case. The old R04, R06 and R09 review files still name old texts, so the runner will not count them.

## Summary

Six cases are Claude-accepted-ready on Civil 3.0.75: R02 and R02b (D03, a new pipe joins its pit at either end), R07, R10, R38 and R39. Everyday tools accepted on 3.0.75: 5 of 40 (D03 added), 7 on any build. BUG-863 and BUG-697 may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)". The four faults are real. BUG-859 now opens AutoCAD's editor first and CE's edit second (CE's log). CDFW at an inspection opening needs a new bug. R33's "no label" is BUG-672's message half. R01's 1 IN 54 is the robot's stale view.
