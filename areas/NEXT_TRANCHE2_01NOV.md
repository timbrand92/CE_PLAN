# Tranche 2 plan: what is still open and fixable after tranche 1 (read-only plan)

Written Sun 1 Nov 2026 (Melbourne) by a read-only Team planner (Sonnet) for CE 00, handed to CE 05. Nothing was built, run, installed, committed or pushed. The only file written is this one. `BUG_CARPARK.md` and every other file were only read.

## FOR TIM

1. **The honest answer: only 12 bugs are really open, fixable and free of a draft.** They sit in 10 batches (q1 to q10 below). The other open entries are already fixed in the code, already have a draft PR, are installed and waiting for proof, or wait for your word.
2. **Why so few:** I checked the open entries against the code lines and the open PRs. Tranche 1 found 49 of 53 bugs "already fixed" or built; tranche 2 shows the same pattern. About 20 more open entries turned out to be fixed already (for example the long-section set 756 to 763 and 774 to 778 were merged under their audit labels IJK-01 to IJK-26, and the Edit Pit pit-number clash check, BUG-414, is in the code).
3. **What the 10 batches fix, in drawing terms:**
   1. **q1 CEMEMBER in a turned UCS and on a layout sheet** (BUG-909, 910): the section stands square to your UCS; break marks on a layout follow paper scale.
   2. **q2 CEMEMBER unequal angle and RHS laid flat** (BUG-1124, 1125): CE asks which leg stands up, and whether an RHS stands or lies flat.
   3. **q3 Section mark (SM)** (BUG-630): number and sheet first, then points, then a full preview you accept; bubble from your SECT MARK block.
   4. **q4 Pit Schedule Revert Row Override** (BUG-386): reverting a row should drop a typed cover level.
   5. **q5 Project Review "Pipe sizes" agrees with CDRULES** (BUG-1258): one speed rule for a pipe with no material speed.
   6. **q6 Double-click on a downpipe leaves a stray "Unknown command" line** (BUG-1250): robot check first.
   7. **q7 X-Civil import level range read from Settings, switched on** (BUG-908, the X-Civil part only).
   8. **q8 STORM "None" wording** (BUG-1120 part a): says "no water-quality treatment".
   9. **q9 Open AG or perimeter drain closes itself in a metre drawing** (BUG-1054): waits for drafts #1716 and #1727.
   10. **q10 BP bored pier always uses the 450 block** (BUG-536, the BP part only).
4. **Left out and why (details in the EXCLUDED list):** bugs already fixed or with a draft (about 70 checked); the 48 installed fixes that need a proof run, not code; every bug with a question waiting for you (list below); the source conflicts (BUG-95, 431, 538, the 75/100 mm cover x8); anything that needs CE_SHARED.
5. **Three batches need a yes first:** q1 and q2 (CEMEMBER) because the four cards are still marked draft for you, and q9 because it waits for drafts #1716 and #1727 to merge. q3 (section mark) has your card approval ("sm card approved") but one design point (BUG-631) is still unanswered, so BUG-631 is not in it.
6. **Questions still waiting for you (they block the bugs named):**
   1. **Voice batch 7 (QUESTIONS items 104 to 114):** grade lock keeps the typed end, flat pipe switches to Levels, repair old "1 IN 1" labels (BUG-343, 340); Save As warning once or every time (BUG-1158); colleagues' "Recall last settings" (#1928); rainfall wording (BUG-866); FO symbol one job with a card (BUG-1236); concrete pipe 6.0 or 8 m/s (BUG-80).
   2. **Voice batch 8 (item 115):** Kingston, Casey, Bayside council numbers and the Glen Eira 30 per cent (BUG-538, 431, 95), amber band (BUG-1094), the other 30 numbers fixed in code (BUG-908 non-council part).
   3. **Item 116:** minimum fall for pipes 450 mm and bigger (recommend 1 in 200).
   4. **Batches 4 and 5 (items 95 and 99):** still open per the 31 Oct note, including which way round the Frankston driveway cover goes.
   5. **Cards waiting for your yes:** CH hatch (BUG-615), DSET styles (BUG-634), CESETTINGS five groups (BUG-526), installer downloads (BUG-553, 554), the four CEMEMBER cards, and BUG-631 (how the section mark pieces move together; recommend one normal AutoCAD group).
