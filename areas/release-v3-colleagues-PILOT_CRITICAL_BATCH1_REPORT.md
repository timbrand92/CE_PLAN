# Pilot-critical batch 1: positions 1 to 7 ("Day one: the hand install and start-up") — report (Sat 24 Oct 2026)

Headless Team job, desk plan/03. Base `origin/claude/rel-20261024m` at `5467f705` (Civil 3.0.73 / Manager 1.1.73, fetched 11:51). Input: section (C) of `BUG_REGISTER_TRIAGE_2026-10-24.md`, positions 1 to 7. Nothing deployed, nothing closed, no bug marked FIXED. AutoCAD, Codex and accoreconsole were not started. CE_SHARED, Installer and signing untouched.

## ANSWER FIRST

Five of the seven are fixed in draft PRs (built and unit-tested; **nobody has opened any of them in AutoCAD**). Two are skipped because they need a protected shared file or a check on the colleague's PC first.

1. **BUG-1135 (position 7, HIGH, DATA LOSS): FIXED in draft PR #1747**, head `346d8e6b05e2906a32edec167dc72d13c6f6e6b5`, branch `fb/pc1-BUG-1135-job-record-unknown-fields`.
   - **What changes:** parts of the job record a newer CE wrote (ignored findings, paused features, review approvals, held-back labels, anything later) are kept and written back on save instead of deleted; the version marker is never lowered and goes from 2.2 to 2.3, so older builds now show their existing "saved by a newer version" warning.
   - **Tests:** new `Bug1135JobRecordKeepsNewerFieldsTests` (5; 4 fail on the base). Civil net10 full 19,811 total, 19,788 passed, 22 skipped, 1 failed (the PDF picture renderer test, flaky on this PC, passes on a rerun of the same build). net48 test build 0 errors. Three property-walking tests needed a sample for the new catch-all, and one pin of the literal "2.2" was rewritten (said in the PR). The guard also caught that a network redesign apply would have dropped the kept parts; fixed in the same PR.
   - **Real-AutoCAD check:** on a test copy run CDCHECKS, ignore one finding (`checks.allowIgnoreFinding` on), save, reopen, move a pit, save, reopen. Right looks like: still ignored. The real two-build case can only be driven once a newer build than this exists.
   - **Limit:** builds already installed elsewhere (3.0.73 and older) still drop the newer parts; only this build onward keeps them.

2. **BUG-1138 (position 6, MEDIUM, DATA LOSS): FIXED in draft PR #1748**, head `f9667b01b37a90676934b44b799e6a2a0859b4d2`, branch `fb/pc1-BUG-1138-sync-refuses-proxy-pipes`.
   - **What changes:** on a PC that cannot read CE pipe objects, CDSYNC, CDREBUILDLINKS, the Pit Schedule relink, a pit MOVE's relink and the import relink stop before touching any pit: "[CE] CDSYNC stopped: this drawing has 50 CE pipe objects this AutoCAD cannot read (the CE pipe add-on is not loaded on this PC). Every pit keeps its pipe list; nothing was changed. ..." On Tim's 2027 PC nothing changes.
   - **Tests:** new `Bug1138UnloadedPipeObjectRuleTests` (10) and `Bug1138RelinksStopForUnloadedPipeObjectsTests` (3, all fail on the base). Civil net10 full 19,819 total, 19,797 passed, 22 skipped, **0 failed**. net48 test build 0 errors.
   - **Real-AutoCAD check:** on a PC without the add-on, open a copy of a drawing with CE pipe objects, type CDSYNC. Right looks like: the "CDSYNC stopped" line with the right count, nothing changed. MOVE a pit: one "Pipe relink stopped" line. On Tim's 2027 PC: CDSYNC completes normally.
   - **Not done:** the one-line notice when such a drawing is opened (second ask in the entry).

