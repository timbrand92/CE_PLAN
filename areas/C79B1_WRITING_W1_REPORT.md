# C-79b1 case writing, job W1 (Sun 1 Nov 2026)

Writer W1 (Opus, Team). Wrote case files and this report only. Ran no AutoCAD, robot, build or test; edited no existing file; committed nothing.

## Answer first

1. **2 of my 5 PRs have a robot case family; 3 do not.** 4 files in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_c79b1_01nov\`, all NOT RUN.
2. **#1891 (BUG-1246, copied downpipe's own tag): family bug1246.** W1246 plus twin W1246_BROKEN (switch off). A real red.
3. **#1972 (BUG-658, cascade question after the save): family bug658.** W658 plus twin W658_BROKEN. Partial: the robot proves the moved question still works and one U takes back everything. It cannot see the ORDER. That goes to a Codex look.
4. **#1868 (BUG-1091, large-pipe minimum fall): no case.** The PR only changes the grade CE *proposes* inside windows. It adds no warning line. The plan's "read the warning" describes #1841, which is already in. Unit tests are the evidence, plus a Codex look.
5. **#1945 (BUG-1158, CDDESIGN Save As warning): no case.** The robot cannot approve outlets (CDLPD window), and the driver refuses Save As. A one-off fixture would make it robot-provable.
6. **#1970 (BUG-1157, "level was not saved"): no case.** Its only triggers are a pipe that vanishes mid-save or AutoCAD refusing the write. A locked layer is not a trigger: it skips quietly. The damaged-record setups need typed Lisp, and the runner blocks typed Lisp. The PR's own log says no robot route exists.
7. **Offline checks are clean.** Validate: 4 files, 0 invalid. Control ids: all known. No "print" in my files, no street names, every level copied from R11v87.
8. **Runs needed: 6.** W1246 x2 starts, W1246_BROKEN x1, W658 x2, W658_BROKEN x1.
9. **Codex looks: 4.** The #1972 order and refused save, the #1891 label position, the #1868 grade strip, and #1945 if no fixture is made.
10. **#1972 was written against head 32fc1a44.** That is CE 05's fx72 fix commit, newer than the 556b3848 in the PR list.
11. **C79B1_FIXTURE_NOTE.md did not exist when I wrote this.** None of my cases uses a SETUP-DMG setup.
12. **Nothing is FIXED.** These are unrun drafts.

## 1. #1891, BUG-1246: a copied downpipe gets its own next tag (head 4f21fc9d)

1. **Case and twin:** `W1246_copied_dp_own_tag_locked_label.case.txt` (CASE W1246) and `W1246_BROKEN.case.txt`. FAMILY bug1246.
2. **What it does in AutoCAD:**
   1. Places a downpipe with DP at 150000,-80000. It gets DP1 and its label text on GUIDELINES.
   2. Selects only that downpipe and runs CR (Copy + Rotate) to 156000,-80000 at 90 degrees. This is Tim's hand check H39 route.
   3. Locks layer GUIDELINES with -LAYER, then runs CR on the original again to 150000,-75000.
3. **What must be true at the end:**
   1. The first copy's line says it got DP2 and the original stays DP1. The copy has its own new GUIDELINES text.
   2. The second copy's line says DP3. A second line names GUIDELINES as locked. The second copy has no new GUIDELINES text.
   3. The old "could not be given its own link" line never appears. No CE window is left open, and the file on disk is unchanged.
4. **Where the checked words come from (PR #1891 diff):**
   1. `Rules/CopiedSourceOwnTagRule.cs` lines 54-72 (OwnTagLine).
   2. `Rules/CopiedSourceOwnTagRule.cs` lines 37-52 (LockedLabelLayerLine). The PR's own test uses exactly "DP3" and "GUIDELINES" (test lines 135-145).
   3. The retag call: `Services/LinkService.Utilities.cs` hunk at 229-246.
   4. The label layer and lock check: `Services/LinkService.CopiedSourceOwnTag.cs` lines 62-80.
5. **DERIVED, never seen on a run:**
   1. That CR of a lone downpipe still takes the "cannot be completed" path on this AutoCAD. Tim saw it on 3.0.85.
   2. That the next free tags are DP2 then DP3. DRV1_B1 holds no downpipe before the case: N04 placed DP1.
   3. That the label layer is GUIDELINES. This is P02's reading of N04's run.
   4. If CR now completes the copy in full, neither line appears and W1246 fails on its first CE check. That is a FINDING. Do not edit the case.
6. **Arithmetic:** none. Points are placed in empty ground inside the zoom window 146000..164000 by -86000..-72000.
7. **The one thing the twin breaks:** SETTING `linking.copiedDownpipeGetsOwnTag false`. The old BUG-1137 line then prints instead, so the DP2 check fails.
8. **Robot can accept alone:** the two CE lines, the absent old line, and the downpipe and GUIDELINES text counts.
9. **Codex must SEE (in NOT_AUTOMATED):**
   1. Where the copy's label sits.
   2. That the Inspector or schedule shows DP2 and DP3 once each.
   3. That GUIDELINES is still locked afterwards.
10. **HEADLESS: maybe.** It uses typed commands and drawing reads only, with no window. Whether CE's CR and DP run under accoreconsole is unknown.

## 2. #1972, BUG-658: Edit Pipe's downstream question comes after the change is accepted (head 32fc1a44)

1. **Case and twin:** `W658_cascade_after_edit_save.case.txt` (CASE W658, SETUP-R47v) and `W658_BROKEN.case.txt`. FAMILY bug658.
2. **What it does in AutoCAD:** this is R11v87's route, which PASSED on 3.0.88 in run RUN-20261031-1027-C3.0.88-aF4vR.
   1. Edit Pipe on P3 (handle 10A98D), with levels 17.60 and 17.50, then Save.
   2. Answers Yes to the Recalculate box, then Apply in Cascade Preview.
   3. Then one U.
3. **What must be true at the end:**
   1. The question still comes, and "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50). Min grade: 1:16." prints.
   2. All invert texts match R11v87's after-cascade set exactly.
   3. Neither new fx72 line prints: "The downstream levels were not recalculated" and "The downstream recalculation could not be completed".
   4. One U shows CDEDIT and puts every invert text and the object count back. This proves the edit and the cascade (now run after the commit) are still one Undo step.
4. **Where the checked words come from (PR #1972 at 32fc1a44):**
   1. `Commands/PipeEditCommand.Update.cs`: the hold-back hunk at 1953-1961 and the after-commit block at 1240-1270.
   2. `Rules/CascadeAfterCommitRule.cs` lines 32-38 (the skipped line).
   3. The cascade line and levels: copied from R11v87's passed run, not from memory.
5. **Arithmetic:** none new. 17.60 to 17.50 is R11v87's own pair, and SETUP-R47v holds the 1-in-100 P8 pipe (18.000 to 17.800 over 20 m, a fall of 0.200).
6. **The one thing the twin breaks:** the Recalculate box is answered No. The Apply press becomes a sleep because no preview opens. It fails on the "Updated 4 pipes" line and on the after-cascade set.
7. **Honest limit: the twin is not a switch-off twin.** On this route, `pipe.cascadeQuestionAfterEditCommits` OFF gives the same lines and levels. Only the order differs, and the robot cannot read order: the Recalculate box is a native box and COM is blocked while it is up. A switch-off twin would PASS and prove nothing.
8. **Robot can accept alone:** the cascade line, the 46 invert texts, the absent new lines, U restoring everything, and the CDEDIT outcome log count.
9. **Codex must SEE (in NOT_AUTOMATED):**
   1. When the Recalculate box appears, the drawing behind it already shows P3 at 17.60 and 17.50. With the switch false and AutoCAD restarted, the box comes first.
   2. A refused save asks nothing and changes nothing downstream. The PR's example, a locked label layer, is UNSURE as a trigger. CE's locked-layer rules mostly skip a write and say so; they do not roll the save back. Codex must find a refusal that really rolls back.
   3. The fx72 "reopen the drawing, then run CDPROPAGATE" line has no robot route.
10. **HEADLESS: no.** It uses the Edit Pipe window, a native message box and Cascade Preview.
11. **LOGIC EVIDENCE:** `Bug658CascadeAfterCommitTests`. TheHeldBackQuestionIsAskedOnlyAfterAnAcceptedSave, ARefusedSaveLeavesNothingHeldBack_BecauseTheHoldIsOnlyReadAfterAnAcceptedCommit and SavedButNeedsReopening_TheCommandLineSaysTheDownstreamLevelsWereNotRecalculated cover the refused and skipped paths. Most of the rest are source-order guards.

## 3. #1868, BUG-1091: large-pipe minimum fall (head 38c3f825), no robot case

1. **Why no case:**
   1. The PR changes one reader, `SettingsSizingStandards.ForEveryMaterial` (diff hunk at 97-103 and 132-156). Civil Design, auto-design, network redesign and the CD/Edit Pipe grade suggestion (`PipeSizingStandards.CreateDefault`) now keep the DN450-and-up minimum fall row.
   2. It adds no command-line line. Its only effect is the grade CE proposes inside windows. CDCALC and CDDESIGN results are window-only.
   3. The plan's "draw a flatter 450 and read the warning" is #1841's Edit Pipe strip and CDRULES warning, which is already in the line.
2. **A possible later route, not written:** a draw-first CD of a 450 between two pits auto-fills the suggested levels, which the robot could read from the drawn pipe. Whether the advisor proposes anything for a 450 with no flow is not known. A 1 in 200 proposal is also flatter than 1 in 100, so it may open the Grade mismatch window. Too unsure to spend 3 runs on.
3. **LOGIC EVIDENCE (pure calculation), `Modules/Drainage.Tests/Rules/Bug1091RedesignReadsMinFallTests.cs`:**
   1. RowSetTo200_RedesignHolds450To1In200_AndAgreesWithTheEditPipeStrip.
   2. SwitchOff_RowSetTo200_GivesExactlyTheOldAnswer: switch off gives the old six-row list and a flatter answer, which is the before-fix behaviour.
   3. BlankRow_NothingChanges_NoMinimumFallSetForLargeSizes.
   4. CreateDefault_AndTheDefaultRedesignPath_ReadTheSameRow and SwitchOff_ThroughSettings_IsReadByTheDefaultPath.
4. **What a Codex look must see:**
   1. Settings: set the minimum fall for DN450 and larger to 1 in 200.
   2. CD a 450 between two pits with cover levels. The grade strip proposes no flatter than 1 in 200.
   3. With `pipe.largePipeRedesignReadsMinFall` false and a restart, the proposal is flatter.
   4. With a blank row, nothing changes.
5. **HEADLESS:** not applicable (no case).

## 4. #1945, BUG-1158: CDDESIGN warns once for outlets approved under another file path (head 7c31c33c), no robot case

1. **Why no case:**
   1. The warning needs approved Design outlets at the current schema, plus a recorded path that differs from the drawing's.
   2. The path is recorded only when outlets are approved after this PR (`Services/LpdService.cs` WriteApprovedPath, diff lines 247-276).
   3. Approving needs the CDLPD window, which is not on the robot's press lists, and the driver refuses Save As.
   4. Typed Lisp to write the record is blocked (the runner has no -AllowLisp; see `held_dmg_lisp_blocked`). A hand-written outlet approval would not be at the right schema anyway.
2. **Cheapest route to a robot case (a fixture job, not mine):**
   1. Tim or Codex approves outlets in CDLPD on a made-up drawing with b1 installed, saves it, and it becomes a fixture.
   2. Every robot session copy then sits under another path. CDDESIGN must show the warning exactly once, verbatim from `Rules/LpdSaveAsCopyRule.cs` lines 22-23: "[CE] Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder. ..."
   3. The twin sets `linking.lpdWarnsWhenOutletsApprovedInAnotherFile false`.
   4. Note: the warning is printed with an "[CE] " prefix before "Warning:" (CivilDesignCommand.cs hunk at 109-116).
3. **LOGIC EVIDENCE, `Bug1158SaveAsCopyWarningTests`:**
   1. ThePathRule_WarnsOnlyWhenBothPathsAreKnownAndDiffer.
   2. ANeverSavedDrawing_RecordsNoPath_NotEvenTheTemplateItWasStartedFrom.
   3. TheSource_WritesThePathBesideTheApproval_ReadsItInCddesign_AndNeverUnapproves.

## 5. #1970, BUG-1157: Edit Pipe says so when the level was not saved on the pipe (head b3e76c82), no robot case

1. **The trigger, found in the diff:** `LinkService.TryStorePipeInverts` (`Services/LinkService.Persistence.cs`, hunk at 244-312) returns false in four cases:
   1. No active drawing.
   2. A null pipe handle.
   3. The pipe is erased or is not a polyline.
   4. Any exception from reading the record, writing it or committing it.
2. **Why a locked layer is NOT a trigger:**
   1. `GetOrCreateLinkDictionary` returns nothing on a locked layer (SkipRecordWriteOnLockedLayer, Persistence.cs 1114).
   2. `WriteXrecordString` then returns quietly (line 1301), so the write counts as true and no line prints.
3. **What would trigger it:** a pipe whose CE record throws when read or written, which is the damaged record. SETUP-DMG-LINKS is held because the runner blocks typed Lisp. The PR's own REGRESSION_LOG item 9 says "a case the robot does not have yet".
4. **The words, for whoever writes it later:** "[CE] Warning: the level was not saved on pipe <id> itself. The schedule and plan show the new level, but if its level text is deleted CE will go back to the old one. Check the pipe and run Edit Pipe on it again." (`Rules/EditPipeLevelWriteRule.cs` lines 20-25.)
5. **LOGIC EVIDENCE, `Bug1157LevelWriteNotSavedTests`:**
   1. ALineIsPrintedOnlyForAWriteThatDidNotHappen_AndOnlyWithTheSwitchOn.
   2. TryStorePipeInverts_ReturnsFalseOnEveryFailurePath_AndTrueOnlyAfterTheCommit.
   3. EditPipe_SaysSoWhenTheWriteFailed_AfterTheScheduleWrite_AndNeverStopsTheSave.
   4. These are source guards plus the pure rule.

## 6. What I could not write, and faults noticed (names only, nothing edited)

1. **No case for #1868, #1945, #1970.** Reasons above.
2. **The plan text is wrong for two items in `C79B1_AREA_TEST_PLAN_01NOV.md`:**
   1. Item 2 (#1868) describes #1841's warning, not this PR's behaviour.
   2. Item 14 (#1970) offers "a locked layer" as a trigger, which the code shows it is not.
3. **#1972's REGRESSION_LOG and PR describe a locked label layer as refusing the save.** On this build a locked layer seems to be skipped and reported, not rolled back. This is unconfirmed and is the Codex look's job.
4. **`C:\CE_PLAN\areas\C79B1_FIXTURE_NOTE.md` did not exist yet.** The SETUP-DMG-* setups exist but are blocked on typed Lisp (`drafts_c79b1_01nov\held_dmg_lisp_blocked`).
5. **The W1246 and W658 routes copy P02 (unrun) and R11v87 (passed).** P02's DP placement comes from N04, which passed on 3.0.85.
