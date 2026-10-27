# Robot next cases: 12 new draft checks to lift the everyday-tools number (27 Oct 2026)

Written Tue 27 Oct 2026 evening, Melbourne, by an Opus planner (read and write documents only). Nothing was run in AutoCAD, nothing built or installed. Installed build when written: Civil 3.0.82 (commit e30556ca, branch claude/rel-20261026w); C-73 (3.0.83, branch x) is being finalised and may land first.

## FOR TIM

1. **Where we are:** 8 of the 40 everyday tools are Claude-accepted on the installed build (the 40 is really 38 named items; the reviewers have noted this since 25 Oct).
2. **What I did:** wrote 12 new robot checks, each with a "deliberately wrong" twin that must fail. They sit in a side folder, so the robot ignores them until a Team robot job tries them.
3. **What it could mean:** if every one passes twice and the independent reviewer agrees, the count rises from 8 to between 15 and 20 of 40.
4. **What you need to do:** nothing today. No question for you comes out of this work.

### Covered by a robot check today (21 of the 38)

1. **Accepted (8):** PIT and CD keep placing, pipe joins its pit, Esc at CD's third point, one IL text each end, erasing a pit, CDEDIT keeps the selection, Recover Inverts, Tidy labels names the pipe.
2. **Whole, waiting for re-runs on 3.0.82 (1):** CDTWL freeboard.
3. **Covered in part only (6):** Edit Pipe cascade (texts only), CE never saves (CDREBUILD missing), warning before CDSYNC and CDREBUILD (CDREBUILD missing), COPY of a pit (mixed with a known fault), spot levels (survey half missing), CDSYNC keeps the schedule.
4. **Has a check, never reviewed or not re-run (2):** quick MOVE, the pipe label text.
5. **Needs a Codex look at the window (2):** CDCHECKDWG, Pit Schedule order (the old check only reads names).
6. **Counted through the PIT and CD check (2):** PIT and CD as named tools.

### Not covered today (17 of the 38)

Pit catch distance, recent-values buttons, hide grade, downpipe and raingarden without pipes, OF and FO, pit label and cover level, short-pipe leader, hand-placed label stays, EXPLODE, Undo names, CDRENUMBER, drawn schedule over two sheets, Excel export, office layers, existing and demolished layers (not built), CDFEEDBACK, ribbon tab on selection.

### The 12 draft checks

1. **N01 CDREBUILD warns and never saves:** proves the warning, both "does not save" lines, file unchanged, U names it. Cannot prove the rebuilt records are right. **Likely ready.** Completes two items together with the old checks.
2. **N02 EXPLODE a pit:** proves the one-line message, P3 leaves the schedule, six pipes stay, U brings it back. Cannot judge the linework look. **Likely ready.**
3. **N03 OF and FO:** proves both use the same symbol, each its own tag, next-one offer until Esc. Cannot prove tags start at 1 (this drawing may already hold some). **Likely ready.**
4. **N04 downpipe and raingarden with no pipe:** proves both place with nothing refused, 12.0 m² area, U takes back only the raingarden. Cannot use a drawing with no pipes at all. **Fair chance.**
5. **N05 pit label and cover level:** proves label P8 on the right layer and "CL 19.000", one U removes all three. Cannot place the label to the millimetre (mouse clicks). **Fair chance.**
6. **N06 office layers:** proves the current layer is kept and nothing lands on layer 0. **Likely ready, but it can only count in part:** "never recolour a layer" is not built.
7. **N07 Undo names (switches on):** proves "Undid: point 3 of the pipe route.", and U names PIT and MOVE. Proves the switch-on setting only, as Tidy labels does. **Fair chance.**
8. **N08 CDRENUMBER:** proves the list, No changes nothing, Yes renumbers P9 and P10, the schedule follows, U puts it back. Cannot judge the numbering rule itself. **Likely ready.**
9. **N09 Pit Schedule order:** proves P1 to P10 in number order, P10 never before P2. Cannot test the switched-off P1A and SPS refinement. **Likely ready.**
10. **N10 hide grade:** proves the label drops "AT 1 IN" with the switch off, levels unchanged. Cannot click the toggle (set before start instead). **Fair chance.**
11. **N11 Edit Pipe cascade, stored levels:** proves the schedule follows the cascade, U and REDO. With R11 this makes the cascade item whole. **Fair chance** (long, never-read cell format).
12. **N12 COPY of a pit:** proves the new number P8, "Check levels" line, U removes it. Cannot see the Inspector's flag. **Likely ready.**

