# Runner case review: R01 to R10 against their cards (Opus independent review, Sat 24 Oct 2026)

Written Sat 24 Oct 2026, about 02:50 to 03:30 Melbourne, by an independent Opus reviewer. Read-only: nothing run in AutoCAD, no runner, case or settings file touched, no bug status changed. Rule applied: RULES.md acceptance amendment of 24 Oct ("Claude-accepted") and `decisions/2026-10-24_TIM_CLAUDE_ACCEPTED_RULE.md`.

**What I read:** the ten case files, the shared setup SETUP-P8 and the two broken variants in `C:\Lisp Files\_ACAD_DRIVER\cases`; `runner-reports\ledger.json` and every run report it names (f1A, f1B, f1C, f2A, f2B, f2C, the p1 debug runs, the REDO probes, a2 on 3.0.71, and the new p3probe of 02:46); `release-v3-colleagues-RUNNER_PHASE2_REPORT.md`; cards D01, D02, D03, D12, D18 in `DAILY_TOOLS_TEST_CASES_2026-10-23.md`; specs C04, C12, C13, C14, C16, C31 in `TEST_CASES_DRAFT_22OCT.md`; BUG-852, 859, 860, 861, 862, 863, 1086, 1087 in `BUG_CARPARK.md`; Tim's UX-CPLAN-26 ruling in `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`; and, by `git merge-base`, which fixes are inside the installed Civil 3.0.72 (`f7f7d551`).

**Phase 3:** no `RUNNER_PHASE3_BATCH*_REPORT.md` exists yet and no new case file has landed. The only phase 3 output is the probe run `RUN-20261024-0246-C3.0.72-p3probe` (case P00, an `ent-read` and MOVE probe, not a test case). Nothing more to review.

## ANSWER FIRST

