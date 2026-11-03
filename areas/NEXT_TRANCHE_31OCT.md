# Next tranche of bug fixes, 31 Oct 2026 (read-only plan)

Written Sat 31 Oct 2026 (Melbourne) by a read-only planning job. Nothing was built, run, installed, committed or pushed. The only file written is this one. `BUG_CARPARK.md` was only read. No bug is marked fixed.

## ANSWER FIRST

1. **The tranche:** 15 batches, 53 bugs, in 3 builder waves (below). Wave 1 can run at the same time because no two batches share a file: batches 1, 2, 7, 8, 12 and 14. Wave 2 waits for drafts that are already open. Wave 3 is the stacked ones.
2. **Pilot-critical first:** the only two pilot-critical bugs I can code are BUG-540 (batch 1) and BUG-1173 (batch 2). The other 15 pilot-critical bugs with no draft are not code jobs today (Tim's word, a fact to gather, a HOLD, or already on the build register). Reasons in the section after the batches.
3. **The brief does not match the file in three places** (I checked each):
   1. **PILOT-BLOCKER tag:** the carpark has the literal word `PILOT-BLOCKER` on one entry only, BUG-1255 (Pit Schedule Excel on 2027), and it already has draft PR #1871. I could not find the 'about 27'. The nearest real list is the 60 pilot-critical bugs of 24 Oct (BUG_REGISTER_TRIAGE section C). 43 of those 60 now have a draft PR with the bug number in the title. 17 do not. I worked from those 17.
   2. **675 bugs with no fix:** by the last Status line I count 649 open entries outside your exclusion list, not 675. 381 of those have an open PR whose title or branch names the bug (so they already have a draft), leaving 268. I then removed 34 that the 24 Oct triage found were installed under an audit label (HUNT, IJK, W-series). That leaves 234 uncovered entries, and 22 of those sit on the build register or have their own draft. **53 are batched. 22 are on the register or covered. 159 are in the lists below.**
   3. **Draft PR #1715 blocks five council bugs.** BUG-1056 to BUG-1060 (CDTWL flood floor, council speed limits, Darebin run length, Maroondah DN150 grade, AS/NZS 3500.3 edition) are 'BLOCKED handoff, no code fix' for protected-file and engineering decisions. They are in the Tim list, not in a batch.
4. **Structural:** all 16 Structural batches S-1 to S-16 (43 bugs) are already in your exclusion list or built, so there is only one new Structural batch (14), plus a long Tim list.

## A. THE BATCHES

How to read a batch: **line** and base branch; **bugs** with the carpark title in plain words; **how often** a drafter meets it; **likely files** (taken only from the entry text; where the entry names none I say so and the builder must find it); **risk**; **shares files with**. Every entry was filed against an older build (3.0.15 to 3.0.86), so the builder first reproduces the fault on `rel-20261102a` (or `rel-20261026s` for Structural) and drops any bug already gone, and says so.

1. **BATCH 1: Pit Schedule truth**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-540:** step-iron depth is read from two places (Pit Schedule and pit set-up) that can disagree; WRONG ANSWER; the first attempt, PR #1192, was rejected in review.
      1. **BUG-1197:** updating one pit schedule can change another schedule's depth heading through a shared block definition, so an old copy gets PIT DEPTH over its old figures.
      1. **BUG-1155:** a loaded Xref whose source was rebuilt is reported SOURCE MISSING and fails Project QA.
   3. **Why and how often:** 540 is on the 24 Oct pilot-critical list (wrong answer on an issued sheet). The Pit Schedule is a daily tool. 1197 and 1155 are weekly.
   4. **Likely files:** PitScheduleViewModel.Data.cs, PitScheduleViewModel.Filters.cs, PitSetupAdvisorService.cs, RulebookEngine.cs, ScheduleLinkService.cs (540); Schedule.cs, ScheduleLinkService.cs (1197); PitScheduleStatusService.cs, PitScheduleXrefDiscoveryService.cs (1155).
   5. **Risk:** Settings engine (540 must read the step-iron depth from Settings, R-00); schedule is drawn output, so the robot must read the drawn text. 1155 is marked UNSURE (AutoCAD behaviour) in the entry.
   6. **Shares files with:** Shares files with open drafts #1660, #1286, #1765, #1767 and #1816; the builder stacks on whichever merges first. Does not touch any other batch here.

2. **BATCH 2: Manager colleague pack and start-up lines**
   1. **Line:** Manager (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1173:** the colleague pack's backup step saves only 2 of the 5 CE settings folders, so a rollback leaves the others behind.
      1. **BUG-1172:** on AutoCAD 2025 and 2026 the status line says [Modern], so a colleague on 2026 is told he is on the 2027 lane.
      1. **BUG-1244:** CE Manager Refresh prints only its own name and gives no sign of what it did.
      1. **BUG-1261:** the Manager upload of the support zip to the office folder picks files by folder name, so a key or settings file copied into a folder would be sent.
   3. **Why and how often:** 1173 is the only one of the 24 Oct pilot-critical 60 that still has no draft at all (day-one for a colleague on rollback). The rest are seen every start-up or every Refresh.
   4. **Likely files:** CeAdminStorageService.cs, CeSuiteManagerMenuService.cs (1173); Plugin.cs, PluginInitialization.cs (1172); the CEMANAGERREFRESH command (file not named in the entry); the support-zip upload service (file not named; the zip itself is #1878).
   5. **Risk:** Installers and update route (the backup step is the rollback route); Manager is a separate assembly but shares CE_SHARED identity with Civil, so no CE_SHARED edit is allowed in this batch. Check before launching that the B-058 chain (job p1) has not already started 1173; the build register says it was to do 1173 first.
   6. **Shares files with:** Shares Manager files with #1876 (B-058), #1878 (B-063), #1860 (B-050) and B-047. One Manager builder only.

3. **BATCH 3: Edit Pipe batch editor and grade lock (wrong levels)**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-340:** batch Edit Pipe with Carry downstream: two pipes into one pit, the next pipe takes its level from whichever incoming pipe was picked first, so one pipe's water climbs 180 mm; and a Simple Pipe preset preview shows levels Apply does not keep.
      1. **BUG-343:** the grade lock works a breakline-pair half from its own drawn length while both halves store the whole run's levels; pipes set flat keep a held grade; the lock keeps the high end even when the drafter fixed the low end.
      1. **BUG-291:** CDEDIT batch Design grade and 'work it out from the grade' both hold the first drawn end as upstream, so a pipe drawn from the downstream end can turn round.
      1. **BUG-297:** Edit Pipe still finds pits by 'within 100 mm of the insertion point', which never matches for new pipes since the wall snap.
   3. **Why and how often:** Edit Pipe is a daily tool and 340 and 343 are rated HIGH (a pipe shown falling that climbs). These entries are from the 1 and 2 Oct reviews, so the builder must first reproduce each on the newest line; some may be overtaken.
   4. **Likely files:** PipeEditCommand.Batch.cs lines 175-199, PipeEditCommand.Batch.Cascade.cs line 172, PipeEditCommand.Update.cs lines 352-422, PipeEditCommand.Batch.cs lines 880-891 (340); grade-lock code (343, file not named); batch preview and carry-downstream (291, file not named); PipeTruthResolverService.cs line 651 (297).
   5. **Risk:** REDO-safety (Edit Pipe writes levels, then cascades); the Repair Center window part of 343 (item 4, cut-off buttons) is a window and goes to Codex, not this batch; unit conversion in metre drawings is separate (batch 12).
   6. **Shares files with:** Shares PipeEditCommand.Update.cs with batch 5, so run 3 then 5. Stacks on #1838 (B-005) and B-041.

4. **BATCH 4: Lock, copy and damaged-record safeguards**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-286:** CD to a pit on a locked layer: the pit's pipe list is skipped, so the link is one-sided and a later pit MOVE leaves the pipe behind.
      1. **BUG-288:** a downpipe copied onto an existing open pipe end together with a pit is no longer relinked (the 'open end anywhere' rescan was dropped).
      1. **BUG-1070:** Undo restores a good CE record but leaves 'cannot save over an unreadable record' switched on, so later saves say Not saved to the CE record.
      1. **BUG-298:** CDFIXPIPEENDS can half-change a pipe record if it throws, and the 'Pipe X was not changed' line can be false.
   3. **Why and how often:** COPY, locked layers and Undo are used every day on a drafting job; each fault here loses a link silently (the pit moves, the pipe stays). Frequency weekly; the damage is silent.
   4. **Likely files:** LinkService.PipeEndRepair.cs lines 161-166 (298); the copy relink and CD-to-locked-pit code (286, 288, files not named); LinkService record-hold code from PR #1658 (1070).
   5. **Risk:** REDO-safety and native locked-layer rule: the fix must refuse or warn, never unlock (RULES native protection rule). 286 and 288 were read from code by Opus reviews and never seen in AutoCAD.
   6. **Shares files with:** Shares LinkService.* with batch 5 (1157 in LinkService.Persistence.cs). Builds after #1867 (B-049a, ROTATE/SCALE copy) because 288 is the same copy code.

5. **BATCH 5: Edit Pipe save path and wording**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1157:** Edit Pipe stores the level in a separate write that fails silently, so the schedule shows the new IL but the pipe keeps the old level.
      1. **BUG-1164:** on a PC set to comma decimals Edit Pipe stores a level as typed (18,14) and CDAUDIT reads it as 1814.
      1. **BUG-658:** Edit Pipe's cascade prints Updated N pipes before a refused save (for example a locked label layer), so the line is false.
      1. **BUG-1235:** the minimum-grade warning prints Grade 1:200 is shallower than minimum 1:200.
   3. **Why and how often:** Edit Pipe is a daily tool; each item is LOW to MEDIUM and rare (1164 is not hit on Australian-region PCs). A tidy-up batch after the wrong-answer one.
   4. **Likely files:** PipeEditCommand.Update.cs, LinkService.Persistence.cs (1157); PipeEditCommand.Update.cs, PipeEditCommand.cs, RepairAudit.AuditPasses.cs (1164); PipeEditCommand.Update.cs (658); the New Pipe grade warning in CdCommand.Grade.cs (1235, file not named in the entry).
   5. **Risk:** REDO-safety (all four are in the save path); 1164 touches culture-invariant number parsing, so a unit test with a comma culture is needed.
   6. **Shares files with:** Run after batch 3 (same Update.cs) and after #1838. Shares LinkService.Persistence.cs with batch 4.

6. **BATCH 6: CDDESIGN draft, sizing ceilings and reuse test**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-80:** a UPVC pipe sized in CDEDIT is held to a 3.0 m/s scour ceiling while auto-design holds the same pipe to 6.0 m/s.
      1. **BUG-1156:** an older CE wipes newer agreed-design answers (orifice head, detention required) from the Design draft when Save Draft is pressed.
      1. **BUG-1152:** twin detention pipes can be left half-upgraded when the pipe-object upgrade is refused, so the next redraw may place the barrels wrongly.
      1. **BUG-1108:** Manningham's 2,000 L minimum is tested against the whole tank, not the reuse share (latent until the reuse credit runs).
   3. **Why and how often:** CDDESIGN is a once-a-job tool but it puts numbers on a council sheet. 80 and 1108 change a number a council reads; 1156 and 1152 protect a colleague on an older build.
   4. **Likely files:** AutoDesignService.cs, MaterialVelocityLimits.cs (80); CivilDesignWindowViewModel.cs, CivilProjectStartDraftStorage.cs (1156); LinkService.PipeObjectUpgrade (1152); ReuseCreditModels.cs, ReuseCreditService.cs (1108).
   5. **Risk:** Settings engine (80 must read the ceiling from the material table, R-00); protected rulebook files may be touched by 80, so the builder must stop and report if RulebookEngine.cs is needed.
   6. **Shares files with:** Must wait for #1852, #1863, #1872 and #1874 to merge (same CDDESIGN files). 1156 edits the same window as B-029 (#1874).

7. **BATCH 7: Redesign Apply safeguards**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1144:** a damaged outlet-roles record quietly switches off the redesign outlet check, and Apply then overwrites it.
      1. **BUG-1153:** the fixed-outlet (CDLPD) protection in Redesign is skipped when the LPD record cannot be read as exactly one.
      1. **BUG-1158:** 'same drawing' checks use AutoCAD's drawing identity, which a Save As copy keeps, so a new job can load the old job's approved outlets.
   3. **Why and how often:** Redesign is a once-a-job step, but a silent skip of a protection is the kind of fault that reaches a council sheet. Rare, quiet.
   4. **Likely files:** NetworkRedesignApplyCoordinator.cs, NetworkRedesignApplyTicketService.cs, NetworkRedesignCurrentDrawingReader.cs (1144, 1153); CivilDesignCommand.cs, LpdCommand.cs, MultiLpdDrawingAuthorityReader.cs (1158).
   5. **Risk:** Data loss family (Apply overwrites evidence); no new hard block, so the fix is warn and carry on (R-27). Only 1153 is UNSURE whether the outlet really moves.
   6. **Shares files with:** No file overlap with other batches, so it can run beside batches 1, 2 and 14.

8. **BATCH 8: Survey, long section and consultant import lines**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1193:** a curved property boundary is treated as a straight chord in the long section, so the boundary mark lands at 5 m instead of 10 m.
      1. **BUG-765:** any plain number in a survey Xref can become a surface level on the long section (a bare 18.60 between covers of 19.20 dips the line 0.6 m).
      1. **BUG-898:** CDIMPORTXCIVIL and CDIMPORTLANDXML list a pit skipped for a locked layer as Recorded, and a zero-placement import can be called complete.
      1. **BUG-1256:** the consultant drawing reader's cancel line reads Import aborted at pre-flight gate instead of a plain cancelled sentence.
   3. **Why and how often:** Long section and survey are weekly tools. 1193 and 765 are wrong-answer risks on a drawn section; 898 and 1256 are honesty of the result line.
   4. **Likely files:** LongitudinalSectionViewModel.cs (1193, 765); LinkCommands.ImportXcivil.cs (898); the consultant reader cancel line (1256; the entry names PitScheduleViewModel.Schedule.cs, which looks wrong, so the builder must find the line).
   5. **Risk:** No shared file. 1193 is listed under Structural batch S-8 by mistake (it is a Civil CDPROFILE item); the register says it is not covered by B-084.
   6. **Shares files with:** No overlap with other batches. 900 and 804 (multi-page PDF schedules) are left out because they need a real PDF.

9. **BATCH 9: Source blocks: tag text, double-click line, leftover wording**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1242:** the tag beside DP, OF, FO and RG on the plan shows letters only, the number shows only in the Inspector.
      1. **BUG-1250:** double-clicking a downpipe leaves one stray Unknown command line with the click coordinates.
      1. **BUG-1175:** leftover wording points at Tim's folders: CDSL tells a drafter to put a missing block in C:\Lisp Files, CDHELP names C:\Lisp Files\SUPERSEDED, CDTRENCHGRATEAUDIT is fixed to C:\Lisp Files\TRENCH GRATE.dwg.
   3. **Why and how often:** Downpipes and overflows are placed daily, so 1242 and 1250 are seen daily (noise, not wrong values). 1175 is what a colleague reads the first time a block is missing.
   4. **Likely files:** Source label code (1242, after #1845); the double-click redirect (1250, after #1834 and #1862); CdHelpDialog.xaml.cs, LayerService.cs, LinkCommands.cs, SpotLevelCommand (1175; CdHelpDialog is a window, so that one line is for Codex to look at).
   5. **Risk:** Double-click hook runs for every block: keep it fast (BUG-865 is about the scan cost). 1175 is wording only, no behaviour.
   6. **Shares files with:** Builds after #1845, #1834 and #1862 (same source and double-click code). LinkCommands.cs is shared in name with batch 8's LinkCommands.ImportXcivil.cs (check if it is one partial class).

10. **BATCH 10: Tidy labels after a pit MOVE**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1253:** after moving a pit 2 m, its upper-left invert text sits on the blue pipe strip.
      1. **BUG-1034:** Tidy labels Apply moves the IL text 'in from the pipe end' onto its own pipe line (same root as 1253).
      1. **BUG-1161:** moving or flipping a pipe label forgets its kept wording, for example APPROX..
   3. **Why and how often:** MOVE of a pit is daily. Codex saw 1253 on Civil 3.0.86; whether the after-MOVE tidy is on for colleagues is not recorded. 1034 and 1161 are weekly.
   4. **Likely files:** LinkService.TextClashTidyUp.cs (1253, 1034); LinkService.SegmentAnalysis.cs and LinkService.Split.cs (1161).
   5. **Risk:** REDO-safety (label moves after MOVE); the look of the result needs a Codex picture (label on the strip), the robot can read the distance.
   6. **Shares files with:** Same file as batch 11, so run 10 before 11. Builds after #1875 (B-025) and B-025b.

11. **BATCH 11: Tidy labels command internals (switch OFF)**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-873:** Tidy labels takes the writing start-up before its switch, preview and Yes/No, so answering No or Esc can still leave the drawing changed.
      1. **BUG-890:** leader-out planning reserves room using a plain label that will not move, so a callout can land on that label while CE reports a clear spot.
      1. **BUG-891:** a layout pipe's labels are checked against model-space text, and the search margin does not grow with the leader-out distance.
      1. **BUG-962:** every distant survey text is tested against every pipe's search area (9,000 texts and 500 pipes is 4.5 million tests).
   3. **Why and how often:** The Tidy labels command is switched OFF for colleagues, so these are rare; 873 is the one that matters (Esc leaves the drawing changed) if the switch is turned on.
   4. **Likely files:** TidyLabelsCommand.cs, CeCommandBase.cs (873); LinkService.TextClashTidyUp.cs (890, 891, 962).
   5. **Risk:** CeCommandBase.cs is the base of every CE command: a change there touches all commands, so 873 may need a separate Opus review. REDO-safety.
   6. **Shares files with:** Same file as batch 10. PR bodies #1650, #1653 and #1690/#1691 mention 873, 890, 891 and 962; the builder must read them for cover before starting.

12. **BATCH 12: Metre-drawing leftovers**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-293:** Edit Pipe's grade suggestion in metre drawings still divides drawing units by 1000, so it disagrees with Project Review for the same pipe.
      1. **BUG-296:** lower-impact raw millimetre distances were not converted in the units fix (CheckHitboxOverlap, SourcePlacementService and others).
      1. **BUG-321:** label offsets, text heights and the hover radius around scaled pits in a metre drawing are still millimetre numbers.
      1. **BUG-1054:** an open AG or perimeter drain can lose its last point and close itself in a metre drawing.
   3. **Why and how often:** Rare: only metre-unit drawings (INSUNITS 6). Wrong-answer type when it happens, so it matters for a consultant's metre drawing.
   4. **Likely files:** PipeEditCommand.GradeSuggestion.cs line 77 (293); the list in PR #478's body (296); label placement code (321, file not named); AgiCommand.Apply.cs, AgiCommand.Plan.cs, AgiCommand.cs (1054).
   5. **Risk:** Unit conversion everywhere: a missed conversion makes things 1000 times wrong; needs a metre fixture (the runner case T1).
   6. **Shares files with:** 1054 must wait for #1716 and #1727 (same AgiCommand files, on HOLD for C-64). 293 shares Edit Pipe code with batches 3 and 5.

13. **BATCH 13: Inspector follow-ups after the reopen fix**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1263:** with two drawings open, a change that could not be saved before switching away leaves the Inspector showing the last saved values until a CE command runs.
      1. **BUG-1264:** Undo in drawing A after picking in drawing B can leave the Inspector showing a pit the Undo removed.
      1. **BUG-1265:** two near-identical rules decide when to read the saved drawing record (#1866 and #1880); they can drift apart.
      1. **BUG-1266:** an unreadable drawing record writes two log lines on every pick, and the saved list is re-read on every pick.
   3. **Why and how often:** Low and rare; all four are follow-up cards from the Opus pre-review of #1880. Worth doing in one small pass once #1880 and #1866 have merged.
   4. **Likely files:** InspectorProjectSourceRule.cs (1265); the Inspector pit list and log code (1263, 1264, 1266, files not named).
   5. **Risk:** Project record on open (BUG-1240 family); Inspector speed on big drawings is unmeasured (1266).
   6. **Shares files with:** Depends on #1880 (B-059) and #1866 (B-055); cannot start before they merge.

14. **BATCH 14: Structural: dimension error on a locked layer, start-up line, support zip**
   1. **Line:** Structural (base origin/claude/rel-20261026s).
   2. **Bugs:**
      1. **BUG-638:** DSET1 on a dimension that sits on a locked layer opens AutoCAD's Unhandled exception (eOnLockedLayer) window; nothing is changed, but the command should say the dimension is locked and leave it alone; rated HIGH.
      1. **BUG-354:** a start-up line [CE_StrucPlus] LISP not found prints on every AutoCAD start (BUG-402 is the same line).
      1. **BUG-1260:** the Structural support zip walks folders by name only and includes the real Windows login, PC name and drawing path; nothing can start it today, so the entry's own options are to remove it or to scrub it.
   3. **Why and how often:** Structural stays on Tim's PC for the 9 Nov pilot, so none of these hurts a colleague. 638 breaks the native protection rule (refuse cleanly, never unlock) and is HIGH; 354 is seen by Tim at every start.
   4. **Likely files:** Modules/Structural DimensionCommands.cs, SetDimensionsOneToPointTwo (638); CE_StrucPlus.lsp, acad.lsp, ce_suite_startup.lsp (354); Modules/Structural/Services/SupportBundleService.cs, DiagnosticsCommands.cs (1260).
   5. **Risk:** Start-up files and the bundle (354 may delete a call in s::startup, which is bundle content); Structural has its own CE_SHARED copy, unrelated to Civil's; 1260 is a privacy item (Tim's choice: remove or scrub).
   6. **Shares files with:** Structural batch S-11 (BUG-634 and BUG-640) also edits the DSET and dimension code, so run 638 after S-11. Otherwise no shared file with the S batches.

15. **BATCH 15: AutoCAD 2022 to 2024 lane: menu and picker**
   1. **Line:** Civil (base origin/claude/rel-20261102a).
   2. **Bugs:**
      1. **BUG-1211:** on 2022 to 2024, CDMENU says the Civil menu is loaded after CUILOAD unloaded it, but does nothing; Repair's Installed menu OK only checks that the file exists.
      1. **BUG-1214:** on 2022 to 2024 the markup file picker offers PDFs that it always rejects.
   3. **Why and how often:** Only a colleague on AutoCAD 2022 to 2024 meets these (his year is not recorded, gap-plan question 7). 1211 is MEDIUM and can leave a colleague with no CE menu.
   4. **Likely files:** CdRepairDialog.xaml.cs, HubCommands.cs, StandaloneCivilRibbonService (1211); CeAssistantControl.xaml.cs, MarkupFileImageLoader.cs (1214).
   5. **Risk:** net48 only: must build and load on the net48 lane (net48 users are in scope). The rest of the 2022 to 2024 gaps (1209, 1210, 1212, 1213) are not buildable here and are in the lists below.
   6. **Shares files with:** No overlap with any other batch.

## B. ORDER, AND WHICH BATCHES CAN RUN SIDE BY SIDE

1. **Rule used:** first the pilot-critical bugs I could code (batches 1 and 2), then wrong-answer bugs on daily tools (3, 4, 5), then once-a-job design numbers (6, 7), then weekly tools (8, 9), then the after-MOVE tidy (10, 11), then rare set-ups (12, 13, 14, 15). Batches 14 and 15 are last because Structural and AutoCAD 2022 to 2024 are not in the 9 Nov pilot as far as the record shows.
2. **Wave 1, no shared files, safe to run together:** batches 1 (Pit Schedule), 2 (Manager), 7 (Redesign Apply), 8 (survey and import lines), 12 (metre leftovers except 1054) and 14 (Structural). Batch 13 (Inspector) joins once #1880 merges. That is 6 builders at once; the desk's rule is to drop to 3 parallel builders at 60 per cent weekly use, so start 1, 2 and 8 first.
3. **Wave 2, after Wave 1 or after named drafts merge:** 3 (Edit Pipe batch editor), 4 (lock, copy and record safeguards), 6 (CDDESIGN, after #1852, #1863, #1872, #1874), 15 (2022 to 2024 lane).
4. **Wave 3, stacked on Wave 2 or on open drafts:** 5 (after 3 and #1838), 9 (after #1845, #1834, #1862), 10 then 11 (after #1875 and B-025b, and 11 only after 10).
5. **Batches that share files (never run these together):**
   1. **3 and 5:** PipeEditCommand.Update.cs.
   2. **4 and 5:** LinkService.* (Persistence.cs and the record-hold code).
   3. **10 and 11:** LinkService.TextClashTidyUp.cs.
   4. **3 and 12:** Edit Pipe grade code (293 is next to 340 and 343).
   5. **8 and 9:** possibly one partial class LinkCommands (the builder checks first).
   6. **2 and any Manager draft:** #1876, #1878, #1860, B-047.
6. **Settings engine / REDO / installers flagged:** Settings engine in 1, 6; REDO-safety in 3, 4, 5, 10, 11; installers or start-up in 2 and 14; shared-file risk in none (no batch may edit CE_SHARED; if one needs to, it stops and tells CE 00).

## ON THE REGISTER OR COVERED (22, not batched, so nobody builds them twice)

1. **BUG-99:** fix already in the installed code (813b4672); only a Codex look is missing.
1. **BUG-272:** being built by team lane 01 (its Status line).
1. **BUG-472:** B-075.
1. **BUG-495:** B-066.
1. **BUG-525:** B-027.
1. **BUG-591:** draft PR #1258 (its own text).
1. **BUG-602:** installed Civil 3.0.49 (its Status line).
1. **BUG-637:** draft PR #1286.
1. **BUG-648:** B-030.
1. **BUG-866:** B-016 (wording only).
1. **BUG-907:** B-013.
1. **BUG-1046:** #1720 (RD03-07).
1. **BUG-1050:** #1720 and B-072.
1. **BUG-1052:** HOLD on #1716 / #1727.
1. **BUG-1053:** HOLD on #1716 / #1727.
1. **BUG-1230:** B-043e, Tim put it ON HOLD.
1. **BUG-1231:** B-049b, queued behind B-049a (#1867).
1. **BUG-1232:** B-032, not started.
1. **BUG-1233:** B-041, no PR yet (same file as #1838).
1. **BUG-1239:** B-043e, needs the gap value.
1. **BUG-1258:** B-064 reserved.
1. **BUG-1259:** B-062 (#1884, tests only).

## Pilot-critical bugs with no draft that I did NOT batch, and why (15 of the 17)

1. **BUG-1148:** Tim's word first: which values win when pasting from a Save As sister drawing (question 21i). Pilot-critical, WRONG ANSWER.
1. **BUG-685:** Tim's word first: does the typed level stay exact (question 21h). Pilot-critical, WRONG ANSWER.
1. **BUG-907:** Tim's word first, and it has B-013 on the register (pit drop where the pipe gets bigger).
1. **BUG-866:** Tim's word first (is the office rainfall curve 7 to 9 per cent high or 6 to 8 per cent low); only the wording is on the register as B-016.
1. **BUG-1052 and BUG-1053:** Wrong answer in metre drawings and LandXML in millimetres; the fix is draft #1727 (rebased, on HOLD for C-64). Nothing to code until #1727 is reviewed.
1. **BUG-648 and BUG-525:** Already on the register as B-030 and B-027.
1. **BUG-855, BUG-865:** Facts first: a robot run to find the extra data issue (855) and a timing run on a survey drawing (865). Not code.
1. **BUG-1166, BUG-1169, BUG-1170:** Facts first: Max's OneDrive layout and his Structural and Manager versions.
1. **BUG-1209, BUG-1210:** Only matter on AutoCAD 2022 to 2024; his AutoCAD year is not recorded (gap-plan question 7). 1210 is also a window change for Codex.

## C. NEEDS TIM OR REAL DATA (left out of the batches)

Each line is ready to hand to the questions chat (CE 04). Lines marked 'Tim' need a decision or a value. Counts are at the end of each group.

### C1. Tim decision, council value, engineering ruling or design card (67)

1. **BUG-3** (**Command / Area:** `CDCALC` → CE Standard Orifice Pit Detail (CE_CVL_SUITE v3.0)): Do you want a one-click CE standard orifice pit detail drawn from CDCALC results? Needs a command card first.
1. **BUG-54** (**Command / Area:** `REFEDIT` / `REFCLOSE` — in-place external reference (xref) editing, s): REFEDIT then REFCLOSE Save refuses (working-set references). Is this a CE fault or an AutoCAD rule? Needs a look in AutoCAD with an Xref, then your word.
1. **BUG-56** (**Command / Area:** `CDRUNSOLVE` (monorepo `Modules/Drainage`)): CDRUNSOLVE cannot anchor a run on an existing council stub with no known level. What should it ask the drafter (type the stub level, pick the pit)?
1. **BUG-57** (**Command / Area:** `CDDASHBOARD` → filter Errors → "⚒ Propose fixes for all…" (monorepo `): CDDASHBOARD Propose fixes for all: you said some of the logic is wrong. Which category of fix gave a wrong value? You were handling it outside the session.
1. **BUG-95** (**Command / Area:** Civil assisted design / historical detention-storage calibration (GE 2): Glen Eira 24-115 back-test is 30 per cent off the sheet. Which after-development C does the job use? A council value is needed.
1. **BUG-177** (**Command / Area:** CDPIPEOBJ (Draw a pipe as one AutoCAD object, AutoCAD 2027 only) — Civ): CDPIPEOBJ (2027 only) has no ribbon button. Which panel should it sit on, or should it stay command-only?
1. **BUG-245** (**Command / Area:** a pipe from a pit to an open end (Civil 3.0.15). Found by the Opus rev): A pipe from a pit to an open end: when the drawn level and the typed level disagree, which one wins?
1. **BUG-249** (**Real export extension,14October2026:** PDF page1 and XLSX Computations A15 name CODEX_SY): CDCALC Boyd's intensity rows (Kingston, 5 years): needs a command card and your approval before any change.
1. **BUG-287** (**Command / Area:** Civil, drawings whose UNITS are Metres but whose CE pits are millimetr): Metre-unit drawing with millimetre-sized pits: reach is 1000 times tighter than 3.0.17. Keep the tight reach, or widen it with a warning?
1. **BUG-311** (**Command / Area:** CDRUNSOLVE / CDPROPAGATE cancel (#492, disclosed by its builder).): Cancelling CDRUNSOLVE or CDPROPAGATE also rolls back a palette edit made meanwhile. Accept it, or make palette edits wait?
1. **BUG-338** (**Command / Area:** Civil train C-6 adversarial review 1 (pit / metre-units conversion; Op): Only if an office template has UNITS = Metres while drawn in mm. Do your templates or a colleague's ever do that? If not, close.
1. **BUG-411** (**Command / Area:** F2 key runs the CE command CLEAN (Codex W10b, 5 Oct 17:34-17:36, insta): F2 runs the CE command CLEAN. Which key should CLEAN use, if any?
1. **BUG-419** (**Command / Area:** Settings-first and Unknown-as-zero findings of the 7 Oct source audit ): Built-in velocity, cover and grade limits that should be Settings values (R-00): confirm each value to move to Settings.
1. **BUG-431** (**Command / Area:** Council rulebook workstream, Kingston (desk, design run 3, 8 Oct; `04_): Kingston rulebook: confirm the 2018/2025 label and the AS/NZS 3500.3 edition (council value).
1. **BUG-466** (**Command / Area:** HUNT-S-01 (MEDIUM-HIGH): FPFC auto-numbering takes the size of the pad): Structural FPFC auto-numbering takes the size of the pad you started from. Is that wanted? (A partial fix, HUNT-S-01, already shipped.)
1. **BUG-475** (**Command / Area:** HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: ): Structural HUNT-S-09 to 15 docs and wording: which prompts are right, the DAY1 page or the command?
1. **BUG-483** (**Command / Area:** HUNT-M-08 (MEDIUM): the install files in the office folder install old): The office-folder install files install old builds and need administrator rights. Is publishing an install pack your call, and when?
1. **BUG-492** (**Command / Area:** AUDIT 01 A4 (privacy, TIM'S CALL, already asked): the Civil time-log f): Time-log files in the office folder are named after each person's Windows login. Keep, or pseudonymise?
1. **BUG-493** (**Command / Area:** AUDIT 01 section C (settings and profile writes; no value a person set): Start-up writes to settings and profile (umbrella): which of the items C1 to C16 do you want removed?
1. **BUG-494** (**Command / Area:** AUDIT 01 section B (Structural Undo/Redo, Stage 1): in the audit's rea): Structural Undo/Redo stage 1 audit umbrella: split into single items before any build.
1. **BUG-528** (**Command / Area:** HUNT3 heading 6, findings 6.2 and 6.3 (two LOWs on shared files; group): Two LOWs on the shared host guard (CE_SHARED). Shared file: needs the shared-contract plan before a builder starts.
1. **BUG-537** (**Command / Area:** R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to ): Structural R00 values (item 55 colour numbers etc.): 'do not change without consulting Tim'. Which values go to Settings?
1. **BUG-538** (**Command / Area:** R00_CIVIL items 4 (the council and rising-main parts), 5 and 6 (MEDIUM): Council rules written into code (Kingston, Manningham, Casey) and rising-main numbers: your values for Settings.
1. **BUG-539** (**Command / Area:** R00_CIVIL item 1 (MEDIUM-HIGH, ENGINEERING-RESULT RISK; breaks R-00 'n): R-00 number one: roof and paved areas are C 0.9 in CDDESIGN and 1.0 in CDCALC, neither on Settings. Which value is right?
1. **BUG-553** (**Command / Area:** OFF-PC CALLS AUDIT route 13 (MEDIUM for security, LOW for job data): S): Structural CEMARKUPRUN downloads software from the internet by default. Switch it off by default?
1. **BUG-554** (**Command / Area:** OFF-PC CALLS AUDIT route 14 (MEDIUM): the installer downloads the Micr): The installer downloads the WebView2 runtime without a signature check. Allow, bundle it, or check the signature?
1. **BUG-636** (DUP changes unselected dimensions across the drawing without controlled review): Structural DUP changes unselected dimensions across the drawing. Needs a reviewed DUP workflow card (preview and Apply) before any code.
1. **BUG-641** (**Codex look L1B/L2 (18 Oct, installed Civil 3.0.54 / Structural 1.0.118):** STILL SEEN: L): CDCATCHMENT New (MEDIUM, 'not fixed'): the text is too thin to code from. Needs a Codex or robot look, then your word.
1. **BUG-685** (**Command / Area:** CD 'Work it out from the grade', typed level rounded. NEEDS TIM'S RULI): CD 'work it out from the grade' rounds the typed level (10.125 becomes 10.13). Keep the typed end exact, or round to the Settings decimals? (Pilot-critical, WRONG ANSWER.)
1. **BUG-775** (Services-crossing rule measures clearance to the inside of the pipe, ignores service size,): Services-crossing clearance measures to the pipe centre, not the wall, and has no caller yet. Wire it up or park it?
1. **BUG-806** (Orifice detail mapper takes baffle head from the outlet invert and rounds the orifice up (): Orifice detail mapper takes head from the wrong level; no live caller yet. Park until the CDCALC detail drawing (BUG-3) is decided.
1. **BUG-819** (Structural section drawing code: purlin second flange width, purlin lips, actual angle thi): Purlin and angle section drawing code: review the corrected drawing first (you said not to build before).
1. **BUG-883** (**Command / Area:** CE installer, no first-install route, ledger F-017.): Installer has no first-install route (self-install). The pilot is a hand install. Build a first-install route after 9 Nov?
1. **BUG-888** (**Command / Area:** Installer interruption and uninstall, ledger F-024.): Installer killed half way can leave CE missing and has no uninstall or restore. Needed for the pilot, or after?
1. **BUG-908** (**Command / Area:** Engineering numbers fixed in code (R-00), ledger F-053.): R-00 council and pump numbers in code: your values for Settings (Kingston, Manningham, Casey, pump station, orifice, X-Civil 0 to 250 m range).
1. **BUG-909** (**Command / Area:** CEMEMBER picked plane and UCS, ledger F-055.): CEMEMBER keeps only X and Y of the picks (Z = 0) and draws the section square to world axes, not the UCS. Which do you want?
1. **BUG-910** (**Command / Area:** LBUH, LBH and CEMEMBER break marks on a layout sheet, ledger F-056.): LBUH, LBH and CEMEMBER break marks on a layout sheet use the model scale. Follow paper scale?
1. **BUG-1056** (CDTWL can say "That is enough" when the water is only 100 mm below a habitable floor): CDTWL says 'That is enough' with water 100 mm below a habitable floor. What clearance applies (Frankston 300 mm is the only source read), and warn or block? Protected TWL solver; draft #1715 is a hand-off only.
1. **BUG-1057** (Council velocity limits never reach the pipe speed checks): Council speed limits (Banyule 1.0 min, Maroondah 5.0 max) never reach R-01 and R-02. Confirm the council bands and flow conditions. Protected rulebook.
1. **BUG-1058** (A 40 m pipe gets no run-length warning for a Darebin job (their recorded limit is 30 m bet): A 40 m pipe on a Darebin job gets no run-length warning (their limit is 30 m). Confirm Darebin applies to private drainage, its source and its exception.
1. **BUG-1059** (Maroondah's recorded DN150 minimum grade (1 in 80) is not applied): Maroondah DN150 minimum grade 1 in 80 is not applied. Does it apply to ordinary DN150 gravity drains? Protected rulebook.
1. **BUG-1060** (New jobs show the stormwater standard edition as 2021): New jobs show AS/NZS 3500.3 edition 2021. Which edition is current, office-wide or per job, and do issued jobs stay on the old one?
1. **BUG-1094** (Inspector shows a pipe up to 20 per cent flatter than the minimum as amber, not red): Inspector shows a pipe up to 20 per cent flatter than the minimum as amber, not red. What should amber mean?
1. **BUG-1100** (R-10 "ask on every job" is not built): R-10 'ask on every job' (Monash, Bayside reuse): build the confirm-and-record question? Needs the card.
1. **BUG-1104** (R-22 local tank orifice minimum and the "tank flows add up to no more than site PSD" check): R-22 tank orifice minimum (Manningham 25 mm, Maroondah 20 mm) is never checked. Warn or block, and add tank flows against the site PSD? Protected rulebook.
1. **BUG-1105** (The STORM / Blue Factor result is not carried with its source, and nothing compares the re): The STORM / Blue Factor result is not carried with its source and the tank is not compared with the report. Build as a feature card?
1. **BUG-1109** (No council value can be edited anywhere in the product): No council value can be edited anywhere in the product. Is a council editor planned, and where?
1. **BUG-1114** (The office tank library has no Settings page box): The tank library has no Settings page box. Add one (R-00)?
1. **BUG-1116** (Lots of 1,000 m2 and over get Tc 5 min with no note): Lots of 1,000 m2 and over get Tc 5 min with no note. What Tc, or just a note?
1. **BUG-1117** (ifd-melbourne.json ships but is never read): ifd-melbourne.json ships but is never read; the curve is in code. Which is the source of truth?
1. **BUG-1120** (Wording and citations to confirm: STORM "None", Bayside reuse formula, charged downpipe co): Three wordings to confirm: STORM 'None', the Bayside reuse formula, the charged downpipe coefficient note.
1. **BUG-1124** (CEMEMBER always stands an unequal angle on its long leg): CEMEMBER stands an unequal angle on its long leg only. Which UA leg may be upright (a shelf angle needs the short leg up)?
1. **BUG-1125** (CEMEMBER cannot draw an RHS laid on its flat): CEMEMBER cannot draw an RHS laid flat. Add an orientation question for RHS? (You earlier said one orientation.)
1. **BUG-1127** (The angle toe radius is drawn on the wrong corner of each leg tip): Angle toe radius drawn on the wrong corner. Need the supplier drawing to confirm.
1. **BUG-1130** (250UC89.5 is drawn with square corners; every other UC has fillets): 250UC89.5 drawn with square corners. Need the real root radius (about 13 mm from memory).
1. **BUG-1133** (The new XCLMTXT angle rule only works when the angle symbol comes straight after the size): XCLMTXT angle rule fails when the symbol is not straight after the size. Do any real sheets put it elsewhere?
1. **BUG-1148** (Pasting a pit from a "Save As" sister drawing gives it this drawing's pit values): Pasting a pit from a Save As sister drawing gives it this drawing's values. Which should win, the pasted pit's own values or the local ones? (Pilot-critical, WRONG ANSWER.)
1. **BUG-1154** (Some large records are saved as one long text value, unlike the rest of CE): Large records saved as one long text value (footing register, long section): needs a test with a large job and DXFOUT first.
1. **BUG-1160** (No drawing records which CE version last wrote it): Record which CE version last wrote a drawing: a new feature. Approve the card?
1. **BUG-1205** (Opening a second AutoCAD is recorded as a crash of the first): Opening a second AutoCAD is recorded as a crash of the first (one shared session file). Fix needs a shared-file change: approve a per-session record?
1. **BUG-1212** (CDWT loses both tank-selection pictures and the first window on AutoCAD 2022-2024): CDWT has no tank pictures or first window on AutoCAD 2022 to 2024 (a deliberate gap). Close the gap or accept it?
1. **BUG-1213** (Older AutoCAD cannot open the council evidence behind a value or saved rule finding): AutoCAD 2022 to 2024 cannot open the council evidence behind a value. Needed for the colleague's year? (His AutoCAD year is not recorded.)
1. **BUG-1236** (FO (front overflow) places a block whose symbol text says "OF", not "FO"): FO places a block whose symbol text says OF. Is that intended (card D08 says the same symbol on purpose)?
1. **BUG-1243** (CE Blocks (CEBLOCKS) does not work the way Tim wanted): CE Blocks 'does not work how I wanted': what did you want? Nothing is recorded anywhere.
1. **BUG-1245** (Move + Rotate (MR) and Copy + Rotate (CR) stop on Tim's selection with a code word in the ): Move+Rotate and Copy+Rotate refuse a raingarden with a code word. Should they work on a raingarden? Native component (protected).
1. **BUG-1249** (CE Inspector, On plan tab, says the pit label is "bottom right" when the P2 label is drawn): Inspector On plan tab says the label is 'bottom right' while it is drawn above: which row did you mean? (The Label position row is the wrong one on the screenshots.)
1. **BUG-1252** (A hand-placed pipe label is shifted when its pit moves, with "hand-placed labels stay" ON,): Hand-placed pipe label shifts half the pit's move with 'hand-placed labels stay' ON: keep or change the rule? (Monday question 19, ON HOLD.)

### C2. Real project data or a consultant package (6)

1. **BUG-61** (**Command / Area:** `CDIMPORTXCIVIL` — "multi-segment pipes drawn as individual segments w): Consultant drawing: multi-segment pipes split. Needs a real consultant DWG.
1. **BUG-63** (**Command / Area:** `CDIMPORTXCIVIL` — council stub + existing council pipes not imported): Council stub and existing council pipes not imported. Design item: needs your input and a real consultant package.
1. **BUG-66** (**Command / Area:** `CDIMPORTXCIVIL` — annotation placement): Imported pit labels and cover levels strewn about. Re-evaluate on a real consultant drawing.
1. **BUG-68** (**Command / Area:** `CDIMPORTXCIVIL` — placement/alignment): Imported network does not land where the architectural plans are xrefed. Ruling received; needs a real package and the design.
1. **BUG-804** (AI vision fallback never sends a schedule that is beyond page 6): AI vision fallback skips a schedule beyond page 6 (paid pages). Needs a real multi-page PDF; AI is switched off for colleagues.
1. **BUG-900** (**Command / Area:** CDIMPORTXCIVIL PDF schedules, ledger F-041.): A schedule over several PDF pages returns one page. Needs a real multi-page schedule PDF.

### C3. Codex list: window changes (windows are Codex-owned) (11)

1. **BUG-213** (**Fresh real AutoCAD FAIL, 14 Oct 2026 05:29, Civil3.0.49:** same dead end still present o): Pit Schedule > Placement for an older schedule has no enabled Replace button (window change, plus your wording).
1. **BUG-222** (**Command / Area:** CEMANAGER > Settings > Civil form (Manager 1.1.15). Breaks Tim's rule:): Manager Settings Civil form scrolls (breaks the no-scroll rule): a window regroup.
1. **BUG-581** (Manager Help Start tool minimises without launching its drawing prompts): Manager Help 'Start tool' minimises without launching the prompts (window behaviour).
1. **BUG-958** (**Command / Area:** Remember window position for Edit Pipe, Edit Pit, New Pit and CDS, led): Edit Pipe, Edit Pit, New Pit, CDS ignore Remember window position (window code).
1. **BUG-959** (**Command / Area:** Civil Hub position on a second monitor, ledger F-143.): Civil Hub reopens on the primary screen, not the second monitor (window code).
1. **BUG-1033** (CDCALC Pump System tab is read-only but shows no read-only banner): CDCALC Pump System tab is read-only but shows no banner (window).
1. **BUG-1208** (The second AutoCAD can erase a different window's newly saved position): A second AutoCAD can erase the other's saved window position (window store, off by default).
1. **BUG-1210** (Edit Pipe and Edit Pit lose the real plan and picture selection on the older lane): Edit Pipe and Edit Pit lose the plan picture and click selection on AutoCAD 2022 to 2024 (window controls compiled out).
1. **BUG-1217** (Calculations Help invites input to Pump System and WSUD calculators that are read-only): Calculations Help invites input to read-only Pump System and WSUD tabs (window text).
1. **BUG-1248** (The Survey Intake review is written in survey-software words (XREF, sha256, TIN triangles,): Survey Intake review is written in survey-software words (Manager window wording).
1. **BUG-1254** (The CDCHECKDWG results list cuts off its next row at the bottom, and one wheel turn does n): CDCHECKDWG list cuts off its last row (window; CE 00's analysis says probably no fault).

### C4. Too thin or needs a look in AutoCAD first (a robot or Codex look is not code; listed so nobody builds blind) (46)

1. **BUG-16** (**Command / Area:** `CD` command Custom Grade textbox — `CdViewModel.CustomGrade` setter +): CD Custom Grade box (May): re-test on the current build; probably overtaken.
1. **BUG-17** (**Command / Area:** Whole CE plugin (Civil + Structural). Affects ALL commands when run wi): Whole plugin with a non-World UCS (May): failure mode never recorded; robot look on a current build first.
1. **BUG-22** (**Command / Area:** `CDSTRIP` — Floor Waste placement at corners + 12m centres along strai): CDSTRIP floor waste lands on the MLINE, not central (May): re-test first.
1. **BUG-23** (**Command / Area:** `CD` — Rising Main split-across-plans workflow (PARK-032 multi-plan).): Rising main breakline treated as a real node for inverts (May): re-test first.
1. **BUG-24** (**Command / Area:** `CD` + `CDEDIT` — Auto-Calc grade + pipe text label.): CD and CDEDIT auto-calc grade gives random grades (May): re-test first.
1. **BUG-49** (**Command / Area:** `CEADS` (also `CEADMINSETTINGS`) — the CE Drafting Standards / setting): CEADS crashes AutoCAD (June, v2.0): re-test first; it is a CRASH, so do not assume it is gone.
1. **BUG-98** (**Command / Area:** pit labels vs stored pit identity (plan label text, CDINSPECTOR, long ): Pit labels vs stored pit identity: the entry says diagnose first; no cause known.
1. **BUG-163** (**Command / Area:** `CDWT` (water tanks), placing a tank. Area G. Colleague release blocke): CDWT: AutoCAD cannot continue when picking the callout (CRASH, Test Day 16 Sep, Codex reproduced 17 Sep): robot reproduction on the current build before any code.
1. **BUG-195** (.. BUG-201 (Codex exploratory run X1, 29 Sep 2026 14:14-14:51, Civil 3.0.14 / Structural 1): Group entry for BUG-195 to 201 (Codex run X1): split into single entries first.
1. **BUG-202** (**Command / Area:** Whole AutoCAD session, Structural drawing (Civil 3.0.14 / Structural 1): Structural whole-session lag: mostly environment.
1. **BUG-206** (**Command / Area:** AutoCAD system variable OSMODE (Tim's running object snaps), across a ): OSMODE changes across a Codex pass: cause unknown.
1. **BUG-229** (**Command / Area:** CDMANAGER > Layers > Draw Order list (Civil 3.0.15). An observation, n): CDMANAGER Layers Draw Order list: observation, cause unknown.
1. **BUG-235** (**Command / Area:** COPY of a pit (relink by proximity) - from the Opus review of PR #417,): COPY of a pit relinks by proximity: read from code, never seen.
1. **BUG-265** (**Command / Area:** Structural drawings with both suites loaded: activation of a Civil dra): Structural debug lines and the restart-recommended message: the entry says fix PR #445 is inside Structural 1.0.114; read each item against that PR before anyone codes.
1. **BUG-280** (**Command / Area:** Civil and Structural: the "redo window" rules (hold background work af): Two copies of the REDO window rules (Civil and Structural) have drifted: REDO-safe, needs an Opus plan, not a quick fix.
1. **BUG-295** (**Command / Area:** Civil Undo/Redo, C-3 Opus ADV 1 LOW 5, 6, 8: the redo window may relea): Undo and Redo LOW items: all need measuring in AutoCAD first.
1. **BUG-304** (**Command / Area:** Structural S-3 sign-off (1 Oct): footing follow on AutoCAD 2024.): Structural footing follow on AutoCAD 2024: needs a 2024 PC.
1. **BUG-310** (**Command / Area:** OOPS after erasing a copied pipe (#490), from the Opus finalizer of tr): OOPS after erasing a copied pipe could attach labels to the wrong row: needs a reproduction.
1. **BUG-319** (**Command / Area:** CDDESIGN areas (from the Opus confirm of PR #497, 2 Oct).): CDDESIGN area typed over a CDCALC figure: window wording, re-test first.
1. **BUG-320** (**Command / Area:** Civil paste and settings follow-ups (from the PR #501 builder, 2 Oct).): Paste follow-ups: cause of skipped pasted pits not proven (log lines were added to settle it).
1. **BUG-361** (**Command / Area:** typed `PIT` prompt at 1.5-1.9 cores (desk driver session 5, 3 Oct abou): Typed PIT prompt hang at 1.5 cores with a 2.9 GB dump: contradicts 'driver only'; read the PC-lag evidence first.
1. **BUG-383** (**Command / Area:** a fresh open of a drawing marks it modified (Structural 1.0.96 loaded)): Structural: a fresh open marks the drawing modified; the writer is not found.
1. **BUG-397** (**Command / Area:** Manager CE.Host load list (reviewer run 87, REVIEWLANE_LOG 584-586, 4 ): Manager CE.Host load list shows a wrong list in two PRs: text too thin.
1. **BUG-399** (**Command / Area:** FEDIT outline click (Structural), Codex W9c W9-01B, 4 Oct 18:51. At cl): Structural FEDIT outline click at close zoom: observation only.
1. **BUG-409** (**Command / Area:** TEST INCIDENT on Tim's live Structural settings (Codex W11-03, 5 Oct 1): Test incident on Tim's live Structural settings: needs your word, not code.
1. **BUG-410** (**Command / Area:** W11 findings on installed Structural 1.0.102 (Codex, 5 Oct 10:44; most): Structural W11 findings: mostly checklist errors.
1. **BUG-412** (**Command / Area:** Civil, installed 3.0.32, Codex W10c (5 Oct 18:07): (1) after a New Pit): New Pit placement then Esc then TEXTSCR shows a CE save message: too thin.
1. **BUG-415** (**Command / Area:** Civil pit-number wording gaps (C-19 finalizer, LOW, none block C-19): ): Pit-number wording gaps: too thin, re-test first.
1. **BUG-469** (**Command / Area:** HUNT-S-04 (MEDIUM): FEDIT Esc at "Select new type [ExternalBeam/...]" ): Structural FEDIT Esc still saves (HUNT-S-04): the status says the old fault did not occur in 1.0.112; needs a look.
1. **BUG-595** (**Status:** OPEN / INVESTIGATE — native recovery unresolved; cause unproven;15October2026.): Native recovery unresolved, cause unproven.
1. **BUG-623** (Q note is blank inside native text editor on the tested fixture): Structural Q note blank in the native text editor: cause not separated.
1. **BUG-749** (Section Mark: answering the identifier question triggers a paste command (not yet shown to): Structural SM identifier answer triggers a paste command: may be Codex typing; a second run is needed.
1. **BUG-822** (A "What's New" palette opened by itself partway through a session): What's New palette opened by itself: cause not known.
1. **BUG-855** (Pit Schedule header "data issues" count goes up by one after the first CDSYNC): Pit Schedule 'data issues' count goes up by one after the first CDSYNC: a robot run to find which issue is new (FB-15).
1. **BUG-865** (**Command / Area:** Double-click hook scan cost (#1499/#1520 area). Opus audit finding on ): Every double-click scans every block (slow in survey drawings): a timing run on a real survey drawing first.
1. **BUG-1084** (Hatch Change may edit a hatch inside a REFEDIT (not yet shown)): Structural Hatch Change inside REFEDIT: not seen in AutoCAD.
1. **BUG-1118** (Downpipe placement preview is a fixed 100 drawing units): Downpipe preview marker is a fixed 100 units: not seen in AutoCAD (metre drawings).
1. **BUG-1163** (DXFOUT may leave out a CE record still waiting to be saved): DXFOUT may omit a CE record not yet saved: AutoCAD event, UNSURE.
1. **BUG-1166** (Civil and Manager look for the office folders in different places): Civil and Manager look for office folders in different places: needs Max's actual OneDrive layout.
1. **BUG-1169** (Max's old July Structural may carry an older shared file with the same version number): Max's old July Structural may load an older shared file: needs his Structural version.
1. **BUG-1170** (Going back restores an old Manager that may stage updates by itself): Rollback may restore an old Manager that stages updates itself: needs Max's Manager version.
1. **BUG-1176** (Delivering the package as a downloaded zip can block a helper): A downloaded zip may block the PDF schedule helper: UNSURE, needs a test with a marked zip.
1. **BUG-1207** (Two AutoCAD sessions may overwrite lines in the main Civil log): Two AutoCADs may overwrite lines in the main log: suspected, not reproduced.
1. **BUG-1209** (A downpipe cannot be placed directly on a valid pit on AutoCAD 2022-2024): Downpipe cannot be placed on a pit on AutoCAD 2022 to 2024: needs the colleague's AutoCAD year (gap question 7).
1. **BUG-1234** (Two new pipes that end at a new pit: the IL texts sit on top of the pit symbol and the flo): Two pipes ending at a new pit, IL texts on the pit symbol: Tim suspects the after-MOVE tidy; compare with it switched off.
1. **BUG-1241** (CDCHECKDWG says pit P2 has no invert level although two pipes with levels meet at it (ques): CDCHECKDWG says P2 has no invert: likely the same cause as BUG-1240; robot re-run after #1880.

### C5. Not product faults, duplicates or latent code (close candidates for Tim's one-look yes, D6; nothing is closed here) (29)

1. **BUG-7** (**Command / Area:** Monday batch — all items coded 2026-05-08, awaiting AutoCAD confirmati): Umbrella record for the 8 May batch; not a bug.
1. **BUG-40** (**Command / Area:** `CDWT` — pit-detention mode (R4.10 / round 4 / 2026-05-21).): Retired from CDWT on 13 Sep (its own status).
1. **BUG-96** (**Command / Area:** Structural release verification / source packaging inputs): Test packaging file, locally corrected.
1. **BUG-97** (**Command / Area:** Command inventory and AI tool-list verification): Test counts, locally corrected.
1. **BUG-240** (**Command / Area:** Tim's REAL AutoCAD 2027 profile `Tim` (read from his own settings expo): Tim's AutoCAD profile settings record; not a product fault.
1. **BUG-307** (**Codex V3/UX verification, 13 Oct 2026, installed Civil source 48662ddd:** re-ran the com): Same red Glen Eira back-test as BUG-095.
1. **BUG-326** (**Command / Area:** AutoCAD FATAL ERROR during Codex VERIFYC5 item C5-12 setup (2 Oct 02:0): AutoCAD fatal error on a LAYER lock from a Codex script; not attributed to CE.
1. **BUG-345** (**Command / Area:** C-7 builder leftovers (Opus builder a36ec5d339421ed8c, branch claude/r): Builder leftovers including a test-runner crash; test tooling.
1. **BUG-371** (**Command / Area:** Civil/Manager train C-10 Opus finalizer (a86db87183cf640b8, branch cla): Finalizer LOWs on train C-10.
1. **BUG-374** (**Command / Area:** Codex verifyW2b (restart of the mouse pass, 16:13-17:06 PC, Codex 4% -): Codex run result record.
1. **BUG-390** (**Command / Area:** Codex verifyW6 results (4 Oct 05:02-05:39 PC clock, usage 17% -> 19%; ): Codex run result record.
1. **BUG-391** (**Command / Area:** Desk driver run 24, the ONE combined session (4 Oct ~08:40; `DRIVER_RU): Desk driver run result record.
1. **BUG-392** (**Command / Area:** Codex verifyW7 results (4 Oct 07:52-08:29 PC clock, usage 19% -> 21%; ): Codex run result record.
1. **BUG-395** (**Command / Area:** Codex verifyW8 results (4 Oct 10:12-11:09 PC clock, usage 22% -> 25% =): Codex run result record.
1. **BUG-402** (**Command / Area:** AutoCAD start-up message (Codex W9d, 4 Oct 19:31): the command line pr): Same start-up line as BUG-354 (batched in 14).
1. **BUG-404** (**Command / Area:** the PC's C: drive during builds and tests (not an AutoCAD command): fr): C: drive free space; PC housekeeping, not a drafter command.
1. **BUG-421** (**Command / Area:** STRAY TEXT TYPED INTO AUTOCAD DURING CODEX PASSES (observed 4 times: 1): Stray text typed during Codex passes; brief wording, not CE.
1. **BUG-436** (**Command / Area:** CODEX W25 = BUG-061 re-import check on installed Civil 3.0.36 (8 Oct 0): Result record, tracked as BUG-061.
1. **BUG-444** (**Command / Area:** C-24 Opus finalizer findings (8 Oct, TRAIN_C24_FINALIZER_REPORT.md; GO): Finalizer LOWs of train C-24.
1. **BUG-455** (**Command / Area:** Codex W45 on the installed Civil 3.0.40+1200744d / Manager 1.1.40+1200): Duplicate of BUG-435 and BUG-562.
1. **BUG-562** (**Command / Area:** AutoCAD start-up with Civil 3.0.41 / Manager 1.1.41 / Structural 1.0.1): Start-up record; duplicate family.
1. **BUG-564** (**Command / Area:** FEDIT, Esc at the 'Select new type' question, then U. Structural 1.0.1): Same Esc family as BUG-469.
1. **BUG-567** (Structural compatibility tests require obsolete version 1.0.78): Structural test expects obsolete version 1.0.78 (test only).
1. **BUG-568** (Structural test host times out during compiled-proof work): Structural test host timeout (test only).
1. **BUG-569** (Beam-picker source guard rejects its single forwarding implementation): Beam-picker source guard (test guard; code ready, needs a review).
1. **BUG-639** (Historical workflow-card index has eleven unresolved local document links): Historical card index with dead links (docs).
1. **BUG-821** (CDTAG ignores a block that is already selected and asks for a pick): Works as designed (FIX_BRIEFS 23 Oct).
1. **BUG-1119** (The background downpipe detector matches layer words by "contains"): Background downpipe detector has no caller yet (latent).
1. **BUG-1177** (The weekly time export can run during Max's AutoCAD start, with no switch to turn it off): Same weekly time export as BUG-1202 (PR #1776).

**C total: 159** (C1 67, C2 6, C3 11, C4 46, C5 29).

## What I did not check (RULES 5.9)

1. **No code was read.** File names are the ones the carpark entries and the 24 Oct, 30 Oct and 31 Oct area files name. Where an entry names none, the batch says so.
2. **Open PRs** were read with `gh pr list --state open --limit 3000` (title, branch and body). Cover means the bug number is in a PR title or branch. A bug named only in a PR body was not treated as covered, except where I read the body (#1715, #1720). PRs named by an audit code and not a bug number could hide a few more covered entries.
3. **The 34 'installed under another label' bugs** come from the 24 Oct triage list (A, item 1 to 3) and I did not re-verify them in the installed history.
4. **Which build is installed now** is not checked. Entries cite builds 3.0.15 to 3.0.86; a number of the older ones (Oct 1 and 2) may be overtaken. Every batch says to reproduce first.
5. **The build register** (`release-v3-colleagues-BUILD_REGISTER.md`, 433 lines) was searched by bug number only; B numbers I could not match to a bug number are not in the 'on the register' list.
6. **Old Status lines lag.** 53 entries have no Status line at all; I used the tidy line the 29 Oct job added where it exists.
