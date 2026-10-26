1. **ANSWER FIRST — BUG-1143: build in progress.** PR not opened yet. Branch `cx4/bug-1143-design-draft-backup`, own worktree `C:\ce-cx\bd10`. Starting branch head and fetched release base head: `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. The brief's recorded head matched the actual fetch. No other bug is in scope.

2. **Baseline completed before editing.** Release net10 console result: `Failed: 2, Passed: 20346, Skipped: 32, Total: 20380, Duration: 22 m 8 s`. The TRX counters additionally list 28 unexecuted entries: total 20408, executed 20348, passed 20346, failed 2. Actual failures:
   1. `CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile`: `Queued diagnostic never reached the log file. Expected: True; But was: False.`
   2. `CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`: PDF renderer produced only blank pages. The suite also reported a test-fixture cleanup error: `CE_CVL_SUITE.log` was still in use. These are untouched-base observations, not claims about the completed change.

3. **Red proved with a compiling stub.** Only the three requested test names (four cases) and a pure method returning false were added first. Filter: `FullyQualifiedName~Bug1143`. Result: `Failed: 3, Passed: 1, Skipped: 0, Total: 4`.

```text
Failed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(False)
An unreadable draft must be kept under a backup key before Save Draft.
Expected: True
But was: False

Failed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(True)
An unreadable draft must be kept under a backup key before Save Draft.
Expected: True
But was: False

Failed CivilProjectStartDraftStorage_Bug1143_ExistingBackup_IsNeverOverwritten
Expected: String containing "earlier backup" and containing "not been replaced"
But was: <string.Empty>
```

4. **Current work.** The real backup decision and drawing-side save are written. The default-on setting is `linking.designKeepsUnreadableDraftBackup`. The Settings row uses the existing load, save, reset, search and change markers. Added checks cover the switch, old settings, saved off, no data, binary contents, all three save callers and off-screen dark/light Settings renders. The green run is still compiling; three-lane builds and the final full suite remain to run. No passing result is claimed yet.

5. **What the drafter should see once verified and installed.** If a Design draft in a drawing is damaged, CDDESIGN still starts a blank draft. Save Draft or Confirm setup first keeps the old draft in the drawing as a backup and prints: `[CE] The old Design draft could not be read. It has been kept in this drawing as a backup; the CE administrator can recover it.` An earlier backup is never replaced; a separate plain line says it was retained.

6. **Real AutoCAD check still required, not run here.** Use a COPY of a synthetic drawing. A fixture creates `CE_CVL_DESIGN_START_DRAFT` as an Xrecord with Text `{bad draft json`, with no backup present; capture its exact TypedValue contents. Open CDDESIGN and press Save Draft. Check the backup key `CE_CVL_DESIGN_START_DRAFT_UNREADABLE_BACKUP` holds exactly the original contents, the main draft can be read, and the CE line in item 5 appears in the command history and CE log. Repeat with Confirm setup, readable data, an existing distinct backup, no data and a wrong-type record. Check the earlier backup stays unchanged. Use U then REDO and confirm no backup write happens between them. Repeat on AutoCAD 2024 and 2027 after the release owner installs a reviewed build.

7. **Safety.** No AutoCAD session, real damaged drawing, installation or deployment was run. The backup is in the drawing's named-objects dictionary and touches no drawing entity; locked layers, Xrefs and REFEDIT protection are not involved. CE_SHARED and every protected source file remain untouched. Tests use explicit in-memory switches or the suite's synthetic settings copies, never Tim's settings. All .NET builds/tests use SkipDevBundle, no node reuse, disabled build servers, absolute project paths and the brief's reference paths. AutoCAD's library folder is added only to the test process's PATH.

8. **Fresh-worktree prerequisites.** The first baseline attempt stopped at a missing native transform build file. The main checkout's file was empty, so the existing native project was built inside this worktree with ProductionIntegration=true and SkipDevBundle=true; no native source was edited. A subsequent discovery attempt reported no tests until the AutoCAD library folder was on PATH; that zero-test attempt was rejected. Only the complete 20380-test run above is the baseline.

9. **Resume record, 26 October 2026, Melbourne time.** Green test process tool session 34710; log `C:\ce-cx\bd10-green.log`. Evidence folder `C:\ce-cx\bd10-evidence`, with base/red TRX files. Native prerequisite log `C:\ce-cx\bd10-native.log`. Source edits are still uncommitted in the own worktree; do not touch another chat's files. Next: finish green, inspect and commit the Settings pictures, build Civil net48/net8/net10 safely, run the full net10 suite, compare failure names, prepend REGRESSION_LOG.md, fetch/merge the release base if moved, commit/push by name, open a draft PR against `claude/rel-20261025r`, replace this progress report with final evidence, push this file alone, then remove only `C:\ce-cx\bd10`. Do not edit the bug register, desk log or queue.
10. **Progress at 20:17 Melbourne, 26 October 2026; supersedes the pending green and uncommitted-source notes above.** Code and the 16 inspected Settings pictures are committed at `fbd79ec95f5f4c694548a67c3f628f9e65c4db07`. The final row fits at 670 px in both themes. Green: 13 passed, 0 failed. The requested passing lines are:

```text
Passed CivilProjectStartDraftStorage_Bug1143_ExistingBackup_IsNeverOverwritten
Passed CivilProjectStartDraftStorage_Bug1143_ReadableExistingDraft_MakesNoBackup
Passed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(False)
Passed CivilProjectStartDraftStorage_Bug1143_UnreadableExistingDraft_IsKeptUnderABackupKeyBeforeSave(True)
Test Run Successful. Total tests: 13. Passed: 13.
```

11. **Current continuation.** Three sequential safe Release builds are running in tool session 37738, logs `C:\ce-cx\bd10-build-net48.log`, `C:\ce-cx\bd10-build-net8.0-windows.log`, `C:\ce-cx\bd10-build-net10.0-windows.log`. No source edits while testing. After the builds, run the full Civil net10 suite with a build/copy step (the source XAML row placement changed after the first compiled green attempt; the off-screen green test reads the final source XAML directly). Compare actual failure names against the baseline in item 2. REGRESSION_LOG.md has the BUG-1143 entry at the top, with final validation still pending. Update that entry after the full result; then fetch/merge the release base if moved, push the branch, open the draft PR, replace this progress report with the final report, push it by name and remove only this session's worktree. Picture paths are the existing 16 `docs/image/V3_WINDOWS/settings-{dark,light}-*.png` files; every one has been viewed.