1. **Counts (one main verdict per case, 10 cases):**
   1. **CLAUDE-ACCEPTED-READY: 0.**
   2. **NEEDS BROKEN VARIANT: 2** (R03, R04). Their checks are sound for what they cover; they have no red run.
   3. **NEEDS STRONGER ASSERTION: 6** (R01, R02, R05, R07, R08, R10). Each could pass, or fail, for the wrong reason.
   4. **NEEDS CODEX LOOK: 1** (R06, a look case nobody has looked at).
   5. **NEEDS TIM: 0 as a main verdict.** One Tim question sits inside R03 (the IL leader in his own ruling) and one inside R04 (what counts as red for "never saves").
   6. **FAIL = real fault: 1** (R09, BUG-859 still opens AutoCAD's attribute editor on 3.0.72).
2. **Also needed, across cases:** 7 of 10 cases still need a red run (R01 to R07). R08, R09 and R10 already have one. 3 need a Codex look sooner or later (R06 now; R09 and R03's label positions once they pass).
3. **Bugs a desk may write "FIXED (Claude-accepted, build, date)" today: none.**
   1. **Closest: BUG-862** (outcome words). On 3.0.72 the runner logs already show "PIT completed" and "CD completed" after an Esc ending (R01, both runs) and "CDCHECKIGNORE refused" (R10, both runs). The fix (`95eafe45`) is in 3.0.72. But no case judges the word, so nothing can be accepted yet. Edits in items 1 and 10 below make it ready.
   2. **Next: BUG-863** (CDCHECKIGNORE switched off must not save the project record). The fix (`98c41c9d`) is in 3.0.72, and R10's runs logged only the one outcome line. But R10 never checks that the drawing is unchanged. The edit in item 10 makes it ready.
4. **Plan items that now count as accepted: none.** For the recount (`V3_RECOUNT_2026-10-24.md` section 4a), these are tested on 3.0.72 in PART only:
   1. **UX-STD-01b:** R01 shows the "pick the next" prompts and the Esc ending. It never places a second pit or pipe, so "keeps placing" is not proven.
   2. **UX-PIPE-02:** R02 covers one pipe starting on a pit. A pipe ending on a pit is not covered, and nor is the Pit Schedule row.
   3. **UX-CPLAN-26:** R03 covers one IL per end. Tim's ruling also asks for "a short leader", which is not built.
   4. **UX-STD-03:** R04 covers PIT, CD, CDSYNC and CDRECOVERINVERTS. CDREBUILD and PITSCHEDULE are not covered.
   5. **UX-DI-03, switch-off half:** R10 covers the message. That nothing is saved is not checked.
5. **Three things the desk should know first:**
   1. **R08's 5-of-5 REDO loss is not yet proven to be CE's fault.** Between U and REDO the runner reads AutoCAD through COM (the view, the pit and the pick-first set) and moves the real mouse. The no-pick control does none of that. Codex's hand picks kept REDO (V4, V6, V10 runs A and B). Item 8 gives two control steps that would settle it.
   2. **Edit the cases, then run them on 3.0.72 before the next Civil train is installed.** C-63 (`claude/rel-20261024m`) carries BUG-859 round 3 (#1676). A case whose text changes gets a new SHA-256, and a red recorded on the old text no longer counts for it. If R09, R08 and R10 are edited first and re-run red on 3.0.72, a later green on C-63 meets condition 2 at once.
   3. **Most broken variants are only flipped expectations.** They prove the checker can go red, not that the case catches a broken feature. Where a real switch exists, use it, because a true red beats a flipped one:
      1. **R10:** `checks.allowIgnoreFinding` true.
      2. **R05:** `options.commandOutcomeLines` false.
      3. **R03:** `options.createText` false.

## How I applied the four conditions

1. **Nothing seen on screen.** True for R01 to R05, R07, R08 and R10. R06 is a look case. R09 reads a window title and a control value, which is fine, but spec C04 is a look case, so the window itself needs Codex.
2. **Two passes in separate AutoCAD sessions on one build.** I counted only runs whose case-file SHA-256 equals today's file:
   1. **R01, R02, R04:** f1C and f2C.
   2. **R03:** p1C2, f1C and f2C.
   3. **R05, R06:** p1A, f1A and f2A.
   4. **R07:** f1A and f2A.
   5. **R10:** f1B and f2B.

   The FAIL rows on 3.0.72 for R01, R02 and R04 in `ledger.json` (p1C, p1C2) belong to older case texts. They were runner faults: the old pipe filter missed `CeCvlPipeObject`, and the Pit Schedule close hit a HARD TIMEOUT. They neither block condition 2 nor count as a red for condition 3.
3. **Red before green.** These count:
   1. **R08:** its own FAIL on 3.0.72, twice, same SHA.
   2. **R09:** its own FAIL on 3.0.72, twice, same SHA.
   3. **R10:** R10_BROKEN failed twice.

   Nothing else has a red.
4. **Compared with the card, and full coverage.** Judged on the case text, item by item below.

## The cases

1. **R01: PIT and CD keep placing until Esc (card D01, plan UX-STD-01b; BUG-862 recorded).** Verdict: **NEEDS STRONGER ASSERTION**, then a broken variant. Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (f1C, f2C).
      3. **Red:** none. The p1C2 FAIL was an older text with a wrong object filter.
      4. **Card:** partly met.
   2. **What it really proves:** after one pit and one pipe, CE offers "Pick the next..." and Esc ends with "Stopped". One U removes the pipe and its IL texts and leaves the pit.
   3. **Gap 1: nothing is placed a second time.** It never places a SECOND pit or pipe, so it would pass if the "next pit" prompt were printed but the next pick did nothing. That is exactly "keeps placing". Add a second placement inside one PIT command and one CD command. Give the next point at "Pick the next pit", go through New Pit again, then Esc. Assert:
      1. **Pits:** 2 new pits on layer STORMWATER PIT.
      2. **One command:** `log civil count "Command outcome: PIT " = 1`.
      3. **Same for CD:** the same for a second pipe.

      The route is unproven, so probe it first. Put it in its own setup (for example SETUP-P8x2, slot fresh) so SETUP-P8, which R02 to R04 share, stays as it is.
   4. **Gap 2: "at least one" is now too loose.** The composition has been read in both runs: 6 new objects (the pit, one `CeCvlPipeObject`, three MText ("225 DIA. UPVC PIPE AT 1 IN 200", "IL 18.000", "IL 17.900") and the arrow block). Replace `count $polylines >= 1` with these lines:
      1. `select $new_all object=CeCvlPipeObject -> $pipes`, then `count $pipes = 1`.
      2. `select $new_all object=AcDbBlockReference "layer=STORMWATER PIT" -> $all_pits`, then `count $all_pits = 1`.
   5. **Gap 3: the pipe label and the arrow are not checked after U.** The card says the U takes back the arrow and the texts too. Today only the pipe and the IL texts are checked after U. Add `count $after_u = 1`, which means only the pit is left.
   6. **Gap 4: the outcome words can now be judged.** BUG-862's fix (`95eafe45`) is in 3.0.72. Both runs logged "PIT completed" and "CD completed". Add these lines and delete the "recorded, not judged" NOT_AUTOMATED line:
      1. `log civil has "Command outcome: PIT completed"`
      2. `log civil has "Command outcome: CD completed"`
   7. **Red:** no switch turns this behaviour off, so use a flipped variant. For example, expect `count $pit_after_u = 0`.

2. **R02: a new pipe joins the pit at its start (card D03, plan UX-PIPE-02; BUG-560 drift).** Verdict: **NEEDS STRONGER ASSERTION**, then a broken variant. Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (f1C, f2C).
      3. **Red:** none (the old FAILs were runner faults).
      4. **Card:** partly met.
   2. **Strong part:** `history has "Inserted flow arrow. Flow: P8 -> Open end"` plus `history absent "Flow: Open end"` really proves CE recorded the join to P8. That is the heart of D03 assertions 1 and 4.
   3. **Weak part: the geometry check.** The report itself says that for a CE pipe object the runner's x,y is the lower-left corner of the bounding box (150225, -80112.5), not the first vertex. So `near=150000,-80000,641` tests the box corner, not "the first vertex lies inside P8's outline" (D03 assertion 2). Probe `ent-read` on the pipe handle. If it returns the start point, assert it against the pit outline: a 600 x 900 pit plus the 100 mm catch, so |x - 150000| <= 400 and |y + 80000| <= 550 at rotation 0. If it does not return the start point, say so in NOT_AUTOMATED and lean on the history line.
   4. **Not covered:**
      1. **Pit Schedule row:** P8 outlet IL 18.000 and diameter (D03 assertion 3, NOT_AUTOMATED).
      2. **The other end:** a pipe whose second end lands on a pit. UX-PIPE-02 is "joins the pit it lands on", either end.

      Count this case for "a pipe started on a pit joins it" only.
   5. **Real red:** a variant whose CD starts 2 m off the pit (for example 152000,-80000) must FAIL on `Flow: P8 -> Open end`. It is the same command and only the landing changes.

3. **R03: one IL text at each pipe end (card D12, plan UX-CPLAN-26).** Verdict: **NEEDS BROKEN VARIANT.** Part only, with a Tim question.
   1. **Conditions:**
      1. **Nothing seen:** met for the count and which end. The exact text position is a label position, which needs a Codex look.
      2. **Two passes:** met (p1C2, f1C, f2C).
      3. **Red:** none.
      4. **Card:** met for D12 as written.
   2. **The checks are sound.** Exactly 2 new IL texts, one "IL 18.000" and one "IL 17.900" by anchored match, at the right ends by distance. A duplicate, a missing text, a swapped value or a wrong end would each fail.
   3. **Optional tightening:** `number $a_to_pit <= 1500` is generous; 462.5 mm was read both times. Consider 800 mm, and add `number $b_to_end <= 800` for the far text (270.8 mm read).
   4. **Real red:** a variant with `SETTING CD_Settings.json options.createText false` must FAIL `count $ils = 2`. It needs its own session (a different setting) and a probe that CD still runs with text off.
   5. **Tim's word needed for the whole item.** His ruling (27 Sep 02:07, "One IL per pipe, at its end") places the IL "near where it enters or leaves the pit with a short leader". The leader is not built (D12). Either the leader stays in scope, and UX-CPLAN-26 is part-accepted only, or Tim drops it. The desk should not decide that.

4. **R04: CE never saves the drawing (card D18, plan UX-STD-03).** Verdict: **NEEDS BROKEN VARIANT.** Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (f1C, f2C).
      3. **Red:** none. The p1C2 FAIL was a tool HARD TIMEOUT on the Pit Schedule, which README rule 7 says should have been BLOCKED, not FAIL.
      4. **Card:** partly met.
   2. **The checks are the right ones.** `copy-unchanged` (SHA-256 and time) and `folder-new-only` are exactly D18 assertions 1 and 3.
   3. **Commands covered:** PIT, CD, CDSYNC and CDRECOVERINVERTS only. Not covered:
      1. **CDREBUILD:** not driven, and its "does not save" wording (D18 assertion 2) is not checked.
      2. **PITSCHEDULE:** the v2 close timed out.
   4. **A save when the drawing closes would be missed.** The file is checked while AutoCAD still has it open. Ask the runner owner to re-hash the copy after the session ends, before it is cleaned up.
   5. **Red: question for the desk, and Tim if needed.** A real red needs something to save the drawing, and saving is banned in cases on purpose. Two honest options:
      1. **Runner self-test:** a self-test in which the runner changes a scratch duplicate of the copy (never the drawing AutoCAD has open) and `copy-unchanged` must FAIL.
      2. **Accept without a red:** accept this one case without a red, written down as an exception.

      This is a reading of Tim's rule, so the desk should ask him, not decide.

5. **R05: one outcome line when a CE command finishes (plan #1507).** Verdict: **NEEDS STRONGER ASSERTION**, then a broken variant. Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (p1A, f1A, f2A).
      3. **Red:** none.
      4. **Card:** partly met. #1507 has no D card. I compared it with BUG-862's expected behaviour.
   2. **The EXPECTED line is wrong.** It says CDCHECKCURRENT "runs without a window". In fact it opens the "CE Civil - What CE Found" palette (driver run 24, and the window lists in f1A and f2A). That is by design, but the case states the opposite and checks neither. Correct the sentence and add `windows-snapshot -> $w` with `record $w`.
   3. **Format check:** the "<n> ms" part is not checked. If `log-read civil` returns the new lines, add `matches $lg "Command outcome: CDCHECKCURRENT completed \d+ ms"`.
   4. **What #1507 covers that this case does not:** one line for every CE command, with the right word.
      1. **Covered:** one command and one word (completed).
      2. **Cancelled:** for example PIT then Esc at the first point, placing nothing, must log "cancelled".
      3. **Refused:** see R10.
      4. **Structural and Manager outcome lines:** #1547 and #1548, now installed.
   5. **Real red:** a variant with `SETTING CD_Settings.json options.commandOutcomeLines false` (the switch exists in 3.0.72 `UserSettings.cs`) must FAIL both log checks.

6. **R06: About CE Suite shows each suite's version (spec C12).** Verdict: **NEEDS CODEX LOOK.** It is a look case and can never be Claude-accepted whole.
   1. **Conditions:**
      1. **Nothing seen:** not met (KIND look).
      2. **Two passes:** met.
      3. **Red:** none.
      4. **Card:** partly met.
   2. **Wrong label.** PLAN_ITEM says BUG-852. BUG-852 is about ribbon buttons calling a command from a module that is not installed (CE_VERSION on a PC without Structural). This case runs with all three suites installed, so it cannot test BUG-852. Re-label it to spec C12. The picture also bears on BUG-090 (clipped rows) and BUG-1087 (heading contrast), both open on Manager 1.1.72 per Codex X6.
   3. **The version part can be counted later.** The rows compared with the DLLs are deterministic and sound. They could count as Claude-accepted for that part only, after a red: a flipped variant, for example expecting `v{$dll_struc}` after "Civil Suite".
   4. **Add (C12 assertion 1):**
      1. `control-text $about has "AutoCAD"`
      2. `control-text $about has ".NET"`
   5. **A ready-made red for BUG-1086 (open, Manager 1.1.72).** Make a new case, R06b, ordered last or in a fresh slot. Type `_.CIRCLE 3000,3000 500`, then CE_VERSION, then Close, then `type "U" -> $u`, and assert `contains $u "CIRCLE"`. It should FAIL today, and that FAIL is the red for the BUG-1086 fix.
   6. **Codex:** look at `R06_about.png` (SHA-256 07A0C4C8D288) and write the verdict on the look note.

7. **R07: Settings opens and Cancel closes it (specs C13, C14 reduced).** Verdict: **NEEDS STRONGER ASSERTION**, then a broken variant. Part only.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** met (f1A, f2A).
      3. **Red:** none.
      4. **Card:** partly met.
   2. **Strong part:** `hashes-unchanged` read before the guard restores is the right check for "opening and Cancel write nothing".
   3. **Gap 1: only 3 of the 8 tabs are checked.** EXPECTED names eight tabs; three are asserted. Add `control $set "Settings, Settings Tabs, <name>" exists` for Design, Survey, Display, Newer tools and Fixes. Spec C13 says six tabs, so first confirm the true list from the f1A dump.
   4. **Gap 2: the real risk is not tested.** That risk is Cancel throwing away a CHANGED value (C14). With nothing changed, a Cancel that wrongly saves would still leave the hashes equal. Count it as "open, read and Cancel with no change writes nothing" only. C14 needs a proven way to type into one Settings field without pressing Save; the route is unproven.
   5. **Red:** a flipped variant, for example `control-text $set absent "No changes. Everything shown is saved."`.

8. **R08: REDO after U and a mouse pick of pit P3, five times (BUG-861).** Verdict: **NEEDS STRONGER ASSERTION.** The FAIL is real as a result, but its cause is not proven, so do not call it a CE fault yet.
   1. **Conditions:**
      1. **Nothing seen:** met.
      2. **Two passes:** not applicable (it fails).
      3. **Red:** its own FAIL on 3.0.72, twice, same SHA (C85AD573).
      4. **Card:** see below.
   2. **The label is the wrong spec.** It says spec C31 (a typed pick). The case uses the real mouse, which is spec C32.
   3. **Why the cause is open.** In each pick round, between U and REDO, the driver does three things the no-pick control never does:
      1. **COM reads:** the view, the pit entity, and the pick-first set (`Test-V3ClickHit` in `acad_driver_v3.ps1`).
      2. **Focus:** it brings AutoCAD to the front.
      3. **The click itself.**

      The typed-pick route that also lost REDO is a typed LISP line (`sssetfirst`, seen in the p3probe). The BUG-861 entry records that Codex's hand picks kept REDO (V4 and V6 pick-only, V10 runs A and B). So 5 of 5 here against 0 of several by hand points at the driver route as much as at CE. I am not stating what AutoCAD does inside.
   4. **Two control rounds to add (each: LINE, U, then the step, then sleep 12, then REDO):**
      1. **Reads without a click:** `v3 view-read`, `ent-read 109D56`, and the same pick-first read the click proof makes, with no click.
      2. **Click on a plain AutoCAD line:** draw line A first and keep it, then line B, U, then `v3 pt-click` on line A.

      Only if both controls say "Everything has been redone" and the pit click says "Nothing to redo" does the case point at CE.
   5. **R08_BROKEN:** it flips the no-pick control only. It proves the control check can fail. It is not needed as R08's red, because R08's own FAIL is the red.

9. **R09: double-click on the DP1 downpipe opens CE's Edit source (BUG-859, spec C04).** Verdict: **FAIL = real fault.** BUG-859 still fails on Civil 3.0.72.
   1. **Conditions:**
      1. **Nothing seen:** met for which window opens. The window itself needs Codex (C04 is a look case).
      2. **Two passes:** not applicable.
      3. **Red:** its own FAIL on 3.0.72, twice, same SHA (E08D4711).
      4. **Card:** partly met.
   2. **The evidence.** Both runs:
      1. **The click:** the aim check selected the DP block.
      2. **The result:** the double-click opened "Enhanced Attribute Editor".
      3. **Agreement:** this matches Codex V10 and its CE log on 3.0.70.
   3. **Which fixes are installed.** I checked by `git merge-base`:
      1. **Round 2 (#1522, `8799d200`):** in 3.0.72, and the case still fails.
      2. **Round 3 (#1676, `dee2744f`):** not in 3.0.72. It is "a border or Xref plan around a downpipe no longer stops its double-click" and is waiting in C-63. The likely reason R09 fails is that round 3 is missing; this is not proven.
   4. **Fix these before C-63 is installed, then re-run red on 3.0.72:**
      1. **The Tag box name.** The check uses "Tag". Spec C04 names the box "Tag (one word, for example DP2)", so a correct fix could still FAIL on the name. Use the name from the first dump, or a contains-match if the runner allows it.
      2. **Cancel.** EXPECTED says "Cancel closes it", but the case uses `close-windows`. Use `ui-press "Edit source" "Cancel" -> $c` and `window-closed $c`.
      3. **The other parts of the symbol.** BUG-859 expects "anywhere on the DP1 symbol". Add the red centre and the angled DP text. The green label is BUG-860, a separate case.
   5. **After a green on C-63:** "which window opens, with DP1 in the Tag box" can be Claude-accepted. The window's look needs Codex (C04 assertion 3).

10. **R10: CDCHECKIGNORE with the switch off (spec C16, plan #1517 / UX-DI-03 switch-off half; BUG-862 and BUG-863).** Verdict: **NEEDS STRONGER ASSERTION.** It is the closest to ready.
    1. **Conditions:**
       1. **Nothing seen:** met.
       2. **Two passes:** met (f1B, f2B).
       3. **Red:** R10_BROKEN failed twice.
       4. **Card:** partly met.
    2. **Gap 1: "changes nothing" is not checked for the drawing.** It checks only the four settings files. BUG-863 is about the switched-off command saving the project record into the drawing, and R10 would pass even if that came back. Add spec C16 assertion 3:
       1. **Before:** `getvar DBMOD -> $m0` before the command.
       2. **After:** `getvar DBMOD -> $m1` after it.
       3. **Check:** `equals $m0 $m1`.

       Prove it can go red with the variant in point 6.
    3. **Gap 2: the outcome word can now be judged.** Both runs logged "CDCHECKIGNORE refused", and BUG-862's fix is in 3.0.72. Add `log civil has "Command outcome: CDCHECKIGNORE refused"`, and remove the out-of-date NOT_AUTOMATED line that says it logs 'completed'.
    4. **Gap 3: "asks no question" is weak.** `not-contains $ig "Specify"` would miss a question worded any other way. Add `getvar CMDACTIVE -> $ca` and `equals $ca 0` after the sleep.
    5. **Not covered:** the ON paths C17 to C19. Count this case for the switch-off half only.
    6. **Real red, better than R10_BROKEN:** a variant with `SETTING CD_Settings.json checks.allowIgnoreFinding true`. CE then asks which finding to ignore, so R10 must FAIL. End it with esc-prompt, so nothing is answered and nothing is written (the fixed code saves nothing on Esc).
    7. **After these edits:** two passes on 3.0.72 would make R10 CLAUDE-ACCEPTED-READY for the switch-off half of UX-DI-03, and would carry BUG-862 (refusal half) and BUG-863.

## For the runner owner (not case faults, listed so they are not lost)

1. **Read the ledger by case SHA-256.** The README rule "no FAIL on record on that build" would block R01, R02 and R04 for good. Their FAIL rows on 3.0.72 are older case texts. The acceptance field should key on the case file's SHA-256, as the phase 2 report itself advises.
2. **A tool HARD TIMEOUT is not a FAIL.** R04 in p1C2 was a tool timeout recorded as FAIL. README rule 7 says it is BLOCKED.
3. **The review files.** Each case now has a `<case>.review.txt` beside it holding the reviewed_against record. The `REVIEWED_AGAINST` lines inside the case files are untouched, as instructed. The runner owner decides whether to copy them in once the edits above are made. Any edit changes the case SHA-256, so this review then applies to the edited text only if a reviewer re-reads it.

**Summary.** I checked all 10 runner cases against their cards and bug entries. None is Claude-accepted yet. R03 and R04 only need a red run. R01, R02, R05, R07, R08 and R10 need stronger checks; the exact lines are in each item. R06 needs Codex. R09 is a real fault: BUG-859 still fails on 3.0.72, and round 3 is not installed. R08's REDO loss may come from the test route itself. BUG-862 and BUG-863 look fixed on 3.0.72 but are not judged by any case yet. R10 is the nearest to ready.
