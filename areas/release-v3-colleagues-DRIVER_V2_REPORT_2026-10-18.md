# Claude test robot, driver v2 (Sun 18 Oct 2026, built 04:00 to 04:40 PC clock)

**Answer first.** The new driver `acad_driver_witness_v2.ps1` is built and its self-test passed in real AutoCAD 2027: **177 PASS, 0 FAIL, 1 NOTE** (the NOTE is a check that cannot work, explained below). **Built and self-tested only. Not reviewed by Opus. Not Tim-accepted. No real robot pass may use it until the Opus review is done; the desk launches that review.**

Files, all in `C:\Lisp Files\_ACAD_DRIVER`: `acad_driver_witness_v2.ps1` (the driver), `acad_driver_witness_v2.allowlist.json` (the allow-list, pinned by hash inside the driver), `driver_v2_selftest.ps1` (the proof), `DRIVER_TESTER_GUIDE.md` (new section 9). The old `acad_driver.ps1` (sha c9ba503d) and `acad_driver_witness.ps1` (sha 0b1116c6) are untouched. Tim's four real settings files have the same hashes as at the start (CD ACD64E79A33B, CS 622A246F7D3B, CS in the structural folder 24D8E5F7D87B, CVL settings EFE307C4FC74). No AutoCAD is running; the lock is released; the test copies were deleted; both pristine fixtures still hash 34BBE37C2EA4 and 950AFDF6E523.

## 1. Which verbs work (each proven by the self-test in real AutoCAD, on copy CLD90)

