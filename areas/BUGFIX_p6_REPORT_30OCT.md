# BUGFIX p6 report, Fri 30 Oct 2026 (group S3, BUG-495 Publish Issue)

## ANSWER FIRST

1. **PR number: none opened, on purpose.** On the C-78 line (origin/claude/rel-20261102a, head 91963bd0) the fault in BUG-495 is already gone from the code, and tests already pin the exact case Tim would try. A change would have been invented work. No B number exists for BUG-495 in the build register, so nothing to rename either.
2. **Mistakes of my own:** none that cost anything. I started a waiting loop to check build slots, then stopped it myself and used one script that waits and runs. I did not push a branch (no commits).
3. **NOT proven:** nobody has driven Publish Issue in AutoCAD on a build from this line. The unit tests prove the sheet list and the saved revisions, not what the window looks like. The window needs a Codex look.
4. **Robot case that would prove it (name it for CE 02):** `S31_issue_unticked_keeps_rev`. See the robot section at the end.

## FOR TIM

1. **What the bug was:** Publish Issue gave the new revision and today's date to every Structural sheet, even sheets you had unticked. A 10-sheet set with 2 changed sheets came out as ten at revision C.
2. **What I found:** the Sheets screen was rebuilt on 10 Sep 2026 (the "reviewed Issue" work). On the newest line it does this instead: only sheets ticked "include in issue" and set as managed are listed; you pick the revision per discipline; a review window shows every sheet and its new revision before anything plots; and Back or Cancel changes nothing in the sheet list.
3. **Why the carpark entry still says OPEN:** the bug hunt on 9 Oct read an older build (Structural 1.0.110, commit 9babe787). That commit does not contain the rebuilt Issue code, so the old fault was real there. The C-78 line does contain it.
4. **What you will see differently on C-78 (if it matches the code):** untick sheet 3 of a three-sheet set at revision B. Publish Issue, Structural, revision C. Sheets 1 and 2 go to C with the issue date. Sheet 3 stays at B with its old date.
5. **Still wrong, not fixed here:** the Publish Issue window still refuses a blank revision. Your 28 Sep ruling on issue with no sheet ticked and a blank revision was "Allow". Allowing it means changing the issue pipeline (folder name, history, review), so it is a separate item that needs your wording of what should plot when nothing is ticked. I have not built it.
6. **What needs a look:** the Sheets window and the review window are windows, so a Codex look in AutoCAD is needed before this counts as accepted. Nothing is accepted yet.
7. **What to do next:** nothing from you. CE 05 can note that BUG-495 is already fixed in code on C-78, awaiting a robot and Codex pass. It must not be marked FIXED yet.

---

## TECHNICAL DETAIL

### Cause and where it went

1. The HUNT2 evidence lines (CeSheetsWindow.xaml.cs 263-273 writing the revision to every Structural sheet; CeSheetsIssueService.cs 24-32 and 86-109 dating every sheet; CeSheetsManagerWindow.xaml.cs 1191-1196) do not exist on C-78. `CeSheetsManagerWindow.xaml.cs` is now 34 lines and hosts `CeProjectSheetsWorkspaceView`.
2. Commit 50572182 (10 Sep 2026, "Integrate shared reviewed Issue workflow and durable history") is an ancestor of HEAD 91963bd0 (checked with `git merge-base --is-ancestor`, rc 0). It is not an ancestor of 9babe787 (rc 1), the commit the hunt read.
3. Current path, confirmed by reading:
   1. `CeSheetsIssueWorkflow.AvailableDisciplines` (CeSheetsIssueCompletionPresentation.cs 306-318) lists only sheets with `IsManaged && IncludeInIssue`.
   2. `SelectExactIssueSheets` (319-332) takes the same ticked set, per chosen discipline.
   3. `PrepareCore` (357-) builds the review and per-sheet `DesiredRevisions` (762-773) for the selected sheets only.
   4. `ApplyDesiredRevisions` (CeSheetsIssueCoordinator.cs 1226-1268) refuses a mismatch between the draft sheets and the revision map.
   5. `ApplyIssueHistory` (CeSheetsIssueService.cs 232-260) writes revision and date only to the sheets in the frozen issue.
   6. `CeSheetsWindow.BtnPublish_Click` (391-) shows `CeIssuePublishDialog` then `CeSheetsIssueReviewDialog` before `IssueAsync`; Back loops, Cancel returns.
   7. The old `ApplyDisciplineRevision` and `DisciplineRev_LostFocus` writers are gone from CeSheetsWindow; the revision boxes are read-only summaries (CeSheetsWindow.xaml.cs 239-246).
4. The old settings switch `IssuePreviewEnabled` and `CeIssuePreviewBuilder.cs` no longer exist (grep over Modules: no match; the file is absent). The review is not behind a switch on this line, so no new switch was needed.

### Existing tests that already pin the carpark case

