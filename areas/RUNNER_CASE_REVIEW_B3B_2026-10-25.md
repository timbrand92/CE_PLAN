# Runner case review, B3b: R12, R19b, R28 re-checked and R01, R03, R05, R08 on Civil 3.0.75 (Opus independent review, Sun 25 Oct 2026)

Written Sun 25 Oct 2026, about 16:40 to 17:10 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, lock, case, variant, settings, run report or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched, nothing committed or pushed. The Team job tester_run60 may be using the runner; I did not touch it. The only files written are this one and two `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Contract: the asks of `RUNNER_CASE_REVIEW_B2FIX_2026-10-25.md` for R12, R19b and R28. Shape: `RUNNER_CASE_REVIEW_B2FIX_2026-10-25.md` and `RUNNER_CASE_REVIEW_B3FIX_2026-10-25.md`.

## FOR TIM

1. **Everyday tools accepted on today's build (Civil 3.0.75): 8 of 40** (was 5). New: PIT and CD keep placing until Esc (D01), one IL text at each pipe end (D12), and erasing a pit keeps its six pipes and one U brings it back (D14).
2. **The robot found a real-looking fault in today's build.** Draw a line, type U, click a pit once, type REDO: AutoCAD says "Nothing to redo" the first time you do it after AutoCAD starts. After that it works. On yesterday's build the same steps worked every time. This is BUG-861, which Codex first reported. The cause is not known yet.
3. **The quick MOVE check is nearly there, not yet.** The pit, its name label, its cover level and two of its six IL texts move with it and come back after one U. Four IL texts are not checked after the U, and the "no CE window opens" check has never been shown to fail.
4. **No bug can be newly written fixed from this batch.** The three from earlier today still stand (BUG-384, BUG-863, BUG-697).
5. **Nothing for you to decide now.**

---

**What I read:** the builder's report `release-v3-colleagues-RUNNER_B3B_REPORT.md` (all of it); the B2FIX and B3FIX reviews (all of B3FIX, the R12, R19b and R28 sections and counts of B2FIX); the harden review's R08 and BUG-861 sections; RULES.md (all of it, with its amendments); cards C41 (`TEST_CASES_DRAFT_22OCT.md`) and D14 (`DAILY_TOOLS_TEST_CASES_2026-10-23.md`); the gap plan line for the 40 checks and the W1-02 line of the acceptance backlog; the case files R08, R12, R19b, R28 and the variants R12_NOU_BROKEN, R12_BROKEN, R19b_BROKEN, R19b_COUNT_BROKEN, R19b_PIPE_BROKEN, R28_BROKEN; the review files of R01, R03, R05, R08, R12 and R16 (format); the review gate in `case_runner.ps1` (lines 115 to 125); `runner-reports\ledger.json` (399 rows at 16:28) joined row by row to today's file hashes, which I took myself (sha256sum); the R08 step lists of b3bh2 (s1, s2), b3bh4 (s1, s2), hdnA4 and hdnB4b from their JSON reports; the R12, R19b and R28 check lines of b3bd1 and b3bd2; the Civil structured log `ce_cvl_structured_20261025.log` for every R08 round in those six sessions; the diff of `case_runner_lib.ps1` between 5AB2CBC1A5A0 (the 3.0.74 runs) and A229DC0BAFA1 (the 3.0.75 runs); the list of Civil files changed between a15b414c (3.0.74) and 2c805a39 (3.0.75); the product version of the three installed Civil DLLs and the creation time of the live bundle folders; the SETUP-P8 and SETUP-P8x2 files' hashes and dates.

## ANSWER FIRST

1. **Counts (one main verdict per case, 7 cases):**
   1. **CLAUDE-ACCEPTED-READY: 5.** R19b and R28 (new texts, review files written today), R01, R03, R05 (unchanged texts, their review files still match, now passed twice on 3.0.75). All on **Civil 3.0.75**.
   2. **NEEDS STRONGER ASSERTION: 1.** R12 (four IL texts not checked after U; the no-window check has never gone red).
   3. **NEEDS BROKEN VARIANT: 0. PARTIAL: 0. NEEDS CODEX LOOK: 0.**
   4. **FAIL = real fault, cause unknown: 1.** R08 (BUG-861, round 1 only, 4 of 4 fresh sessions on 3.0.75). Not a case fault (item 6).
2. **Build and ledger checks: true, with one correction (item 7.1).**
   1. **Build:** the live Civil and Manager bundle `Contents` folders were created at **03:33:02** today; the Legacy, Modern and Net8 Civil DLLs all read **3.0.75+2c805a39** (read at about 16:50). Every ledger row of this job is 15:16 to 16:28 and stamped civil 3.0.75+2c805a39 / struc 1.0.123+4af3f37d / mgr 1.1.75+2c805a39. The 3.0.74 R08 passes (02:28 and 03:18) were before the install. No run straddles it.
   2. **Hashes:** every case and variant hash in the report equals today's file hash: R12 85BAD74AEDEB, R19b 3536E3A4615D, R28 7F29403F16E7, R01 99BC70E23675, R03 4384D2D7B6B9, R05 4E5A615417F8, R08 4A42C588E549; variants R12_NOU_BROKEN D70D7B7AA3E1, R19b_BROKEN 4729BB887F19, R19b_COUNT_BROKEN 519375085E7C, R19b_PIPE_BROKEN 0B5739E993B4, R28_BROKEN E8665FBDA33C. R01, R03, R05 and R08 equal the hash in their review files.
   3. **Two separate sessions, current text, 3.0.75:** R12, R19b, R28 in b3bd1-s1 and b3bd2-s1; R01, R03 in b3bh1-s1 and b3bh3-s1; R05 in b3bh2-s1 and b3bh4-s1. Each pair is two different runs, each its own AutoCAD start. No FAIL on 3.0.75 for any of these texts.
   4. **Reds on the current variant text:** R12_NOU_BROKEN (b3bd1, from checks: 1990.3, 1988, 2000, 2000 against 0 +- 0.5); R19b_COUNT_BROKEN (b3bd1, from a check: 1030 against 1031); R19b_BROKEN (b3bd1, from a check, flipped); R19b_PIPE_BROKEN (b3bd1, NOT from a check: "ent-read 109E23: ... Unspecified error (E_FAIL)", the ledger row says `from_check` false); R28_BROKEN (b3bd1, from checks: "Select a CE pit block.", no window, no P3). R01_BROKEN 8D6A64A5E2DF, R03_BROKEN 5306E08120E5 and R05_BROKEN ADF4E7646481 still equal the files that failed on 3.0.74 (hdnA2v, hdnA5).
   5. **The runner printed ACCEPTED-READY** for R01 and R03 (b3bh3) and R05 (b3bh4). I confirmed the lines in the reports.
3. **Daily tools (D-numbers) and gap-plan checks accepted ON CIVIL 3.0.75: 8 of 40.**
   1. **D01** (PIT and CD keep placing until Esc): R01, b3bh1 and b3bh3. **Moved from 3.0.74 to 3.0.75.**
   2. **D03** (a new pipe joins the pit at either end): R02 and R02b (B3FIX).
   3. **D04** (Esc at CD's third point): R17.
   4. **D12** (one IL text at each pipe end): R03, b3bh1 and b3bh3. **Moved from 3.0.74 to 3.0.75.**
   5. **D14** (erasing a pit keeps its pipes, says how many, one U restores it): R19b, b3bd1 and b3bd2. **New.**
   6. **D17** (CDEDIT leaves your selection): R20.
   7. **Recover Inverts** (spec C38): R15.
   8. **Tidy labels names the pipe** (spec C37): R16. Only with Tidy labels switched on, which is OFF in Tim's file.
   9. **How I counted, to reconcile with the earlier figures:** one per gap-plan item. An item counts only when its case or cases cover the whole card, have two PASS rows in separate sessions on Civil 3.0.75 with today's file hash, no FAIL on 3.0.75, a red on the current variant text, and a review file naming today's hash. **B3FIX said 5 of 40 on 3.0.75 and 7 counting 3.0.74.** Those 7 are now all on 3.0.75 (D01 and D12 re-proved today), plus D14 = **8 of 40 on 3.0.75; 8 on any build** (no item is held on 3.0.74 only any more). Denominator 40 as the gap plan writes it (the list adds up to 38; earlier reviews noted this).
   10. **Not counted, with the reason:** quick MOVE (R12, item 4 of the cases); D15, D18, D28, D07, D21, D23 as in B3FIX (unchanged).
   11. **Other Claude-accepted-ready cases on 3.0.75, not among the 40:** R05 (#1507, now on 3.0.75), R28 (CDPROFILE start, new), and from earlier R07, R10, R23, R31, R35, R37, R38, R39, R39b. **R08 drops out:** it was ready on 3.0.74 only and fails on 3.0.75.
4. **Bugs that may be written "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)": none new from this batch.**
   1. **Why none:** R19b, R12 and R28 claim no bug; R01, R03 and R05 prove halves of BUG-862, which stays OPEN (CDEDIT refusals still log "completed", B2FIX item 6.1).
   2. **Still standing from earlier today:** BUG-384 (B2FIX), BUG-863 and BUG-697 (B3FIX), with the wording given there. Never close or delete an entry (D6).
5. **R19b's tool-error red (the report's question):** enough reds without it. R19b_COUNT_BROKEN is a true red from a check, and the count check alone would also catch a pipe erased with the pit (1030, not 1031). R19b_PIPE_BROKEN adds that a missing pipe cannot pass quietly: reading an erased pipe stops the case, and the runner records FAIL. R19b_BROKEN is a flipped red for the six in the sentence. Accepted.
6. **R08, my reading: a possible CE regression in 3.0.75. Not a case problem; a timing cause is unlikely but not ruled out.**
   1. **The robot did the same thing both days.** I compared the step lists: same case text, same click point (pixel 2728,706, read back exactly), same calibration (1.686 px raw), same view, same driver files (v2 120EE24D15B2, v3 7CADBF80D5AA, v3 session 9A7B8D210C7F), same four settings fingerprints, same fixture hash. Each step took the same time within about a second on 3.0.74 (hdnA4, hdnB4b) and 3.0.75 (b3bh2, b3bh4). The s2 sessions on 3.0.75 were a fresh AutoCAD with R08 first, exactly like the 3.0.74 passes, and still failed.
   2. **The runner's library did change in between** (5AB2CBC1A5A0 to A229DC0BAFA1, 12:29 today). I diffed it: it only adds two steps (`save-copy`, `settings-set`) that only broken variants may use. R08 uses neither. It does not explain R08.
   3. **CE's own log shows nothing different in the failing round.** In every round of every session, both builds, CE logs the same three lines after the click: "[CivilGripProbe] callback-cache-miss ... 109D56", "Inspector refresh waits for the next command so REDO stays available" and "Automatic Project QA waits for the next command ...", within half a second of the click. In the failing round 1 on 3.0.75, CE's REDO watcher logged no drawing change between the U and the REDO, the same as in passing rounds. The only difference is at the REDO itself: the 12 "write after U finished" lines that a working REDO produces are missing, because nothing was redone. So CE's log does not show CE writing to the drawing. What lost REDO is not visible in CE's log.
   4. **The weight of evidence.** On 3.0.74 the first pit click of a session kept REDO in 3 R08 sessions (k8R1, hdnA4, hdnB4b) and in the 5 one-round sessions of control arm A: 8 of 8. On 3.0.75 it lost REDO in 4 of 4, and rounds 2 to 5 kept it every time. Same robot, same drawing, new build. That points at the build. It is still only 4 sessions in one hour on one afternoon, so "timing" (how busy the PC was) is not excluded, but CE's own timings in the log match the passing runs.
   5. **Why only the first click:** unknown. It matches Codex's original BUG-861 report ("first run after opening a drawing"), which the harden review said was never explained.
   6. **Leads for whoever investigates, not findings:** 62 Civil source files changed between a15b414c and 2c805a39. None is named for the Inspector or the REDO guard. The only palette-side change I saw is BUG-960's palette theme refresh (`ThemeService`). I have not shown that any of them is involved, and I state nothing about what AutoCAD does inside itself.
   7. **What R08's 3.0.74 acceptance is worth now:** history only. It proved the case route works and that 3.0.74 kept REDO in all rounds. It does not carry to 3.0.75, where the same text fails in every session. R08 counts for nothing on 3.0.75. It was never among the 40, so the count above does not change. Its review file (hash 4A42C588) still says CLAUDE-ACCEPTED-READY "on Civil 3.0.74"; the runner will not print ACCEPTED-READY while FAIL rows exist on this build. I did not touch it (its hash did not change).
   8. **What R08 is now:** a reproduction of BUG-861 on 3.0.75. Keep the text as it is. It becomes the bug's red-to-green guard.
   9. **Text for the desk to add to BUG-861 (status stays OPEN):** "Reproduced by the runner on Civil 3.0.75 (25 Oct 2026, case R08 hash 4A42C588, sessions b3bh2-s1, b3bh2-s2, b3bh4-s1, b3bh4-s2, 4 of 4): after LINE, U and the FIRST real-mouse click on pit P3 of the session, REDO says 'Nothing to redo'; rounds 2 to 5 keep REDO. The same case text, click point, driver and settings kept REDO in every round on Civil 3.0.74 (k8R1, hdnA4, hdnB4b; arm A 5 of 5). CE's log shows no drawing change between U and REDO in the failing round (the same lines as passing rounds). Not a robot read: the runner reads nothing between U and REDO in this case. Cause not found. Matches Codex V4/V6 (first run after open). The 24 Oct finding that the old 5-of-5 loss came from the robot's own pick-first read still stands for that old route."
   10. **Next steps I recommend (for the runner owner and the desk, not mine to do):**
       1. **One diagnostic run, record only, outside Tim's hours:** R08 with `sleep 60` after the control round and before round 1's LINE. If round 1 then keeps REDO, it is "too soon after start"; if not, it is "the first pit click".
       2. **A second diagnostic:** round 1 clicks a plain AutoCAD line instead of the pit (same reads as R08). If REDO survives, it is pit- or CE-specific.
       3. **A Codex pass of the V4/V6 route on 3.0.75**, 3 freshly started AutoCADs, CE log copied (the harden review's step 4, now more urgent).
       4. **A builder look at what 3.0.75 runs on the first selection of a CE pit** (the leads in item 6.6), with this log evidence.
7. **Things the desk should know first (RULES 6.2):**
   1. **The report's "nothing in the case, runner or driver changed" is not quite true.** `case_runner_lib.ps1` changed between the 3.0.74 passes and the 3.0.75 fails (the report does list the new hash in its "What I changed" section). I checked the diff: it cannot affect R08 (item 6.2). The conclusion stands; the sentence was too strong.
   2. **R19b_PIPE_BROKEN's own header calls it "a true red for its all six pipes check".** It is a tool-error red (the ledger row has `from_check` false). Cosmetic; nothing rests on it (item 5).
   3. **R12's report figure "moved 1899.4, 1925.7 and 1999.1 mm"** is right (both sessions). Those three IL texts follow the pit, but their return after U is not checked (case item 1).

## How I applied the four conditions

1. **Nothing seen on screen.** Met for R12, R19b, R28, R01, R03, R05: positions, counts, command-line lines, window titles in the window list, a window's text dump, file hash, CE log lines. R28's window is read as text, not looked at.
2. **Two passes in separate AutoCAD sessions on one build.** ANSWER FIRST item 2.3.
3. **Red before green.** ANSWER FIRST item 2.4. True reds: R12_NOU_BROKEN, R19b_COUNT_BROKEN, R28_BROKEN. Flipped: R19b_BROKEN. Tool error: R19b_PIPE_BROKEN.
4. **Compared with the card, and full coverage.** Line by line below.

## The cases

1. **R12: quick MOVE (card C41; gap-plan check "quick MOVE"; backlog W1-02).** Verdict: **NEEDS STRONGER ASSERTION.** Hash 85BAD74AEDEB. It counts for part: "MOVE of pit P3 lists no CE window; the pit, its name label (109E08), its cover level text (109E0F) and two of its six IL texts follow it, and one U puts those five back exactly" (b3bd1, b3bd2; true red R12_NOU_BROKEN). No review file.
   1. **Asks met, all three of B2FIX:** the label and cover text read before (0 mm from their recorded places), after the MOVE (2000 and 2000, asked 2000 +- 150) and after U (0 and 0, asked 0 +- 0.5); the moves of 1155B6, 116A3C and 116BE4 recorded (1899.4, 1925.7, 1999.1). The red now fails on the label and cover checks too.
   2. **Gap 1, C41 assertion 3 ("one U restores all monitored positions"):** the case reads 1155B6, 116A3C and 116BE4 after the MOVE, so they are monitored, but it never checks them after U. The handle-list check after U cannot cover it: a text left 1.9 m away is still inside the 4000 mm search. 116A0E (IL 18.10, in the six) is not read at all. **Lines to add after U** (after `dist $cl2 ...`):
      1. `select $a2 "handle=1155B6" -> $b1155`, `dist $b1155 "52367.63,-25217.61" -> $r1155`
      2. `select $a2 "handle=116A3C" -> $b116a3c`, `dist $b116a3c "54262.93,-26095.53" -> $r116a3c`
      3. `select $b2 "handle=116BE4" -> $b116be4`, `dist $b116be4 "53376.61,-25031.45" -> $r116be4`
      4. ASSERT `number $r1155 = 0 +- 0.5`, `number $r116a3c = 0 +- 0.5`, `number $r116be4 = 0 +- 0.5`.
      5. **116A0E:** probe its place once (as b3bprobe1 did for the label), then the same three lines (read before, record its move, assert 0 +- 0.5 after U). It may be the IO8 inlet's text and not follow the pit; the U check holds either way.
      6. Copy the three `dist ... = 0 +- 0.5` checks into R12_NOU_BROKEN so they go red too.
   3. **Gap 2, the headline check has never gone red:** `equals $win1 $win0` ("no CE window opens") has passed in every run and no variant ever made it fail. R28 shows the window list does see CE windows, which is good evidence it can fail, but the rule asks for a red. **Variant `R12_WIN_BROKEN`:** the same first steps, then after the MOVE `type "CE_VERSION" -Force -ExpectWindow "About CE Suite" -> $t`, `windows-snapshot -> $win1`, `close-windows`; ASSERT `equals $win1 $win0`. It must FAIL. (CE_VERSION is what R06 uses.)
   4. **Then:** two passes on 3.0.75 of the new text, and quick MOVE counts (9 of 40). The "documented placement rules" of C41 assertion 1 are still not recorded anywhere; the case's 2000 +- 150 for the label and cover is a fair reading (they moved exactly 2000). Leave the IL texts record-only for their move.
   5. **Not covered, said for the record:** the pipe ends (the runner cannot read a pipe's end points). Same as B2FIX.
2. **R19b: erase pit P3 with six pipes (D14, UX-EDIT-01).** Verdict: **CLAUDE-ACCEPTED-READY** for D14 as written, on Civil 3.0.75. Hash 3536E3A4615D. Review file written.
   1. **Asks met, both of B2FIX:** all six pipes read after the ERASE (10A98D, 109E23, 109ED4, 110179, 110136, 10A901, each "STORMWATER PIPE"); the count straight after the ERASE asserted at 1031 (1034 before: the pit, its name label, its cover text), and 1034 again after U.
   2. **Against D14:** assertion 1, the whole sentence with 6 is pinned word for word; assertion 2, all six pipes exist after the ERASE (six reads plus the count); assertion 3, 109D56 back on STORMWATER PIT, count equal, echo "ERASE". The card's "N from the Pit Schedule" is its method; 6 is backed three ways (driver run 20's schedule rows, CE's own sentence, the six boxes touching the pit).
   3. **The six handles were found from pipe boxes, not pipe ends.** If one were wrong, the count check would still catch a real P3 pipe being erased. Accepted.
   4. **Reds:** item 5 of ANSWER FIRST.
   5. **Not covered:** the Pit Schedule figures after the ERASE and after U, and the links coming back after U. Neither is a D14 assertion. The one-pipe wording ("1 pipe now has an end ...") is R19's branch; D14's own pit has six.
   6. **Cosmetic, at the next edit (changes the hash):** EXPECTED still names only pipe 10A98D; the NOT_AUTOMATED line says the driver cannot close the Pit Schedule (it can, R25 and R38).
3. **R28: CDPROFILE start (triage group Q1).** Verdict: **CLAUDE-ACCEPTED-READY** for its narrow claim only, on Civil 3.0.75. Hash 7F29403F16E7. Review file written.
   1. **Ask met, B2FIX's one line, word for word:** `ui-dump "Profiles" -> $pd` and the `matches` line. In both passes the text right after the instruction line is "P3". In the dump that text sits beside the "Choose Pit" buttons, so it is the window's start pit field, not a list of every pit.
   2. **The red:** R28_BROKEN picks an empty place and fails three checks, including the new P3 line (no window). True red.
   3. **What it proves:** CDPROFILE asks "Select starting CE pit for profile review:", a pick 200 mm inside P3 with the view zoomed is accepted, the Profiles window opens showing P3 as its start pit, closing it leaves no CE window, the object count and the file on disk unchanged.
   4. **What it does not prove:** that P3 comes from the pick and is not a default (no red picks another pit), any long-section value, any Q1 bug. No D-number, none of the 40.
   5. **Optional, at the next edit:** a variant that picks pit P4 and expects P3 (must FAIL); and end the pattern with `P3.,` so "P30" could not match. Neither blocks.
   6. **Seen in passing, not judged:** CDPROFILE closed with nothing done logs "completed" (BUG-862 family, B2FIX item 6.4).
4. **R01: PIT and CD keep placing until Esc (D01).** Verdict: **CLAUDE-ACCEPTED-READY**, now on Civil 3.0.75. Unchanged text; review file hash 99BC70E2... matches; passes b3bh1 and b3bh3; red R01_BROKEN still matches its file. SETUP-P8x2 is unchanged since 24 Oct 23:17 (81152F70E476), before the reviewed passes, so the setup the case ran today is the one reviewed (the case hash does not cover it: B3FIX's runner note). The robot's 5.4 m second pipe ("1 IN 54") is the robot's stale view, not CE (B3FIX item 4).
5. **R03: one IL text at each pipe end (D12).** Verdict: **CLAUDE-ACCEPTED-READY**, now on Civil 3.0.75. Review file hash 4384D2D7... matches; passes b3bh1 and b3bh3; red R03_BROKEN matches. SETUP-P8 unchanged since 23 Oct (7A241608EB59). UX-CPLAN-26 whole stays part-accepted (the "short leader" ruling and the text's look are not robot items).
6. **R05: one outcome line per command, and "cancelled" (#1507).** Verdict: **CLAUDE-ACCEPTED-READY**, now on Civil 3.0.75. Review file hash 4E5A6154... matches; passes b3bh2 and b3bh4 (b3bh2-s1: "Command outcome: CDCHECKCURRENT completed 200 ms" once, "PIT cancelled 7232 ms" once); red R05_BROKEN matches. Not among the 40. BUG-862 stays OPEN.
7. **R08: REDO after U and a real-mouse pit pick, five rounds (spec C32, BUG-861).** Verdict: **FAIL = real fault, cause unknown** (ANSWER FIRST item 6). Hash 4A42C588E549, unchanged. Four FAIL rows on 3.0.75, all at check 5 and 6 (round 1, "Nothing to redo"); checks 1 to 4 and 7 to 24 passed, and the final pick read found 109D56 in every session.

## For the runner owner (not case faults, listed so they are not lost)

1. **Hash the SETUP file in the review gate** (B3FIX item 4.3, still open).
2. **Print the build of the two passes beside ACCEPTED-READY** (B2FIX), so a review file's old build in its verdict line is not read as current. R01, R03, R05 and R08 files all say 3.0.74 in words.
3. **A step that reads a pipe's end points** would let R12 and R19b check the pipe ends.
4. **Still open from earlier reviews:** a red only for `BUG` cases (R12, R19b, R28 carry an empty `BUG` line, so the runner does not demand their reds; I checked them by hand); case-blind text checks; `folder-new-only` passes when nothing appears; the build stamp read before the lock wait.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Results are read from the ledger, the run reports and the CE log.
2. **I looked at no picture.** None of these cases has one.
3. **Installed code:** not read beyond the list of changed files and the ThemeService diff. The R08 leads are leads, not findings.
4. **AutoCAD's own command-line logs of the R08 sessions** (CLDV31538231, CLDV31611091): I could not find them on disk, so I did not see whether anything else was typed or echoed between U and REDO in round 1. The runner's capture shows only "Command: | Command: REDO | Nothing to redo".
5. **Tim's four settings files:** I relied on each run's end-of-session fingerprints (0 differences in every session I read).
6. **The probe and trial runs b3bprobe1, b3bprobe2, b3btrial1:** not read beyond the 116A0E search.
7. **Not re-reviewed:** every other case.

## Files written

1. `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_B3B_2026-10-25.md` (this file).
2. `C:\Lisp Files\_ACAD_DRIVER\cases\R19b_erase_pit_with_several_pipes.review.txt` (new; case hash 3536E3A4615D...).
3. `C:\Lisp Files\_ACAD_DRIVER\cases\R28_cdprofile_start.review.txt` (new; case hash 7F29403F16E7...).

No review file for R12 (its old file still names an old text, BD224816..., so the runner will not count it). R01, R03, R05 and R08 review files untouched (their hashes did not change).

## Summary

R19b and R28 are Claude-accepted-ready on Civil 3.0.75 (review files written); R01, R03 and R05 now count on 3.0.75 too. Everyday tools accepted on 3.0.75: 8 of 40 (D01, D03, D04, D12, D14, D17, Recover Inverts, Tidy labels), 8 on any build. R12 needs four after-U checks and a red for "no CE window". No new bug may be written fixed. R08 fails round 1 in 4 of 4 fresh sessions on 3.0.75 with the same robot steps that passed on 3.0.74: a possible CE regression, cause unknown; add it to BUG-861, keep it OPEN.
