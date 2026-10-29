# BUG-1171 plan: Civil's reports never reach Tim (build item B-050, planner job B-043a slot)

Written Thu 29 Oct 2026, 22:30 Melbourne, by a read-only planner (Opus, headless, CE 01 job). No code was changed,
no dotnet was run, no branch or worktree was made. Code read from `origin/claude/rel-20261026z` @ `09126560`
(Civil 3.0.85 / Manager 1.1.85, C-75, the installed build).

---

## FOR TIM

1. **Answer first: this fix does NOT need a change to the protected shared file.** The carpark, the build register
   and the 29 Oct triage all say BUG-1171 "needs a Shared train". That is not right for the smallest fix. Manager
   already has the code to collect Civil's reports from Civil's folder. It is in the version you have installed
   (Manager 1.1.85), switched OFF. So the fix can be a Manager-only change in an ordinary train.

2. **My own mistake first:** none in code (I changed nothing). The plan I was asked for assumed the shared-file
   route. I am recommending the other route instead. CE 01 should check my reasons below before accepting that.

3. **Why the shared-file route is worse, in plain terms.** If Civil wrote into Manager's own folder, its reports
   would go out through Manager's "copy the whole file" path. That path never checks what is inside. Today's route
   (Manager reads Civil's folder) checks every Civil report line by line and cuts drawing paths down to the job
   number. So moving the folder would send MORE, not less.

4. **What you would see after the fix.** Max runs a CE command that fails. Next time Manager starts (or he presses
   Send), one short report lands in the office IT folder: job number, the command that failed, a code for his PC,
   and the date. No drawing name, no client name, no error text. You turn the PC code into "Max's PC" once, in
   Manager's private name book on your own PC.

5. **What is piling up today.** On your own PC, Civil's folder holds **25,842 report files** dated 28 Apr to
   29 Oct 2026 (138 day folders of failure records and 150 of usage records). Nothing ever sends or clears them.
   Size on disk: not measured (the count took over two minutes). Max's PC: not measured (GUESS: the same kind of pile).

6. **One thing in the existing code clashes with your ruling.** You said "never delete anything unsent". The
   collector already built (#1788) DELETES Civil's old files instead of sending them the first time it is switched
   on. Today it is OFF, so nothing has been deleted. The fix must change that to "keep, never send" first.

7. **Four decisions for you** are in the block at the end (for the questions chat to ask). The biggest one: once the
   short list is built and tested, may Manager start sending it.

8. **What is NOT proven:** everything. This is a plan. Nobody has built it, run it, or opened Manager with it.

---

## Technical detail

### 1. The two folders (verified in code, 29 Oct)

1. **Civil writes** to `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox` — `Shared/CE_SHARED/Services/CeTelemetryStore.cs:60-65`
   (`Root`), `:69` (`OutboxRoot`). Used by `Modules/Drainage/Services/AdminTelemetryService.cs:516` (`Store`).
2. **Manager's own folder** is `%APPDATA%\CE_CADTOOLS\CE_Admin\outbox` — `Modules/Manager/Services/CeAdminStorageService.cs:33,45`.
   `CeAppDataPaths.GetLocalOutboxRoot()` (`Shared/CE_SHARED/Services/CeAppDataPaths.cs`) resolves to the same folder
   ("Outbox" vs "outbox", same on Windows).
3. **The one-time move** `CeAdminStorageService.cs:36-40`: if `CE_CADTOOLS\CE_Admin` does not exist and
   `TIM_CE_CADTOOLS\CE_Admin` does, Manager moves the WHOLE old tree (Civil's outbox, sessions, seat_tokens.txt) into
   its own folder, once. Civil then re-creates its own. Confirmed on this PC: both trees exist.
4. **Manager already reads Civil's folder**: `GetPluginOutboxRoot()` `:167-172` and `UploadAllOutboxes(...)` `:204-222`,
   behind the Manager switch `drainPluginOutbox` (`CeOneGlanceStatus.cs:240-243`, file
   `%APPDATA%\CE_SUITE\manager-switches.json`, missing file = OFF). Called at Manager start (`Plugin.cs:172`) and by
   the Send buttons (`PluginManagerWindow.xaml.cs:771`, `PluginAdminWindow.xaml.cs:169`).
5. **#1788 is already in the release.** `git merge-base --is-ancestor origin/fb/r2fix-954-bug552a origin/claude/rel-20261026z`
   is true, and the three code files have no diff. #1788 is still an OPEN draft against `claude/rel-20261025r`
   (left as is, D6). Commits in the release: `c1b33b78`, `c4229aa0`.

### 2. What the existing collector sends and deletes (switch ON)

1. **Sends:** only files whose `"PluginId"` is `CE_CVL_SUITE` (`:343`); every text value except PluginId is put
   through `CeSupportBundleScrub.Scrub` (drawing and job-folder paths cut to the job number, login and PC removed)
   (`:349-354`). It still sends every FIELD: Message, Details (exception text), AutoCadVersion, DurationMs, Result,
   StatusSummary, SourceRoot, and the whole usage stream (every command run).
2. **Deletes unsent:** every file older than the first-ON time stamp (`TryClearPluginBacklog` `:260-269`), every
   real-named machine file (`:244-255`), every non-Civil file (Structural) and every unreadable file (`:343-347`),
   every old support zip (`:325-328`).
3. **Civil's own records** already carry only `[job NNNN]` in `DrawingName` (`AdminTelemetryService.cs:324`,
   `FaultReportTextScrub.DrawingLabel`), and scrubbed Message/Details (`:175-176`). Login and PC are hashed
   (`CePiiHash`).

Against Tim's rulings (decisions 12 and 14, 29 Oct): receiver Tim; only the short list (job number, command that
failed, which PC) leaves the PC; the office IT folder can be opened by others; never delete anything unsent. The
existing collector breaks two of these: it sends more than the short list, and it deletes unsent files.

### 3. Correction to the earlier write-ups (rule 6.2)

1. **BUG_CARPARK BUG-1171** "Fix kind: code (shared file, sync by hand with Manager)" and
   **PILOT_NOFIX_TRIAGE_29OCT section E** ("the batch 4 option of making Manager upload the old folder is out: it
   would send drawing names") are not right. Civil's records have carried only the job number since BUG-552, and the
   collector checks each Civil file. The real gap is the field list and the deleting, both Manager-side.
2. **Moving Civil into Manager's folder (the CE_SHARED route) would be the less private route**: Manager's own
   outbox goes through `UploadOutbox` (`:428-478`), a plain `File.Copy` with no field check.
3. The memory note `ce-shared-one-assembly-identity` says Structural does not reference CE_SHARED. True for the
   INSTALLED Structural 1.0.125 (its three DLLs contain no `CE_SHARED` reference, read 29 Oct), but the monorepo
   `Modules/Structural/CE_STRUC_SUITE.csproj:147` does reference it and its `AdminTelemetryService.cs:496` uses
   `CeTelemetryStore`. A change to `CeTelemetryStore.Root` would also move a future monorepo Structural's records.

### 4. Recommended plan (route B, Manager only, no CE_SHARED change)

One draft PR, B-050, base `claude/rel-20261026z` (or the then-current release), files in `Modules/Manager` only:

1. **Short list only** (`UploadPluginOutbox`, `CeAdminStorageService.cs:307-369`). Replace "scrub every text field"
   with an allow-list built into a NEW small record: `PluginId`, `Kind` (failure or machine), `JobNumber` (taken
   from `[job NNNN]` in DrawingName or from the scrubbed Message; blank when none, never a guess), `CommandName`,
   `MachineName` (the hashed code), `Date` (day only), `PluginVersion` (decision Q2). Nothing else is written. The
   usage stream is NOT sent (decision Q3): usage files stay on the PC.
2. **Never delete unsent** (`TryClearPluginBacklog` `:230-279` and the deletes at `:325-328`, `:343-347`). Instead of
   `File.Delete`, MOVE each such file to `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\kept-not-sent\<same relative path>`,
   outside `outbox`, so it is never scanned or sent again. A move is not a delete. Sent files: after the short record
   is written to the office folder, the original is moved to `kept-sent\` (decision Q4 says whether that may later
   be deleted).
3. **The one-time move** (`:36-40`): with the new switch ON, the move leaves `outbox\` behind (Civil's records stay
   where the collector reads them, and are never sent through the unchecked path). Everything else moves as today.
4. **The switch (ships ON, R-00/R-27).** Manager switches read "missing = false" (`CeManagerSwitches`), so the new
   guard is an inverse key: **`pluginOutboxFullRecords`** (default false = short list, keep-not-sent, move leaves
   outbox; true = exactly today's collector and move). Documented beside the others in `CeOneGlanceStatus.cs` with
   "Default: OFF = the fix is on" wording, pinned by a default test. `drainPluginOutbox` itself STAYS OFF (Tim's
   ruling 14) until Tim answers Q1.
5. **No Civil Settings switch is needed** because Civil does not change. (If route A is ever chosen, see section 6.)

### 5. Tests (all without AutoCAD; `UploadAllOutboxes` already takes explicit folders)

1. A Civil failure file with Message, Details, AutoCadVersion and `[job 2417]` produces an office file with ONLY the
   allowed names; the text "Details" and the exception text are absent (read the written file back).
2. A file with no job number gives a blank JobNumber, never "0" or a guess.
3. Backlog, Structural, unreadable and support-zip files end up in `kept-not-sent` byte-identical, and nothing in
   the office folder; count of files before = count after (nothing lost).
4. A usage file is never sent and never moved while the usage question (Q3) is "no".
5. `.tmp` / `.bak` still left alone (BUG-848).
6. One-time move with the switch ON leaves `outbox` in place; with it OFF moves everything (today).
7. Switch-default test: missing file, empty file, broken file all give the fix ON; `"pluginOutboxFullRecords": true`
   gives today's behaviour exactly (rerun the existing `CeAdminPluginOutboxDrainTests` with the key set and assert
   the same results as on 1.1.85).
8. Manager net10 focused tests, the full Manager suite (count not 0), net48 compile. Civil is unchanged, so no
   Civil run is needed beyond the train's normal one.

**Robot case (proposed, cannot run until the IT folder can be pointed at a scratch folder):** `N50_mgr_outbox_short`
/ C50. Setup: a test profile whose IT admin path is a scratch folder, `drainPluginOutbox: true`. It types a CE
command that is known to record a failure on a drawing whose name carries a job number, then `CEMANAGER`, presses
Send, and checks the scratch office folder holds one file whose names are exactly the short list and whose text
holds the job number and no drawing file name. Switch-off control C50s: same with `pluginOutboxFullRecords: true`,
expects today's full scrubbed record. Neither case may touch Tim's own `manager-switches.json`.

### 6. If the CE_SHARED route is ever wanted (route A, NOT recommended)

1. **Change:** `CeTelemetryStore` gets a second constructor taking the folder name (default `TIM_CE_CADTOOLS` so
   Structural and every old caller are unchanged), and Civil passes `CE_CADTOOLS` behind a Civil Settings switch
   declared like `pipe.editPipeReverseArrowReadsDrawnEnds` (`UserSettings.cs`, "Default: on.", pinned in
   `C75NewSwitchDefaultsTests`, both start-up reads).
2. **Why it needs a shared train:** a new public constructor in CE_SHARED means a Civil built against it throws
   `MissingMethodException` at load if Manager's older CE_SHARED loads first (same 1.1.0.0 identity) — no CE ribbon
   (the 15 Sep 2026 incident). So Civil and Manager must be built from ONE commit, ship the same CE_SHARED in all
   three lanes (Legacy net48, Net8, Modern net10, never crossed), install together through the install chain, and
   pass its "CE_SHARED identical" check (`chain_install_c75.log` line 3 shows the check exists). `CeSharedCopyCheck`
   (Civil and Manager) warns at start-up if they differ. Today's installed copies match lane for lane (SHA-256 first
   16: Legacy ed9a496f…, Net8 8fd38f9b…, Modern 4d3121ae…, Civil = Manager).
3. **It would still need route B's Manager changes**, because Manager's own outbox path sends files unchecked.
   That is why route A is more work and less private.

### 7. Risks

1. **Manager's own records** (its own failures and machine file) still go out through `UploadOutbox` with scrubbed
   but full text, switch or no switch, today. Tim's ruling 14 was asked about #1788; whether it covers Manager's own
   records is not recorded (Q1 asks).
2. **The pile is large** (25,842 files on Tim's PC); the first run with the switch ON moves them all once. On a
   background thread at Manager start; time not measured. Robot runs inflate Tim's pile; Max's is unknown.
3. **Job number extraction** relies on `FaultReportTextScrub.FindJobNumber`; a drawing named without a job number
   gives a blank. That is correct (unknown stays unknown) but Tim may see reports with no job.
4. **"Which PC"** is a code; Tim must teach the name book once per colleague (`CeWhoIsThisService`). Without that he
   sees codes only.
5. **OneDrive:** if the office IT folder is OneDrive-synced, the short list still leaves the building. It carries no
   client or drawing name, which is what Tim allowed.

### 8. Decision block for QUESTIONS_FOR_MONDAY.md (CE 01 to append; I did not write that file)

```
B-050 / BUG-1171 — Civil's failure reports to Tim (planner report: areas\release-v3-colleagues-BUG1171_SHARED_PLAN_29OCT.md)
Context: Civil's failure reports pile up on each PC (25,842 files on Tim's own PC since 28 Apr) and never reach Tim.
The fix is Manager-only; the protected shared file does not need to change.

Q1. Once the short list is built and tested, may Manager start sending it (turn drainPluginOutbox ON)?
    Recommended: YES, in the train after the robot and Codex have seen it pass. Real-world: Max's CDDESIGN failure
    shows in your admin view the next morning as "job 2417, CDDESIGN, PC code, 30 Oct". If NO: nothing changes, the
    pile keeps growing, you hear about faults only by phone.
    Also: does the same short-list rule apply to Manager's OWN reports? Recommended: YES (one rule for everything).

Q2. Besides job number, failed command and which PC, may the date and the CE version go too?
    Recommended: YES. Without the date you cannot tell an old fault from today's; without the version you cannot
    tell if the fault was fixed in the update Max has not installed yet. Neither names a client or a drawing.

Q3. Should usage records (every command a colleague runs, not just failures) be sent?
    Recommended: NO. You asked for "the command that failed". Usage stays on the PC.

Q4. The old files: CE will move them to a "kept-not-sent" folder on each PC and never send them (your rule: never
    delete anything unsent). May CE ever delete them, for example after 90 days?
    Recommended: NO for now: keep them, they are small text files; revisit if a colleague's disk complains.
```

### 9. What CE 01 should do next

1. Read section 3 and decide whether to correct the carpark's "Fix kind" (CE 05 owns BUG_CARPARK.md) and the build
   register line 74 (CE 01 owns it): B-050 becomes a Manager-only build, no shared train.
2. Append the block in section 8 to QUESTIONS_FOR_MONDAY.md and send it to CE 04.
3. Build B-050 per section 4 as a draft PR with `pluginOutboxFullRecords` (fix ON) and `drainPluginOutbox` still OFF.

---

**Summary:** BUG-1171 does not need a CE_SHARED change. Manager's collector for Civil's folder (#1788) is already in
Manager 1.1.85, OFF. The fix is Manager-only (`CeAdminStorageService.cs`, `CeOneGlanceStatus.cs`): short-list
record, keep-not-sent instead of delete, one-time move leaves the outbox, inverse switch `pluginOutboxFullRecords`
(fix ON). Four questions for Tim. No PR, no code, nothing run.
