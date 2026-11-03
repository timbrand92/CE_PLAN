# Opus pre-review FILL LATE: PRs #1278, #1297, #1495, #1517 and #1180

Written Monday 2 November 2026, 15:02 Melbourne, by an independent read-only Opus reviewer for CE 05 (queue filler 6, job 609).
Heads reviewed: #1278 6e935c2c, #1297 8d11531c, #1495 c7333338, #1517 440b13fa, #1180 1fb9525e. All five are DRAFT on GitHub.
Release tips checked with `git ls-remote` and a read-only `git fetch`: newest Civil line claude/rel-20261112a at ccaf0783 (C-79c finaliser), and newest Structural line claude/rel-20261026s at 204dfad2 (Structural 1.0.125, S-45).
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the diffs, the PR descriptions, the carpark entries, Tim's decisions, QUESTIONS_FOR_MONDAY.md and the review lane log. I ran `git merge-base --is-ancestor`, `git merge-tree` and `git grep` only.

## FOR TIM

1. **The brief was wrong about four of the five: they are already in your installed CE.** #1278 is in Structural (since at least 1.0.118). #1297, #1495 and #1517 are in Civil (3.0.70 or earlier). Each also had an Opus review before it went in. Their GitHub pages were just never closed. Only #1180 is genuinely new.
2. **#1278, hatches and the BL break line at 1:50 (BUG-614, BUG-628): KEEP-WITH-NOTE, already shipped, no train.** Example: at DIMSCALE 50 and LTSCALE 500, CH draws Concrete at 2.5 and BL draws a 2 mm zigzag on paper. Your question on the 1:50 hatch density is still unanswered (QUESTIONS_FOR_MONDAY section B item 4). One side effect: CEHATCHAUDIT Repair will now re-scale an old Earth hatch at 8 in a 1:50 drawing to 20.
3. **#1297, ribbon buttons read "Inspector (CDINSPECTOR)" (BUG-518): KEEP-WITH-NOTE, already shipped, no train.** It matches your 9 Oct ruling. Note: there is no tick box in CDS to turn the brackets off. The only way is editing the settings file, so Codex should add a row.
4. **#1495, 17 new tick boxes in CDS (drafting fixes, survey, detention, heartbeat): KEEP, already shipped, no train.** I checked the newest Civil line: all 17 boxes are in both Settings windows (CDS and CEMANAGER). No default changed.
5. **#1517, typed CDCHECKIGNORE to hide one Checks finding: KEEP as shipped, already shipped, no train.** The PR itself had faults: it said "Ignored" when nothing was saved, and Undo was not one clean step. All of these were fixed after it went in, and the installed version is the fixed one. The PR page is out of date and should simply be closed.
6. **#1180, surveyed services checked against drawn pipes on plan: KEEP-WITH-NOTE, Civil area + smoke.** It is the rule only, nothing calls it, and the switch is OFF, so no drawing changes. The "conflict" is only the change log (REGRESSION_LOG.md): keep both entries. One engineering point for your clearance question (question 11): when a service runs UNDER the pipe, it measures from the bottom of the service, not its top. That reads high by the service's size.
7. **Nothing here has been seen by you or Codex in AutoCAD.** BUG-614, BUG-628 and BUG-518 stay OPEN. No test I read touches your real settings. I did not run any test myself.
8. **For CE 05:** close (or mark "shipped") #1278, #1297, #1495 and #1517 so they stop showing up as "open draft, no review". Only #1180 needs a train slot.

---

## DETAIL

### Group facts

1. **Already shipped (checked with `git merge-base --is-ancestor`):**
   1. **#1278** head 6e935c2c is an ancestor of the Structural tip claude/rel-20261026s (1.0.125). `PR_PILE_TRIAGE_2026-10-24.md` line 637 already said so (class A, in installed 1.0.122). The Codex look on 18 Oct saw 1:50 hatches placing on Structural 1.0.118 (carpark BUG-614).
   2. **#1297** head 8d11531c is an ancestor of claude/rel-20261102a and claude/rel-20261112a. The carpark says "fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1297" (BUG-518 status line).
   3. **#1495** head c7333338 merged in train C-56 (merge 8d0eb8f2, `release-v3-colleagues-TRAIN_C56_ASSEMBLY_REPORT_2026-10-20.md` item 4).
   4. **#1517** head 440b13fa merged in train C-60 (merge 037b9311) after its fix round (`release-v3-colleagues-FIX_1517_REPORT.md`).
   5. **#1180** head 1fb9525e is on no release branch.
