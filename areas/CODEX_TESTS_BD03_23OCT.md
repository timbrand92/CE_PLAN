# CODEX TESTS BD03 — Manager regression tests — 23 October 2026 (Melbourne)

## ANSWER FIRST

1. **Status:** validation in progress. Nine new cases in `Modules/Manager.Tests/Services/Bd03ManagerRegressionTests.cs`; focused run 9 passed, 0 failed, 0 skipped. No product source changed.
2. **Tests per bug:** BUG-425: 1; BUG-832: 1; BUG-835: 1; BUG-842: 1; BUG-848: 2; BUG-1028: 3. These cover missing branches of fixes with existing basic tests, rather than claiming those bugs had no tests at all.
3. **Branch and base:** `cx3/tests-bd03`, private worktree `C:\ce-cx\bd03`, from fetched `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Draft PR [#1703](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1703), current head `1fcf5b5b6a442cccb2f9fa344c3ee4f9a92e8fea`; final verification pending.
4. **Totals:** focused Manager 9/9. Full Manager corrected run: 941 total, 940 passed, 1 existing skipped case, 0 failures. Final Manager rerun (including the added approval-log assertion): again 941 total, 940 passed, 1 skipped, 0 failed; all 9 BD03 cases passed. All six Manager/Civil module builds passed with zero errors; Civil full suite is running. The first full Manager invocation put the log override beside TEMP, causing existing containment guards to fail; this is a runner setup error and will be rerun with the override beneath TEMP.
5. **New findings:** none established by the new cases so far. No bug status changed.
6. **What a drafter sees:** no change: this branch adds tests only. For example, it checks that a locked Civil approval does not hide another tool's approval.
7. **Not run:** AutoCAD, accoreconsole, installer tests, deployment, full net48/net8 test suites, or a dedicated BD03 visual inspection. The full Civil suite includes existing off-screen render fixtures; no new window or screenshot deliverable is claimed. No installation or acceptance claimed.

## Coverage audit and evidence

1. **BUG-425, approval folder:** existing `CeDamagedOfficeFileReadTests` covers malformed approval JSON and damaged admin lists, but no approval scan with a file held open. Added locked-file scan and same-session recovery, with original bytes checked.
2. **BUG-832, update route:** `CePairedApprovalTests` covers a failed Civil/Manager pair. Added Manager-first input with an independent Structural descriptor: Civil failure blocks Manager while the independent update still stages. Only injected callbacks execute; no Structural source or installed bundle is used.
3. **BUG-835, approval rollback:** `CeVersionTextAndRollbackSourceTests` checks version, folder, manifest, content hash and commit; it does not assert the record/signature/summary/signer hashes or release profile. Added distinct current/earlier sentinels for all five fields.
4. **BUG-842, settings:** existing fixture covers a locked read, malformed input, blank paths and a normal save. Added destination locked only AFTER a successful read: failed replacement preserves bytes and leaves no temporary settings copy. Direct execution of the actual parent writer (`5d0cfe9a^`) in an isolated PowerShell compilation produced IOException and two files (original plus `.tmp`), where this case requires only the original. This proves the missing cleanup assertion fails before the fix; it is not a full parent-commit NUnit run.
5. **BUG-848, waiting reports:** the existing upload fixture tests lower-case `.tmp`/`.bak` beside a completed report. Added upper-case TMP and BAK as the ONLY, exclusively held files in a failures outbox: nothing is copied, nothing is deleted, no office directory is created and the result is successful with zero uploads.
6. **BUG-1028, settings and ribbon loader logs:** `C60ManagerSupportTests` already checks one failing tab, one broken switch file and defaults. Added two distinct failed tabs (both logged, one ribbon notice), a failing command-line notice retried without duplicate log lines, and independent switch/ribbon warning families.

7. **Already covered, not duplicated:** BUG-836/BUG-837 numeric version handling (CeVersionTextAndRollbackSourceTests); BUG-838 read-only stage cleanup (CeUpdateStagingServiceTests.ReadOnlySource); BUG-850 contributor-tab refresh (CeStatusRefreshLeavesContributorTabsTests); BUG-851 disable-on-restart manifests (CeDisableOnRestartMainOnlyTests); BUG-1026 log-folder selection and BUG-1027 real support evidence (C60ManagerSupportTests). Search included behaviour names as well as BUG labels. Installer-only BUG-823/BUG-824/BUG-834 cases already exist and were not executed.

## Before-fix reasoning

1. **BUG-425:** `47804bde` adds a per-file catch inside approval discovery. Its parent catches outside the loop, so the first locked file stops discovery before the next good approval. The explicit-folder overload also did not exist in the parent.
2. **BUG-832:** `d79f8f10` adds `civilStageFailed` and skips Manager when Civil's stage fails. Its parent ignores the failed result and calls all three stage callbacks; the new expected two-call set fails.
3. **BUG-835:** `49c930c6` adds `RollbackSourceFor` and maps earlier signed fields. Its parent copies the current approval's fields instead, destroying the earlier signed identity. The new helper call is compile-red against the parent as written; diff reasoning establishes the wrong earlier fields.
4. **BUG-842:** `5d0cfe9a` replaces delete/move with replacement plus finally cleanup. Parent behaviour demonstrated directly as above.
5. **BUG-848:** `7eaa55db` adds case-insensitive extension filtering before copy. Its parent tries to copy the held file, returns false and creates the destination directory; both new cases fail.
6. **BUG-1028:** `a1b0ddf8` adds `CeManagerSupportWarnings`; its parent only uses TraceError for ribbon failures and silently defaults switch readers. The three new cases are compile-red against that parent because the warning service is absent; no runtime parent pass is claimed.

## Real AutoCAD check (not run; future tester, disposable profile and copies only)

1. **Approvals/update route:** point a disposable profile at a synthetic office folder with a newer Civil/Manager pair. Hold Civil's approval file: CEMANAGER must still show other valid approvals. Release it and Refresh: Civil returns. Force Civil staging to fail: Manager must stay on its earlier version; an unrelated eligible tool may still prepare. Do not activate or install stages.
2. **Settings and rollback:** on a disposable profile, hold the CE Blocks settings file after it has loaded, attempt a save, then release it: original settings survive and no `.tmp` remains. Reapprove one signed test release: its earlier rollback identity remains intact. Keep Show Roll Back OFF.
3. **Logs and loader:** use a test build/contributor that fails two ribbon tabs: each reason is in the redirected Manager log, with one plain ribbon notice. A broken synthetic manager-switches.json also gets its own notice and is left unchanged. Other tabs and typed commands remain available. No fault injection or settings change on Tim's live profile.
4. **Waiting reports:** put only unfinished synthetic .TMP/.BAK files in the disposable profile's outbox and click Send waiting reports: zero reports sent; files remain on that PC. A real OneDrive race remains unproven.

## Completed build evidence

1. **Release, net48:** Manager 0 errors / 0 warnings; Civil 0 errors / 242 warnings.
2. **Release, net8.0-windows:** Manager 0 errors / 0 warnings; Civil 0 errors / 210 warnings.
3. **Release, net10.0-windows:** Manager 0 errors / 0 warnings; Civil 0 errors / 208 warnings.
4. **Every invocation:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`; `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10` and `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref` (2027 reference set, as C-57 report). AutoCAD 2027 directory on PATH for DLL resolution only. Builds/tests stayed in the foreground.
5. **Native limitation:** managed Civil compilation used the C-57 report's zero-byte `CE_TRANSFORM_2027.arx` placeholder, inside this worktree's ignored build input folder. The native transform module was not built or executed. No product source was changed for compilation.
6. **Evidence:** local only `C:\ce-cx\bd03-evidence`; build logs named `CE_SUITE_MANAGER-<tfm>.log` / `CE_CVL_SUITE-<tfm>.log`; final Manager results `manager-final.trx` / `manager-final.log`. Test redirects sit beneath this run's TEMP folder.

