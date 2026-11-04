# BUGFIX ff2002b report: #2002 (B-183, BUG-879) fix-first, Thu 5 Nov 2026

## FOR TIM

1. **What you will see:** pick "Reset cover text position" on a pit cover text grip and the command line now says "[CE] Cover text handed back to Tidy labels. It moves the next time Tidy labels runs." Before, it said nothing and looked broken.
2. **What does NOT change:** the text does not jump back on Reset. That waits on your answer (I recommend yes, as a separate job). No new switch; `linking.ceMovesMarkHandPlaced` stays ON.
3. **Mistakes of my own:** none that cost anything. My first log-script run failed (wrong shell) and was rerun.
4. **NOT proven:** built and unit-tested only. Nobody has opened this in AutoCAD. BUG-879 stays open.
5. **Robot case (to write, not run):** like N31_dp_time. Mark a pit cover text by hand (flip its grip), open the grip menu, pick Reset cover text position, and check the command line contains "handed back to Tidy labels". Switch-off control: with the switch OFF on a fresh pit the Reset line is not offered, so the line is absent.

---

## Technical

1. **Commit:** dfbe6edc on claude/w879-hand-placed (one normal commit on top of da825208; no force-push, no new PR, no retarget).
2. **Files:** Modules/Drainage/Commands/PitCoverTextFlipCommand.cs (success line in the Reset branch, 2 lines), Modules/Drainage.Tests/Rules/Bug879CeMovesMarkHandPlacedTests.cs (2 asserts added to the existing Reset guard test: the line is present, the branch has no Regen), REGRESSION_LOG.md (item 3c). CE_SHARED untouched.
3. **Test:** CE_CVL_SUITE.Tests, filter Bug879CeMovesMarkHandPlacedTests|NewSwitchDefaults: net48 261/261 pass, net10.0 261/261 pass (net8 target matched none, not our target). net48 compiles.
4. **Isolation:** TEMP, TMP, CE_LOG_DIR_OVERRIDE set to C:\CE_WORK\scratch\ff2002b\temp. Manager tests not run.
5. **Real folder listing before/after** (full lists in C:\CE_WORK\scratch\ff2002b\before.txt and after.txt, 244 lines): one difference, CE_CADTOOLS/CE_Admin/sessions/CE_SUITE_MANAGER.json, 228 bytes, modified 04:23 to 04:30. That is the Manager app's own session heartbeat (Manager was running on this PC); my run does not run Manager and does not write there. Flagging it as asked.
6. **Still open (not in this job):** review item 2.7 (Reset line stays after the switch is turned OFF on an already-marked pit), left alone as the review advised.
