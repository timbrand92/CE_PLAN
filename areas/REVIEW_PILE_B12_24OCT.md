# Opus review of the best unreviewed PRs, batch 12 (Sat 24 Oct 2026, about 06:55 to 07:15 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class F (plan work), positions 1 to 12 of the FULL list, counted within class F only: #972, #983, #984, #985, #986, #991, #992, #996, #1000, #1010, #1019, #1020.

I read the code at each PR's exact head, not the PR text. Heads were read from GitHub at about 07:00 and fetched into my own bare copy `C:\ce-tr\b12.git` (removed at the end). None had moved since 9 or 10 Oct. I compared the Civil PRs with installed Civil 3.0.72 / Manager 1.1.72 (`claude/rel-20261023m` @ f7f7d551) and the C-63 train (`claude/rel-20261024m` @ 28987b73), and the two Structural PRs with installed Structural 1.0.122 (`claude/rel-20261023s` @ e6d597c0). Trial merges ran in memory only. Read-only: nothing built, tested, merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

Plan scope was judged against the draft one plan (`04_REFERENCE/one-plan-draft-2026-10-17/one-plan-civil.md`, sections "To do for 9 Nov vs after 9 Nov"), Ruling A (17 Oct, pause on new items, bug fixes carry on) and Ruling F (17 Oct, Civil + Manager to Max on 9 Nov; ribbon reorganisation on HOLD).

## ANSWER FIRST

1. **Counts (12 PRs):** MERGE 1, MERGE-WITH-FIXES 7, HOLD 4, REJECT 0.
   1. **MERGE:** #985.
   2. **MERGE-WITH-FIXES:** #972, #984, #986, #991, #996, #1000, #1010.
   3. **HOLD:** #983, #992, #1019, #1020.
   4. **9 Nov scope (Civil + Manager + Shared):** #985, #1000, #1010 belong in it. #1020's item is listed for 9 Nov but this PR must be rebuilt. #1019's item is listed for 9 Nov but needs Tim's number first. The rest are after 9 Nov or Structural.

2. **Top faults found:**
   1. **The triage called these 12 "not reviewed". That is wrong.** All 12 had verdicts on 9 and 10 Oct at the very same heads (REVIEWLANE_LOG entries 910, 965, 966, 967). The triage missed that log's older entries. The verdicts were mostly MERGE. They still needed this fresh look, because the installed code has moved two weeks since, and four PRs no longer fit it.
   2. **#1020 (CDCHECK progress line and Esc) would add a second progress piece.** Since 10 Oct the installed code gained its own progress ticker (used by CDCHECKCURRENT), and CDCHECK's reading step was moved into one shared reader. #1020 brings a third way to do the same job (design rule 1) and clashes with the new CDCHECK. The one plan wants the progress line on CDCHECKS, not CDCHECK. Rebuild it on the live code.
   3. **#972 (assumed levels) has a trap in its clash.** In `PitCommand.cs` the PR still holds the old fixed 200 mm and 250 mm cover text gaps. The installed code now reads them from Settings (R-00 Civil item 33). Whoever settles the clash must keep the installed lines, or the Settings values silently stop working.
   4. **#1019 (FLAT label) is an engineering question, not a code fault.** It makes a pipe label read FLAT when the fall is within 5 mm, whatever the pipe length. On a 1 m connection a 5 mm fall is 1 in 200, a real grade, and the label would say FLAT. Tim's number is needed before this switch is ever ON (question below).
   5. **#991 (Civil speed: block names remembered per command) forgets to clear on a cancelled or failed command.** The installed per-command cache it copies clears in four places; #991 clears in two. Small fix.
   6. **#992 changes CE_SHARED and the ribbon.** Manager must be rebuilt from the same commit, with its pinned CE_SHARED fingerprint renewed. Ruling F holds ribbon work. HOLD until after 9 Nov.

3. **Safe to merge today, into C-64 (after C-63), in this order:**
   1. **#985** as it is (only the REGRESSION_LOG top clashes).
   2. **#1010** keeping both sides of its one `UserSettings.cs` clash (both add a switch at the end of the import group).
   3. **#1000** once its three-file clash is settled the way item 9 below says.

