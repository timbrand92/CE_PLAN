# Opus pre-review, backlog group r5 (Structural basics): PRs #1596, #1587, #1457 and #1261

Written Monday 2 November 2026, 00:10 Melbourne, by an independent read-only Opus reviewer for CE 05 (brief written Sunday 1 November at CE 00's and CE 01's request; the file name keeps the brief's date).
Structural line checked: `claude/rel-20261026s` at 204dfad2 (Structural 1.0.125, S-45), confirmed with `git ls-remote` at the time of review.
Heads reviewed (all DRAFT, all OPEN): #1596 be6e198f, #1587 b8026c89, #1457 3feb0668, #1261 b2e56d16. Heads confirmed with `git ls-remote`.
Nothing was built, tested, installed or opened in AutoCAD by this review. I read the PR diffs, the carpark entries, Tim's 20 Oct answers, the earlier Codex review of #1457 (`CODEX_PR_REVIEW_GROUP14_24OCT.md` position 62), the code on the Structural line around each change, and ran read-only `git fetch`, `git ls-remote` and `git merge-tree` only.
One honesty note: to read the diffs I saved them to a temporary folder (`C:\ce-fx\opus_r2`) and two source copies to TEMP. I deleted all of them before writing this file. No repository file and none of Tim's settings files were touched.

## FOR TIM

1. **#1596, TH, PF, BP, column and 18 tags keep their size on paper at every scale (BUG-951): CHANGE-NEEDED, Structural FULL.** Right idea, and it works in an ordinary millimetre drawing. But in a drawing set to metres, the footing rectangle tags (THC, PFC, BTHC, BPFC and their L/R forms) would come out 1,000 times too small: a 250 mm high TH label would be drawn 0.25 mm high. The fix is small (one place converts the height twice). Must be fixed before it ships.
2. **#1587, CSREOBAR lengths on a layout read in millimetres as drawn (BUG-1025): KEEP-WITH-NOTE, Structural area + smoke.** Example: in a metre drawing, a 100 mm bar drawn on a sheet now says 100, not 100000. Bars in model space are unchanged. One small text clash with the BUG-986 plan-length fix that is already on the line; the fix is to keep both.
3. **#1457, Structural Reset Defaults asks first and keeps a copy (BUG-826): CHANGE-NEEDED, Structural area + smoke.** The question (default No) and the dated copy are good. But the question says "the settings shown in this window" go back to standard. It actually resets about 40 groups of settings, including some the window never shows (for example the CEMEMBER break overshoot). Codex found this on 24 Oct; the PR has not changed since. The Codex fix still has to be applied.
4. **#1261, the C2/SC2 column picker says "press 1 to 9" (BUG-576): KEEP, nothing to build.** This change is already in your installed Structural (it went in with 1.0.121). The PR is only still open by mistake. It should be closed, not merged again. It still needs its robot or Codex look in AutoCAD.
5. **Your 20 Oct ruling covers #1596:** "all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale". #1596 uses the existing switch (on by default). With it off, the old fixed 250, 200 and 180 heights come back exactly.
6. **Merging:** each PR clashes with the Structural line only in the change log (keep both entries). Two also have a one-place code clash: #1596 in a Settings help line, #1587 next to the BUG-986 note. In both, both sides should be kept. The PRs do not clash with each other except in the change log.
7. **No test touched your real settings.** The tests point the settings file at a temporary folder. Nobody has opened #1596, #1587 or #1457 in AutoCAD. BUG-951, BUG-1025, BUG-826 and BUG-576 all stay OPEN.
8. **Nothing here needs your decision now.** One small question may come later. When the reset in #1457 cannot save its copy, should it ask "Reset anyway?" instead of refusing? My recommendation: keep the refusal, because a reset without a copy is exactly what BUG-826 was about.

---

## DETAIL

### Group facts (apply to every PR below)

1. **Bases.** #1596 and #1587 sit one commit each on `claude/rel-20261022s2` (2c9a9694). #1457 is two commits on `claude/rel-20261017s` (9a8e5d4e). #1261 is one commit on `claude/rel-20261009y`. Every base is an ancestor of `claude/rel-20261026s`, so a merge onto 26s equals the rebase the brief asks for. #1596 and #1587 are 119 commits behind 26s; #1457 is 175 behind.
2. **#1261 is already on the line.** `git merge-base --is-ancestor b2e56d16 origin/claude/rel-20261026s` is true. It came in through "Merge commit 'b2e56d16' into claude/rel-20261017s" (e9d5bcf9). A merge-tree of #1261 onto 26s gives exactly 26s's own tree, so it changes nothing. 26s line 62 of `ColumnVisibilityPickerDialog.cs` already reads `Press 1–{Math.Min(options.Count, 9)}`.
3. **Merge-tree against 26s (read-only):**
   1. **#1596:** conflicts in `SettingsService.LoadRecovery.cs` (about line 1326) and `REGRESSION_LOG.md`. In LoadRecovery, 26s added two new lines next to the switch's help line (`Options.HatchChangeSkipsRefusedAndChangesTheRest`, `Options.InspectRunsOnReadOnlyDrawing`). The right merge takes #1596's new wording for `Layouts.TagTextFollowsLabelHeight` and keeps 26s's two new lines. This is not a literal "keep both", because the switch line itself must appear once only.
   2. **#1587:** conflicts in `ReoBarCore.cs` (about line 170) and `REGRESSION_LOG.md`. 26s added `PlanLengthLine` (BUG-986) at the same spot as #1587's `MmPerUnitInSpace`. Keep both methods, each with its own `/// <summary>` opening line. `ReoBarService.cs` merged cleanly. In the merged result the Place note (merged line 152) and the BUG-986 plan line (merged line 149) both use the new `mmPerUnit`, which is right.
   3. **#1457:** conflicts only in `REGRESSION_LOG.md`. `CeSettingsDialog.xaml.cs` and `IssuePreviewSettingsRowTests.cs` auto-merge.
   4. **Pairs inside the group:** #1596 x #1587, #1596 x #1457 and #1587 x #1457 each conflict in `REGRESSION_LOG.md` only. Keep both entries.
   5. **UserSettings.cs:** none of the four PRs touches it (as the brief says). There is no stack inside this group.
4. **What I could not verify:** I could not confirm the authors' red-then-green claims (I ran no test). Neither could I confirm the net10 pass counts or that a net48 build passes for #1596, #1587 or #1457. All three PR bodies say net48 was not built. `release-v3-colleagues-MAX_BUILD_D_REPORT.md` names #1596 and #1587 (its line 57 and line 61) but has no section on how they were tested. No report exists for #1457. Instead #1457's own change-log entry and Codex group 14 cover it.

### #1596 — BUG-951, tag heights follow the drawing scale (head be6e198f)

1. **What changes for the drafter.**
   1. 27 command lines in `Modules/Structural/Services/CeTextService.cs` (PR lines 663-780) change a bare 250, 200 or 180 to `FixedTagHeight(250|200|180)`. These are THL/THR, PFL/PFR, BPL/BPR, CL1/CR1, PCL/PCR, 18L/18R, SL/SR, DSL/DSR, TSL/TSR, 18T/18B, THC(L/R), BTHC(L/R), PFC(L/R), BPFC(L/R) and BPC(L/R).
   2. `FixedTagHeight` (PR `CeTextService.cs` about line 5483) calls `LabelTextHeightRule.TagHeight(earlier, Get25TextHeight(), switch)`. The pure rule is in `Core/Units/LabelTextHeightRule.cs` lines 16-26 of the PR, and gives label height x earlier / 250.
   3. In a millimetre drawing at DIMSCALE 50, PFL is now 125 high, not 250. On a layout sheet it is 2.5 mm, not 250 mm. At DIMSCALE 100 with the label plot height at 2.5 mm, nothing changes.
   4. **This matches the carpark** (BUG-951: "Height follows the label plot height times the drawing scale, as 25C and EBT now do"). It also matches Tim's 20 Oct answer 12 (`decisions/2026-10-20_TIM_ANSWERS.md` line 17).
   5. **Scope gap:** the carpark title also names the "setout tag heights". The PR deliberately leaves the setout, floor setout, lintel and level-carry tags alone, because they have their own Settings height. That is reasonable under R-00, but BUG-951 cannot close on this PR alone; the setout part needs its own entry or a note on BUG-951.
2. **The defect (CHANGE-NEEDED).** Metre drawings and the footing rectangle tags:
   1. THC, THCL, THCR, BTHC, BTHCL, BTHCR, PFC, PFCL, PFCR, BPFC, BPFCL and BPFCR are in `MillimetreFootingTextCommands` (26s `CeTextService.cs` lines 28-31). For these, `ExecuteCore` sets `_quickFootingUnitsPerMm` to 0.001 in a metre drawing *before* the switch (26s line 618).
   2. `FixedTagHeight(250)` is then evaluated in the switch. `Get25TextHeight` (26s lines 5484-5520) sees the converted factor and returns `FoundationService.FootingLabelTextHeight(..., 0.001)`. That is already in drawing units: 0.25 at 1:100 in a metre drawing.
   3. `ExecuteRectWithText` then converts again: `textHeight = QuickFootingDrawn(textHeight);` (26s line 1115). That gives 0.00025 m, a 0.25 mm high label. Before the PR it was 250 x 0.001 = 0.25 m, which was right at 1:100.
   4. **Failure scenario:** a drawing with INSUNITS 6 (metres), DIMSCALE 100. Run PFC, type 600x300, pick a point. The PF label is about a thousandth of the size it was before the PR. Millimetre drawings are not affected, because the factor there is 1.
   5. **Fix (pick one, then add a test):** pass the tag height in millimetres to `ExecuteRectWithText`. For example, divide `FixedTagHeight(...)` by `QuickFootingUnitsPerMm` for these twelve command lines. Or drop the `QuickFootingDrawn` on `textHeight` at line 1115 when the height already came from `Get25TextHeight`. Add a test that pins a metre-drawing rectangle tag at 1:100 to 0.25 units. BPC/BPCL/BPCR (`ExecuteColumnOverText`) and the top/bottom and angle commands do not convert again, so they are not affected.
3. **Another tag not covered.** Inside `ExecuteRectWithText` the "column over" text is still `QuickFootingDrawn(180.0)` (26s line 1308). At 1:50 the main tag shrinks to 125 while that second line stays 180. The source guard's pattern (`Height = (250|200|180)` / `textHeight: (250|200|180)`) cannot see it. Either fold it into `FixedTagHeight` (after the fix above) or record it as a separate carpark item.
4. **Settings switch.**
   1. It reuses the existing `Layouts.TagTextFollowsLabelHeight`, default true (26s `UserSettings.cs` line 1967). `LabelTextHeight.TagFollowsLabelHeight()` reads it, and an unreadable value means on (26s `LabelTextHeight.cs` lines 19-22).
   2. **Defaults test:** the default is pinned by `TagTextHeightRuleTests.cs` line 19 (`new LayoutSettings().TagTextFollowsLabelHeight` is true). I found no test that pins the default through both start-up reads (a fresh file and a file with the key missing). This is the pre-existing BUG-531 gap, not new here, but the switch now governs 27 more commands. CODEX_AUDIT_STRUCTURAL_22OCT line 107 also noted that this switch has no row on any Settings page. So the "window text owed to Codex" is the recovery help line in `SettingsService.LoadRecovery.cs` line 1323, not a visible row.
   3. **OFF restores the old behaviour exactly:** yes. `TagHeight` returns `earlierHeight` when the switch is off (PR `LabelTextHeightRule.cs` line 23), and the 27 lines then pass 250, 200 or 180 as before.
   4. **Note for the robot:** "At 1:100 nothing changes" is true only with the label plot height at 2.5 mm. If an office sets 3.5 mm, the TH tag at 1:100 becomes 350 (as EBT already does). That follows the ruling but should be stated in the change log.
   5. **R-00:** the 250/200/180 base sizes and their ratios (1, 0.8 and 0.72) stay in code. They are the old fixed sizes, re-expressed as ratios rather than new engineering values. Acceptable as presentation sizes; no new hard-coded engineering value.
5. **No-hard-blocks (R-27):** no new stop, refusal or window.
6. **Native protection and REDO:** no new database write path; heights only. The footing rectangle commands already stop on a layout tab or in REFEDIT (26s line 614). Nothing about locked layers changes. No protected file touched.
7. **Tests.**
   1. `TagHeightFollowsScaleTests` has 17 cases. 15 cover the pure rule; one is a source guard that counts 27 `FixedTagHeight(...)` calls and no bare heights.
   2. They would fail before (the method did not exist, so the file does not compile). But they would also pass with the metre-drawing defect above, because no test covers a converted drawing.
   3. The count of 27 is fragile: any new tag command will break it. That is acceptable as a guard.
   4. No test touches `%APPDATA%`: the new tests are pure or read source.
8. **Not proven / AutoCAD scenario for the robot (CE 02).** Do these on a copy, after the fix.
   1. **mm drawing, DIMSCALE 100:** PFL, 18T, CL1, THC 600x300. Heights must be 250, 180, 200 and 250 (unchanged).
   2. **DIMSCALE 50:** the same commands give 125, 90, 100 and 125.
   3. **Layout tab:** PFL gives 2.5. (THC must stop with the layout line, as before.)
   4. **Metre drawing, INSUNITS 6, DIMSCALE 100:** PFC 600x300 label 0.25; PFL label behaves as before the PR.
   5. **Switch off** (set the key in a copy of CS_Settings.json before starting AutoCAD): every tag back to 250, 200 or 180.
   6. Undo after each command removes the tag; Redo puts it back.
   7. A Codex look is owed for the recovery help line only (there is no visible row).
9. **Verdict: CHANGE-NEEDED.** Fix the double conversion for the twelve footing rectangle commands and add a metre-drawing test. Decide whether the 180 "column over" line follows too. After that: **KEEP-WITH-NOTE, Structural FULL.** It changes the output of 27 everyday tag commands for every colleague at every scale except 1:100.

### #1587 — BUG-1025, CSREOBAR lengths on a layout (head b8026c89)

1. **What changes for the drafter.**
   1. `ReoBarCore.MmPerUnitInSpace(onLayout, insunits)` (PR `Core/Rebar/ReoBarCore.cs` lines 169-176) returns 1 on a layout and the model conversion otherwise.
   2. **When drawing (Place):** `ReoBarService.cs` PR lines 138-141 decide layout or not by the current space. On a layout they skip the "units" line.
   3. **When refreshing (Refresh):** PR lines 487-489 judge each bar by the space its extent belongs to.
   4. **Result:** in a metre drawing, a 100 mm bar drawn on a sheet reads 100 in the note and in CSBARSCHEDULE. Model-space bars are unchanged.
   5. **This matches** the carpark's expected behaviour and its test (BUG-1025, extent (20,20)-(120,20) on a layout gives 100 mm, and 0.1 m in model space gives 100 mm). It also matches the rule the bar text sizes already use (26s `ReoBarService.cs` lines 906-910, `BarUnitsPerMm`).
   6. A layout with a model-space viewport active counts as model space (`CurrentSpaceId` is model space then). That is correct, because the bar then lands in model space.
2. **Settings switch:** none, and none is needed. This corrects a unit reading; it is not an engineering value. No value is hard-coded beyond "1 mm per unit on a sheet", which is AutoCAD's own sheet convention. The brief's "flag for CE 00" stands as information only.
3. **No-hard-blocks:** none added.
4. **Native protection and REDO.** The existing REFEDIT and locked-layer checks (26s merged lines 89, 160-163) are unchanged. No new write; Refresh rereads lengths only. The carpark marks ReoBar as "Protected: yes". I read every changed line: the change is limited to which conversion factor is used, and the model-space path is the same number as before.
5. **Small note.** In Refresh the units line is still added when every bar is on a layout (26s `RefreshInTransaction`, the unchanged `unitsLine` at about merged line 425). The drafter may see "this drawing is in metres..." after refreshing a sheet-only schedule. That is harmless, but it is inconsistent with Place. Optional tidy, not a blocker.
6. **Tests.**
   1. `ReoBarLayoutUnitsTests` has 4 cases (3 pure, 1 source guard). They fail before, because the method did not exist.
   2. The source guard also checks that `ReoBarCore.MmPerDrawingUnit((int)db.Insunits, out _)` no longer appears in `ReoBarService.cs`. In the merged result it still does not (merged line 905 uses `MmPerDrawingUnit(insunits, out _)`, a different text), so the guard survives the merge.
   3. No `%APPDATA%` access.
7. **Not proven / robot scenario.** Use a copy, after merging with BUG-986.
   1. Set UNITS to Meters.
   2. In a layout tab (paper space), run CSREOBAR N16 3 100 Top from 20,20 to 120,20. The note says 100.
   3. Run CSBARSCHEDULE (refresh). The row says 100.
   4. In model space, draw 0,0 to 0.1,0. It says 100 as before.
   5. Undo the layout bar, then Redo. The note comes back the same.
   6. On a locked rebar layer, the command must still refuse with the locked-layer line.
   7. No Codex window look is needed: there is no window text change.
8. **Verdict: KEEP-WITH-NOTE, Structural area + smoke.** The note is to resolve the `ReoBarCore.cs` merge by keeping both `PlanLengthLine` and `MmPerUnitInSpace`, then re-run the reo tests (as the PR body says).

### #1457 — BUG-826, Structural Reset Defaults (head 3feb0668)

1. **What changes for the drafter.**
   1. `CeSettingsDialog.xaml.cs` PR lines 459-482 change Reset Defaults to ask a Yes/No question, with No as the default answer.
   2. On Yes it saves `CS_Settings.before-reset-yyyyMMdd-HHmmss.json` beside the file (`SettingsResetPlanner.KeepCopy`, PR `SettingsResetPlanner.cs` lines 44-60). If that copy fails, it refuses with a message.
   3. It then saves `SettingsResetPlanner.BuildReset(SettingsService.Current)` (PR lines 15-41).
   4. **What carries over:** Migration, SbeamPicker, LineStyles, MarkPrefixes, CommandHub, WallSchedule, six Excel lists, the bearer span table and the Python path. Everything else is a fresh default.
   5. **Against the carpark**, which expects "An 'are you sure', a kept copy, a reset limited to what the window shows, and the migration flags kept": the question, the copy and the migration flags are done. **"Limited to what the window shows" is not done.**
2. **The older review's fix is still owed (CHANGE-NEEDED).**
   1. Codex group 14 (`CODEX_PR_REVIEW_GROUP14_24OCT.md` position 62, head 3feb0668, the same head as now) said MERGE-WITH-FIXES. It asked to clone the current settings, reset only the fields the window shows, keep hidden fields inside shown groups, pin that with a preservation test, and either reset the shown bearer table and Python setting or say plainly that they remain.
   2. The PR has had no commit since 19 Oct 20:05, so none of this is applied. The second commit ("Opus review fixes (entries 1302, 1309)") is the *earlier* Opus round, not the Codex one.
   3. **Failure scenario:** a colleague has `CeMember.BreakOvershootPaperMm` set to 2.0 (no row in the window). They press Reset Defaults and read "Put the settings shown in this window back to the standard values?". They press Yes and the overshoot silently goes back to 1.5. The same happens to every hidden switch in groups such as Layouts, Options and Install.
   4. **The question text is also inaccurate the other way.** It lists the kept items but leaves out the bearer span table and the Python path, which are kept (PR `CeSettingsDialog.xaml.cs` line 468).
   5. **What the builder must do:**
      1. Start from a deep copy of `SettingsService.Current` and put back only the fields the window shows. One way is to reuse the window's own load and save mapping: build a default draft, have the window's save code copy its shown fields onto the copy.
      2. Add the Codex preservation test: a hidden CEMEMBER value and an SBEAM favourite survive Yes, a visible Beam offset resets, and No changes nothing.
      3. Make the question's list match what is really kept.
   6. **Lighter alternative, which I do not recommend:** reword the question to say "all settings except your lists" and leave the logic as it is. That is honest, but it does not meet the carpark's "limited to what the window shows".
3. **Settings switch:** none. The PR argues that a safety question has no "today's number". I agree. This is the same class as a confirm on a destructive action, and OFF would recreate the bug.
4. **No-hard-blocks (R-27).**
   1. The Yes/No question is a modal window, but it guards a destructive one-click action that the carpark explicitly asked for. That is acceptable.
   2. The copy-failed refusal (PR lines 474-481) is a hard stop. I recommend keeping it, because resetting without a copy is the harm BUG-826 describes. This is listed for Tim at item 8 as optional, not as a required change.
   3. **Edge case:** `File.Copy(..., overwrite: false)` makes a second reset inside the same second fail with "nothing was reset". That is harmless and rare; note only.
5. **Native protection and REDO:** not a drawing command; no drawing change; nothing to undo. No protected file touched.
6. **Tests.**
   1. `Bug826SettingsResetTests` has 7 cases. Its window test is a source check; there is no compile-before test of the planner.
   2. One new window test answers No, and two existing window tests now answer Yes through `ConfirmResetForTests`.
   3. **Fail before:** the planner and seam did not exist, so the tests would not compile. The change log's "4 of 7 failed" cannot be checked from the diff.
   4. **Real `%APPDATA%`:** none touched by the code. `IssuePreviewSettingsRowTests` points `_settingsFilePath` at `%TEMP%\ce-settings-issue-<guid>` and sets `_initialized` (lines 27-41). `StructuralWindowRenderTests` sets `_initialized` in SetUp (lines 31-47) and the path to the test work folder (line 208). `KeepCopy` tests use `%TEMP%`. So the Yes path's dated copy lands in temporary folders, not beside Tim's file.
   5. **Missing:** the preservation test above.
7. **Not proven / robot scenario.** Use a copy of the profile, with settings set before AutoCAD starts.
   1. Star an SBEAM favourite and set `CeMember.BreakOvershootPaperMm` to 2.0 in the copy's CS_Settings.json.
   2. Run CESETTINGS, change Beam large offset, press Reset Defaults, then press No (or Esc). Nothing changes and no before-reset file appears.
   3. Press Reset Defaults again and pick Yes. The offset is back to standard, the favourite is still there, the overshoot is still 2.0 (after the fix), and `CS_Settings.before-reset-*.json` sits beside the file.
   4. **Codex look:** the question's wording, dark and light themes, and that No is the button Enter presses.
8. **Verdict: CHANGE-NEEDED.** Apply the Codex group 14 fix and test, and correct the question's list. Then: **KEEP-WITH-NOTE, Structural area + smoke**, plus the Settings window tests, because Settings is pilot-critical.

### #1261 — BUG-576, column picker "press 1 to 9" (head b2e56d16)

1. **What changes for the drafter.** `ColumnVisibilityPickerDialog.cs` line 62 now says "Press 1–9" when nine choices exist (capped at nine). Key 9 already worked. This matches the carpark. It is wording only, no Settings value, and no R-27, protection or REDO question.
2. **Already shipped.** The commit is an ancestor of `claude/rel-20261026s`, through e9d5bcf9 on S-38. The carpark says "fix installed in Structural 1.0.121 via PR #1261". A merge-tree onto 26s changes nothing.
3. **Tests:** none added; the author argued for that in the change log. A caption has low risk. No `%APPDATA%` concern.
4. **Not proven:** the installed window has not been looked at.
   1. **Robot or Codex:** run C2, then SC2 on an owned support.
   2. Read all nine choices and "Press 1–9".
   3. Press 9 then Enter: 250x90 PFC is chosen.
   4. Reopen and press Cancel or Escape: the support is unchanged.
   5. Check both dark and light appearance.
5. **Verdict: KEEP, no train needed.** Close the PR as already merged. Do not merge it again. BUG-576 stays OPEN until the robot or Codex look above passes.
