# Independent review: open PRs with no independent review yet, Sun 25 Oct 2026

Reviewer: Opus 5.5 lead plus five Opus reviewers, independent (none of us built these PRs). Desk plan/03, Team, read only. Method and standard as `REVIEW_PILOT_CRITICAL_B4B5_25OCT.md`.

- **Bases:** Civil and Manager `origin/claude/rel-20261025o` at `2c805a39` (Civil 3.0.75 / Manager 1.1.75). Structural `origin/claude/rel-20261024s` at `4af3f37d` (Structural 1.0.123).
- **Heads:** every head was read live from gh at 09:29. All 25 match what was reviewed, and all are still OPEN and draft.
- **Nothing was touched:** no PR was closed, retargeted, commented on or merged, and no branch was deleted.

## ANSWER FIRST

1. **How the 25 were chosen:**
   - **Open PRs listed:** 300. That is the newest 300 (#1479 to #1778) of the roughly 1,310 open PRs, per the job's `--limit 300`.
   - **Already inside a base:** 174 (151 in the Civil base, 23 in the Structural base), checked one by one with `git merge-base --is-ancestor`. This replaces the "50" estimate; the B4B5 review only looked at the 62 that touch its files.
   - **Already named in a review, a train list or a finalizer report:** 87.
   - **Never reviewed:** 39. I reviewed **25** here.
   - **Still to do (15), all docs-only:** the Codex batch audit PRs #1662, #1666, #1667, #1668, #1673, #1674, #1675, #1677, #1679, #1680, #1681, #1683, #1684, #1685 and #1686. They change no code; the 24 Oct triage already called them "class H, notes only".
   - **Not in my count:** #1702 and #1704 already have a Codex HOLD (CODEX_PR_REVIEW_GROUP09).
2. **Counts for the 25:** MERGE 13, MERGE-WITH-FIXES 7, HOLD 2, REJECT 3.
3. **MERGE candidates for the Civil and Manager update after C-66, ranked by value (live heads at 09:29):**
   1. **#1753** `0217714d`, BUG-1051 (HIGH, WRONG ANSWER): a slab fall is worked out in real units, so a flat slab in a metre drawing no longer passes. **Needs a fix first: add a switch.**
   2. **#1734** `7617ff57`, BUG-1040 (HIGH, daily tool CDPROPAGATE and the Edit Pipe cascade): keeping a hand-typed level warns and the rest of the cascade goes ahead. **Needs a fix first: one sentence.**
   3. **#1735** `45e9ddfe`, BUG-1043 (daily tool CD and Edit Pipe): a blank end level warns instead of stopping New Pipe and Edit Pipe. **Needs a fix first: one sentence.**
   4. **#1743** `7afad0d4`, BUG-1049 (daily tool CDEDIT batch): a ticked blank field is left out and Apply still writes the rest. **Needs fixes first: a keep-both clash and one test line.**
   5. **#1738** `81d1772c`, BUG-1047 (Manager, CE Blocks): places on a frozen layer and warns it will be hidden. **Needs fixes first: two tests and one sentence.**
   6. **#1759** `8044f6ae`, BUG-1055 (wording): CDPIPEOBJ says the right length in a metre drawing. MERGE as it is.
   7. **#1724** `c463d44b` and **#1725** `6a4790f9` (tests only): MERGE as they are.
   8. **#1723** `55f65b33` (tests only): **two test cases fail on today's base; fix the expected text first.**
4. **MERGE candidates for the Structural update after S-43:**
   1. **#1762** `f5cd0214`, BUG-1061/1062/1063 (WRONG ANSWER in the RCBEAM window).
   2. **#1746** `518741ee`, BUG-1048 (CEHATCHCHANGE).
   3. **#1749** `57c1b060`, BUG-1045, Structural half (CE_INSPECT on a read-only drawing).
   4. **Wording:** **#1745** `770759a2` (BUG-1073), **#1744** `65078082` (BUG-1072), **#1739** `8218fe1c` (BUG-1076), **#1740** `ebf480f3` (BUG-1077), **#1741** `0eef8a25` (BUG-1078) and **#1742** `6fb92d11` (BUG-1079).
   5. **Tests only:** **#1766** `d5f3c84d` (BUG-1069). Structural train only.
   6. **#1737** `4ae66b1b`, BUG-1041 (sheet title updates): **not until fixes 1 and 2 land.**
5. **Safe without Tim:** all 20 MERGE and MERGE-WITH-FIXES items, once their fixes land. None needs engineering judgement.
6. **Hold:**
   - **#1600 and #1602 (CEMEMBER editing):** these are new features built on an edit card Tim has never seen.
   - **Reject:** #1639, #1519 and #1571. All three are already on the base as #1635, #1520 and #1567 (checked: all three commits are ancestors of `2c805a39`).
7. **Tim's question (one):** the CEMEMBER edit card. See "Tim's question" below. Nothing else needs him.
8. **Tests I ran on combined trees** (Release, net10.0-windows, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, one run at a time under `C:\CE_PLAN\desk_jobs\build.lock`):
   - **Civil:** the base, the C-66 eleven, and #1734, #1735, #1743, #1753, #1759, #1723, #1724 and #1725. **340 of 342 pass.** The 2 failures are #1723's two Bug604 cases, exactly as reviewer B predicted from reading: the base now rounds a cover level to 2 decimals ("0.00", not "0.000").
   - **Manager:** the same tree plus #1738. **90 of 90 pass** (includes Bug1047 7, Bug842, CeBlocks, Bug1179 and DrawingRepair).
     - **My mistake first, cost about 2 minutes:** my first two Manager runs showed 5 failures. They were caused by my scratch log folder sitting outside Windows TEMP, then by its short name (`TIMOTH~1`). The Bug842 guard rightly refuses that. My third run used the long TEMP path and was clean.
   - **Structural:** S-43 plus all 13 Structural PRs. **159 of 159 pass.**
     - **Not run:** the CEMEMBER binding tests in Structural.DesignCore.Tests. They are on hold anyway.

## Checks I ran

1. **Containment:** all 300 heads were checked against both bases with `git merge-base --is-ancestor`, using a private shared clone at `C:\ce-rv\r` with every PR head fetched as `refs/pr/N`.
   - **Patch check:** `git cherry` against the base found none of the 25 patch-identical to a base commit.
2. **Already reviewed:** the PR number was searched (`#N`) in `areas\REVIEW_*.md`, `TRAIN_C6*_PR_LIST*.md`, the finalizer and assembly reports, and `CODEX_PR_REVIEW_*.md`.
   - **#1571 is the one exception:** it was only listed in a Codex group, with no verdict, so I reviewed it.
3. **Trial merges:**
   - **Civil on the base:** each Civil PR alone onto the base. Then the C-66 eleven merged together (the #1770 and #1772 keep-both clash in `UserSettings.cs`, as B4B5 said), and then each Civil PR onto that.
   - **Structural on the base:** each Structural PR alone onto S-43, then all 13 together.
   - **Clashes found:**
     1. **#1743** with the base in `Modules/Drainage/Models/UserSettings.cs`, after `EscKeepsPlacedCalloutLinks`. The base added five switches there. Keep both. I resolved it and the tree builds and passes.
     2. **#1746 + #1749** in Structural `UserSettings.cs` and `SettingsService.LoadRecovery.cs`. Both add a switch at the same spot. Keep both; the second block needs its own `/// <summary>` line.
     3. **#1744 + #1739** in `CeSettingsDialog.xaml`, on the same three tick lines. Take #1744's tick and grey line, and #1739's "Show save messages on the command line".
     4. **#1639, #1519 and #1571:** clash with the base on their own, because the base already carries a fuller fix.
     5. **#1766 onto the Civil base:** about 170 files. Its branch carries the Structural release line. A cherry-pick of its one commit applies, but its new guard would fail on the Civil tree. Structural train only.
   - **`REGRESSION_LOG.md`:** merges by itself, but reviewer E found the Structural entries (#1740, #1741, #1742, #1600) land mid-file, and the "5. Undo" lines of BUG-1077 and BUG-1078 were dropped. The train builder should hand-place those entries at the top.
   - **The C-66 eleven:** no new clash with any Civil PR here. None of them touches a Structural file.
4. **Protected files:** none of the 25 touches CE_SHARED / `Shared/`, the Installer, signing, deploy, version or PackageContents files.
   - **#1762** edits the Structural **test** project file, to link one source file. That is a test-only item and is safe (item 10).
5. **Live checks of reviewer claims (RULES 6.1):** I re-checked these myself.
   - **Duplicates:** #1635 `a5751512`, #1520 `7a3e0b53` and #1567 `14006793` are all ancestors of the base.
   - **#1734:** the sentence "The levels were written as they are and the rest of the cascade went ahead" is in the PR.
   - **#1737:** the base `CeSheetsManifestService.Save` sets `LastScannedUtc = DateTime.UtcNow` (fix 2).
   - **#1753:** the base `SlabService.ComputeFallForTriangle` multiplies the level by 1000 against drawing-unit X and Y.
   - **#1738:** the base CE Blocks line says "is locked or frozen" at lines 60 and 158.
   - **Test counts:** Bug1047 7, Bd05 10 and Bug1048 6 are confirmed.
6. **Free space:** C: had 17 GB free at the start and 16 GB during the builds (stop line 12 GB).

## One item per PR

### Civil and Manager (base `2c805a39`)

1. **#1753 BUG-1051 (HIGH, WRONG ANSWER): slab fall worked out in physical units. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Cause is real:**
     - **Where:** `SlabService.cs` lines 144 and 145 (base) turn the level difference into millimetres (×1000) but leave X and Y in drawing units.
     - **On a job:** in a metre drawing the fall reads 1000 times too flat, so a flat slab passes.
   - **The fix:**
     - **The sum:** `ComputeFallForTriangle` scales the level through the existing `DrawingAreaUnits.DrawingUnitsToMillimetres`. Millimetre and unitless drawings are unchanged.
     - **Callers:** all five callers pass the drawing's units (CDSLAB arrows, CDSLABEREGEN, slab edit, the flow plan, the Link audit). Reviewer A grepped the head: none is left on the default.
   - **Fix needed (switch rule):** this changes an engineering answer with no switch.
     - **Why it matters:** in a drawing whose units say metres but which is really drawn in millimetres (the mixed-units case CE already finds for pits, BUG-287), the new reading is 1000 times too steep, and a slab has no pit size to cross-check.
     - **The change:** add `surfaceDrainage.slabFallUsesDrawingUnits`, default ON. With it OFF, `ComputeFallForTriangle` reads millimetres.
     - **Tests to add:** new object ON, old file `{}` ON, and OFF gives the old answer. The precedent is the metre-drawing switch at base `UserSettings.cs` line ~2441.
   - **Tests:** 5 cases. They pass on the combined tree (my run). RED is by compile only (a new parameter).
     - **Missing:** no guard that the callers pass the units. Worth one source guard.
   - **Redo, locked layers:** arrows are still placed inside the command. No new write.
   - **Limits:** not run in AutoCAD on a metre copy and its millimetre twin.

2. **#1734 BUG-1040 (HIGH, daily tool): keeping a hand-typed level no longer refuses the whole cascade. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Cause is real:**
     - **The block:** `PropagationPlan.cs` line 163 has `CanApply => Errors.Count == 0 && !HasBlockingFlatGrade`.
     - **The second refusal:** `ApplyPropagationPlan` refuses again with `FlatWhenWrittenRefusal`.
     - **Untouched since:** base changes since the PR branched (BUG-811, 796, 944) do not touch either refusal.
   - **The fix:** with switch `linking.flatPipeIsWarningNotBlock` ON, a flat or back-falling row is a warning and is named on the command line.
     - **What still holds:** the same writes happen and no fall is invented. Real plan errors still block.
     - **Covers both commands:** CDPROPAGATE and the Edit Pipe cascade share this one writer.
   - **Fix needed (wording):**
     - **Where:** `LinkService.RepairAudit.InvertPropagation.cs`, `FlatPipeWarning`.
     - **The problem:** the line is said before the write. If every pipe is then refused (a locked layer), the drafter reads "The levels were written as they are and the rest of the cascade went ahead" and then "Nothing was changed".
     - **The change:** say "Its levels are kept as they are and the rest of the cascade goes ahead - check that pipe's levels." Update `TheWarningLine_NamesThePipe_AndSaysTheCascadeWentAhead` to match.
   - **Tests:** 9 new cases, plus four older tests now set the switch OFF. The PR's "four" is right; the batch report's "three" is wrong (cosmetic).
     - **Switch tests:** new object, old file and OFF.
     - **My run:** pass on the combined tree.
     - **Writer:** proven by a source guard only.
   - **Redo, locked layers:** no new write. The BUG-797 locked-layer refusal is unchanged.
   - **Wording:** the lines start "[CDPROPAGATE]" or "[CDEDIT-CASCADE]", the writer's existing prefix. Accepted.
   - **Overlaps:** #1643 (BUG-982) touches the same writer and already clashes with the base. Whoever rebases it must keep #1734's warning path.

3. **#1735 BUG-1043 (daily tool): New Pipe and Edit Pipe go on when an end level is blank. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Cause is real:** `Rules/PipeStartReadiness.cs` lines 163 and 167 still stop with "Enter the invert level for the first / second end".
   - **The fix:** the readiness rule only, plus one line passing the switch `pipe.blankInvertIsWarningNotBlock` (ON).
     - **CD:** a blank end is written as level not known, never 0.00.
     - **CDEDIT:** an emptied box clears the level (Tim's BLANK-01 ruling).
   - **Fix needed (wording):**
     - **The sentence:** `DescribeBlankInverts` says the end "stays Unknown".
     - **Why it is untrue:** in CDEDIT, emptying a box that held a level clears it on Save, which this PR newly makes reachable.
     - **The change:** say "...is blank: it is saved blank (Unknown) and no fall or grade is worked out." in all three sentences, and update the test.
   - **Tests:** 9 new cases (switch new, old and OFF). They pass on the combined tree. RED is by compile only.
   - **Limits:**
     - **Grade label:** in Default grade mode with one level blank, the label still prints the default "1 IN 100 MIN." That is existing policy, not new.
     - **AutoCAD:** not run there.

4. **#1743 BUG-1049 (daily tool): the CDEDIT batch leaves a ticked blank field out and applies the rest. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Cause is real:** `CeBatchEditViewModel.cs` lines 284 to 286 grey Apply for one blank ticked field.
   - **The fix:** only the Apply gate changes.
     - **No new write path:** `BuildPlan()` already wrote only fields with values, so a blank was never written.
     - **All blank:** if every ticked field is blank, Apply stays grey, which is right.
   - **Fixes needed:**
     1. **The clash:** keep both sides of the `UserSettings.cs` clash (see Checks item 3). Done and tested in my tree.
     2. **Old-file switch test:** add `Assert.That(SettingsService.DeserializeSettings("{}").Linking.BatchBlankFieldIsLeftOut, Is.True);` to `TheSwitchDefaultsOn_ViewModelAndSettings`.
   - **Tests:** 8 new cases. They pass on the combined tree.
   - **Wording:** "Not changed — left blank, so it keeps its current value." Plain.
   - **Limits:** the pit batch window was not looked at.

5. **#1738 BUG-1047 (Manager, CE Blocks): places on a frozen layer and warns it will be hidden. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed (Manager version bump).**
   - **Cause is real:** `CeBlocksInsertService.ProtectedLayer` (line 255) treats frozen like locked, so both the Insert and PlaceOne paths refuse.
   - **The fix:** one rule, `CeBlocksLayerGate.Decide`.
     - **Locked:** still refuses.
     - **Frozen:** warns and places. CE never thaws or unlocks the layer.
     - **The switch:** `FrozenLayerWarnsAndPlaces` in `ce-blocks-settings.xml`, ON.
   - **Fixes needed:**
     1. **Two tests in `Bug1047FrozenLayerTests.cs`**, on the redirected settings file (the `Bug842CeBlocksSettingsFileTests` pattern): an old file without the element loads ON, and a saved OFF reads back OFF.
     2. **Wording:** with the switch ON, the refusal at lines 60 and 158 can only mean locked but still says "locked or frozen", and has no "[CE]".
        - **Switch ON:** say "[CE] Layer X is locked. No block was placed."
        - **Switch OFF:** keep the old text.
   - **Tests:** 7 cases. They pass in my Manager run (90 of 90).
   - **New line:** "[CE] The layer is frozen, so the block will be hidden until you thaw it. CE has not thawed it." Plain.

6. **#1759 BUG-1055 (wording): CDPIPEOBJ says the length in metres in a metre drawing. Verdict MERGE. Safe without Tim.**
   - **Cause is real:** `NativePipeObjectCommands.cs` line 110 divides by 1000 whatever the drawing units.
   - **The fix:** the line goes through `DrawingUnitsToMillimetres`. Only the message changes.
   - **Tests:** 5 cases. They pass on the combined tree.
   - **Limit:** proving it needs AutoCAD 2027 with the pipe object add-on on a metre drawing.

7. **#1724 BD06 (tests only): BUG-800, 825 and 839. Verdict MERGE. Safe without Tim.**
   - **What they pin:** nine cases pin base behaviour, against the "CouldNotCheck" line, the old-starting-values flag and changed-values-only saving.
   - **Before the fix:** they fail on the fix parents with a wrong answer, not just a compile error (by reading).
   - **My run:** pass.
   - **For the desk:** the PR notes a separate finding (BUG-802/875: a cover change does not change the warning fingerprint). If it is not carparked, carpark it.

8. **#1725 BD07 (tests only): BUG-773 raingarden centre and BUG-967 Blue Factor reader. Verdict MERGE. Safe without Tim.**
   - **What they pin:** four cases; the arithmetic was checked by hand (L-shape centre 2200,2200; pervious 500 m2).
   - **My run:** pass.
   - **Live settings file:** the PR reports a short change to the live `CD_Settings.json` hash during its own run, writer unproved. Nothing in this diff writes there.

9. **#1723 BD05 (tests only): BUG-703, 704, 783 and 604. Verdict MERGE-WITH-FIXES. Safe without Tim once fixed.**
   - **Fails today:** the two Bug604 cases fail on today's base (my run: "cover level 0.00 m", expected "0.000"). BUG-729 later rounded LandXML cover levels to the Settings decimals.
   - **The fix:** in `Bd05ScheduleImportSurveyRegressionTests.cs`, use `[TestCase("0.000", "0.00")]` and `[TestCase("-0.350", "-0.35")]`. Feed the first value in the file and look for the second in the text.
   - **Log entry:** replace the PR's "BLOCKED validation" log line with the real result.
   - **The other 8 cases:** pass.

10. **#1639 BUG-1032 (CDTWL wording). Verdict REJECT: already on the base as #1635 (`a5751512`).**
    - **What #1639 adds:** pit-first pipe names and "level with the lowest lid". Both are polish, and the PR clashes in both product files.
    - **If wanted:** make a fresh small PR on top.
    - **For the desk:** the carpark still shows BUG-1032 OPEN with no PR named.

11. **#1519 BUG-859 (downpipe double-click). Verdict REJECT: already on the base as #1520 (`7a3e0b53`), with rounds 2 and 3 on the base too.**
    - **The one extra idea:** read a resized dynamic downpipe's real block name, not `*U12`. That would make its own one-line PR or carpark line.
    - **For the desk:** the carpark text "round 2 PR #1522 not installed" is stale.

12. **#1571 BUG-963 (CDPROPAGATE single level). Verdict REJECT: already on the base as #1567 (`14006793`).**
    - **Why the base is better:** it reads the text's recorded end. #1571 guesses from distance, so a text dragged past mid-pipe would get the wrong level.

### Structural (base `4af3f37d`)

13. **#1762 BUG-1061/1062/1063 (WRONG ANSWER in the RCBEAM window). Verdict MERGE. Safe without Tim.**
    - **Cause is real:** the window checked depth against the full D, hid every width warning at zero room, and spaced bottom bars differently from the writer.
    - **The fix:** one shared helper, `RcBeamBarRoom`.
      - **Writer:** its numbers are unchanged, so placed sections do not change.
      - **Window:** reads the same helper.
    - **Tests:** 17 cases. They pass in my Structural run.
    - **The test project edit:** links `RcBeamBarRoom.cs` into the test project, the same pattern as about 40 other linked sources. It is needed because the test project compiles its own copy of the dialog. It ships nothing.
    - **Window picture:** the Type 7 preview picture will change and has not been looked at.

14. **#1746 BUG-1048 (CEHATCHCHANGE): changes the hatches it can and names the one it cannot clear. Verdict MERGE. Safe without Tim.**
    - **Cause is real:** one hatch with a coloured background refused the whole selection.
    - **The fix:** the split happens before the Undo group, and one U undoes what changed.
    - **Switch:** `Options.HatchChangeSkipsRefusedAndChangesTheRest`, ON.
    - **Tests:** 6 new cases plus 1 edited. They pass.
    - **New line:** "[CE] 1 hatch was left unchanged (handle 2F3) ... One U undoes the hatches that were changed." Plain.
    - **Train note:** keep-both with #1749.

15. **#1749 BUG-1045, Structural half (CE_INSPECT on a read-only drawing). Verdict MERGE. Safe without Tim.**
    - **Cause and fix:** CE_INSPECT only reads, so a new pre-flight skips only the read-only refusal.
    - **Switch:** `Options.InspectRunsOnReadOnlyDrawing`, ON.
    - **Tests:** 4. They pass.
    - **Follow-up worth a carpark line:** in a read-only folder, the .json write fails with a raw "Access to the path ... is denied". Fall back to the Desktop with one "[CE]" line.
    - **Keep BUG-1045 open:** the Civil half (CDDIAG, CDDASHBOARD, CDPARTS) is not covered.

16. **#1745 BUG-1073 (wording): a damaged saved markup review says "[CE] CE could not read this saved markup review. Choose another saved copy." Verdict MERGE. Safe without Tim.**
    - **Tests:** 5. They pass.

17. **#1744 BUG-1072 (wording): the backup tick says "Also keep backup copies of Civil-only drawings", not "autosave". Verdict MERGE. Safe without Tim.**
    - **Tests:** 2. They fail on the base text and pass after.
    - **Train note:** take #1744's lines in the #1739 clash.

18. **#1739 BUG-1076 (wording): the Structural Settings fault-report choices are in plain words. Verdict MERGE. Safe without Tim.**
    - **Tests:** 6. They fail on the base text and pass after.
    - **Optional:** "Record fault and speed information" sits under "Record detailed troubleshooting", which a drafter may not tell apart.

19. **#1740 BUG-1077 (wording): the BSET hover and Help say why the inside point matters. Verdict MERGE. Safe without Tim.**
    - **Tests:** 6. They pass. Every sentence was checked against the code.

20. **#1741 BUG-1078 (wording): the markup tools' Help is in drawing words. Verdict MERGE. Safe without Tim.**
    - **Tests:** 26 cases. They pass.
    - **Optional follow-up:** the same Help pages' layer lines still say "CEMARKUP package state" and "batch actions".

21. **#1742 BUG-1079 (wording): the PDF export Help drops the untrue "runs in the background". Verdict MERGE. Safe without Tim.**
    - **Tests:** 6. They pass.
    - **Two pre-existing faults, worth carpark lines:**
      - **Cancel:** the plot window's Cancel button is set but never read.
      - **Raw error:** "Another plot is already in progress." reaches the drafter as AutoCAD's error, not a "[CE]" line.

22. **#1766 BUG-1069 (tests only): the drawing-close guards read the real Structural file instead of quietly skipping. Verdict MERGE on the Structural train only. Safe without Tim.**
    - **Tests:** 3. They pass on S-43.
    - **Do not carry it onto the Civil train:** the Civil line's copy of `FoundationMonitor.cs` is older, so the guard would fail there.

23. **#1737 BUG-1041 (daily tool, sheet title updates): one out-of-date drawing no longer stops every update. Verdict MERGE-WITH-FIXES. NOT for the next train until fixes 1 and 2 land.**
    - **Cause is real:** `BuildSyncBlockers` turns any drawing saved after the scan into a whole-project block.
    - **The fix:** leaves out only that drawing.
    - **Switch:** `ceSheets.SyncSkipsOnlyAffectedDrawings`, ON.
    - **Fix 1 (required): support and Xref drawings are said to be "left out" but are still written.**
      - **Why:** a register or shared-title drawing saved after the scan is named as left out, yet the support loop and `SyncSharedTitleXrefs` never check `IsLeftOut`, so CE writes it anyway.
      - **The change:** in `BuildSyncScope`, leave out only sheet drawings. For any other newer drawing, keep the old block (`BuildStaleReason`).
    - **Fix 2 (required): the leave-out is forgotten after the first sync.**
      - **Why:** `SyncManifest` ends with `Save`, and `Save` sets `LastScannedUtc` to now (checked). The next sync then writes the left-out drawing without a rescan.
      - **The change:** before that save, record each left-out drawing in `LastScanDiagnostics.SkippedDrawings` with `Kind = "SavedAfterScan"`.
    - **Fix 3 (should): keep the duplicate-sheet-number check as a block.** It was dropped without a word, and the Sheet No column is editable.
    - **Fix 4 (should): add the old-settings-file switch test.**
    - **Tests:** 8. They pass, but none covers fixes 1 to 3.

24. **#1600 CEMEMBER slice (i): save the member's choices on its lines. Verdict HOLD.**
    - **Not a bug fix:** it is the first step of CEMEMBER editing.
    - **Not approved:** Tim approved the CEMEMBER card on 19 Oct and "build now" on 20 Oct, but that card has no editing. The edit card (`release-v3-colleagues-CEMEMBER_EDIT_CARD_DRAFT_2026-10-21.md`) is marked DRAFT, "Tim has not seen it". The AGENTS.md review gate needs his approval before code.
    - **The design reads sound:** one U, it writes only its own lines, it warns and never blocks, and it refuses a copy rather than guessing.
    - **To unblock it:** Tim's answer below, then an AutoCAD pass of draw, save, reopen, record still readable.

25. **#1602 CEMEMBER slice (j): SBEAMEDIT edits a CEMEMBER member (stacked on #1600). Verdict HOLD.**
    - **Why hold:** the same gate as #1600, and it changes the existing SBEAMEDIT command.
    - **Fix before any merge: after a COPY, the original cannot be edited either.**
      - **Why:** the member is found by its id across the whole space, so the copy's lines are counted too.
      - **The change:** in `CeMemberEditCommand.Edit`, keep only lines whose saved handle matches their real handle before `TryReadMember`.
    - **Also owed:**
      - **A switch of its own:** with `SaveEditRecord` OFF, SBEAMEDIT still takes over tagged members.
      - **SBEAMEDIT Help:** still describes SBEAM compounds only.
      - **Wording:** the new lines start "CEMEMBER:", not "[CE]".

## Tim's question (one)

1. **CEMEMBER editing (#1600 and #1602): how should a drawn CEMEMBER member be edited?** Context: you approved drawing CEMEMBER members; the editing card was drafted on 21 Oct and you have not seen it.
   - **What is built:** pick a CEMEMBER line in SBEAMEDIT, change the choices, and it redraws in place with one U.
   - **Recommendation: yes, edit through SBEAMEDIT, as built.** One edit command for every beam a drafter picks.
   - **Three sub-points, with my recommendations:**
     - **A member drawn before records existed:** say "draw it again". Never guess its choices.
     - **A copied member:** refuse to edit the copy and keep the original editable (needs the #1602 fix above).
     - **A moved member:** ask Yes or No first, default No, as built.
   - **On a job:** a drafter picks a 200UB beam drawn last week, changes it to 250UB, and it redraws in the same place. If they copied it first, CE says the copy cannot be edited and to draw it again.

## Train notes

1. **Civil and Manager train after C-66:** #1753, #1734, #1735, #1743 and #1738 after their fixes; #1759, #1724 and #1725 as they are; #1723 after its test fix.
   - **Clashes:** keep both in `UserSettings.cs` for #1743. `REGRESSION_LOG.md` keeps both sides each time.
   - **Manager:** #1738 changes Manager code, so the Manager version needs its bump.
   - **New-switch defaults test:** pin ON `linking.flatPipeIsWarningNotBlock`, `pipe.blankInvertIsWarningNotBlock`, `linking.batchBlankFieldIsLeftOut`, the #1753 switch once added, and CE Blocks `FrozenLayerWarnsAndPlaces`.
2. **Structural train after S-43:** #1762, #1746, #1749, #1745, #1744, #1739, #1740, #1741, #1742 and #1766; #1737 after fixes 1 and 2.
   - **Keep-both:** #1746 with #1749.
   - **Dialog lines:** #1744 with #1739.
   - **Log entries:** hand-place the Structural `REGRESSION_LOG.md` entries at the top.
3. **Settings page:** none of the new switches has a Settings page row (the R-00 home is still owed, window lane).

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing was opened in AutoCAD. Built and unit-tested only. Nobody has seen any of these 25 work in AutoCAD.
2. **Full suites and net48:** only focused classes were run (342 Civil, 90 Manager, 159 Structural). The full suites and net48 were not run. The builders of #1734 and #1735 did not compile net48 either.
3. **RED:** by reading only. Most new tests "fail on the base" only because they do not compile there. No deliberately broken variant was run.
4. **Scope:**
   - **Older PRs:** only the newest 300 of about 1,310 open PRs were in scope. Older unreviewed PRs (below #1479) were not looked at.
   - **Clashes with other open PRs:** checked by text clash, not by meaning, and only against the C-66 eleven and the PRs touching the same files.
5. **Not looked at:**
   - **Windows:** the window pictures (#1762 preview, Settings pages, the pit batch window) were not viewed.
   - **The 15 docs-only audits:** not reviewed.
6. **Housekeeping:**
   - **My scratch:** `C:\ce-rv` (private clone, worktrees, test runs) is removed at the end of this job.
   - **The build lock:** `C:\CE_PLAN\desk_jobs\build.lock` was created by my lock call and is removed again if nobody holds it.
   - **The main checkout:** it has untracked items that are not mine (`.codex/`, `tmp/`, a TEAMLANE4 log, `BracingLengthSettingsTests.cs` and an oddly named folder). I did not touch them.
