# BUGFIX f1 report: BUG-430, double-click on a pit label (build B-110)

Job f1, Sat 31 Oct 2026, Melbourne time (3:00pm to 3:45pm). Civil only. Built and unit-tested only. **Nobody has opened this in AutoCAD. BUG-430 is NOT marked fixed.**

---

## FOR TIM

**Answer first: draft PR #1923 is open (B-110, against `claude/rel-20261102a`, Civil 3.0.88).** With the double-click switch turned ON, a double-click on a pit label (the P8 text) should now open Edit Pit and AutoCAD's attribute editor should not open first. It needs a Codex look before anyone relies on it.

1. **What you will see differently (only once `doubleClick.opensEditWindow` is ON):** double-click the P8 label: Edit Pit for P8 opens, and AutoCAD's Enhanced Attribute Editor window does not appear first. Today, with that switch ON, the AutoCAD editor wins the race.
2. **Your 22 Oct ruling is untouched.** The main double-click switch stays OFF by default. With it OFF, nobody sees any change from this PR.
3. **Xref plan or sheet border round the pit:** I fixed this too. CE no longer treats a border or Xref plan that only surrounds the label as "a second thing you clicked". Two real symbols on top of each other still make CE back off, and an Xref block is never opened. **Question I did NOT act on:** should CE also ignore a border that is smaller than the whole sheet, or a block that merely overlaps the label? My recommendation: no. CE never guesses between two real symbols. I changed nothing beyond the surround case.
4. **One new switch, ON:** `doubleClick.pitLabelStopsAttributeEditorFirst`. Set it to false and the old behaviour returns exactly. It has no row on the Settings page, the same as the downpipe switch beside it.
5. **Nothing bypasses protection:** a label or pit on a locked layer, an Xref block or pit, and an open in-place edit (REFEDIT) all keep AutoCAD's own editor. Nothing is unlocked.
6. **A Codex look is needed.** You must SEE which window opens. Robot case below; the robot may not be able to double-click on a drawing point (unproven), in which case it is Codex-only.

**My mistakes:**
1. Two existing guard tests (BUG-859) failed on my first run because they pin exact call text in the handler. I changed my code to keep the old call text for the switch-off path rather than editing those guards. Cost: two extra 5-minute test runs.
2. My first run script had a mangled path (my own shell edit) and failed to start. Cost: one retry.
3. I did not run the full suite: the job's later rule said focused classes only, so I followed that over the METHOD line that said once at the end.

**What is NOT proven:**
1. Nothing has run in AutoCAD. The cause (the editor race for a pit label) is an inference from the downpipe robot results (R09), as z3 said; no pit-label run on 3.0.88 exists.
2. Whether a real pit label is a block with a recorded owner on a real drawing (the linked proof) is read from code, not seen. An older label with no owner record is deliberately left to AutoCAD.
3. The label's position relative to the pit: if the label sits inside the pit's own outline, the hit-test still says "two blocks" and backs off (the pit counts as a real symbol). I did not change that.

**Robot case to prove it: N95_pitlabel_dblclick** (style of N31_dp_time / C31). Needs a Codex look as well.
1. **Settings before launch:** `doubleClick.opensEditWindow` true (settings are read at AutoCAD start). Leave the new switch at its default.
2. **Drawing:** a copy of the L4 drawing with a sheet frame or Xref plan around the pits, P8 label placed beside P8 (not inside the pit outline).
3. **Types:** double-click the P8 label text (the driver needs a drawing-point double-click; if it cannot, Codex does it by hand).
4. **Checks (CE log and windows):**
   1. Log line "TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-430, doubleClick.pitLabelStopsAttributeEditorFirst); pit label".
   2. Log line "TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle".
   3. The Edit Pit window for P8 opens.
   4. No "Enhanced Attribute Editor" window is listed.
5. **Switch-off control (N95_OFF):** same drawing and double-click, `pitLabelStopsAttributeEditorFirst` false before launch. Expected: no "stopped ... (BUG-430" line, and AutoCAD's Enhanced Attribute Editor opens (or CE logs "EATTEDIT not stopped at its start (tagged source False, ...)" if a hit is found; with the frame in place it logs the hit-test "2 block(s) under the pointer" and goes ahead). The case must FAIL with the switch off.

---

## Technical detail (below the line: nothing here needs Tim)

**Fault check (done first):** still present on the installed line. Installed bundle per z3 is Civil 3.0.88+3fbb9da5; my start point `origin/claude/rel-20261102a` head 3fbb9da5 is that commit. Re-read on it: `ShouldStop` was `isTaggedSource && !locked && !refedit` (a pit label is not a tagged source), and `TryPickTaggedBlockInsideBackground` accepted only a tagged block. Both causes from z3 still true.