4. **Rules checks across the batch:**
   1. **Redo (U then REDO):** nothing new writes between a U and its REDO. #991 adds memory-only clearing at command start and end (no drawing access). #992's ribbon event writes nothing to the drawing. #1020 opens nothing and writes nothing. #972 writes the job record only inside its own typed command (one U).
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. No PR edits drawing objects except through existing commands.
   3. **Switches:** the one bug-fix switch (#1010) starts ON. Plan-work switches (#972, #992, #996, #1019, #1020) start OFF. #985 is a privacy protection with no switch, which matches Tim's "Don't send; say so" rule (UX-QA-05).
   4. **CE_SHARED:** only #992 touches it (two files). Civil and Manager compile the same `Shared\CE_SHARED` folder, so they stay identical only if both are built from one commit.
   5. **Installer and signed-update files:** none touched.
   6. **Hard-coded engineering values:** #972 has the default datum (100.00) and default fall (1 in 100) as fixed numbers. The fall should be a Settings value. #996 compares levels to 0.5 mm but shows them to 2 decimals (see item 8).
   7. **Hard blocks:** none new. #985's refusal is Tim's own privacy rule with a working route (From file...).
   8. **C-63 list:** none of the 12 is in C-63. Trial merges against C-63 give the same clashes as against the installed code. C-63 changes `LandXmlParser.cs`, but #1010 still merges cleanly there.

5. **One engineering question for Tim (work hours, not urgent; one plan Set C Q1):** should a pipe label read FLAT when the two inverts are within 5 mm?
   1. **What I understand:** the 5 mm is the same Settings value the "essentially flat" warning uses. The recommendation on file is "FLAT at 5 mm".
   2. **The catch:** 5 mm is a fixed fall, not a grade. On a 10 m pipe it is 1 in 2,000 (fine to call FLAT). On a 1 m pipe it is 1 in 200, which is a real grade, and the contractor would read FLAT.
   3. **My recommendation:** judge it by grade instead: FLAT only when the grade is flatter than a Settings value, for example 1 in 1,000. Then a 1 m pipe at 1 in 200 keeps "AT 1 IN 200", and a 10 m pipe with a 3 mm fall still reads FLAT. The 1 in 1,000 is Tim's number to set.

## One item per PR

1. **#972 Batch 6 card 6.4, UX-RL-04 (Civil): CDASSUMEDLEVELS, assumed levels for a job with no survey.** Head edf5ecf1 (stacked on #969, which is installed).
   1. **Plan item:** UX-RL-04 (Tim 27 Sep, "Ask for assumed levels"). **Part only:** the typed command and the New Pit offer. The CE panel's "Levels: ASSUMED" line and the plotted note "LEVELS ARE ASSUMED AND SUBJECT TO SURVEY" are written as words but nothing shows them. The New Pit box still says "Survey RL".
   2. **9 Nov?** No. The one plan lists UX-RL-04/05 under "After 9 Nov".
   3. **Claim real?** Yes. Nothing like it is installed (no `CDASSUMEDLEVELS`, no `AssumedLevelService`).
   4. **Does only that?** Yes. The command picks a point, asks a level (Enter = 100.00) and an optional fall (pick high side, low side, "1 in N"), and saves it on the job record. Esc at any prompt changes nothing. New Pit offers the level only with `survey.offerAssumedLevelsWhenNoSurvey` ON (OFF), so out of the box nothing changes. The command is hidden from the ribbon. A redesign Apply keeps the plane.
   5. **Test fails without it?** Yes for the round 6 fix: the switch-OFF test was RED first (builder log). The maths tests are new with the new class. A 1 in 80 fall over a millimetre drawing is tested in real metres.
   6. **Risks:** a Unitless drawing (INSUNITS 0) is treated as millimetres, the house rule; a metre-coordinate Unitless drawing would get a fall 1,000 times too small. That matches every other CE reader.
   7. **Fixes:**
      1. Restack on the live code. In `PitCommand.cs` keep the installed Settings-based `CoverOffsetDefault` and `DetentionCoverOffset` lines and add only the `_assumedLevelsOfferedIn` field. In `CrossModuleGuardTests.cs` the command count becomes 148 (installed 147 plus this one).
      2. Put the default fall (1 in 100) into Settings (Survey group), next to the switch, and read it in the prompt.
   8. **Verdict: MERGE-WITH-FIXES. Later plan train, after 9 Nov.**

2. **#983 Settings > AI section (Civil): the AI features tick and the Title block area box.** Head 295fda0c.
   1. **Plan item:** C-35 follow-up, the AI master switch (UX-QA-05 "Claude only, page only"). **Part only:** the window rows. The switch and the blanking already exist in the installed code (`CeAiMasterSwitch`, `CeAiOffPcGate`). Today they can only be set in the settings file.
   2. **9 Nov?** Not needed. AI is off by default, and whether Max gets the tick at all is Tim's call.
   3. **Claim real?** Yes. No AI row exists in the installed Settings window.
   4. **Does only that?** Yes. A new AI tab, a tick (OFF), a sentence saying what is sent and to whom while it is on, and a checked "four fractions or blank" box.
   5. **Problem:** it no longer fits. It clashes in six files. The installed window has since gained a "Newer tools" tab and a "Fixes" tab, so the tab order list and the change-map lines must be rebuilt. The window is Codex's, and nobody has looked at it.
   6. **Verdict: HOLD.** Rebuild on the live window after 9 Nov, then a Codex look in both themes.

3. **#984 Redo guard scan (Structural): recognise every way a command can start.** Head ff5be038.
   1. **Plan item:** BUG-558 redo sweep, guardrail item 17 (decompile finding: any command between U and REDO loses REDO). **Whole** for the Structural scan.
   2. **9 Nov?** No, Structural.
   3. **Claim real?** Yes. The installed Structural scan still lacks the COM `SendCommand`, `Application.Invoke` and the five native `aced...` names.
   4. **Does only that?** Yes, test code only. `Invoke` is flagged only on `Application`, so ordinary delegate calls are not caught.
   5. **Test fails without it?** Yes: ten cases, each would pass unflagged on the old scan.
   6. **Fix:** restack on the installed S line. The installed test file gained a "1b. BUG-457" block at the same place: keep both blocks.
   7. **Verdict: MERGE-WITH-FIXES. Next Structural train after S-43.**

4. **#985 CDASK Analyse markups (Civil): the live screen is never sent, on the Model tab either.** Head 3a8d0901.
   1. **Plan item:** UX-QA-05 ("Claude only, page only", "Don't send; say so"). **Whole** for the live-screen route.
   2. **9 Nov?** Yes. It is a privacy protection on a feature already installed. Nothing changes while AI is OFF.
   3. **Claim real?** Yes. The installed code still takes a screenshot on the Model tab and paints only a fixed strip white, so a title block placed elsewhere in model space would be sent.
   4. **Does only that?** Yes. Every tab now refuses with "Nothing was sent. Use From file... with the PDF sheet." The layout-tab sentence no longer suggests the Model tab.
   5. **Test fails without it?** Yes: the screenshot-count test expects 0 pictures on the Model tab; the old code takes 1.
   6. **LOW (later, not a gate):** the `capture` parameter is now never used. The live-screen menu choice could be hidden rather than always refusing.
   7. **Verdict: MERGE. C-64.**

5. **#986 Structural speed: fewer objects opened (drawing-health count, support follow).** Head 6cdc5534.
   1. **Plan item:** Structural speed (BUILD_QUEUE run 1). **Part only**, and not measured.
   2. **9 Nov?** No, Structural.
   3. **Claim real?** Yes. The drawing-health count opens every model-space object just to read its kind; moving many columns reads the same block definition again for each.
   4. **Does only that?** Yes. The count reads the class name instead. The run 6 proxy fault is fixed (Proxy or Zombie). The support check remembers each definition for one move only.
   5. **Test fails without it?** The classifier tests are new with the new method.
   6. **Fix:** restack. The installed code made `IsSupportBlockReference` `internal` (another file now calls it). Keep it `internal`.
   7. **Verdict: MERGE-WITH-FIXES. Next Structural train after S-43, after a before-and-after timing.**

6. **#991 Civil speed 1: a dynamic block's name read once per command.** Head 82efc0e6.
   1. **Plan item:** Civil speed (Tim's first pick, 10 Oct). **Part only** (the first piece). Not measured.
   2. **9 Nov?** Only if measured. The plan gap audit says the next step is a before-and-after timing with AutoCAD closed.
   3. **Claim real?** Yes. Three readers open the block definition for every pit, on every command end, U, UNDO and REDO.
   4. **Does only that?** Yes. Memory only. Each reader asks the cache first.
   5. **Fault:** the installed per-command cache it copies (`PitLineworkReadCache`) is cleared at command start, end, cancel and fail. #991 clears only at start and end. After a cancelled command, the names read during it are kept until the next command starts, and a palette or background read in between gets them.
   6. **Fixes:** clear the cache in `OnCommandCancelled` and `OnCommandFailed` too, and when a drawing closes (the run 6 LOW). Then time it.
   7. **Verdict: MERGE-WITH-FIXES. Later train, once measured.**

7. **#992 Ribbon contextual tab hide guard (Civil + CE_SHARED, switch OFF).** Head a37b5861.
   1. **Plan item:** UX-RIBBON-01 follow-up (decompile finding: AutoCAD hides CE's Pipe/Pit/Source tab on every selection change). **Part only**, a draft.
   2. **9 Nov?** No. Ruling F holds ribbon work.
   3. **Claim real?** Unproven. It reads an AutoCAD event by reflection. Whether removing CE's tab from AutoCAD's hide list is safe inside AutoCAD is not known (rule 12.5).
   4. **Does only that?** Yes. With the switch OFF nothing hooks. It never throws inside AutoCAD's event.
   5. **Risks:** CE_SHARED changed, so Manager must ship the same CE_SHARED, rebuilt and re-pinned. If AutoCAD raises its event before CE has noticed the drafter picked a non-CE object, the old CE tab could be kept up (the BUG-225 family, "tab stays open"). Only a driver pass can show the order.
   6. **Verdict: HOLD.** After 9 Nov: driver pass with the switch ON, then a joint Civil + Manager train.

8. **#996 Batch 6 card 6.5, UX-RL-05 (Civil): the list "Levels from the new survey" (planner only, switch OFF).** Head d1045df7 (stacked on #972).
   1. **Plan item:** UX-RL-05 (Tim 27 Sep, "Fill in and show changes"). **Part only:** the list rule. No window, no Apply, nothing calls it.
   2. **9 Nov?** No (one plan: after 9 Nov).
   3. **Does only that?** Yes. Assumed and blank levels are ticked; typed, design, survey and not-recorded levels are unticked. A pit the survey does not reach is counted and left alone (Unknown stays Unknown).
   4. **LOW:** a change of 0.5 to 4.9 mm is listed but shows as "(+0.00)". Show the difference to 3 decimals, or list only changes of 5 mm or more. The `·` and `→` in the row text must go through the plain command-line words if ever printed there (run 6 LOW).
   5. **Verdict: MERGE-WITH-FIXES, with #972. Later plan train.**

9. **#1000 Batch 2 card 2.5, UX-SEL-01 (Civil): pick prompts use drafting words.** Head cb3a2342.
   1. **Plan item:** UX-SEL-01, and the rest of BUG-523 finding 1.3. **Whole** for the prompts it lists. BUG-523's "not a pit" sentences were installed in 3.0.70 by #1307 (`PitPickWording`).
   2. **9 Nov?** Yes. Command-line words on daily tools (PITEDIT, CDRUNSOLVE, pit delete, slab, water tank).
   3. **Does only that?** Yes. Wording only, in 11 files. A guard test bans "Selected entity is not", "pit block", "block reference" in every Civil command file.
   4. **Fix:** the clash in `LinkCommands.cs`, `PitEditCommand.cs` and `RunSolveCommand.cs`. Keep the installed `PitPickWording` constants for "That is not a pit..." (one wording; it says "Pick a pit", #1000 says "Select a pit"), and take #1000's prompt lines ("Select a pit to delete:", "Select a pit to edit:"). I checked: after that, the guard test finds no banned words left in the merged code.
   5. **Verdict: MERGE-WITH-FIXES. C-64.**

10. **#1010 Set C item 8 (Civil): a LandXML circular pit reads "diameter" first (switch ON).** Head 1ca9c514.
    1. **Plan item:** Set C Q8. Also the pit half of BUG-512 (HUNT2-C-08, OPEN). **Whole** for Q8.
    2. **9 Nov?** Yes. The one plan lists it as a 9 Nov bug fix, on the recommendation.
    3. **Claim real?** Yes. The installed import reads only "diamWidth", so a pit sized the standard way comes in 600 x 600, and its report says "CE does not read this structure's size from the file yet".
    4. **Does only that?** Yes. "diameter" first, then "diamWidth". Switch `xcivilImport.landXmlCircularDiameterFirst`, ON. OFF gives today's reading.
    5. **Test fails without it?** Yes: the "standard diameter comes in at its real size" test gets 600 on the old code.
    6. **Fix:** one clash in `UserSettings.cs`: both sides add a switch at the end of the import group. Keep both.
    7. **Verdict: MERGE-WITH-FIXES (the clash only). C-64.**

11. **#1019 Set C item 1 (Civil): a pipe label reads FLAT within the "essentially flat" Settings value (switch OFF).** Head 33c8227c.
    1. **Plan item:** Set C Q1. **Whole** for Q1, if Tim takes the 5 mm answer.
    2. **9 Nov?** The one plan says "settle Q1 for 9 Nov on the recommendation unless Tim says otherwise". It is Tim's number.
    3. **Does only that?** Yes. Every label path asks the one shared label rule, so plan labels, the Pit Schedule grade note and the preview stay together. OFF gives today's labels exactly.
    4. **Engineering issue:** see ANSWER FIRST item 5. A fixed 5 mm fall labels a short real grade FLAT, and a reverse fall inside 5 mm also reads FLAT.
    5. **Verdict: HOLD for Tim's answer.** The code is safe to carry while OFF. If Tim picks a grade limit, the rule changes from millimetres to a grade.

12. **#1020 Batch 2 card 2.6, UX-PERF-01 (Civil): CDCHECK shows progress and Esc stops it (switch OFF).** Head 2788ce60.
    1. **Plan item:** UX-PERF-01 (progress with Cancel). **Part only.**
    2. **9 Nov?** The one plan lists "train CDCHECKS (#1034) and its progress line (#1020)" for 9 Nov. But not this PR as it stands.
    3. **Problem:** the installed code has moved on:
       1. CDCHECK's reading step is now one shared call (`ChecksResultReader.GatherSpine`). #1020's steps sit inside the old code and clash.
       2. The installed code already has a progress piece (`SlowWorkProgressTicker`, command-line lines, used by CDCHECKCURRENT), built after #1020. #1020 adds a second one (status bar and Esc). That is two ways to do one job (design rule 1).
       3. CDCHECKS is now installed and is the one plan's single Checks door. The progress line belongs there.
    4. **Verdict: HOLD. Rebuild:** add Esc to the installed ticker, and call it from the shared reader so CDCHECKS, CDCHECK and CDCHECKCURRENT all get it.

## What I did NOT check

1. **No build and no test run.** "Test fails without it" comes from reading the tests against the old code and from the builder logs' RED notes. The finalizer must run the full suites, on both net48 and net10.
2. **Nothing was driven in AutoCAD.** Unproven in AutoCAD: CDASSUMEDLEVELS prompts and its U (#972), the Model-tab refusal (#985), the ribbon event (#992), the status-bar meter and Esc (#1020), and the speed of #986 and #991.
3. **Trial merges only against installed and C-63**, not against batches 1 to 11's PRs or each other (#996 sits on #972, so they go together).
4. **Settings window rows** for the new switches are Codex's and were not looked at. #983's window was not looked at.
5. **The draft one plan** (17 Oct) is a draft Tim has not yet checked (Ruling F). Where I say "9 Nov" or "after 9 Nov" I am quoting it, not a ruling.
6. **Carpark status** was read from each entry's Status line. I did not edit the carpark, DESK_LOG or QUEUE.
7. **#983's privacy sentence** ("to Claude only") was not traced to the provider code.
