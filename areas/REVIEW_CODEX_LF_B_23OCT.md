# Opus review: Codex ledger-fix batches 03 to 07 (Manager update PRs and import PR), plus a second opinion on the Codex PR-review groups

Friday 23 October 2026, 19:35 Melbourne. Reviewer: Claude Opus 5.5, independent. I read the code at each PR's head, not the PR text.
Nothing was built, installed or opened in AutoCAD. No PR, branch or setting was touched.

## ANSWER FIRST

1. **The PRs I reviewed first (six):** MERGE 2 (#1647 BUG-884, #1654 BUG-899). MERGE-WITH-FIXES 1 (#1648 BUG-886). HOLD 3 (#1649 BUG-885, #1652 BUG-887, #1651 the batch 05 routing notes). REJECT 0.
2. **Second opinions on the Codex review groups (01, 02, 03, 06; groups 04 and 05 have no report yet):** Codex raised 12 new faults (3 + 2 + 3 + 4). It is right on 11. The twelfth is #1636: the fault is real, but Codex rates it too high and it should not stop that PR.
3. **Fault 1, the worst: #1652 (BUG-887) would stop every future Civil and Manager update going through the installer.** Each update installs one half at a time. The check refuses that half whenever the other half's shared support file (CE_SHARED) is different. In practice it is different after every release, because the file records the folder it was built in. So Civil gets refused because the old Manager is still there, and Manager gets refused because the old Civil is still there. It is also a new hard block, and only two are allowed. HOLD.
4. **Fault 2: #1649 (BUG-885) removes the installer build script and puts a different tool in its place.** The release chat's packaging route uses that script. The change was not approved by Tim (the rule: no new or replaced build scripts without his word). Nothing yet writes the "accepted file list" the new tool needs. The PR also deletes one unrelated safety guard test, and at least five Civil tests will fail because they read the old script. HOLD.
5. **Fault 3: Pit Schedule faults that are ALREADY INSTALLED in 3.0.72.** Codex found them and the earlier Opus reviews missed them. (a) The "With Step Irons" note goes by the depth shown in the cell, which is rounded to 10 mm and can be typed over. A pit 904 mm deep shows 0.90 and loses its step-iron note, and typing a smaller depth removes the note too. (b) Updating one schedule changes the depth heading inside the block definition, so every other schedule drawn from the same frame block gets "PIT DEPTH (m)" above its old outlet-depth figures. These need new fix PRs on C-63. Holding #1531 now does nothing, because its code has already shipped.
6. **Safe to merge today (C-63 Civil/Manager):** #1647 (BUG-884), #1654 (BUG-899) and #1636 (BUG-1030). #1648 (BUG-886) also goes in, once its builder pushes the newer commit `dddd45a6`, which already exists on this PC.
7. **Seven of the PRs the groups flagged are already inside installed 3.0.72:** #1522, #1531, #1535, #1553, #1617, #1619 and #1625. Their PR heads are part of `claude/rel-20261023m`. So their faults are faults in the installed version. Each needs a small follow-up fix on C-63, not a hold.

---

## Part 1: PRs from the ledger-fix batches (my own review)

### 1. #1647, BUG-884: office approvals follow each PC's synced folder (Manager). **MERGE, C-63.**

1. **Cause is real.** At the base, Manager saves `approved.json` with the approving PC's full folder path (for example `C:\Users\TimothyBrand\OneDrive...\builds\71\...`). A colleague's OneDrive sits under a different user name, so the safe-folder check refuses it.
2. **The fix does only that.** When Manager saves, the four folder paths (current and rollback, bundle and manifest) are written relative to the office IT Admin folder. When Manager reads, they are rebuilt under that PC's own IT Admin folder. Reader and writer work out the same root (`IT Admin\CE Plugin Admin\releases` is two folders below it). Every hash, the signer and the source commit are copied unchanged, and the signature check still runs on the files it finds. So the security of the update is unchanged; only where it looks has changed.
3. **Tests.** Four new test groups. They cannot compile without the fix. They check that an approval saved on "office A" reads back under "office B", that a path climbing out of the office folder (`..\outside`) is refused, and that reading never rewrites the shared file. The test does not drive the real `SaveManifest`, because that needs the real OneDrive folder. A newer commit, `3a179e73`, exists on this PC but is not pushed; it changes tests only.
4. **Installer unaffected.** The installer's own reader of `approved.json` (`Installer/CeOfficeApproval.cs`) reads only the version and rollout status, never the paths.
5. **Risks, both small.**
   1. **Order of rollout:** a colleague still on the OLD Manager reads the new short paths as "outside the safe folder". That colleague is already refused today, so nothing gets worse. But the fixed Manager must reach colleagues before it helps. And Tim must approve once more after installing it, so the shared file gets rewritten in the new form.
   2. **Second administrator:** if a different administrator's PC wrote the previous approval, its old full path does not sit under this PC's folder. Approving again then fails with "points outside the safe synced office folder". Only Tim approves today, so this is LOW. Note it before a second administrator is ever added.
6. **Checks against the rules.** No CE_SHARED change, no setting, no new hard block, no drawing writes.

### 2. #1648, BUG-886: the installer enforces the office-approved version. **MERGE-WITH-FIXES, C-63.**

1. **Cause is real.** At the base, any `--approved-version=` typed on the command line made the installer skip reading the office approval, even when it was blank or older. So a blank flag let an out-of-date signed build install.
2. **The fix is right.** The office approval is now always read. A caller's value is kept only when it is a real version at least as new as the office one. Otherwise it is replaced by the office version. A garbage value with no office approval is refused before anything changes (exit 64). That is argument checking, not a new user-facing block. When the office approval cannot be read (no file, damaged, or a canary rollout), the installer warns "CE could not check the office approval for this PC" and carries on (R-27).
3. **Tests fail without the fix.** For example, a blank flag over an office approval of 3.0.70 must refuse 3.0.69. The old test that said "an explicit flag is never replaced" was correctly turned round.
4. **Fix needed: push commit `dddd45a6`.** At the PR head, the warning goes only to the console. Manager starts the installer itself, so nobody sees that console, and the warning never reaches the saved install record. Commit `dddd45a6` ("retain unknown-office warnings in durable install results") is already on this PC, not pushed. It writes the warning into the install record and is the right fix. Merge only once that commit is on the PR.
5. **Small wording point (LOW).** On a canary PC the approval is known (it is a canary), but the warning still says "could not check". Better wording: "the office approval for this PC is a trial (canary) rollout". Not a blocker.
6. **No CE_SHARED change.** No new hard block beyond the existing "older than approved" refusal Tim ruled on for BUG-834 ("yes", 20 Oct).

### 3. #1649, BUG-885: seal the accepted package without rebuilding. **HOLD (needs Tim's approval and a rework).**

1. **Cause is real.** The old `Installer/build_installer.ps1` rebuilds all three lanes, the native modules and the blocks, then zips the new files. That zip can differ from the files Codex tested.
2. **The new C# packer is good work.** It is `CeFrozenCandidatePackaging`, run through `--pack-frozen` in the release authority. It checks the signature twice, holds every file shut against changes while zipping, re-reads every zip entry against the accepted hash list, and never overwrites an earlier zip.
3. **Fault A: the whole build script is replaced (about 380 lines removed).** The old script produced the installer program and the release zip. The release chat's procedure (CHAT_PROMPT_RELEASE_03.md, item 67) wraps "the repo's approved build_installer.ps1 routes". The replacement takes five compulsory inputs, and nothing in the repo produces two of them: the "accepted file list" and its recorded hash. So after this PR there is no way to make an installer at all until another piece is built. That is a build-route change, and it needs Tim's explicit approval.
4. **Fault B: an unrelated safety guard test is deleted.** `RetiredRivalDeployRoutes_ContainOnlyDeterministicHardFail` checked that the two retired deploy scripts cannot copy, delete or write anything. It has nothing to do with BUG-885 and must stay.
5. **Fault C: Civil tests will go red.** At least five Civil tests read `build_installer.ps1` and look for text that is now gone. I confirmed every searched string is missing at the PR head:
   1. `NativePipeObjectTests`: two tests looking for "CE object enabler is staged from Release only" and `CE_CVL_OBJECTS_2027.vcxproj`.
   2. `BlockShippingTests.BuildInstaller_ShipsEveryBlockInSourceBlocks`: looks for `source_blocks` and `Get-ChildItem`.
   3. `BundleManifestTests.BuildInstaller_UsesTrackedPackageContentsManifest`: looks for the PackageContents copy lines.
   4. `BundleManifestTests.BuildInstaller_UsesMonorepoDrainagePathsAndAllRuntimeLanes`: looks for the three lane builds.

   The batch report says validation was still pending, so nobody has run the Civil suite on this head.
6. **What to do.** Keep the new `--pack-frozen` operation and its tests. Leave `build_installer.ps1` as it is for now, with a clear printed line: "This zip is for building only. Deliver only a --pack-frozen archive." Restore the deleted guard test. Then ask Tim whether the old rebuild route may be retired, once something records the accepted file list at Codex acceptance.

### 4. #1652, BUG-887: refuse a Civil and Manager support-file mismatch. **HOLD (reject this design; keep the detection idea).**

1. **Cause is real.** The installer can switch on Civil alone while an older Manager stays. The two then carry different copies of the shared support file, and whichever loads first wins.
2. **Fault A, HIGH: it stops normal updates.** The installer handles one half per run, and no "install both together" route exists (the batch 03 report says so too). Whenever the new Civil's `CE_SHARED.dll` differs from the installed Manager's, Civil is refused. Then Manager is refused because the installed Civil is still old. It is stuck both ways. The shared file differs after almost every release, because `CE_SHARED.csproj` sets `DebugType pdbonly` with no path mapping. The finished file records the folder it was built in, and every release train builds in a new folder. The tests only cover "identical bytes are allowed" and "different bytes are refused". There is no test of a real two-step update (new Civil, then new Manager, over the old pair).
3. **Fault B: a new hard block.** R-27 allows only two hard blocks (deleting spine IDs, and pushing an update after a failed build). This adds a third.
4. **What to do.** Either add a paired activation, where one installer run switches on both halves or neither, or turn this into a plain warning saved in the install record. The detection code (renamed folders, every enabled copy, all three lanes) is sound and can be reused. Do not merge as it stands.

### 5. #1651, BUG-893 to BUG-897 (Tidy labels): routing notes only. **HOLD as a routing record; do not merge.**

1. **The causes check out.** I spot-checked two in the protected Tidy file. BUG-896: more than 1,000 nearby texts makes the pipe count as "unreadable" (lines 200 to 204 and 700 to 701). BUG-893: the preview returns before the shared scan is refreshed, and Apply refreshes it (lines 361 to 364 against 408).
2. **The PR claims no fix.** It adds 12 lines to the regression log saying SKIPPED. Merging it would put "nothing changed" entries into a release log, so leave it as a draft for the protected-file owner. Do not close it (Tim's no-close ruling).

### 6. #1654, BUG-899: LandXML Replace lands where a clean import would. **MERGE, C-63.**

1. **Cause is real.** `ImportLandXmlIntoCurrentDrawing` measures the drawing's extents, old import included, before deciding the move. Later, `ClearPreviousXcivilImportArtifacts` always erases that old import. So the new network shifts according to where the old one was.
2. **The fix is one line.** It passes the same "about to be erased" list the X-Civil route already uses (BUG-731). That list is gathered read-only and leaves out anything on a locked layer, so locked old objects still count, which is correct. Nothing is written before the review question (BUG-603 still holds).
3. **Tests.** One test pins the source line, and it fails on the base. Two number tests use the test file's own helper, not the real AutoCAD measurement. The real-AutoCAD check in the regression entry (same insertion points within 0.01 mm) is still owed.
4. **No setting, hard-coded value or CE_SHARED change.**

### 7. Batches 06 and 07, other bugs

1. **No PR to review yet.** BUG-900, BUG-904 and BUG-906 are "investigating / in progress", with no PR open. BUG-901, 902, 903, 905 and 907 were rightly skipped as engineering decisions for Tim. No batch 08 report exists yet.

---

## Part 2: second opinion on the Codex review groups (only the HOLDs and the faults raised against an Opus pass)

### 8. #1531, Pit Schedule depth from the pit floor. **Codex is right (G01 F1 and F3, G06 F1). Already installed in 3.0.72, so it needs a C-63 fix PR, not a hold.**

1. **Step irons (F1). I confirmed it.** With "depth uses the pit floor" ON (the default), `TryGetEffectiveDepth` returns just the depth cell's text. That text is rounded to two decimals (`ToString("0.00")`) and can be typed over. The note is added only when depth is more than the threshold. A pit 904 mm deep shows "0.90", which is not more than 0.90, so "With Step Irons" disappears. The rulebook (R-29) uses 904 mm and still asks for step irons. Before this change the code also checked cover minus each invert.
   - **Fix:** decide the note from the recorded levels (cover minus the lowest of floor, inlet and outlet), not from the cell.
   - **Severity:** MEDIUM-HIGH. A missing step-iron note on an issued schedule is a site-safety omission.
2. **Shared heading (F3). I confirmed it.** `UpdatePitDepthHeadingInTransaction` follows the frame's block definition, and any blocks inside it, and rewrites the matching heading text there. A block definition is shared by every insert of that frame, so another schedule (for example an archived one on a layout) gets "PIT DEPTH (m)" above its old outlet-depth numbers.
   - **Fix:** change only this schedule's own heading, or give this schedule its own copy of the definition.
   - **Severity:** MEDIUM, not HIGH as G06 says. The numbers are untouched, but the heading misdescribes them by the floor-to-outlet distance.
3. **Opus missed both**, in REVIEW_CODEX_PRS_B item 4.

### 9. #1522, downpipe double-click picks the block under the pointer. **Codex is right (G01 F2). Already installed in 3.0.72. Follow-up fix on C-63.**

1. **I confirmed it.** Every visible block in the current space is a candidate. "Under the pointer" means inside the block's rectangle. A border, title block or Xref that surrounds the downpipe counts as a second block, so the result is "ambiguous" and AutoCAD's own attribute editor opens instead.
2. **Worse in real drawings than Codex says.** Most Civil plans have the site or architectural base plan Xref'd in model space, covering every downpipe. So the fix will rarely fire on real jobs. It does no damage; it just falls back to the old behaviour.
3. **Fix:** when exactly one CE-tagged block is under the pointer and every other candidate is an untagged block or an Xref whose rectangle fully contains it, choose the tagged block. Keep "ambiguous" for two tagged blocks.
4. **Severity:** MEDIUM.

### 10. #1528 (test-state tool). **Both say HOLD. I agree.**

1. Codex's callback/REDO concern stands. Not in 3.0.72.

### 11. #1534, wording. **Codex is right (G02 F1). Verdict MERGE-WITH-FIXES, C-63 (not installed).**

1. **The fault.** This PR newly writes "Run CDCHECK again" in a failed-check row of the Checks window. CDCHECK does not refresh that window, and when "use shared result" is OFF (the default) it does not even re-run the rule check.
2. **Fix:** "Click Check again in this window."
3. **Not re-checked by me:** Codex says the garbled characters Opus found are repaired. Confirm with one clean build before merging.

### 12. #1535, Manager support. **Codex is right (G02 F2, LOW). Already installed in 3.0.72.**

1. **The fault.** The new Manager warnings say "the reason is in the CE log", but they write it to `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`. CEMANAGERLOGS opens only `%APPDATA%\CE_CVL_SUITE\logs`, plus the two Structural folders when Structural is loaded.
2. **Fix:** add the Manager folder to `LogFoldersToOpen`. This is Manager only, with no CE_SHARED change.

### 13. #1537 (pipe material), #1539 (FB-01 helper), #1550 (FB-06 helper) and #1551 (move-pit grade helper). **Both say HOLD. I agree.**

1. **#1537:** a bug fix that starts OFF. It must start ON.
2. **#1539, #1550 and #1551:** helpers with no caller. #1551's notes still plan an OFF switch, which must be ON.

### 14. #1541, #1542, #1543 and #1544 (notes-only routing PRs). **Codex is right on the facts; my verdict is HOLD, not REJECT.**

1. **The facts.** Each diff says "BLOCKED / documentation only / no fix". I checked the added lines, so Opus's "misleading fix claim" reason is wrong.
2. **What to do.** They still must not be merged into a release (they only add log entries). Keep them as drafts for the protected-file owner, under Tim's no-close ruling.

### 15. #1547, Structural outcome lines. **Codex is right (G03 F3, LOW to MEDIUM). MERGE-WITH-FIXES, Structural train (not C-63).**

1. **The fault.** Line 455 marks "completed" only when not repairing or when something was repaired. A Repair run that finds every hatch already correct is logged as "cancelled".
2. **Fix:** mark completed when the scan finishes in Repair mode with nothing to repair. Codex's two related "refused, not cancelled" exits should be fixed in the same pass.

### 16. #1553, Blue Factor garden and lawn. **Codex is right on both (G03 F1 and F2). Already installed in 3.0.72.**

1. **F2, MEDIUM. I confirmed it.** Only the "listed is less than the site" case gets a note. Roof 800 plus garden 500 on a 1000 m2 site now produces no warning. CE offers 800 m2 roof/paved and only 200 m2 of soft area, and hides a likely overlap or typing error.
   - **Fix:** also warn when listed is more than the site. Warn, don't block.
2. **F1, LOW. I confirmed it.** A newest report listing only garden and lawn, with an unreadable score, fails `HasAnything` and is skipped, so an older report can be offered instead. That is rare, since nearly every site has a roof.
   - **Fix:** count the pervious rows as "something read".

### 17. #1617, CDRUNSOLVE "nothing to solve" message. **Codex's heading fault is the same as item 8 (inherited from C-61). Already installed in 3.0.72.**

1. The solver-message fix itself is fine. Nothing more is needed on this PR.

### 18. #1619, CDNEWDWG reads the chosen job folder. **Codex is right (G06 F4, LOW to MEDIUM). Already installed in 3.0.72.**

1. **The fault. I confirmed it.** `NewJobDrawingRecordSource.RecordFor` stores a failed read, such as a locked file or a OneDrive file still downloading, as a blank record for that folder and never tries again. REF NO can then come out blank.
2. **Fix:** use `JobRecordService.TryLoad` and keep only a successful read or a truly absent file. This is a Drainage-only change; `TryLoad` already exists in CE_SHARED.

### 19. #1625, CDCALC levels at or below RL 0.00. **Codex is right (G06 F3, LOW to MEDIUM). Already installed in 3.0.72.**

1. **The fault. I confirmed it.** `CoverLevelKnown = IsRecordedLevel(pit.CoverLevel)` treats an old trench grate's "0.000" placeholder as a real level. `PitData.KnownCoverLevelRl()` already knows it is not a real level.
2. **Fix (one line):** `CoverLevelKnown = pit.KnownCoverLevelRl().HasValue`. Add the TG-placeholder and real-zero pair of tests.

### 20. #1636, closing CDCALC with nothing changed leaves no Undo step. **Codex is partly right. My verdict is MERGE, C-63, with a separate carpark entry.**

1. **The fault is real.** Building the window calls `EnsureDrawingDataCurrent`. When the CE record is missing a pit or pipe that is in the drawing, that repair saves at once (`SaveProjectData(db, immediate: true)`), before the new gate.
2. **But it is not introduced by this PR.** It only happens when the record is already out of step, and many commands share that repair path. The PR correctly fixes the everyday case: open, look, Close, and no Undo step.
3. **What to do.** Merge it. Add a new carpark entry: "opening CDCALC on an out-of-step drawing still repairs and saves the record before the window shows". Codex's HIGH rating for this PR is overstated.

### 21. #1621, damaged prepared update. **Both say REJECT in favour of #1632. I agree.**

---

## What I did NOT check

1. **No build and no tests run.** Every finding is from reading the code at the PR heads. The broken Civil tests in item 3 were confirmed by searching the new script for the exact strings the tests expect. They were not run.
2. **Nothing opened in AutoCAD.** Nothing installed. The installed DLL version was not read; I took 3.0.72 from the brief and the branch tip `f7f7d551`.
3. **Unpushed newer commits.** For #1647 and #1649 I read only their file lists, not the code. For #1648 I read the code change of `dddd45a6`.
4. **Not re-checked from the group reports:** #1534's garbled-character repair, the window fit for #1526 and #1531, and the PRs Codex passed with no new fault (#1502, #1520, #1524, #1526, #1527, #1530, #1533, #1536, #1538, #1540, #1545, #1546, #1548, #1549, #1552, #1613, #1623, #1635, #1645).
5. **Batch 01 to 04 PRs other than the four Manager ones:** #1646, #1650 and #1653 were not reviewed here.
6. **Whether Manager shows the install record's warning to the drafter** (relevant to #1648) was not traced.