**Change (commit e3dfb957, branch `claude/b110-bug430-pitlabel-dblclick`, PR #1923 draft):**
1. `Models/DoubleClickSettings.cs`: `PitLabelStopsAttributeEditorFirst`, JSON `pitLabelStopsAttributeEditorFirst`, const default true, documented "Default: on.".
2. `Rules/DoubleClickAttributeEditorStopRule.cs`: `PitLabelIsOn`, `ShouldLookForPitLabel` (needs the new switch AND `opensEditWindow` AND a fresh double-click AND a position), `ShouldStopForPitLabel` (linked, not locked, not REFEDIT), `PitLabelStoppedLogLine`.
3. `Services/DoubleClickHitTest.cs`: `DoubleClickBlockCandidate.IsLinkedPitLabel` (optional ctor arg, default false); `TryPickTaggedBlockInsideBackground` counts a linked pit label like a tagged block (one target only, others must be untagged non-pit blocks that surround it on all four sides).
4. `Services/CompoundEditModeService.cs`: `TryReadLinkedPitLabel` (the existing `LinkService.ReadRecordedOwnerForEdit` two-sided proof; owner must be a pit that is not Xref content; reports the pit's layer lock); `TryFindBlockUnderDoubleClick(..., findLinkedPitLabels)` marks candidates only near the pointer and only when asked (the screen-position reading is now taken before the block loop, same call); `OnDocumentLockModeChanged` looks when either the downpipe look or the pit-label look applies, vetoes and registers the PIT (not the label) for CDEDIT; the command-start path passes the flag only when `opensEditWindow` and the new switch are ON. With the new switch OFF the calls are the old text and the old decisions.
5. `REGRESSION_LOG.md` entry added; test file `Bug430PitLabelStopsAttributeEditorTests` (new).

**Redo and protection:** one open-close ForRead transaction in the handler (a source-guard test pins that), no write, no new command, regen, view or system variable change. Locked label or pit layer, Xref block or pit, REFEDIT: AutoCAD's answer.

**Shared files:** open Civil drafts touching these files are #1834, #1862, #1676, #1522 and #1313. Their content (BUG-859 rounds, BUG-860, the border fix) is already inside the start point (3.0.86 to 3.0.88), so I based on the release branch as instructed, not on them. #1521, #1313, #1522, #1676 are old drafts with older bases; I did not touch them.

**Tests (Civil net10, one project, filtered):** `CE_CVL_SUITE.Tests.csproj -f net10.0-windows --filter "Bug430PitLabelStopsAttributeEditorTests|Bug859|C76NewSwitchDefaultsTests|C75NewSwitchDefaultsTests|Bug860|DoubleClick"`: **315 passed, 0 failed** (count not zero). These cover: the switch default ON through both `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant` (empty file, empty group, older keys); typed false changes only itself; `opensEditWindow` default still false; look/stop rules; hit-test linked label inside a frame or Xref plan is OneBlock while the same label unmarked is Ambiguous (the switch-off answer); pit, downpipe, second label or inner block stay Ambiguous; Xref label stays Protected; handler order and read-only guards. Net48 compile of `Modules/Drainage/CE_CVL_SUITE.csproj`: 0 errors. Full suite NOT run (job rule: focused only). Manager tests not run. The tests "fail before" by construction: the new members did not exist.
Test-command rule: each run printed its command, named the one `.csproj`, carried `--filter`; the script refuses a `.sln` or no filter. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below-normal priority, after a slot check (count 0).

**Isolation:** each run set `CE_STRUC_SUITE_APPDATA_ROOT`, `CE_LOG_DIR_OVERRIDE`, `TEMP`, `TMP` to a fresh folder under `C:\CE_WORK\scratch\f1\run_*` (echoed in the log). The classes run read only settings text and source files.

**Real-files compare (names, sizes, times only; before about 15:01, after about 15:35).** Folders: `%APPDATA%\TIM_CE_CADTOOLS` (incl. CE_Admin and logs), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` (incl. CE_Admin). Before: 33,290 files. After: 33,314 files. **No settings file changed** (no `CD_Settings.json`, `*Settings*.json` or struc settings file appears in the difference). 58 differences, all from a live AutoCAD session on this PC (acad was running; a restart at 15:32 rewrote session files and the menu cuix):
1. New or grown files: 23 usage files under `TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-10-31` (15:02 to 15:2x), machine heartbeat files in `outbox\machines` (CE_CVL_SUITE and CE_STRUC_SUITE, 508 and 498 bytes, 15:32), `CE_Admin\sessions\CE_CVL_SUITE.json` and `CE_STRUC_SUITE.json` (15:32), `CD_RecentValues.json` (12218 to 12220 bytes, 15:29:24).
2. Logs grown: `TIM_CE_CADTOOLS\logs\ce_struc_structured_20261031.log`, `CE_STRUC_SUITE\logs\ce_struc_suite.log`, `RuntimeDiagnostics\runtime_20261031.jsonl` and `runtime_snapshot.json`, `CE_CVL_SUITE\logs\ce_cvl_structured_20261031.log`, `CE_CVL_SUITE.log`, `native_grip_2027.log`, `ledger\suggestions.jsonl`, `telemetry\outbox.jsonl`.
3. New: `CE_CVL_SUITE\logs\cdcheck-CLDV31508041_B1-20261031-040912.txt` (a CDCHECK run at 15:09, not mine: my tests do not run commands).
4. `CE_CADTOOLS\CE_Admin\manager-menu-state.json`, `sessions\CE_SUITE_MANAGER.json`, `CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix` (15:32:36 to 15:32:46, after my last test at 15:25, so AutoCAD's startup, not my run).
**My reading:** none of these could have been written by my runs (my last test ended 15:25, several entries are timestamped after it, and the CDCHECK file needs a command run in AutoCAD). I cannot prove a negative for the 15:02 to 15:25 entries, so I am saying it plainly: another AutoCAD session was running throughout. The full before and after listings were in `C:\CE_WORK\scratch\f1` and are deleted with it.

**Clean-up and disk:** worktree `C:\CE_WORK\build\f1`: `git clean -fdXq` then `git worktree remove` done (branch kept, pushed). C: free space: about 36 GB at start (14:56), 48.1 GB at 15:35: it went UP by about 12 GB, from other jobs' clean-ups, not from mine (my worktree and test output were a few GB at most and are now removed). Scratch `C:\CE_WORK\scratch\f1` removed after this report was pushed.

**Decision 94 note:** when Codex passes this, the `OpensEditWindowDefault` flip to true is a separate commit with the PASS recorded. I did not touch it.