2. **Earlier Opus reviews exist** (so "no Opus pre-review" in the brief is not right): #1278 entries 1024 and 1065 (FINAL MERGE) and #1297 entry 1044 (MERGE) in `release-v3-colleagues-REVIEWLANE_LOG.md`. For #1495 see `desk_jobs/review_1491_1495_job.log` ("#1494 and #1495 ... go"), and for #1517 the C-60 reports (MERGE-WITH-FIXES, then the fix round). #1180 was never reviewed (`PR_PILE_TRIAGE` line 1228, class F).
3. **Same function touched by two PRs in this group: none.** #1278 is Structural only. Two places come close in Civil, with no clash:
   1. **#1297 and #1517:** #1517's registry label "Ignore a Finding (CDCHECKIGNORE)" already holds its command, and `CeRibbonLabel.WithCommand` leaves it alone (`Shared/CE_SHARED/Services/CeRibbonLabel.cs`, the `IndexOf("(" + typed + ")")` line). It is also hidden.
   2. **#1495 and #1180:** both are Settings work, but #1180 adds no window row.
4. **Train class for the four shipped PRs: none.** Nothing is left to merge. Any follow-up below is a new carpark item, not a change to these PRs.

### #1278 — BUG-614 and BUG-628: hatches and BL follow any drawing scale (Structural, not Civil as the brief says)

1. **What changes for the drafter.**
   1. **Hatches:** CEHATCH and the preset commands (EH, CH, LBH, LBUH and the rest) now accept any office pair: DIMSCALE n with LTSCALE 10 x n. A preset that differs between 1:20 and 1:100 follows a straight line between the two values (`Modules/Structural/Core/Units/DrawingScaleRule.cs`, `HatchPatternScale`). Earth (8 and 40) gives 20 at 1:50, and Concrete (1 and 5) gives 2.5. At 1:20 and 1:100 the answers are exactly as before (`DrawingScaleRuleTests.Hatch_AtOneToTwenty_AndOneToHundred_IsUnchanged_WhateverTheSwitch`).
   2. **Break line:** BL is 1.5, 2 and 2 mm on paper at every scale (`BreaklineSizes`). That gives 75/100/100 at 1:50, and the same as before at 1:20 and 1:100.
   3. **Audit:** CEHATCHAUDIT and CEHATCHCHANGE use the same rule (`HatchCommands.PlacementScale`, `HatchUpgradeCommands.AuditScale`).
   4. **Against the asks:** this matches the carpark (BUG-614 item 3: "normal plotted scales including 1:50") and Tim's ruling 12 of 20 Oct ("all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale"). It does NOT fully match the desk's reading of ruling 12 ("same dots per square cm of paper at every scale"). For Earth and Concrete the straight line and "same on paper" agree, because both are proportional. For a preset whose two values are not proportional, they differ. BUG-748 (DOTS) is the live case.
   5. **The density number is still Tim's open question** (QUESTIONS_FOR_MONDAY.md line 17, not marked ANSWERED).
2. **The switch.**
   1. **What it is:** `Layouts.FollowAnyDrawingScale`, default ON (`Modules/Structural/Models/UserSettings.cs`, new property after `LabelPlotHeightMm`). The PR calls ON "Tim's recommended answer"; ruling 12 of 20 Oct later backs ON in substance.
   2. **OFF:** OFF gives back the old two-pair hatch rule and the old BL sizes (`Hatch_WithTheSwitchOff_RefusesOneToFifty_ExactlyAsToday`, `BreakLine_WithTheSwitchOff_KeepsTodaysSizesAtOneToFifty`, `WithTheSwitchOff_TheAuditKeepsTheEarlierAnswer`).
   3. **Defaults test gap:** the test only pins `new LayoutSettings()` (`TheSwitch_IsOnByDefault_AndHasAPlainName`). It does not pin a settings file that lacks the key, read through SettingsService. By reading, a missing key keeps the property initialiser (true), but no test proves it.
   4. **R-00:** the 1.5/2/2 mm paper sizes and the factor 10 are constants in `DrawingScaleRule.cs`, not Settings values. They come from the existing 1:20 sizes, so this is acceptable, but they are engineering-looking numbers.
