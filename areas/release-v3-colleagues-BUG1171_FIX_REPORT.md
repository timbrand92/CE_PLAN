# B-050 / BUG-1171 fix report: Civil's failure reports reach Tim as a short list (Manager only)

Written Fri 30 Oct 2026, about 01:35 Melbourne, by the B-050 build job (Sonnet, headless, CE 01 Build).

---

## FOR TIM

1. **Answer first:** the fix is built and open as **draft PR #1860** (branch `fb/bug1171-manager-outbox`, base `claude/rel-20261029a`). It changes **Manager only**. The protected shared file and Civil are untouched.

2. **What you will see differently:** nothing today, because sending is still OFF (you have not yet said yes to sending, QUESTIONS item 61). Once sending is turned on, a failed CE command on Max's PC lands in the office IT folder as one small file holding only: the job number, the command that failed (for example CDDESIGN), a code for his PC, and the day. No drawing name, no client name, no error text, no folder path. The CE version is left out until you answer Q2.

3. **Your rule "never delete anything unsent" is now kept.** The old collector deleted Civil's old files the first time it was switched on. Now they are moved into a "kept-not-sent" folder next to the outbox and never sent. Reports that were sent are moved to "kept-sent".

4. **The new switch** is `pluginOutboxFullRecords` in Manager's switch file. It is off by default, which means the safe short list is on. Only a plain `true` brings back the old way.

5. **My own mistakes first:**
   1. I wrote my first scratch files straight into the shared `C:\ce-fx` folder instead of my own sub-folder; I moved them into `C:\ce-fx\b050` before finishing. Nothing of anyone else's was touched.
   2. I waited about two hours for a free build slot (other jobs held it). No wasted test run, but the PR is two hours later than it could have been.
   3. The plan said a usage record "is never moved". I made new usage records stay put, but the one-off clear-out of OLD files (older than the first time sending is switched on) also moves old usage files into kept-not-sent. That is how the 23,893-file pile will be cleared, and it matches your rule, but it is slightly more than the plan's wording.

6. **What is NOT proven:** nobody has opened Manager with this. Not tried on your real pile of 25,842 files (how long the first move takes is unknown). Not tried against the real office folder. The one-time old-folder move was tested on temporary folders only. Nothing in AutoCAD.

7. **Nothing for you to do yet.** Sending only matters after you answer Q1 to Q4 (planner's block in the plan, section 8).

---

## Technical detail

1. **PR:** #1860, draft, base `claude/rel-20261029a` (Civil 3.0.86 / Manager 1.1.86, C-76). Worktree `C:\ce-fx\c82c`. `origin/fb/manager-help-tab` does not exist, so there was nothing to merge from B-047.

2. **Files:** `Modules/Manager/Services/CeAdminStorageService.cs`, `Modules/Manager/Services/CeOneGlanceStatus.cs`, `Modules/Manager.Tests/Services/B050PluginOutboxShortListTests.cs` (new), `REGRESSION_LOG.md`. `Shared/` has no diff against the base.

3. **Switch:** `CeManagerSwitches.PluginOutboxFullRecordsKey = "pluginOutboxFullRecords"`, `PluginOutboxFullRecordsEnabled()`; read with the same strict reader as `drainPluginOutbox` (missing, empty, broken or not plain true gives false, which means the fix). `drainPluginOutbox` is untouched and still OFF.

4. **Code:**
   1. `TryUploadOutbox` passes the switch into a new `UploadAllOutboxes(..., bool fullRecords, out count)`. The two older overloads call it with `true`, so all existing tests still run against the 1.1.85 behaviour.
   2. Fix on: `TryClearPluginBacklog(..., keepRoot)` moves instead of deletes (`DisposeUnsent`); `UploadPluginShortList` reads only `failures\`, sends `BuildShortRecord` output and moves the original to `kept-sent`; non-Civil, unreadable, no-PluginId files and `support-bundles` go to `kept-not-sent`; `usage`, `machines` and any other folder are not read, sent or moved (except the one-off old-file clear-out); `.tmp`/`.bak` left alone.
   3. `BuildShortRecord`: exactly six names (PluginId, Kind, JobNumber, CommandName, MachineName, Date). Job number only from a `[job NN-NNN]` token left after Manager's own scrub of DrawingName and Message; command and PC code must match strict shapes or are blanked; Date is the day only.
   4. `MoveOldRootLeavingOutbox` replaces the whole-tree `Directory.Move` in `GetLocalRoot` when the fix is on.
   5. Machine reports are not sent (the plan listed Kind "machine" but gave no field list that avoids the active-drawing text; nothing in Tim's answers asks for them). Say if they are wanted.

5. **Tests (net10, headless):** new class 18 of 18 pass; Manager full suite 1,085 total, 1,084 passed, 1 skipped, 0 failed (count not 0); Manager net48 build 0 errors, 0 warnings. Civil not run (unchanged). Runs at below-normal priority, one build slot, one group per call.

6. **Not tested:** AutoCAD, a real Manager start, real folders, the real pile, Max's PC, Civil, Structural, the Settings or Manager windows.

7. **Robot case proposal `N50_mgr_outbox_short` / switch-off control `C50`:** cannot run until the office IT folder can be pointed at a scratch folder.
   1. Setup: a test profile whose IT admin path is a scratch folder; test-only `manager-switches.json` with `{"drainPluginOutbox": true}` (never Tim's own file); a seeded Civil failure file in the test plugin outbox with `"CommandName": "CDDESIGN"`, a `Message` naming a drawing path inside a `24-100` job folder, plus a seeded old usage file.
   2. Types: `CEMANAGER`, then presses Send.
   3. Checks: the scratch office folder holds exactly one `failures\...json` whose names are exactly PluginId, Kind, JobNumber, CommandName, MachineName, Date; the line `"JobNumber": "24-100"` and `"CommandName": "CDDESIGN"` are present; no text "dwg", "Details" or the drawing name; the old usage file is under `kept-not-sent\usage`, not deleted.
   4. Switch-off control `C50`: the same with `"pluginOutboxFullRecords": true`; expects the old full scrubbed record (the line `"Details"` present) and the old usage file gone.

8. **Next:** CE 01 to name PR #1860 in the build register and DESK_LOG; Opus review; the questions chat to ask Q1 to Q4.