1. **ui press** works. Pressed Cancel without saving and Save pit and close in Edit Pit, Refresh and Relink and recalculate in Pit Schedule, Choose DWG and Close in X-Civil import. Refused correctly: More... (not on the list), Export CSV (never list).
2. **ui set** works. Text box (note above levels = V2TEST) and toggle button (Pit label block on plan, on).
3. **pick-first** works. Pit P3 (handle 109D56) selected, count 1 read back, then CDEDIT opened the Edit Pit window on it.
4. **esc-prompt** works. Ended a LINE that was waiting for its second point (a plain AutoCAD command, which the old `esc` refuses). Refuses when nothing is waiting or the driver started nothing.
5. **dialog-path** works. Through X-Civil import, Choose DWG opened the Windows dialog "Choose X-Civil drawing", the driver typed the path of the second test copy, pressed Open, the dialog closed and the window showed the file.
6. **shot** works (new, Tim's request). PNG of the AutoCAD window and of CE windows by name, read back with the Read tool. PrintWindow worked every time; a separate CE window is not inside the AutoCAD picture, so shoot it by name.
7. **click-canvas** works (new, Tim's request). One real left click at drawing coordinates. Wanted 72801.8,-61633.3, got 72845.1,-61603.9: one pixel out. Only after `click-canvas calibrate` while idle, and only while a command the driver started waits for a point. Refused when AutoCAD is idle. It is the last resort; `answer "x,y"` is still the preferred way to give a point.
8. **save-copy and reopen-copy** work (new, desk decision). Saved the Edit Pit change on the copy (hash 34BBE37C2EA4 to 938BB6E8F19F logged), reopened it, and Edit Pit then showed V2TEST: the change persisted. Refused correctly: SaveAs over an existing file, a name that is not CLD, reopen with unsaved changes (needs -Force and says so), and both verbs on the pristine DRV2_S1 fixture. The fixtures' hashes did not change.
9. **settings guard** works: `settings-temp set` / `snapshot` / `arm` / `status`, `settings-restore`, `-RestoreOnExit`, and the automatic restore in `quit`. Proven only on a SCRATCH settings file (never Tim's real ones): one key changed, nothing else, restored byte for byte, hash equal. A damaged backup made the restore fail LOUDLY and keep the backup and the manifest; after repair it restored. The Settings window gate (Apply refused until armed, Cancel always allowed) is proven at function level only.

## 2. What did not work, or was not proven

1. **Pit Schedule Apply and Place were not proven.** On this drawing the window offers only Refresh, Relink and recalculate and Close; Apply and Place appear after rows are chosen. They are on the allow-list but untested. Relink and recalculate pressed without error; no visible change was read back.
2. **The Settings window itself was never opened** (its gate is tested, not the window).
3. **`quit -Kill` with a live settings guard** was not run (the same restore code runs in the normal quit, which was proven).
4. **A check that cannot work:** DBMOD cannot show a data change on this fixture because CE marks the drawing changed at open (49 pipes upgraded, DBMOD already 1). The proof used instead is the note text found in the drawing and in the Edit Pit window after reopening.
5. **A hang I found:** pressing "Review changes" in Edit Pit opened a second window ("Pit review"); after Cancel, AutoCAD stayed busy (COM rejected every call, CPU idle). Two esc-prompt keys did not end it; `quit -Kill` did. I removed Review changes from the allow-list. The cause inside CE is not known; whether a window opened that way is ever left in this state in normal use is a question for the CE side.
6. `launch -Env` (isolated profile) is still broken (run 26); not touched.

## 3. Call counts and the safety design

1. **Self-test driver calls:** about 22 offline, then 15, 10, 35, 11, 12 and 3 in the AutoCAD stages of the final run, plus the first runs while fixing faults. Every call is counted in `calls_v2.json` (refusals too) and logged in `transcripts\v2_audit.jsonl` (132 lines for this work).
2. **Caps per verb per session:** ui press 40, ui set 60, pick-first 40, esc-prompt 25, dialog-path 10, shot 40, click-canvas 25, save-copy 20, reopen-copy 20, settings-temp 12, settings-restore 12. `ACAD_DRIVER_CALL_CAP` makes the driver enforce a tester's total cap.
3. **Allow-list pin:** the JSON is used only if its SHA-256 equals the value written in the driver (now FD13DBA3...). Editing the JSON without a reviewed edit of the pin makes every v2 verb refuse (tested).
4. **Everything else is the old guard set:** test copies only, lock held by the caller, the AutoCAD this driver launched, one AutoCAD at a time, never Manager windows, Save dialogs or the AutoCAD main window. save-copy and reopen-copy use AutoCAD's own Save and Open through COM; the typed deny words (SAVE, QSAVE, OPEN, CLOSE) are unchanged.

## 4. For the Opus review (please look hard at these)

1. The never-press list and each window's press list in the JSON; in particular Update and Continue placement, which the old driver refused and v2 allows in named windows on a test copy.
2. `ui set` allows any field (`*`) in the CE editing windows and Settings; the gate is the lock, the test copy and the button list on `press`.
3. `click-canvas`: the pointer is moved and a real click is made; check the guards (frame in front, window under the pointer belongs to AutoCAD, command waiting, calibration age).
4. `esc-prompt` ownership is a record file (`v2_state.json`) written by `type` and `ui press`; a tester with file access could edit it. I did so once myself to recover from the hang above (stated here, not hidden).
5. save-copy name rules (`CLD*` allowed; `DRV*`, `_PRE_`, `.bak`, `.dwt` refused) and that SaveAs can never overwrite.
6. The settings guard writes the original bytes back with a plain file write; check the retry and verification logic.

## 5. My mistakes

1. I started a bare python command by accident while editing; it hung and I stopped it. No effect on any file.
2. The first stage-1 run and the first stage-2 run failed on faults in my own driver (duplicate window entries, a file lock on the open drawing, a nested array), fixed and rerun. AutoCAD was killed once (the hang in section 2.5) and relaunched on fresh copies.

## 6. What I did not test

Real robot journeys, Structural windows, the Settings window, Pit Schedule Apply and Place, a layout tab, any click on a drawing object (only an empty point), and an AutoCAD that was not launched by the driver (refused by design).

**Built, tested, installed, accepted:** built and self-tested in AutoCAD 2027 on test copies; not installed anywhere (it is a tool); not Opus-reviewed; not Tim-accepted.
