# Runner case review, hardening of R01 to R10 (Opus independent review, Sun 25 Oct 2026)

Written Sun 25 Oct 2026, about 03:00 to 03:50 Melbourne (PC clock), by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case, settings or ledger file edited, no bug status changed, `BUG_CARPARK.md` and `DESK_LOG.md` not touched. The only files written are this one and four `.review.txt` files (listed at the end). Rule applied: the RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`. Standard followed: `RUNNER_CASE_REVIEW_2026-10-24.md` (its per-case asks are the contract) and `RUNNER_CASE_REVIEW_B2_2026-10-24.md` (method and shape).

## FOR TIM

1. **4 of the 10 cases are now ready to count as Claude-accepted** on the installed build (Civil 3.0.74): PIT and CD keep placing until Esc (R01), one IL text at each pipe end (R03), the outcome line in the CE log (R05), and REDO still works after a mouse pick of a pit (R08).
2. **Daily-tool checks:** 2 more count now, D01 and D12. That makes **6 of the 40**, of which **3 are on today's build** (D01, D12, D17).
3. **No bug can be written fixed yet.** BUG-861 (REDO lost after picking a pit) stays open: the robot's old failure was the robot's own fault, but Codex's first failure has never been explained.
4. **Nothing for you to decide.** The builder asked whether you would accept R04 ("CE never saves") without a proper failing twin. You do not need to: the robot can already save its own test copy safely, so a proper failing twin can be built.
5. **One thing to look at later, not now:** in R01 the second pipe's label said "1 IN 54" although its levels and length mean about 1 IN 200. Nobody knows why yet. One quick probe will show whether it is a real fault.

---

**What I read:** the builder's report `release-v3-colleagues-RUNNER_HARDEN_REPORT.md` (all of it); the first review in full; the batch 2 review; the ten case files R01 to R10, `SETUP-P8`, `SETUP-P8x2`, the variants R01, R02, R03, R05, R07, R08, R10 and R10_save broken, the control arm R08c_F; `case_runner.ps1` (`Get-CaseIndependentReview`), the step and assertion table and `hashes-unchanged` in `case_runner_lib.ps1`, `Invoke-V3Pointer`, `Get-V3Pickfirst` and `Test-V3ClickHit` in `acad_driver_v3.ps1`, `save-copy` in `acad_driver_witness_v2.ps1` and both allow-lists; `runner-reports\ledger.json` (208 rows) joined to today's case hashes, which I took myself with Get-FileHash; run reports hdnA1, hdnA2, hdnA2v, hdnA3, hdnA4, hdnA4b, hdnA5, hdnA6, hdnB1, hdnB2, hdnB3, hdnB4b, k1A1, k1A2 (diffed against k1A1), k1F1, k6V1, k8R1; the Civil CE log `CE_CVL_SUITE.log` around the R08 and control-F runs, and the structured log of 22 Oct at the original BUG-863 moment; cards D01, D03, D12, D18; specs C13, C14, C16, C31, C32; BUG-861, BUG-862 and BUG-863; the gap plan's daily-tool list (section 3 item 7); `git merge-base` of the installed commit `a15b414c` against the fixes named below; the product version of every installed CE DLL.

## ANSWER FIRST

1. **Counts (one main verdict per case, 10 cases):**
   1. **CLAUDE-ACCEPTED-READY: 4.** R01 (D01, PIT and CD keep placing), R03 (D12 as written), R05 (#1507 outcome line, the "cancelled" word), R08 (spec C32, REDO after a real-mouse pit pick). All on **Civil 3.0.74**.
   2. **NEEDS BROKEN VARIANT: 1.** R04 (no red inside AutoCAD; one is possible, see item 4 of "The cases").
   3. **NEEDS STRONGER ASSERTION: 3.** R07 (spec C14 half-checked, its key check has never gone red), R09 (the first review's three fixes not done; round 3 of BUG-859 IS installed now), R10 (two lines of spec C16 missing).
   4. **PARTIAL (part only): 1.** R02 (start-on-a-pit half of D03; the Pit Schedule row and the other end are not covered).
   5. **NEEDS CODEX LOOK: 1.** R06 (untouched, a look case).
   6. **FAIL = real fault: 0.** R09's last result was a real-fault FAIL on 3.0.72, but it has not run on 3.0.74, which carries the round 3 fix. Its status today is unknown, not failed.
2. **BUG-861 verdict (special item a):** the controls prove that the robot's own pick-first read loses REDO, so the old R08 5-of-5 failure says nothing against CE. They do NOT prove that CE plays no part (CE was loaded in every arm) and they do not touch the route that failed for Codex (first run after open, pick, right-click, Esc). **BUG-861 must stay OPEN.** Suggested status wording in section "BUG-861" below.
3. **Daily tools (D-numbers) that may now be counted Claude-accepted: 2 new.**
   1. **D01** (PIT and CD keep placing until Esc), from R01, on **Civil 3.0.74**.
   2. **D12** (one IL text at each pipe end), from R03, on **Civil 3.0.74**, as the card is written. Plan item UX-CPLAN-26 as a whole still waits for Tim's word on the "short leader" in his 27 Sep ruling (not built).
   3. **Not yet:** D03 (R02, part only), D18 (R04, no red and part only).
4. **The 40 gap-plan checks (section 3 item 7 of the gap plan), all reviews so far:**
   1. **Accepted in total: 6.** D01 and D12 (this review); D04, D17, Recover Inverts and Tidy labels names the pipe (batch 2 and the review before it).
   2. **Accepted on Civil 3.0.74, the current build: 3.** D01, D12 and D17. D04 (R17), Recover Inverts (R15) and Tidy labels (R16) are accepted on 3.0.73 only; ledger checked, no pass of their current text on 3.0.74 yet.
   3. **"PIT" and "CD" as separate checks:** no card defines them apart from D01, so I do not count them; counting D01 for them as well would count one test three times.
   4. **R05 and R08 are not among the 40** (#1507 and spec C32 are pack extras), so they add nothing to that count.
5. **Bugs that may be written "FIXED (Claude-accepted, build, date)": none.**
   1. **BUG-862:** completed half (R01) and cancelled half (R05) are ready on 3.0.74. The refused half (R10) is two lines short, and BUG-862's symptom names "the downpipe command" too, which no case runs. One more small case (DP, place one, Esc, expect "Command outcome: DP completed") plus R10's lines would close it.
   2. **BUG-863:** R10 checks the exact symptom (I confirmed the 22 Oct log: "Project data saved to DWG successfully" just before "Command outcome: CDCHECKIGNORE completed"). Two lines and two passes away.
   3. **BUG-861:** stays OPEN (item 2).
   4. **BUG-859:** round 3 (`dee2744f`) is inside the installed `a15b414c`; R09 has not run on it.
6. **Things the desk should know first:**
   1. **Mistakes in the first review, said plainly.** (a) Its red for R03 was wrong: `options.createText` only switches the pipe label. I confirmed it in the installed code (`CdViewModel.Settings.cs` maps it to `CreatePipeText`) and in run k6V1 (setting guarded, IL texts still written). Cost: one wasted session, about 5 minutes. (b) It said R10 would be ready after its edits; it missed two parts of spec C16 (selection unchanged, no outcome text on the command line). Cost: one more edit and two short sessions, about 6 minutes.
   2. **The report is wrong on R09:** it says round 3 of BUG-859 is not installed. `git merge-base --is-ancestor dee2744f a15b414c` says it IS in Civil 3.0.74. R09 should run on 3.0.74 before anything else is concluded.
   3. **Build stamps are true.** Every hdn and k run is after the 3.0.74 install (bundle `Contents` created 24 Oct 17:19:58; the DLLs read 3.0.74+a15b414c today in Legacy, Modern and Net8). No install landed during the job. Structural 1.0.123 and Manager 1.1.74 unchanged throughout.
   4. **Hashes:** every ledger PASS and FAIL I count carries today's file hash. One typo in the report: R01_BROKEN's hash starts 8D6A64A5E2DF, not ...E2DD (the ledger is right).
   5. **Seen in passing, not judged by any case:**
      1. **R01's second pipe label reads "AT 1 IN 54"** in both passes (hdnA1, hdnB1), and wraps as "UPVC\PPIPE", while its two IL texts read 17.800 and 17.700 and it was drawn from x 150000 to 170000 (about 20 m, so about 1 IN 200). The builder put it down to click accuracy. The pointer read-back was exact to the pixel, and one pixel is about 53 mm at that zoom, so that does not explain a 0.1 m fall reading as 1 in 54 (about 5.4 m of pipe). No bug entry found. One probe (read the second pipe's length, or draw it typed) before anyone files it.
      2. **CDCHECKIGNORE with the switch ON, ended by Esc, wrote no outcome line** in R10_BROKEN's log window (hdnA6: 1 new log line, no "Command outcome: CDCHECKIGNORE ..."). Possibly the BUG-862 family (a command with no outcome word). Not judged.
      3. **AutoCAD refused COM for 61 s right after a pit click in a reopened drawing** (R08_BROKEN, hdnA3 and hdnA4). In hdnA4 CE's log shows 200 lines of CE writing at 02:26:19 while it converted the reopened drawing's 49 pipes. Unexplained; I state nothing about what AutoCAD did.

## How I applied the four conditions

1. **Nothing seen on screen.** Met for R01 to R05, R07, R08 and R10. R06 is a look case. R03 judges counts, values and distances, not how the text looks. R07 reads the window as text only; spec C13's page look still needs Codex.
2. **Two passes in separate AutoCAD sessions on one build.** From the ledger, current hashes only, all on civil 3.0.74+a15b414c / struc 1.0.123 / mgr 1.1.74:
   1. **R01:** hdnA1 and hdnB1.
   2. **R02, R03, R04:** hdnA2 and hdnB2.
   3. **R05, R07, R10:** hdnA3 and hdnB3.
   4. **R08:** hdnA4 and hdnB4b (hdnB4 was BLOCKED at calibration and wrote no ledger row; k8R1 also passed but ran without the ledger).
   5. **No FAIL on record** for any current R01 to R10 text on 3.0.74.
   6. **The k-series runs are not in the ledger.** I counted them only as supporting evidence, never as passes.
3. **Red before green.** Every variant FAILED in the ledger on its current text, from a check (not a tool error), and for the intended reason (I read each first failure):
   1. **R01_BROKEN** (hdnA2v): flipped by setup. One pit and one pipe only, so 16 of R01's checks fail, starting with "Pit placed ... = 2" holding 1.
   2. **R02_BROKEN** (hdnA2v): a true red. CD starts 2 m off; "Flow: Open end -> Open end"; pipe box at x 152000.
   3. **R03_BROKEN** (hdnA2v): a true red. Both invert texts hidden in New Pipe; IL texts 0, pipe still 1.
   4. **R05_BROKEN** (hdnA5): a true red. `options.commandOutcomeLines false`; all five log checks fail.
   5. **R07_BROKEN** (hdnA3): flipped window checks only. Its `hashes-unchanged` PASSED.
   6. **R08_BROKEN** (hdnA4b): a true red. REDO says "Nothing to redo".
   7. **R10_BROKEN** (hdnA6): a true red. Switch on, the refusal sentence is missing.
   8. **R10_SAVE_BROKEN** (hdnA3): simulated by a CDSYNC. "Project data saved to DWG successfully" was found.
4. **Compared with the card or bug, and full coverage.** Judged line by line below.

## The cases

1. **R01: PIT and CD keep placing until Esc (card D01, UX-STD-01b; BUG-862 completed half).** Verdict: **CLAUDE-ACCEPTED-READY** for D01, on Civil 3.0.74.
   1. **Asks met:** a second pit and a second pipe in one PIT run and one CD run; exact composition (2 pits, 2 pipe objects, 2 arrows, 4 IL texts, 6 texts); after one U only the last pipe, its arrow, its two IL texts and its label are gone ("U" echoed CD); "PIT completed" and "CD completed", never "cancelled".
   2. **Card D01:** assertions 1 to 3 in full, and stronger than written (a second object really placed). Assertion 4 says "exactly one" outcome line each; with two placements CE writes one line per placement (hdnA1 saw 2 PIT and 2 CD lines, all "completed"), which agrees with BUG-862's rule.
   3. **The red:** R01_BROKEN is a flipped red by setup (a drawing where the second pick never happened). Accepted under the rule; it shows the case goes red when CE stops after one object.
   4. **Isolation:** R01 ran alone, first in each session, on the copy the session launched.
   5. **Not covered:** sizes, label look, Undo of the first pit; the second pipe's grade label (see item 6.5.1 of ANSWER FIRST).
2. **R02: a new pipe joins the pit at its start (card D03, UX-PIPE-02).** Verdict: **PARTIAL.** It counts for "a pipe started on a pit joins it" only.
   1. **Asks met:** exactly one pipe and one pit; the flow line once; the box corner within 50 mm of 150225, -80112.5, which puts the pipe's start inside P8's 600 mm outline (225 mm east of the centre). A true red.
   2. **Not covered:**
      1. **D03 assertion 3, the Pit Schedule row:** P8 outlet IL 18.000 and the diameter. Batch 2 showed the schedule can now be opened, read as text and closed (R25 route). Whether a row's cells can be read as text is not proven (R25 says the cells have no accessible id).
      2. **The other end:** a pipe that ends on a pit (UX-PIPE-02 says either end).
   3. **Lines to make it whole:**
      1. **Probe first:** after SETUP-P8, `type "PITSCHEDULE" -Force -ExpectWindow "Pit Schedule" -TimeoutSec 120 -> $ps`, `sleep 5`, `ui-dump "Pit Schedule" -> $psd`, `ui-press "Pit Schedule" "Close" -> $psc`, `await-window-gone "Pit Schedule" -Secs 120`. Only if the dump ties "18.000" and "225" to the P8 row, add `control $psd "Pit P8" exists` and the row checks.
      2. **A twin case R02b:** `type "CD{NL}130000,-80000{NL}150000,-80000{NL}"` after SETUP-P8 steps 1 and 2. ASSERT `history has "Flow: Open end -> P8"`.
3. **R03: one IL text at each pipe end (card D12, UX-CPLAN-26).** Verdict: **CLAUDE-ACCEPTED-READY** for D12 as written, on Civil 3.0.74.
   1. **The report's claim about the first review's red is right** (ANSWER FIRST item 6.1). The new red is valid: CD still places the pipe, and the IL count goes to 0.
   2. **Asks met:** both distances at 800 mm (462.5 and 270.8 mm read in both passes); exactly two IL texts with the right values at the right ends.
   3. **Card D12:** assertions 1 and 2 in full. Assertion 3 asks only to record whether a leader is drawn; the case does not record new lines or leaders. Optional at the next edit: `select $new_all "object~Leader$|^AcDbLine$" -> $leaders` and `record $leaders "any leader drawn"`.
   4. **For the plan count:** UX-CPLAN-26 whole stays part-accepted until Tim rules on the "short leader" (his 27 Sep ruling). The text's exact look stays a Codex item.
4. **R04: CE never saves the drawing (card D18, UX-STD-03).** Verdict: **NEEDS BROKEN VARIANT**, and part only.
   1. **Decision on the builder's question (special item c):** the offline self-test does not meet the rule. The rule allows two kinds of red: the build before the fix, or a deliberately broken variant of the case. The self-test is neither: it runs no AutoCAD and no CE, and proves only that the file-compare tool works. So R04 stays not accepted.
   2. **No exception is needed, because an in-AutoCAD red is possible.** The v2 driver already has a guarded `save-copy` verb. It saves only this session's `CLD*` copy, refuses `DRV*` masters and `_PRE_` backups, and records the hash before and after. The case runner does not expose it yet. **Lines:**
      1. **Runner owner:** add a step verb `save-copy` that calls v2 `save-copy` with no new name, and refuse it unless the case has `EXPECT-FAIL BROKEN-VARIANT`.
      2. **Variant** `variants\R04_save_broken.case.txt`: `VARIANT_OF R04`, `EXPECT-FAIL BROKEN-VARIANT`, FIXTURE DRV1_B1, SLOT fresh, SETUP SETUP-P8, ORDER 99, R04's steps with `save-copy` after CDRECOVERINVERTS, ASSERT `copy-unchanged $copy0`. It must FAIL. Run it last in its session, because the runner refuses to reopen a copy whose hash changed.
   3. **Still part only after that (D18):**
      1. **PITSCHEDULE (assertion 1):** now drivable. Add R25's open, Close and `await-window-gone` lines before `copy-info -> $copy1`.
      2. **CDREBUILD (assertion 2):** probe its prompts first.
   4. **Stale note (cosmetic, it changes the hash):** NOT_AUTOMATED line 3 ("runs AFTER R01 has undone its pipe") is out of date since every case gets a fresh drawing.
5. **R05: one outcome line per command, and "cancelled" (#1507; BUG-862 cancelled half).** Verdict: **CLAUDE-ACCEPTED-READY** for #1507 on Civil: one line with its time, exactly once, for CDCHECKCURRENT, and the "cancelled" word for PIT stopped at its first prompt. On Civil 3.0.74.
   1. **Asks met:** the wrong sentence is fixed (the What CE Found palette is recorded: "CE Civil - What CE Found" in both runs); the "<n> ms" format is matched (237 ms read); "PIT cancelled" once, never "completed". A true red.
   2. **Scope, as the case itself says:** not every CE command; Structural and Manager lines (#1547, #1548) are not read. EXPECTED's "asks no question" for CDCHECKCURRENT is not asserted; it is not the feature under test.
6. **R06: About CE Suite (spec C12).** Verdict: **NEEDS CODEX LOOK.** Untouched (hash C783FF31387F, unchanged).
   1. **Still to do:** relabel PLAN_ITEM to spec C12 (it says BUG-852). Add `control-text $about has "AutoCAD"` and `control-text $about has ".NET"`, plus a flipped red.
   2. **Build:** it has passed only on 3.0.72. It needs two passes on 3.0.74.
   3. **Codex:** look at `R06_about.png`.
7. **R07: Settings opens, Cancel throws a change away (specs C13 reduced, C14).** Verdict: **NEEDS STRONGER ASSERTION.**
   1. **Asks met:** all eight tabs; one field (Label slide step) changed to 123 and seen dirty; Cancel closes; the four files unchanged, read before the guard restores.
   2. **Gap 1, C14 assertion 2 is missing:** reopen the window and check the field shows the saved value again. Cancel that writes nothing to disk but keeps 123 in CE's memory would pass today, and the drafter would see 123 next time. Tim's file holds `labelSlideStepMm` 125.0. **Lines to add:**
      1. Before the change: `control $set "AdvancedSettingsDialog.SettingsTabs.Drafting.LabelSlideStepMm" value "125"` (probe first whether the box shows "125" or "125.0").
      2. After the Cancel: `type "CDS" -Force -ExpectWindow "Settings" -> $t3`, `ui-dump "Settings" -> $set3`, `ui-press "Settings" "Settings, Cancel" -> $pr3`, `wait`.
      3. ASSERT: `control $set3 "AdvancedSettingsDialog.SettingsTabs.Drafting.LabelSlideStepMm" value "125"`, `control-text $set3 has "No changes. Everything shown is saved."` and `window-closed $pr3`.
   3. **Gap 2, the key check has never gone red:** R07_BROKEN flips only window checks, and its `hashes-unchanged` passed. No run in `runner-reports` shows `hashes-unchanged` failing, ever. **True red:** `variants\R07_save_broken.case.txt`, the same steps but `ui2-press "Settings" "Save"` in place of the Cancel. The v2 allow-list permits Save in the Settings window only while the settings guard is armed. ASSERT `hashes-unchanged`; it must FAIL. Its own session, outside Tim's hours. Check the four fingerprints at the end as usual. Probe the v2 button name first.
   4. **Not covered:** C13's page look (Codex).
8. **R08: REDO after U and a real-mouse pit pick, five rounds (spec C32; BUG-861 pick half).** Verdict: **CLAUDE-ACCEPTED-READY** for spec C32 as amended, on Civil 3.0.74. **BUG-861 stays OPEN** (next section).
   1. **Asks met:** the two controls the first review asked for were run (reads with no click, arm B; click on a plain line, arm D), plus five narrowing arms. The new route has no pick-first, view or entity read between U and REDO.
   2. **What the case shows:** five rounds per session, two sessions, every REDO "Everything has been redone". **The CE Inspector palette was open** in both sessions (CE log: "Inspector palette created", CDINSPECTOR completed at session start). CE's REDO guard logged "Inspector refresh waits for the next command so REDO stays available" 11 times in each session. So the CE path BUG-861 suspects was running during the rounds.
   3. **Why a missed click cannot pass quietly:** the view is not changed between rounds, and the final click at the same pixel picked 109D56 in both sessions. A click on empty space leaves AutoCAD in a selection window that refuses COM, so the next typed REDO would be BLOCKED, not passed.
   4. **The red:** R08_BROKEN (one pick-first read added) is a true red, "Nothing to redo".
   5. **Deviation from spec C32, accepted:** C32 asks a COM read of the selection after each click, and that read is now shown to destroy REDO by itself (arm F). So C32's step 3 cannot be done as written. The case proves the hit once, after the rounds. Rounds 2 to 5 are not fresh sessions; arm A gave 5 fresh one-round sessions.
   6. **Wording to fix at the next edit (cosmetic):** EXPECTED says "the runner reads nothing from AutoCAD" between U and REDO. The v2 `wait` after U and the typed REDO still talk to AutoCAD through COM. The true statement is "no pick-first, view or entity read".
   7. **Optional per-round proof at the next edit:** `log civil count "Inspector refresh waits for the next command" >= 5`.
9. **R09: double-click on DP1 opens Edit source (BUG-859, spec C04).** Verdict: **NEEDS STRONGER ASSERTION**, and run on 3.0.74.
   1. **Status:** last result FAIL on 3.0.72 (a real fault then). Round 3 is installed in 3.0.74 (ANSWER FIRST item 6.2), so today's status is unknown.
   2. **Order:** run it once unchanged on 3.0.74 first, for information.
   3. **The first review's three fixes, still to do:**
      1. **The Tag box name:** take it from the first real dump.
      2. **Cancel:** replace `close-windows` with `ui-press "Edit source" "Cancel" -> $c` and `window-closed $c`.
      3. **The rest of the symbol:** a second double-click on the red centre, and one on the angled DP text.
   4. **The red after the edit:** an edit changes the hash, and its 3.0.72 FAIL then no longer counts. Give it a true red: a variant with `SETTING CD_Settings.json doubleClick.sourceEditWindow false` (the key exists in `DoubleClickSettings.cs`). Probe first that the SETTING verb can add the key if Tim's file lacks it. Expect AutoCAD's editor, so R09 must FAIL.
   5. **Codex:** the window's look stays a Codex item (C04 assertion 3).
10. **R10: CDCHECKIGNORE with the switch off (spec C16; BUG-862 refused half; BUG-863).** Verdict: **NEEDS STRONGER ASSERTION.** Two lines away.
    1. **Asks met:** CMDACTIVE 0; "Command outcome: CDCHECKIGNORE refused" once; no "Project data saved to DWG" line. That is the exact BUG-863 symptom: one code path writes it (`ProjectDataService.Persistence.cs:600`), and it is what the 22 Oct log shows. Two true reds.
    2. **Gap, C16 assertion 3:** "selection equal baseline" and "no Command outcome text appears on the command line" are not checked. DBMOD read 1 before and after, so that check proves nothing here (the case says so). **Lines to add:**
       1. `v3 pick-read -> $s0` before CDCHECKIGNORE.
       2. `v3 pick-read -> $s1` after it.
       3. ASSERT `contains $s0 "pick-first set: 0 object(s)"`, `contains $s1 "pick-first set: 0 object(s)"` and `not-contains $ig "Command outcome"`.
    3. **Limit, not a blocker:** R10 never ran on a build before the fix. On 22 Oct the bad save came after other CE edits in that drawing. Whether a fresh copy, with CDCHECKIGNORE as the first command, would have triggered it on the old build is not known. R10_SAVE_BROKEN proves the check catches the line, which the rule accepts.
    4. **Then:** two passes on 3.0.74. R10 becomes ready for the switch-off half of UX-DI-03, and the desk may write BUG-863 "FIXED (Claude-accepted, Civil 3.0.74, <date>)" for the switch-off path.

## BUG-861: is the "it was the robot, not CE" conclusion supported? (special item a)

1. **What is proved (on Civil 3.0.74, CE loaded, the Inspector palette open):**
   1. **One read of the pick-first set through COM between U and REDO is enough to lose REDO.** This happens with no click, no pit and no CE object selected (arm F, 2 of 2). It happens with the reads plus a hover (arm B, 5 of 5), and on a plain AutoCAD line with the old route's reads (arm D, 5 of 5).
   2. **Without that read, a real-mouse click on the pit keeps REDO:** 5 one-round sessions (arm A), plus 5 rounds in each of 3 sessions (k8R1, hdnA4, hdnB4b), so 20 rounds in 8 sessions. The view read plus the pit data read keep it (arm G, 2 of 2), and so does waiting alone (arm E, 1 run).
   3. **The old R08 route contained that read** (`Test-V3ClickHit` calls `Get-V3Pickfirst`, which reads `PickfirstSelectionSet`). So its 5-of-5 failure is fully explained by the robot's own route. It is no evidence against CE.
   4. **Supporting, from CE's own log:** in control F (k1F1, 24 Oct 21:00:38 to 21:00:54) CE's REDO watcher logged no write to the drawing between that U and that REDO. In the R08 rounds it logged no write with CE code on the stack.
2. **What is NOT proved:**
   1. **That CE plays no part in the read-caused loss.** CE was loaded in every arm, and no arm ran without CE. Whether AutoCAD loses REDO on that read by itself is Autodesk's internals, and I do not state it.
   2. **The route that failed for Codex:** V4 and V6, the FIRST run after opening a drawing, with the Inspector showing: LINE, U, wait, pick P3, **right-click, Esc**, REDO. R08 has no right-click and no Esc between the pick and REDO. Its first pick comes after a no-pick control round, a minute or more after open. Codex's own pick-only runs had already kept REDO, so R08 proves again what never failed by hand.
   3. **Why AutoCAD refused COM for 61 s after a pit click in a reopened drawing** (R08_BROKEN, hdnA3 and hdnA4).
   4. **Counts are small** for the narrowing arms (F 2, G 2, E 1).
3. **Can BUG-861 be written anything other than open?** No. There is no fix, and the failing route was never run by the robot. It can never be closed (D6). **Suggested status wording for the desk:** "OPEN (not reproduced on Civil 3.0.74: the robot's 5-of-5 'Nothing to redo' came from its own pick-first read, controls k1A to k1J, 24 Oct; R08 v2 guards U + real-mouse pit pick + REDO, Claude-accepted-ready 25 Oct; Codex's first-run loss in V4/V6 with right-click and Esc still unexplained)."
4. **To settle it:** a Codex pass of the exact V4/V6 route, in 3 freshly started AutoCADs, first action after open, Inspector showing, CE log copied. If all three keep REDO, the desk can ask Tim whether to park it as not reproducible.

## For the runner owner (not case faults, listed so they are not lost)

1. **Expose `save-copy` to broken variants only** (R04's red, case item 4).
2. **`hashes-unchanged` has never been seen to fail.** Give it a red once (R07_save_broken), so the check that guards Tim's settings files is known to work.
3. **The review gate picks the first `<id>_*.review.txt`, searching `cases` before `variants`.** That is right today. But R08 and R10 also have old `R08_broken.review.txt` and `R10_broken.review.txt` in `variants`. If a case's own review file were ever missing, the gate would read the variant's review instead. Both of those old files say NEEDS..., so nothing passes wrongly today.
4. **Report and evidence (from the builder's list, still open):** `control-text ... absent` prints garbage evidence; `esc-prompt` does nothing after a mouse click; the calibration-retry property error (`CalibRetry`, `case_runner.ps1`); a case needs its own `v3 pt-` step to calibrate.
5. **The log window includes the setup's lines** (the log start is taken after the reopen, before the setup). Keep that in mind for any "absent" log check in a case with a SETUP.

## What I did NOT check

1. **I ran nothing.** No AutoCAD, no runner. Results are read from the ledger, the run reports and the CE log.
2. **I looked at no picture.** R06's picture is untouched by me.
3. **Code changes in this job:** I read the `-Blind` branch of `Invoke-V3Pointer` (no COM read, no hit proof, stored view up to 180 s). I did not review the rest of the driver change or diff it against the backups.
4. **The 3.0.72 control runs (hA, hB, hE)** and the setup probes k2P1 to k2P11 were not read.
5. **Tim's four settings files:** I relied on each report's end-of-session fingerprints (all four equal in every run I read).
6. **Not re-reviewed:** R11 to R30.

## Files written

1. `C:\CE_PLAN\areas\RUNNER_CASE_REVIEW_HARDEN_2026-10-25.md` (this file).
2. `C:\Lisp Files\_ACAD_DRIVER\cases\R01_pit_cd_until_esc.review.txt` (replaced; hash 99BC70E2...).
3. `C:\Lisp Files\_ACAD_DRIVER\cases\R03_one_il_text_each_end.review.txt` (replaced; hash 4384D2D7...).
4. `C:\Lisp Files\_ACAD_DRIVER\cases\R05_outcome_line_completed.review.txt` (replaced; hash 4E5A6154...).
5. `C:\Lisp Files\_ACAD_DRIVER\cases\R08_redo_after_pick_x5.review.txt` (replaced; hash 4A42C588...).

The other R02, R04, R06, R07, R09 and R10 review files still name their old texts, so the runner will not count them.

## Summary

Of R01 to R10, four are Claude-accepted-ready on Civil 3.0.74: R01 (D01), R03 (D12 as written), R05 (outcome line, cancelled) and R08 (REDO after a mouse pick). R04 needs a red inside AutoCAD, which the driver can already give; the offline red does not meet the rule. R07, R09 and R10 need stronger checks (exact lines given). R02 is part only, and R06 needs Codex. The R08 controls prove that the robot's own read caused the old REDO failure. They do not explain Codex's failure, so BUG-861 stays open. No bug may be written fixed. Accepted daily checks: 6 of 40, 3 on 3.0.74.