7. **I could not find your answers to voice batches 7 and 8.** The decisions file stops at item 185 (voice batch 6). `SESSION_STATE_CE05.md` still lists batch 7 as waiting. If you have answered, the desk has not recorded it, and I treated them as unanswered.
8. **Nothing from the Codex looks or the C-79b1 robot runs added a new product bug.** Codex batch A runs today 13:00 to 17:00, so its results do not exist yet. The red-before robot runs of 1 Nov failed where they should (no fix on 3.0.88); the other FAILs in the runner ledger are case faults (a missing New Pipe control name, a "string too long" probe), not product faults.
9. **Not tested by anyone:** this is a plan. Nothing here was opened in AutoCAD, and the code checks below were by commit search and reading only.

## HOW THE LIST WAS MADE (so CE 05 can repeat it)

1. **Open entries:** a script took the last line containing the word Status in every entry of `BUG_CARPARK.md` (1216 entries; 955 end in plain OPEN).
2. **Removed in turn:** any bug number in the title or branch of an open PR (1567 open PRs; 804 bug numbers); everything named anywhere in `NEXT_TRANCHE_31OCT.md` (batches, the 22 on the register, C1 to C5); everything named in the n1 to n20 reports. That left 102 numbers.
3. **Then each of the 102 was checked** against `git log` on `origin/claude/rel-20261102a` (Civil, 3.0.88 line) and `origin/claude/rel-20261026s` (Structural, 1.0.125) by BUG number and by its audit label (HUNT-C-01, IJK-01 and so on), and against open PR titles that carry an audit label with no bug number. Most turned out fixed or covered.
4. **Then Tim's decisions were swept:** decisions 1 to 185 in `decisions\2026-10-29_TIM_ANSWERS.md`, for every "yes, build it" whose bug has no PR and no commit. That found BUG-630 and BUG-909, 910, 1124, 1125.
5. **Gaps in this method:** see "What I could not verify" at the end.

## COMMON BLOCK (paste at the top of every job text, then the batch's THE TASK)

Replace `<key>` with the batch key (q1 to q10), `<B-XXX>` stays B-XXX (CE 01 assigns the number), `<LINE>` and `<BASE>` from the batch.

