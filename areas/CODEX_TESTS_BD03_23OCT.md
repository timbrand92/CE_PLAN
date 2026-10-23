# CODEX TESTS BD03 — Manager regression tests — 23 October 2026 (Melbourne)

## ANSWER FIRST

1. **Status:** validation in progress. Nine new cases in `Modules/Manager.Tests/Services/Bd03ManagerRegressionTests.cs`; focused run 9 passed, 0 failed, 0 skipped. No product source changed.
2. **Tests per bug:** BUG-425: 1; BUG-832: 1; BUG-835: 1; BUG-842: 1; BUG-848: 2; BUG-1028: 3. These cover missing branches of fixes with existing basic tests, rather than claiming those bugs had no tests at all.
3. **Branch and base:** `cx3/tests-bd03`, private worktree `C:\ce-cx\bd03`, from fetched `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Draft PR [#1703](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1703), current head `1fcf5b5b6a442cccb2f9fa344c3ee4f9a92e8fea`; final verification pending.
4. **Totals:** focused Manager 9/9. Full Manager corrected run: 941 total, 940 passed, 1 existing skipped case, 0 failures. Civil/build validation and the final added approval-log assertion rerun pending. The first full Manager invocation put the log override beside TEMP, causing existing containment guards to fail; this is a runner setup error and will be rerun with the override beneath TEMP.
5. **New findings:** none established by the new cases so far. No bug status changed.
6. **What a drafter sees:** no change: this branch adds tests only. For example, it checks that a locked Civil approval does not hide another tool's approval.
7. **Not run:** AutoCAD, accoreconsole, installer tests, deployment, window rendering. No window was changed; no screenshots are claimed. No installation or acceptance claimed.

## Coverage audit and evidence

1. **BUG-425, approval folder:** existing `CeDamagedOfficeFileReadTests` covers malformed approval JSON and damaged admin lists, but no approval scan with a file held open. Added locked-file scan and same-session recovery, with original bytes checked.
2. **BUG-832, update route:** `CePairedApprovalTests` covers a failed Civil/Manager pair. Added Manager-first input with an independent Structural descriptor: Civil failure blocks Manager while the independent update still stages. Only injected callbacks execute; no Structural source or installed bundle is used.
3. **BUG-835, approval rollback:** `CeVersionTextAndRollbackSourceTests` checks version, folder, manifest, content hash and commit; it does not assert the record/signature/summary/signer hashes or release profile. Added distinct current/earlier sentinels for all five fields.
4. **BUG-842, settings:** existing fixture covers a locked read, malformed input, blank paths and a normal save. Added destination locked only AFTER a successful read: failed replacement preserves bytes and leaves no temporary settings copy. Direct execution of the actual parent writer (`5d0cfe9a^`) in an isolated PowerShell compilation produced IOException and two files (original plus `.tmp`), where this case requires only the original. This proves the missing cleanup assertion fails before the fix; it is not a full parent-commit NUnit run.
5. **BUG-848, waiting reports:** the existing upload fixture tests lower-case `.tmp`/`.bak` beside a completed report. Added upper-case TMP and BAK as the ONLY, exclusively held files in a failures outbox: nothing is copied, nothing is deleted, no office directory is created and the result is successful with zero uploads.
6. **BUG-1028, settings and ribbon loader logs:** `C60ManagerSupportTests` already checks one failing tab, one broken switch file and defaults. Added two distinct failed tabs (both logged, one ribbon notice), a failing command-line notice retried without duplicate log lines, and independent switch/ribbon warning families.

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

## Safety and handoff

1. **Disk:** initial C: free 13.71 GB; after checkout 13.60 GB. Stop threshold 12 GB, checked before each build/test step. No unrelated worktree was removed.
2. **Isolation:** no shared checkout files taken over; other chats' unsaved work left alone. Stage by filename only. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md are not edited.
3. **Undo:** revert this branch's test/log commit; no installed file or drafter setting needs restoring.