Draft files: `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_27oct\N01_...` to `N12_...`, each with a `_BROKEN` twin (24 files; all 24 pass the robot's offline format check).

### Needs a Codex look or Tim (not drafted)

1. **Codex look:** recent-values buttons, pipe label side and direction, drawn schedule over two sheets (its button was greyed out for Codex), Excel export (the robot may not use Save dialogs), CDCHECKDWG window, ribbon tab on selection (Codex saw Esc return to Plug-ins, not CE).
2. **Needs a route probe first:** short-pipe leader (an unknown "Snap callout arrow to pipe" prompt), hand-placed label (switch off), pit catch distance.
3. **Needs Tim or a build:** existing and demolished layers (not built), CDFEEDBACK "Send report" (would post into the office folder; needs the spare login and your yes), the survey half of spot levels (needs a drawing with a stored survey).

### Instruction for the Team robot job (copy as is)

1. **When:** a free AutoCAD window only (weekday after 5:30 pm, 2:00 to 3:00 pm, or the weekend). Read the installed Civil DLL version first; all passes for one case must be on that same build.
2. **Format check:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_27oct"` must say 24 checked, 0 invalid.
3. **First pass:** run each draft and its twin with `run-pack "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_27oct" -Only "<N id>,<twin file name>" -Tag n27a<k> -NoRerun`, two cases per call. Run N01's twin alone and last (it saves its copy on purpose).
4. **Second pass:** repeat every main case in a NEW call (a new AutoCAD session), tag n27b<k>.
5. **Fix only mistakes in the draft text** that the runner shows: a wrong prompt word, a BLOCKED step, a wrong variable, a schedule cell written in another number format. Never weaken or delete a check because CE behaves differently from its card: that is a finding. Write it in the report for the desk to file.
6. **After any fix,** run that case twice again (its hash changed, so earlier passes no longer count).
7. **Move when ready:** a main case that passed twice with its twin failing as intended moves to `cases\`; its twin moves to `cases\variants\`. Rename on the move to `N<nn>_<words>.case.txt` and `variants\N<nn>_broken.case.txt`, keeping the CASE line unchanged.
8. **Never:** write or edit any `.review.txt`, edit existing R cases, the runner or driver files, ledger.json by hand, DESK_LOG.md or BUG_CARPARK.md.
9. **Report:** write `C:\CE_PLAN\areas\release-v3-colleagues-ROBOT_N_CASES_VALIDATION_<date>.md`: per case PASS, FAIL or BLOCKED with run ids, every text fix (before and after), every finding, and which cases moved. Then the desk starts the independent Opus review.

---

## Technical detail

### A. The 38 named items and their checks today

Source of the list: `areas/RELEASE_9NOV_GAP_PLAN_2026-10-22.md` section 2 (the 30, numbered D01 to D30 in `areas/DAILY_TOOLS_TEST_CASES_2026-10-23.md`) plus section 3 item 7 (PIT, CD, Edit Pipe cascade with U and REDO, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts, Tidy labels names the pipe). Acceptance state from `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` items 1 to 14 and `runner-reports/ledger.json` read 27 Oct about 19:30.

1. **D01 UX-STD-01b:** R01 (+R05). Accepted; 2 passes on 3.0.82.
2. **D02 UX-PIT-02 pit catch outline + 100 mm:** none. Codex D1-03 blocked.
3. **D03 UX-PIPE-02:** R02, R02b. Accepted; 2 passes on 3.0.82.
4. **D04 UX-PIPE-03:** R17. Accepted; 2 passes on 3.0.82.
5. **D05 UX-PIPE-04 recent buttons:** none. Look item.
6. **D06 UX-PIPE-05 hide grade:** none. Draft N10.
7. **D07 UX-SRC-05 DP and CDRG before pipes:** none (R36, R37, R37b are neighbours). Draft N04.
8. **D08 UX-SRC-01 OF and FO:** none. Draft N03.
9. **D09 UX-CPLAN-21 pit label and cover:** none. Draft N05.
10. **D10 UX-CPLAN-23 pipe label:** R18 (passes on 3.0.72/73 with a red twin; no run since; never reviewed; side and direction need a Codex look).
11. **D11 UX-CPLAN-24 short-pipe leader:** none. Codex D7-04 met an unexpected "Snap callout arrow to pipe:" prompt.
12. **D12 UX-CPLAN-26:** R03. Accepted; 2 passes on 3.0.82.
13. **D13 UX-LBL-01 hand-placed label:** none. Switch off for Max; Codex D6-01 blocked.
14. **D14 UX-EDIT-01:** R19b + R19. Accepted.
15. **D15 UX-EDIT-02 COPY:** R34, R34s, R34sn, R34so. The plain COPY checks pass in every run; the cases fail on ROTATE/SCALE Copy (BUG-665, switch off). Draft N12 takes the plain COPY alone.
16. **D16 UX-EDIT-04 EXPLODE:** none. Draft N02.
17. **D17 UX-STD-06:** R20. Accepted; 2 passes on 3.0.82.
18. **D18 UX-STD-03 CE never saves:** R04, PARTIAL (Opus B5: CDREBUILD not driven). Draft N01.
19. **D19 UX-UNDO-01:** none. Codex D8-05 PASS with the switches on. Draft N07.
20. **D20 UX-CPLAN-18/19 CDRENUMBER:** none. Codex D5-01 blocked on the visual half only. Draft N08.
21. **D21 UX-SCHED-06 order:** R25 (look case; reads names, not order); R38 neighbour. Draft N09.
22. **D22 UX-SCHED-04 drawn schedule continuation:** none. Codex D6-03: "Continue to Place / update" stayed disabled.
23. **D23 UX-SCHED-02 Excel export:** none for the robot ("*Export*" and Save dialogs are on the never-press list). Codex D5-03 PASS.
24. **D24 UX-LYR-01:** none. Part-built. Draft N06 (installed part).
25. **D25 UX-LYR-04:** not built.
26. **D26 UX-SURV-03 CDSL:** R35 accepted for the typed-level half; the survey half needs a fixture with a stored CDSURVEY survey.
27. **D27 UX-REP-01:** R13 CDSYNC half (PARTIAL). Draft N01.
28. **D28 UX-IMP-02 CDCHECKDWG:** R40 (look case). Codex D8-02 DIFFERENT (title and report folder).
29. **D29 UX-WORD-03 CDFEEDBACK:** none. Codex D8-03 did the Cancel half; the Send half needs the spare login and Tim's yes.
30. **D30 UX-RIBBON-01:** none. Codex D8-04 FAIL (Esc returns to Plug-ins).
31. **PIT, CD (named):** reviewers count them inside D01; no separate count.
32. **Edit Pipe cascade with U and REDO:** R11, PARTIAL (texts; stored levels not read). Draft N11.
33. **quick MOVE:** R12, passes to 3.0.78, not reviewed ready (B3B review asked for more after-U checks; batch 4 added them). Needs a 3.0.82 run and an independent review.
34. **CDSYNC keeps the schedule:** R13, ready for the part named by Opus B5. Whether that makes this named check whole is the desk's call (not decided here).
35. **CDTWL freeboard:** R14 + R14h x3, whole on 3.0.80. No run on 3.0.81 or 3.0.82 in the ledger: two passes owed.
36. **Recover Inverts:** R15. Accepted.
37. **Tidy labels names the pipe:** R16. Accepted (switch on).

### B. How the 12 were chosen

1. **Rule used:** no picture needed (command-line words, stored attributes, object counts, layers, schedule cells read as text, the file on disk); exact expected words available from the source at e30556ca, a Codex D-series report or an accepted case; one route already proven by the robot or Codex.
2. **Left out for now:** D02 (needs the pit outline from the schedule and a near/far pipe pair: a sound later case, but the snap-to-wall behaviour is unproven), D11 (unknown prompt), D13 (switch off and a pit-move re-tidy route Codex could not drive), D05 and the windows (pictures), D23 (Save dialog), D29 (Send), D26 survey half (fixture).

### C. What each draft rests on

1. **N01:** `LinkCommands.cs` lines 222, 265, 312 at e30556ca; Codex D4-02 saw every line with "11 pits, 49 pipes" on an untouched copy (3.0.77). U echo CDREBUILD and the outcome log line come from card D27 assertion 3 (CDREBUILD is in command-registry.json). Twin: driver save-copy, as R04_SAVE_BROKEN.
2. **N02:** `ExplodeLeftScheduleMessagePolicy.cs` Describe; Codex D3-05 saw the exact line with P3 and 6 pipes, P3 gone from the schedule, U echoes PITSCHEDULE then EXPLODE. Pipe handles from R19b. Twin: no U (as R19_NOU_BROKEN).
3. **N03:** `SourceBlockInsertCommands.cs` lines 75-93 and 897; Codex D7-02 (blank drawing). Runs on DRV1_B1, so tag numbers are recorded, prefixes asserted. Twin: OF typed twice.
4. **N04:** CDRG source (prompts, keywords Place/Skip, area in m² with one decimal, INSUNITS conversion); Codex D7-01 (blank, unitless). 12.0 m² is DERIVED from the formula, INSUNITS 4 and the typed 4 m by 3 m outline. Twin: no U.
5. **N05:** `PitCommand.cs` lines 481, 590, 993; `PitAnnotationTextFormatter` "CL {level}"; P8 from SETUP-P8 and Codex D4-03; clicks as SETUP-P8x2. The cover-text click is new (the label click is proven). Twin: Esc at both prompts.
6. **N06:** LayerService constants; CLAYER BLOCKS at open from Codex readings. IL text, label and pipe layers recorded only (the card and the source disagree on the IL layer name). Twin: v3 setvar CLAYER 0.
7. **N07:** settings keys at e30556ca (`autoCadStyleCdPrompts`, `cdCommandLine.sayWhatWasUndone`); `CdCommand.cs` 1244-1250; Codex D8-05 PASS with the same points. Twin: only the prompt switch on, so CE prints "Last point taken back.".
8. **N08:** `PitRenumberCommand.cs`; Codex D5-01 saw every line on an untouched copy. Schedule rows after Yes and after U are DERIVED. Twin: answers No and expects P10 gone.
9. **N09:** ui-cells row order recorded by RUN-20261027-1842-C3.0.82-x82a1; the untouched fixture already holds P9 and P10 (Codex D4-03, D4-02, D5-01). Twin: flipped order.
10. **N10:** `PipeSettings.NonExistingPipeShowGrade` (JSON `pipe.nonExistingPipeShowGrade`), `CdViewModel` toggle label, `PipeAnnotationTextFormatter` default branch. The setting route has never been run. Twin: no setting (Tim's value, grade shown).
11. **N11:** R11's proven route on the untouched copy (Codex D3-01 same result); schedule cells before from the 3.0.82 run record and R38; after-cascade cells DERIVED from the texts IL 17.50, 17.45, 17.33, 17.28, with patterns that accept 17.5, 17.50 or 17.500. Twin: no U, rows compared.
12. **N12:** `CopiedLevelsRule.cs` line 28; Codex D3-04 saw the whole line and P8; COPY chain and label read from R34 and R34sn. Twin: flipped label P3, as R34sn_BROKEN.

### D. Known risks for the validating job

1. **Typed text into CDRG's drag prompt (N04):** Codex typed the points by keyboard; the robot has not. If BLOCKED, it is a route problem, not a CE result.
2. **The cover-text click (N05):** a new click point; object snap might move it. Only the existence and wording of the cover text are asserted.
3. **N10 setting route:** `pipe.lastChoiceByJob` may also carry choices per job folder; if the toggle starts ON despite the setting, record it as a finding with the window dump.
4. **N11 length:** about 15 minutes under load; keep it alone in its call.
5. **N01_BROKEN** changes its copy on disk; the runner refuses to reopen it, so it must be last (ORDER 999) or alone.
6. **3.0.83 (C-73)** may install during the job: stop, note the build, and restart both passes on the new build.

### E. What this document did not do (RULES 5.9)

1. Nothing was run in AutoCAD; the only run was the offline format check (24 of 24 ok).
2. No review.txt, ledger, carpark, DESK_LOG, existing case, runner or driver file was touched.
3. The everyday count of 8 is the ledger's figure; I did not re-count it from runs.
4. Whether CDSYNC (R13) and PIT and CD count as whole named items is left to the desk.

## Summary

38 named everyday items: 21 have a robot check today (8 accepted), 17 have none. Twelve new draft checks with failing twins are in `cases\drafts_opus_27oct` (24 files, offline format check clean), covering D06, D07, D08, D09, D15, D16, D18/D27 (CDREBUILD), D19, D20, D21, D24 (part) and the cascade's stored levels. If all pass twice and are reviewed, the count could reach 15 to 20 of 40. Windows, Save dialogs, unbuilt items and the CDFEEDBACK send stay with Codex or Tim.
