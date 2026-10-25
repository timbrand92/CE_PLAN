# Round 2 review fixes applied, Mon 26 Oct 2026

Job: "TEAM: APPLY THE ROUND 2 REVIEW FIXES TO THE MERGE-WITH-FIXES PRS" (desk plan/03, Team, Sonnet). Input: `REVIEW_OPEN_PRS_R2_26OCT.md`. Restarted at 07:08 after the first run was stopped by mistake; the first run's partial work (#742) was checked, reused and finished. Work 07:08 to 10:57 Melbourne time.

## ANSWER FIRST

1. **All 17 MERGE-WITH-FIXES PRs now have a new draft PR with the review's fixes applied: 11 Civil/Manager (base `claude/rel-20261025r` d8840a09) and 6 Structural (base `claude/rel-20261025s` 3a3caac5).** Every old PR is untouched (nothing closed, retargeted, commented on or merged; no branch deleted; no force-push). Every live head matched the head the review names, checked again with gh before each one.
2. **Civil and Manager: the full net10 suite ran on every PR, and net48 compiles with 0 errors.** The only red in any final run is the PDF page-render test (needs AutoCAD's own renderer, AutoCAD was open), which passed every time it was re-run on its own.
3. **Structural: the full suite did NOT finish on this PC.** The test host sat at full CPU with no output for 30 minutes on the first run (it was stopped; I did not run the bare base to see if it hangs there too). The six Structural PRs were checked with focused classes only (each PR's own class plus the switch-defaults class), all green, and a net48 compile (hosted) with 0 errors. Treat the Structural "full suite" as still owed.
4. **Not done on purpose:**
   1. **#954 version bump:** the review says a Manager version bump is needed; the branch changes no version, `PackageContents.xml` or csproj. The next train's assembly takes it.
   2. **#1247** (MERGE as it is), **#1204** (HOLD, needs Tim), **#369 and #817** (REJECT) are not in this job's scope and were not touched.
5. **Nothing was installed or deployed.** No AutoCAD, Codex or accoreconsole was started. No settings files, bundles or ProgramData were touched. `CE_SHARED` unchanged in every branch. Every build used `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Built and unit-tested only: nobody has seen any of this in AutoCAD, and no bug is marked FIXED.

## Per PR (old PR and head, new PR and head, what changed, tests)

### Civil and Manager (base d8840a09)

1. **#742 BUG-406 (head 0ed568a0) → new #1781 (head 6b124d6b).** Took the PR's two commits. The one test line (`C5MixedUnitsTests`) now expects `markupStandards,`. Tests: Civil net10 20,386 total, 20,353 passed, 32 skipped, 1 failed (the PDF test; passed on its own re-run); net48 0 errors.
2. **#710 BUG-403 (head ef6937f6) → new #1782 (head a4ff2ea9).** Took the PR's five commits. New record-only read `ProjectDataService.HasCivilRecordContentReadOnly` (open-close, true when unreadable); the paste end uses it; new switch `linking.pasteLineForDrawingWithNoRecord` ON (OFF passes no read); wiring test updated plus new source guard and switch tests. Tests: 20,391 total, 20,359 passed, 32 skipped, 0 failed; net48 0 errors.
3. **#1029 BUG-517(g) (head 55883cd3) → new #1783 (head 5396cf9c).** Test that `{}` gives `#000000`; "Default: #000000 (black)." note. The #1043 overlap is for the desk: take #1029 for the sheet and drop #1043's `CalculationsV2ViewModel.cs` hunk (not touched here). Tests: 20,391 total, 20,359 passed, 32 skipped, 0 failed; net48 0 errors.
4. **#1147 BUG-527 5.2 (head d5b96269) → new #1784 (head 22c0f7ec).** The CDPROPAGATE / Edit Pipe cascade warning now reads each pipe's material once and uses `SettingsSizingStandards.CheckLimitMs`; "Default: off." notes; stacked summaries tidied; source guard and `{}` test. Switch stays OFF. Tests: 20,387 total, 20,355 passed, 32 skipped, 0 failed; net48 0 errors.
5. **#1152 BUG-545 part 2 (head 117a631f) → new #1785 (head 30f221b8).** The box is used only when a finite whole number of millimetres (else the Design Standards figure is kept and one warning line names it); with the switch ON the box figure joins the criteria fingerprint (OFF fingerprint unchanged); "Default: off." notes; added 25.5, infinity and an over-large figure to the tests plus a source guard. Switch stays OFF. Tests: 20,390 total, 20,358 passed, 32 skipped, 0 failed; net48 0 errors.
6. **#1144 BUG-543 (head 1402c9f8) → new #1787 (head 92ce817c).** Gravity switch ships ON (Tim's 17 Jul 2026 ruling "9.81 everywhere"); the Detention tab's gravity is `OrificeBasis.RuledGravity`; "Default: on." notes. One existing test (`DarebinOrificeNoteTests`) pinned the exact hole at 9.8 (43.326 mm) and was updated to the ruled gravity (43.314 mm; the adopted 43 mm is unchanged). BUG-543 is NOT done: the 0.61 sites remain. Tests: first full run 1 failed (that Darebin test), second 20,391 total, 20,359 passed, 32 skipped, 0 failed; net48 0 errors.
7. **#1150 BUG-541 (head 72e6b48e) → new #1786 (head 77941777).** The group moved into the existing `surface` group as `surface.slabMinimumFalls`; "Default:" notes; the log's backwards example corrected (pavers 70, a 1 in 60 paver slab, flagged before, now passes); path and source-guard tests. Tests: 20,392 total, 20,360 passed, 32 skipped, 0 failed; net48 0 errors.
8. **#1156 BUG-547 part 1 (head 45f4f520, first commit only) → new #1790 (head ee2cdf44).** The X-Civil level range commit (93fdfef3) is not taken (BUG-544 has it). Wording now "Connection pipe size assumes 10 m of UPVC (CE's assumption, not the drawn pipe)."; "Default:" notes. Tests: 20,387 total, 20,354 passed, 32 skipped, 1 failed (the PDF test; passed on re-run); net48 0 errors.
9. **#1159 BUG-547 part 2 (head e3700167) → new #1789 (head b349b1b2).** The Charged system file kept from the base (the PR's side would wipe BUG-597 and BUG-1097) with only the Settings reads laid on it, including the one 0.82 line; "Default:" notes on 11 keys and both groups; `WsudTabSettings.SourceWords` and its test deleted; source guard added. Tests: 20,393 total, 20,361 passed, 32 skipped, 0 failed; net48 0 errors.
10. **#1161 BUG-547 part 3 (head 344a5742) → new #1791 (head c52b514d).** Dead `trenchGrateLengthMm` removed; the LPD message builds its distance from the setting; "Default: 12000." style notes; `FLOOR_WASTE_MAX_SPACING_MM` deleted; source guard. Tests: 20,386 total, 20,353 passed, 32 skipped, 1 failed (the PDF test; passed on re-run); net48 0 errors.
11. **#954 BUG-552a (head 78bea5b5) → new #1788 (head 4b5cc0c5).** PR merged in (not cherry-picked), base log file kept with its five entries added on top. `.tmp` and `.bak` files skipped in the plugin outbox upload and in the backlog delete loop; new test `SwitchOn_ATmpOrBakFileIsLeftAloneAndNeverSent`. Switch stays OFF. Tests: Manager net10 1,032 total, 1,031 passed, 1 skipped, 0 failed (a first run had 7 failures from my own test TEMP folder using forward slashes; fixed in the runner, not in code); net48 0 errors. No version bump made.

### Structural (base 3a3caac5)

12. **#1157 BUG-503 S-13 (head bce513a2) → new #1792 (head 04f4d169).** `TryFindBestBeamLabel` (the nearer of the IB and EB match, only when the switch is ON) so an EB label is seen; the question reads "Some beam lines in this raft have no label. Are they External or Internal beams? [External/Internal] <Internal>:"; switch ships ON (also when settings are not loaded); tests for new PC, `{}`, OFF and the EB source guard. Tests: focused 34 of 34 passed; net48 (hosted) 0 errors.
13. **#1154 BUG-530 (head 542c1afe) → new #1793 (head c8e45895).** Switch ships ON; warning now "PF3: size not recorded. Drawn at the 600 mm placeholder size. Set its size with FEDIT."; log checklist now says FST. Tests: focused 12 of 12 passed; net48 (hosted) 0 errors.
14. **#1139 BUG-550/557 (head 6128420e) → new #1794 (head 0181c01b).** `CEMARKUPUNDO` no longer behind the switch; the guard test expects one fewer and a new test pins it; `{}` test. Tests: focused 12 of 12 passed; net48 (hosted) 0 errors.
15. **#1135 BUG-519 (head 17df5667) → new #1795 (head ec7ef8a0).** `Plugin.cs` clash resolved with the PR's two-line loop; `CE_VERSION` dropped from the full list and added to the never-names test; `{ "Diagnostics": {} }` test. Tests: focused 11 of 11 passed; net48 (hosted) 0 errors.
16. **#1146 BUG-503 S-15 (head 7bebd060) → new #1796 (head 2e01d8fe).** The three sentences are now exactly the reviewed words, with a test. Tests: focused 30 of 30 passed; net48 (hosted) 0 errors.
17. **#843 BUG-453 (head 85d74b19) → new #1797 (head c1533e67).** The lintel and roof point-load lines read as plurals; test for both. Tests: focused 14 of 14 passed; net48 (hosted) 0 errors.

## What is left

1. **Structural full suite:** run it somewhere it does not hang (or find the hanging test), once, on the six Structural branches or on the train. It stalled on the first run here; it was not compared with the bare base.
2. **Train notes, still true:** pin the new-switch defaults in the next defaults test (`pipeSpeedChecks.useMaterialLimit` OFF, `sharedValues.pitDropFollowsBox` OFF, `drainPluginOutbox` OFF, #1144 coefficient and gravity ON, #710 `linking.pasteLineForDrawingWithNoRecord` ON; Structural `AdoptAsksUnlabelledBeamKind` and `UnknownPadSizeIsNotInvented` now ship ON). Run `C60AuditSourcePinGuardTests` after every pick (it passed in every full Civil run here).
3. **For the desk (carpark lines this job may not write):**
   1. The EB-label raft fault with the switch OFF (#1157): every EB-labelled raft edge was adopted as Internal.
   2. BUG-543 remainder: the 0.61 sites (`OrificeCalcViewModel.cs`, `DetentionDesignViewModel.cs`); the carpark's "a quarter of a per cent" should read about 0.025 per cent.
   3. #1043 must drop its `CalculationsV2ViewModel.cs` hunk when #1029 lands.
   4. #954 needs the Manager version bump at assembly.
   5. BUG-069 needs a reproduction; BUG-805's "in an open PR" count is wrong; #902 is already in the base (all from the review, unchanged).
4. **Merge order cautions from the review:** #772 needs a rebase after #742; hold #1208's two pit-drop rows until #1152's name is settled; take #1144 before #1174.
5. **Tim, one question, still open:** #1204 (column in a metre drawing: convert the label and link distances too?). Not asked again here.

## Housekeeping

1. All private worktrees under `C:\ce-fx` (one per PR, plus the first run's `w742`) are removed. Scratch logs and run scripts stay in `C:\ce-fx\r2job` (mine only; nothing outside it was deleted).
2. Runner facts learned (for the next job): Civil builds need the 0-byte `CE_TRANSFORM_2027.arx` placeholder; Manager tests need TEMP and the log override written with backslashes; Structural needs a hosted restore (`-p:EnableUnifiedHostAdapters=true`) before its test project builds, and its net48 compile needs the same flag or the standalone "CE_SHARED metadata" guard fails.