1. **Isolation rule:** this job process is started with CE_LOG_DIR_OVERRIDE, TEMP and TMP set to scratch folders under C:\CE_WORK\scratch\<key>. For Structural batches CE_STRUC_SUITE_APPDATA_ROOT is also set. Before EVERY dotnet test, echo the variables and set them again in a new shell; never run tests against the real %APPDATA%. NEVER run Manager tests. List names, sizes and last-write of the files in %APPDATA%\TIM_CE_CADTOOLS (with CE_Admin\outbox and logs), %APPDATA%\CE_STRUC_SUITE, %APPDATA%\CE_CVL_SUITE and %APPDATA%\CE_CADTOOLS before the first test and after the last; put both listings in the report; if a real file changed that your run could have written, stop and say so first.
2. **Job:** headless Team job "build one CE backlog item as a draft PR". Read C:\TimOS\RULES.md first, then C:\CE_PLAN\areas\CE_SESSIONS_MAP_29OCT.md, then Tim's rulings in C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md for the decisions named in THE TASK. Tim is a civil engineer, not a coder: the report opens with a FOR TIM block (plain English, AutoCAD terms, numbered, no tables), then the technical detail. Australian spelling, metric.
3. **Rulings:** nothing closed or deleted (D6). Never close, retarget or merge a PR, delete a branch or force-push; ONE normal commit per PR. Never mark a bug fixed. Every behaviour change gets a Settings switch that ships ON by default, documented "Default: on.", pinned in the new-switch-defaults test through BOTH start-up reads (SettingsService.DeserializeSettings and DeserializeSettingsTolerant); with the switch OFF the old behaviour returns exactly. Every engineering value comes from Settings or pipe data. Warn and carry on, never block (R-27). REDO-safe (BUG-861 rule): no new write, command, regen, view or system-variable change beyond what the fix itself needs. Never touch locked layers, Xref or REFEDIT content; never unlock a layer. CE_SHARED must not change: stop and report if a change needs it. Do not start AutoCAD, Codex or accoreconsole. Do not touch Tim's settings files, installed bundles or ProgramData.
4. **PR rules:** each PR title starts with the batch's B number (write B-XXX; CE 01 assigns it). Open a DRAFT PR against `<BASE>`: Civil and Manager `claude/rel-20261102a`; Structural `claude/rel-20261026s`. Before editing a shared file run `gh pr list --state open --search "<file name>"` and read any open draft that touches it; if THE TASK names a draft to stack on, build on that PR branch, base your PR on it and say so in the PR body and report. REGRESSION_LOG.md and the settings file (Civil Modules/Drainage/Models/UserSettings.cs; Structural its own settings file) are touched by every PR: on a merge conflict keep both sides.
5. **Build and test:** ALWAYS `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2` on every dotnet build and test, with the AutoCAD refs from release-v3-colleagues-TRAIN_C62_ASSEMBLY_REPORT_2026-10-23.md. Focused tests only: ONE test project per dotnet test command, with a --filter; print the command and REFUSE to run it if it names the .sln or has no --filter; never the full suite; never Manager tests. Check the test COUNT is not 0 (AutoCAD 2027 on the PATH). At most two top-level dotnet build or test commands run on this PC at once: count them with your own small .ps1 (Get-CimInstance Win32_Process, Name dotnet.exe, command line starting build, test, msbuild, publish or restore) and run only when the count is 0 or 1; otherwise loop `Start-Sleep 60` inside ONE blocking command, up to 3 hours. Below-normal priority. net48 compile check at the end.
6. **Disk and folders:** keep C: at least 27 GB free before a build (wait in a sleep loop below that; never delete to make room). Worktree under C:\CE_WORK\build\<key>, scratch under C:\CE_WORK\scratch\<key>; when your last PR is pushed run `git clean -fdXq` inside your worktree, `git worktree remove`, and remove the scratch folder; say in the report how much C: free space moved. If the worktree or branch exists, reuse it. If the 0-byte CE_TRANSFORM_2027.arx placeholder is missing, create an empty one where the build names it.
7. **First confirm the fault:** for EACH bug reproduce or confirm on `<BASE>` with file and line before building. If it is already fixed say ALREADY FIXED with the commit, file and line and open no PR. If it needs Tim's word, a window change (windows are Codex-owned: write a brief), a design card, the native component or AutoCAD to see, skip it with the evidence or the exact one-line question.
8. **Report:** C:\CE_PLAN\areas\BUGFIX_<key>_REPORT_<DDMON>.md with a FOR TIM block first (what a drafter will see differently, mistakes of your own first, what is NOT proven) and the name of the robot case that proves it with a switch-off control, in the style N31_dp_time (say exactly what it types and which line or value it checks). Push the report by name: `git fetch`, `git merge --no-edit origin/main`, `git push` (never pull --rebase, never `git add -A`, never --no-verify; if the leak-scan hook blocks on a URL slug, reword and push again; `git status -sb` must show no ahead). Never edit BUG_CARPARK.md or DESK_LOG.md. Commit messages name the BUG number in full and end with the line Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>; PR bodies end with: Generated with Claude Code (https://claude.com/claude-code). No bare python and no long inline pwsh -Command (write a .ps1).
9. **Keep-alive:** a headless turn ENDS the moment you reply with plain text and no tool call. Never write "I will carry on once the wait finishes". While waiting for a slot, run one blocking loop. Your turn may end only after the PR is open (or the report says exactly why no PR can be opened) and the report is pushed. End with a summary under 100 words naming the PR numbers, the files and the switch.

## A. THE BATCHES

Each batch: **key and line**; **bugs**; **effect in AutoCAD terms**; **files expected**; **risk**; **clashes** (UserSettings.cs and REGRESSION_LOG.md are touched by every batch, keep-both merge; the lines below name the OTHER shared files); **robot hint for CE 02**; then **THE TASK**, the paragraph to paste after the common block. Order is the run order, chosen so no two batches that share a code file run together.

1. **q1: CEMEMBER follows the UCS and the paper scale** (Structural, base origin/claude/rel-20261026s)
   1. **Bugs:** BUG-909, BUG-910. Tim's decision 185 ("yes to all four"; 909 section follows the UCS; 910 break marks follow paper scale on layouts).
   2. **Effect:** rotate the UCS 30 degrees and a 310UB section comes out square to the UCS, not tilted on screen, with its lines at the picked height (today every line drops to height 0). On a layout sheet at DIMSCALE 50 the break kink is 2 mm on the sheet instead of 100 mm.
   3. **Files:** CEMEMBER command and line writer (Modules/Structural: CeMemberLineWriter.cs and the CEMEMBER command file; the builder finds the point-picking code). Cards: C:\CE_PLAN\areas\cards\CARD_CEMEMBER_UCS_BUG909_DRAFT_31OCT.md and CARD_CEMEMBER_LAYOUT_BREAKS_BUG910_DRAFT_31OCT.md.
   4. **Risk:** drawn output in every orientation; Z of picks; BL break uses the model scale today. Two PRs (one per bug) unless the same lines change.
   5. **Clashes:** same CEMEMBER files as q2, so q1 first. Open CEMEMBER drafts (titles "CEMEMBER slice ..." and "CEMEMBER (g)") touch the same files: read them and stack.
   6. **Gate:** start only after CE 04 confirms the cards are approved (they are still marked DRAFT FOR TIM).
   7. **Robot hint:** UCS Z 30, CEMEMBER 310UB32 on typed points, read the line endpoints and Z with ent-read; expect the run rotated 30 degrees and Z at the picked height; world UCS twin must stay identical; layout case at DIMSCALE 50 reads the kink size of the BL polyline.
   8. **THE TASK:** BATCH q1 of tranche 2. Read the two cards and decision 185. For BUG-909 make every picked point and every line follow the current UCS (convert once, never twice: BUG-467 was exactly a double conversion). For BUG-910 make the break mark use the paper scale when drawing on a layout viewport sheet. Switches `CeMember.SectionFollowsUcs` and `CeMember.BreakMarksFollowPaperScale`, ON. Never touch Xref or locked layers.

2. **q2: CEMEMBER unequal angle leg and RHS flat** (Structural, base origin/claude/rel-20261026s)
   1. **Bugs:** BUG-1124, BUG-1125 (decision 185).
   2. **Effect:** for an unequal angle CE asks "Upright leg [Long/Short] <Long>" (a shelf angle needs the short leg up). For an RHS CE asks "RHS sits [Standing/Flat] <Standing>".
   3. **Files:** CEMEMBER prompt and orientation code (same family as q1); cards CARD_CEMEMBER_UA_LEG_BUG1124_DRAFT_31OCT.md and CARD_CEMEMBER_RHS_FLAT_BUG1125_DRAFT_31OCT.md.
   4. **Risk:** BUG-1125 overrides Tim's earlier "one orientation" rule; the card marks that as a GUESS. Build 1124 first. Build 1125 only if CE 04 has confirmed the guess; otherwise skip 1125 and say so.
   5. **Clashes:** after q1 (same files). Enter-repeat ("previous choices") must remember the new answers.
   6. **Gate:** card approval as q1, plus the 1125 confirmation.
   7. **Robot hint:** CEMEMBER 150x90x10 UA, answer Short, read that the 90 leg is vertical; 150x50 RHS Flat, read the section is 50 high; defaults give today's drawing exactly.
   8. **THE TASK:** BATCH q2 of tranche 2. Read the two cards and decision 185. Add the two questions with the defaults Long and Standing so Enter gives today's result. Switch `CeMember.AskLegAndRhsOrientation`, ON (OFF never asks). Stack on q1's branch if q1 is still open.

3. **q3: Section mark order and bubble block** (Structural, base origin/claude/rel-20261026s)
   1. **Bugs:** BUG-630 (build); BUG-632 only if its own entry is open and no PR covers it (the builder reads it and says). BUG-631 is NOT in this batch (its link design is unanswered; see EXCLUDED).
   2. **Effect:** type SM and CE asks number and sheet first, then the two points and view direction, then shows the whole mark (line and both bubbles) and waits for Enter to accept before drawing. The bubble comes from the SECT MARK block in Tim's standard blocks file, not lines CE draws itself.
   3. **Files:** Commands/SectionMarkCommands.cs, Services/SectionMarkRegistry.cs. Card: C:\CE_PLAN\areas\cards\CARD_SM_SECTION_MARK_DRAFT_31OCT.md (approved by Tim, "sm card approved", decision 171; decisions 164 and 170).
   4. **Risk:** new preview (a jig); REDO and Cancel and Escape at each step; opening the standard blocks file only as a copy. s10 skipped this on 31 Oct because the card was not approved; it is approved now.
   5. **Clashes:** none with q1, q2 or q10 by file; Structural settings file as everywhere. Wave 1.
   6. **Robot hint:** SM, answer A and S02, two typed points, direction Left, read the preview line, press Enter, count one line and two bubble blocks named SECT MARK; Escape at the preview leaves zero objects; one U removes all.
   7. **THE TASK:** BATCH q3 of tranche 2. Read the SM card in full and decisions 164, 170, 171. Build the new question order and the preview-then-Enter step for BUG-630, bubble from the SECT MARK block. Switch `SectionMark.PreviewThenPlace`, ON (OFF returns today's order and drawn bubble exactly). Do not touch BUG-631.

4. **q4: Pit Schedule Revert Row Override keeps the typed cover** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-386 (Codex W4-02 on 4 Oct and W3-04 on 3 Oct: C1 cover typed 18.80, Revert Row Override leaves row and plan label at 18.80).
   2. **Effect:** Revert Row Override puts the cover back to CE's own figure (18.74 in the entry) on the row and the plan label.
   3. **Files:** ViewModels/PitScheduleViewModel.cs (RevertOverrideCommand, line 306) and the Pit Schedule data code. Read the entry's own expected result first.
   4. **Risk:** unverified on 3.0.88 (not re-checked since 4 Oct), so the first job is to reproduce in a unit test; REDO (one U must restore both); Pit Schedule drafts #1660, #1286, #1765, #1767, #1816 and #1937 touch the same files.
   5. **Clashes:** stack on whichever of those merges first; no other batch here touches Pit Schedule. Wave 1.
   6. **Robot hint:** type cover 18.80 on C1 in the Pit Schedule, press Revert Row Override, read the plan cover text and the row; expect CE's figure; one U returns 18.80.
   7. **THE TASK:** BATCH q4 of tranche 2. Read BUG-386 in full. Reproduce on the base line first; if it already reverts, report ALREADY FIXED. If not, make revert restore the computed cover on row and plan, switch `pitSchedule.revertOverrideRestoresCover`, ON.

5. **q5: Project Review "Pipe sizes" agrees with CDRULES** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-1258 (found by CE 00's pre-review M of #1857).
   2. **Effect:** a pipe whose material has no speed limit is judged against the office "Maximum pipe velocity" in BOTH CDRULES and Project Review > Proposals > Pipe sizes (today Project Review says Unknown).
   3. **Files:** Dialogs/ProjectReviewProposalsDialog.xaml.cs and its proposal service (the builder finds the speed-limit lookup); the CDRULES path from #1857.
   4. **Risk:** one code path (design rule 1): reuse the #1857 lookup, do not copy it. Value from Settings only.
   5. **Clashes:** stack on #1857 (B-011 extras, still an open draft). No other batch touches Project Review.
   6. **Robot hint:** pipe with a material that has no speed limit, run CDRULES and open Project Review > Pipe sizes; read that both name the same limit; switch OFF restores Unknown.
   7. **THE TASK:** BATCH q5 of tranche 2. Read BUG-1258 and #1857. Build on the #1857 branch. Switch `checks.projectReviewUsesOfficeVelocityForUnsetMaterial`, ON.

6. **q6: Stray "Unknown command" line after a downpipe double-click** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-1250 (CE 02 robot run 29 Oct).
   2. **Effect:** double-click a downpipe and the command line shows no extra "Unknown command" line with the click coordinates.
   3. **Files:** Services/CompoundEditModeService.cs (OnDocumentLockModeChanged line 928, Veto line 991 per the n9 report). Ranked suspects are in C:\CE_PLAN\areas\BUGFIX_n9_REPORT_31OCT.md item 6.
   4. **Risk:** the cause is unproven; the hook runs on every block (keep it fast, BUG-865); REDO.
   5. **Clashes:** stack on #1834 (B-001, BUG-859), #1862 (B-014) and #1923 (B-110); all touch the double-click code. Do not start before CE 02's robot check below has been run.
   6. **Gate:** CE 02 runs R09s with `doubleClick.sourceStopsAttributeEditorFirst` OFF and ON, on a DP and on a plain block, and reads the command-line history for "Unknown command" first. If it appears only with the switch ON, build; if it appears with it OFF too, it is AutoCAD's and the batch closes as no change.
   7. **Robot hint:** same R09s case; read the history for the words Unknown command; the broken twin must show it.
   8. **THE TASK:** BATCH q6 of tranche 2. Read the n9 report item 6 and the robot result CE 05 attaches. Confirm the cause with file and line before any change; if unprovable, build only a log line behind a switch default OFF (and say so). Otherwise swallow the pick text the vetoed EATTEDIT leaves behind. Switch `doubleClick.swallowsLeftoverPickText`, ON.

7. **q7: X-Civil import level range follows Settings, switched on** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-908, the X-Civil range part only (the 0 to 250 m level range). The pump constants and sizing limits in the same entry need Tim's values and are not in this batch.
   2. **Effect:** an X-Civil import accepts levels in the range set on the Settings page (0 to 250 m by default, so nothing changes at the default); a job whose levels sit outside it can be set once, not rebuilt.
   3. **Files:** Services/XcivilLayerRecognition.cs lines 89 to 100; Models/UserSettings.cs lines 3652 to 3658 (switch `xcivilImport.levelRangeFollowsSettings`, today OFF, "needs Opus review").
   4. **Risk:** an existing switch ships OFF against Tim's rule that a fix ships ON; flipping the default is a Settings-engine change, so it needs an Opus review and the N91 start-up smoke (decision 161). Default values must not change.
   5. **Clashes:** UserSettings.cs only. Wave 1.
   6. **Robot hint:** import a made-up consultant file with a level of 300 m; with the range at 0 to 250 it is flagged; with the range raised it is accepted; OFF twin keeps the fixed range.
   7. **THE TASK:** BATCH q7 of tranche 2. Read BUG-908 and n17 report item 4. Flip the shipped default of the existing switch to ON after confirming with a test that default values are unchanged; add the defaults test through both reads; name the Opus review need in the PR body. No new value.

8. **q8: STORM "None" wording** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-1120 part (a) only.
   2. **Effect:** the STORM note that says "None" says "no water-quality treatment".
   3. **Files:** the reuse and STORM note text (ReuseCreditService.cs lines 61 to 63 are the nearest known; the builder finds the "None" note). Parts (b) Bayside formula and (c) the 0.82 charged-downpipe citation need Tim and are not in this batch.
   4. **Risk:** wording only, but the golden computations-sheet text files carry some sentences (n16 had to update two): check them.
   5. **Clashes:** the CDDESIGN files of #1874 and #1956; small. Wave 1.
   6. **Robot hint:** run CDDESIGN on a job with STORM "None"; read the sentence on the computations sheet.
   7. **THE TASK:** BATCH q8 of tranche 2. Read BUG-1120 and the n18 report item 6. Change only the wording for (a), behind switch `detention.stormNoneNoteWording`, ON.

9. **q9: Open AG or perimeter drain closes itself in a metre drawing** (Civil, base origin/claude/rel-20261102a)
   1. **Bugs:** BUG-1054.
   2. **Effect:** an open AG or perimeter drain keeps its last point in a drawing set to metres.
   3. **Files:** AgiCommand.Apply.cs, AgiCommand.Plan.cs, AgiCommand.cs.
   4. **Risk:** unit conversion (a missed one is 1000 times wrong); needs a metre fixture (runner case T1).
   5. **Gate:** do not start until drafts #1716 and #1727 (on HOLD for C-64) have merged or CE 01 says they will not; they change the same AgiCommand files. Stack on them.
   6. **Robot hint:** metre drawing, draw an open AG drain of four points, read the polyline's vertex count and closed flag.
   7. **THE TASK:** BATCH q9 of tranche 2. Read BUG-1054 and the two drafts. Convert the point handling through the one drawing-units helper n12 added. Switch `agi.openDrainKeepsLastPointInMetreDrawing`, ON.

10. **q10: BP bored pier uses the Settings diameter's block** (Structural, base origin/claude/rel-20261026s)
    1. **Bugs:** BUG-536, the BP part only (the entry's other parts are Tim's talk-later items 168, or built in #1910 and #1911).
    2. **Effect:** BP draws the block that matches the Settings default diameter instead of always the 450 block.
    3. **Files:** the BP command and the footing block choice in Modules/Structural (builder finds). Read C:\CE_PLAN\areas\STRUCTURAL_ALREADY_FIXED_CHECK_31OCT.md item on BUG-536 ("BP reads the Settings default diameter. It still always uses the 450 block").
    4. **Risk:** only a 450 block may exist; if no other block exists, build a warning and stop there (R-27), do not invent a block.
    5. **Clashes:** after #1911 (BUG-536 part, open). Last in the order.
    6. **Robot hint:** set the default diameter to 600, type BP, read the block name inserted.
    7. **THE TASK:** BATCH q10 of tranche 2. Reproduce first (the check file is a code read only). If only the 450 block exists, report that and build the warning. Switch `Footing.BoredPierBlockFollowsDiameter`, ON.

## B. ORDER AND WHICH BATCHES CAN RUN SIDE BY SIDE

1. **Two build lanes only,** so run in pairs. Suggested pairs, each pair sharing no code file: (q3, q4), (q7, q8), (q1, q5), (q2, q10), then q6 after CE 02's robot check, and q9 after #1716 and #1727.
2. **Never together:** q1 and q2 (CEMEMBER files); q4 and any open Pit Schedule draft; q5 and #1857; q6 and #1834, #1862, #1923; q9 and #1716, #1727; q10 and #1911.
3. **Touch UserSettings.cs (Civil):** q4, q5, q6, q7, q8, q9 (each adds a switch; q7 flips an existing one). Keep-both merge.
4. **Touch the Structural settings file:** q1, q2, q3, q10.
5. **Touch REGRESSION_LOG.md:** all ten.
6. **Settings engine or start-up change (needs the N91 start-up smoke plus Opus review):** q7 only. REDO-sensitive: q1, q2 (point conversion), q3 (preview), q4, q6.
7. **Structural line:** q1, q2, q3, q10. **Civil line:** q4, q5, q6, q7, q8, q9. No Manager batch: the only Manager candidates (BUG-1261, 489) are already done or in draft #1878.

## C. EXCLUDED (with reasons)

1. **Already fixed in the code (found by commit search or a code read; not accepted in AutoCAD):**
   1. **Long section set:** BUG-756, 757, 759, 761, 762, 763 (IJK-01, 02, 04, 06, 07, 08), BUG-774 (IJK-23), 776 (IJK-26), 778 (IJK-X2), 760: merged on the Civil line under audit labels.
   2. **Hunt items:** BUG-651 (Esc at Proceed with import, commit 2c35de86), 458 (REFEDIT start check), 461, 462 (HUNT-C-05), 463 (HUNT-C-06), 477 (Roll Back hidden), 479, 482, 488 (privacy, train C-1), 507, 508 (shipped with its switch OFF), 414 (Edit Pit clash check present), 300, 470, 473, 474, 529, 611 (Structural, per CE 05 notes of 30 and 31 Oct), 489 (zip scrub gaps closed by HUNT-M tests), 862 and 867 (commits exist).
   3. **From tranche 1 reports:** 286, 288, 298, 291, 297, 340 items 1 to 6 and 9, 343 item 1, 293, 638, 354, 402, 1260, 540 (apart from a Settings box), 1197.
2. **Covered by an open draft PR (do not build twice):** BUG-864 (PR "Fix audit MEDIUM 3: never change an existing 18HIDDEN / 9HIDDEN2 layer"), 1042 (#1720, Audit RD03), 467 (#1921), 859 (#1834), 430 (#1923), 860 (#1862), 788, 505 (#1926), 642 (#1924), 626 and 627 (FFL), 613, 578, 1132, 818, 1267, 1224, 1262, 1257, 80 (#1960 per QUESTIONS item 114), and every bug in a draft from n1 to n20.
3. **Installed, waiting for a proof run, not code (48 of the 102):** for example 797, 741, 732, 714, 713, 696, 695, 689, 680, 678, 671, 666, 655, 654, 653, 574, 441, 445, 448, 364, 349, 347, 341, 337, 335, 325, 324, 313, 312, 292, 290, 282, 277, 274, 248, 180, 175, 174, 166, 165, 158, 076, 012, 014, 015, 050, 549, 767. They go to the proof lanes (BUG_PROOF_LANES_31OCT.md), not to a builder.
4. **Old "IN PROGRESS, coded in May to September, awaiting Tim's test":** BUG-020 to 094 (about 45 entries). Stale status lines, not open work; the carpark tidy should retest or reset them.
5. **Waiting for Tim (open question; see FOR TIM item 6):** BUG-343 items 2, 3, 5, 7; BUG-340 item 7; BUG-631; BUG-634; BUG-615; BUG-526; BUG-533 (talk later, decision 168); BUG-538 remainder; BUG-1060; BUG-1120 (b) and (c); BUG-1094 amber; BUG-908 non-council values; BUG-1100; BUG-1158 warning style; BUG-1236; BUG-1239; BUG-1242 (Tim ruled number in tag only); BUG-1243; BUG-1148 (known limit for the pilot, decision 48); BUG-1252; BUG-1249; BUG-490 (Windows login inside the drawing: AUDIT 01 A5, no ruling found; decision 184 only keeps the time-log names); BUG-553 and 554 (card first); BUG-883 and 888 (after the pilot, decision 182).
6. **Source conflicts:** BUG-95, 431, 538 (Kingston, Casey, Bayside), the 75/100 mm cover x8 (B-114, held for Tim's answer).
7. **Needs CE_SHARED or the native component:** BUG-528, 1205, 1245 (native TransformCommands.cpp in Shared.Transform.Native2027), 1163.
8. **Windows are Codex-owned (briefs, not Team builds):** BUG-540 Settings box, 526, 213, 222, 581, 958, 959, 1033, 1208, 1210, 1217, 1248, 1254, 1100 window, the CDDESIGN reuse-litres box (BUG-1108).
9. **Needs AutoCAD or real data first:** BUG-855, 865, 163, 235, 310, the C4 "too thin" list (decision 179: robot and Codex look first), BUG-61, 63, 66, 68, 804, 900 (real consultant package), BUG-1209, 1210, 1212, 1213, 304 (parked after the pilot, decision 181).
10. **Closed or closing (decision 178):** the 29 C5 entries.
11. **Not product faults:** the runner FAILs on 31 Oct and 1 Nov that are case faults (N33 control id C2.IsAutoCalcUpToDown missing on the New Pipe window, probe "String too long", GM1 "Grade mismatch" text after decision 118 replaced the window, W658 passes before its fix).

## D. WHAT I COULD NOT VERIFY (RULES 5.9)

1. **No code was run or built, and no AutoCAD was opened.** "Already fixed" means a commit message or a file line says so; none of it is accepted.
2. **The carpark script took the last line containing the word Status.** An entry whose real last status sits on a line without that word, or whose Status line is older than a later "Note" line, can be misread. Entries with no Status line at all (53 per tranche 1) were read from their own text or notes.
3. **Open PR cover means a bug number in a title or branch, or an audit label I recognised.** A bug named only in a PR body was not treated as covered. I found 864 and 1042 covered only by checking titles by hand; other bugs may be covered the same way, so each THE TASK says to run `gh pr list --state open --search` first.
4. **Commit search used the commit message only** (BUG number and audit labels). A fix with a message that names neither would be missed, in either direction.
5. **Voice batches 7 and 8:** I found the questions (QUESTIONS items 104 to 115) but no recorded answers; see FOR TIM item 7.
6. **Codex looks and C-79b1:** Codex batch A has not run; C-79b1 results are red-before runs on 3.0.88, so nothing there found a new product bug. The runner ledger has 2034 report files; I read the FAIL lines of the 31 Oct and 1 Nov runs, not every file.
7. **BUG-386, 1258 and 1120(a) were read from their carpark entries only;** I did not read their code. BUG-632's status was not read. The file names in each batch are the entries' own or the n-reports', and the builder must confirm them.
8. **The tranche 1 reports were read at the top (the FOR TIM blocks);** the technical parts of n1 to n20 were read only where named above.
9. **Disk:** 60 GB free on C: when I looked (above the 27 GB floor).
10. **B numbers** are left as B-XXX for CE 01.