3. **BUG-1206 (position 5, MEDIUM): FIXED in draft PR #1750**, head `cf6b3bec255c640e38616155d71c6f979beb739a`, branch `fb/pc1-BUG-1206-ce-tools-load-order`.
   - **What changes:** the CE Tools tab (Manager, Version, Health) appears as soon as AutoCAD is ready even when the Manager loads before Civil.
   - **Tests:** new `Bug1206CeToolsTabLoadOrderTests` (2, both fail on the base); one older test that pinned the removed early return was rewritten (said in the PR). Manager net10 full 952 total, 951 passed, 1 skipped, 0 failed; Manager net48 build 0 errors; Civil net10 full on the same branch (no Civil code changed) 19,806 total, 19,783 passed, 22 skipped, 1 failed (the same flaky PDF test, so it also fails on the base).
   - **Real-AutoCAD check:** NETLOAD Manager first, then Civil. Right looks like: CE Tools and the Civil tab straight away. Then Civil first, then Manager: one CE Tools tab, not two.
   - **Not done:** "tell Manager when a tab is added" needs `Shared/CE_SHARED/Services/CeRibbonRegistry.cs` (protected).

4. **BUG-1165 (position 2, MEDIUM): FIXED in draft PR #1751**, head `29324462abcfa34c06c641451d74302a8f35937d`, branch `fb/pc1-BUG-1165-blocks-from-running-bundle`.
   - **What changes:** PIT, fall symbols and other CE blocks come from the CE copy that is running, not an old all-users copy. New switch `pits.blocksFromRunningBundleFirst`, **ON** (guards a bug fix), no Settings row.
   - **Tests:** new `Bug1165BlocksFromRunningBundleFirstTests` (9; they do not compile on the base because the rule and switch are new; a wiring guard checks the real caller). One pin of the exact `pits` settings text was rewritten (said in the PR). Civil net10 full 19,813 total, 19,791 passed, 22 skipped, **0 failed**. net48 test build 0 errors.
   - **Real-AutoCAD check:** put a marked old `PIT BLOCK.dwg` (a big X in it) in `C:\ProgramData\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Blocks` (administrator), type PIT in a new drawing. Right looks like: the normal pit block, no X. Set the switch false before start-up and repeat: the X block (proves the switch). Remove the marked file.

5. **BUG-1167 (position 1, MEDIUM): FIXED in draft PR #1754**, head `9bb151be546c0691c5dfd497a9531ca1601f0bd7`, branch `fb/pc1-BUG-1167-settings-folder-paths`.
   - **What changes:** a settings file copied from Tim's PC no longer points the colleague's CDWT, CDNEWDWG and job time at Tim's own folders: at start-up, the four office folders that sit inside someone else's profile and are missing on this PC move onto this PC's own profile. New switch `linking.otherUsersFoldersFollowThisPc`, **ON**, no Settings row.
   - **Tests:** new `Bug1167FoldersFollowThisPcTests` (7; do not compile on the base, the rule and switch are new; wiring guard on the start-up read). Civil net10 full 19,813 total, 19,791 passed, 22 skipped, **0 failed**. net48 test build 0 errors.
   - **Real-AutoCAD check:** on a second Windows login with the office OneDrive synced, copy Tim's CD_Settings.json in (keep theirs), start AutoCAD, type CDWT (right: the tank window with office tank plans) and CDNEWDWG (right: office templates offered); Settings, Advanced, Drawing Templates folder reads that login's own `C:\Users\<name>\...`. Put their file back.

