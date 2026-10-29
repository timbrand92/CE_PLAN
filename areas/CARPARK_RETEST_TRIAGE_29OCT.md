# Carpark retest triage: the 47 IN PROGRESS bugs (CE 02, Thu 29 Oct 2026, 16:30 Melbourne)

Job: CE_ACAD / robot / plan / 25. Read-and-write-documents only. Input: `areas\CARPARK_IN_PROGRESS_RETEST_LIST.md` (CE 05, carpark tidy T-4, Tim's item 108). **No carpark status was changed. CE 05 is the only writer of `BUG_CARPARK.md`.** Nothing was run in AutoCAD.

## ANSWER FIRST

None of the 47 can be marked fixed today. Eight now have a robot test written, ready for tonight's free window. Two are still broken, and one more (the "MIN." label) looks broken.

## FOR TIM

1. **Already proven, needing only a reviewer or a quick re-look: 2.**
   - **BUG-075 (IL text on a steep pipe):** Codex passed it on 27 Oct.
   - **BUG-188 (CE Blocks attribute tag):** Codex passed it on 28 Sep, on an older build.
2. **A robot test can close: 16.**
   - **Written today, ready to run: 8.** Each has a deliberately wrong twin that must fail, except BUG-027, which should fail as it stands.
   - **Need one short look-around run first, then a case: 8.**
3. **Need a Codex look: 9.** These are window pictures, ribbon icons, the Inspector panel and a real consultant import.
4. **Need your word: 6.** These are engineering or design choices. The robot can test them once you have answered.
5. **No longer real, or very probably not: 6.** The code that caused them has been replaced.
6. **Structural: 5.** All are already installed (the "awaiting deploy" notes are out of date). They need a Codex look in Structural, and one still fails in part.
7. **Still broken: 2.**
   - **BUG-073:** the New Pipe preview is blank.
   - **BUG-173:** the New Pit window has large empty areas.
8. **Unknown: 1.** BUG-053, the roof Xref crash, has no test drawing.
9. **Can close this week: up to 8.** That is the seven written tests that should pass, plus BUG-075 once a reviewer records it. Every written test is untried, so expect some to need a fix after their first run.
10. **Likely still broken: BUG-027.**
    - **The ruling:** on 26 Sep you said "Keep the May rule: no MIN."
    - **What the build does:** type only the first level of a pipe on Standard grade, and the label still comes out "100 DIA. UPVC PIPE AT 1 IN 100 MIN.".
    - **Proof:** read from the code, not yet run. Robot case K02 will show it tonight.
11. **What you need to do: nothing now.** Your six questions (item 4) are listed below the line for the desk to batch into your work hours.

---

## How to read this

Each entry gives:

1. **Sees:** what the drafter sees go wrong.
2. **Class:** the triage class.
3. **Evidence:** what exists, with the build.
4. **Steps:** test steps in AutoCAD terms, marked DERIVED where inferred from the code.
5. **Case:** the draft case name, if one was written.

**Lines checked:**

- **Installed:** `origin/claude/rel-20261026z`, Civil 3.0.85+09126560. The robot ledger agrees: the newest runs say civil 3.0.85+09126560, Structural 1.0.125+204dfad2, Manager 1.1.85.
- **Newest:** `origin/claude/rel-20261029a`, Civil 3.0.86+5888ee75. No file named in any entry below changed between the two lines.

**Sources searched:**

- **Robot cases:** all 334 case files and their headers in `C:\Lisp Files\_ACAD_DRIVER\cases` and every sub-folder.
- **Ledgers:** `runner-reports\ledger.json` (1,385 rows) and `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`.
- **Reviews and lists:** the Opus and Codex case reviews and `PILOT_CRITICAL_TEST_LIST_29OCT.md`.
- **Codex looks:** every `CODEX_VERIFY*` report in `C:\Lisp Files\_TEST_COPIES_20260923`.
- **Other:** `REGRESSION_LOG.md` on the installed line, and the code itself (git show and git grep only).

**Result:** no robot case and no ledger row names any of the 47 bug numbers. R39 and R39b mention BUG-187 only to say "not driven". The only real-AutoCAD evidence is Codex looks: W25, W29, W61 and W63 (8 to 12 Oct), pass 18 (28 Sep), pass 11 (25 Sep) and E11 (27 Oct).

---

## Order of work (quickest closes first)

1. **Reviewer only (no AutoCAD):** record BUG-075's Codex PASS (E11, Civil 3.0.80; no changes to these files since).
   - **Why a reviewer only:** under RULES 4.5 a Codex PASS in real AutoCAD counts. A reviewer checks the E11 screenshots and steps, then hands it to CE 05 as "Codex-accepted (3.0.80, steep-pipe half only)".
   - **Not covered:** the edit-path half ("a genuine clash still flips the text away").
2. **Robot, tonight after 5:30 pm: the 15 draft files in `cases\drafts_carpark_29oct\`.**
   - **One AutoCAD start fits all:** none has a SETTING line.
   - **Split into two calls** to keep each session short and inside the reopen cap: call A is K01 to K04 with their twins (7 files), call B is K05 to K08 with their twins (8 files).
   - **Example:** `-Only "K01,K02,K03,K04"`. Note that -Only also picks up the `_BROKEN` files whose names start with the same id.
   - **Then repeat** both calls in a second, separate AutoCAD start (the two-start rule). Each twin needs only its one red run.
   - **After that:** an independent Opus review of the eight. Only then can CE 05 write "FIXED (Claude-accepted, build, date)".
3. **Robot after a short look-around run:** BUG-028, 032, 033, 036, 038, 072, 074 (auto-pick half) and 186.
   - **The probe:** each needs one unrecorded first run to learn a control name, a prompt or a fixture fact before a case can be written (listed per entry).
4. **Codex looks:** batch into one Codex brief: BUG-020, 026, 058, 059, 060, 071, 170, 172 and 177, plus the Structural set 085, 086, 088, 089 and 185, and the re-looks for 188 and 187 (picture half).
5. **Tim's word:** BUG-029, 031, 034, 042, 077 and 171, as one batch of questions for his work hours.
6. **Builder work (still broken):** BUG-073 and BUG-173. BUG-027 joins them if K02 fails as expected.

### HAZARD found while drafting: remembered New Pipe values are not put back

New Pipe saves its choices to `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json`, listed in `SettingsService.RememberedValues.cs`. The saved choices include:

- **Grade:** `grade.method` and `grade.customValue`.
- **Work out one end:** `inverts.autoSecondFromGrade`.
- **Second level set:** `inverts.secondRequired`.
- **Pipe label:** `options.createText`.
- **Pipe type:** `pipe.type`.

The runner's settings guard restores only CD_Settings.json, CS_Settings.json and settings.json. So a case that draws with Set my own grade, "I know one end", one level or the label off leaves Tim's next real CD opening that way.

**Values read at 16:3x today (file saved 13:54):**

- **grade.method:** defaultMin.
- **autoSecondFromGrade:** false.
- **autoCalcDirection:** upToDown.
- **secondRequired:** true.
- **createText:** true.
- **pipe.type:** Stormwater Pipe.

**What the drafts do about it:**

- **Set them first:** every draft sets those choices explicitly on its first pipe.
- **Reset pipe:** K01, K02 and K05 end with a "reset" pipe that saves the values above back.
- **Cancel:** K07 and K08 cancel New Pipe rather than start it.

**If a case stops early:** those values must be put back by hand before Tim next draws.

**Recommendation for the runner owner:** snapshot and restore `CD_RecentValues.json` by hash, as the other settings files are. This was already flagged for N10 in `ROBOT_N_CASES_PREFLIGHT_27OCT.md`. I did not edit the runner.

### About the failing twins

None of these fixes has a settings switch that turns it off. So each twin is "the same steps with one deliberate input change that makes the drawing really wrong", for example typing 1.11 instead of 1.10 or leaving a toggle on. README_CASES allows this as a "deliberately broken variant", but the reviewer should confirm it meets the acceptance rule.

K02 has no twin by design. On today's build K02 itself should FAIL. That FAIL is the red, and the same case passing after a fix is the green.

---

## Group 1: coded 20 to 21 May 2026 (18)

1. **BUG-020: CDWT riser and dropper tags.**
   - **Sees:** riser and dropper showed "DP" (the downpipe tag) instead of R1 and D1.
   - **Class:** NEEDS A CODEX LOOK.
   - **Evidence:** none in AutoCAD. Code present (WaterTankCommand.Apply.cs 130-142 and the attribute sweep 281-294). Tim's ruling of 25 Sep: "Keep R1 / D1".
   - **Steps (DERIVED):** run CDWT, place a tank with a riser and a dropper. Right: R1 beside the riser, D1 beside the dropper, no "DP" anywhere. Run again: R2 and D2.
   - **Case:** none. The CDWT window has never been mapped; once Codex maps it, the robot can read the attribute with ent-read.

2. **BUG-021: IL text "Above" landed below the pipe at about 92 to 96 degrees.**
   - **Sees:** on a nearly level pipe falling slightly south-east, the invert text sat under or on the pipe although Above was chosen.
   - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
   - **Evidence:** none in AutoCAD. R03 (accepted) checks the IL texts sit near their ends, not their side. Fix present (GeometryHelper.cs 183-215, one helper for every caller).
   - **Steps:** draw two 20 m pipes with CD, 150000,-96000 to 170000,-96698 (92 degrees) and 150000,-100000 to 170000,-102096 (96 degrees), levels 18.000 and 17.900, IL texts Above. Right: all four IL texts are above their pipe line. DERIVED margins: each text's y is checked against the line's lowest point within 1000 mm of its end.
   - **Case:** K03, twin K03_BROKEN (pipe A first end set to Below).

3. **BUG-025: typed 1.10 shown as 1.11.**
   - **Sees:** with "I know one end" on, a level typed as 1.10 came out on the drawing as 1.11 on short pipes.
   - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
   - **Evidence:** none in AutoCAD. Codex W34 saw only the window's two-decimal display. Fix present (MathHelper.cs 225-238 and 298-340).
   - **Steps:**
     - **Pipe A:** 10 m, Set my own 1 in 100, upstream end known, 1.10. Right: IL 1.10 and IL 1.00.
     - **Pipe B:** 1 m, downstream end known, 1.10. Right: IL 1.10 stays at the typed end and the other end is IL 1.12 (DERIVED: the 20 mm minimum drop). Bug: 1.11.
     - **Pipe label:** off, so the short pipe asks no leader question.
   - **Case:** K01, twin K01_BROKEN (pipe B typed 1.11).

4. **BUG-026: Inspector grade 1:94 against label 1 IN 100.**
   - **Sees:** on a 15 m pipe falling exactly 0.150, the Inspector said 1:94 while the label said 1 IN 100.
   - **Class:** NEEDS A CODEX LOOK.
   - **Evidence:** none in AutoCAD. Code now uses one rounding rule for both (InspectorPaletteService.cs 3395-3410, MathHelper.ActualGradeDenominator). The cause was BUG-025's wrong stored levels, which K01 covers.
   - **Steps (DERIVED):** CD 150000,-96000 to 165000,-96000, levels 1.500 and 1.350. The label reads 1 IN 100. Select the pipe and open CDINSPECTOR. Right: every grade figure reads 1 in 100 or 1:100. Bug: 1:94.
   - **Case:** none (no case has ever read the Inspector palette).

5. **BUG-027: "MIN." on pipe labels.**
   - **Sees:** labels ending "AT 1 IN 100 MIN.".
   - **Class:** ROBOT CAN PROVE, CASE WRITTEN, and LIKELY STILL BROKEN.
   - **Tim's ruling:** UX-CPLAN-05, 26 Sep 11:46: "Keep the May rule: no MIN."
   - **Code:** the installed CdCommand.Grade.cs 212-221 still adds " MIN." when the grade is Standard, only the first level is typed and "I know one end" is off. A unit test asserts it. Every existing label case types both levels, so none reaches this path.
   - **Steps:** CD 150000,-96000 to 170000,-96000, Standard grade, first level 18.000, second level switched off. Right: the label ends "AT 1 IN <n>" with nothing after. Expected today: "... MIN.".
   - **Case:** K02 (no twin by design; its expected FAIL is the red).

6. **BUG-028: CDSTRIP floor waste insets.**
   - **Sees:** the floor waste sat flush with the strip end; Tim wanted it 50 mm in, and corners inset.
   - **Class:** ROBOT CAN PROVE after a probe (end inset). The corner half is SUPERSEDED: the code now puts corner wastes on the centreline with 0 inset (StripDrainCommand.cs 64-70, R6.7). ENGINEERING_RULEBOOK B9 still lists the two corner rules as a disagreement for Tim.
   - **Evidence:** none in AutoCAD; CDSTRIP has never been driven by a case or a Codex sweep.
   - **Probe first:** does DRV1_B1 have what CDSTRIP needs? It refuses with "CDSTRIP refused - <missing>" otherwise.
   - **Steps (DERIVED):** CDSTRIP, C, 150000,-96000, 160000,-96000, Enter, A. Right: two FLOOR WASTE blocks at x 150050 and 159950. Bug: 150000 and 160000.
   - **Case:** not written (fixture unknown).

7. **BUG-029: CDSTRIP fall arrow style.**
   - **Sees:** Tim asked for a leader in his style on 25DIMS with "FALL" text.
   - **Class:** NEEDS TIM'S WORD.
   - **The conflict:** the carpark entry and ENGINEERING_RULEBOOK say a multileader on 25DIMS. The installed code draws a plain leader on layer STRIP DRAIN with no text (StripDrainCommand.Apply.cs 200-211, R6.11).
   - **Steps:** none until Tim says which is the office standard. A robot can then read the arrow's layer and count.
   - **Case:** none.

8. **BUG-030: "[Yes/Ce]" in the dynamic-input prompt.**
   - **Class:** SUPERSEDED. The prompt no longer exists: no "[CE]" keyword prompt remains, and the rising-main question became a popup and a New Pipe toggle (CdCommand.Breakline.cs; CdDialog.xaml 280-285).
   - **Small leftover:** CdCommand.Breakline.cs line 64 still prints "you'll be prompted to continue this rising main", but no prompt follows.
   - **Case:** none.

9. **BUG-031: rising-main continuation as a popup.**
   - **Sees:** Tim wanted a Yes/No popup.
   - **Class:** NEEDS TIM'S WORD.
   - **What I verified:** the popup "Creative Engineering | Rising Main" exists, but its answer is stored and never used. The break mark and anchor are placed whether the drafter clicks Yes or No (CdCommand.Breakline.cs 36-64, read today). The second popup (continuing an earlier half) has no caller.
   - **Questions for Tim:** should No leave no break mark? Is the up-front popup still wanted now that New Pipe has a "Continuation" toggle?
   - **Case:** none.

10. **BUG-032: Inspector "Linked half" badge for a split rising main.**
    - **Class:** ROBOT CAN PROVE after a probe.
    - **Evidence:** none. Code present, but the wording changed: "Linked half: {handle} ({role})" and "PARTNER MISSING" (InspectorPaletteService.cs 1814-1895). The carpark text is stale.
    - **Probe first:** build a cross-plan break pair once, and check that ui-dump can read the docked CE Inspector.
    - **Steps (DERIVED):** CD with "Cross-plan break" on, then CD again for the second half. Open CDINSPECTOR on each half. Right: "Linked half: <the other half's handle>".
    - **Case:** not written.

11. **BUG-033: flow arrow too far off a pipe under 100 mm.**
    - **Sees:** a 50 mm riser's arrow sat about 425 mm off instead of about 150 mm.
    - **Class:** ROBOT CAN PROVE after a probe.
    - **Evidence:** none. Fix present in both pipe writers (PipeCreationService.cs 511 and PreparedOutputs ~222).
    - **Probe first:** can New Pipe be given 50 mm (C2.Diameter), and where does the arrow block's insertion point sit?
    - **Steps (DERIVED):** CD 150000,-96000 to 170000,-96000 at 50 mm. Right: the arrow about 150 mm from the line (25 + the 125 Settings offset). Bug: about 425.
    - **Case:** not written.

12. **BUG-034: next CD goes straight to continuation.**
    - **Class:** NEEDS TIM'S WORD. The installed build asks one popup ("Continue on another plan?") and copies the first half's type, size and levels on Yes. Tim asked for no question at all.
    - **Case:** none until answered.

13. **BUG-035: pit skewed under a rotated UCS.**
    - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
    - **Evidence:** none. A defensive fix is present (PitCommand.cs 405-425). It now forces the New Pit orientation value (Manual 0 by default) rather than always 0.
    - **Steps:** _.UCS _Z 30, CD from world *150000,-96000 to *170000,-96000, then PIT at *175000,-90000, cover 19.000, manual rotation 0. Right: the pit's stored rotation is 0. Bug: 0.5236 (30 degrees).
    - **Case:** K04, twin K04_BROKEN (rotation 30 typed).

14. **BUG-036: cover-level text after MIRROR.**
    - **Class:** ROBOT CAN PROVE after a probe.
    - **Evidence:** Codex C4B (1 Oct) mirrored pits and "labels followed", but cover text was not named. The code has been rebuilt since the carpark text (displacement tracking, LinkService.PipeMoveHelpers.cs 263). CDREFRESHLINKS is still typed.
    - **Probe first:** the MIRROR chain on pit P3 (handle 109D56, cover text 109E0F) with its pipes attached.
    - **Steps (DERIVED):** MIRROR P3 and its cover text about a horizontal line, Erase source Yes, then MOVE 0,2000 as R12. Right: the cover text moves 2000 mm with the pit. Bug: it snaps back.
    - **Case:** not written.

15. **BUG-037: PIT BLOCK 2 in the installer.**
    - **Class:** SUPERSEDED.
    - **Why:** the installer now copies every block in `Installer/source_blocks`, which holds both PIT BLOCK 2 and 3 (build_installer.ps1 308-320). PIT BLOCK 3 is preferred (BlockService.cs 215-218) and BUG-052 carries it.
    - **Still open:** the colleague-machine check is deploy-gated; it needs an installer build and a second PC.
    - **Case:** none.

16. **BUG-038: Inspector pairs a split rising main's levels in one line.**
    - **Class:** ROBOT CAN PROVE after the BUG-032 probe.
    - **Code changed:** it now reads "SPS IL x -> destination IL y" (no break-line level; Tim's 26 May correction), InspectorPaletteService.cs 1907-1965. The carpark wording is stale.
    - **Case:** not written.

17. **BUG-041: Set my own grade refused more than two points.**
    - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
    - **Evidence:** none. Fix present (CdCommand.cs 1223-1228); the old message is in no source file.
    - **Steps:** CD through 150000,-96000, 154000,-96000, 154000,-94000, 158000,-94000, then Enter. Set my own 1 in 100, levels 18.000 and 17.900. Right: one pipe reaching x 158000, label "AT 1 IN 100", no refusal.
    - **Case:** K05, twin K05_BROKEN (route ends at 160000).

18. **BUG-042: cross-plan break for ordinary pipes.**
    - **Class:** NEEDS TIM'S WORD. The carpark said the toggle's place needed his UX confirmation. It shipped as "Cross-plan break" and "Same-plan break" toggles (CdDialog.xaml 306-312) for every pipe type. The robot can prove the pairing after his answer.
    - **Case:** none.

## Group 2: coded 3 to 4 July 2026 (11)

19. **BUG-058: imported IO and OF pits not registered.**
    - **Class:** NEEDS A CODEX LOOK.
    - **Why:** the robot has no consultant-package master (only DRV*.dwg masters) and cannot choose the import file.
    - **Code:** fix present (XcivilPitInsertionService.cs 647, XcivilSourceTagPitRegistrationService.cs 141).
    - **Steps (DERIVED):** on a copy of the W26-26 package, run CDIMPORTXCIVIL, then CDCHECKDWG. Right: no "has no ProjectData entry" line for IO or OF pits.

20. **BUG-059: import doubled the pipes.**
    - **Class:** NEEDS A CODEX LOOK.
    - **Evidence:** Codex W25 (8 Oct, Civil 3.0.36) saw the doubling gone (63 to 53 pipes), still 8 over the consultant's 45. Nothing since; old build.
    - **Steps:** import twice with Replace. Right: the pipe count is unchanged on the second import.

21. **BUG-060: pipe from a pit to itself after import.**
    - **Class:** NEEDS A CODEX LOOK.
    - **Evidence:** Codex W25 and W29 (3.0.36) FAILED (P8 to P8). BUG-440 (3.0.38) now skips a zero-length pipe on import, so the symptom is hidden rather than cured. A real 1,676 mm pipe may be lost instead.
    - **Steps:** import, then read the Pit Schedule. Right: no P8-to-P8 pipe, and the 1,676 mm pipe present.

22. **BUG-070: "Proposed" strip showed three decimals.**
    - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
    - **Evidence:** Codex E11 (27 Oct): "NOT TESTED, no strip shown". Its pipe had no pit at either end, and the strip appears only when a pipe end is on a pit. Fix present (CdViewModel.GradeSuggestion.cs 485).
    - **Steps:** PIT at 150000,-80000 with cover 19.000, then CD from that pit to 170000,-80000. Right: the strip reads "Proposed: ... US 18.xx / DS 18.xx" (two decimals). Then Cancel.
    - **Case:** K07, twin K07_BROKEN (no pit, so no strip).

23. **BUG-071: Grade mismatch and rising-main popups clipped.**
    - **Class:** NEEDS A CODEX LOOK.
    - **Evidence:** the Grade mismatch box was opened and read in full in Codex X9, X2, E3, D7, F1 and F7 (3.0.72 to 3.0.80), with no clipping noted, but never judged as BUG-071. A one-line Codex confirm would do. The rising-main popup has never been looked at; it depends on Tim's BUG-031 answer.

24. **BUG-072: pit P-number label jumps on resize.**
    - **Class:** ROBOT CAN PROVE after a probe.
    - **Evidence:** Codex E11 BLOCKED (window capture timeouts).
    - **Probe first:** read the Edit Pit size field names with ui-dump.
    - **Steps (DERIVED):** PIT with the label clicked 900 mm up-right, then PITEDIT and shrink 450 to 300. Right: the label moves in about 75 mm, and the log line "PITEDIT ShiftAnnotation ... gapBefore=.. gapAfter=.." shows equal gaps. Bug: the label moves out.

25. **BUG-073: New Pipe preview blank.**
    - **Class:** STILL BROKEN.
    - **Evidence:** Codex E11 (27 Oct, Civil 3.0.80, the fix inside) FAIL SURE: "No plan preview for this pipe", no length, no fall. No relevant file has changed up to 3.0.85.
    - **Likely cause (DERIVED, not run):** CdCommand.GradeSuggestion.cs 116-122 returns before line 131 sets the length when no pipe end is on a pit.
    - **Needs:** a builder, then a Codex look.

26. **BUG-074: smarter label and arrow leg, plus click to move.**
    - **Class:** HAS A CASE NOT YET REVIEWED (click-to-move half). Draft P01 (`drafts_pilot_29oct`) is not run and not reviewed.
    - **Auto-pick half:** ROBOT CAN PROVE after a probe.
    - **Steps (DERIVED):** a polyline 150000,-96000 to 150000,-86000 to 156000,-86000, then CD, E. Right: the label sits beside the 6 m flat leg, not the 10 m vertical one.

27. **BUG-075: IL text on top of a steep pipe.**
    - **Class:** ALREADY PROVEN (steep-pipe half). Codex E11 PASS SURE on Civil 3.0.80, an older build than installed, with no change to these files. Needs only a reviewer to record it as Codex-accepted.
    - **Not covered:** the "genuine clash still flips" half.

28. **BUG-077: pit inlet-to-outlet drop carried down the run.**
    - **Class:** NEEDS TIM'S WORD.
    - **The conflict:** the carpark (3 Jul) and plan card HV11 say a 5 mm default. The code now follows rulebook R-08: 20 mm default, allowed values 0, 20 and 50 only (UserSettings.cs 1486; RulebookSettings.cs 46-49). So 5 mm cannot be chosen.

29. **BUG-078: Edit Pipe could not move an IL text to Below.**
    - **Class:** ROBOT CAN PROVE, CASE WRITTEN.
    - **Evidence:** Codex E11 DIFFERENT. Edit Pipe shows only "Above" and "Hidden", Codex pressed Hidden, and the Above/Below flip was never tried. The missing word "Below" is a small Codex look item.
    - **Steps:** CD 150000,-96000 to 158000,-96000, levels 18.000 and 17.920, IL Above. Then CDEDIT on the pipe, switch the first end's Above off, Save. Right: the IL 18.000 text moves under the line and stays there.
    - **Case:** K06, twin K06_BROKEN (toggle left on).

## Group 3: Structural, installer and deploy-gated (9)

30. **BUG-052: PIT BLOCK 3 everywhere.**
    - **Class:** SUPERSEDED, by the automatic migration on open (PitBlockMigrationService.cs 15-58).
    - **Evidence:** BUG_REGISTER_TRIAGE_2026-10-24 lists it as a close candidate. Its two remaining defects are carried by BUG-793 (OPEN). Closing it is Tim's call.

31. **BUG-053: roof Xref drawing crash.**
    - **Class:** UNKNOWN. No Xref-heavy roof drawing exists as a fixture. Code present (LinkService.Reactors.cs 175-215).
    - **Note for CE 05:** compound behaviour now defaults ON (Tim 24 Sep). That is harmless while the overrules stay unregistered, but the entry does not say so.

32. **BUG-085: beam command 1 XREF_OBJECT_LIMIT_EXCEEDED.**
    - **Class:** STRUCTURAL, ALREADY INSTALLED (the fix is in Structural 1.0.125).
    - **Evidence:** Codex passed object-to-object (S1, 1.0.87) and point-to-point (W13, 1.0.102; W19, 1.0.105) on small drawings. Not seen: the mixed object and point ends, and the original Xref-heavy trigger. Needs a Codex look.

33. **BUG-086: C2 stale support block.**
    - **Class:** STRUCTURAL, ALREADY INSTALLED. Needs a Codex look on a drawing that holds an old support definition. No such fixture is known.

34. **BUG-088: lintel L4 refused, RB9 label far away.**
    - **Class:** STRUCTURAL, ALREADY INSTALLED. Needs a Codex look; the label distance is judged by eye.

35. **BUG-089: lintel L2/L4 LINTEL_BOUNDARY_MISSING.**
    - **Class:** STRUCTURAL, ALREADY INSTALLED, STILL FAILING IN PART.
    - **Fix found:** 1fb7da9e (20 Aug), an ancestor of 1.0.125. The 22 Oct reconciliation's "no fix" is wrong.
    - **New failure:** Codex pass 11 (1.0.75) failed the propose-and-accept route with a different code, INSIDE_POINT_EVIDENCE_CHANGED. There is no carpark entry for that failure. Needs a Codex look on 1.0.125.

36. **BUG-091: CD free-point AutoCalc, CDEDIT Apply, invert mask.**
    - **Class:** PROBABLY NO LONGER REAL, unproven. Both quoted refusal sentences are in no source file, and CD free-point routes pass in R39, R39b and R36 on 3.0.84 to 3.0.85.
    - **Not proven:** the CDEDIT Apply and mask parts.

37. **BUG-092: Manager ribbon rebuilt 60 times.**
    - **Class:** PROBABLY NO LONGER REAL. The 60-retry loop is gone; the ribbon now builds once on an idle hook (CeUnifiedRibbonService.cs ~124-155; fc857a08, cf6b3bec).
    - **Not proven:** "is the lag gone" is Tim's feel.

38. **BUG-094: CDEDIT opens differently from the pipe's MLINE and PLINE.**
    - **Class:** PROBABLY NO LONGER REAL on AutoCAD 2027, where a CE pipe is one object.
    - **Wrong hash in the carpark:** it names 96e7d76a, which is "Keep reversed invert text readable...". The real fix is e1cee45b ("Fix CDEDIT routing for pipe-side MLINE ownership"), an ancestor of the installed line (verified today).
    - **Needs:** an older-pipe fixture for a Codex look.

## Group 4: September PR fixes (9)

39. **BUG-170: What's New window readability.**
    - **Class:** NEEDS A CODEX LOOK. Fix installed (4465e22d, deaac3e2).
    - **The carpark's step cannot be followed:** it says "type the What's New command", but there is no such command. The window opens only on the first start after a version change (PluginInitialization.cs 570-588).
    - **Route for Codex:** remove the last-seen state file before launch. E6 (26 Oct) found no route.

40. **BUG-171: an upgraded stormwater pipe opens as Detention.**
    - **Class:** NEEDS TIM'S WORD, then robot.
    - **Evidence:** the only FAIL (Codex W61-06, 3.0.47, fix inside) is on pipe 109E23. That pipe's own plan label reads "... DETENTION", so the fixture may simply be a detention pipe.
    - **Question for Tim:** is pipe P3 to P2 on the test drawing really detention?

41. **BUG-172: ribbon pictures.**
    - **Class:** NEEDS A CODEX LOOK (E12 never started).
    - **Also Tim's word:** six commands still show the generic wrench (CDPERIMETER, CDTWL, CDDEST, CDPAVE, CDKERB, CDSPOONDRAIN) and need his artwork.

42. **BUG-173: New Pit, Edit Pit and Edit Pipe should look like New Pipe.**
    - **Class:** STILL BROKEN.
    - **Evidence:** Codex E11 (3.0.80, fix inside) FAIL SURE, because New Pit has large empty preview areas. No pit window file has changed since.
    - **Needs:** a builder, then a Codex look.

43. **BUG-177: CDPIPEOBJ not on the ribbon.**
    - **Class:** NEEDS A CODEX LOOK (ribbon).
    - **Fix is in the code:** command-registry.json marks CDPIPEOBJ hidden, with Tim's UX-PIPE-08 note (verified today). The 22 Oct reconciliation's "no fix" is wrong, and the PR number in the entry (#291) does not match git.
    - **Typed half:** robot-provable (typed CDPIPEOBJ still starts).

44. **BUG-185: beam at 45 degrees on a metre drawing.**
    - **Class:** STRUCTURAL. Planner unit tests only (BeamCommandSourceCompatibilityTests). Low priority; a Codex look if wanted.

45. **BUG-186: Edit 2 Pipes "Carry downstream" refused after the preview.**
    - **Class:** ROBOT CAN PROVE after a probe.
    - **Evidence:** Codex W63-04 (3.0.48, fixes inside): the original refusal did NOT recur ("2 pipes updated"). The FAIL it reported (grade 91, a level still changed after U) was read after opening and cancelling the editors before the U, so it is not clean.
    - **Probe first:** the Edit 2 Pipes window has no control names in its XAML, so one ui-dump run must find the Design grade field and the Apply button first.
    - **Steps (DERIVED):** pick-first pipes 11C807 and the next pipe, CDEDIT, Design grade 100, Carry downstream, Apply. Right: "2 pipes updated", the downstream level moves as previewed, and one U restores every level.
    - **Grade-memory half:** proven by Codex pass 18 (3.0.15); see 46.

46. **BUG-187: Existing then back to Stormwater loses the grade and preview.**
    - **Class:** ROBOT CAN PROVE, CASE WRITTEN (grade-memory cause). Also ALREADY PROVEN on an old build: Codex pass 18 B2 PASS, Civil 3.0.15. Codex W61-03 (3.0.47) was BLOCKED because its route had changed.
    - **Steps:** CD, Set my own 100, then Detention, Existing, Stormwater. Right: Set my own still On, Standard Off, box still 100. Then Cancel.
    - **Not covered:** the preview picture is a Codex look.
    - **Case:** K08, twin K08_BROKEN (Standard pressed).

47. **BUG-188: CE Blocks inserted blocks without their attribute.**
    - **Class:** ALREADY PROVEN (attribute half). Codex pass 18 (28 Sep, Civil 3.0.15): the PIT LABEL tag showed and stayed editable (P1 edited to T18). That PASS is not yet in the carpark entry.
    - **Old build:** a re-look on 3.0.85 is advised, because the CE Blocks redesign (PR #337) came later.
    - **Live-preview half:** a Codex look.

---

## Questions for Tim (for the desk to batch into his work hours; none was asked by this job)

1. **BUG-029:** strip-drain fall arrow. A multileader on 25DIMS with "FALL" text (carpark and rulebook), or the plain arrow on STRIP DRAIN that CE draws today?
2. **BUG-031:** after the first half of a rising main, if the drafter clicks No on "Continue on another plan?", should CE leave NO break mark? Today it leaves one either way.
3. **BUG-034:** is one Yes click on that popup acceptable, or must the second CD never ask?
4. **BUG-042:** are the "Cross-plan break" and "Same-plan break" toggles in New Pipe where you want them?
5. **BUG-077:** default pit drop. 5 mm (your 3 Jul ruling and card HV11), or 20 mm (rulebook R-08, which today allows only 0, 20 or 50)?
6. **BUG-171:** on the test drawing, is pipe P3 to P2 (450 STORMPRO, plan label "... DETENTION") really a detention pipe?

## For CE 05 (carpark wording found stale; no status changed by this job)

1. **BUG-032 and BUG-038:** the Inspector wording has changed (see entries 10 and 16).
2. **BUG-035:** the forced rotation is now the New Pit orientation value, not always 0.
3. **BUG-042:** the toggle is now "Cross-plan break" / "Same-plan break".
4. **BUG-077:** the default is now 20 mm.
5. **BUG-094:** the fix commit is e1cee45b, not 96e7d76a.
6. **BUG-089:** the fix 1fb7da9e exists, and a new pass 11 failure (INSIDE_POINT_EVIDENCE_CHANGED) has no entry.
7. **BUG-177:** the fix is in the registry.
8. **BUG-170:** there is no typed What's New command.
9. **BUG-188:** Codex pass 18 PASS is not recorded in the entry.
10. **BUG-085, 086, 088, 089:** the "awaiting 1.0.73 deploy" wording is stale; installed is 1.0.125.
11. **BUG-031:** the popup's answer is ignored (possible new defect).
12. **BUG-027:** the code contradicts Tim's 26 Sep ruling (likely live defect; K02 will show it).

## What I did NOT verify

1. **Nothing was run in AutoCAD.** AutoCAD was Tim's and in use (acad.exe started 9:14 am). Every draft case is unrun, and every route in it marked DERIVED is a reading of the code.
2. **Offline check only.** `case_runner.ps1 validate` on `drafts_carpark_29oct` returned "15 file(s) checked, 0 invalid". I read the validate path first: it dot-sources the driver library with -Library, which defines functions and runs nothing. That says the files parse, not that the routes work.
3. **Unproven control names.** These follow the rule in WorkshopEditorFocus.cs line 75 that gives the proven C2.FirstInvert, but no case has used them yet: C2.KnownInvert, C2.IsAutoCalcUpToDown, C2.IsAutoCalcDownToUp, C2.SecondInvertEnabled, C2.CustomGrade, C2.CreatePipeText, C2.ManualRotationDegrees, C2.FirstInvertIsAbove (Edit Pipe).
4. **Unproven route details:**
   - **K02:** whether New Pipe accepts a blank second level.
   - **K07:** whether the strip text appears in a ui-dump.
   - **K04:** whether `*` world points are taken by CE's prompts.
   - **K03:** the IL-text offset that sets the margins.
5. **Not read for every unit test.** I did not open the unit tests the carpark names. Where an entry says "N tests green", that is the carpark's claim, not mine.
6. **No PR states.** `gh` is not on the shell PATH, so merge state was taken from commit ancestry.
7. **Group work by readers.** The group 1 to 4 evidence was gathered by four reader agents and spot-checked. I re-read the code myself for BUG-027, BUG-031, BUG-177 and BUG-094, the installed and newest line heads, the runner verbs and the remembered-values list. The other code citations are the readers', not re-read by me.
8. **No Structural, installer or Manager build was read beyond git.** I did not check the Manager log lines or the installer payload.
