# Findings ledger: every audit and hunt finding, deduplicated and triaged (22 Oct 2026)

Compiled Thu 22 Oct 2026 late to Fri 23 Oct early (Melbourne), headless desk job plan/03, Sonnet. Compile only: no source changed, nothing built, no AutoCAD, no Codex. Nothing here is built, tested, installed or Tim-accepted unless an entry says so.

**Sources read (10 files, all that existed at 00:10 Fri 23 Oct):** AUDIT_C58_C60_S40_S41 (Opus, "OPUS-A"), AUDIT_ENGINEERING_CIVIL (Opus, "OPUS-E"), AUDIT_UI_WORDING (Opus, "OPUS-UI", 68 lines merged into 40 entries), CODEX_AUDIT_CIVIL ("CDX-C"), CODEX_AUDIT_STRUCTURAL ("CDX-S"), CODEX_AUDIT_GATE ("CDX-G"), CODEX_HUNT_UNDO, CODEX_HUNT_IMPORT, CODEX_HUNT_LABELS, CODEX_HUNT_MANAGER. Also BUG_CARPARK.md (grep only), RELEASE_9NOV_GAP_PLAN and the open PR list.

**Not yet arrived, so NOT in this ledger (see "Late sources" at the end):** AUDIT_ENGINEERING_STRUCTURAL, CARPARK_RECONCILIATION, and eight hunts (settings, windows, records, design, structcmds, privacy, perf, compat).

