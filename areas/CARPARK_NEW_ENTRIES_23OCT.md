# New carpark entries from the 23 Oct findings ledger (BUG-873 to BUG-1029)

For the desk to append to `C:\CE_PLAN\BUG_CARPARK.md`, in this order, then set the "Next BUG ID" line to **BUG-1030**. One entry per NEW, real, HIGH or MEDIUM finding in `areas/FINDINGS_LEDGER_22OCT.md` (ledger order, F-001 upward). Template as at the top of BUG_CARPARK.md. Compiled 23 Oct 2026 (Melbourne); nothing here is built, tested or accepted unless the Status says so. The first ledger's draft numbers BUG-873 to BUG-972 are void.

## Status notes for existing entries (apply by hand; do not append)

1. **BUG-788:** reopen. CODEX_SWEEP_S05 S05-01 (ledger F-154, Opus check VERIFIED): `PitScheduleXrefDiscoveryService.cs:394-398` returns the first Xref's record for any later Xref with the same FingerprintGuid, so the installed fix (#1404, core only) never sees a SAVEAS copy's different data. Fix the adapter, not the core.
2. **BUG-725 / FB-17:** add CODEX_SWEEP_S11 S11-02 (F-171) as a second report of the millimetre LandXML x1000 scale (`LandXmlParser.cs:189, 459`).
3. **BUG-802:** add ledger F-005 (BUG-875) as the same root (the ignore fingerprint holds only the pipe); fix together.
4. **BUG-834:** its installed fix leaves the empty or stale `--approved-version=` bypass and the silent unknown approval (F-020, BUG-886).
5. **BUG-008:** F-229 (BUG-1023) proposes removing its 90 per cent sort-map rule; if Tim agrees, BUG-008 must be re-tested.
6. **BUG-867, BUG-869:** add the second reports CODEX_SWEEP_S08 S08-01 (to BUG-867) and note #1530 / #1531 are MERGE-WITH-FIXES in REVIEW_CODEX_PRS_B.
7. **AUDIT-XCLMTXT-DECIMALS:** add CODEX_SWEEP_S14 S14-03 (rated HIGH there; the saved schedule record and the drawing text also disagree; #1533 fixes both).
8. **HUNT_DATALOSS_SILENT DS-06** (CDJOINT erases before the last question) was never given a number: it is now BUG-979 (F-169).

---

## BUG-873

**Command / Area:** CDTIDYLABELS (Tidy labels), ledger F-003.

**Symptom:** Tidy labels takes the writing start-up (it marks the drawing active and can save the CE project record) before its switch, selection, preview and Yes/No. Answering No or pressing Esc can still leave the drawing changed. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** A cancelled or preview-only Tidy labels run writes nothing to the drawing.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 1; `Commands/TidyLabelsCommand.cs:35`, `Commands/CeCommandBase.cs:29,43`. Related BUG-863. Opus check: real, but the write is the active-drawing marker and a first-command record save, no label moves. Re-checked at the installed commit 23 Oct. Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-874

**Command / Area:** CD (Esc after a pipe with a callout), ledger F-004.

**Symptom:** After a successful pipe with a callout label, pressing Esc for the next pipe throws away the callout's deferred link record. The pipe and callout stay but are not linked, so erasing the pipe leaves the label behind or moving the pipe leaves the arrow at the old spot. HIGH.

**Expected behaviour:** The link is written for every item placed before the Esc.

**Reference:** CODEX_HUNT_UNDO_22OCT.md U-01; `Services/LinkService.Reactors.cs:1420,1542,1557`, `Commands/CdCommand.cs:214,235,1196`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-875

**Command / Area:** CDCHECKIGNORE fingerprint, ledger F-005.

**Symptom:** An ignored warning stays hidden after the design changes: the remembered fingerprint omits the pit, the clearances and the actual and required layer. MEDIUM (first rated HIGH; checked 23 Oct) (switch OFF today).

**Expected behaviour:** Any change to an input the finding depends on brings the row back as "Asked again".

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 2; `Services/Checks/IgnoredChecks.cs:198-263`, `ChecksResult.cs:228-296`. Opus check: real; switch OFF by default; same root as BUG-802 (fix together). Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-876

**Command / Area:** CDIMPORTXCIVIL and CDIMPORTLANDXML, Replace, ledger F-009.

**Symptom:** Replace deletes the old imported pit before checking that the replacement can be drawn. If the new pit needs a locked layer (for example 25TEXT for a new cover level) the old pit is gone and nothing replaces it. HIGH.

**Expected behaviour:** Old items whose replacement cannot be drawn are kept and a warning says so; the rest import.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 1; `Services/XcivilImportService.cs:1921,1950`. Related BUG-731, BUG-417. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-877

**Command / Area:** CDIMPORTLANDXML and CDIMPORTXCIVIL review window, ledger F-010.

**Symptom:** Choosing a different source on the review page and clicking Read source imports the previously read file. HIGH.

**Expected behaviour:** A source change starts a fresh read; acceptance is bound to the file that was reviewed.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 2; `Commands/LinkCommands.ImportXcivil.cs:73,164-179`, `ViewModels/CivilImportWindowViewModel.cs:53,60`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-878

**Command / Area:** CDIMPORTLANDXML named inverts, ledger F-011.

**Symptom:** With one level and one end, the single-level shortcut assigns the level to a pipe even when the file names it for another pipe (pipe B gets 9.75 m that belongs to A). HIGH.

**Expected behaviour:** An explicit mismatching pipe name outranks the shortcut; the level stays Unknown.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 3; `Helpers/LandXmlParser.cs:260,277,328`. Related BUG-605. Opus check: verified; live mainly for startRef files until FB-16 lands, then for every real file. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-879

**Command / Area:** CDTIDYLABELS hand-placement, ledger F-012.

**Symptom:** With "hand-placed labels stay" ON, a label moved with CE's own Slide along pipe or CDANNOTATIONEDIT is not marked hand-placed, and a hand-moved pit cover text is ignored, so Tidy labels moves them again. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** Any CE hand move marks the label as hand-placed.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F1; `Services/LinkService.PipeAttachmentActions.cs:323-352`, `Services/LinkService.TidyPitText.cs:87,100`. Opus check: real; needs two default-OFF switches. Re-checked at the installed commit 23 Oct. Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-880

**Command / Area:** CEMEMBER in a metre drawing, ledger F-014.

**Symptom:** CEMEMBER uses millimetre section sizes as drawing units, so in a metre drawing a 310UB32 section comes out 298 m deep; break overshoot and kink are wrong the same way. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** Sizes are converted by the drawing units, or a plain warning says the drawing is not in millimetres.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F2, OPUS-A finding 9; `Commands/CeMemberCommands.cs:79,128,191`. Opus check: real; metre Structural drawings are rare and a 1000x member is obvious. Re-checked at the installed commit 23 Oct. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-881

**Command / Area:** CEHATCHAUDIT Repair with an unusable DIMSCALE / LTSCALE pair, ledger F-015.

**Symptom:** Placement refuses a mismatched DIMSCALE/LTSCALE pair, but the audit substitutes the old 1:20 value and repairs a correct new hatch back to it (LBUH 50 becomes 20). HIGH.

**Expected behaviour:** An unusable scale pair is reported as unknown and never authorises a repair.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F4; `Commands/HatchUpgradeCommands.cs:343,380,413,576`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-882

**Command / Area:** CE installer, Windows administrator rights, ledger F-016.

**Symptom:** The installer requests elevation, so a colleague without administrator rights cannot start it. HIGH (release blocker for self-install; the 9 Nov pilot uses a hand install).

**Expected behaviour:** A first install into the colleague's own folder works without Windows administrator rights.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 1; `Installer/app.manifest:7`. Related BUG-483. Opus check: verified (requireAdministrator). Gap plan: hand install for 9 Nov. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-883

**Command / Area:** CE installer, no first-install route, ledger F-017.

**Symptom:** Running the installer with no arguments exits with usage (64); `--install` and `--update` are retired and the embedded ZIP code is switched off. A PC with no Manager has no way to start. HIGH (release blocker for self-install).

**Expected behaviour:** A documented first-install route that needs no developer command knowledge.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 2; `Installer/Program.cs:13,21`, `CeInstallerApplication.cs:77-253`. Opus check: verified (exit 64, payload extraction inside #if false). Gap plan: hand install. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-884

**Command / Area:** Manager approved releases, absolute paths, ledger F-018.

**Symptom:** `approved.json` stores the approving PC's absolute folder paths; another colleague's PC then refuses the same files as outside the allowed office folder. Rollback paths have the same fault. HIGH.

**Expected behaviour:** Approvals resolve to the current user's office root, with every approved hash unchanged.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 3; `Modules/Manager/Services/CeApprovedReleaseService.cs:46,107,108,122,751,761`. Opus check: verified. Gap plan: after 9 Nov. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-885

**Command / Area:** Installer packaging (build_installer.ps1), ledger F-019.

**Symptom:** The script rebuilds all lanes and the native files and zips the new tree, instead of sealing the accepted candidate. The delivered files can differ from the tested ones (the "payload 85" fault). MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** Packaging takes the frozen candidate folder and refuses any file whose hash differs. No rebuild after acceptance.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 4; `Installer/build_installer.ps1:185-332`, `ReleaseAuthorityPackaging.cs:379,397`. Opus check PARTLY: the EXE never unpacks that payload; the live risk is a hand install copying the script's freshly rebuilt bundle. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-886

**Command / Area:** CE installer `--activate-staged` (release branch), ledger F-020. Residual of BUG-834.

**Symptom:** Whoever runs the installer can add a blank or old `--approved-version=` and an out-of-date signed build installs anyway; on a PC whose office approval file has not synced, an older build installs with no warning at all. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** An empty or older-than-approved flag is refused the same as no flag; when the office approval cannot be read the installer warns plainly that it could not check (R-27: warn, not block).

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 5; `Installer/CeOfficeApproval.cs:21-33, 57-88`, `Installer/CeInstallerApplication.cs:279-289`, `Installer/SafeBundleInstaller.cs:268-271, 803-823`. Opus check 23 Oct: VERIFIED; PR #1492 does not close it (already in the release). Test: approved.json 3.0.70, signed stage 3.0.69: run with no flag, with `--approved-version=` and with `--approved-version=3.0.68`: all three refuse; with approved.json removed the message contains a 'could not check the office approval' warning. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-887

**Command / Area:** Civil and Manager separate activation, shared file, ledger F-021.

**Symptom:** Civil can be activated alone while an older Manager remains, leaving two different copies of CE_SHARED; the ribbon or commands can fail depending on load order. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** Incompatible pairing is refused, or the pair is completed or recovered before restart.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 6; `Installer/SafeBundleInstaller.cs:252,281,442`. Opus check: real; only when one half is activated by hand. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-888

**Command / Area:** Installer interruption and uninstall, ledger F-024.

**Symptom:** If the installer is killed after the old folder is retired and before the new one is placed, CE can be missing on restart, and a colleague has no uninstall or restore command. MEDIUM (first rated HIGH; checked 23 Oct).

**Expected behaviour:** A tested recovery route restores a complete pair, and a documented uninstall exists.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 10; `Installer/SafeBundleInstaller.cs:314-351`. Opus check: real; recoverable by hand from the .retiring folder or the roll-back copy. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-889

**Command / Area:** CDCHECKIGNORE, "Asked again" rows, ledger F-029.

**Symptom:** A finding that returns as "Asked again" is not offered by CDCHECKIGNORE Ignore; the drafter must first Un-ignore the old entry. MEDIUM (switch OFF).

**Expected behaviour:** Ignore offers every row not still hidden after the fingerprint check.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 3; `Services/Checks/IgnoreFindingPicker.cs:18-27`. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-890

**Command / Area:** CDTIDYLABELS leader-out planning, ledger F-030.

**Symptom:** Leader-out planning reserves room using a plain label that will not move, so a callout can be moved onto that label while CE reports a clear spot. MEDIUM (switch OFF).

**Expected behaviour:** The final applied set never overlaps a label that stays.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 4; `Services/LinkService.TextClashTidyUp.cs:426-437`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-891

**Command / Area:** CDTIDYLABELS obstacle space and search margin, ledger F-031.

**Symptom:** A layout pipe's labels are checked against model-space text, and the search margin does not grow with the leader-out distance. MEDIUM (switch OFF).

**Expected behaviour:** The scan uses the pipe's own space and covers every destination.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 5; `Commands/TidyLabelsCommand.cs:169-176`, `Services/LinkService.TextClashTidyUp.cs:28,425,579-747`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-892

**Command / Area:** Inspector problem counts (Flat / backfall pipes and similar), ledger F-032.

**Symptom:** Clicking a count takes a write lock and a normal transaction even when the list is empty, which can use up the next U or lose a REDO. MEDIUM.

**Expected behaviour:** An empty lookup does nothing to the drawing history.

**Reference:** CODEX_HUNT_UNDO_22OCT.md U-02; `Services/InspectorPaletteService.cs:2752-2796`. Related BUG-861. Opus check: code path verified; the REDO loss itself is not yet seen in AutoCAD. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-893

**Command / Area:** CDTIDYLABELS preview versus Apply, ledger F-034.

**Symptom:** The preview does not reserve earlier pipes' proposed moves, so Apply makes a different plan ("Will move 2", then 1 moves). MEDIUM (switch OFF).

**Expected behaviour:** The applied plan equals the accepted preview.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F2; `Commands/TidyLabelsCommand.cs:55-85`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-894

**Command / Area:** CDTIDYLABELS pit cover text, ledger F-035.

**Symptom:** The preview checks a translated rectangle but Apply also changes rotation and anchor, so the text can land on another note. MEDIUM (switch OFF).

**Expected behaviour:** The footprint checked is the footprint written.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F3; `Services/LinkService.TidyPitText.cs:84-120`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-895

**Command / Area:** CDTIDYLABELS on a layout sheet, cover text, ledger F-036.

**Symptom:** A layout cover text is counted as moved although its writer always refuses it; the reason is only in the CE log. MEDIUM (switch OFF).

**Expected behaviour:** "Moved" counts real moves and a plain line says what was left.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F4; `Services/LinkService.TidyPitText.cs:39-116`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-896

**Command / Area:** CDTIDYLABELS in a crowded drawing, ledger F-037.

**Symptom:** At 1,001 nearby text objects Tidy labels abandons the pipe, says CE could not read it, and can end with "No CE label needs to move". MEDIUM (switch OFF).

**Expected behaviour:** A bounded-work explanation and valid work continues.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F5; `Services/LinkService.TextClashTidyUp.cs:33,197-203`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-897

**Command / Area:** CDTIDYLABELS slide step Setting, ledger F-038.

**Symptom:** A very small positive Label slide step (for example 0.001) makes Tidy labels enumerate hundreds of thousands of candidates before the preview. MEDIUM (switch OFF).

**Expected behaviour:** A work budget with an explicit outcome, no hard block.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F6; `Rules/LabelPlacementRule.cs:65-97`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-898

**Command / Area:** CDIMPORTXCIVIL and CDIMPORTLANDXML results page, ledger F-039.

**Symptom:** A pit skipped because of a locked layer is listed "Recorded" in the results window, and a zero-placement import can be called complete. MEDIUM.

**Expected behaviour:** Results come from what was actually drawn, retained or skipped.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 4; `Commands/LinkCommands.ImportXcivil.cs:219-229,508-518`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-899

**Command / Area:** CDIMPORTLANDXML Replace, position, ledger F-040.

**Symptom:** The new import's offset is worked out from the old import, which is then deleted, so the replacement lands in a different place from a clean import. MEDIUM.

**Expected behaviour:** The measured extents exclude the objects about to be erased, as the X-Civil lane already does.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 5; `Services/XcivilImportService.cs:1879,1921` vs `:694`. Related BUG-068. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-900

**Command / Area:** CDIMPORTXCIVIL PDF schedules, ledger F-041.

**Symptom:** A schedule spread over several pages returns only one page's rows, so pits on the continuation sheet lose their sizes and levels. MEDIUM.

**Expected behaviour:** Rows from every schedule page are collected.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 6; `Modules/tools/Extract-XcivilPdfSchedule.ps1:480-819`. Related BUG-781, BUG-804. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-901

**Command / Area:** CDRULES R-04 cover, ledger F-042.

**Symptom:** Cover is measured to the inside top of the pipe, so it is over-stated by the wall thickness (concrete 375 shows 320 mm, really about 275 mm). MEDIUM (needs Tim's word).

**Expected behaviour:** Cover to the outside top, with a wall-thickness table in Settings.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 4; `Rules/RulebookEngine.cs:466`. Needs Tim's word (after 9 Nov). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-902

**Command / Area:** CDRULES cover between pits, ledger F-043.

**Symptom:** Cover is checked only at the two pits against the lid level; a pipe under a lower garden bed between raised lids is never checked there. MEDIUM (needs Tim's word).

**Expected behaviour:** Cover can be checked along the pipe from surface levels.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 5; `Rules/RulebookEngine.cs:444-474`. Needs Tim's word (after 9 Nov). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-903

**Command / Area:** Inspector, Hub, repair checks versus CDRULES, ledger F-045.

**Symptom:** Different screens judge one pipe against different minimum grades (one figure versus the ladder) and covers (office 300 versus council value), so the Inspector can say OK where CDRULES warns. MEDIUM (needs Tim's word).

**Expected behaviour:** One minimum per pipe on every screen.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 7; `Services/DesignValidationService.cs:350`, `Services/MinimumCoverForChecks.cs:18-30`. Needs Tim's word (the grade ladder). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-904

**Command / Area:** CDDESIGN storm sweep, ledger F-049.

**Symptom:** The sweep (5, 10, 15 ... minutes) skips storms near the peak, so storage can be 2 to 3 per cent short, and nothing says when the worst storm is the first one. MEDIUM.

**Expected behaviour:** A finer sweep near the peak, or a note.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 11; `Services/DetentionSizingService.cs:66-67,156-159`. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-905

**Command / Area:** CDCALC Boyd's tab versus CDDESIGN, ledger F-050.

**Symptom:** The two use different hard-ground C (1.0 versus 0.9), so one job gets different storage figures. MEDIUM (needs Tim's word).

**Expected behaviour:** One value, set in Settings.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 12; `ViewModels/BoydsCalcViewModel.cs:233-237`, `Services/AutoDesignService.cs:62-69`. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-906

**Command / Area:** CDRULES R-30 versus R-06, ledger F-051.

**Symptom:** R-30 judges a 100 mm downpipe left marked Detention while R-06 says it is "not judged". MEDIUM.

**Expected behaviour:** R-30 says Unknown for the same reason as R-06.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 13; `Rules/RulebookEngine.cs:95-106,479-497`. Related BUG-815, BUG-854. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-907

**Command / Area:** CDRULES pit drop where the pipe gets bigger, ledger F-052.

**Symptom:** Only inverts are compared, so a 150 in at 10.000 and a 300 out at 9.980 passes although the outlet top is 130 mm above the inlet top. MEDIUM (needs Tim's word).

**Expected behaviour:** A warning when the outlet obvert sits above the inlet obvert.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 14; `Rules/PitDropRule.cs:150-156`. Needs Tim's word (after 9 Nov). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-908

**Command / Area:** Engineering numbers fixed in code (R-00), ledger F-053.

**Symptom:** Council values (Kingston, Manningham, Casey), pump station numbers, sizing limits, storm, orifice, level limits and an X-Civil level range of 0 to 250 m are written into code, not Settings. MEDIUM (needs Tim's values).

**Expected behaviour:** Each number lives in Settings or the council profile; the code value is only a documented fallback.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 15 (about 30 files listed there). Needs Tim's values (R-00). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-909

**Command / Area:** CEMEMBER picked plane and UCS, ledger F-055.

**Symptom:** CEMEMBER keeps only X and Y of the picks (Z becomes 0) and draws a section square to the world axes, not the UCS. MEDIUM (needs Tim's word on the section).

**Expected behaviour:** Elevated geometry keeps its Z or is refused before writing.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F3, OPUS-A finding 7; `Commands/CeMemberCommands.cs:125,131,189-191`. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-910

**Command / Area:** LBUH, LBH and CEMEMBER break marks on a layout sheet, ledger F-056.

**Symptom:** "Follows paper" still uses the model drawing scale when drawing directly on a layout sheet (a break kink is 100 mm on paper at DIMSCALE 50). MEDIUM (needs Tim's word).

**Expected behaviour:** Paper-sized marks on paper.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F5; `Commands/HatchCommands.cs:1655`, `Commands/CeMemberCommands.cs:99`. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-911

**Command / Area:** EBT and 25C text height, ledger F-057.

**Symptom:** In a metre drawing the text is 125 m high; at DIMSCALE 0 and 1:50 it falls back to 250 and plots 5 mm instead of 2.5 mm. MEDIUM.

**Expected behaviour:** Height follows drawing units and the annotation scale, or the command says the scale is unavailable.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F6; `Services/CeTextService.cs:27,610,625,4655,5482-5520`. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-912

**Command / Area:** CEMEMBER DefaultScale Setting, ledger F-058.

**Symptom:** With DIMSCALE 0 the Setting is ignored and the fixed 1:100 is used (150 / 200 mm breaks instead of 75 / 100 at 1:50). MEDIUM.

**Expected behaviour:** The Setting is used and named in the warning.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F7, OPUS-A finding 6; `Commands/CeMemberCommands.cs:98`, `DesignCore/SteelSections/CeMemberEngine.cs:188-190`. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-913

**Command / Area:** CE_VERSION (About CE Suite window), ledger F-065.

**Symptom:** The three rows start as "Not loaded" and stay so if reading the versions fails, so a loaded Civil can read "Not loaded". AutoCAD shows as an internal number (25.1) and falls back to a guessed "2022+". HIGH (the text can be false).

**Expected behaviour:** Rows start as "Checking" and a failure says "CE could not read this. Type CEHEALTH." The AutoCAD row shows the year or "not read".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 7 and 8, CODEX_AUDIT_GATE_22OCT.md finding 14; `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:67-73`, `CeVersionWindow.xaml.cs:34-44`. Wording fix drafted in #1534 (HOLD: garbled characters in the pushed head). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-914

**Command / Area:** CE Suite Manager window, install step wording, ledger F-083.

**Symptom:** The window says "Then run the CE installer" but only the administrator can run it; the status line already says to ask the administrator. HIGH (false for a colleague).

**Expected behaviour:** Both lines use the same words; a colleague reads "ask your CE administrator to finish the install".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 1; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:177,189`, `Services/CeInstallWords.cs:6-15`. Fix drafted in #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-915

**Command / Area:** CDCHECKIGNORE list, rows beyond 40, ledger F-084.

**Symptom:** Only 40 rows are printed but the command offers "type their number" for the rest, so a finding that was never shown can be ignored. HIGH.

**Expected behaviour:** Print every row, or refuse numbers that were not shown and say how to see the rest.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 13; `Commands/CheckIgnoreCommand.cs:93,141`. Fix drafted in #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-916

**Command / Area:** CDCHECKIGNORE refusal wording, ledger F-085.

**Symptom:** One refusal says a finding "CE could not check" can be ignored; the next says a check CE could not run cannot be ignored. HIGH (the two messages contradict).

**Expected behaviour:** One consistent rule in plain words.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 14; `Services/Checks/IgnoredChecks.cs:90,93`. Fix drafted in #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-917

**Command / Area:** CE Suite Manager window, stage names, ledger F-086.

**Symptom:** Five different phrases name one update stage ("Installed next start", "Updates ready to get", "Ready next start", "Update ready", "2 · Ready"), so a drafter cannot tell approved from copied from installed. MEDIUM.

**Expected behaviour:** Three fixed words everywhere: Approved, Copied waiting, Starts next time.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 2; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:50,98,99,139,176`. Left out of #1534 on purpose (needs each state checked). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-918

**Command / Area:** Manager finish-update messages (not connected yet), ledger F-087.

**Symptom:** The messages use "record" and give no next step, and one promises "It will finish when every AutoCAD window on this PC is closed" although no code starts the installer. MEDIUM (becomes false if connected too early).

**Expected behaviour:** Plain next steps, and the promise text can only appear once the part that starts the installer exists.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 5 and 6; `Modules/Manager/Services/CeFinishUpdatePlanner.cs:47,52,56`, `CeFinishUpdateStartRule.cs:36`. Partly in #1534 (UI-5); UI-6 left out. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534, not installed)

## BUG-919

**Command / Area:** CE_VERSION wording, ledger F-088.

**Symptom:** A ".NET 10" row drafters cannot act on, "CONFLICT — 2 copies" in capitals with no next step, "<path unavailable>", and three names for one window. MEDIUM.

**Expected behaviour:** "Two copies loaded (3.0.70 and 3.0.69). Close AutoCAD and ask your CE administrator."; one window name; no programmer placeholder.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 9 to 12; `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:4,34,78`, `Services/CeVersionReport.cs:97,101`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-920

**Command / Area:** CDCHECKIGNORE, switch-off message, ledger F-089.

**Symptom:** "Ignoring a finding is switched off in CE Settings." does not say which tab to tick. MEDIUM (switch OFF).

**Expected behaviour:** The line names CDS > Newer tools > Allow a finding to be ignored, and still says "Nothing was changed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 15; `Commands/CheckIgnoreCommand.cs:39`, `Services/Checks/IgnoredChecks.cs:88`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-921

**Command / Area:** CDCHECKIGNORE, empty drawing wording, ledger F-090.

**Symptom:** "This drawing has no CE project record yet" uses a software word and gives no next step. MEDIUM (switch OFF).

**Expected behaviour:** "This drawing has no CE pits or pipes yet, so there is nothing to ignore. Nothing was changed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 16; `Commands/CheckIgnoreCommand.cs:46`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-922

**Command / Area:** Checks window, "could not check", ledger F-091.

**Symptom:** The same words cover "a value is missing" and "CE failed while reading"; the row repeats its own title and gives no next step. MEDIUM.

**Expected behaviour:** Header "not known (a value is missing)"; the read-failure row says to run CDCHECK again and how to send a fault report.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 20; `Services/Checks/ChecksResult.cs:153,305-307`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-923

**Command / Area:** CDRULES row wording, ledger F-092.

**Symptom:** Rows use "provenance", "PitSelector size tier", "office seed", "per-type catalogue selection" and "fallback velocity". MEDIUM.

**Expected behaviour:** Plain words and a next step ("Set the material on the pipe").

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 21, 23, 24, 25; `Rules/RulebookEngine.cs:69,250-260,321,411-419`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-924

**Command / Area:** CDRULES "no minimum in the rulebook", ledger F-093.

**Symptom:** Rows say "no minimum cover in the rulebook" instead of where to set it (Settings-first). MEDIUM.

**Expected behaviour:** "No minimum cover set. Set it in CDS > Design."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 22; `Rules/RulebookEngine.cs:345,437,454,625,650`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-925

**Command / Area:** Council source window, ledger F-094.

**Symptom:** The window shows raw saved data (JSON including EntityHandle and SpineKey) and legal-sounding sentences. MEDIUM.

**Expected behaviour:** Values listed in words ("Diameter 225 mm, upstream IL 10.250"); no handles.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 26; `ViewModels/CouncilSourceViewModel.cs:63,80,82`. Left out of #1534 (behaviour change). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-926

**Command / Area:** "Unknown" versus "not known", ledger F-095.

**Symptom:** The Checks list says "not known" but Settings, council rule values, audit lines and a pipe-length message say "Unknown". MEDIUM.

**Expected behaviour:** "not known" everywhere a drafter reads it.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 27 and 28; `AdvancedSettingsDialog.xaml:919,1360`, `Rules/CouncilRuleValues.cs:333`, `Commands/LinkCommands.ReadOnlyAudit.cs:25-36`. Partly in #1534. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534, not installed)

## BUG-927

**Command / Area:** CDTAG messages, ledger F-096.

**Symptom:** "CDTAG removed." appears when nothing was tagged (Enter on an empty tag), and the success line reads "CDTAG applied: tag=DP2. Pipes linked to this block: 2." MEDIUM.

**Expected behaviour:** "[CE] No tag typed. This block has no source tag." and "[CE] Tagged DP2. 2 pipes are connected to it."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 30 and 31; `Commands/SourceTagCommand.cs:311,391`. Left out of #1534 (reserved for the source-edit PRs). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-928

**Command / Area:** Settings tooltip naming a person, ledger F-097.

**Symptom:** A tooltip colleagues read says "Tim decides when to hide it (ruling of 18 Oct: it stays visible for now)." MEDIUM.

**Expected behaviour:** Plain text about the tick, no names or internal rulings.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 36; `Dialogs/AdvancedSettingsDialog.xaml:1375`, `CivilSettingsView.xaml:400`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-929

**Command / Area:** Settings tick with no visible effect, ledger F-098.

**Symptom:** A tick for the long-section row says "Nothing draws this row today". MEDIUM.

**Expected behaviour:** Hidden until something draws the row, or labelled "(no effect yet)".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 37; `AdvancedSettingsDialog.xaml:1369`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-930

**Command / Area:** Settings Fixes tab tooltips, ledger F-099.

**Symptom:** Eight tooltips use software words (stored deletion word, records, drawing identity, Point Order, runtime rounding, unlinked, Project QA, native, host drawing). MEDIUM.

**Expected behaviour:** Plain wording as in the audit's suggested text.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 38 to 45; `AdvancedSettingsDialog.xaml:1338-1398`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-931

**Command / Area:** Settings, start-up message to CE Cloud, ledger F-100.

**Symptom:** The tick is worded with "heartbeat", "install ID", "environment variables", "posts" and "queues", and does not say plainly what is sent. MEDIUM.

**Expected behaviour:** "At start-up, tell the CE office this PC is running CE (CE and AutoCAD versions and a PC code only)."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 50; `AdvancedSettingsDialog.xaml:1128-1129`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-932

**Command / Area:** Settings, "Furthest a label may move out (mm)", ledger F-101.

**Symptom:** It does not say model or paper millimetres; 1500 mm in the model is 7.5 mm on a 1:200 sheet. MEDIUM (switch OFF).

**Expected behaviour:** The label says "(mm in the model, 1500 = 1.5 m)".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 51; `AdvancedSettingsDialog.xaml:1215-1286`. Related F-063. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-933

**Command / Area:** Settings, new switches with no tick, ledger F-102.

**Symptom:** The double-click Edit source window (ON by default), leave out removed pits, slow-check progress and wrong-layer rows have no tick in Settings, so a drafter cannot see or change them. MEDIUM.

**Expected behaviour:** One tick each in CDS > Newer tools.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 52; `Models/DoubleClickSettings.cs:34`, `Models/UserSettings.cs:1985,2757,2764`. PR #1526 adds rows (check it covers all four). #1526 adds the rows (MERGE-WITH-FIXES: tallest tab 673 px). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1526, not installed)

## BUG-934

**Command / Area:** Settings window name, ledger F-103.

**Symptom:** One window is called Preferences (ribbon, CD and Edit Pipe buttons), Settings (title bar, Help) and CE Settings (messages). MEDIUM (needs Tim's naming call).

**Expected behaviour:** "Settings" everywhere.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 55; `Assets/Config/ce_toolbar_layout.json:189`, `Dialogs/AdvancedSettingsDialog.xaml:4`. Partly in #1534; protected Edit Pipe window keeps 'Preferences'; one name is Tim's call. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534, not installed)

## BUG-935

**Command / Area:** Two things called "CE Manager", ledger F-104.

**Symptom:** CDMANAGER ("CE Manager") is the Drawing Standards Manager, but CESURVEYREVIEW says "Opens CE Manager" and means Suite Manager. MEDIUM (needs Tim's naming call).

**Expected behaviour:** CDMANAGER reads "Drawing Standards (CDMANAGER)"; the survey tooltip says "CE Suite Manager".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 56; `Assets/Config/command-registry.json:319`, `Modules/Manager/Assets/Config/command-registry.json:33`. #1534 (HOLD); naming is Tim's call. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-936

**Command / Area:** Ribbon tooltips, banned words, ledger F-105.

**Symptom:** Tooltips for CDDASHBOARD, CDANNOTATIONEDIT, CDEXPORTENTITIES, CDSLABIMPORT and CDTAG use "network topology", "schedule drift", "compound entity", "Export Entities", "CE data model". MEDIUM.

**Expected behaviour:** Plain wording as in the audit's suggestions.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 57; `Assets/Config/command-registry.json:147,198,252,314,343`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-937

**Command / Area:** Repair Centre ribbon label, ledger F-106.

**Symptom:** "Repair Center" is US spelling and the tooltip says "sync, rebuild, upgrade and diagnostics". MEDIUM (LOW for the spelling alone).

**Expected behaviour:** "Repair Centre" with "Fix a drawing whose pits, pipes or schedule look wrong."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 58; `Assets/Config/command-registry.json:351,355`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-938

**Command / Area:** Manager Refresh button tooltip, ledger F-107.

**Symptom:** "Refresh plugin discovery, upload queued telemetry, and reload dashboard data." uses software words and does not say plainly that it sends data. MEDIUM.

**Expected behaviour:** "Look again for installed CE tools, send any waiting usage notes to the office, and refresh this screen."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 59; `Modules/Manager/Assets/Config/command-registry.json:27`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-939

**Command / Area:** Help Centre, Settings tabs, ledger F-108.

**Symptom:** Help lists six Settings tabs; the window has eight (Newer tools and Fixes are missing) and says "Pipes & Pits" where the tab is "Pipes and Pits". MEDIUM.

**Expected behaviour:** The Help line names all eight tabs.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 61; `Assets/Help/guide-content.js:95`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-940

**Command / Area:** Help Centre, who can switch Checks on, ledger F-109.

**Symptom:** Help says only the office administrator can switch it on; any drafter can tick it in Settings. MEDIUM.

**Expected behaviour:** "Switch it on in Settings (CDS) > Newer tools. Ask first: it has not been tested in AutoCAD yet."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 62; `Assets/Help/guide-content.js:58`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-941

**Command / Area:** CD window wording, ledger F-110.

**Symptom:** "Use single pipe entity", "...and validation rules" and "no invert or grade validation" are software words in the window used all day. MEDIUM.

**Expected behaviour:** "Draw the pipe as one line", "...and which checks apply", "Levels and grade are not checked."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 63; `Dialogs/CdDialog.xaml:238,244,469`. #1534 (HOLD). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1534 (on HOLD), not installed)

## BUG-942

**Command / Area:** Inspector and Edit Pit wording, ledger F-111.

**Symptom:** The Inspector shows "Handle", "GIO Handle" and "full-detail snapshot", and Edit Pit says "reference evidence, not authority". MEDIUM.

**Expected behaviour:** Handle rows hidden for colleagues; "This is the full view."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 64; `Controls/InspectorPanelControl.xaml:89,266,321`, `Dialogs/PitEditWorkshopDialog.xaml:203`. Left out of #1534 (layout change; Edit Pit protected). Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-943

**Command / Area:** Repair Centre and CD help page wording, ledger F-112.

**Symptom:** "Sync Links", "Sync first, rebuild second" and "refreshes caches from drawing truth" are software words. MEDIUM.

**Expected behaviour:** "1. Reconnect pits and pipes"; "Rebuild reads the pits and pipes again from what is drawn, and keeps what you typed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 65; `Dialogs/CdRepairDialog.xaml:46,75`, `Dialogs/CdHelpDialog.xaml:94`. Left out of #1534. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-944

**Command / Area:** Command-line messages in developer words, ledger F-113.

**Symptom:** "compound root", "no ProjectData record", "slab boundary polyline handle", "not a council profile id" and "entity(ies) skipped due to read errors" reach the drafter. MEDIUM.

**Expected behaviour:** Plain messages starting "[CE]" with a next step.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 66; `Commands/AnnotationEditCommand.cs:57`, `RunSolveCommand.cs:288,467`, `SlabCommand.cs:1229`, `RulebookCommand.cs:158`, `HubCommands.cs:654`. Left out of #1534. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-945

**Command / Area:** CDAUDIT and Recover Inverts messages, ledger F-114.

**Symptom:** Output reads like a programmer's dump ("pits=12, pipes=14, pipes-without-handle=0, duplicate-handle-groups=1", "cached ownership Unknown"). MEDIUM.

**Expected behaviour:** "[CE] CDAUDIT: 12 pits, 14 pipes. 2 pipes are copies of one another. Type CDREPAIR to fix them."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 67; `Commands/LinkCommands.cs:403,405,2379`, `Commands/LinkCommands.ReadOnlyAudit.cs:36,40`. Left out of #1534. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-946

**Command / Area:** CEHEALTH, Civil installed but not loaded, ledger F-122.

**Symptom:** When Civil's files are present but Civil is not loaded, CEHEALTH prints "[OK] CE Civil Suite v3.0.70" and can finish "All checks passed", while CE_VERSION says "Not loaded". MEDIUM.

**Expected behaviour:** A plain warning that Civil is not loaded, with the remaining checks carried on.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-01; `Modules/Manager/Commands/PluginManagerCommands.cs:184-243`, `Services/CePluginRegistryService.cs:517`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-947

**Command / Area:** Manager Get update ready, damaged prepared copy, ledger F-123.

**Symptom:** If one file is missing from a prepared update, clicking Get update ready again copies the good files, discards them and fails because the old damaged folder is still there ("conflicting identity evidence"). A restart does the same. MEDIUM.

**Expected behaviour:** The damaged copy is set aside and a new verified copy is prepared from the intact source; installed files do not change.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-02; `Modules/Manager/Services/CeUpdateStagingService.cs:370-430`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-948

**Command / Area:** CE Tools > Updates & Rollback button, ledger F-124.

**Symptom:** For an ordinary colleague the button opens no window and prints that their Windows account is not set up as a CE administrator, although the Manager window already has an Updates page. MEDIUM.

**Expected behaviour:** The button opens the Manager Updates page for a colleague, or is labelled as an administrator function.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-03; `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26`, `Commands/PluginManagerCommands.cs:91,139,148`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-949

**Command / Area:** LBH hatch at 1:100, ledger F-127.

**Symptom:** Since S-41 LBH at 1:100 is hatched five times sparser (one line every 1.1 m of wall instead of 225 mm), so a 900 mm wall nib can show no hatch. MEDIUM (needs Tim's word).

**Expected behaviour:** Tim decides whether LBH keeps its stated 50 at 1:100 (and LBUH keeps paper density).

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 3; `Commands/HatchCommands.cs:120-130`, `Core/Units/DrawingScaleRule.cs:58-60`. Related BUG-748. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-950

**Command / Area:** Bracing panel, ledger F-128.

**Symptom:** The panel adds the metres of brace of every type and shows green when the total reaches the required length, with no rating per metre; a weak brace can show sufficient against a requirement worked for a strong one. MEDIUM (needs Tim's word).

**Expected behaviour:** A rating per bracing type on the Settings page, provided and required in kN; until then "lengths only, types not weighted" and unknown when the types differ.

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 4; `Modules/Structural.DesignCore/BracingPanelCalculator.cs:157-195`. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-951

**Command / Area:** TH, PF, BP, column, 18-text and setout tag heights, ledger F-129.

**Symptom:** These tags use a fixed height (250, 200 or 180) at every scale, so a PFL label plots 12.5 mm at 1:20 and 5 mm at 1:50 beside 2.5 mm notes. MEDIUM.

**Expected behaviour:** Height follows the label plot height times the drawing scale, as 25C and EBT now do.

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 5; `Modules/Structural/Services/CeTextService.cs:663-780`. Related BUG-531. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-952

**Command / Area:** SBEAM versus CEMEMBER member size, ledger F-130.

**Symptom:** At any DIMSCALE except 20 the same member is drawn at different sizes: SBEAM scales depth by DIMSCALE / 20, CEMEMBER draws real size (at 1:100, 298 mm deep from CEMEMBER, 1490 mm from SBEAM). MEDIUM (needs Tim's word).

**Expected behaviour:** One ruling from Tim decides which is right, and both commands follow it.

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 6; `DesignCore/SteelSections/SbeamPlacementPlanner.cs:8,23,87-92`, `CeMemberElevation.cs`. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-953

**Command / Area:** EH, CH, LBH and LBUH when LTSCALE is not 10 x DIMSCALE, ledger F-131.

**Symptom:** The hatches refuse to draw ("Invalid DIMSCALE/LTSCALE combination") although the pattern scale depends only on DIMSCALE; a drawing at DIMSCALE 100 and LTSCALE 1 gets no hatch. This is a hard stop that R-27 does not allow. MEDIUM.

**Expected behaviour:** Draw the hatch and warn that LTSCALE looks off.

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 7; `Commands/HatchCommands.cs:347-349,1655-1678`. Related BUG-614. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-954

**Command / Area:** CEHATCH library fixed presets, ledger F-132.

**Symptom:** The fixed-scale template hatches disagree with their scale-aware twins (at 1:100 "Concrete slab" is 5 times sparser than CE's Concrete), and "Fence wall under" and "Dot hatch 9" still have the dots-merge fault BUG-748 fixed for LBUH. MEDIUM (needs Tim's word).

**Expected behaviour:** Each pair follows one rule chosen by Tim.

**Reference:** AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md finding 8; `Commands/HatchUpgradeCommands.cs:45-58`. Related BUG-748. Needs Tim's word. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-955

**Command / Area:** Structural windows (CESHEETS, CESETTINGS and others sharing the host), ledger F-139.

**Symptom:** The shared host copies screen pixels into WPF window sizes, so at 150% on a large monitor Drawing Sheets and Settings can open too large with the lower buttons beyond the screen. MEDIUM (first rated HIGH; checked 23 Oct) (conditional on a 150% transform).

**Expected behaviour:** Window sizes are converted from pixels and clamped to the monitor work area.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 1; `Modules/Structural/UI/AutoCadWindowHostHelper.cs:49-164`. Opus check: real at any display scale above 100 per cent; the window can still be moved. Re-checked at the installed commit 23 Oct. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-956

**Command / Area:** Structural window minimum sizes (SBEAM picker, RC member, Structural Settings), ledger F-140.

**Symptom:** Their minimum sizes (up to 1340 x 820) are bigger than a 1080p screen at 150%, so the Place or Save buttons cannot be reached even by dragging smaller. MEDIUM.

**Expected behaviour:** Each window fits a 1080p screen at 150% with its buttons visible.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 2; `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml:5`, `RCMemberDialog.xaml:5`, `CeSettingsDialog.xaml:5`. Source-verified (not re-checked 23 Oct). Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2.

**Status:** OPEN

## BUG-957

**Command / Area:** CDS (Settings) search, ledger F-141.

**Symptom:** Pressing Enter in the Settings search with no matches saves the whole draft and closes Settings. MEDIUM.

**Expected behaviour:** An unsuccessful search never falls through to Save.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 3; `Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.cs:57,62`. Opus check: verified. Re-checked at the installed commit 23 Oct. Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-958

**Command / Area:** Remember window position for Edit Pipe, Edit Pit, New Pit and CDS, ledger F-142.

**Symptom:** With Remember ticked these windows still reopen at CE's calculated centre, because CE's own fitting sets the position to Manual first. MEDIUM (switch-dependent).

**Expected behaviour:** The windows remember where the drafter moved them.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 4; `Modules/Drainage/Services/CeWindowPlacementHook.cs:49,100,101`. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-959

**Command / Area:** Civil Hub position on a second monitor, ledger F-143.

**Symptom:** Civil Hub restores a saved second-monitor position against the primary work area only and moves back to the primary screen; other Civil sizing paths clamp the same way. MEDIUM.

**Expected behaviour:** A valid position on any connected monitor is kept.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 5; `Modules/Drainage/Dialogs/CivilHubDialog.xaml.cs:419-467`, `Services/WindowSizingService.cs:189-216`. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-960

**Command / Area:** Checks palette and What CE Found, theme, ledger F-144.

**Symptom:** The palettes keep their old dark or light look after the theme is changed, even after closing and reopening. MEDIUM (Checks palette OFF by default).

**Expected behaviour:** The palette follows the saved theme.

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 6; `Modules/Drainage/Controls/ChecksListControl.xaml.cs:12`, `Services/ThemeService.cs:107-220`. Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN

## BUG-961

**Command / Area:** Manager window and import review lists, test names, ledger F-145.

**Symptom:** The running-build and installed-build fields in Manager, and the two import review lists, have no stable name, so an automated check can read the wrong value and pass the window. MEDIUM.

**Expected behaviour:** Each test-critical field has a stable name (see CODEX_BUILD_AUTOMATION_IDS_22OCT.md).

**Reference:** CODEX_HUNT_WINDOWS_22OCT.md finding 9; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:47,52`, `Modules/Drainage/Dialogs/CivilImportWindow.xaml:133,171`. #1527 adds the names (MERGE-WITH-FIXES). Source-verified (not re-checked 23 Oct). Lane: Codex or Sonnet; base claude/rel-20261022m.

**Status:** OPEN (fix drafted in #1527, not installed)

## BUG-962

**Command / Area:** CDTIDYLABELS scan cost, ledger F-149.

**Symptom:** Every distant survey text is tested against every pipe's search area (9,000 texts and 500 pipes is 4.5 million tests) before planning starts, and Yes repeats it. MEDIUM (switch OFF).

**Expected behaviour:** Distant text is rejected once or through a bounded lookup, with local obstacles still complete.

**Reference:** CODEX_HUNT_PERF_22OCT.md PERF-02; `Services/LinkService.TextClashTidyUp.cs:142-747`. Source-verified (not re-checked 23 Oct). Lane: Sonnet (protected file); base claude/rel-20261022m.

**Status:** OPEN

## BUG-963

**Command / Area:** CDPROPAGATE (LinkCommands.cs:475); no switch (Civil commands, Undo and Checks), ledger F-152.

**Symptom:** Hide the upstream IL on a pipe, then CDPROPAGATE 9.50 at the downstream pit. The IL text beside the downstream pit reads "IL 9.60" (the upstream level) while the schedule says 9.50, and the command still says "Updated 1 pipes". HIGH.

**Expected behaviour:** CDPROPAGATE writes each new level only into the IL text that belongs to that end of the pipe; with the upstream IL hidden, the one remaining text beside the downstream pit shows the downstream level.

**Reference:** CODEX_SWEEP_S03 S03-01; `Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs:974-995 (called from :799)`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grep for UpdateIlAnnotationsForPipe, and for hidden/one-IL with propagate/cascade, in carpark, FB list and ledger: no match). Fix kind: code. Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: P1->P2 10 m, IL 10.00/9.90, first IL Hidden; CDPROPAGATE P2 9.50; expect the single text beside P2 = "IL 9.50" (today "IL 9.60").

**Status:** OPEN

## BUG-964

**Command / Area:** CDHUB > Network redesign (preview and Apply). The same Design service feeds CDRUNSOLVE and auto-design (RunSolveCommand.cs:143, AutoDesignOrchestrator.cs:212), so those are likely affected too (not traced further) (Civil engineering numbers), ledger F-153.

**Symptom:** A-B-C at 1 in 100, outlet C 10.000. The redesign preview gives B to C leaving B at 10.200 but A to B arriving at B at 10.030, so the pipe drops 170 mm into the pit and the outgoing pipe starts higher. Pit B is set to 10.000. The preview offers this as a good design. HIGH.

**Expected behaviour:** Network redesign sets each pit's level from the upstream (this-pit) end of its outgoing pipe, so incoming pipes arrive at or above the outgoing pipe and the preview never offers a pit where pipes drop in below the outlet.

**Reference:** CODEX_SWEEP_S04 S04-01; `Modules/Drainage/Services/NetworkDesignService.cs:329-356; OutputValidation.cs:188-194`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none. BUG-868 (F-007) is the same file but a different defect (every pipe treated as UPVC). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: NetworkDesignService.Design, chain A->B->C, 20 m each, 1:100, outfall C 10.000, drop 0.030; expect B->C upstream 10.200, A->B downstream 10.230, pit B 10.200

**Status:** OPEN

## BUG-965

**Command / Area:** PITSCHEDULE Refresh; also every automatic RefreshLinkedCells (for example after a Pit Schedule diameter sync); no switch (Civil records, schedules and sheets), ledger F-155.

**Symptom:** A placed schedule that correctly shows "2/375" for twin tanks and "3000" for a trench grate changes to "375" and "300 x 300" when you press Refresh (or after any edit that refreshes linked cells), while the Pit Schedule window still shows the right values. HIGH.

**Expected behaviour:** Refreshing a placed Pit Schedule keeps exactly what the Pit Schedule window shows: '2/375' for twin tanks, the trench grate length, and a blank (not '0 x 0') for a pump pit.

**Reference:** CODEX_SWEEP_S05 S05-02; `Modules/Drainage/Services/ScheduleLinkService.cs:2001, :2020, :2026, :2619-2638`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grep for twin/2/375 with refresh, TgLength with linked: only this report). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: linked schedule with twin 375 pipe and TG pit (TgLengthMm 3000, 300x300); RefreshLinkedCells; expect MText "2/375" and "3000" unchanged

**Status:** OPEN

## BUG-966

**Command / Area:** CDSPOON (SpoonCommand.cs:24, :150); no switch (Civil commands, Undo and Checks), ledger F-156.

**Symptom:** Trace a spoon drain with CDSPOON and Close: nothing is left on the drawing and the command line says the spoon boundary or hatch "failed exact readback. No spoon output was committed." It fails every time, standalone or inside a slab. HIGH.

**Expected behaviour:** CDSPOON completes and leaves one closed boundary and one hatch, both ByLayer, on the spoon layers; the readback check accepts ByLayer colour.

**Reference:** CODEX_SWEEP_S06 S06-01; `Modules/Drainage/Services/SlabService.cs:2264, :2279, :2308, :2418, :2421`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grep for "failed exact readback" and CDSPOON rollback: none). Fix kind: code (check the layer colour, or that the entity is ByLayer, instead of the entity index). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fresh mm drawing, CDSPOON standalone 10000,10000 / 12000,10000 / 12000,11000 / 10000,11000 / Close; expect "CDSPOON complete." and one closed boundary + one SOLID hatch, both ByLayer

**Status:** OPEN

## BUG-967

**Command / Area:** CDDESIGN (Yes to "look through the job's folders for its rating report") (Civil engineering numbers), ledger F-157.

**Symptom:** A Blue Factor report with 400 m2 roof, 100 m2 drive, 300 m2 garden and 200 m2 lawn on a 1000 m2 site goes into CDDESIGN as "Roof and paved area 1000 m2" instead of 500, so the whole site is treated as hard surface. HIGH.

**Expected behaviour:** CDDESIGN takes only roof and paved rows from a Blue Factor report into 'Roof and paved area'; garden and lawn go to the pervious area (how to treat 'Other' is Tim's call).

**Reference:** CODEX_SWEEP_S07 S07-01; `Modules/Drainage/Rules/BlueFactorReport.cs:39, :100-115`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grep for Blue Factor with garden/lawn: only this report). Fix kind: code (Garden/Lawn kept out of the impervious total; how to treat "Other" may need Tim's word). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: BlueFactorReport.Parse on the 4-line fixture; expect TotalImperviousM2 = 500 and PerviousAreaM2 = 500

**Status:** OPEN

## BUG-968

**Command / Area:** CDRENUMBER (PitRenumberCommand.cs:28, :69); no switch (Civil commands, Undo and Checks), ledger F-158.

**Symptom:** If the drawing has two pipes recorded running opposite ways between the same two pits, typing CDRENUMBER can close AutoCAD before the renumber list appears. HIGH.

**Expected behaviour:** CDRENUMBER on a drawing whose pipe records form a loop finishes with a plain message naming the loop (no hard block) and never closes AutoCAD.

**Reference:** CODEX_SWEEP_S08 S08-02; `Modules/Drainage/Rules/PitRenumberPlanner.cs:91-104, :142; PitRenumberNetworkBuilder.cs:102-129`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grep for renumber with loop/cycle/stack: only this report). Fix kind: code (on-path guard; report the loop in plain words, no hard block). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: PitRenumberPlanner.Compute with edges P10<-{P12,P13}, P12<-P11, P11<-P12; expect it returns (a finite list or a loop message), no StackOverflow

**Status:** OPEN

## BUG-969

**Command / Area:** CDNEWDWG (Civil records, schedules and sheets), ledger F-159.

**Symptom:** Working in job 26-901, CDNEWDWG with the job folder changed to 26-902 makes the sheet in 26-902, but its title block REF NO (and any client and address) says 26-901. The preview shows the wrong number too. HIGH.

**Expected behaviour:** When the job folder is changed in CDNEWDWG, the job record is re-read from the new folder, so the new sheet's title block carries the new job's number, client and address.

**Reference:** CODEX_SWEEP_S10 S10-01; `Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.cs:61, :121-128, :202; Commands/NewJobDrawingCommand.cs:51-56, :92-98`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (CODEX_SWEEP_S16 CDNEWDWG item is the file name, a different defect). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: folders 26-901/26-902 each with CE_JobRecord.json; open 26-901\seed.dwg, CDNEWDWG, set folder 26-902, Create; expect DWGPROPS REF NO = 26-902

**Status:** OPEN

## BUG-970

**Command / Area:** CDTWL (no switch) (Civil engineering numbers), ledger F-160.

**Symptom:** Two separate detention systems in different schedule sets, both numbered P1-P2: CDTWL picks "P2" without asking which, adds both systems' pipes (measured with the wrong set's pit positions) and can say "That is enough" when neither system is. HIGH.

**Expected behaviour:** CDTWL keeps two schedule sets that both use P1-P2 apart: it asks which outlet (set A or set B) and counts only that system's pipes, measured with that system's pits.

**Reference:** CODEX_HUNT_DESIGN DESIGN-01; `Services/DetentionTwlService.cs:112-118; Rules/DetentionBranchCollector.cs:85-135, 150-170; Commands/DetentionTwlCommand.cs:91`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (BUG-871/F-048 is units, BUG-913 proposal is sump; PR #1538 CDTWL units is different). Fix kind: code (carry handles/spine keys, not printed numbers). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: reviewer fixture (sets A and B, P1-P2 each, TWL 10.300, need 2.5 kL); expect a choice between A-P2 and B-P2 and one pipe per branch (today one choice, two pipes, about 3,427 L "enough").

**Status:** OPEN

## BUG-971

**Command / Area:** CDSYNC and any command that saves the project record after a failed load (Civil records, schedules and sheets), ledger F-161.

**Symptom:** If the CE record in a drawing cannot be read (for example written by a newer CE), running CDSYNC rebuilds pits from the drawing and saves over the old record, so manual schedule rows and pit remarks are gone for good. HIGH.

**Expected behaviour:** A CE drawing record that exists but cannot be read is never overwritten: CE says so on the command line, keeps a copy, and holds every save of that record until it is repaired.

**Reference:** CODEX_HUNT_RECORDS R-02; `Services/ProjectDataService.Persistence.cs:197-287, 823-905, 1070-1130, 1293-1310`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grepped unreadable record, LoadFromDrawingLight, PROJECT_DATA corrupt). Fix kind: code (keep "present but unreadable" state; hold that record's write and keep a copy). Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: drawing whose PROJECT_DATA has lastPitNumber="BROKEN"; run sync+save; expect original chunks unchanged and a visible message (today replaced).

**Status:** OPEN

## BUG-972

**Command / Area:** CESHEETSCLASSIC (manager window) and the Sheets palette button; normal CESHEETS window not checked (Structural), ledger F-162.

**Symptom:** Change a closed sheet's revision from A to B and click "Preview drawing updates": the closed DWG is already saved with revision B before you see anything, and closing the window does not undo it. HIGH.

**Expected behaviour:** 'Preview drawing updates' only lists what would change; nothing is written or saved until a separate Apply.

**Reference:** CODEX_SWEEP_S13 S13-01; `CeSheetsManagerWindow.xaml.cs:505-540; Services/CeSheetsUpdateService.cs:124-135; Services/CeSheetsSyncService.cs:835-890; UI/Palette/SheetsPanel.xaml.cs:183`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grepped "Preview drawing updates", CESHEETSCLASSIC, UpdateAllDrawings; BUG-495 is Publish Issue revision, different). Fix kind: code (preview = read-only change list, then a separate Apply) plus wording. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: closed B.dwg REVISION=A, manifest row B; click preview; expect B.dwg SHA-256 and REVISION unchanged (today REVISION=B, file rewritten).

**Status:** OPEN

## BUG-973

**Command / Area:** CESHEETSCLASSIC > Preview Renames > Apply Renames (Structural), ledger F-163.

**Symptom:** Swap S01 and S02 in the sheet list and Apply Renames: both rows now open S01.dwg (which holds the old S02 drawing) and the other drawing is moved into the Superseded folder. HIGH.

**Expected behaviour:** Swapping two sheet numbers and applying renames leaves each row on its own drawing and archives nothing.

**Reference:** CODEX_SWEEP_S13 S13-02; `Services/CeSheetsSyncService.cs:469-536, 690-740`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grepped ApplyRenamePlan, ArchiveUnusedProjectDrawings, sheet rename/swap). Fix kind: code (map from a snapshot of the original row-to-file assignment; archive from the final set). Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: manifest rows S01->S02.dwg target, S02->S01.dwg target, both files present; ApplyRenamePlan; expect two distinct DwgPaths and ArchivedUnusedDrawingCount 0 (today both S01, count 1).

**Status:** OPEN

## BUG-974

**Command / Area:** XCLMTXT (Insert Selected) then C2 (also any support command whose name matches a schedule mark); no switch (Structural), ledger F-164.

**Symptom:** exclude C2 = 200 SHS in XCLMTXT and insert the rest; the printed schedule has no C2, but typing C2 silently uses 200 SHS instead of asking you for the size. HIGH.

**Expected behaviour:** Rows the drafter excluded in XCLMTXT are left out of the saved member schedule, so a later support command (for example C2) asks for its size instead of silently using the excluded row.

**Reference:** CODEX_SWEEP_S14 S14-02; `Modules/Structural/Services/XclmTxtService.cs:277, :303-331`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grep for MemberSchedule / XclmTxtService / schedule snapshot in carpark, fix briefs, ledger: no hits). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Preview rows B1/310UB32 (Include, Ground) and C2/200 SHS (Include=false); call TryPersistMemberSchedule path via insert: saved MEMBER_SCHEDULE holds 1 row (B1) and FindByCode(db,"C2") returns null.

**Status:** OPEN

## BUG-975

**Command / Area:** SDS, SDS1, SC2 and every other S* support switch (and TDS); no switch (Structural), ledger F-165.

**Symptom:** two supports 200 mm apart; SDS on the first one and turning it 90 degrees also swings the second support's label round to the wrong place, and the label becomes a new object. HIGH.

**Expected behaviour:** Switching or turning one support moves only that support's own side text; a neighbouring support's text keeps its object, position and rotation.

**Reference:** CODEX_SWEEP_S15 S15-01; `Modules/Structural/Commands/SupportBlockCommands.cs:562-580, :665-745, :1772-1830, :1905-1935`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grep CaptureSupportSideTextLabels / side-text label / neighbour support: no hits). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Supports A (0,0) and B (200,0), DBText on SUPPORT TEXT at (245,145); SDS on A, rotation 90: the text keeps its handle, insertion (245,145,0) and rotation 0.

**Status:** OPEN

## BUG-976

**Command / Area:** CENOTES (+ Note, Save) and the Notes browser; no switch (Structural), ledger F-166.

**Symptom:** if your notes file is damaged or held by OneDrive for a moment, adding one note in the Notes palette leaves a file with only that note; your notes from every other drawing vanish with no warning. HIGH.

**Expected behaviour:** If the notes file cannot be read (damaged, or held by OneDrive), adding a note refuses with a plain message and leaves the file exactly as it was.

**Reference:** CODEX_SWEEP_S15 S15-03; `Modules/Structural/Core/Notes/SharedNotesManager.cs:350-375, :1060-1110`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grep notes_data / SharedNotesManager: no hits). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Isolated DataFolder, notes_data.json with 2 notes prefixed "S15_CORRUPT!"; AddNote("S15 THIRD") returns false and the file bytes are unchanged.

**Status:** OPEN

## BUG-977

**Command / Area:** SBEAM (elevation and section routes); no switch (Structural), ledger F-167.

**Symptom:** move the UCS to a detail at 10000,20000 and pick a beam from local 0,0 to 3000,0: SBEAM draws it back at World 0,0 to 3000,0, nowhere near the detail. HIGH.

**Expected behaviour:** SBEAM converts the picked points from the current UCS to World, so a beam picked at a moved or rotated UCS lands where it was picked.

**Reference:** CODEX_HUNT_STRUCTCMDS SC-01; `Modules/Structural/Commands/SbeamCommandRunner.cs:159-198, :234`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (F-055 is CEMEMBER's Z/section-axis loss, a different command; no SBEAM UCS entry in carpark or ledger). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: UCS Origin 10000,20000; SBEAM 310UB32 Side Elevation, picks 0,0 and 3000,0: outline end stations at World X 10000 and 13000, Y 20000.

**Status:** OPEN

## BUG-978

**Command / Area:** Structural load at AutoCAD start (no switch) (Structural), ledger F-168.

**Symptom:** Open a second AutoCAD (same or other year) while the first is running: the second has no CE STRUC ribbon or background services and says another copy is active, until the first AutoCAD is closed. HIGH.

**Expected behaviour:** A second AutoCAD window (same or another year) starts Structural normally, with its ribbon and services; the 'already running' guard applies only inside one AutoCAD process.

**Reference:** CODEX_HUNT_COMPAT COMPAT-01; `Modules/Structural/Plugin.cs:76, 125-130, 451-475`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grepped PluginRuntime, RuntimeMutex, second AutoCAD process). Fix kind: code (process-scoped name, e.g. add the process id). Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: create the named mutex in a helper process, then call TryAcquireRuntimeMutex in a second process; expect true (today false).

**Status:** OPEN

## BUG-979

**Command / Area:** CDJOINT; no switch (Civil commands, Undo and Checks), ledger F-169.

**Symptom:** CDJOINT on a slab that already has joints, Enter for Yes to "Clear and regenerate", then Esc at "Select slab type": every joint line and SC label disappears, nothing is redrawn and nothing is said. Only U brings them back. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** CDJOINT erases the old joints only after every question is answered; Esc at the slab type or spacing leaves the old joints and the slab record untouched.

**Reference:** CODEX_SWEEP_S09 S09-01 (also HUNT_DATALOSS_SILENT DS-06, never filed); `Modules/Drainage/Commands/CdJointCommand.cs:77-112, :500-528`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: HUNT_DATALOSS_SILENT_2026-10-12 DS-06 (identical, same lines; never given a BUG number, not in BUG_CARPARK). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: slab 9000x6000 with a 3000 grid; CDJOINT, Yes, Esc at slab type; expect the 3 baseline line/label handles still live and the stored list unchanged

**Status:** OPEN

## BUG-980

**Command / Area:** CDCALC > Pipe Flows > SELECT FROM DRAWING list (no switch) (Civil engineering numbers), ledger F-170.

**Symptom:** In CDCALC Pipe Flows, pick a 1 in 50 pipe then a 1 in 200 pipe from the list: the grade box stays 50, the flow shown is about double the true capacity, and the grey note can name the second pipe's inverts. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** In CDCALC Pipe Flows, picking a second pipe from the list refills every value CE filled from the first pipe (grade, diameter, roughness), and the note names the pipe actually used.

**Reference:** CODEX_SWEEP_S11 S11-01; `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:159-217; Dialogs/CalculationsV2Dialog.xaml:573`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grepped carpark/FB/ledger for PipeFlowCalc, prefill, IsBlankOrDefault; only BUG-592 zero-input, different). Fix kind: code (remember which fields CE filled itself; refill those on the next pick). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: view model with pipes A (1:50, RCP) and B (1:200, RCP); set SelectedPipeId=A then B; expect SlopeRatio "200" and hint naming B (today "50").

**Status:** OPEN

## BUG-981

**Command / Area:** PITSCHEDULE, Source = Drainage XREFs (no switch) (Civil records, schedules and sheets), ledger F-172.

**Symptom:** In a combined schedule from two drainage XREFs, the second drawing's pit can print with a blank pit number, size, outlet and cover, so its row reads as another inlet into the first drawing's pit. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** A combined Pit Schedule from two drainage Xrefs keeps each drawing's pits as separate groups even when their internal handles are equal.

**Reference:** CODEX_SWEEP_S11 S11-03; `PitScheduleViewModel.Schedule.cs:410-449; PitScheduleViewModel.Data.cs:812-826`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (BUG-788/LM-45 is source discovery merging SAVEAS copies, a different key). Fix kind: code (add SourceDrawingIdentity to the group key for external rows). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: IsFirstRowInGroup on two external rows, same SourcePitHandle "2A1" and set Main, different SourceDrawingIdentity; expect true for index 1 (today false).

**Status:** OPEN

## BUG-982

**Command / Area:** CDPROPAGATE (Cascade Preview, Override 1:N cell) (Civil commands, Undo and Checks), ledger F-173.

**Symptom:** Override a 1 m pipe to 1 in 300 in the cascade preview: it says OK, both inverts are saved as 10.00 (flat), and the command line still says "Min grade: 1:300". MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** CDPROPAGATE judges and reports the fall on the two-decimal levels it actually writes, so a pipe that would be saved flat is flagged and never reported as 1:300.

**Reference:** CODEX_SWEEP_S12 S12-01; `Models/PropagationPlan.cs:50-57; Services/LinkService.RepairAudit.InvertPropagation.cs:686, 780-832, 917`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (BUG-782 is the kept-hand-level end, different; F-070 is CDRULES wording). Fix kind: code (check and report on the rounded strings actually written; keep Tim's 2dp format). Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: plan row length 1000 mm, new levels 10.003333/10.000; expect flat-when-written = true and no "1:300" in summary (today false and "1:300").

**Status:** OPEN

## BUG-983

**Command / Area:** Sheets palette "Preview drawing updates" (SyncManifest); any sync that reaches title-Xref layers (Structural), ledger F-174.

**Symptom:** With title Xref TITLE on the layout and an unrelated Xref TITLE_DETAIL in model space, updating a revision A sheet freezes TITLE_DETAIL|REV_B, so its linework disappears. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** Title-Xref layer sync freezes layers of the title Xref only (exact name), never another Xref whose name merely contains it.

**Reference:** CODEX_SWEEP_S13 S13-03; `Services/CeSheetsSyncService.cs:2156-2172, 2175-2245, 2290-2298`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grepped IsTitleXrefLayerMatch, title xref freeze). Fix kind: code (match the bound Xref's exact name/hierarchy, not substrings). Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: IsTitleXrefLayerMatch("TITLE_DETAIL|REV_B", {"TITLE"}); expect false (today true).

**Status:** OPEN

## BUG-984

**Command / Area:** CEMARKUPRUN then CEMARKUPUNDO after a drawing switch; no switch (Structural), ledger F-175.

**Symptom:** run a markup batch in drawing A, switch to drawing B and type CEMARKUPUNDO: B loses its last step, A's note stays, and CE records A's batch as undone, so running it again in A puts a second copy of the note on top. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** CEMARKUPUNDO refuses, naming the drawing, when the active drawing is not the one the batch ran in, and marks a batch undone only after the undo actually happened.

**Reference:** CODEX_SWEEP_S14 S14-01; `Modules/Structural/Services/MarkupAIWorkflowService.cs:209-251; MarkupAIExecutionService.cs:215-226; MarkupAIRuntimeState.cs:18`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (grep of BUG_CARPARK, FIX_BRIEFS, ledger for CEMARKUPUNDO / Markup Undo / MarkupAIRuntimeState: no hits). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Two drawings; CEMARKUPRUN one NATIVE:NOTE in A; activate B, draw LINE; CEMARKUPUNDO: expected refusal naming drawing A, B's line still present, A's plan status still Executed.

**Status:** OPEN

## BUG-985

**Command / Area:** BEXTEND (and alias BEXT if registered); no switch (Structural), ledger F-176.

**Symptom:** extend a beam to a curved wall drawn as a polyline arc and it stops on the straight line between the arc's ends, up to the full arc depth short, while CE says it reached the boundary. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** BEXTEND extends to the real arc of a polyline boundary (or says plainly it used the chord); it never reports reaching the boundary when it stopped short.

**Reference:** CODEX_SWEEP_S15 S15-02; `Modules/Structural/Commands/BeamExtendCommands.cs:228-252, :170-215`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (carpark line 40 "BEXTEND/FEDIT doubled defaults ... FADOPT arc" is a different defect). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: LINE (0,0)-(3000,0); LWPOLYLINE (5000,-2000) bulge 1 to (5000,2000); BEXTEND End, None: beam end = (7000,0,0).

**Status:** OPEN

## BUG-986

**Command / Area:** CSREOBAR, then CSBARSCHEDULE; no switch (Structural), ledger F-177.

**Symptom:** pick a bar from 0,0,0 to 3000,0,4000: the preview and command line say 5000 LG, but the bar drawn, its note and the bar schedule all say 3000. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** CSREOBAR's preview, drawn bar, note and bar schedule all give the same length for a bar picked at two different heights.

**Reference:** CODEX_HUNT_STRUCTCMDS SC-02; `Modules/Structural/Services/ReoBarService.cs:130-192, :486-496, :745-766`. Installed Structural 1.0.121. Opus check 23 Oct: VERIFIED. Existing: none (no CSREOBAR slope/Z entry in carpark or ledger). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: World UCS, CSREOBAR N16 3 100 Top, 0,0,0 to 3000,0,4000, Yes: completion line, note text and extent length all agree (either 5000 along a 3D bar, or a stated plan-length rule with matching preview).

**Status:** OPEN

## BUG-987

**Command / Area:** CDSYNC (any full EnsureDrawingDataCurrent) (Civil records, schedules and sheets), ledger F-178.

**Symptom:** In a metre drawing, a new pit with no levels yet sitting 10 m from a pit marked "Class D, KEEP P2, not in schedule" can swap: after CDSYNC the new pit drops out of the schedule with Class D, and the other one comes back in. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** CDSYNC matches saved pit choices by identity and handle first and by position only for pits left unmatched, so two valid pits never swap lid class, remarks or schedule tick.

**Reference:** CODEX_HUNT_RECORDS R-01; `Services/ProjectDataRecoveryGuardService.cs:105-232, 347-365; Services/ProjectDataService.cs:636-662`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (ledger PERF-01 / proposed BUG-970 is speed of the same loop, not wrong matches). Fix kind: code (reserve id/handle matches first; position only for unmatched; tolerance in drawing units via Settings). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: RestorePitUserData with pits P1 (0,0) default and P2 (10,0) Class D/KEEP P2/excluded and their own snapshots; expect each keeps its own values (today swapped).

**Status:** OPEN

## BUG-988

**Command / Area:** any drawing open / first CE command (project load) (Civil records, schedules and sheets), ledger F-179.

**Symptom:** Delete the last pit and pipe in a job and reopen it: CE can bring back old rainfall, land use and numbering choices from a file on this PC, so the same DWG behaves differently on a colleague's PC. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** Any CE record read successfully from the drawing wins over an old record file on this PC, even when its pit, pipe and manual-row lists are empty.

**Reference:** CODEX_HUNT_RECORDS R-03; `Services/ProjectDataService.Persistence.cs:197-287`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (grepped legacy file precedence, CD_ProjectData_; BUG-489 only logs that path). Fix kind: code (any successfully read drawing record wins). Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: valid embedded record with empty lists and landUse=residential plus legacy file landUse=commercial; load; expect residential (today commercial).

**Status:** OPEN

## BUG-989

**Command / Area:** CDSPINEUPGRADE > Rollback (hidden in registry) (Civil records, schedules and sheets), ledger F-180.

**Symptom:** Run CDSPINEUPGRADE Apply on an old job, then CDSPINEUPGRADE Rollback: the pits and pipes lose the permanent identities they were just given, while their numbers on the drawing look the same. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** Needs Tim's decision: CDSPINEUPGRADE Rollback either keeps the permanent identities and rolls back the rest, or refuses with a plain line (R-27 says identities are protected).

**Reference:** CODEX_HUNT_RECORDS R-04; `Commands/SpineUpgradeCommand.cs:40-55, 140-175; Services/LinkService.Spine.cs:195-212, 713-726; Services/ProjectDataService.Spine.cs:230-239`. Installed Civil 3.0.70. Opus check 23 Oct: PARTLY (the removal is real; calling it an R-27 breach needs Tim's word, because it only undoes keys the same upgrade added, on a hidden repair command). Existing: none (grepped spine rollback, RollbackSpine). Fix kind: needs Tim's word (keep keys and roll back the rest, or refuse) then code. Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: object with no SPINE_ID; Apply then Rollback; expect SPINE_ID still present and a refusal line (today removed, "Rolled back 1 of 1 identities").

**Status:** OPEN

## BUG-990

**Command / Area:** AutoCAD start-up (Civil load); Settings fleetTelemetry.heartbeatEnabled default ON (Privacy and security), ledger F-181.

**Symptom:** If a PC's CE cloud address is typed as http://, opening AutoCAD sends the CE access key unencrypted in the background, even with AI turned off. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** The start-up heartbeat sends nothing unless the CE cloud address is https and the approved host, and it does not follow redirects.

**Reference:** CODEX_HUNT_PRIVACY H01; `Services/FleetTelemetryStartupService.cs:49-75; Services/TelemetryQueueService.cs:131-205`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: related BUG-557 route 8 (heartbeat had no switch; now has one) but not the HTTPS/approval gap; none exact. Fix kind: code (require https and the approved host; no auto-redirect). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: HttpHandlerOverride capture, CE_CLOUD_URL=http://127.0.0.1:18765, dummy auth; TryFlushAsync; expect zero requests (today one POST with x-api-key).

**Status:** OPEN

## BUG-991

**Command / Area:** CDASK (and markup / X-Civil vision paths using the same sender); AI master switch must be ON (Privacy and security), ledger F-182.

**Symptom:** CE checks the cloud address before asking AI, but if that address forwards the request, the question, drawing facts and access key go to wherever it forwards without a second check. MEDIUM (source HIGH; checked 23 Oct).

**Expected behaviour:** The shared AI sender does not follow redirects, so a question, drawing facts and the access key only ever go to the approved address.

**Reference:** CODEX_HUNT_PRIVACY H02; `CE.AI.Core/AnthropicChatClient.cs:36-38, 117-130; Controls/CeAssistantControl.xaml.cs:687-711`. Installed Civil 3.0.70. Opus check 23 Oct: VERIFIED. Existing: none (BUG-557 route 7 covers only the seat check, which does refuse redirects). Fix kind: code (redirects off in the shared AI sender). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: real HttpClientHandler against loopback A returning 307 to B; SendAsync; expect B receives nothing and an error (today B gets body and key).

**Status:** OPEN

## BUG-992

**Command / Area:** CDXREFCOMPARE (also the automatic one-line background-changed notice leads to it); no switch found, runs by default (Civil imports), ledger F-186.

**Symptom:** When a consultant moves a roof 4.5 m in the Xref and you run CDXREFCOMPARE, the "Nearby CE objects to check" list names the pit beside the new roof but not the pit that used to sit beside the old roof, and next time it forgets the old roof ever existed. MEDIUM.

**Expected behaviour:** CDXREFCOMPARE lists CE objects near both the old and the new position of a moved roof or boundary.

**Reference:** CODEX_SWEEP_S01 S01-01; `BackgroundXrefGeometryDiffService.cs:74, :106-109; BackgroundXrefAffectedObjectsService.cs:35-49; BackgroundXrefCompareCommand.cs:102-113, :135-144`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (grep of BUG_CARPARK, ledger and FB for BackgroundXref / Compare background / CDXREFCOMPARE found no matching entry). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Pure unit test: previous roof 0..10000, current roof 4500..14500 (same category), pits at (-500,5000) and (15000,5000) in mm; run Diff then FindAffected; expected both pits listed, current code lists only the second.

**Status:** OPEN

## BUG-993

**Command / Area:** CDCHECK (All); CDCHECKS / CDRULES share the same reader. No switch; default on (Civil commands, Undo and Checks), ledger F-189.

**Symptom:** If you rotate a FALL symbol 180 degrees so it points away from its grated pit, CDCHECK still treats it as aimed at the pit and says nothing (and a correctly turned arrow can keep a false "points away" warning). MEDIUM.

**Expected behaviour:** CDCHECK's FALL-arrow direction check adds the block's own rotation, so a FALL symbol turned 180 degrees away from its grated pit is flagged.

**Reference:** CODEX_SWEEP_S02 S02-02; `FallArrowDirectionReviewService.cs:145-175; Rules/FallArrowGeometry.cs:131-170; Services/Checks/ChecksResultReader.cs:143-149`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG-588 is about the saved listing not holding this warning, a different defect). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Unit test on TryReadFallArrow output or Review: arrow with Angle1 0, flip 0, block rotation pi at (0,0), grated pit at (5000,0), tolerance 45 deg: expected one away finding with difference about 180.

**Status:** OPEN

## BUG-994

**Command / Area:** CDINSPECTOR (select a pipe); editors.workshopLayout default ON (Wording and windows), ledger F-190.

**Symptom:** Click a 10 m pipe in a metre drawing with the normal Inspector open: Connections > Drawn length says 10 mm instead of 10000 mm. MEDIUM.

**Expected behaviour:** The compact Inspector converts drawn length by the drawing's units, as the full-detail Inspector already does: a 10 m pipe in a metre drawing reads 10000 mm.

**Reference:** CODEX_SWEEP_S02 S02-03; `InspectorPaletteService.cs:860, :1128; ViewModels/InspectorViewModel.cs:120-143`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG-323 fixed the other Inspector path only; PR #1546 is Inspector type, not length; PR #1530 is rule length, not Inspector). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Fixture pipe polyline of length 10.0 with INSUNITS 6: the drawn-length string passed to ShowCivilPipeRecord is "10000 mm"; with length 10000 at INSUNITS 4 it is also "10000 mm".

**Status:** OPEN

## BUG-995

**Command / Area:** CDINSPECTOR > Show full detail > Drawing health buttons (failing grade, low cover, unconnected pits, disconnected pipes, duplicate numbers, missing levels). No switch (Wording and windows), ledger F-192.

**Symptom:** With a user UCS set, clicking "Unconnected pits" (or any health count) in the Inspector selects the right pits but the view jumps to empty space and the command line still says "Zoom fit applied". MEDIUM.

**Expected behaviour:** The Inspector's Drawing health buttons zoom to the selected pits with a user UCS set (world extents are not transformed a second time).

**Reference:** CODEX_SWEEP_S02 S02-05; `InspectorPaletteService.cs:268-282, :2752-2806; DrawingService.cs:595-660`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: UCS origin 100000,0 and a pit extents (-300,-300)-(300,300) world: the resulting view centre is (0,0); current code gives about (100000,0).

**Status:** OPEN

## BUG-996

**Command / Area:** CD (manual pipe text, Yes to mirror); no switch (Civil labels and Tidy labels), ledger F-193.

**Symptom:** In CD with manual pipe text, answer Yes to "Do you want to mirror the text?", then move the pipe: the mirrored label stays behind. MEDIUM.

**Expected behaviour:** Answering Yes to 'mirror the text' in CD keeps the pipe linked to the mirrored text, so the text moves with the pipe.

**Reference:** CODEX_SWEEP_S03 S03-03; `MirrorService.cs:133-149; CdCommand.cs:771-780`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG at carpark line 8369 is about AutoCAD's own MIRROR on a pit, a different path). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Mirror a registered MText through MirrorEntity and assert the original handle still resolves (or the pipe record holds exactly the live handle); then move the pipe and assert the text moves by the same displacement.

**Status:** OPEN

## BUG-997

**Command / Area:** CDCALC > Older longitudinal > Update Existing. The tab is shown by default (Civil records, schedules and sheets), ledger F-194.

**Symptom:** Copy a long-section block to keep an older view, then press Update Existing on the original in CDCALC (Older longitudinal): the copy changes too, even if it sits on a locked layer. MEDIUM.

**Expected behaviour:** Update Existing on an older long section changes only the selected section; a copy that shares its block keeps the old content (give the selected insert its own block first; no hard block).

**Reference:** CODEX_SWEEP_S03 S03-04; `LongitudinalSectionService.cs:452-504; ViewModels/LongitudinalSectionViewModel.cs:700-718`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Related but different: BUG-758 (older tab lacks CDPROFILE admission checks; fix is in 3.0.70 via PR #1407/#1408). Fix kind: code (give the selected insert its own definition first; do not add a hard block, R-27). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Section block A and copy B reference one definition; UpdateExistingSection(A) with a changed vertical scale: B's nested scale note keeps the old text (needs its own definition); currently both change.

**Status:** OPEN

## BUG-998

**Command / Area:** CDHUB > Network redesign > Build read-only preview / Apply approved redesign. No switch found; reachable by default (Civil engineering numbers), ledger F-195.

**Symptom:** In CDHUB Network redesign, a pipe arriving 30 mm above the pit floor is reported as "levels changed after the preview" and Apply stays greyed out, though you changed nothing. MEDIUM.

**Expected behaviour:** Network redesign shows each pipe's own end levels as the 'before' levels, so an unchanged pipe arriving above the pit floor is not called stale and Apply is available.

**Reference:** CODEX_SWEEP_S04 S04-02; `NetworkRedesignPreviewService.Projection.cs:197-200; NetworkRedesignDrawingProjector.cs:305-309; NetworkRedesignApplyTicketService.cs:472-480; NetworkRedesignHubViewModel.cs:318`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (F-007/BUG-868 is the UPVC-only solver, a different defect). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Unit test of the projection and ticket: pit IL 10.300, arriving pipe ToInvert 10.330 unchanged since preview: ticket must have no "levels changed" reason and the preview's before-IL must be 10.330.

**Status:** OPEN

## BUG-999

**Command / Area:** CDRUNSOLVE (also the hand-off from Edit Pit). No switch (Civil engineering numbers), ledger F-196.

**Symptom:** CDRUNSOLVE on a normal run finishes with "every invert already matches the solved design" even though it solved nothing and your inverts are untouched. MEDIUM.

**Expected behaviour:** CDRUNSOLVE either solves with real flows or says plainly that it could not solve; it never reports 'every invert already matches' when nothing was solved.

**Reference:** CODEX_SWEEP_S04 S04-03; `ProposalApplyService.PlanBuilders.cs:555, :72-110; NetworkDesignService.cs:223, :281; PipeSizingSolver.cs:63; RunSolveCommand.cs:140-178`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (F-007 / BUG-868 / PR #1537 concern the hard-coded UPVC material in this same solver, not the zero flow). Fix kind: code (feed real flow, or say honestly it could not solve; needs Tim's word on whether Run Solve is meant to be a level-only calculation). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: BuildRunInputs -> Design -> BuildRunSolvePlan for a one-pipe run A-C (cover 12.0, ILs 10.6/10.0): plan must carry an error or warning shown to the drafter, never an empty plan reported as "matches"; currently EffectiveChanges 0 with only a warning.

**Status:** OPEN

## BUG-1000

**Command / Area:** CDIMPORTXCIVIL (when the auto-translation trigger fires). No switch (Civil imports), ledger F-197.

**Symptom:** When CDIMPORTXCIVIL automatically shifts a far-away consultant layout onto your drawing, the pits and pipes land in the right place but the spot levels and FALL arrows stay at the old coordinates. MEDIUM.

**Expected behaviour:** When CDIMPORTXCIVIL shifts a far-away layout onto the drawing, spot levels and FALL arrows shift by the same amount as the pits and pipes.

**Reference:** CODEX_SWEEP_S06 S06-02; `XcivilImportService.cs:696-712, :1134, :1172; XcivilPitInsertionService.cs:899-965, :1047-1100`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (F-040 / proposed BUG-908 concern LandXML Replace target extents, not the Xcivil spot and fall lists). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Call TranslateXcivilImportData with a translation of (985000, 990000) and one spot and one fall candidate at (15000,12000) and (15000,14000): expected (1000000,1002000) and (1000000,1004000); currently unchanged.

**Status:** OPEN

## BUG-1001

**Command / Area:** CDIMPORTXCIVIL. No switch (Civil imports), ledger F-198.

**Symptom:** Importing a consultant layout with two close pits labelled P10 and P20, the second pit can come in as a made-up P11 even though P20 is sitting right there. MEDIUM.

**Expected behaviour:** CDIMPORTXCIVIL gives each pit its own nearby label even when the nearest label is taken by a neighbour (two close pits P10 and P20 both come in with their own names).

**Reference:** CODEX_SWEEP_S06 S06-03; `XcivilScheduleService.cs:795-845 (loop at :817-830); XcivilImportService.cs:473 (caller), :562`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Two pit sources at (10000,10000) and (11000,10000), texts P10 at (10000,12000) and P20 at (11000,13000): expected P10 and P20 assigned, unresolved 0; currently second pit unresolved and later "P11".

**Status:** OPEN

## BUG-1002

**Command / Area:** CDIMPORTXCIVIL. No switch (Civil imports), ledger F-199.

**Symptom:** Two fall arrows that point at right angles in the consultant's drawing, because one block was rotated 90 degrees, both come in pointing the same way with the same 1:100 text. MEDIUM.

**Expected behaviour:** An exported fall-arrow block that was rotated keeps its real direction on import.

**Reference:** CODEX_SWEEP_S06 S06-04; `XcivilEntityScanner.cs:1759-1917; XcivilPitInsertionService.cs:1087-1100`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Block definition with a line (0,0)-(1000,0) and text "1:100"; two references on layer FALL, rotation 0 and 90 degrees: imported Angle1 values must differ by 90 degrees; currently both 180.

**Status:** OPEN

## BUG-1003

**Command / Area:** CEFIND (and the Pit Schedule, Checks and Project Review Show where do not use it). No switch (Civil commands, Undo and Checks), ledger F-200.

**Symptom:** Type CEFIND then P1A (or C2, or P1A-P2) for a pit that is clearly there and CE answers "P1A is not in this drawing." MEDIUM.

**Expected behaviour:** CEFIND finds pits typed as they are numbered (P1A, C2) and pipes between them (P1A-P2).

**Reference:** CODEX_SWEEP_S07 S07-02; `CeFindQuery.cs:54-102; Commands/CeFindCommand.cs:80-111`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (carpark CEFIND entries at lines 5978-5996 are about the drawing being marked changed). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: CeFindQuery.Parse("P1A") must return Kind PitId and Parse("P1A-P2") must return PipeEndpoints; currently both Unrecognised.

**Status:** OPEN

## BUG-1004

**Command / Area:** CDDESIGN (During). No switch found (Civil engineering numbers), ledger F-201.

**Symptom:** Agree the design with a 0.45 m orifice head, later change it to 0.60 m and Save Draft: reopening CDDESIGN still shows "Nothing has changed since the design was agreed." MEDIUM.

**Expected behaviour:** CDDESIGN's 'changed since agreed' list includes the orifice head and the detention answer, so changing either no longer reads 'Nothing has changed'.

**Reference:** CODEX_SWEEP_S07 S07-03; `AgreedDesignRules.cs:67-83, :219-233; Models/AgreedDesignSnapshot.cs; ViewModels/CivilDesignWindowViewModel.cs:141-164, :515-520, :562-585`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (PR #1549 changes the soft C display only; F-072 is the soft C value). Fix kind: code (add head and detention to the snapshot and the During list). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Agreed snapshot head 0.45 vs current head 0.60 (all else equal): Compare returns one change and IsUnchanged is false; currently zero changes and true.

**Status:** OPEN

## BUG-1005

**Command / Area:** CDRENUMBER. No switch (Civil commands, Undo and Checks), ledger F-202.

**Symptom:** CDRENUMBER numbers a short 20 m side run before a 100 m run feeding the same pit, so the "longest main line first" numbering comes out wrong. MEDIUM.

**Expected behaviour:** CDRENUMBER scores each branch including the pipe that joins it, so the longer run continues the main-line numbers.

**Reference:** CODEX_SWEEP_S08 S08-03; `PitRenumberPlanner.cs:97-143; Rules/PitRenumberNetworkBuilder.cs:121-129; Commands/PitRenumberCommand.cs:69-104`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Planner unit test with edges P10<-P11 (100 m), P10<-P12 (10 m), P12<-P13 (10 m): expected order P10, P11, P12, P13; currently P10, P12, P13, P11.

**Status:** OPEN

## BUG-1006

**Command / Area:** CDRULES (Explain), CDCHECKS rows; no switch (Civil engineering numbers), ledger F-203.

**Symptom:** When CDRULES warns that a pipe is too slow it tells you to reduce the pipe size, which makes it slower; when too fast it says increase the size, which makes it faster. MEDIUM.

**Expected behaviour:** The speed-warning advice no longer tells the drafter to change pipe size in the direction that makes the speed worse (replacement wording is Tim's engineering call).

**Reference:** CODEX_SWEEP_S08 S08-04; `Rules/RuleFixAdvisor.cs:78-87; Rules/RulebookEngine.cs:415-438; Rules/RuleExplainer.cs:27-37`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (PR #1534 wording and #1530 real length do not touch these two lines). Fix kind: wording (needs Tim's word on the replacement advice, since it is engineering guidance). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: RuleFixAdvisor for an R-02 Warn finding returns an action that contains neither "reduce the pipe size" nor "increase the pipe size"; R-01 Warn likewise.

**Status:** OPEN

## BUG-1007

**Command / Area:** CDFALL (no switch) (Civil commands, Undo and Checks), ledger F-205.

**Symptom:** In a metre drawing, placing a fall arrow and picking the direction 0.5 m to the north gives an arrow pointing east, with no warning. MEDIUM.

**Expected behaviour:** CDFALL converts the 'no direction' distance by the drawing's units, so a direction picked 0.5 m north in a metre drawing points north.

**Reference:** CODEX_SWEEP_S09 S09-04; `FallCommand.cs:83-99`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG-079 family is about flip/orientation of a valid angle; BUG-4251 family is metre-drawing units generally). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Metre drawing (INSUNITS=6), CDFALL insertion 0,0, direction 0,0.5, ratio 80; expected log `FALL orientation: input=90.0` (today 0.0); mm control with direction 0,500 already gives 90.0.

**Status:** OPEN

## BUG-1008

**Command / Area:** PITSCHEDULE (no switch) (Civil records, schedules and sheets), ledger F-206.

**Symptom:** Double-click a Remarks cell in the Pit Schedule and you get "This cell cannot be edited" instead of a typing box. MEDIUM.

**Expected behaviour:** Double-clicking a REMARKS cell in the Pit Schedule opens it for typing, and Restore Cell / Delete Cell work on it.

**Reference:** CODEX_SWEEP_S10 S10-02; `PitScheduleDialog.xaml.cs:328-364 and :180-184; PitScheduleViewModel.cs:133-136, :1054-1059`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG_CARPARK line 1038 is about text typed into the DRAWN table, and the 14 Oct custom-remarks bug is about the CUSTOM REMARKS box losing characters; neither is this). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Schedule with one current-drawing pit, double-click REMARKS cell, expect an edit box (today the status line reads "This cell cannot be edited."); unit form: `ResolveTemplateColumnProperty("REMARKS")` must return "Remarks".

**Status:** OPEN

## BUG-1009

**Command / Area:** PITSCHEDULE with Source set to Drainage XREFs (switch is a window choice; default source is the current drawing, so this only happens after choosing Xrefs) (Civil records, schedules and sheets), ledger F-207.

**Symptom:** Clicking pit P3 in a schedule built from an attached drainage drawing can zoom to and select some unrelated object in your current drawing, or print "P3 is not in this drawing" while P3 is plainly visible in the attached one. MEDIUM.

**Expected behaviour:** Clicking a Pit Schedule row that comes from an Xref never selects an object in the host drawing; it zooms into the Xref or says plainly that it cannot.

**Reference:** CODEX_SWEEP_S10 S10-03; `PitScheduleDialog.xaml.cs:246-265; CeZoomHighlightService.cs:69-124`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code (skip the zoom for external rows, or say it is unavailable; real Xref navigation would be larger and may need Tim's word). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Host drawing with an object whose handle equals an Xref pit's handle; click the Xref row; expected no selection of the host object (today it selects it); with no host object at that handle, expected no "not in this drawing" message for an Xref row.

**Status:** OPEN

## BUG-1010

**Command / Area:** automatic job timer (no command); Settings idleTimeoutMinutes default 5 (Civil records, schedules and sheets), ledger F-208.

**Symptom:** Walk away for 6 minutes, come back and click "Click to count that time": the job timer adds 11 minutes, not 6. If you ignore the offer, the first 5 minutes of the break are still counted. MEDIUM.

**Expected behaviour:** Accepting 'count that time' after a 6 minute break adds 6 minutes, not 11; whether the first idle minutes count at all is Tim's billing rule.

**Reference:** CODEX_SWEEP_S10 S10-04; `JobTimeTracker.cs:314-340, :367-374, :464-471; JobTimeSession.cs:202-212`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG_CARPARK lines 9854-9886 are privacy/time-log file items, not this arithmetic). Fix kind: needs Tim's word (whether the first 5 minutes should count is a billing rule; the double count on accept is plainly wrong). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Session with threshold 300 s: tick 300 s, fire idle, return with IdleDuration 360 s, call RestoreIdleTime(360); expected TrackedSeconds 360 (today 660).

**Status:** OPEN

## BUG-1011

**Command / Area:** PITSCHEDULE, Auto-calculate depth unticked (default ticked) (Civil records, schedules and sheets), ledger F-209.

**Symptom:** With Auto-calculate depth off, you type a depth in the Pit Schedule and it looks accepted, but the pit's levels do not change and Stop overriding then blanks the depth while saying your values stay. MEDIUM.

**Expected behaviour:** With Auto-calculate depth off, a depth typed in the Pit Schedule changes the pit's levels, and Stop overriding keeps it as the message says.

**Reference:** CODEX_SWEEP_S11 S11-04; `PitScheduleViewModel.Data.cs:1157-1179, :1270-1290, :1814-1850`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none (BUG_CARPARK 1136 is the depth rule for SPS pits; the Depth cell wiring tests are helper-only). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Linked unlocked pit, AutoCalculateDepth=false, raise `PropertyChanged` for Depth="2.00" through the subscribed row; expected OutletInvert (or InletInvert) changes per `PitScheduleDepthEditPlanner` (today unchanged).

**Status:** OPEN

## BUG-1012

**Command / Area:** CDPROFILE (and the older long-section output) (Civil records, schedules and sheets), ledger F-211.

**Symptom:** A pipe that crosses the last side of a closed property boundary (the side drawn from the final corner back to the first) gets no boundary mark on its long section. MEDIUM.

**Expected behaviour:** The long section reads the closing side of a closed boundary polyline, so a pipe crossing that side gets its boundary mark (fix with FB-20 / BUG-764, same function).

**Reference:** CODEX_SWEEP_S11 S11-06; `LongitudinalSectionViewModel.cs:1181-1223`. Installed Civil 3.0.70. Sonnet check 23 Oct: VERIFIED. Existing: none. Same function as FB-20 / BUG-764 (marks measured on a straight line, not along a bent pipe), which does not mention closed polylines. Flag to the FB-20 builder: fix both in one pass.. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Closed lightweight polyline (0,0),(10000,0),(10000,10000),(0,10000) on the boundary layer; segment list from `CollectBoundarySegments` expected 4 segments (today 3), and a pipe from (-5000,5000) to (5000,5000) expected one boundary mark at 5.00 m.

**Status:** OPEN

## BUG-1013

**Command / Area:** CESHEETS / CESHEETSCLASSIC (Sheets window and palette); no switch (Structural), ledger F-214.

**Symptom:** After a colleague adds a new sheet layout to a drawing, clicking Save sheet list in the Sheets window makes it say the list matches the drawings, and the new layout is missing from the list and from issuing until you press a scan button. MEDIUM.

**Expected behaviour:** Saving the sheet list does not move the 'last scanned' time; only a real scan does, so a new layout keeps the list marked out of date.

**Reference:** CODEX_SWEEP_S13 S13-04; `CeSheetsManifestService.cs:36-50 and :55-76; CeSheetsManagerWindow.xaml.cs:270-285, :486-497`. Installed Structural 1.0.121. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code (stamp the time only in the scan path, keep a separate saved-at time); Structural brief required, Codex may edit only on a Structural brief. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Save a manifest scanned at T0, touch a tracked DWG at T1 > T0, call `Save` at T2 then `IsStale`; expected true (today false).

**Status:** OPEN

## BUG-1014

**Command / Area:** XCLMTXT then Insert Selected (the static-frame fallback, CreateStaticScheduleFrame, does follow the UCS, but only runs when the block is missing or fails) (Structural), ledger F-215.

**Symptom:** If you rotate the UCS 90 degrees and then insert the member schedule, the beam sizes turn with your UCS but the schedule box stays square to World, so the text no longer sits inside its box. MEDIUM.

**Expected behaviour:** With a rotated UCS, the XCLMTXT schedule frame turns with its text.

**Reference:** CODEX_SWEEP_S14 S14-04; `Modules/Structural/Services/ExcelMTextService.cs:3640-3642, 3710, 3717, 4897-4898, 4975-4978`. Installed Structural 1.0.121. Sonnet check 23 Oct: VERIFIED. Existing: none (F-055 is the same family for CEMEMBER, not this command). Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Synthetic mm drawing with MEMBER SCHEDULE block, UCS Z 90, XCLMTXT Insert Selected at 0,0: frame BlockReference.Rotation must equal 90 degrees (today 0) and match the size MTEXT rotation.

**Status:** OPEN

## BUG-1015

**Command / Area:** RIB and REB (both pass requiresRaftHost: true, :1112 and :1115); THC likely the same shape at :1103 (Structural), ledger F-216.

**Symptom:** Pick an ordinary line for RIB on a drawing with no slab and CE says "No slab perimeter contains the selected point" but has already moved your line onto the SLAB INTERNAL BEAM layer (or left a new loose line if you clicked two points). MEDIUM.

**Expected behaviour:** RIB and REB check for a slab before changing or drawing the line, so a refusal leaves the drawing as it was.

**Reference:** CODEX_SWEEP_S14 S14-05; `Modules/Structural/Services/FoundationService.cs:1312-1351, 3816-3896`. Installed Structural 1.0.121. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Line (0,0)-(3000,0) on layer AUDIT-CENTRELINE, no slab: RIB / 1 / 300 / 0, pick the line; after the refusal the line's layer must still be AUDIT-CENTRELINE (today SLAB INTERNAL BEAM).

**Status:** OPEN

## BUG-1016

**Command / Area:** CECHECKLIST, Select Template, Edit Templates, OK (Structural), ledger F-218.

**Symptom:** If a colleague has sent a suggestion for the checklist and anyone then edits and saves the checklist templates, the waiting suggestion is silently deleted and the review window says there are none. MEDIUM.

**Expected behaviour:** Saving edited checklist templates keeps the pending suggestions file.

**Reference:** CODEX_SWEEP_S15 S15-04; `Modules/Structural/Core/Checklist/TemplateManager.cs:1290-1316`. Installed Structural 1.0.121. Sonnet check 23 Oct: VERIFIED (one correction to the reviewer's test: the save only runs after the user clicks Edit Templates and accepts, not on a plain Apply). Existing: none. Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Temp Templates folder with `pending_changes.json` holding one suggestion plus two template files: call SaveAllTemplates(two templates); the pending file must still exist with one suggestion (today deleted).

**Status:** OPEN

## BUG-1017

**Command / Area:** CEMANAGER window (Open Repair, hub, help, settings, Load Now buttons); CEBLOCKS palette tiles. No switch; always on. (Release, installer and Manager), ledger F-219.

**Symptom:** If you start LINE or TEXT, leave CE Manager open beside the drawing and click Open Repair (or click a block in the CE Blocks palette), AutoCAD gets the word "CDREPAIR" (or "CEBLOCKINSERT") as the answer to its current question, so the point is rejected, or at a "Enter text:" prompt the word is written into your text. MEDIUM.

**Expected behaviour:** Manager buttons (Open Repair, hub, help, Load Now) and CE Blocks tiles cancel a running command first, the same way the CE ribbon does, so the command name is never typed into another command's prompt.

**Reference:** CODEX_SWEEP_S16 F1 + Opus Manager review B3; `PluginManagerWindow.xaml.cs:534-540 (BtnOpenRepair_Click) and :894-901 (SendCommand); same helper also serves PluginManagerWindow.xaml.cs:515 (hub button), PluginManagerWindow.Help.cs:102 and :241 (help, CESUPPORT); fallback senders ...`. Installed Civil 3.0.70 / Manager 1.1.70 (Manager).. Sonnet check 23 Oct: VERIFIED. Existing: CE Blocks half = Opus review item B3 (REVIEW_CEMEMBER_AND_MANAGER_2026-10-23.md). Open Repair half = none (not in BUG_CARPARK, FB-01..25 or F-001..F-151; BUG-828 is the ribbon-only fix of the same .... Fix kind: code (one shared Manager dispatcher that calls `RibbonBuilder.BuildSendString(cmd, !string.IsNullOrEmpty(doc.CommandInProgress))`); tests needed: string-builder test per call site.. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = open drawing, Manager loaded; Run `_.-TEXT`, `0,0`, `2.5`, `0`, then at "Enter text:" click Open Repair; expected = no TEXT entity with string CDREPAIR and Repair window opens. Unit form: the helper returns "\u0003\u0003CDREPAIR\n" when CommandInProgress is non-empty.

**Status:** OPEN

## BUG-1018

**Command / Area:** CDPIPEOBJ, CDC7UPGRADE, pipe split, edit/grips on existing pipe objects. Behind PipeObjectUpgradeGate (colleague hold; options.pipeObjectUpgrade, held on colleague PCs by Tim's 26 Sep ruling), so colleagues do not reach ... (Civil commands, Undo and Checks), ledger F-223.

**Symptom:** If CE's pipe-object file was not loaded the first time Civil asked for it, loading it later (ARX, Load) does not wake it up; CDPIPEOBJ keeps saying "needs the CE pipe object enabler" until you restart AutoCAD. MEDIUM.

**Expected behaviour:** If the pipe-object file is loaded after Civil first asked for it, Civil notices on the next command instead of saying 'needs the CE pipe object enabler' until a restart.

**Reference:** CODEX_HUNT_COMPAT COMPAT-03; `CeCvlObjectsBridge.cs:83-99 (and :129, :200, :299 dependents)`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED for the code; UNPROVEN that ordinary startup order hits it (reviewer says the same). Existing: none (grep CeCvlObjectsBridge, CE_CVL_OBJECTS_2027 in carpark; the two hits are about Disable on Restart and the installer .dbx owner check).. Fix kind: code (do not cache a negative result, or retry on command; keep API-version check). Protected: yes. Lane: Sonnet (protected file); base claude/rel-20261022m. Test: fixture = bridge with an injectable probe that throws DllNotFoundException then returns version 4; `IsAvailable` called twice expected = false then true (today false, false).

**Status:** OPEN

## BUG-1019

**Command / Area:** CDCALC > Detention system. No switch ("Use pit cover as TWL (suggested)" tick drives the invented value). (Civil engineering numbers), ledger F-224.

**Symptom:** On a job where the pipes sit below RL 0.00 (for example inverts of -1.000 and -1.100), CDCALC invents a top water level of 0.00, adds extra pit storage and a 1,100 mm baffle, and never warns when your typed water level is above the lid. MEDIUM.

**Expected behaviour:** CDCALC treats real levels at or below RL 0.00 as known: a suggested water level of -0.700 is shown, and a water level above a -0.500 lid warns.

**Reference:** CODEX_HUNT_DESIGN DESIGN-02; `DetentionSystemViewModel.cs:708-717, :818-825, :845, :1278-1296`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: none. Same family (zero or negative level treated as missing) as carpark entries at lines 2274 (CDSURVEY drops RL below 0) and 2406 (level exactly 0), but a different command.. Fix kind: code (decide "known and finite" separately from sign). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = one selected pipe IL -1.000/-1.100, DN300; `ComputeSuggestedTwl` expected = -0.700 (today 0.00); with TWL -0.400 and pit cover -0.500, `TwlWarningText` expected = non-empty, 100 mm over.

**Status:** OPEN

## BUG-1020

**Command / Area:** CDPROFILE (long section), Review then Apply. Long-section office layout setting must list INVERT DEPTH for the text to show. (Civil records, schedules and sheets), ledger F-225.

**Symptom:** On a long section A-B-C through pit B, if a third pipe leaves B lower than the through pipes (or the pit floor is recorded lower), the section still shows B at the route depth, for example 1.00 m deep, and draws the pit bar ending above that lower pipe. MEDIUM.

**Expected behaviour:** A long section's pit depth uses the lowest of the recorded floor and every connected pipe, or warns that the depth is unresolved (which rule wins when they disagree is Tim's call).

**Reference:** CODEX_HUNT_DESIGN DESIGN-03; `ProfileRouteReviewService.cs:403-444; ProfileRouteEvidenceCaptureService.cs:787-880; LongitudinalSectionService.cs:1242, :1364, :1773, :2035-2049`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: none. FB-22 / BUG-766 is the missing branch junction MARK, a different symptom; the report itself says so.. Fix kind: code, plus needs Tim's word on which rule wins when the recorded floor and the connected inverts disagree. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = A-B-C route inverts through B 10.020/10.000, side pipe B-D invert 9.500, B cover 11.000; resolved B depth expected = 1.50 m or an "unresolved depth" warning (today 1.00).

**Status:** OPEN

## BUG-1021

**Command / Area:** CDTWL. No switch. (Civil engineering numbers), ledger F-226.

**Symptom:** A pit whose cover is known (RL 10.200) but whose floor is unknown is dropped from CDTWL's lid check, so CDTWL reports a higher pit (RL 12.000) as the lowest lid and does not warn that your chosen water level (RL 10.500) is above the low lid. MEDIUM.

**Expected behaviour:** CDTWL keeps a pit's known lid level in the low-lid check even when that pit's storage cannot be worked out.

**Reference:** CODEX_HUNT_DESIGN DESIGN-04; `DetentionBranchCollector.cs:175-215; TopWaterLevelCandidates.cs:224; DetentionTwlSolver.cs:142; DetentionTwlService.cs:303`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: none (HUNT2-C-12..15 at carpark line 10089 cover pit-centre storage, freeboard setting names, CDDESIGN wording, LandXML units; not this).. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = branch with pit LOW cover 10.200, floor blank, no connected invert, plus pit P1 cover 12.000; `LowestCoverLevel` of all pits expected = 10.200 (today 12.000).

**Status:** OPEN

## BUG-1022

**Command / Area:** PITSCHEDULE, CDSYNC and any command that runs EnsureDrawingDataCurrent (runs on drawing load/change). No switch. (Civil records, schedules and sheets), ledger F-228.

**Symptom:** If a pit block gets a new internal handle (for example after a copy or re-insert) CE says it re-found the pit, but the typed override in the Pit Schedule (say Cover 11.25) and the pit's saved place in the list are left on the old handle, so the schedule shows the drawing value (10.00) and the override sits as "lost source pit". MEDIUM.

**Expected behaviour:** When CE re-finds a pit under a new handle, its Pit Schedule override and saved row order move to the new handle with it.

**Reference:** CODEX_HUNT_RECORDS R-05; `ProjectDataService.cs:398-480; ProjectDataService.Recovery.cs:603-650; PitScheduleViewModel.Data.cs:267, :499, :923; PitScheduleViewModel.Schedule.cs:478, :529, :651`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: none (grep ReconcileOrphanedHandlesByPosition, IsOrphaned, "lost their linked source pit" in carpark, ledger, FB).. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = project with pit P1 handle H-old (unresolved) at (0,0), block with H-new, manual row SourcePitHandle=H-old IsLinkedOverride Cover 11.25; run Reconcile + Restore; expected = row.SourcePitHandle == H-new, IsOrphaned false, Cover 11.25.

**Status:** OPEN

## BUG-1023

**Command / Area:** PITSCHEDULE. Setting linking.scheduleRowOrderByPit default true (does not affect the stale test). (Civil records, schedules and sheets), ledger F-229.

**Symptom:** You put P2 above P1 in the Pit Schedule, add P3, reopen the schedule, and the list is back in P1, P2, P3 order. MEDIUM.

**Expected behaviour:** Adding one pit keeps the saved Pit Schedule order for the existing rows (this changes the BUG-008 90 per cent rule, so Tim decides and BUG-008 is re-tested).

**Reference:** CODEX_HUNT_RECORDS R-06; `PitScheduleViewModel.Data.cs:904-940; PitScheduleRowOrder.cs:21`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: not a duplicate of BUG-786 (carpark 1120, pit group split, fixed via PR #1422, which this code includes). Root is the BUG-008 90% rule (carpark 7680). Matched by grep ApplyPersistedSortOrder, .... Fix kind: code, needs Tim's word (drop the cutoff and treat only unmatched keys as unknown, which reopens the BUG-008 symptom unless re-tested). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = saved map {P2:0,P1:1}, rows P1,P2,P3; Arrange expected order = P2,P1,P3 (today P1,P2,P3).

**Status:** OPEN

## BUG-1024

**Command / Area:** CDSPINEUPGRADE (DryRun / Apply / Rollback). No switch. (Civil records, schedules and sheets), ledger F-230.

**Symptom:** After a record rebuild, your pits and pipes still carry their permanent IDs in the drawing but CE's project record has lost them; CDSPINEUPGRADE Apply prints "Every object already has its identity. Nothing to write." and leaves the two out of step. MEDIUM.

**Expected behaviour:** CDSPINEUPGRADE Apply compares the drawing's identities with the project record and fills missing record identities, instead of saying 'Nothing to write'.

**Reference:** CODEX_HUNT_RECORDS R-07; `SpineUpgradeCommand.cs:67-123; LinkService.Spine.cs:74,89; ProjectDataService.Spine.cs:41,62`. Installed Civil 3.0.70.. Sonnet check 23 Oct: VERIFIED. Existing: none (grep SpineUpgrade, "Nothing to write", W26-26_C01 in carpark; spine in ledger/FB).. Fix kind: code (compare object keys with project rows, not just count new keys). Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: fixture = plan with only KeepExistingKey steps (NewKeyCount 0) and project rows with blank SpineKey; run RunUpgrade Apply; expected = project rows filled and message not "Nothing to write".

**Status:** OPEN

## BUG-1025

**Command / Area:** CSREOBAR, CSBARSCHEDULE (refresh) (Structural), ledger F-231.

**Symptom:** In a drawing set to metres, a 100 mm bar drawn straight onto a millimetre layout sheet is labelled "100000" long in the note and the bar schedule, while the text and arrows look the right size. MEDIUM.

**Expected behaviour:** CSREOBAR measures a bar drawn on a layout in paper millimetres, so a 100 mm bar reads 100 in the note and schedule whatever the model units.

**Reference:** CODEX_HUNT_STRUCTCMDS SC-03; `Modules/Structural/Services/ReoBarService.cs:138-142, 424, 490-491; Core/Rebar/ReoBarCore.cs:162-167`. Installed Structural 1.0.121. Sonnet check 23 Oct: VERIFIED. Existing: none. Fix kind: code. Protected: yes. Lane: Sonnet, or Codex on a Structural brief; base claude/rel-20261022s2. Test: Layout in a drawing with INSUNITS 6, bar extent (20,20)-(120,20) in paper space: length must be 100 mm (today 100000); control in metre model space extent 0.1 gives 100 mm.

**Status:** OPEN

## BUG-1026

**Command / Area:** CEMANAGERLOGS; CE Tools > Open Logs; Manager menu > Logs (Release, installer and Manager), ledger F-236.

**Symptom:** Support asks a colleague to open the logs and send CE_CVL_SUITE.log; CEMANAGERLOGS opens %APPDATA%\CE_CADTOOLS, which holds no CE log, so the real log never arrives. MEDIUM.

**Expected behaviour:** Open Logs (CEMANAGERLOGS) opens the folder that holds CE_CVL_SUITE.log (and the Structural log folders when Structural is loaded).

**Reference:** Opus Manager review B1; `Modules/Manager/Services/CeSupportBundleService.cs:218-229 (Civil log is in CE_CVL_SUITE\logs, LoggingService.cs:68-70)`. Installed Manager 1.1.70. Opus check 23 Oct: VERIFIED (Opus Manager review, code and disk; Opus PR review A confirms #1535 targets it). Existing: none in carpark; fix drafted in PR #1535 (MERGE-WITH-FIXES). Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: type CEMANAGERLOGS: the new Explorer window path ends \AppData\Roaming\CE_CVL_SUITE\logs and contains CE_CVL_SUITE.log.

**Status:** OPEN (fix drafted in #1535, not installed)

## BUG-1027

**Command / Area:** CESUPPORT (Release, installer and Manager), ledger F-237.

**Symptom:** After a CEMEMBER or grip problem the support zip holds only the short Structural log and no grip log, so the desk needs a second round trip for the file that shows what happened. MEDIUM.

**Expected behaviour:** The support zip holds, or names as left out, the Structural daily and command logs, Structural RuntimeDiagnostics, the Civil grip and ribbon-click logs and the latest office diagnostics report.

**Reference:** Opus Manager review B2; `Modules/Manager/Services/CeSupportBundleService.cs:29-54, 132-150; CeDiagnosticsService.cs:300-311`. Installed Manager 1.1.70. Opus check 23 Oct: VERIFIED (Opus Manager review, code and disk). Existing: none in carpark; fix drafted in PR #1535. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: seed a temp profile with the four missing files: the zip has an entry for each, or WHAT_IS_IN_THIS_ZIP.txt names each as left out.

**Status:** OPEN (fix drafted in #1535, not installed)

## BUG-1028

**Command / Area:** AutoCAD start-up (Manager ribbon build) (Release, installer and Manager), ledger F-238.

**Symptom:** If the CE Tools tab never appears, nothing anywhere says why; a stray comma in manager-switches.json turns every Manager switch off with no message. MEDIUM.

**Expected behaviour:** A ribbon tab that fails to build, or a broken manager-switches.json, leaves a line in a CE log and one plain command-line notice.

**Reference:** Opus Manager review B4; `Modules/Manager/Services/CeUnifiedRibbonService.cs:150-172; CeOneGlanceStatus.cs:219-222, 367-370; CeBlocksSettings.cs:72-104`. Installed Manager 1.1.70. Opus check 23 Oct: VERIFIED (Opus Manager review). Existing: none in carpark; fix drafted in PR #1535. Fix kind: code. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: a test ribbon contributor that throws leaves one line in crash_trace.log naming the tab; a broken switch file leaves a 'switch file is broken' line.

**Status:** OPEN (fix drafted in #1535, not installed)

## BUG-1029

**Command / Area:** the old-style CE menu on AutoCAD 2022 to 2024 (net48) (Release, installer and Manager), ledger F-240.

**Symptom:** A colleague on AutoCAD 2024 cannot find CE Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate or Copy + Rotate on any menu; they only work if typed. MEDIUM.

**Expected behaviour:** On AutoCAD 2022 to 2024 the CE menu carries CE Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate and Copy + Rotate (Tim confirms a menu entry per tool is wanted).

**Reference:** Opus Manager review B6; `Modules/Manager/Assets/Config/ce_toolbar_layout.json; Modules/Manager/Services/CeUnifiedRibbonService.cs:27-43`. Installed Manager 1.1.70 (Civil 3.0.70 for the second menu). Sonnet check 23 Oct: VERIFIED (and extended: Civil's own older-AutoCAD menu layout lacks them too). Existing: none. Fix kind: settings row (add entries to the layout file; the commands already exist and are in command-registry.json, which the menu service reads) -- confirm with Tim that a menu entry per tool is wanted. Protected: no. Lane: Codex or Sonnet; base claude/rel-20261022m. Test: Static: Manager's ce_toolbar_layout.json sourceCommand set contains CEHEALTH, CESUPPORT, CE_VERSION, CESURVEYREVIEW, CEBLOCKS, MR, CR (today none).

**Status:** OPEN
