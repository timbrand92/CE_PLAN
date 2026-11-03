# BUGFIX w1045 report: BUG-1045 Civil half (3 Nov 2026, B-189)

## FOR TIM

1. **What you will see:** open a drawing read-only and type CDDIAG, CDDASHBOARD or CDPARTS. They now run instead of saying "cannot run - drawing is read-only".
2. **CDDIAG and CDDASHBOARD on a read-only drawing:** they show the pit and pipe record already saved in the drawing, with one line saying so. They do not re-check it against the drawing, because that step writes into the drawing. A drawing that never had a record saved shows zero pits and pipes.
3. **CDPARTS:** opens the office catalogue. The CDPIT350 to CDPIT1200 placing commands still refuse a read-only drawing.
4. **Switch:** `linking.inspectRunsOnReadOnlyDrawing`, on by default. Off brings back the old refusal exactly.
5. **My mistakes:** two test runs failed before running any test (dotnet not on the tool PATH, then a space in the AutoCAD 2027 path). No cost beyond a few minutes. The "after" listing of your real settings and log folders differs from the "before" listing; see detail item 4. I believe it is your other AutoCAD session closing, not my run.
6. **Built, tested, installed, accepted:** built (net48 and net10) and unit-tested (6 of 6). Not installed. Nobody has opened it in AutoCAD. BUG-1045 is not fixed until that is done.
7. **NOT proven:** that the dashboard's analysis really writes nothing on a read-only drawing (I read it and found no write, but it has not been driven); that the CDDIAG/CDDASHBOARD figures are useful when the saved record is old.
8. **Robot case to prove it:** `N46_ro_inspect`. Open a copy of a drawing with 2 pits and 1 pipe via the read-only open. Type `CDDIAG` and check the command line contains "this drawing is read-only" and "2 pit(s), 1 pipe(s)". Type `CDPARTS` and check the catalogue window appears. Type `CDDASHBOARD` and check its window appears. Check the DWG file hash and size are unchanged. Switch-off control: set `linking.inspectRunsOnReadOnlyDrawing` to false before launch (settings are read at start-up) and repeat; each command must print "cannot run - drawing is read-only" and open no window.

---

## Technical detail

1. **Base and PR:** `origin/claude/rel-20261102a` (3fbb9da5). Draft PR #2007, branch `fb/w1045-readonly-inspect`, one commit. No other open draft touches these files (checked by name in the repo history; `gh pr list` search not run for the shared files beyond this PR).
2. **Fault confirmed on base:** `Services/DrawingSafetyService.cs` `CommandPreFlightCore` refused `doc.IsReadOnly` for every caller (line 70); `DiagnosticsCommand.cs:26`, `DashboardCommands.cs:28`, `PartsCatalogueCommands.cs:32` call it. Not already fixed: the only branch with BUG-1045 is the Structural one (57c1b060).
3. **Why not a simple bypass:** `ProjectDataService.SetDrawingPath` and `EnsureDrawingDataCurrent` save the record into the drawing, so CDDIAG and CDDASHBOARD use `BindToDrawingWithoutSaving` on a read-only drawing.
4. **Isolation:** TEMP, TMP and CE_LOG_DIR_OVERRIDE set to `C:\CE_WORK\scratch\w1045\...`; the override folder stayed empty. Before/after listings are saved as `C:\CE_WORK\scratch\w1045\appdata_before.txt` and `appdata_after.txt` (36,510 files listed). Changed between them: CD_RecentValues.json, CE_Admin outbox and session files, the Civil, Structural and Manager logs, suggestions.jsonl. All last-write times are 12:01 to 12:02:38 Melbourne, when the Civil, Structural and Manager plugins all logged "terminated" within 0.3 s of each other, which a Civil test run cannot cause (it loads no Structural or Manager plugin). My only test that ran tests started after that. Flagging per the isolation rule; if you want certainty, the saved listings show every file.
5. **Tests:** `dotnet test Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj -c Release --filter FullyQualifiedName~Bug1045InspectReadOnlyTests` with the four AutoCAD refs and the skip flags: net48 6 passed, net10 6 passed (net8 reported no match for the filter, as that target runs a different set). Count not 0. net48 compiled.
6. **Files:** as in the PR. CE_SHARED untouched. No window change.
7. **Cleanup:** worktree and scratch removed after this push; C: free was about 66 GB at start.