3. **R-27 (no hard blocks):** a mixed pair (DIMSCALE 50, LTSCALE 1000) is still refused with "Invalid DIMSCALE/LTSCALE combination" (`HatchCommands.ResolveScale`). That hard stop is already carparked as **BUG-953** (MEDIUM). #1278 did not create it, but kept it, and its message is now clearer.
4. **Native protection and REDO:** #1278 does not touch layer locking, the Xref handling or the Undo wrapping. It changes numbers only. Two side effects matter:
   1. **Repair now changes more hatches:** with the switch ON, CEHATCHAUDIT Repair at 1:50 expects 20 for Earth where it used to expect 8. An existing 1:50 drawing with Earth hatches at 8 (drawn by hand or by older tools) will now report them as wrong, and Repair will re-scale them to 20. That matches the new rule but uses the unapproved density.
   2. **The audit is safe on Xrefs:** it scans only the current space (`HatchUpgradeCommands.cs`, `db.CurrentSpaceId` loop on the S-45 tip), so it never reaches into an Xref. A hatch on a locked layer goes through the existing rollback path; I did not trace that path end to end.
   3. **No protected file** (LinkService, ProjectDataService, RulebookEngine) is touched.
5. **Merge:** already in the Structural line. Nothing to merge. (Entry 1068 had the BreaklineCommands.cs hand-resolve with #1285. On the S-45 tip the BL code holds #1278's `anyScale` block, so it was done.)
6. **Tests:**
   1. **What the author reports:** `DrawingScaleRuleTests` RED 4 of 15, then 15 of 15. `HatchAuditScaleTests` RED 4 of 56, then 56 of 56. I did not re-run them.
   2. **One pinned test changed:** `HatchUpgradeContractTests` line 716 changed its invalid example from 50/500 to 50/1000. That is honest: 50/500 is now valid.
   3. **No real %APPDATA%:** the tests are pure; the one source-reading test reads only repository files.
7. **NOT proven, and the robot scenario:**
   1. **No one has looked at it:** nobody has seen the 1:50 hatch on a plot, or the CEHATCH library window route at 1:50 (the Codex look on 18 Oct drove only typed CH and LBUH).
   2. **DIMSCALE 1 changes BL size:** with DIMSCALE 1 and CANNOSCALE 1:1, BL now draws a 2-unit zigzag where it drew 40, because of the annotation-scale fallback in `ScheduleService.ResolveDrawingScale` and #1285's paper-space override. That is right on a sheet, but tiny in a model space left at DIMSCALE 1. The robot should check this.
   3. **Robot (CE 02), on a copy:**
      1. DIMSCALE 50, LTSCALE 500, then CH on a closed boundary: read the PatternScale (2.5).
      2. EH: read 20.
      3. BL across a line: read the zigzag height (100).
      4. CEHATCHAUDIT Report: no issue listed for those hatches.
      5. Plant an Earth hatch at scale 8 on a copy and run Repair: it becomes 20 (this confirms the side effect).
      6. Repeat at 20/200 and 100/1000: values unchanged.
      7. Set DIMSCALE 1 and CANNOSCALE 1:1 in model space, then BL: record the zigzag size.
   4. **Codex look:** the CEHATCH library cards at 1:50, and a 1:50 plot of Earth and Concrete.
8. **Verdict: KEEP-WITH-NOTE. Already shipped; close the PR.** Follow-ups, none of them a change to this PR:
   1. **Tim:** answer QUESTIONS_FOR_MONDAY B4 (straight line or "same on paper").
   2. **New carpark note:** Repair at 1:50 re-scales old hatches.
   3. **Defaults test:** add a load-path defaults test for the switch.
   4. **Already carparked:** BUG-953 covers the mixed-pair stop.
   5. **Train:** none.

### #1297 — BUG-518: ribbon buttons show the AutoCAD command in brackets

1. **What changes.** Every button the shared ribbon builder makes now reads "plain name (COMMAND)", for example "Inspector (CDINSPECTOR)". This covers ordinary buttons, split-button faces, toggles and the gallery (`Shared/CE_SHARED/Services/CeRibbonLabel.cs`, `RibbonBuilder.cs`).
   1. **No doubling:** a label that already names its command is not doubled. I checked all 141 labels in the Civil registry on the newest tip: every bracket already present matches its command.
   2. **One odd label:** the one exception is "Label Styles (folded into CDS)" for CDLABELSTYLE, which would read "Label Styles (folded into CDS) (CDLABELSTYLE)" if it is shown.
   3. **Against Tim's ruling:** this is Tim's 9 Oct ruling (INT-075: plain name AND command, on during the transition, one switch).
   4. **Not covered:** Manager's ribbon never sets the provider, so its 10 buttons stay plain (carpark 2.3). Structural's own ribbon is not covered either (carpark 2.4). The PR says so.
2. **The switch.**
   1. **What it is:** the existing `rightClick.showCommandNames`, default ON (`Modules/Drainage/Models/UserSettings.cs` line 3919 on the tip), pinned by `TheOneSwitch_IsOnByDefault_DuringTheTransition` (`new()` only).
   2. **OFF:** the label is exactly what it was (`WithTheSwitchOff_TheLabelIsExactlyAsBefore`).
   3. **Coupling:** the one switch now drives both the right-click menu and the ribbon.
   4. **Gap:** there is no Settings window row for this switch on the newest tip (no binding in `CivilSettingsView.xaml` or `AdvancedSettingsDialog.xaml`). A drafter cannot turn the brackets off without editing CD_Settings.json. Give Codex a row.
3. **R-27:** nothing blocks. A failing provider gives "off", never a broken ribbon.
4. **Native protection:** no drawing objects are touched; this is ribbon text only. No protected file.
5. **Merge:** already in. When it went in, it shared `PluginInitialization.cs` with #1299 and #1310 (one start-up line each), and those merged cleanly (entry 1056).
6. **Tests:** `Bug518RibbonCommandNamesTests` (23). `CeRibbonLabel` is a new class, so they are red before by construction (they do not compile). One test swaps the static provider and restores it in `finally`. No file I/O except reading source files. No %APPDATA%.
7. **NOT proven:** the label widths on the real ribbon (large buttons wrapping, small stacked buttons cut off), and the Manager ribbon. Robot or Codex look: a screenshot of every Civil ribbon panel at 1920x1080, looking for any cut-off label.
8. **Verdict: KEEP-WITH-NOTE. Already shipped; close the PR.** Follow-ups: a Settings row for `rightClick.showCommandNames` (Codex), and the CDLABELSTYLE label wording if it is ever shown. Train: none.

### #1495 — Civil Settings: drafting fix switches, survey, detention and heartbeat rows (Codex)

1. **What changes.** CDS (and CEMANAGER > Settings > Civil) gets 17 tick boxes for switches that already existed:
   1. **14 boxes on the Fixes tab.**
   2. **On other tabs:** `survey.surveyReadsMTextAndMoreTags` on Survey, `detention.detentionWithoutLengthNotDiameterChecked` on Design, and `fleetTelemetry.heartbeatEnabled` on Advanced.
   3. **Left out on purpose:** the freeboard row is omitted, correctly. `DetentionFreeboardRule.Resolve(150, 200)` returns 200, so a box could not honour a typed 150, and a test proves it (`FreeboardCannotReturnTo150ByWritingOnlyDesignStandardsWithAnOlderPipeCopy`). `topWaterLevelDefaultIsHighestObvert` is held back for Tim's open question, and `consultantCheckReportBesideDwg` for BUG-606. Both are correct.
2. **Defaults:** the PR changes no default; `UserSettings.cs` is not in its file list. On the newest tip:
   1. **The 14 fixes:** ON.
   2. **Survey MText:** OFF (`UserSettings.cs` 3392), and the tooltip warns about pit LEVEL tags.
   3. **Heartbeat:** ON (`FleetTelemetrySettings.cs` 13). I could not find a Tim ruling on the heartbeat default in `C:\CE_PLAN\decisions`. The PR only shows the existing value.
   4. **Round trip:** every row round-trips, changes no other key, and Reset Civil gives the `new UserSettings()` value (`Bj34SettingsPersistenceTests.EveryNewRowRoundTripsWithoutChangingAnyOtherKey`).
3. **R-27:** nothing blocks.
4. **Native protection:** Settings only, so there are no drawing objects. No protected file.
5. **No row lost in the merge:** I grepped the newest Civil tip (rel-20261112a). All 17 bindings are present in BOTH `CivilSettingsView.xaml` and `AdvancedSettingsDialog.xaml` (17 of 17 each).
6. **Tests:** they use a temporary folder and `SettingsService.BeginTestScope` (`Bj34SettingsPersistenceTests.WithCopy`), so nothing touches the real CD_Settings.json. Cancel keeps the file byte for byte. I did not re-run them. The earlier review reports Civil focused 162 of 162.
7. **NOT proven:** how the Fixes tab looks with the 14 extra boxes (three columns, no scrolling) at 1920x1080 and at 125 % scaling. Codex look: open CDS > Fixes, check that no box is clipped, and tick one box, Apply, reopen: it stays ticked.
8. **Verdict: KEEP. Already shipped; close the PR.** Train: none.

### #1517 — UX-DI-03: CDCHECKIGNORE, typed Ignore / Un-ignore for one Checks finding

1. **What changes.** A hidden, typed command: CDCHECKIGNORE.
   1. **The questions:** Ignore or Unignore, then a numbered list of findings, a reason (Survey, Council requirement, Engineer's judgement, Other) and an optional note. The choice is saved inside the drawing's CE record.
   2. **When it comes back:** the hidden finding returns if the pit, pipe or rule value changes.
   3. **Default:** the switch `checks.allowIgnoreFinding` is OFF (`UserSettings.cs` 4321), so it does nothing until Tim turns it on.
   4. **Against the card:** this matches card 2.3 (Batch 2), Tim's recommended answer 4.
2. **The switch:** OFF is pinned by source order (the switch is read before the first question and before the write). On the PR head, though, `InitServicesFull(document)` ran BEFORE the switch check (`Modules/Drainage/Commands/CheckIgnoreCommand.cs`, PR head, first lines of `IgnoreFinding`). The 22 Oct Opus audit (MEDIUM 2) found that "Nothing was changed" was not quite true with the switch OFF. It is fixed on the tip: the switch is read first (`CheckIgnoreSwitchFirstTests`).
3. **R-27:** no hard block. A bad number or reason gives one plain line, and Escape changes nothing.
4. **The save path (extra care), as shipped on the newest tip:**
   1. **One undo step:** CDCHECKIGNORE itself is now a reader only (`CommandFlags.NoUndoMarker`). The write happens in an inner command `CDCHECKIGNOREAPPLY` run by `editor.Command`, after a complete, valid answer. So one U takes it back, and Escape leaves no Undo step. The PR head wrote from inside the prompting command, and that was replaced (`CheckIgnoreUndoTests`).
   2. **Only its own key is written:** `ProjectDataService.WriteIgnoredChecksInDrawing` (`Modules/Drainage/Services/ProjectDataService.IgnoredChecks.cs`, which pre-dates #1517 and is not in its file list) changes only its own key in the drawing's CE record (`MergeIntoProjectJson`). Every other field is kept verbatim.
   3. **Damaged records are left alone:** when the record is held as unreadable it skips the write and returns false (BUG-971). After that, the command no longer prints "Ignored" for a skipped save (BUG-1071; the PR head did print it).
   4. **Where it writes:** to the HOST drawing's dictionary only, never an Xref, and it touches no layer, so locked layers do not apply.
   5. **The person's name:** the PR head stored the raw Windows user name (`Environment.UserName`). A later privacy fix stores a coded name (`CheckIgnoreStoresCodedNameTests`). The Settings box still says "with your reason, name and date". Worth a wording check, not a fault.
5. **Merge:** already in C-60. The only overlap was REGRESSION_LOG.md, and the finaliser put back one blank line (C-60 finaliser report item 3).
6. **Tests:** `IgnoreFindingPickerTests` (pure list rules and source pins) and a command-count bump in `CrossModuleGuardTests` (145 to 146). No %APPDATA%. The author reports 26 new; I did not re-run them.
7. **NOT proven:** nobody has driven CDCHECKIGNORE in AutoCAD with the switch ON. Robot (CE 02), on a copy with `allowIgnoreFinding` set true before launch:
   1. Run CDCHECKS and note a finding.
   2. CDCHECKIGNORE, Ignore, pick it, reason Survey: CDCHECKS no longer lists it.
   3. U: it is back.
   4. REDO: hidden again.
   5. Save, close and reopen: still hidden.
   6. Change that pit's level: it returns.
   7. CDCHECKIGNORE, Unignore: it returns.
   8. Escape at each question: no Undo step is left.
8. **Verdict: KEEP (as shipped). Already shipped, with four later fixes; close the PR, because the PR head is out of date and must never be re-merged.** Train: none.

### #1180 — UX-CPLAN-11 clash half: surveyed services against drawn pipes on plan (rule only)

1. **What changes.** Nothing a drafter can see yet. It is a pure rule, `PlanServiceClashCheck.Check` (`Modules/Drainage/Rules/PlanServiceClashCheck.cs`).
   1. **What it does:** given pipes (centreline, the two inverts, inside diameter) and survey service lines (layer, noted IL), it finds every crossing on plan. It judges each one with the long-section rule `CrossingServiceRule.Evaluate`.
   2. **What is not built:** nothing reads the survey Xref, nothing calls it, and no Checks row or mark is drawn.
   3. **Against the card:** this matches card 6.8 / UX-CPLAN-11 (clash half).
2. **The switch.**
   1. **What it is:** `crossingServices.checkPlanClashes`, default OFF (`CrossingServiceSettings.cs`), per INT-073.
   2. **Pinned twice:** both by `new CrossingServiceSettings()` and by deserialising a settings file that lacks the key (`JsonConvert.DeserializeObject<UserSettings>("{\"version\":\"5.0\"}")`). That second test uses Newtonsoft directly, not `SettingsService.DeserializeSettings`. It is close, but not the exact start-up read.
   3. **OFF:** OFF returns an empty answer.
   4. **R-00:** the minimum clearance stays Tim's number (question 11, blank), so nothing can be red until he sets it. That is correct.
3. **R-27:** nothing blocks. While the minimum is blank every crossing says "clearance not set, not checked". An unknown level says "not checked", and a level is never guessed.
4. **Native protection:** it reads nothing and writes nothing, so none applies yet. The wiring PR that reads the survey Xref must use read-only access (no detach, bind or explode). No protected file.
5. **The conflict:** GitHub says CONFLICTING against its base claude/rel-20261009w. Against the newest Civil tip (rel-20261112a), `git merge-tree` shows exactly one conflicted file: **REGRESSION_LOG.md** (both add an entry at the top). Resolution: keep both, with #1180's entry as its own block at the top and one blank line between headings.
   1. **`CrossingServiceSettings.cs` merges cleanly:** the tip's copy is unchanged from the base.
   2. **`CrossingServiceRule.cs` is also unchanged** between the base and the tip (`git diff --stat` empty), so the three calls #1180 makes (`LabelForLayer`, `CrossingChainages`, `Evaluate`) still have the same signatures. By reading, it should compile. I did not build it.
   3. **No other PR in this group touches these files.**
   4. **Recommended:** rebase or merge the tip into the branch before the train, rather than hand-resolving at assembly.
6. **Tests:** `PlanServiceClashCheckTests`, 10 cases, compile-RED first, then green (the author's word, on a scratch net10 project). They are pure, with no file access and no %APPDATA%.
7. **What is NOT proven, and engineering notes for whoever wires it (none blocks this rule-only PR):**
   1. **Service under the pipe (for Tim, with question 11):** the service is treated as a point at its noted IL, and the pipe uses its inside diameter with no wall (`CrossingServiceRule.Evaluate`, `top = bottom + diameter`). When a service runs under the pipe, the clearance is taken from the service IL (its bottom) up to the pipe invert. It should be from the top of the service to the outside bottom of the pipe. Example: a 150 mm sewer at IL 9.50 under a 375 mm pipe at IL 10.00 reads 0.50 m clear. The real gap is nearer 0.30 m once the sewer's size and the pipe wall are counted. Tim should decide this before he sets the minimum. The long-section rule (already in) has the same sum.
   2. **Chainage units:** the chainage is reported in "metres", but the rule simply measures in whatever units the points are in. A caller passing a millimetre drawing's coordinates would print "ch 10000.0". The wiring PR must convert first.
   3. **A crossing right at a pipe bend:** it can be counted twice (end of one segment and start of the next, both included in `CrossingChainages`). This is shared with the long-section rule. LOW.
   4. **Robot:** nothing to drive yet; there is no command. When it is wired, use a copy with a surveyed sewer line crossing two pipes, one with both inverts and one without, and the switch ON:
      1. Expect one "clearance not set, not checked" line, and one "not checked" line for the pipe without inverts.
      2. Expect nothing red.
8. **Verdict: KEEP-WITH-NOTE. Civil area + smoke** (pure rule, no caller, switch OFF). Resolve REGRESSION_LOG.md by keeping both entries. Record the "service below the pipe" clearance point against question 11 before anyone types a minimum.

### What I could not verify

1. **No tests run:** I ran no test and no build, so every "red before, green after" above is the author's report.
2. **Installed version numbers:** I did not read the installed bundle's version, so "already shipped" means "on the release branch", backed by the carpark and train reports. It is not a reading of Tim's installed DLL.
3. **Heartbeat ruling:** I found no Tim ruling on the heartbeat default (ON). #1495 did not change it.
4. **Locked-layer path:** I did not trace CEHATCHAUDIT Repair's locked-layer handling end to end. It is not part of #1278's change.
