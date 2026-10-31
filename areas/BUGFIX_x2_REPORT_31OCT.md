# BUGFIX x2 report, Sat 31 Oct 2026 (B-101, BUG-1262, Publish Issue with nothing ticked, Structural)

## ANSWER FIRST

1. **PR number: #1929** (draft, base claude/rel-20261026s, branch claude/b101-publish-issue-nothing-ticked). Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **Mistakes of my own:** (a) my first test run failed because the test project needs the Structural project restored with the "hosted" flag first; one extra restore fixed it, no harm. (b) My first edit script used a relative path that .NET resolved against the wrong folder; it stopped on a guard before writing anything, and I checked the desk worktree afterwards (clean). (c) Two `sed` edits of my own helper script ate backslashes; I fixed them. None touched Tim's files.
3. **NOT proven:** the Publish Issue window and the warning box have not been looked at in AutoCAD. The "no sheets" row in the Sheets Manager issue-history list has not been seen. The Sheets Manager "Create Issue" path was changed by reading the code only (no test drives that window).
4. **Robot case:** `S32_issue_nothing_ticked_records` with control `S32_issue_nothing_ticked_switch_off` (details at the end).

## FOR TIM

1. **What you will see differently:** in CESHEETS, click Publish Issue PDF with no sheet ticked "include in issue" (or untick every discipline in the Publish Issue window). Before, it refused: a "No managed, included-in-issue sheets to publish" message, or a greyed Publish button reading "Tick at least one discipline". Now the Publish button works. The preview line says: nothing is ticked, Publish will plot nothing, change no revision and record "no sheets" in the issue history.
2. **What happens when you press it:** one warning box ("Nothing is ticked, so nothing was plotted and no sheet revision or date was changed. The issue is recorded in the issue history as "no sheets"."). No PDF is made, no issue folder is made, every sheet keeps its revision and date, and the issue history in the Sheets Manager gets one new row reading "no sheets" with the date. The same happens from Create Issue in the Sheets Manager with nothing ticked.
3. **What did not change:** tick a discipline and leave its revision blank, and it still asks for the revision. Sheets ticked with a revision publish exactly as before. The window layout is the same.
4. **The switch:** Settings, Sheets, `IssueWithNothingTickedWarnsAndRecords`, ships ON. Switched off, the old refusal returns exactly. It is not on the Settings page yet (the Issue choices there are open PR #1248, Codex-owned); for now it is a setting in the settings file.
5. **Does the installed line have the newer Issue look (commit 50572182)?** No. The start point (Structural 1.0.125, origin/claude/rel-20261026s, head 204dfad2) does NOT contain 50572182. It still has the older Publish Issue window, so the fix is on that window. If a later train brings in 50572182, the same fix has to be applied on the newer window (report p6 says the newer one still refuses a blank revision).
6. **Overlap to know about:** open draft PR #721 ("blank new revision allowed when no sheet is ticked") touches the same issue code with a similar idea. Nothing was merged or closed. Whoever assembles the next Structural train should look at #721 and #1929 together.
7. **What needs a look:** a Codex look in AutoCAD at the Publish Issue window with nothing ticked, the warning box, and the "no sheets" row in the history. Nothing here is accepted.
8. **C: space:** free space was 44.1 GB at the start and 44.0 GB at the end (low point 42.9 GB during the build). I removed my worktree and scratch folder before finishing. I finished at 17:29 on Sat 31 Oct 2026 (PC clock).

---

## TECHNICAL DETAIL

### Fault still existed on the start point
1. `CeIssuePublishDialog.BuildPreview` returned "Tick at least one discipline." with `canPublish = false` when no discipline was ticked, and "Enter a revision for each ticked discipline." for a ticked blank revision.
2. `CeSheetsWindow.BtnPublish_Click` showed "No managed, included-in-issue sheets to publish." and returned when no sheet was included.
3. `CeSheetsIssueService.CreateIssueCore` threw "Select at least one sheet for the issue pack."; `CeSheetsManagerWindow.BtnCreateIssue_Click` showed the same text.
4. 50572182 is not an ancestor of 204dfad2 (`git merge-base --is-ancestor`, rc 1).

### Entry point and the change
1. `CeSheetsIssueService.ClassifyTicks(tickedWithRevision, anyTickedBlank, nothingTickedAllowed)` is the one rule: NeedsRevision, Publish, NothingTickedRecordOnly, NothingTickedRefused. `RecordNoSheetsIssue` adds the history row (new field `CeIssueEntry.NoSheets`, written to the job file only when true; `IssueId` is "<date> no sheets"; no folder, no PDFs, no sheet touched; the caller saves the manifest). `HistoryRevisionText` gives "no sheets" for the list label.
2. Dialog: `BuildPreview` uses `ClassifyTicks`; `BtnPublish_Click` returns a `PublishChoice` with `NothingTicked = true`. Window: `BtnPublish_Click` (no included sheets) and `PublishFromChoiceAsync` (NothingTicked) call `RecordNothingTickedIssue` (record, save, status line, warning box). Manager: `BtnCreateIssue_Click`.
3. Side effects handled: the "latest issue" lookups for the date, revision and council boxes (`CeSheetsManagerWindow` around line 201) and for project title-block fields (`CeSheetsSyncService.ResolveProjectField`) skip a "no sheets" row; the issue-history diff never compares the next issue with one.
4. Switch `CeSheets.IssueWithNothingTickedWarnsAndRecords` (UserSettings.cs, documented "Default: on."). Switch OFF: `ClassifyTicks` gives NothingTickedRefused and the three old refusal texts return unchanged.

### Shared-file check (gh pr list --state open --search)
1. CeIssuePublishDialog: #1248 (Codex, Issue choices on Settings). CeSheetsWindow: #704, #781, #1248, #700. CeSheetsIssueService: #1018, #700, #743, #702, #704, #721, #1248. CeSheetsModels: #700. CeSheetsManagerWindow: #781, #700, #704, #721. CeSheetsSyncService: #1568, #397, #230. UserSettings: many (#1918, #1927, #1904 and others).
2. These are older drafts on the preview-based issue code, not the Structural #1898 to #1921 set. I read titles only, not their diffs. My edits are additions at new anchors (after the last Sheets setting, before `NormalizeIssueDateForDisplay`, inside the refusal branches). Clashes expected: #721 (same service, same intent) and #1248 (dialog and settings). #1918 and #1927 edit UserSettings.cs elsewhere; the new property near line 290 may need a keep-both-sides merge.

### Tests
1. `CeIssueNothingTickedTests` (15): decision with switch on and off; a blank revision still asks, whatever the switch; ticked-with-revision publishes unchanged; the recorded row has no sheets, PDFs or folder; every revision, date and tick unchanged; two same-day records both kept; an earlier real issue untouched; `CreateIssue` with no sheets still throws; an unreadable date still records; job-file round trip and omission when false; switch default ON through the normal and the value-by-value start-up reads; a typed off stays off and gives the old refusal.
2. Run: `dotnet test Modules\Structural.Tests\CE_STRUC_SUITE.Tests.csproj -f net10.0-windows --filter <class names> -p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`. Result 24 passed, 0 failed (the 15 new plus `CeIssueRevisionScopeTests` and `S45NewSwitchDefaultsTests`); the count is not zero. The isolation variables were printed before every run and pointed at C:\CE_WORK\scratch\x2.
3. net48: `dotnet build Modules\Structural\CE_STRUC_SUITE.csproj -f net48` with `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`. The C# compile succeeded (DLL written, no CS errors). The build then ended in the post-build "no CE_SHARED metadata" check, which could not launch `powershell` (exit 9009) from this shell. That is an environment gap, not a compile error; I did not re-run it elsewhere.
4. NOT run (job rules): the full Structural suite, any Manager or Civil suite.

### Real-files compare (names, sizes, last-write; no contents)
Listings were taken before the first test and after the last, of %APPDATA%\TIM_CE_CADTOOLS (including CE_Admin\outbox and logs), CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS (including CE_Admin) and CE_SUITE (CE_SUITE does not exist). Each listing is about 33,400 lines (AutoSave backups dominate), so they are not pasted: the complete difference is below, and the settings files are listed.

1. Settings files, identical before and after: `CS_Settings.json` 351713 bytes 2026-03-31 13:18:00; `CS_Settings.json` 35613 bytes 2026-10-30 19:54:14; `CS_Settings.json.PRE_TIM_YES_20261020.bak` 34858 bytes 2026-10-18 10:00:24.
2. The CE_STRUC_SUITE folder listing is identical before and after (no new or changed file).
3. Complete difference (every changed or new file):

```
CD_RecentValues.json            12221  17:21:08 -> 17:25:43      (TIM_CE_CADTOOLS)
CE_Admin\outbox\usage\2026-10-31\usage_20261031_062213_129_4410249a...json  387  17:22:13 new   (TIM_CE_CADTOOLS)
CE_Admin\outbox\usage\2026-10-31\usage_20261031_062406_921_ce9b2463...json  387  17:24:06 new
CE_Admin\outbox\usage\2026-10-31\usage_20261031_062442_149_05d3e942...json  391  17:24:42 new
CE_Admin\outbox\usage\2026-10-31\usage_20261031_062543_519_c49dc360...json  391  17:25:43 new
ledger\suggestions.jsonl        3587036 -> 3587967  17:21:08 -> 17:25:43   (CE_CVL_SUITE)
logs\ce_cvl_structured_20261031.log  10111144 -> 10134039  17:21:10 -> 17:25:47   (CE_CVL_SUITE)
CE_Admin\sessions\CE_SUITE_MANAGER.json  228  17:20:53 -> 17:25:53   (CE_CADTOOLS)
```

4. **Why I say these are not mine:** acad.exe (process 59680, Tim's live AutoCAD) was running throughout; `CE_SUITE_MANAGER.json` names processId 59680 and is its heartbeat; the log tail shows Civil PERF-SUMMARY lines from that session. All are Civil or Manager files, and my Structural tests with isolation write nothing there. But the usage files do fall in the same minutes as my three test and build runs (17:22 to 17:25), so I cannot prove from names alone that none came from my process. To settle it: CE 05 can check whether those four usage files name a Structural command.

### Robot case for CE 02 (S32 style)
1. **`S32_issue_nothing_ticked_records`:** on a Structural project copy with at least three managed sheets at known revisions, untick "include in issue" on every sheet, run CESHEETS, click Publish Issue PDF. Checks: the warning box text starts "Nothing is ticked, so nothing was plotted"; no new folder under the project's issue PDF folder and no PDF; every sheet's revision and issue date in the Sheets list equal the values before; the manifest gains exactly one issue, shown as "no sheets" in the Sheets Manager Issue History list.
2. **Control `S32_issue_nothing_ticked_switch_off`:** set `CeSheets.IssueWithNothingTickedWarnsAndRecords` to false in the copy's settings and repeat: the message reads "No managed, included-in-issue sheets to publish." and the issue history gains no row.
3. **Also check with sheets ticked:** tick two sheets, enter revision D, Publish: they go to D with today's date, the third stays as it was, and no "no sheets" row is added.