**Left out on purpose (already in the carpark, not recounted):** BUG-859 (downpipe double-click does nothing in 3.0.70; round 2 is #1522), BUG-860, BUG-505/725 unit guesses, BUG-781, BUG-804, BUG-719, BUG-729. Findings a source marked "known, not counted" stay out here too.

---

## ANSWER FIRST (for Tim)

1. **124 distinct findings.** By severity: **HIGH 30, MEDIUM 66, LOW 28.** Eight findings were seen by two sources (the higher severity was kept). The Opus wording audit's 68 lines became 40 entries (same-file wording faults merged).
2. **By area:** wording and windows 40; Civil engineering numbers 28; release, installer and Manager 16; Civil commands, Undo and Checks 12; Structural 12; Civil labels and Tidy labels 10; Civil imports 6.
3. **By source (a finding seen by two sources counts under both):** Opus engineering 28; Opus C-58 to S-41 15; Opus wording 40; Codex gate 14; Codex Civil 9; Codex Structural 8; Codex undo hunt 3; Codex import hunt 6; Codex labels hunt 6; Codex Manager hunt 3.
4. **In the code installed for 9 Nov Civil + Manager (3.0.70 / 1.1.70): 99.** About 25 of those sit behind switches that are OFF by default (Ignore a finding, Tidy labels, wrong-layer rows and similar), so Max will not meet them on day one. Another 2 are bugs inside #1522, which is not installed yet. 11 are release and installer faults (not drafting code). 12 are Structural only (1.0.121), and Structural does not ship to Max.
5. **Already have a BUG id: 15.** The other 109 are NEW. 82 of the new ones are HIGH or MEDIUM and have a ready entry below (BUG-873 to BUG-954). **Open PR touches 7:** F-001 (#1523), F-002 (#1525) and F-102 (#1526) directly; F-028 and F-062 are faults inside #1522 to fix before it ships; F-020 (#1492) and F-022 (#1503, #1493) only in part.
6. **Need Tim's engineering or design word: 25** (list below).
7. **A numbering fault in the carpark:** BUG-866 is used twice (CDCHECKIGNORE Undo, and the rainfall-curve note, F-008). The desk should renumber one before appending. BUG-873 is the next free number.
8. **The 12 most likely to hurt a colleague on 9 Nov** (Max on Civil + Manager, hand install):
   1. **F-004:** pressing Esc to finish CD right after a pipe with a callout label can leave the label unlinked, so erasing the pipe leaves the label behind.
   2. **F-006:** CDRULES and CDCHECKS grade a bent pipe on the straight pit-to-pit distance, so a pipe drawn at 1 in 240 passes as 1 in 170.
   3. **F-007:** the pipe-size redesign treats every pipe as UPVC, so a concrete 375 is called a fit for 200 L/s when it carries 154.
   4. **F-008:** CDDESIGN says the office rainfall curve reads "high" and storage is on the safe side; on both Glen Eira jobs it reads 6 to 8 per cent LOW and storage is about 18 per cent short (2.12 m3 instead of 2.58 m3).
   5. **F-009:** an X-Civil or LandXML Replace erases the old pit first, then finds it cannot draw the new one (locked cover-text layer), so the pit simply vanishes.
   6. **F-010:** on the import review page, choosing a different source file and clicking Read source can import the OLD file.
   7. **F-011:** a LandXML pipe can be given an invert level the file assigns to a different pipe.
   8. **F-044:** moving a pit with a held 1 in 100 grade can leave the pipe flatter (1 in 102), where CD itself rounds safe.
   9. **F-046:** the Pit Schedule says 0.85 m (no step irons) where the pit floor makes it 950 mm (step irons needed).
   10. **F-048:** CDTWL on a metre drawing counts every pipe 1,000 times too small, so storage reads short and freeboard wrong.
   11. **F-032:** clicking an Inspector count such as "Flat / backfall pipes" takes a drawing-edit lock even when the count is 0, which can eat the next U or lose REDO.
   12. **F-019:** the installer script rebuilds the native files instead of sealing the tested ones, so Max can get files nobody tested (the "payload 85" fault). The other install blockers (F-016, F-017, F-018) are avoided by the hand install the gap plan chose, but only if that is rehearsed on a standard-user login.
9. **Also worth a look on 9 Nov:** F-065 (CE_VERSION can say "Not loaded" for a loaded tool, and Max quotes that version in every bug report) and F-083 (the Manager window tells a colleague to run an installer only the administrator can run).
10. **What the desk does first:** review #1523, #1525, #1524, #1522 as already planned; give the Sonnet lane the top 20 fix briefs at the end; keep F-016 to F-018 on the "cut, hand install" list.

### Needs Tim's engineering or design word (25), batched

1. **Rainfall note (F-008):** may CDDESIGN say "may be high or low by up to about 8 per cent; storage moves about 2.5 times as much"? (Recommend yes; wording only, the calculation does not change.)
2. **Cover and levels (F-042, F-043, F-052, F-053):** cover to the OUTSIDE top of the pipe with a wall-thickness table, cover along the pipe between pits, an obvert warning where a pipe gets bigger, and Tim's values for the council numbers still written in code. (Recommend all four after 9 Nov.)
3. **Grade ladder (F-045, F-074):** is "375 at 1 in 300 but 450 and up at 1 in 200" the office rule? One confirmation fixes both entries.
4. **Storage figures (F-047, F-050, F-067):** one shared hard-ground C (0.9 or 1.0), pipes counted wall to wall, and whether the stored orifice level is the invert or the centre.
5. **Structural drawing behaviour (F-055, F-056, F-081):** should a CEMEMBER section follow the UCS; should break marks and hatch density follow paper height on a layout sheet; should CEHATCHAUDIT flag older LBH and LBUH hatches?
6. **Label and Settings choices (F-063, F-064, F-103, F-104):** leader-out distance in paper or ground millimetres; the name stored with an ignored check (Windows login, initials or a Setting); one name for the Settings window; one name for Drawing Standards versus Suite Manager.
7. **Install and release (F-016, F-017, F-023, F-025, F-026):** the first-install route for a colleague without administrator rights (gap plan: hand install now); the behaviour-switch comparison against a fresh PC; corporate Windows trust (IT); the older-AutoCAD-year hold on one-piece CE pipes and Max's AutoCAD year.
8. **CD and import (F-033, F-076, F-077):** is the extra U after cancelling the window-first CD acceptable; unitless drawing read as millimetres with one soft line (gap plan question 4, recommend yes); full-bore speed for self-cleansing (information only).

---

## How to read an entry

1. **Severity:** HIGH, MEDIUM or LOW, the higher where two sources differ. 2. **Evidence:** every item is "verified by reading" unless it says "seen in log" or "suspected". Nothing was run in AutoCAD by the sources except where the Opus audit quotes the real CE log. 3. **Installed:** Civil/Manager 3.0.70 = train C-60 (`claude/rel-20261022m` @ `40ee0a36`); Structural 1.0.121 = `claude/rel-20261022s2` @ `2c9a9694`. 4. **PR:** open PRs checked with `gh pr list --state open`. 5. **Lane:** Sonnet fixer, Codex build, or Opus design. 6. **Test:** one deterministic line; the full steps are in the named source. 7. **Layout:** HIGH first, then MEDIUM, then LOW grouped by area; ids are not in strict number order where an entry moved severity.

---

## HIGH (30)

1. **F-001. The "Command outcome" log line calls a successful Esc-finished PIT, CD or DP "cancelled", and a CE refusal "completed".**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A finding 1, CDX-C finding 6 (MEDIUM, suspected). **Installed:** Civil 3.0.70 (and Structural 1.0.121 shows three CEMEMBER records as "cancelled", suspected).
   - **For Tim:** the log (and the robot's evidence) says a pit placement that worked did not work.
   - **Where:** `Modules/Drainage/Services/CommandOutcomeLogService.cs:62-80, 184`. **BUG:** BUG-862. **PR:** #1523 (fix drafted). **Fix kind:** code. **Lane:** Sonnet fixer (in flight), then Opus review. **Test:** PIT, place one pit, Esc: the outcome line must not read plain "cancelled".

2. **F-002. CDCHECKIGNORE with its switch OFF saves the CE project record into the drawing before it checks the switch, then says "Nothing was changed".**
   - **Severity:** HIGH (Codex), MEDIUM (Opus). **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A 2, CDX-C 1. **Installed:** Civil 3.0.70 (switch OFF).
   - **For Tim:** the message is false: CE has just rewritten its record in the drawing, twice (seen in the log at 20:34:45).
   - **Where:** `Modules/Drainage/Commands/CheckIgnoreCommand.cs:35-38`; `CeCommandBase.cs:29,43`; `ProjectDataService.cs:249-254`. **BUG:** BUG-863. **PR:** #1525. **Fix kind:** code. **Lane:** Sonnet fixer (in flight). **Test:** switch OFF, `CDCHECKIGNORE`: no "Project data saved" log line and no `PROJECT_ACTIVE` marker added.

3. **F-003. Tidy labels (CDTIDYLABELS) takes the same writing start-up before its switch, selection, preview and Yes/No, so answering No or pressing Esc still writes to the drawing.**
   - **Severity:** HIGH. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 1 (second half). **Installed:** Civil 3.0.70 (the switch is OFF for Max).
   - **For Tim:** a "No" to moving labels can still leave the drawing changed.
   - **Where:** `Modules/Drainage/Commands/TidyLabelsCommand.cs:35`; `CeCommandBase.cs:29,43`. **BUG:** NEW (proposed BUG-873). **PR:** none (#1525 covers CDCHECKIGNORE only). **Fix kind:** code. **Lane:** Sonnet fixer (same pattern as #1525). **Test:** `CDTIDYLABELS`, All, No: no write event on the CE project Xrecords.

4. **F-004. Esc after an accepted CD placement throws away the deferred callout registration, so the pipe and its callout are not linked.**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-01. **Installed:** Civil 3.0.70.
   - **For Tim:** place a pipe with a callout label, press Esc for the next pipe, then erase the pipe: the label stays behind (or the arrow stays at the old position).
   - **Where:** `Services/LinkService.Reactors.cs:1420,1542,1557`; `LinkService.Registration.cs:978`; `Commands/CdCommand.cs:214,235,1196`. **BUG:** NEW (proposed BUG-874). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** CD with Callout, pipe placed, Esc; the pipe's PIPE_LINK attachment list must contain the MLeader handle.

5. **F-005. An ignored Checks warning stays hidden after the design changes, because the remembered fingerprint leaves out the pit, the clearances and the actual/required layer.**
   - **Severity:** HIGH. **Area:** Civil commands, Undo and Checks. **Sources:** CDX-C 2. **Installed:** Civil 3.0.70 (switch OFF).
   - **For Tim:** a "pipe does not fit the pit" warning you accepted stays hidden after the pit is made smaller.
   - **Where:** `Commands/CheckIgnoreCommand.cs:121`; `Services/Checks/ChecksResult.cs:228-235,288-296`; `Services/Checks/IgnoredChecks.cs:198-263`. **BUG:** NEW (proposed BUG-875). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** ignore a fit row, change only the pit's clear X from 600 to 400: the row must return as "Asked again".

6. **F-006. CDRULES and CDCHECKS work grade and speed on the straight pit-centre distance, not the drawn route or the real length.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 1. **Installed:** Civil 3.0.70.
   - **For Tim:** a bent pipe labelled 1 in 240 is judged 1 in 170 and passes the 1 in 200 minimum; capacity reads 19 per cent high.
   - **Where:** `Rules/RulebookEngine.cs:77,88-89`; `Services/PipeGeometryHelper.cs:128-171`. **BUG:** BUG-867. **PR:** none yet (Codex cx_b07_real_length_c60 queued; brief `areas/CODEX_BUILD_ENG_REAL_LENGTH_22OCT.md`). **Fix kind:** code. **Lane:** Codex build. **Test:** P1 (0,0) to P2 (12000,12000), DN225, 10.000 to 9.900, route 24.0 m: R-03 must Warn "1:240".

7. **F-007. CDRUNSOLVE, the network redesign and size proposals treat every pipe as UPVC.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 2. **Installed:** Civil 3.0.70.
   - **For Tim:** on a concrete line the solver thinks the pipe carries about 23 per cent more than it does.
   - **Where:** `Services/NetworkDesignService.cs:286,520`; callers `RunSolveCommand.cs:143`, `AutoDesignOrchestrator.cs:212`, `NetworkRedesignSolverService.cs:23`, `ProposalApplyService.PlanBuilders.cs`. **BUG:** BUG-868. **PR:** none yet (cx_b08 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** two-node network, Q 200 L/s, 20 m, material RCP: expect DN450 (or DN375 at 1 in 77 or steeper), not DN375 at 1 in 130.

8. **F-008. CDDESIGN calls the office rainfall curve "about 7 to 9 per cent high"; on the two real Glen Eira sheets it reads 6 to 8 per cent LOW.**
   - **Severity:** HIGH. **Area:** Civil engineering. **Sources:** OPUS-E 3. **Installed:** Civil 3.0.70.
   - **For Tim:** storage is about 18 per cent short (job 24-115: 2.12 m3 against 2.58 m3 issued) while the note says safe side.
   - **Where:** `Rules/RainfallCurve.cs:241-247,27-31`; `Services/AutoDesignService.cs:185-188`. **BUG:** BUG-866 (second use of that number; renumber). **PR:** none. **Fix kind:** needs Tim's word (wording only for now). **Lane:** Sonnet fixer after Tim's yes. **Test:** `SizeBoyds` area 640.67, C 0.6718, PSD 5.87: SSR 2.123 m3 (plus or minus 0.005) and the note must not contain "high".

9. **F-009. Replace deletes the old imported pit before checking whether the new one can be drawn (new cover text needs a locked layer).**
   - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 1. **Installed:** Civil 3.0.70. **Related:** BUG-731, BUG-417.
   - **For Tim:** updating a pit with no cover level to CL 12.00 can make the pit disappear if 25TEXT is locked.
   - **Where:** `Services/XcivilImportService.cs:1921,1950` (X-Civil `:975,986`); `Services/XcivilImportReportService.cs:725-815`; `Rules/XcivilImportLockedLayers.cs:51`. **BUG:** NEW (proposed BUG-876). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** import old.xml (no elevRim), lock 25TEXT, Replace with new.xml: old P11 handles must survive and a warning must say it was kept.

10. **F-010. Choosing another file on the import review page then clicking Read source imports the previously read file.**
    - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 2. **Installed:** Civil 3.0.70.
    - **For Tim:** you notice the wrong file, pick the right one, and the wrong one is drawn.
    - **Where:** `Commands/LinkCommands.ImportXcivil.cs:73,164-179,400-467`; `Dialogs/CivilImportWindow.xaml.cs:37,49,73`; `ViewModels/CivilImportWindowViewModel.cs:53,60`. **BUG:** NEW (proposed BUG-877). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** read A.xml, choose B.xml, click Read source: a review of B (P21) must appear and P11 must not be drawn.

11. **F-011. The single-level shortcut gives a pipe an invert the file explicitly names for another pipe.**
    - **Severity:** HIGH. **Area:** Civil imports. **Sources:** HUNT-IMPORT 3. **Installed:** Civil 3.0.70. **Related:** BUG-605.
    - **For Tim:** pipe B gets 9.75 m although the file says that level belongs to pipe A.
    - **Where:** `Helpers/LandXmlParser.cs:260,277,328`; `Services/XcivilPipeInsertionService.cs:325-503`; `XcivilImportService.cs:2065`. **BUG:** NEW (proposed BUG-878). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** named-invert fixture (A refers to P99): B's P31-end invert stays Unknown, log shows `no-level-names-this-pipe`.

12. **F-012. Hand-placement protection misses CE's own "Slide along pipe" and CDANNOTATIONEDIT moves and the pit cover text, so Tidy labels moves them again.**
    - **Severity:** HIGH. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F1. **Installed:** Civil 3.0.70 (Tidy labels switch OFF for Max).
    - **For Tim:** slide a label carefully beside other notes, run Tidy labels, and it moves again.
    - **Where:** `Services/LinkService.PipeAttachmentActions.cs:323-352`; `Commands/AnnotationEditCommand.cs:89,105`; `Services/ExternalMutationCommandPolicy.cs:14,51,82`; `Services/LinkService.TidyPitText.cs:87,100`. **BUG:** NEW (proposed BUG-879). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** slide L1 along the pipe, add clashing MTEXT, CDTIDYLABELS: L1 position unchanged and counted "placed by hand".

13. **F-013. CEMEMBER and SBEAM re-set the linetype of an existing 18HIDDEN or 9HIDDEN2 layer (the S-41 fix covered only renamed layers).**
    - **Severity:** HIGH (Codex), MEDIUM (Opus). **Area:** Structural. **Sources:** OPUS-A 3, CDX-S F1. **Installed:** Structural 1.0.121.
    - **For Tim:** one CEMEMBER run turns every dashed line on 18HIDDEN into HIDDEN across the drawing, with no message.
    - **Where:** `Services/CeMemberLineWriter.cs:86-92`; `Services/StructuralDetailService.cs:1902,1915,2017`. **BUG:** BUG-864. **PR:** fix drafted by the desk job, no open PR seen. **Fix kind:** code. **Lane:** Sonnet fixer (in flight). **Test:** make 18HIDDEN on Continuous, run CEMEMBER SI 310UB32: `-LAYER ?` must still list Continuous.

14. **F-014. CEMEMBER draws the member and section 1,000 times too big in a metre drawing.**
    - **Severity:** HIGH (Codex), LOW (Opus). **Area:** Structural. **Sources:** OPUS-A 9, CDX-S F2. **Installed:** Structural 1.0.121.
    - **For Tim:** a 310UB32 section comes out 298 m deep; break overshoot and kink have the same fault.
    - **Where:** `Commands/CeMemberCommands.cs:79,128,191`; `Services/CeMemberSectionWriter.cs:102,116`; `Services/CeMemberLineWriter.cs:123`; `DesignCore/SteelSections/CeMemberCatalogue.cs:61`. **BUG:** NEW (proposed BUG-880). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** INSUNITS 6, CEMEMBER SE 310UB32: section 0.149 by 0.298 m.

15. **F-015. Hatch repair puts the old 1:20 value back on a correct new hatch when DIMSCALE and LTSCALE disagree.**
    - **Severity:** HIGH. **Area:** Structural. **Sources:** CDX-S F4. **Installed:** Structural 1.0.121.
    - **For Tim:** a correct LBUH at 1:50 (scale 50) is "repaired" to 20 just because LTSCALE was changed to 1.
    - **Where:** `Commands/HatchUpgradeCommands.cs:343,380,413,576`; `Core/Units/DrawingScaleRule.cs:74`. **BUG:** NEW (proposed BUG-881). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** LBUH at DIMSCALE 50, LTSCALE 1, CEHATCHAUDIT Repair: pattern scale must stay 50.

16. **F-016. The installer needs Windows administrator rights.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 1. **Installed:** release branch, not an installed build. **Related:** BUG-483.
    - **For Tim:** Max is asked for an administrator login before the installer can help him.
    - **Where:** `Installer/app.manifest:7`; `Installer/CE_CVL_SUITE_Installer.csproj:13`; `Modules/Manager/Services/CePluginInstallerService.cs:45`. **BUG:** NEW (proposed BUG-882). **PR:** none. **Fix kind:** needs Tim's word (gap plan: cut, hand install for the pilot). **Lane:** Opus design. **Test:** launch the final installer as a standard user: it installs both bundles into that user's folder without elevation.

17. **F-017. There is no normal first-install route: double-clicking the installer installs nothing.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 2. **Installed:** release branch.
    - **For Tim:** the EXE alone does nothing for Max (usage exit 64; `--install` is retired).
    - **Where:** `Installer/Program.cs:13,21`; `Installer/CeInstallerApplication.cs:77,84,253`; `Modules/Manager/Services/CePluginInstallerService.cs:242`; `CeInstallWords.cs:12`. **BUG:** NEW (proposed BUG-883). **PR:** none. **Fix kind:** needs Tim's word (hand install now). **Lane:** Opus design. **Test:** from a PC with no CE files, the documented route puts Civil and Manager at their expected versions.

18. **F-018. The shared approval file stores one PC's absolute folder paths, so another colleague's PC refuses the same approved update.**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 3. **Installed:** Manager 1.1.70 code.
    - **For Tim:** an update approved on your PC points back at your user folder; Max is told it is outside the allowed folder.
    - **Where:** `Modules/Manager/Services/CeApprovedReleaseService.cs:46,107,108,122,751,761`; `CePluginInstallerService.cs:54`. **BUG:** NEW (proposed BUG-884). **PR:** none. **Fix kind:** code (the gap plan puts it after 9 Nov). **Lane:** Codex build with Opus review. **Test:** approve under root A, copy to root B: `BuildAvailablePlugin` resolves B's package with hashes unchanged.

19. **F-019. Installer packaging rebuilds the files instead of sealing the accepted candidate (the "payload 85" failure).**
    - **Severity:** HIGH (Codex "BLOCKER"). **Area:** Release, installer and Manager. **Sources:** CDX-G 4. **Installed:** release branch.
    - **For Tim:** Max can get freshly rebuilt files that nobody tested.
    - **Where:** `Installer/build_installer.ps1:185,199,215,235,323,332`; `Installer/ReleaseAuthorityPackaging.cs:379,397`; `CE_CVL_SUITE_Installer.csproj:36,81`. **BUG:** NEW (proposed BUG-885). **PR:** none. **Fix kind:** code (edit the existing script; no new script). **Lane:** Sonnet fixer with Opus review. **Test:** read the final EXE's embedded ZIP and compare every file's SHA-256 with the frozen candidate: zero missing, extra or changed.

20. **F-020. The older-than-approved refusal can be bypassed by an empty or stale `--approved-version=` argument; an unknown approval is silent.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 5. **Installed:** release branch. **Related:** BUG-834.
    - **For Tim:** a launcher can install an old signed build even though the office approves a newer one.
    - **Where:** `Installer/CeOfficeApproval.cs:25,30,74`; `Installer/SafeBundleInstaller.cs:268,803,815`. **BUG:** BUG-834 (partly). **PR:** #1492 (BUG-834 base check; does not close the argument bypass). **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** approval 3.0.70, stage 3.0.69, run with omitted, empty and `=3.0.68` flags: all must refuse.

21. **F-021. Civil and Manager can be activated separately, so they can end up with different copies of CE_SHARED.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 6. **Installed:** release branch.
    - **For Tim:** installing only half a release can break the ribbon or commands, depending on load order.
    - **Where:** `Shared/CE_SHARED/CE_SHARED.csproj:15`; `Modules/Manager/CE_SUITE_MANAGER.csproj:179,207`; `Installer/SafeBundleInstaller.cs:252,281,442`; `CeApprovedReleaseService.cs:138`. **BUG:** NEW (proposed BUG-886). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** old pair installed, then Civil-only activation of a release with different CE_SHARED: refused or completed as a pair.

22. **F-022. Structural in the Civil release branch still claims CE_VERSION, which now belongs to Manager (conditional: only if someone ships Structural from this branch).**
    - **Severity:** HIGH (conditional). **Area:** Release, installer and Manager. **Sources:** CDX-G 7. **Installed:** not an installed build; Structural 1.0.121 is built from a different line.
    - **For Tim:** never build or ship Structural from the Civil branch.
    - **Where:** `Modules/Structural/Installer/PackageContents.xml:12,22`; `Commands/AdminCommands.cs:22`; `Modules/Manager/Commands/PluginManagerCommands.cs:30`. **BUG:** BUG-852. **PR:** #1503 (Structural half) and #1493 (Manager half). **Fix kind:** test only (manifest overlap guard) plus the existing PRs. **Lane:** Sonnet fixer. **Test:** compare all three manifests: command names must not overlap.

23. **F-023. A fresh PC's starting values may not match Tim's current behaviour switches.**
    - **Severity:** HIGH (release-evidence gap). **Area:** Release, installer and Manager. **Sources:** CDX-G 8. **Installed:** Civil 3.0.70, Manager 1.1.70.
    - **For Tim:** Max gets the program's defaults, not necessarily the switches you use every day.
    - **Where:** `Modules/Drainage/Services/SettingsService.cs:51,82,160,308,749`; `ViewModels/Shell/CeEditorShellStateStore.cs:40`; `Modules/Manager/Services/CeOneGlanceStatus.cs:254,271,335`. **BUG:** NEW (proposed BUG-887). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design (comparison), Sonnet for the export. **Test:** export Tim's behaviour values and compare with first-run effective values from an empty profile; list every difference.

24. **F-024. If the installer is killed between retiring the old folder and placing the new one, CE can be gone on restart; there is no uninstall or restore command for a colleague.**
    - **Severity:** HIGH. **Area:** Release, installer and Manager. **Sources:** CDX-G 10. **Installed:** release branch.
    - **For Tim:** a power cut mid-install can leave Max with no CE.
    - **Where:** `Installer/SafeBundleInstaller.cs:314,334,340,351`; `Installer/CeInstallerApplication.cs:120,253`; `Modules/Manager/Services/CeOneGlanceStatus.cs:236`. **BUG:** NEW (proposed BUG-888). **PR:** none. **Fix kind:** code plus a written recovery procedure. **Lane:** Codex build with Opus review. **Test:** terminate the installer right after the live rename on a disposable PC; the recovery route restores a complete pair by hash.

25. **F-025. CE's signed-package check does not prove the company's Windows protection will allow the EXE or the native files.**
    - **Severity:** HIGH (environment gate). **Area:** Release, installer and Manager. **Sources:** CDX-G 12. **Installed:** release branch.
    - **For Tim:** the release can pass CE's own check and still be stopped by Max's IT policy.
    - **Where:** `Shared/CE.Release/OfficialReleaseGate.cs:724,829`; `Installer/CE_CVL_SUITE_Installer.csproj:9,33`; `Installer/build_installer.ps1:332`. **BUG:** NEW (proposed BUG-889). **PR:** none. **Fix kind:** needs Tim's word (IT). **Lane:** Opus design. **Test:** corporate IT runs its normal publisher and Defender checks on the final download and records any refusal.

26. **F-026. Existing one-piece CE pipes from Tim's PC may not work on older AutoCAD years: the native grip and object files only cover 2027.**
    - **Severity:** HIGH (compatibility gate). **Area:** Release, installer and Manager. **Sources:** CDX-G 13. **Installed:** Civil 3.0.70.
    - **For Tim:** unknown until Max's AutoCAD year is recorded (gap plan question 7).
    - **Where:** `Installer/PackageContents.xml:18,78,138,199,207`; `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs:7,18,55`. **BUG:** NEW (proposed BUG-890). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** open a synthetic drawing with a native CE pipe in each promised year; inspect, edit, save, undo.

65. **F-065. The About window (CE_VERSION) can say "Not loaded" for a tool that is loaded, shows AutoCAD as an internal number (25.1 or 26.0) instead of the year, and falls back to a guessed "2022+".**
    - **Severity:** HIGH (the text can be false). **Area:** Wording and windows. **Sources:** OPUS-UI 7, 8; CDX-G 14 (LOW). **Installed:** Manager 1.1.70.
    - **For Tim:** after a failed read a loaded Civil reads "Not loaded", so a colleague would reinstall for nothing; it also cannot prove the shared files match.
    - **Where:** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:67,70,73`; `CeVersionWindow.xaml.cs:34-44`; `Services/CeVersionReport.cs:46-113`. **BUG:** NEW (proposed BUG-891). **PR:** none. **Fix kind:** wording and a Codex look at the window. **Lane:** Sonnet fixer. **Test:** force the read to fail: rows say "CE could not read this. Type CEHEALTH."; the AutoCAD row reads the year.

83. **F-083. The Manager window tells colleagues to "run the CE installer", but only the administrator can.**
    - **Severity:** HIGH (the text is false for a colleague). **Area:** Wording and windows. **Sources:** OPUS-UI 1. **Installed:** Manager 1.1.70.
    - **For Tim:** the window and the status line disagree, so Max is told to do something he cannot do.
    - **Where:** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:177,189`; `Services/CeInstallWords.cs:6-15`. **BUG:** NEW (proposed BUG-892). **PR:** none. **Fix kind:** wording (bind both lines to `CeInstallWords.FinishTheInstall`). **Lane:** Sonnet fixer. **Test:** a colleague sees "ask your CE administrator to finish the install" in both places.

84. **F-084. CDCHECKIGNORE prints only 40 rows but says "... and 12 more (type their number to ignore one)", so a drafter can ignore a finding they cannot see.**
    - **Severity:** HIGH. **Area:** Wording and windows. **Sources:** OPUS-UI 13 (CDX-C calls the 40-row display a known limitation). **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** typing 45 ignores finding 45 without ever showing it.
    - **Where:** `Commands/CheckIgnoreCommand.cs:93,141`. **BUG:** NEW (proposed BUG-893). **PR:** none. **Fix kind:** code and wording (print all, or say fix some first and run again). **Lane:** Sonnet fixer. **Test:** 50 findings: either all 50 are printed or numbers above 40 are refused.

85. **F-085. Two CDCHECKIGNORE refusals contradict each other: one says a finding "CE could not check" can be ignored, the next says a check CE could not run cannot.**
    - **Severity:** HIGH. **Area:** Wording and windows. **Sources:** OPUS-UI 14. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** the first sentence tells the drafter they can do what the second forbids.
    - **Where:** `Services/Checks/IgnoredChecks.cs:90,93`; `Services/Checks/ChecksResult.cs:305`. **BUG:** NEW (proposed BUG-894). **PR:** none. **Fix kind:** wording. **Lane:** Sonnet fixer. **Test:** the two lines no longer contradict ("a finding to look at, or a not known one").

---

## MEDIUM (66)

27. **F-027. REDO is sometimes lost after picking a pit (BUG-861); CE's "REDO safe" list was only measured in the headless console, never with a real selection.**
    - **Severity:** MEDIUM (suspected). **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A 4, CDX-C (trace only). **Installed:** Civil 3.0.70.
    - **For Tim:** a pick, then REDO, can answer "Nothing to redo" the first time.
    - **Where:** `Services/RedoWindowGuard.cs:10-17`; `CivilSelectionObserver.cs:99-220`; `InspectorPaletteService.cs:1120`. **BUG:** BUG-861. **PR:** none. **Fix kind:** test only (six-row REDO test names the step). **Lane:** Codex build (test). **Test:** LINE, U, pick P3 with the Inspector open, wait 12 s, REDO must say "Everything has been redone".

28. **F-028. Every double-click on any attributed block scans every block in the drawing (and #1522 keeps the scan).**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** OPUS-A (#1522 section). **Installed:** not in 3.0.70 (arrives with #1522).
    - **For Tim:** a survey drawing with thousands of point blocks lags on each double-click.
    - **Where:** branch `b04/bug-859-r2-pick-at-doubleclick` `TryFindBlockUnderDoubleClick`. **BUG:** BUG-865. **PR:** #1522. **Fix kind:** code (fix before #1522 ships). **Lane:** Sonnet fixer. **Test:** 5,000 attributed blocks: under 100 ms between the two log lines.

29. **F-029. A finding that returns as "Asked again" cannot be ignored again directly.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** CDX-C 3. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** the Checks window asks you to reconsider, but CDCHECKIGNORE does not offer it.
    - **Where:** `Commands/CheckIgnoreCommand.cs:86`; `Services/Checks/IgnoreFindingPicker.cs:18-27`; `IgnoredChecks.cs:151-158`. **BUG:** NEW (proposed BUG-895). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** ignore, change a fingerprinted field, CDCHECKIGNORE Ignore: the row is offered.

30. **F-030. Leader-out planning reserves room using a plain label that will not actually move, so a callout can land on it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 4. **Installed:** Civil 3.0.70 (switch OFF).
    - **For Tim:** Tidy labels can move a callout onto a plain label and report a clear spot.
    - **Where:** `Services/LinkService.TextClashTidyUp.cs:426-437`; `Rules/TidyLeaderOutRule.cs:90-141`. **BUG:** NEW (proposed BUG-896). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** the `PlanWithLeaderOut` composition with labels A (0,0)-(100,100) and B: final moved boxes must not clash with held boxes.

31. **F-031. Tidy labels checks obstacles in model space even for a layout pipe, and its search margin does not grow with the leader-out distance.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** CDX-C 5. **Installed:** Civil 3.0.70 (Tidy labels OFF).
    - **For Tim:** a layout label can be moved because of model-space text, or run into text on its own sheet.
    - **Where:** `Commands/TidyLabelsCommand.cs:169-176`; `Services/LinkService.TextClashTidyUp.cs:28,425,579-747`. **BUG:** NEW (proposed BUG-897). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** model-only MTEXT at the same XY as a layout label: the label is not offered for movement.

32. **F-032. Clicking an Inspector problem count (Flat / backfall pipes, shallow pits and the rest) takes a write lock and a transaction even when the list is empty.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-02. **Installed:** Civil 3.0.70.
    - **For Tim:** clicking a zero count can use up the next U or lose the line you were about to REDO.
    - **Where:** `Services/InspectorPaletteService.cs:271,2752-2796`; `Controls/InspectorPanelControl.xaml:573`. **BUG:** NEW (proposed BUG-898). **PR:** none. **Fix kind:** code (return at once on an empty list, read-only for the rest). **Lane:** Sonnet fixer. **Test:** LINE, U, click the zero-count button, REDO: line comes back and no transaction is recorded.

33. **F-033. Window-first CD starts an empty next command, so cancelling that window costs a second U.**
    - **Severity:** MEDIUM. **Area:** Civil commands, Undo and Checks. **Sources:** HUNT-UNDO U-03. **Installed:** Civil 3.0.70.
    - **For Tim:** with "Pick the route first" OFF, after one pipe, Cancel on the next window then one U leaves the pipe.
    - **Where:** `Commands/CdCommand.cs:239,242`; `Services/PlacementContinuationService.cs:78-89`. **BUG:** NEW (proposed BUG-899). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** window-first CD, place one pipe, Cancel the next window, one U removes the pipe.

34. **F-034. Tidy labels preview does not reserve earlier pipes' proposed moves, so Apply is a different plan from the preview.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F2. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** "Will move 2", then Yes moves 1.
    - **Where:** `Commands/TidyLabelsCommand.cs:55,78,85`; `Services/LinkService.TextClashTidyUp.cs:159-709`. **BUG:** NEW (proposed BUG-900). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** two overlapping labels: preview count equals applied count.

35. **F-035. The pit-cover tidy preview checks a translated rectangle, but Apply also changes rotation and anchor, so the text can land on another note.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F3. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** a rotated cover text is offered a clear corner, then turns and lands on a note.
    - **Where:** `Services/LinkService.TidyPitText.cs:84-120`; `Rules/PitTextTidyRule.cs:31,47`; `Services/LinkService.PitCoverText.cs:135-152`. **BUG:** NEW (proposed BUG-901). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** real MText extents after the write must not touch note B.

36. **F-036. On a layout sheet Tidy labels counts a cover text as moved although its writer always refuses it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F4. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** "Moved 1" and the text has not moved; the reason is only in the CE log.
    - **Where:** `Services/LinkService.TidyPitText.cs:39-116`; `Services/LinkService.PitCoverText.cs:118`; `Commands/TidyLabelsCommand.cs:104`. **BUG:** NEW (proposed BUG-902). **PR:** none. **Fix kind:** code (wording and counts). **Lane:** Sonnet fixer. **Test:** layout fixture: "Moved" equals real moves and a plain line says why one was left.

37. **F-037. Tidy labels gives up on a pipe at 1,001 nearby text objects and says CE could not read it.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F5. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** a crowded drawing leaves an easy clash untouched and says "No CE label needs to move".
    - **Where:** `Services/LinkService.TextClashTidyUp.cs:33,197-203,685,700`; `Rules/TidyLabelsSummaryRule.cs:39`. **BUG:** NEW (proposed BUG-903). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** 2,000 close text objects: L1 is offered its clear move or an honest bounded-work line.

38. **F-038. A very small slide-step Setting makes Tidy labels enumerate hundreds of thousands of candidates before the preview.**
    - **Severity:** MEDIUM. **Area:** Civil labels and Tidy labels. **Sources:** HUNT-LABELS F6. **Installed:** Civil 3.0.70 (OFF).
    - **For Tim:** type 0.001 into Label slide step and AutoCAD seems to hang.
    - **Where:** `ViewModels/AdvancedSettingsViewModel.cs:1489,1648`; `Services/LinkService.TextClashTidyUp.cs:506,558`; `Rules/LabelPlacementRule.cs:65-97`; `Rules/TidyLeaderOutRule.cs:100,111`. **BUG:** NEW (proposed BUG-904). **PR:** none. **Fix kind:** code (a work budget, no hard block). **Lane:** Sonnet fixer. **Test:** step 0.001: candidate count stays under the budget.

39. **F-039. The import results page lists a skipped pit as "Recorded" and can call a zero-placement import complete.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 4. **Installed:** Civil 3.0.70.
    - **For Tim:** the command line says the pit was not drawn, the window says Recorded.
    - **Where:** `Commands/LinkCommands.ImportXcivil.cs:219-229,508-518`; `Services/XcivilImportService.cs:1950,2082`; `Services/LandXmlImportReview.cs:107`. **BUG:** NEW (proposed BUG-905). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** lock STORMWATER PIT, import one pit: the window lists it "Not drawn", not Recorded.

40. **F-040. LandXML Replace measures the old import to decide the new position, then deletes it, so the replacement can land somewhere else.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 5. **Installed:** Civil 3.0.70. **Related:** BUG-068.
    - **For Tim:** the same XML lands in different places depending on where the previous import sat.
    - **Where:** `Services/XcivilImportService.cs:1879,1921` (compare the correct X-Civil caller at `:694`); `XcivilPitInsertionService.cs:806-878`; `XcivilImportReportService.cs:604`. **BUG:** NEW (proposed BUG-906). **PR:** none. **Fix kind:** code (one missing argument). **Lane:** Sonnet fixer. **Test:** clean target A and target B-with-old-import give the same new insertion points within 0.01 mm.

41. **F-041. A PDF schedule spanning several pages is reduced to one page.**
    - **Severity:** MEDIUM. **Area:** Civil imports. **Sources:** HUNT-IMPORT 6. **Installed:** Civil 3.0.70. **Related:** BUG-781, BUG-804.
    - **For Tim:** pits on the continuation sheet lose their size and levels.
    - **Where:** `Modules/tools/Extract-XcivilPdfSchedule.ps1:480,485,538,685,819`; `Services/XcivilScheduleService.cs:308-361`; `XcivilImportService.cs:733`. **BUG:** NEW (proposed BUG-907). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** two-page PDF, P11 on page 1 and P12 on page 2: both rows come back.

42. **F-042. Cover is measured to the inside top of the pipe; the wall thickness is ignored.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 4. **Installed:** Civil 3.0.70.
    - **For Tim:** a concrete 375 showing 320 mm cover really has about 275 mm, below 300.
    - **Where:** `Rules/RulebookEngine.cs:466`; `Services/PipeSizingSolver.cs:387-388`. **BUG:** NEW (proposed BUG-908). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design then Sonnet. **Test:** RCP 375, cover 11.000, IL 10.305, wall table 45: Warn "cover 275 mm".

43. **F-043. Cover is checked only at the two pits, against the lid level, with one figure for every surface.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 5. **Installed:** Civil 3.0.70.
    - **For Tim:** a pipe under a lower garden bed between two raised lids is never checked there.
    - **Where:** `Rules/RulebookEngine.cs:444-474`; `Services/PipeSizingSolver.cs:353-371`; `Models/UserSettings.cs:1736`. **BUG:** NEW (proposed BUG-909). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design. **Test:** spot levels at 0, 5, 10 m (11.00, 10.65, 10.90): Warn at 5 m, 150 mm.

44. **F-044. Moving a pit with a held grade rounds the bottom level to the nearest step, so the pipe can come out flatter than the held grade.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 6. **Installed:** Civil 3.0.70.
    - **For Tim:** a 1 in 100 pipe reads 1 in 102 after a pit move; CD itself writes 1 in 96.
    - **Where:** `Services/LinkService.Utilities.cs:2293-2309`; compare `Helpers/MathHelper.cs:296-323`. **BUG:** BUG-870. **PR:** none yet (cx_b10 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** `ComputeGradeLockLevels(10.00, 9.90, "10.00", "9.90", 15.30, 100, 2, ...)` gives newTo "9.84".

45. **F-045. Different screens judge the same pipe against different minimum grades and covers.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 7. **Installed:** Civil 3.0.70.
    - **For Tim:** the Inspector says OK and CDRULES says Warn on the same DN100 at 1 in 150.
    - **Where:** `Services/DesignValidationService.cs:350`; `Models/UserSettings.cs:1718,1920-1924`; `Rules/RulebookValues.cs:337-358`; `Services/MinimumCoverForChecks.cs:18-30`. **BUG:** NEW (proposed BUG-910). **PR:** none. **Fix kind:** needs Tim's word (confirm the ladder). **Lane:** Sonnet fixer after the ruling. **Test:** DN100, 15 m, 10.10/10.00: Inspector and R-03 give the same verdict.

46. **F-046. The Pit Schedule measures depth to the outlet pipe, not the pit floor (Tim's 20 Oct ruling).**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 8. **Installed:** Civil 3.0.70.
    - **For Tim:** schedule says 0.85 m (no step irons), CDRULES says 950 mm (step irons).
    - **Where:** `Rules/PitScheduleDepthRule.cs:32-47`; compare `Rules/RulebookEngine.cs:660-701`. **BUG:** BUG-869. **PR:** none yet (cx_b09 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** `DepthText(false, "11.00", "10.20", "10.15")` with floor 10.05 gives "0.95".

47. **F-047. CDTWL counts some water twice (pipe ends inside pits) and counts water below the orifice that never drains.**
    - **Severity:** MEDIUM (suspected). **Area:** Civil engineering. **Sources:** OPUS-E 9. **Installed:** Civil 3.0.70.
    - **For Tim:** the system holds about 100 L less than CDTWL says, so the top water level comes out low (about 4 per cent on 2,576 L).
    - **Where:** `Rules/DetentionBranchCollector.cs:323-339`; `Rules/DetentionStorageMath.cs:106-125`; `Models/UserSettings.cs:2221-2222`. **BUG:** NEW (proposed BUG-911). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** orifice pit with 150 mm sump: live storage excludes 54 L and counts 9.4 m of pipe.

48. **F-048. CDTWL ignores the drawing's units when it measures pipes.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 10. **Installed:** Civil 3.0.70.
    - **For Tim:** on a metre drawing a full 20 m DN300 pipe holds 1.4 L in CDTWL instead of 1,414 L.
    - **Where:** `Rules/DetentionBranchCollector.cs:323-330`; compare `Services/PipeGeometryHelper.cs:128-153`. **BUG:** BUG-871. **PR:** none yet (cx_b11 queued). **Fix kind:** code. **Lane:** Codex build. **Test:** pits at (0,0) and (20,0), `PositionInsunits` 6, DN300: about 1,414 L.

49. **F-049. The storm sweep is too coarse near the peak and says nothing when the worst storm is the first one.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 11. **Installed:** Civil 3.0.70.
    - **For Tim:** CDDESIGN can under-size storage by 2 to 3 per cent (job 24-115: 1.688 m3 at 5 min, 1.734 m3 at 7 min).
    - **Where:** `Services/DetentionSizingService.cs:66-67,156-159`. **BUG:** NEW (proposed BUG-912). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** area 640.67, C 0.6511, PSD 6.54: SSR at least 1.73 m3 or a note.

50. **F-050. CDCALC's Boyd's tab and CDDESIGN use different hard-ground C, so one job gets two storage figures.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 12. **Installed:** Civil 3.0.70.
    - **For Tim:** job 24-115 gives 2.58, 3.11 and 1.69 m3 depending on the screen.
    - **Where:** `ViewModels/BoydsCalcViewModel.cs:233-237`; `Services/AutoDesignService.cs:62-69`. **BUG:** NEW (proposed BUG-913). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** same inputs through both give equal SSR.

51. **F-051. R-30 (council detention-pipe grade) still judges pipes that R-06 says cannot be told from downpipes.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 13. **Installed:** Civil 3.0.70. **Related:** BUG-815, BUG-854.
    - **For Tim:** a 100 mm downpipe left marked Detention gets a council warning while R-06 says "not judged".
    - **Where:** `Rules/RulebookEngine.cs:95-106,479-497`. **BUG:** NEW (proposed BUG-914). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** Manningham DN100 downpipe, Detention ticked, no length: R-30 is Unknown.

52. **F-052. The pit drop check compares inverts only, so a pipe getting bigger can back water up the smaller pipe.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 14. **Installed:** Civil 3.0.70.
    - **For Tim:** 150 in at 10.000 and 300 out at 9.980 passes, but the outlet top sits 130 mm above the inlet top.
    - **Where:** `Rules/PitDropRule.cs:150-156`; `Rules/RulebookEvaluator.cs`. **BUG:** NEW (proposed BUG-915). **PR:** none. **Fix kind:** needs Tim's word (after 9 Nov). **Lane:** Opus design then Sonnet. **Test:** that pit gives Warn "outlet obvert 130 mm above inlet obvert".

53. **F-053. Engineering numbers are still fixed in code (R-00): council values, pump station, sizing, storm, orifice, level limits.**
    - **Severity:** MEDIUM. **Area:** Civil engineering. **Sources:** OPUS-E 15. **Installed:** Civil 3.0.70.
    - **For Tim:** for example Kingston's 2000 L block, Manningham factor 0.25, pump C 0.90, X-Civil level limit 0 to 250 m that drops real levels on a high site.
    - **Where:** about 30 files listed in the source (`ReuseCreditService.cs`, `PumpSizingService.cs`, `NetworkDesignService.cs`, `SettingsSizingStandards.cs`, `XcivilLayerRecognition.cs:41-42` and others). **BUG:** NEW (proposed BUG-916). **PR:** none. **Fix kind:** needs Tim's word (values). **Lane:** Sonnet fixer after Tim's values. **Test:** a "no engineering literal" source guard listing those files.

54. **F-054. The red back-test GE 24-115 (1.69 vs 2.58 m3) is out of date; the engine's formula is right.**
    - **Severity:** MEDIUM (audit), LOW (carpark). **Area:** Civil engineering. **Sources:** OPUS-E 16. **Installed:** Civil 3.0.70 (test only).
    - **For Tim:** the test feeds 2024 inputs (1 in 5 storm, C 0.35, site rainfall); do not widen the 30 per cent band.
    - **Where:** `Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs:146-157`. **BUG:** BUG-872. **PR:** none yet (cx_b06 queued). **Fix kind:** test only. **Lane:** Codex build. **Test:** pin `PostDevSoftGroundC: 0.35` and `CouncilProvidedPsdLps: 5.87`: 2.123 m3, 17.7 per cent, passes.

55. **F-055. CEMEMBER keeps only X and Y of the picked points (Z set to 0) and draws a section square to the world, not to the UCS.**
    - **Severity:** MEDIUM (Codex), LOW (Opus). **Area:** Structural. **Sources:** CDX-S F3, OPUS-A 7. **Installed:** Structural 1.0.121.
    - **For Tim:** a member picked on a raised UCS lands at Z 0; a section in a rotated UCS sits at 30 degrees on screen.
    - **Where:** `Commands/CeMemberCommands.cs:125,131,189-191`; `Services/CeMemberLineWriter.cs:124`; `Services/CeMemberSectionWriter.cs:39,43`; house helper `CeStrucCommandBase.cs:94`. **BUG:** NEW (proposed BUG-917). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** UCS origin at Z 1000: lines stay at World Z 1000 or the command refuses before writing.

56. **F-056. "Follows paper" hatch density and CEMEMBER break marks still use the model drawing scale when drawn directly on a layout sheet.**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** CDX-S F5. **Installed:** Structural 1.0.121.
    - **For Tim:** a break kink is 100 mm on paper instead of 2 mm at DIMSCALE 50.
    - **Where:** `Commands/HatchCommands.cs:1655`; `Core/Units/DrawingScaleRule.cs:56`; `Commands/CeMemberCommands.cs:99`; `DesignCore/SteelSections/CeMemberEngine.cs:219`. **BUG:** NEW (proposed BUG-918). **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Opus design. **Test:** PSPACE, DIMSCALE 50, CEMEMBER with break lines: overshoot 1.5 mm, kink 2 mm.

57. **F-057. EBT and 25C text heights ignore drawing units (metre drawings) and annotation scale (DIMSCALE 0).**
    - **Severity:** MEDIUM. **Area:** Structural. **Sources:** CDX-S F6. **Installed:** Structural 1.0.121.
    - **For Tim:** 125 m high text in a metre drawing; at DIMSCALE 0 and 1:50 the text plots 5 mm instead of 2.5 mm.
    - **Where:** `Services/CeTextService.cs:27,610,625,4655,5482,5492,5520`. **BUG:** NEW (proposed BUG-919). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** INSUNITS 6, DIMSCALE 50, EBT: height 0.125 m.

58. **F-058. CEMEMBER ignores the office DefaultScale Setting when DIMSCALE is 0.**
    - **Severity:** MEDIUM (Codex), LOW (Opus). **Area:** Structural. **Sources:** CDX-S F7, OPUS-A 6. **Installed:** Structural 1.0.121.
    - **For Tim:** an office setting of 1:50 still gives 150/200 mm breaks (the fixed 1:100).
    - **Where:** `Commands/CeMemberCommands.cs:98`; `Models/UserSettings.cs:895`; `LegacyToolCommon.cs:147`; `DesignCore/SteelSections/CeMemberEngine.cs:188-190`. **BUG:** NEW (proposed BUG-920). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** `CeMember.DefaultScale` 50, DIMSCALE 0: command line says 1:50, overshoot 75 mm.

59. **F-059. Long staging paths are the clean-profile default, so a colleague with a long Windows profile path may not be able to prepare an update on older AutoCAD.**
    - **Severity:** MEDIUM (suspected). **Area:** Release, installer and Manager. **Sources:** CDX-G 9. **Installed:** Manager 1.1.70.
    - **For Tim:** works on your PC, may fail on Max's.
    - **Where:** `Modules/Manager/Services/CeUpdateStagingService.cs:109,374`; `CeOneGlanceStatus.cs:245,302,341`; `CeAdminStorageService.cs:32,49`. **BUG:** NEW (proposed BUG-921). **PR:** none. **Fix kind:** code. **Lane:** Codex build. **Test:** a profile path over 260 characters: staging succeeds or refuses cleanly before any partial copy.

60. **F-060. If Windows denies creating the settings folder on first run, Civil silently falls back to defaults and does not say why preferences are not remembered.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** CDX-G 11. **Installed:** Civil 3.0.70, Manager 1.1.70.
    - **For Tim:** Max changes a setting and it is gone next time, with no message.
    - **Where:** `Modules/Drainage/Services/SettingsService.cs:79,93`; `LoggingService.cs:68-98`; `Modules/Manager/Services/CeAdminStorageService.cs:32,51`; `Modules/Manager/Plugin.cs:97`. **BUG:** NEW (proposed BUG-922). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** deny creation of the settings folder: Settings shows a visible "not saved" explanation.

86. **F-086. Manager window uses five names for one update stage ("Installed next start", "Updates ready to get", "Ready next start", "Update ready", "2 · Ready").** MEDIUM. Wording and windows. OPUS-UI 2. Manager 1.1.70. For Tim: a drafter cannot tell whether "Ready" means approved, copied or installed. `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:50,98,99,139,176`. NEW (proposed BUG-923). No PR. Wording (Approved / Copied, waiting / Starts next time). Sonnet fixer. **Test:** the five strings are gone and the three fixed words appear.

87. **F-087. The unconnected finish-update messages use "record" and give no next step, and one promises "It will finish when every AutoCAD window is closed" although nothing starts the installer.** MEDIUM. Wording and windows. OPUS-UI 5, 6. Manager 1.1.70 (not shown to anyone yet). `Modules/Manager/Services/CeFinishUpdatePlanner.cs:47,52,56`; `CeFinishUpdateStartRule.cs:36`. NEW (proposed BUG-924). No PR (#1508 and #1515 are the unconnected code). Wording plus a guard. Sonnet fixer. **Test:** the "will finish" line cannot appear until a caller that starts the installer exists.

88. **F-088. About window (CE_VERSION) smaller wording faults: a ".NET 10" row drafters cannot act on, "CONFLICT — 2 copies" in capitals with no next step, "<path unavailable>", and three names for one window.** MEDIUM. Wording and windows. OPUS-UI 9, 10, 11, 12. Manager 1.1.70. `UI/Dialogs/CeVersionWindow.xaml:4,34,78-79`; `Services/CeVersionReport.cs:97,101`. NEW (proposed BUG-925). No PR. Wording. Sonnet fixer. **Test:** two copies loaded reads "Two copies loaded (3.0.70 and 3.0.69). Close AutoCAD and ask your CE administrator."

89. **F-089. CDCHECKIGNORE's "switched off" message does not say which tab to tick.** MEDIUM. Wording and windows. OPUS-UI 15. Civil 3.0.70 (switch OFF). `Commands/CheckIgnoreCommand.cs:39`; `Services/Checks/IgnoredChecks.cs:88`. NEW (proposed BUG-926). No PR. Wording. Sonnet fixer. **Test:** the line names CDS > Newer tools > "Allow a finding to be ignored".

90. **F-090. CDCHECKIGNORE says "no CE project record yet" (a software word) with no next step.** MEDIUM. Wording and windows. OPUS-UI 16. Civil 3.0.70 (switch OFF). `Commands/CheckIgnoreCommand.cs:46`. NEW (proposed BUG-927). No PR. Wording. Sonnet fixer. **Test:** the line reads "This drawing has no CE pits or pipes yet, so there is nothing to ignore. Nothing was changed."

91. **F-091. "CE could not check" means two different things in the Checks window (a value is missing, and CE failed while reading), and the row repeats its own title with no next step.** MEDIUM. Wording and windows. OPUS-UI 20. Civil 3.0.70. `Services/Checks/ChecksResult.cs:153,305-307`. NEW (proposed BUG-928). No PR. Wording. Sonnet fixer. **Test:** header "312 not known (a value is missing)"; the read-failure row tells the drafter to run CDCHECK again.

92. **F-092. CDRULES rows use software words: "provenance", "PitSelector size tier", "office seed", "per-type catalogue selection", "fallback velocity".** MEDIUM. Wording and windows. OPUS-UI 21, 23, 24, 25. Civil 3.0.70. `Rules/RulebookEngine.cs:69,250-260,321,411-419`. NEW (proposed BUG-929). No PR. Wording. Sonnet fixer. **Test:** a source guard that none of those words reach a user string.

93. **F-093. CDRULES says "no minimum in the rulebook" instead of saying where to set it.** MEDIUM. Wording and windows. OPUS-UI 22. Civil 3.0.70. `Rules/RulebookEngine.cs:345,437,454,625,650`. NEW (proposed BUG-930). No PR. Wording. Sonnet fixer. **Test:** the line reads "No minimum cover set. Set it in CDS > Design."

94. **F-094. The council-source window shows raw saved data (JSON with EntityHandle and SpineKey) and legal-sounding sentences.** MEDIUM. Wording and windows. OPUS-UI 26. Civil 3.0.70. `ViewModels/CouncilSourceViewModel.cs:63,80,82`; `Rules/RulebookEngine.cs:134`. NEW (proposed BUG-931). No PR. Wording. Sonnet fixer. **Test:** the window lists values in words ("Diameter 225 mm, upstream IL 10.250"), no handles.

95. **F-095. "Unknown" and "not known" are both used for the same thing in what a drafter reads (Settings, council rule values, audit lines, pipe length).** MEDIUM. Wording and windows. OPUS-UI 27, 28. Civil 3.0.70. `AdvancedSettingsDialog.xaml:919,1360`; `Rules/CouncilRuleValues.cs:333`; `Commands/LinkCommands.ReadOnlyAudit.cs:25,30,36`; `Rules/RulebookEngine.cs:333`. NEW (proposed BUG-932). No PR. Wording. Sonnet fixer. **Test:** a source guard for "Unknown" in user strings.

96. **F-096. CDTAG says "CDTAG removed." when nothing was tagged, and prints "CDTAG applied: tag=DP2. Pipes linked to this block: 2."** MEDIUM. Wording and windows. OPUS-UI 30, 31. Civil 3.0.70. `Commands/SourceTagCommand.cs:311,391`. NEW (proposed BUG-933). No PR. Wording. Sonnet fixer. **Test:** Enter on an empty tag prints "[CE] No tag typed. This block has no source tag."

97. **F-097. A colleague-facing Settings tooltip names a person and an internal ruling ("Tim decides when to hide it (ruling of 18 Oct)").** MEDIUM. Wording and windows. OPUS-UI 36. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:1375`; `CivilSettingsView.xaml:400`; `ViewModels/SettingsValueCatalog.cs`. NEW (proposed BUG-934). No PR. Wording. Sonnet fixer. **Test:** a source guard for personal names in Settings strings.

98. **F-098. A Settings tick that changes nothing the drafter can see ("Nothing draws this row today").** MEDIUM. Wording and windows. OPUS-UI 37. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1369`; `CivilSettingsView.xaml:394`. NEW (proposed BUG-935). No PR. Wording (hide it, or label "(no effect yet)"). Sonnet fixer. **Test:** the row is hidden or carries the label.

99. **F-099. Eight Fixes-tab tooltips use software words (stored deletion word, records, drawing identity, Point Order, stored levels, runtime rounding, unlinked, Project QA, native, host drawing).** MEDIUM. Wording and windows. OPUS-UI 38, 39, 40, 41, 42, 43, 44, 45. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:1338-1398`; `CivilSettingsView.xaml:363-423`. NEW (proposed BUG-936). No PR. Wording. Sonnet fixer. **Test:** a source guard for those words in the Fixes tab.

100. **F-100. The start-up "heartbeat to CE Cloud" tick is worded with software words and does not say plainly what is sent.** MEDIUM. Wording and windows. OPUS-UI 50. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1128-1129`; `CivilSettingsView.xaml:207`. NEW (proposed BUG-937). No PR. Wording. Sonnet fixer. **Test:** the label reads "At start-up, tell the CE office this PC is running CE (CE and AutoCAD versions and a PC code only)".

101. **F-101. "Furthest a label may move out (mm)" does not say model or paper millimetres (1500 mm is 7.5 mm on a 1:200 sheet).** MEDIUM. Wording and windows. OPUS-UI 51. Civil 3.0.70 (switch OFF). `AdvancedSettingsDialog.xaml:1215-1216,1286`; `CivilSettingsView.xaml:243,313`. Related F-063. NEW (proposed BUG-938). No PR. Wording. Sonnet fixer. **Test:** the label reads "(mm in the model, 1500 = 1.5 m)".

102. **F-102. Several new switches have no tick on the Settings page (double-click Edit source window, leave out removed pits, slow-check progress, wrong-layer rows), so the Edit source window is ON and cannot be switched off from Settings.** MEDIUM. Wording and windows. OPUS-UI 52. Civil 3.0.70. `Models/DoubleClickSettings.cs:34`; `Models/UserSettings.cs:1985,2757,2764`. NEW (proposed BUG-939). **PR:** #1526 (adds rows for existing check, progress and double-click settings; confirm it covers all four). Settings row. Codex build (in flight). **Test:** each of the four keys has a row in CDS > Newer tools.

103. **F-103. One window has three names: Preferences (ribbon, CD and Edit Pipe buttons), Settings (title bar, Help) and CE Settings (messages).** MEDIUM. Wording and windows. OPUS-UI 55. Civil 3.0.70. `Assets/Config/ce_toolbar_layout.json:189`; `command-registry.json:327`; `Dialogs/CdDialog.xaml:145`; `Dialogs/AdvancedSettingsDialog.xaml:4`. NEW (proposed BUG-940). No PR. Needs Tim's word (one name). Sonnet fixer after the ruling. **Test:** a source guard that "Preferences" is gone from user strings.

104. **F-104. Two different things are called "CE Manager" (CDMANAGER is the Drawing Standards Manager; CESURVEYREVIEW means Suite Manager).** MEDIUM. Wording and windows. OPUS-UI 56. Civil 3.0.70, Manager 1.1.70. `Assets/Config/command-registry.json:319`; `Modules/Manager/Assets/Config/command-registry.json:33`. NEW (proposed BUG-941). No PR. Needs Tim's word (naming). Sonnet fixer after the ruling. **Test:** CDMANAGER reads "Drawing Standards (CDMANAGER)".

105. **F-105. Ribbon tooltips use banned words (network topology, schedule drift, compound entity, "Export Entities", "CE data model").** MEDIUM. Wording and windows. OPUS-UI 57. Civil 3.0.70. `Assets/Config/command-registry.json:147,198,252,314,343`. NEW (proposed BUG-942). No PR. Wording. Sonnet fixer. **Test:** a source guard for the banned words.

106. **F-106. "Repair Center" is US spelling and its tooltip says "sync, rebuild, upgrade and diagnostics".** MEDIUM. Wording and windows. OPUS-UI 58. Civil 3.0.70. `Assets/Config/command-registry.json:351,355`; `ce_toolbar_layout.json:222`. NEW (proposed BUG-943). No PR. Wording. Sonnet fixer. **Test:** the label reads "Repair Centre".

107. **F-107. The Manager Refresh tooltip says "upload queued telemetry" and does not say plainly that it sends data.** MEDIUM. Wording and windows. OPUS-UI 59. Manager 1.1.70. `Modules/Manager/Assets/Config/command-registry.json:27`. NEW (proposed BUG-944). No PR. Wording. Sonnet fixer. **Test:** the tooltip says it sends waiting usage notes to the office.

108. **F-108. Help lists six Settings tabs; the window has eight (Newer tools and Fixes are missing, "Pipes & Pits" should be "Pipes and Pits").** MEDIUM. Wording and windows. OPUS-UI 61. Civil 3.0.70. `Assets/Help/guide-content.js:95`. NEW (proposed BUG-945). No PR. Wording. Sonnet fixer. **Test:** the Help line names all eight tabs.

109. **F-109. Help says only the office administrator can switch Checks on; any drafter can tick it in Settings.** MEDIUM. Wording and windows. OPUS-UI 62. Civil 3.0.70. `Assets/Help/guide-content.js:58`. NEW (proposed BUG-946). No PR. Wording. Sonnet fixer. **Test:** the Help line points to CDS > Newer tools.

110. **F-110. CD window (used all day) uses software words: "Use single pipe entity", "validation rules", "no invert or grade validation".** MEDIUM. Wording and windows. OPUS-UI 63. Civil 3.0.70. `Dialogs/CdDialog.xaml:238,244,469`. NEW (proposed BUG-947). No PR. Wording. Sonnet fixer. **Test:** the checkbox reads "Draw the pipe as one line".

111. **F-111. Inspector and Edit Pit show "Handle", "GIO Handle", "full-detail snapshot" and "reference evidence, not authority".** MEDIUM. Wording and windows. OPUS-UI 64. Civil 3.0.70. `Controls/InspectorPanelControl.xaml:89,266,321`; `Dialogs/PitEditWorkshopDialog.xaml:203`. NEW (proposed BUG-948). No PR. Wording (hide the handle rows for colleagues). Sonnet fixer. **Test:** the handle rows are hidden.

112. **F-112. Repair Centre and CD help page use software words ("Sync Links", "caches from drawing truth").** MEDIUM. Wording and windows. OPUS-UI 65. Civil 3.0.70. `Dialogs/CdRepairDialog.xaml:46,75`; `Dialogs/CdHelpDialog.xaml:94`. NEW (proposed BUG-949). No PR. Wording. Sonnet fixer. **Test:** the step reads "1. Reconnect pits and pipes".

113. **F-113. Command-line messages in developer words ("compound root", "no ProjectData record", "slab boundary polyline handle", "not a council profile id", "entity(ies) skipped").** MEDIUM. Wording and windows. OPUS-UI 66. Civil 3.0.70. `Commands/AnnotationEditCommand.cs:57`; `RunSolveCommand.cs:288,467`; `SlabCommand.cs:1229`; `RulebookCommand.cs:158`; `HubCommands.cs:654`. NEW (proposed BUG-950). No PR. Wording. Sonnet fixer. **Test:** a source guard for those phrases.

114. **F-114. CDAUDIT and Recover Inverts print a programmer's dump ("pits=12, pipes=14, duplicate-handle-groups=1", "cached ownership Unknown").** MEDIUM. Wording and windows. OPUS-UI 67. Civil 3.0.70. `Commands/LinkCommands.cs:403,405,2379`; `Commands/LinkCommands.ReadOnlyAudit.cs:36,40`. NEW (proposed BUG-951). No PR. Wording. Sonnet fixer. **Test:** the CDAUDIT line reads "12 pits, 14 pipes. 2 pipes are copies of one another. Type CDREPAIR to fix them."

122. **F-122. CEHEALTH prints "[OK] CE Civil Suite v3.0.70" (and can end "All checks passed") when Civil is installed but not loaded.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-01. **Installed:** Manager 1.1.70.
    - **For Tim:** the command meant to diagnose a missing Civil says Civil is fine, while CE_VERSION says "Not loaded".
    - **Where:** `Modules/Manager/Commands/PluginManagerCommands.cs:184,191,201,206,211,243`; `Services/CePluginRegistryService.cs:517`; `Services/CeHealthChecks.cs:31`. **BUG:** NEW (proposed BUG-952). **PR:** none. **Fix kind:** code (add a NotLoaded warning). **Lane:** Sonnet fixer. **Test:** NETLOAD only Manager, then CEHEALTH: a "Civil not loaded" warning and no OK line for Civil.

123. **F-123. A damaged prepared update cannot be repaired by clicking Get update ready again: the old folder blocks the fresh copy every time.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-02. **Installed:** Manager 1.1.70.
    - **For Tim:** one missing file in the local copy and Max is stuck with "conflicting identity evidence" even after a restart.
    - **Where:** `Modules/Manager/Services/CeUpdateStagingService.cs:370,374,399,401,414,417,430`; `UI/Dialogs/PluginManagerWindow.xaml.cs:666,688`; `Services/CePluginInstallerService.cs:242`. **BUG:** NEW (proposed BUG-953). **PR:** none. **Fix kind:** code (quarantine the bad copy and stage a new verified one; keep the rejection test). **Lane:** Sonnet fixer with Opus review. **Test:** remove one listed file from the staged bundle, click Get update ready twice: a complete verified stage results and installed hashes are unchanged.

124. **F-124. The CE Tools "Updates & Rollback" ribbon button sends an ordinary colleague to an administrator-only route and opens no window.**
    - **Severity:** MEDIUM. **Area:** Release, installer and Manager. **Sources:** HUNT-MANAGER MGR-03. **Installed:** Manager 1.1.70.
    - **For Tim:** Max clicks the prominent button and gets "This Windows account is not set up as a CE administrator" while the normal Manager window has an Updates page he could use.
    - **Where:** `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26`; `Commands/PluginManagerCommands.cs:91,139,148`; `UI/Dialogs/PluginManagerWindow.xaml:161,191`. **BUG:** NEW (proposed BUG-954). **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** non-administrator clicks the button: the Manager Updates page opens and no administrator role is granted.

---

## LOW, grouped by area (28)

### Civil commands, Undo and Checks (3)

61. **F-061. The slow-check progress line is bypassed when the shared Checks list is enabled.**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** CDX-C 7. **Installed:** Civil 3.0.70 (both switches OFF). **Where:** `Commands/CheckCurrentDrawingCommand.cs:28-33`; `ChecksListCommand.cs:53-65`; `Services/CurrentDrawingCheckService.cs:43-46`. **BUG:** NEW. **PR:** none. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** with the Checks doorway ON, a 10,000-entity drawing prints a progress line.

62. **F-062. The double-click "screen pixel" second reading can pick a different downpipe in a metre drawing near 0,0 (before #1522 ships).**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** OPUS-A (#1522 section). **Installed:** not installed (#1522). **Where:** branch `b04/bug-859-r2-pick-at-doubleclick` `Combine`. **BUG:** NEW. **PR:** #1522. **Fix kind:** code. **Lane:** Sonnet fixer. **Test:** metre drawing, downpipes at 0,0 and 300,200, double-click a title-block attribute: AutoCAD's editor opens, CE's does not.

64. **F-064. CDCHECKIGNORE stores the drafter's Windows sign-in name inside the drawing.**
    - **Severity:** LOW. **Area:** Civil commands. **Sources:** OPUS-A 12. **Installed:** Civil 3.0.70 (switch OFF). **For Tim:** a DWG sent to a council carries a staff login name. **Where:** `Commands/CheckIgnoreCommand.cs:121`. **BUG:** NEW. **PR:** none. **Fix kind:** needs Tim's word (initials Setting?). **Lane:** Sonnet fixer. **Test:** ignore one finding: the list line shows the chosen name, not the login.

### Civil labels (1)

63. **F-063. The leader-out limits are ground millimetres, not paper millimetres, although entry 1572 says "same paper distance".**
    - **Severity:** LOW. **Area:** Civil labels and Tidy labels. **Sources:** OPUS-A 11. **Installed:** Civil 3.0.70 (switch OFF). **Where:** `Services/LinkService.TextClashTidyUp.cs:425`; `Rules/TidyLeaderOutRule.cs:50`. **BUG:** NEW. **PR:** none. **Fix kind:** needs Tim's word. **Lane:** Sonnet fixer after the ruling. **Test:** DIMSCALE 500 and 20: the clear-spot distance is the same on paper.

### Civil engineering (12)

66. **F-066. Hydraulic radius uses the nominal size, not the bore.** LOW. Civil engineering. OPUS-E 17. Civil 3.0.70. Safe side (UPVC DN100 under-states capacity about 11 per cent). `Services/DesignValidationService.cs:141-142`; `Services/PipeSizingSolver.cs:313-314`. NEW. No PR. Code. Sonnet fixer. **Test:** DN100 UPVC at 1 in 100 with a 104 mm bore: about 7.5 L/s.

67. **F-067. CDTWL measures the orifice head to the orifice level, while the equation wants the head to its centre.** LOW (suspected). Civil engineering. OPUS-E 18. Civil 3.0.70. `Services/DetentionTwlService.cs:217-226`; `Services/OrificeSizer.cs`. NEW. No PR. Needs Tim's word. Opus design. **Test:** TWL 10.40, orifice invert 10.00, d 71: report head 364 mm or say "to invert".

68. **F-068. Casey's formula uses banker's rounding on exact halves.** LOW. Civil engineering. OPUS-E 19. Civil 3.0.70. `Services/OrificeSizer.cs:65`. NEW. No PR. Code. Sonnet fixer. **Test:** an input giving exactly 54.5 returns 55.

69. **F-069. The grade label ignores which way the levels fall, so an uphill pipe reads "1 IN 100".** LOW. Civil engineering. OPUS-E 20. Civil 3.0.70. `Services/PipeAnnotationTextFormatter.cs:41`. NEW. No PR. Code. Sonnet fixer. **Test:** `ActualGradeLabel(10000, 10.00, 10.10)` says it rises.

70. **F-070. The R-03 message can contradict itself after rounding ("actual 1:200 is flatter than 1:200").** LOW. Civil engineering. OPUS-E 21. Civil 3.0.70. `Rules/RulebookEngine.cs:347-351`. NEW. No PR. Wording. Sonnet fixer. **Test:** 20.04 m over 0.10 m prints "1:200.4".

71. **F-071. CDCALC boxes accept a comma as a thousands mark, so "0,35" in a C box reads as 35 and is clamped to 1.0.** LOW. Civil engineering. OPUS-E 22. Civil 3.0.70. `ViewModels/BoydsCalcViewModel.cs:277-280`; `DetentionCalcViewModel.cs:138-140`; `OrificeCalcViewModel.cs:158-160`. NEW. No PR. Code. Sonnet fixer. **Test:** Parse("0,35") is rejected or warned.

72. **F-072. The CDDESIGN window shows the council's soft C (0.35), not the Settings value used (0.30).** LOW. Civil engineering. OPUS-E 23. Civil 3.0.70. `ViewModels/CivilDesignWindowViewModel.cs:741-744`; `Services/CivilDesignService.cs:156`. NEW. No PR. Wording. Sonnet fixer. **Test:** the window line reads "0.30 (Settings; council records 0.35)".

73. **F-073. The storm sweep includes storms shorter than the council's Tc (Darebin Tc 10 min, 5-min storm still worked).** LOW (safe side). Civil engineering. OPUS-E 24. Civil 3.0.70. `Services/DetentionSizingService.cs:131`. NEW. No PR. Code. Sonnet fixer. **Test:** Darebin job: first row is 10 min.

74. **F-074. Minimum grade ladder has odd values and two readers: a DN250 gets no minimum in the solver but 1 in 250 in CDRULES.** LOW. Civil engineering. OPUS-E 25. Civil 3.0.70. `Models/UserSettings.cs:1920-1924`; `Services/PipeSizingSolver.cs:422-437`; `Rules/RulebookValues.cs:337-358`. NEW. No PR. Needs Tim's word (the ladder). Sonnet fixer. **Test:** DN250 in both gives the same minimum.

75. **F-075. Sizing defaults ignore Tim's 300 mm cover (600 mm cover and 6.0 m/s in `CreateDefault`).** LOW. Civil engineering. OPUS-E 26. Civil 3.0.70. `Services/SettingsSizingStandards.cs:91-99`. NEW. No PR. Code. Sonnet fixer. **Test:** `CreateDefault().MinCoverMm` equals Settings `minimumCoverDepth`.

76. **F-076. A drawing with UNITS not set is read as millimetres by the rules, so a unitless metre drawing makes every pipe 1,000 times short.** LOW. Civil engineering. OPUS-E 27. Civil 3.0.70. `Services/PipeGeometryHelper.cs:150-153`. NEW. No PR. Needs Tim's word (gap plan question 4). Sonnet fixer. **Test:** unitless record, pits 20 units apart with 6-digit coordinates: reads 20 m or Unknown.

77. **F-077. The self-cleansing check uses full-bore speed, so "0.6 m/s met" is optimistic at low flow.** LOW (information only). Civil engineering. OPUS-E 28. Civil 3.0.70. `Rules/RulebookEngine.cs:415`; `Services/PipeSizingSolver.cs:256`. NEW. No PR. Needs Tim's word. Opus design. **Test:** none until Tim rules.

### Wording and windows, Civil + Manager (7)

115. **F-115. Manager window labels: "Current drawing session" (it is the AutoCAD session) and a "Module" tab (drafters say Civil, Structural, Manager).** LOW. Wording and windows. OPUS-UI 3, 4. Manager 1.1.70. `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:115,122`. NEW. No PR. Wording. Sonnet fixer. **Test:** the strings read "This AutoCAD, right now" and "CE tools".

116. **F-116. CDCHECKIGNORE polish: "(!)" and "(?)" have no key line, a wrong reason number ends the command, and three different wordings say when an ignored finding comes back.** LOW. Wording and windows. OPUS-UI 17, 18, 19. Civil 3.0.70 (switch OFF). `Services/Checks/IgnoreFindingPicker.cs:36`; `Commands/CheckIgnoreCommand.cs:111,128`; `AdvancedSettingsDialog.xaml:1260`. NEW. No PR. Wording. Sonnet fixer. **Test:** a key line prints first; a typo at the reason asks again; one "comes back" sentence in all three places.

117. **F-117. Message openings: the progress line starts "CE:", others start "[CDRUNSOLVE]", "CDAUDIT:", "CopyRot:" or nothing, where 674 messages start "[CE]".** LOW. Wording and windows. OPUS-UI 29, 68. Civil 3.0.70. `Rules/SlowWorkProgressTicker.cs:47-48` and others. NEW. No PR. Wording. Sonnet fixer. **Test:** a source guard that every user message starts "[CE]".

118. **F-118. CDTAG and Edit source window polish: two commands in one message, "Show tag label on screen?" versus "...on the drawing", OK greys out with no reason, Help does not mention the window.** LOW. Wording and windows. OPUS-UI 32, 33, 34, 35. Civil 3.0.70. `Commands/SourceTagCommand.cs:322,393`; `Dialogs/SourceEditDialog.xaml:39,55`; `Assets/Help/guide-content.js:42`. NEW. No PR. Wording. Sonnet fixer. **Test:** a space in the tag shows "One word, no spaces (for example DP2)".

119. **F-119. Fixes tab polish: one sentence repeated on 32 tooltips, two names for one tab, a vague "Tidy labels (more)" heading, a US-style phrase.** LOW. Wording and windows. OPUS-UI 46, 47, 48, 49. Civil 3.0.70. `Dialogs/AdvancedSettingsDialog.xaml:754,1342,1376,1377`. NEW. No PR. Wording. Sonnet fixer. **Test:** one bold line at the top of the Fixes tab; the repeated sentence is gone from each tooltip.

120. **F-120. Settings polish: one tick has two different descriptions (tooltip versus Settings search), two Survey boxes in a row, "DEBUGGING" versus "FAULT-FINDING", mixed capitals.** LOW. Wording and windows. OPUS-UI 53, 54. Civil 3.0.70. `AdvancedSettingsDialog.xaml:1089`; `ViewModels/SettingsValueCatalog.cs`; `Dialogs/CivilSettingsView.xaml:169,188,197`. NEW. No PR. Wording. Sonnet fixer. **Test:** the Settings search text equals the tooltip text for CommandOutcomeLines.

121. **F-121. Small ribbon tooltip polish (CDINSPECTOR, CDSTRIP "100mm-wide", CDSOURCE "user-typed source ID", CDPERIMETER "AG-style engine").** LOW. Wording and windows. OPUS-UI 60. Civil 3.0.70. `Assets/Config/command-registry.json` (several entries). NEW. No PR. Wording. Sonnet fixer. **Test:** none beyond reading the four strings.

### Structural (5)

78. **F-078. CEMEMBER draws onto a frozen or off layer and still says "placed".** LOW. Structural. OPUS-A 5. Structural 1.0.121. `SbeamAtomicPlacementWriter.ReadLayerStates`; `SbeamOutputProtectionContract.TryAdmit`. NEW. No PR. Code (warn and carry on, R-27). Sonnet fixer. **Test:** freeze 25CONT, run CEMEMBER: a plain line names the frozen layer.

79. **F-079. CEMEMBER's section-name question does not take Space as Enter.** LOW. Structural. OPUS-A 8. Structural 1.0.121. `Commands/CeMemberCommands.cs:351`. NEW. No PR. Code. Sonnet fixer. **Test:** type `310UB32` then Space: the next question appears.

80. **F-080. CEMEMBER's locked-layer refusal says "SBEAM output layer is locked".** LOW. Structural. OPUS-A 10. Structural 1.0.121. `SbeamPlacementPersistenceContract.cs`; `Services/CeMemberLineWriter.cs:74`. NEW. No PR. Wording. Sonnet fixer. **Test:** lock 25CONT: the line starts "CEMEMBER:".

81. **F-081. After S-41, CEHATCHAUDIT flags every older LBH and LBUH hatch at 1:50 and 1:100, and Repair rescales them.** LOW. Structural. OPUS-A 13. Structural 1.0.121. `Core/Units/DrawingScaleRule.cs:59-60`; `Commands/HatchUpgradeCommands.cs:563`. BUG-748 (related). No PR. Needs Tim's word. Opus design. **Test:** old LBH at DIMSCALE 100: Report either leaves it or flags it, as Tim chooses.

82. **F-082. Settings recovery tells the drafter to check three switches (FollowAnyDrawingScale, HatchDensityFollowsPaper, TagTextFollowsLabelHeight) that have no Settings row.** LOW. Structural. CDX-S F8. Structural 1.0.121. `Services/SettingsService.LoadRecovery.cs:282,828,1321`. NEW. #1526 adds Civil rows only. Wording. Sonnet fixer. **Test:** a damaged OFF value: recovery says the key has no Settings page.

---

## NEW BUG ENTRIES

For the desk to append to `C:\CE_PLAN\BUG_CARPARK.md` (the template at the top of that file). 82 entries, BUG-873 to BUG-954, in ledger order (every NEW HIGH and MEDIUM finding). **Before appending:** BUG-866 is used twice in the file (CDCHECKIGNORE Undo, and the rainfall note); renumber one. Every entry: **Steps for Tim: none, AI tests it.**

## BUG-873

**Command / Area:** CDTIDYLABELS (Tidy labels), ledger F-003.

**Symptom:** Tidy labels takes the writing start-up (it marks the drawing active and can save the CE project record) before its switch, selection, preview and Yes/No. Answering No or pressing Esc can still leave the drawing changed. HIGH.

**Expected behaviour:** A cancelled or preview-only Tidy labels run writes nothing to the drawing.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 1; `Commands/TidyLabelsCommand.cs:35`, `Commands/CeCommandBase.cs:29,43`. Related BUG-863. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-874

**Command / Area:** CD (Esc after a pipe with a callout), ledger F-004.

**Symptom:** After a successful pipe with a callout label, pressing Esc for the next pipe throws away the callout's deferred link record. The pipe and callout stay but are not linked, so erasing the pipe leaves the label behind or moving the pipe leaves the arrow at the old spot. HIGH.

**Expected behaviour:** The link is written for every item placed before the Esc.

**Reference:** CODEX_HUNT_UNDO_22OCT.md U-01; `Services/LinkService.Reactors.cs:1420,1542,1557`, `Commands/CdCommand.cs:214,235,1196`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-875

**Command / Area:** CDCHECKIGNORE fingerprint, ledger F-005.

**Symptom:** An ignored warning stays hidden after the design changes: the remembered fingerprint omits the pit, the clearances and the actual and required layer. HIGH (switch OFF today).

**Expected behaviour:** Any change to an input the finding depends on brings the row back as "Asked again".

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 2; `Services/Checks/IgnoredChecks.cs:198-263`, `ChecksResult.cs:228-296`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-876

**Command / Area:** CDIMPORTXCIVIL and CDIMPORTLANDXML, Replace, ledger F-009.

**Symptom:** Replace deletes the old imported pit before checking that the replacement can be drawn. If the new pit needs a locked layer (for example 25TEXT for a new cover level) the old pit is gone and nothing replaces it. HIGH.

**Expected behaviour:** Old items whose replacement cannot be drawn are kept and a warning says so; the rest import.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 1; `Services/XcivilImportService.cs:1921,1950`. Related BUG-731, BUG-417. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-877

**Command / Area:** CDIMPORTLANDXML and CDIMPORTXCIVIL review window, ledger F-010.

**Symptom:** Choosing a different source on the review page and clicking Read source imports the previously read file. HIGH.

**Expected behaviour:** A source change starts a fresh read; acceptance is bound to the file that was reviewed.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 2; `Commands/LinkCommands.ImportXcivil.cs:73,164-179`, `ViewModels/CivilImportWindowViewModel.cs:53,60`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-878

**Command / Area:** CDIMPORTLANDXML named inverts, ledger F-011.

**Symptom:** With one level and one end, the single-level shortcut assigns the level to a pipe even when the file names it for another pipe (pipe B gets 9.75 m that belongs to A). HIGH.

**Expected behaviour:** An explicit mismatching pipe name outranks the shortcut; the level stays Unknown.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 3; `Helpers/LandXmlParser.cs:260,277,328`. Related BUG-605. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-879

**Command / Area:** CDTIDYLABELS hand-placement, ledger F-012.

**Symptom:** With "hand-placed labels stay" ON, a label moved with CE's own Slide along pipe or CDANNOTATIONEDIT is not marked hand-placed, and a hand-moved pit cover text is ignored, so Tidy labels moves them again. HIGH.

**Expected behaviour:** Any CE hand move marks the label as hand-placed.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F1; `Services/LinkService.PipeAttachmentActions.cs:323-352`, `Services/LinkService.TidyPitText.cs:87,100`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-880

**Command / Area:** CEMEMBER in a metre drawing, ledger F-014.

**Symptom:** CEMEMBER uses millimetre section sizes as drawing units, so in a metre drawing a 310UB32 section comes out 298 m deep; break overshoot and kink are wrong the same way. HIGH.

**Expected behaviour:** Sizes are converted by the drawing units, or a plain warning says the drawing is not in millimetres.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F2, OPUS-A finding 9; `Commands/CeMemberCommands.cs:79,128,191`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-881

**Command / Area:** CEHATCHAUDIT Repair with an unusable DIMSCALE / LTSCALE pair, ledger F-015.

**Symptom:** Placement refuses a mismatched DIMSCALE/LTSCALE pair, but the audit substitutes the old 1:20 value and repairs a correct new hatch back to it (LBUH 50 becomes 20). HIGH.

**Expected behaviour:** An unusable scale pair is reported as unknown and never authorises a repair.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F4; `Commands/HatchUpgradeCommands.cs:343,380,413,576`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-882

**Command / Area:** CE installer, Windows administrator rights, ledger F-016.

**Symptom:** The installer requests elevation, so a colleague without administrator rights cannot start it. HIGH (release blocker for self-install; the 9 Nov pilot uses a hand install).

**Expected behaviour:** A first install into the colleague's own folder works without Windows administrator rights.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 1; `Installer/app.manifest:7`. Related BUG-483. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-883

**Command / Area:** CE installer, no first-install route, ledger F-017.

**Symptom:** Running the installer with no arguments exits with usage (64); `--install` and `--update` are retired and the embedded ZIP code is switched off. A PC with no Manager has no way to start. HIGH (release blocker for self-install).

**Expected behaviour:** A documented first-install route that needs no developer command knowledge.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 2; `Installer/Program.cs:13,21`, `CeInstallerApplication.cs:77-253`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-884

**Command / Area:** Manager approved releases, absolute paths, ledger F-018.

**Symptom:** `approved.json` stores the approving PC's absolute folder paths; another colleague's PC then refuses the same files as outside the allowed office folder. Rollback paths have the same fault. HIGH.

**Expected behaviour:** Approvals resolve to the current user's office root, with every approved hash unchanged.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 3; `Modules/Manager/Services/CeApprovedReleaseService.cs:46,107,108,122,751,761`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-885

**Command / Area:** Installer packaging (build_installer.ps1), ledger F-019.

**Symptom:** The script rebuilds all lanes and the native files and zips the new tree, instead of sealing the accepted candidate. The delivered files can differ from the tested ones (the "payload 85" fault). HIGH.

**Expected behaviour:** Packaging takes the frozen candidate folder and refuses any file whose hash differs. No rebuild after acceptance.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 4; `Installer/build_installer.ps1:185-332`, `ReleaseAuthorityPackaging.cs:379,397`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-886

**Command / Area:** Civil and Manager separate activation, shared file, ledger F-021.

**Symptom:** Civil can be activated alone while an older Manager remains, leaving two different copies of CE_SHARED; the ribbon or commands can fail depending on load order. HIGH.

**Expected behaviour:** Incompatible pairing is refused, or the pair is completed or recovered before restart.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 6; `Installer/SafeBundleInstaller.cs:252,281,442`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-887

**Command / Area:** First-run behaviour switches versus Tim's, ledger F-023.

**Symptom:** A fresh PC gets the program's starting values, which may differ from the switches Tim uses every day (Civil editor flags, drawing behaviour, Manager switches). Not proven either way. HIGH (release-evidence gap).

**Expected behaviour:** Every difference between Tim's behaviour values and first-run values is listed and ruled on.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 8; `Modules/Drainage/Services/SettingsService.cs:51-749`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-888

**Command / Area:** Installer interruption and uninstall, ledger F-024.

**Symptom:** If the installer is killed after the old folder is retired and before the new one is placed, CE can be missing on restart, and a colleague has no uninstall or restore command. HIGH.

**Expected behaviour:** A tested recovery route restores a complete pair, and a documented uninstall exists.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 10; `Installer/SafeBundleInstaller.cs:314-351`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-889

**Command / Area:** Corporate Windows trust of the EXE and native files, ledger F-025.

**Symptom:** CE's signed-package check is not Windows publisher signing or a company allow-list; Max's IT may refuse the EXE or an ARX/DBX file. Not seen. HIGH (environment gate).

**Expected behaviour:** The final delivery passes the company's normal checks, or the refusal is recorded and handled.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 12; `Shared/CE.Release/OfficialReleaseGate.cs:724,829`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-890

**Command / Area:** One-piece CE pipes on older AutoCAD years, ledger F-026.

**Symptom:** The native grip and object files only cover 2027, so an existing one-piece CE pipe drawing from Tim's PC may not work on 2022 to 2026. Not seen. HIGH (compatibility gate).

**Expected behaviour:** Each promised year opens such a drawing and edits it as supported, or the limit is stated.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 13; `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs:7,18,55`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-891

**Command / Area:** CE_VERSION (About CE Suite window), ledger F-065.

**Symptom:** The three rows start as "Not loaded" and stay so if reading the versions fails, so a loaded Civil can read "Not loaded". AutoCAD shows as an internal number (25.1) and falls back to a guessed "2022+". HIGH (the text can be false).

**Expected behaviour:** Rows start as "Checking" and a failure says "CE could not read this. Type CEHEALTH." The AutoCAD row shows the year or "not read".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 7 and 8, CODEX_AUDIT_GATE_22OCT.md finding 14; `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:67-73`, `CeVersionWindow.xaml.cs:34-44`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-892

**Command / Area:** CE Suite Manager window, install step wording, ledger F-083.

**Symptom:** The window says "Then run the CE installer" but only the administrator can run it; the status line already says to ask the administrator. HIGH (false for a colleague).

**Expected behaviour:** Both lines use the same words; a colleague reads "ask your CE administrator to finish the install".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 1; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:177,189`, `Services/CeInstallWords.cs:6-15`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-893

**Command / Area:** CDCHECKIGNORE list, rows beyond 40, ledger F-084.

**Symptom:** Only 40 rows are printed but the command offers "type their number" for the rest, so a finding that was never shown can be ignored. HIGH.

**Expected behaviour:** Print every row, or refuse numbers that were not shown and say how to see the rest.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 13; `Commands/CheckIgnoreCommand.cs:93,141`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-894

**Command / Area:** CDCHECKIGNORE refusal wording, ledger F-085.

**Symptom:** One refusal says a finding "CE could not check" can be ignored; the next says a check CE could not run cannot be ignored. HIGH (the two messages contradict).

**Expected behaviour:** One consistent rule in plain words.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 14; `Services/Checks/IgnoredChecks.cs:90,93`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-895

**Command / Area:** CDCHECKIGNORE, "Asked again" rows, ledger F-029.

**Symptom:** A finding that returns as "Asked again" is not offered by CDCHECKIGNORE Ignore; the drafter must first Un-ignore the old entry. MEDIUM (switch OFF).

**Expected behaviour:** Ignore offers every row not still hidden after the fingerprint check.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 3; `Services/Checks/IgnoreFindingPicker.cs:18-27`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-896

**Command / Area:** CDTIDYLABELS leader-out planning, ledger F-030.

**Symptom:** Leader-out planning reserves room using a plain label that will not move, so a callout can be moved onto that label while CE reports a clear spot. MEDIUM (switch OFF).

**Expected behaviour:** The final applied set never overlaps a label that stays.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 4; `Services/LinkService.TextClashTidyUp.cs:426-437`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-897

**Command / Area:** CDTIDYLABELS obstacle space and search margin, ledger F-031.

**Symptom:** A layout pipe's labels are checked against model-space text, and the search margin does not grow with the leader-out distance. MEDIUM (switch OFF).

**Expected behaviour:** The scan uses the pipe's own space and covers every destination.

**Reference:** CODEX_AUDIT_CIVIL_22OCT.md finding 5; `Commands/TidyLabelsCommand.cs:169-176`, `Services/LinkService.TextClashTidyUp.cs:28,425,579-747`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-898

**Command / Area:** Inspector problem counts (Flat / backfall pipes and similar), ledger F-032.

**Symptom:** Clicking a count takes a write lock and a normal transaction even when the list is empty, which can use up the next U or lose a REDO. MEDIUM.

**Expected behaviour:** An empty lookup does nothing to the drawing history.

**Reference:** CODEX_HUNT_UNDO_22OCT.md U-02; `Services/InspectorPaletteService.cs:2752-2796`. Related BUG-861. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-899

**Command / Area:** CD with "Pick the route first" OFF, ledger F-033.

**Symptom:** After a pipe, CD starts an empty next command to show its window; cancelling it then pressing U once leaves the pipe, a second U is needed. MEDIUM.

**Expected behaviour:** One U after stopping removes the last pipe (needs Tim's design call).

**Reference:** CODEX_HUNT_UNDO_22OCT.md U-03; `Commands/CdCommand.cs:239,242`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-900

**Command / Area:** CDTIDYLABELS preview versus Apply, ledger F-034.

**Symptom:** The preview does not reserve earlier pipes' proposed moves, so Apply makes a different plan ("Will move 2", then 1 moves). MEDIUM (switch OFF).

**Expected behaviour:** The applied plan equals the accepted preview.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F2; `Commands/TidyLabelsCommand.cs:55-85`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-901

**Command / Area:** CDTIDYLABELS pit cover text, ledger F-035.

**Symptom:** The preview checks a translated rectangle but Apply also changes rotation and anchor, so the text can land on another note. MEDIUM (switch OFF).

**Expected behaviour:** The footprint checked is the footprint written.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F3; `Services/LinkService.TidyPitText.cs:84-120`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-902

**Command / Area:** CDTIDYLABELS on a layout sheet, cover text, ledger F-036.

**Symptom:** A layout cover text is counted as moved although its writer always refuses it; the reason is only in the CE log. MEDIUM (switch OFF).

**Expected behaviour:** "Moved" counts real moves and a plain line says what was left.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F4; `Services/LinkService.TidyPitText.cs:39-116`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-903

**Command / Area:** CDTIDYLABELS in a crowded drawing, ledger F-037.

**Symptom:** At 1,001 nearby text objects Tidy labels abandons the pipe, says CE could not read it, and can end with "No CE label needs to move". MEDIUM (switch OFF).

**Expected behaviour:** A bounded-work explanation and valid work continues.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F5; `Services/LinkService.TextClashTidyUp.cs:33,197-203`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-904

**Command / Area:** CDTIDYLABELS slide step Setting, ledger F-038.

**Symptom:** A very small positive Label slide step (for example 0.001) makes Tidy labels enumerate hundreds of thousands of candidates before the preview. MEDIUM (switch OFF).

**Expected behaviour:** A work budget with an explicit outcome, no hard block.

**Reference:** CODEX_HUNT_LABELS_22OCT.md F6; `Rules/LabelPlacementRule.cs:65-97`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-905

**Command / Area:** CDIMPORTXCIVIL and CDIMPORTLANDXML results page, ledger F-039.

**Symptom:** A pit skipped because of a locked layer is listed "Recorded" in the results window, and a zero-placement import can be called complete. MEDIUM.

**Expected behaviour:** Results come from what was actually drawn, retained or skipped.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 4; `Commands/LinkCommands.ImportXcivil.cs:219-229,508-518`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-906

**Command / Area:** CDIMPORTLANDXML Replace, position, ledger F-040.

**Symptom:** The new import's offset is worked out from the old import, which is then deleted, so the replacement lands in a different place from a clean import. MEDIUM.

**Expected behaviour:** The measured extents exclude the objects about to be erased, as the X-Civil lane already does.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 5; `Services/XcivilImportService.cs:1879,1921` vs `:694`. Related BUG-068. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-907

**Command / Area:** CDIMPORTXCIVIL PDF schedules, ledger F-041.

**Symptom:** A schedule spread over several pages returns only one page's rows, so pits on the continuation sheet lose their sizes and levels. MEDIUM.

**Expected behaviour:** Rows from every schedule page are collected.

**Reference:** CODEX_HUNT_IMPORT_22OCT.md finding 6; `Modules/tools/Extract-XcivilPdfSchedule.ps1:480-819`. Related BUG-781, BUG-804. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-908

**Command / Area:** CDRULES R-04 cover, ledger F-042.

**Symptom:** Cover is measured to the inside top of the pipe, so it is over-stated by the wall thickness (concrete 375 shows 320 mm, really about 275 mm). MEDIUM (needs Tim's word).

**Expected behaviour:** Cover to the outside top, with a wall-thickness table in Settings.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 4; `Rules/RulebookEngine.cs:466`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-909

**Command / Area:** CDRULES cover between pits, ledger F-043.

**Symptom:** Cover is checked only at the two pits against the lid level; a pipe under a lower garden bed between raised lids is never checked there. MEDIUM (needs Tim's word).

**Expected behaviour:** Cover can be checked along the pipe from surface levels.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 5; `Rules/RulebookEngine.cs:444-474`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-910

**Command / Area:** Inspector, Hub, repair checks versus CDRULES, ledger F-045.

**Symptom:** Different screens judge one pipe against different minimum grades (one figure versus the ladder) and covers (office 300 versus council value), so the Inspector can say OK where CDRULES warns. MEDIUM (needs Tim's word).

**Expected behaviour:** One minimum per pipe on every screen.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 7; `Services/DesignValidationService.cs:350`, `Services/MinimumCoverForChecks.cs:18-30`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-911

**Command / Area:** CDTWL storage volume, ledger F-047.

**Symptom:** CDTWL counts pipe ends inside pits twice and counts water below the orifice that cannot drain (about 100 L, about 4 per cent, on a 2,576 L job). Suspected. MEDIUM (needs Tim's word).

**Expected behaviour:** Live storage is the volume above the orifice, pipes counted wall to wall.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 9; `Rules/DetentionBranchCollector.cs:323-339`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-912

**Command / Area:** CDDESIGN storm sweep, ledger F-049.

**Symptom:** The sweep (5, 10, 15 ... minutes) skips storms near the peak, so storage can be 2 to 3 per cent short, and nothing says when the worst storm is the first one. MEDIUM.

**Expected behaviour:** A finer sweep near the peak, or a note.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 11; `Services/DetentionSizingService.cs:66-67,156-159`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-913

**Command / Area:** CDCALC Boyd's tab versus CDDESIGN, ledger F-050.

**Symptom:** The two use different hard-ground C (1.0 versus 0.9), so one job gets different storage figures. MEDIUM (needs Tim's word).

**Expected behaviour:** One value, set in Settings.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 12; `ViewModels/BoydsCalcViewModel.cs:233-237`, `Services/AutoDesignService.cs:62-69`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-914

**Command / Area:** CDRULES R-30 versus R-06, ledger F-051.

**Symptom:** R-30 judges a 100 mm downpipe left marked Detention while R-06 says it is "not judged". MEDIUM.

**Expected behaviour:** R-30 says Unknown for the same reason as R-06.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 13; `Rules/RulebookEngine.cs:95-106,479-497`. Related BUG-815, BUG-854. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-915

**Command / Area:** CDRULES pit drop where the pipe gets bigger, ledger F-052.

**Symptom:** Only inverts are compared, so a 150 in at 10.000 and a 300 out at 9.980 passes although the outlet top is 130 mm above the inlet top. MEDIUM (needs Tim's word).

**Expected behaviour:** A warning when the outlet obvert sits above the inlet obvert.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 14; `Rules/PitDropRule.cs:150-156`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-916

**Command / Area:** Engineering numbers fixed in code (R-00), ledger F-053.

**Symptom:** Council values (Kingston, Manningham, Casey), pump station numbers, sizing limits, storm, orifice, level limits and an X-Civil level range of 0 to 250 m are written into code, not Settings. MEDIUM (needs Tim's values).

**Expected behaviour:** Each number lives in Settings or the council profile; the code value is only a documented fallback.

**Reference:** AUDIT_ENGINEERING_CIVIL_2026-10-22.md finding 15 (about 30 files listed there). Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-917

**Command / Area:** CEMEMBER picked plane and UCS, ledger F-055.

**Symptom:** CEMEMBER keeps only X and Y of the picks (Z becomes 0) and draws a section square to the world axes, not the UCS. MEDIUM (needs Tim's word on the section).

**Expected behaviour:** Elevated geometry keeps its Z or is refused before writing.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F3, OPUS-A finding 7; `Commands/CeMemberCommands.cs:125,131,189-191`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-918

**Command / Area:** LBUH, LBH and CEMEMBER break marks on a layout sheet, ledger F-056.

**Symptom:** "Follows paper" still uses the model drawing scale when drawing directly on a layout sheet (a break kink is 100 mm on paper at DIMSCALE 50). MEDIUM (needs Tim's word).

**Expected behaviour:** Paper-sized marks on paper.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F5; `Commands/HatchCommands.cs:1655`, `Commands/CeMemberCommands.cs:99`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-919

**Command / Area:** EBT and 25C text height, ledger F-057.

**Symptom:** In a metre drawing the text is 125 m high; at DIMSCALE 0 and 1:50 it falls back to 250 and plots 5 mm instead of 2.5 mm. MEDIUM.

**Expected behaviour:** Height follows drawing units and the annotation scale, or the command says the scale is unavailable.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F6; `Services/CeTextService.cs:27,610,625,4655,5482-5520`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-920

**Command / Area:** CEMEMBER DefaultScale Setting, ledger F-058.

**Symptom:** With DIMSCALE 0 the Setting is ignored and the fixed 1:100 is used (150 / 200 mm breaks instead of 75 / 100 at 1:50). MEDIUM.

**Expected behaviour:** The Setting is used and named in the warning.

**Reference:** CODEX_AUDIT_STRUCTURAL_22OCT.md F7, OPUS-A finding 6; `Commands/CeMemberCommands.cs:98`, `DesignCore/SteelSections/CeMemberEngine.cs:188-190`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-921

**Command / Area:** Manager update staging, long paths, ledger F-059.

**Symptom:** A fresh Manager profile uses the long staging folder name, so a colleague with a long Windows profile path may not be able to prepare an update on older AutoCAD. Suspected. MEDIUM.

**Expected behaviour:** Staging succeeds or refuses cleanly before any partial copy.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 9; `Modules/Manager/Services/CeUpdateStagingService.cs:109,374`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-922

**Command / Area:** CE Settings first run when the settings folder cannot be created, ledger F-060.

**Symptom:** Civil falls back to defaults without telling the colleague why preferences are not remembered; the log may also be unavailable. MEDIUM.

**Expected behaviour:** A visible "not saved" explanation; commands keep working.

**Reference:** CODEX_AUDIT_GATE_22OCT.md finding 11; `Modules/Drainage/Services/SettingsService.cs:79,93`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-923

**Command / Area:** CE Suite Manager window, stage names, ledger F-086.

**Symptom:** Five different phrases name one update stage ("Installed next start", "Updates ready to get", "Ready next start", "Update ready", "2 · Ready"), so a drafter cannot tell approved from copied from installed. MEDIUM.

**Expected behaviour:** Three fixed words everywhere: Approved, Copied waiting, Starts next time.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 2; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:50,98,99,139,176`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-924

**Command / Area:** Manager finish-update messages (not connected yet), ledger F-087.

**Symptom:** The messages use "record" and give no next step, and one promises "It will finish when every AutoCAD window on this PC is closed" although no code starts the installer. MEDIUM (becomes false if connected too early).

**Expected behaviour:** Plain next steps, and the promise text can only appear once the part that starts the installer exists.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 5 and 6; `Modules/Manager/Services/CeFinishUpdatePlanner.cs:47,52,56`, `CeFinishUpdateStartRule.cs:36`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-925

**Command / Area:** CE_VERSION wording, ledger F-088.

**Symptom:** A ".NET 10" row drafters cannot act on, "CONFLICT — 2 copies" in capitals with no next step, "<path unavailable>", and three names for one window. MEDIUM.

**Expected behaviour:** "Two copies loaded (3.0.70 and 3.0.69). Close AutoCAD and ask your CE administrator."; one window name; no programmer placeholder.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 9 to 12; `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:4,34,78`, `Services/CeVersionReport.cs:97,101`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-926

**Command / Area:** CDCHECKIGNORE, switch-off message, ledger F-089.

**Symptom:** "Ignoring a finding is switched off in CE Settings." does not say which tab to tick. MEDIUM (switch OFF).

**Expected behaviour:** The line names CDS > Newer tools > Allow a finding to be ignored, and still says "Nothing was changed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 15; `Commands/CheckIgnoreCommand.cs:39`, `Services/Checks/IgnoredChecks.cs:88`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-927

**Command / Area:** CDCHECKIGNORE, empty drawing wording, ledger F-090.

**Symptom:** "This drawing has no CE project record yet" uses a software word and gives no next step. MEDIUM (switch OFF).

**Expected behaviour:** "This drawing has no CE pits or pipes yet, so there is nothing to ignore. Nothing was changed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 16; `Commands/CheckIgnoreCommand.cs:46`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-928

**Command / Area:** Checks window, "could not check", ledger F-091.

**Symptom:** The same words cover "a value is missing" and "CE failed while reading"; the row repeats its own title and gives no next step. MEDIUM.

**Expected behaviour:** Header "not known (a value is missing)"; the read-failure row says to run CDCHECK again and how to send a fault report.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 20; `Services/Checks/ChecksResult.cs:153,305-307`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-929

**Command / Area:** CDRULES row wording, ledger F-092.

**Symptom:** Rows use "provenance", "PitSelector size tier", "office seed", "per-type catalogue selection" and "fallback velocity". MEDIUM.

**Expected behaviour:** Plain words and a next step ("Set the material on the pipe").

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 21, 23, 24, 25; `Rules/RulebookEngine.cs:69,250-260,321,411-419`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-930

**Command / Area:** CDRULES "no minimum in the rulebook", ledger F-093.

**Symptom:** Rows say "no minimum cover in the rulebook" instead of where to set it (Settings-first). MEDIUM.

**Expected behaviour:** "No minimum cover set. Set it in CDS > Design."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 22; `Rules/RulebookEngine.cs:345,437,454,625,650`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-931

**Command / Area:** Council source window, ledger F-094.

**Symptom:** The window shows raw saved data (JSON including EntityHandle and SpineKey) and legal-sounding sentences. MEDIUM.

**Expected behaviour:** Values listed in words ("Diameter 225 mm, upstream IL 10.250"); no handles.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 26; `ViewModels/CouncilSourceViewModel.cs:63,80,82`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-932

**Command / Area:** "Unknown" versus "not known", ledger F-095.

**Symptom:** The Checks list says "not known" but Settings, council rule values, audit lines and a pipe-length message say "Unknown". MEDIUM.

**Expected behaviour:** "not known" everywhere a drafter reads it.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 27 and 28; `AdvancedSettingsDialog.xaml:919,1360`, `Rules/CouncilRuleValues.cs:333`, `Commands/LinkCommands.ReadOnlyAudit.cs:25-36`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-933

**Command / Area:** CDTAG messages, ledger F-096.

**Symptom:** "CDTAG removed." appears when nothing was tagged (Enter on an empty tag), and the success line reads "CDTAG applied: tag=DP2. Pipes linked to this block: 2." MEDIUM.

**Expected behaviour:** "[CE] No tag typed. This block has no source tag." and "[CE] Tagged DP2. 2 pipes are connected to it."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 30 and 31; `Commands/SourceTagCommand.cs:311,391`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-934

**Command / Area:** Settings tooltip naming a person, ledger F-097.

**Symptom:** A tooltip colleagues read says "Tim decides when to hide it (ruling of 18 Oct: it stays visible for now)." MEDIUM.

**Expected behaviour:** Plain text about the tick, no names or internal rulings.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 36; `Dialogs/AdvancedSettingsDialog.xaml:1375`, `CivilSettingsView.xaml:400`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-935

**Command / Area:** Settings tick with no visible effect, ledger F-098.

**Symptom:** A tick for the long-section row says "Nothing draws this row today". MEDIUM.

**Expected behaviour:** Hidden until something draws the row, or labelled "(no effect yet)".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 37; `AdvancedSettingsDialog.xaml:1369`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-936

**Command / Area:** Settings Fixes tab tooltips, ledger F-099.

**Symptom:** Eight tooltips use software words (stored deletion word, records, drawing identity, Point Order, runtime rounding, unlinked, Project QA, native, host drawing). MEDIUM.

**Expected behaviour:** Plain wording as in the audit's suggested text.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md items 38 to 45; `AdvancedSettingsDialog.xaml:1338-1398`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-937

**Command / Area:** Settings, start-up message to CE Cloud, ledger F-100.

**Symptom:** The tick is worded with "heartbeat", "install ID", "environment variables", "posts" and "queues", and does not say plainly what is sent. MEDIUM.

**Expected behaviour:** "At start-up, tell the CE office this PC is running CE (CE and AutoCAD versions and a PC code only)."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 50; `AdvancedSettingsDialog.xaml:1128-1129`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-938

**Command / Area:** Settings, "Furthest a label may move out (mm)", ledger F-101.

**Symptom:** It does not say model or paper millimetres; 1500 mm in the model is 7.5 mm on a 1:200 sheet. MEDIUM (switch OFF).

**Expected behaviour:** The label says "(mm in the model, 1500 = 1.5 m)".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 51; `AdvancedSettingsDialog.xaml:1215-1286`. Related F-063. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-939

**Command / Area:** Settings, new switches with no tick, ledger F-102.

**Symptom:** The double-click Edit source window (ON by default), leave out removed pits, slow-check progress and wrong-layer rows have no tick in Settings, so a drafter cannot see or change them. MEDIUM.

**Expected behaviour:** One tick each in CDS > Newer tools.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 52; `Models/DoubleClickSettings.cs:34`, `Models/UserSettings.cs:1985,2757,2764`. PR #1526 adds rows (check it covers all four). Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-940

**Command / Area:** Settings window name, ledger F-103.

**Symptom:** One window is called Preferences (ribbon, CD and Edit Pipe buttons), Settings (title bar, Help) and CE Settings (messages). MEDIUM (needs Tim's naming call).

**Expected behaviour:** "Settings" everywhere.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 55; `Assets/Config/ce_toolbar_layout.json:189`, `Dialogs/AdvancedSettingsDialog.xaml:4`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-941

**Command / Area:** Two things called "CE Manager", ledger F-104.

**Symptom:** CDMANAGER ("CE Manager") is the Drawing Standards Manager, but CESURVEYREVIEW says "Opens CE Manager" and means Suite Manager. MEDIUM (needs Tim's naming call).

**Expected behaviour:** CDMANAGER reads "Drawing Standards (CDMANAGER)"; the survey tooltip says "CE Suite Manager".

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 56; `Assets/Config/command-registry.json:319`, `Modules/Manager/Assets/Config/command-registry.json:33`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-942

**Command / Area:** Ribbon tooltips, banned words, ledger F-105.

**Symptom:** Tooltips for CDDASHBOARD, CDANNOTATIONEDIT, CDEXPORTENTITIES, CDSLABIMPORT and CDTAG use "network topology", "schedule drift", "compound entity", "Export Entities", "CE data model". MEDIUM.

**Expected behaviour:** Plain wording as in the audit's suggestions.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 57; `Assets/Config/command-registry.json:147,198,252,314,343`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-943

**Command / Area:** Repair Centre ribbon label, ledger F-106.

**Symptom:** "Repair Center" is US spelling and the tooltip says "sync, rebuild, upgrade and diagnostics". MEDIUM (LOW for the spelling alone).

**Expected behaviour:** "Repair Centre" with "Fix a drawing whose pits, pipes or schedule look wrong."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 58; `Assets/Config/command-registry.json:351,355`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-944

**Command / Area:** Manager Refresh button tooltip, ledger F-107.

**Symptom:** "Refresh plugin discovery, upload queued telemetry, and reload dashboard data." uses software words and does not say plainly that it sends data. MEDIUM.

**Expected behaviour:** "Look again for installed CE tools, send any waiting usage notes to the office, and refresh this screen."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 59; `Modules/Manager/Assets/Config/command-registry.json:27`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-945

**Command / Area:** Help Centre, Settings tabs, ledger F-108.

**Symptom:** Help lists six Settings tabs; the window has eight (Newer tools and Fixes are missing) and says "Pipes & Pits" where the tab is "Pipes and Pits". MEDIUM.

**Expected behaviour:** The Help line names all eight tabs.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 61; `Assets/Help/guide-content.js:95`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-946

**Command / Area:** Help Centre, who can switch Checks on, ledger F-109.

**Symptom:** Help says only the office administrator can switch it on; any drafter can tick it in Settings. MEDIUM.

**Expected behaviour:** "Switch it on in Settings (CDS) > Newer tools. Ask first: it has not been tested in AutoCAD yet."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 62; `Assets/Help/guide-content.js:58`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-947

**Command / Area:** CD window wording, ledger F-110.

**Symptom:** "Use single pipe entity", "...and validation rules" and "no invert or grade validation" are software words in the window used all day. MEDIUM.

**Expected behaviour:** "Draw the pipe as one line", "...and which checks apply", "Levels and grade are not checked."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 63; `Dialogs/CdDialog.xaml:238,244,469`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-948

**Command / Area:** Inspector and Edit Pit wording, ledger F-111.

**Symptom:** The Inspector shows "Handle", "GIO Handle" and "full-detail snapshot", and Edit Pit says "reference evidence, not authority". MEDIUM.

**Expected behaviour:** Handle rows hidden for colleagues; "This is the full view."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 64; `Controls/InspectorPanelControl.xaml:89,266,321`, `Dialogs/PitEditWorkshopDialog.xaml:203`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-949

**Command / Area:** Repair Centre and CD help page wording, ledger F-112.

**Symptom:** "Sync Links", "Sync first, rebuild second" and "refreshes caches from drawing truth" are software words. MEDIUM.

**Expected behaviour:** "1. Reconnect pits and pipes"; "Rebuild reads the pits and pipes again from what is drawn, and keeps what you typed."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 65; `Dialogs/CdRepairDialog.xaml:46,75`, `Dialogs/CdHelpDialog.xaml:94`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-950

**Command / Area:** Command-line messages in developer words, ledger F-113.

**Symptom:** "compound root", "no ProjectData record", "slab boundary polyline handle", "not a council profile id" and "entity(ies) skipped due to read errors" reach the drafter. MEDIUM.

**Expected behaviour:** Plain messages starting "[CE]" with a next step.

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 66; `Commands/AnnotationEditCommand.cs:57`, `RunSolveCommand.cs:288,467`, `SlabCommand.cs:1229`, `RulebookCommand.cs:158`, `HubCommands.cs:654`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-951

**Command / Area:** CDAUDIT and Recover Inverts messages, ledger F-114.

**Symptom:** Output reads like a programmer's dump ("pits=12, pipes=14, pipes-without-handle=0, duplicate-handle-groups=1", "cached ownership Unknown"). MEDIUM.

**Expected behaviour:** "[CE] CDAUDIT: 12 pits, 14 pipes. 2 pipes are copies of one another. Type CDREPAIR to fix them."

**Reference:** AUDIT_UI_WORDING_2026-10-22.md item 67; `Commands/LinkCommands.cs:403,405,2379`, `Commands/LinkCommands.ReadOnlyAudit.cs:36,40`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-952

**Command / Area:** CEHEALTH, Civil installed but not loaded, ledger F-122.

**Symptom:** When Civil's files are present but Civil is not loaded, CEHEALTH prints "[OK] CE Civil Suite v3.0.70" and can finish "All checks passed", while CE_VERSION says "Not loaded". MEDIUM.

**Expected behaviour:** A plain warning that Civil is not loaded, with the remaining checks carried on.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-01; `Modules/Manager/Commands/PluginManagerCommands.cs:184-243`, `Services/CePluginRegistryService.cs:517`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-953

**Command / Area:** Manager Get update ready, damaged prepared copy, ledger F-123.

**Symptom:** If one file is missing from a prepared update, clicking Get update ready again copies the good files, discards them and fails because the old damaged folder is still there ("conflicting identity evidence"). A restart does the same. MEDIUM.

**Expected behaviour:** The damaged copy is set aside and a new verified copy is prepared from the intact source; installed files do not change.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-02; `Modules/Manager/Services/CeUpdateStagingService.cs:370-430`. Steps for Tim: none, AI tests it.

**Status:** OPEN

## BUG-954

**Command / Area:** CE Tools > Updates & Rollback button, ledger F-124.

**Symptom:** For an ordinary colleague the button opens no window and prints that their Windows account is not set up as a CE administrator, although the Manager window already has an Updates page. MEDIUM.

**Expected behaviour:** The button opens the Manager Updates page for a colleague, or is labelled as an administrator function.

**Reference:** CODEX_HUNT_MANAGER_22OCT.md MGR-03; `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs:26`, `Commands/PluginManagerCommands.cs:91,139,148`. Steps for Tim: none, AI tests it.

**Status:** OPEN

---

## FIX BRIEFS TO WRITE (first 20, ranked)

Base branch for Civil and Manager briefs: `claude/rel-20261022m` (C-60 head `40ee0a36`), or the C-61 train head if it exists when the lane starts. Base for Structural: `claude/rel-20261022s2` (`2c9a9694`). Every brief: build and test with `-p:SkipDevBundle=true`; the lane writes the REGRESSION_LOG entry; Tim tests nothing. Files below are relative to `Modules/Drainage/` unless a full path is given.

1. **F-004 (BUG-874), CD Esc loses the callout link.** Files: `Services/LinkService.Reactors.cs`, `Services/LinkService.Registration.cs`, `Commands/CdCommand.cs`. Base: Civil. Sonnet fixer.
2. **F-006 (BUG-867), real pipe length in CDRULES.** Files: `Rules/RulebookEngine.cs`, `Services/PipeGeometryHelper.cs`, `Models/PipeData`. Base: Civil. Brief exists: `areas/CODEX_BUILD_ENG_REAL_LENGTH_22OCT.md`; Codex build.
3. **F-007 (BUG-868), drawn material in the solver.** Files: `Services/NetworkDesignService.cs`, `Commands/RunSolveCommand.cs`, `Services/AutoDesignOrchestrator.cs`, `Services/NetworkRedesignSolverService.cs`, `Services/ProposalApplyService.PlanBuilders.cs`. Base: Civil. Codex build.
4. **F-008 (BUG-866 second), rainfall note wording.** Files: `Rules/RainfallCurve.cs`, `Services/AutoDesignService.cs`. Base: Civil. Wording only, after Tim's yes on 29 Oct.
5. **F-019 (BUG-885), seal the installer payload.** Files: `Installer/build_installer.ps1` (edit the existing script, no new script), `Installer/ReleaseAuthorityPackaging.cs`, `Installer/CE_CVL_SUITE_Installer.csproj`. Base: Civil release branch. Sonnet with Opus review.
6. **F-009 (BUG-876), keep the old pit when the new one cannot be drawn.** Files: `Services/XcivilImportService.cs`, `Services/XcivilImportReportService.cs`, `Rules/XcivilImportLockedLayers.cs`. Base: Civil. Sonnet fixer.
7. **F-010 (BUG-877), bind acceptance to the reviewed file.** Files: `Commands/LinkCommands.ImportXcivil.cs`, `Dialogs/CivilImportWindow.xaml.cs`, `ViewModels/CivilImportWindowViewModel.cs`. Base: Civil. Sonnet fixer.
8. **F-011 (BUG-878), explicit invert names outrank the single-level shortcut.** Files: `Helpers/LandXmlParser.cs`, `Services/XcivilPipeInsertionService.cs`. Base: Civil. Sonnet fixer.
9. **F-046 (BUG-869), Pit Schedule depth to the pit floor.** Files: `Rules/PitScheduleDepthRule.cs`, the Pit Schedule row builder. Base: Civil. Codex build (cx_b09 queued).
10. **F-044 (BUG-870), round the held-grade drop up.** Files: `Services/LinkService.Utilities.cs`. Base: Civil. Codex build (cx_b10 queued).
11. **F-048 (BUG-871), CDTWL units.** Files: `Rules/DetentionBranchCollector.cs`. Base: Civil. Codex build (cx_b11 queued).
12. **F-032 (BUG-898), empty Inspector lookup touches nothing.** Files: `Services/InspectorPaletteService.cs`. Base: Civil. Sonnet fixer.
13. **F-054 (BUG-872), repair the back-test fixture.** Files: `Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs`. Base: Civil. Codex build (cx_b06 queued). Keep the 30 per cent band.
14. **F-003 (BUG-873), Tidy labels writes nothing before Yes.** Files: `Commands/TidyLabelsCommand.cs`, `Commands/CeCommandBase.cs`. Base: the branch of #1525 (same pattern). Sonnet fixer.
15. **F-027 (BUG-861), the six-row REDO test.** Files: test lane only, no source. Base: n/a. Codex build (test). Names the step that loses REDO.
16. **F-039 (BUG-905), import results from real insertion results.** Files: `Commands/LinkCommands.ImportXcivil.cs`, `Services/XcivilImportService.cs`, `Services/LandXmlImportReview.cs`. Base: Civil. Sonnet fixer.
17. **F-040 (BUG-906), LandXML Replace excludes the objects about to be erased.** Files: `Services/XcivilImportService.cs` (one call site, line 1879). Base: Civil. Sonnet fixer.
18. **F-013 (BUG-864), never change an existing hidden layer.** Files: `Modules/Structural/Services/StructuralDetailService.cs` (`EnsureLayerInTransaction`), `Modules/Structural/Services/CeMemberLineWriter.cs`. Base: Structural. Desk job already drafted it; no open PR seen, so check the branch before briefing.
19. **F-014 (BUG-880), CEMEMBER converts catalogue millimetres by drawing units.** Files: `Modules/Structural/Commands/CeMemberCommands.cs`, `Services/CeMemberSectionWriter.cs`, `Services/CeMemberLineWriter.cs`. Base: Structural. Sonnet fixer.
20. **F-065 (BUG-891), the About window must never say "Not loaded" after a failed read, and must show the AutoCAD year.** Files: `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml`, `CeVersionWindow.xaml.cs`, `Modules/Manager/Services/CeVersionReport.cs`. Base: Civil/Manager. Sonnet fixer; Codex looks at the window. (Max quotes this version in every bug report. Next in line: F-015 hatch repair, F-122 CEHEALTH, F-084 CDCHECKIGNORE rows beyond 40, F-124 Updates ribbon button.)

**Not in the top 20, already moving:** #1523 (F-001), #1525 (F-002), #1524 (BUG-866 Undo after a re-list), #1522 (F-028 and F-062: fix the scan before it ships), #1526 (Civil Settings rows), #1503 and #1493 (F-022). **After 9 Nov by the gap plan:** F-016, F-017, F-018, F-020, F-021, F-024 (installer work), F-042, F-043, F-052.

---

## Late sources

1. **Checked at Fri 23 Oct 00:09 Melbourne.** The areas folder held 10 source files, all merged above. Two arrived while this ledger was being compiled and were added: the Opus wording audit (40 entries) and the Codex Manager hunt (3 entries).
2. **Still to come, not merged:** AUDIT_ENGINEERING_STRUCTURAL, CARPARK_RECONCILIATION, and the Codex hunts for settings, windows, records, design, structcmds, privacy, perf and compat. When they land, the desk re-runs this job: new findings take F-125 onward and BUG numbers continue from BUG-955.
3. **Numbers to re-check after any addition:** the totals in ANSWER FIRST (124 findings; HIGH 30, MEDIUM 66, LOW 28; 82 new carpark entries BUG-873 to BUG-954).