1. `CeSheetsIssueHistoryCommitTests` (about line 99-102): after issuing sheet c1 at C, the unticked c2 stays at A with IssueDate "untouched", and s1 stays B.
2. `CombinedPack_PersistsExactPerSheetRevisionsWithoutChangingUntickedRows` (same file, 158-206): c2 stays Z and "untouched".
3. `CeSheetsIssueCompletionPresentationTests`: `IssueSelectionUsesManagedTickedIntersectionAndIgnoresVisualSelection`, `AvailableDisciplinesUsesOnlyRowsEligibleForIssue`, `PublishCannotTriggerLegacyBroadDisciplineRevisionLostFocusWriter` (the old writer method is absent), and the review tests that say preparing the review does not edit the draft.
4. `CeSheetsIssueDraftTests.DraftUsesOnlySelectedManagedIncludedSheetsAndPreservesAllSnapshotFields`.

### What I ran

1. Focused net10 run, below normal priority, one slot free: `dotnet test Modules\Structural.Tests\CE_STRUC_SUITE.Tests.csproj -f net10.0-windows --filter` on CeSheetsIssueHistoryCommitTests, CeSheetsIssueCompletionPresentationTests and CeSheetsIssueDraftTests, with `-p:SkipDevBundle=true -nr:false --disable-build-servers` and the AutoCAD refs. Result: **Passed 21, Failed 0, Skipped 0, Total 21** (count is not 0). AutoCAD 2027 was on PATH. Log: C:\ce-scratch\p6\focus.log.
2. Isolation: CE_STRUC_SUITE_APPDATA_ROOT=C:\ce-scratch\p6\struc, CE_LOG_DIR_OVERRIDE=C:\ce-scratch\p6\logs, TEMP=C:\ce-scratch\p6\tmp were set and echoed in the log's first line. I did not run Manager tests or the full Structural suite. Those three test classes use their own temp project folders; I read the History and Presentation tests' set-up (temp root per test) but not every line of every test class.
3. Settings files, names, sizes and last-write, listed BEFORE the run and AFTER it, identical:
   1. `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` 35613 bytes, 2026-10-30 19:54:14 (both listings)
   2. `%APPDATA%\CE_CVL_SUITE\settings.json` 672 bytes, 2026-09-16 12:13:17 (both listings)
   3. `%APPDATA%\CE_SUITE`: no settings file found (both listings)
   No real settings file changed.
4. net48 compile and the full Structural suite were not run: nothing was changed in the repo, so there is nothing new to compile or test.
5. Worktree C:\ce-fx\p6 (branch fb/bug495-publish-issue-ticked, no commits, equal to origin/claude/rel-20261102a) had bin/obj cleaned with `git clean -fdXq`. The branch and worktree are left in place (nothing deleted).

### What is not proven

1. Whether the installed Structural 1.0.125 contains commit 50572182. I did not read the installed DLL (not my job and not needed here). CE 01 should check that before anyone expects the fix in Tim's AutoCAD. If the installed line is the 9babe787 family, Tim still has the old fault until a train with C-78 code is installed.
2. The review window layout and the real PDFs. Unit tests never prove a window (RULES 5.7).
3. Combined mode with two disciplines at different revisions is pinned by tests, but not seen in AutoCAD.

### Remaining part of the carpark entry, not built

1. `CeIssuePublishDialog.xaml.cs` 130-133 and 162-163 refuse any ticked discipline with a blank revision, and `CeSheetsIssueService.CreateIssueDraft` (316-317) and `PrepareCore` (379-381) throw or flag "Issue revision is required". INT-059 item 22 (28 Sep holiday run answer) says "Allow (Recommended)" for an issue with no sheet ticked and a blank new revision. It touches the folder name, history record and review, so it is not a small change. Suggest CE 04 ask Tim what should plot and what the folder is called. This is a window, so it needs a Codex look after any change.

### Robot case (for CE 02), switch-off control

1. **Name:** `S31_issue_unticked_keeps_rev` (control: `S31x_issue_all_ticked`).
2. **Set-up:** a copy of a job with three Structural sheets at revision B, issue date 01/09/2026, all managed, on the C-78 line (or any build containing 50572182).
3. **Steps typed:** CESHEETS; untick "include in issue" on sheet 3; Publish Issue; tick Structural, revision `C`, date `30/10/2026`; Publish; accept the review window; wait for the result window.
4. **What it checks:** the sheet list (or the saved sheet manifest) shows sheets 1 and 2 at C dated 30/10/2026 and sheet 3 at B dated 01/09/2026; the issue folder PDF holds 2 pages, not 3.
5. **Control (the "switch off" twin):** there is no switch for this behaviour on C-78, so the control is the same job with all three sheets ticked; it must show all three at C. A red result on the main case with the control green would mean the ticks are being ignored again.
6. **Do not publish a real job** (Codex coverage note of 14 Oct): use the copy only.
7. **Needs:** a Codex look for the windows (sheet list, review window); the numbers can be read by the robot.

### For CE 05 (record, do not mark FIXED)

1. BUG-495: cause as filed was real on 9babe787; absent on C-78. Status suggestion: "already fixed in code on C-78 line by commit 50572182, awaiting robot case S31 and a Codex look; not FIXED". Residual: blank revision refusal vs INT-059 item 22 as a new item.
2. No PR. No B number was in the register for BUG-495.