6. **BUG-1166 (position 4, MEDIUM): SKIPPED — needs a protected shared file, and Max's OneDrive layout is unknown.** The code claim is true on the base: Manager looks under `%OneDriveCommercial%` first (`Modules/Manager/Services/CePluginInstallerService.cs` `GetItAdminPath`), Civil only under `%USERPROFILE%\Creative Engineering\...` (`FeedbackService`, `CivilJobTimeSettings`, the two folder defaults in `UserSettings`, CE Blocks). The entry asks for "one shared office-folder lookup used by both", which can only live in `Shared/CE_SHARED` (must not change in this job). Options for Tim:
   - **(a) Recommended:** a small `CeOfficeFolders` lookup in CE_SHARED (OneDrive variable first, then the profile layout), used by Civil, Manager and CE Blocks. Needs Tim's OK to change CE_SHARED. One code path, matches the entry.
   - **(b)** copy Manager's OneDrive-first lookup into Civil only. No Shared change, but two copies of the same rule (breaks design rule 1, one code path per behaviour) that can drift.
   - **(c)** do nothing in code before 9 Nov; check on Max's PC where "Creative Engineering - Drafting" actually lands (Sync vs "Add shortcut to My files"). If it is the usual `C:\Users\<name>\Creative Engineering\...`, the bug does not bite the pilot.
   - Whatever is chosen, (c) should happen before 9 Nov; it also decides whether BUG-1167's fix finds the folders on Max's PC.

7. **BUG-1169 (position 3, MEDIUM, UNSURE): SKIPPED — the entry's own fix is a release check on the colleague's PC, then code only if confirmed.** Verified on the base: CE_SHARED is still labelled `1.1.0.0` (`Shared/CE_SHARED/CE_SHARED.csproj` lines 14 to 16), and Civil reaches `CeRuntimePaths` through it (`Modules/Drainage/Services/RuntimePathService.cs`), so an older same-numbered copy loaded first could lack it. Whether AutoCAD loads Max's July Structural copy first is not knowable without his PC (RULES 12.5). Options:
   - **(a) Recommended before 9 Nov:** read the version and date of Max's Structural bundle; if it holds its own `CE_SHARED.dll`, switch that bundle off or move it aside before the first start.
   - **(b)** later, a CE_SHARED version bump per release so two copies are told apart (protected file, needs Tim's word).
   - **(c)** a Civil start-up check that names the mismatch in plain words instead of "command failed" lines (code, but only worth it if (a) finds the old copy).

**What I did NOT test (RULES 5.9):** nothing was opened in AutoCAD; no PC without the CE pipe add-on, no second Windows login, no all-users bundle folder, no Manager-first NETLOAD were tried. Structural tests were not run (no Structural code changed). Civil net48 tests were compiled, not run (the net48 lane fails on reference-only AutoCAD assemblies on this PC). The PDF picture renderer test (`LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`) failed in three full runs and passed in two, including a pass and a fail on the same build; it is not touched by any of these changes.

## Notes for the merger

1. All five PRs touch `REGRESSION_LOG.md` at the top (keep both sides when merging). #1751 and #1754 each add one setting to `UserSettings` sections (`pits`, `linking`); the C-64 finalizer's new-switch defaults test should pin both ON.
2. #1747 raises the job-record version marker to 2.3; any later PR that adds a job-record field should raise it again (comment beside the constant).
3. #1748's stop also covers the BUG-189 scoped relink (pit MOVE), which sets `fallbackReason = "unloaded-pipe-objects"` so its caller skips the endpoint pass.

## Method

1. Each bug: carpark entry read; `gh pr list --state all --search BUG-nnnn` (no existing fix for any; the one hit for BUG-1166, #547, is an unrelated footing PR). Cause verified in the base code before any change.
2. One private worktree per fix under `C:\ce-fx\pc1a` to `pc1e`, each removed after its push. Builds and tests in the foreground with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the C-62 reference paths; free space checked before each build (19 to 21 GB). One full Civil run outlasted the tool's 10-minute wait and finished in the background; its result was read from its log.
3. RED: for #1747, #1748 and #1750 the new tests were run against the base source (4 of 5, 3 of 3 and 2 of 2 failed). For #1751 and #1754 the tests use new members, so they do not compile on the base.
4. Leak scan clean on all five pushes.