## Exact native follow-up setup (future robot session only; not performed by BD03)

1. **Use a disposable Windows account/VM with synthetic drawings and approved test packages.** Do not change Tim's profile. Use the same code head named in this report, with controlled signed test releases newer than the running pair. No installation was done in this job.
2. **Office folder:** for that future AutoCAD process set `OneDriveCommercial=C:\ce-bd03-real\Office`; put only synthetic approval/release fixtures beneath `C:\ce-bd03-real\Office\Creative Engineering - IT Admin\releases`. Leave `CE_LOG_DIR_OVERRIDE` unset in AutoCAD; it must not move AutoCAD's real settings into a test folder.
3. **Approval check:** hold `releases\CE_CVL_SUITE\approved.json` open with FileShare.None; type CEMANAGER and click Refresh. Manager's other valid approval remains visible; the Manager log names the skipped Civil approval. Release the handle and click Refresh: Civil's offer returns. Nothing is activated.
4. **Switch/loader check:** in that disposable account only, put `{"oneGlanceStatus":true,}` in `%APPDATA%\CE_SUITE\manager-switches.json`, then start AutoCAD in the separate robot session. Expect one plain notice that normal defaults are in use and a persistent reason in `%APPDATA%\CE_CADTOOLS\CE_Admin\logs\manager-trace.log`; the malformed file must remain byte-for-byte unchanged. Two failing ribbon-contributor checks additionally need a controlled fault-injection fixture, which this tests-only branch does not ship; no native proof is claimed for them.

## Safety and handoff

1. **Disk:** initial C: free 13.71 GB; after checkout 13.60 GB. Stop threshold 12 GB, checked before each build/test step. No unrelated worktree was removed.
2. **Isolation:** no shared checkout files taken over; other chats' unsaved work left alone. Stage by filename only. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md are not edited.
3. **Undo:** revert this branch's test/log commit; no installed file or drafter setting needs restoring.