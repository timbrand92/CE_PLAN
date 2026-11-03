# Opus pre-review: draft PRs B-179 to B-186 (Civil, six bug fixes)

Written Monday 2 November 2026, about 11:05 pm Melbourne time (PC clock), by a read-only Opus reviewer for CE 05 on the CE 00 order of 20:45 (deep queue to Tue 08:30).

**What I read:** `C:\TimOS\RULES.md`; `git fetch origin` first (clean); the six PR diffs (`gh pr diff`, `git show`); the base code each one calls; `BUG_CARPARK.md` for BUG-1046's scope; the 3 Nov reports to find B-180 and B-181. I ran read-only `git merge-base --is-ancestor` and `git merge-tree` checks.
**Built:** nothing. **Tested:** nothing. **Opened in AutoCAD:** nothing. I did not read or write Tim's real settings files.
**NOT proven:** every claim about behaviour comes from reading code. The authors' test counts are their own; I did not re-run them.

Output path note: the order named `C:\CE_PLANreas\...`. That folder does not exist; I read it as `C:\CE_PLAN\areas\` (a lost backslash), as the earlier pre-review did.

---

## FOR TIM

1. **None of the six is in what you have installed.** Civil 3.0.89 (61fd6fbc) has none of them. Neither do the next two builds (3.0.90 at cf059dcf, and rel-20261110a at aa3b92ac). Checked with git after a fresh fetch.
2. **B-179, orifice detail "HIGH" and orifice size: GO.** The baffle height now measures from the orifice, not the outlet pipe. Bayside example: 420 HIGH, not 670. A 55.6 mm orifice now prints 55, never 56, so the permitted discharge is never beaten. You will see nothing yet: no command draws this detail today.
3. **B-182, AG drain grade "1:50" on the plan: GO, with one gap you should know.** CDAGI now writes "1:50" under the longest leg. But the text is not tied to the drain. If you MOVE or ERASE the drain, the "1:50" stays behind. I have listed that for the bug list.
4. **B-183, labels you move with CE's own grips stay put on Tidy labels: GO.** Slide along pipe, Move away, Flip side, CDANNOTATIONEDIT and the pit cover-text flip now count as "placed by hand". Only matters if "hand-placed labels stay" is ticked.
5. **B-184, Edit Pipe, Edit Pit, New Pit and Settings reopen where you left them: GO.** Only when "Remember where windows were last left" is ticked (it ships unticked). Position only; the size never changes.
6. **B-185, loading the pipe object enabler mid-session now works without a restart: GO.** Type ARX, Load the .dbx, then CDPIPEOBJ works straight away. Not proven in real AutoCAD; the robot case is written for it.
7. **B-186, CDPARTS and CDLABELSTYLE open on a layout sheet: FIX FIRST (two minutes).** It also lets the Design Check dashboard open on a sheet. There, "Show in drawing" would zoom the sheet off to the pit's model position and the sheet goes blank. Take the dashboard out of that list, then GO.
8. **B-180 and B-181 have no PR.** B-180's fix is already draft #1972, which is in both candidate builds. B-181 was never used. Nobody has seen any of the six in AutoCAD; no bug is fixed.

---

## THE SIX CHECKS, PER PR

The checks from the order:
- switch ON by default
- OFF restores the old behaviour
- the default is tested through both start-up reads (`DeserializeSettings` and `DeserializeSettingsTolerant`)
- no CE_SHARED change
- no unlock of locked layers, no Xref or REFEDIT touch
- one normal commit, with a title that starts with the B-number

All six PRs are one commit each, sit directly on `claude/rel-20261102a` at 3fbb9da5, none stacked. None changes a file under `Shared/`. Every PR title starts with its B-number.

1. **#2000 B-179 BUG-806 (head bb594ff4):** all six pass.
2. **#2001 B-182 BUG-648 (head 90037740):** all six pass. The commit's own first line reads "BUG-648: AG drain draws..." with no B-number. Optional reword; not a blocker.
3. **#2002 B-183 BUG-879 (head 229f354a):** all six pass. Commit first line "BUG-879: ..." has no B-number. Optional reword.
4. **#2003 B-184 BUG-958 (head ea5b215b):** all six pass.
5. **#2004 B-185 BUG-1018 (head 6dce9df9):** all six pass. Commit first line "BUG-1018: ..." has no B-number. Optional reword.
6. **#2005 B-186 BUG-1046 (head abe5d2b9):** five pass. The REFEDIT item needs care: the PR switches OFF CE's own REFEDIT refusal for CDPARTS and CDLABELSTYLE. I checked both. They save to office files only (`label_styles.json`, the parts catalogue), never to the drawing. So no REFEDIT content is touched. The fault is a different one (below). Commit first line "BUG-1046: ..." has no B-number. Optional reword.

Clashes: each PR merges cleanly into 3.0.89 (61fd6fbc) and into rel-20261110a (aa3b92ac) in the code. Five of the six clash only in `REGRESSION_LOG.md` (all at the top; keep both). #2004 merges with no clash at all.

---

## DETAIL

### PR #2000, B-179 BUG-806: orifice detail head from the orifice IL, orifice never rounded up. GO

1. **What changes.** `Services/OrificeDetailFieldMap.cs` `Build`: the "HIGH" callout is top water level minus the orifice invert (was minus the outlet pipe invert). The orifice diameter is cut down to the whole millimetre (`Math.Floor(d + 0.000001)`), so 55.6 gives 55 and a 56.0 stored as 55.9999999 stays 56.
2. **Datum is right.** `OrificeInvertM` is documented in `Models/OrificeDetailModels.cs` line 82 as "RL of orifice centreline", which matches the rulebook's "top of baffle wall to centre of orifice".
3. **Switch.** `detention.orificeDetailHeadFromOrificeIl`, ON. OFF = outlet-invert head and round-to-nearest, pinned by `Off_EarlierBehaviourReturnsExactly` (670, 56). Both reads pinned in `SwitchShipsOn_ThroughBothStartUpReads`. The old 670/57/680/50 tests in `OrificeDetailFieldMapTests` now pass `headFromOrificeIl: false`. I checked the untouched old tests: none asserts a head or a rounded diameter on the default path, so the new default does not break them.
4. **No drawing effect yet.** The log says "the mapper has no live caller". Strictly, `Services/OrificeStandardDetailDrafter.cs` lines 100 and 235 call it, but nothing outside the services calls that drafter. So the claim holds one step out. Wording only.
5. **Open, for Tim (already in the report):** which level the `PIT_IL_CENTRE` tag should carry. Engineering call; not this PR's job.

### PR #2001, B-182 BUG-648: AG drain draws its 1:N grade text. GO, gap recorded

1. **What changes.** CDAGI Accept adds one MText "1:50" (or "1:50 rising") in the same transaction as the drain, so one U removes both. Placed at the middle of the longest leg, below the line, turned to read left to right, at the drain-tag text height, on the drain's own layer. Flat or skipped levels draw nothing. Read-back check added in `AgiCommand.Apply.cs` (lines 267-274 of the head).
2. **Text matches the grade line.** The two patterns in `AgiCommand.GradeLabel.cs` match the base wording in `AgiCommand.GradeDirection.cs` line 60 ("(1:N rising)") and the "1:N — " lead. Pinned by the carpark, below-minimum and rising tests.
3. **Switch.** `surface.agDrainGradeLabel`, ON. OFF returns null from `BuildGradeLabel`, so nothing is appended and the read-back is skipped: the old drawing exactly. Both reads pinned.
4. **The gap (not a blocker, but Tim should know).** The text is a loose MText, not linked to the drain the way the PD tag is (BUG-236). MOVE, COPY or ERASE the drain and the "1:50" is left behind. The PR says so in its log item 5. **Carpark entry suggested:** "BUG-648 follow-up: AG drain grade text does not follow MOVE/COPY/ERASE of its drain."
5. **Locked layer.** It adds to the same layer as the polyline, after the same lock check; no new unlock.
6. Cosmetic: the log entry has no blank line before the next `## C-78` heading.

### PR #2002, B-183 BUG-879: CE's own label moves mark the label "placed by hand". GO

1. **What changes.** With "hand-placed labels stay" ON and the new switch ON:
   - The grip actions mark the label in the write they already do (`LinkService.PipeAttachmentActions.cs`, the new `else if` after Reset Position). The action list has only four kinds (Slide, Offset, Flip, Reset), so only real moves are marked. Reset still clears the mark.
   - CDANNOTATIONEDIT marks only when Move, Rotate, Mirror or Flip really changed the label. A cancelled prompt or a locked layer returns false and marks nothing (`ApplyTransform` now returns whether it moved).
   - The pit cover-text flip grip stores `coverTextPlacedByHand` on the pit record in the same project-record write. `PlanOnePitCoverText` then offers no new spot for it.
2. **Switch.** `linking.ceMovesMarkHandPlaced`, ON. OFF: `MarksOnCeMove` is false everywhere, and Tidy ignores any stored pit mark (`&& CeMovesMarkEnabled()`): the old behaviour. Both reads pinned.
3. **Locked layers.** Still `OpenForWriteUnlessLocked`; nothing is unlocked.
4. **Small note.** The new pit field is always written, so every saved project record gains `"coverTextPlacedByHand": false` even with the switch OFF. The project-record reader ignores unknown fields (no `MissingMemberHandling` set), so older builds still read it. Harmless.

### PR #2003, B-184 BUG-958: fitted windows remember where they were left. GO

1. **What changes.** CE's two screen fits (`WindowSizingService.TryFitTabbedEditor` and `FitWorkshopFallback`) now record the window in a weak table (`MarkFittedByCe`). The placement hook, which skipped every "Manual" window, now puts back the position (never the size) for a window CE itself fitted (`PlanForFitted`).
2. **Timing checked.** The fits run in `OnSourceInitialized` (Settings, `AdvancedSettingsDialog.xaml.cs` line 102; Pipe workshop, `PipeEditWorkshopDialog.xaml.cs` line 96) or before the window is shown (`DialogService.PrepareWorkshopFallback`). The hook runs on Loaded, which comes later. So the mark is there when the hook looks.
3. **Switch.** `windowPlacement.rememberFittedWindows`, ON, but it does nothing while `windowPlacement.remember` is OFF, which is still the shipped default. OFF = the plan is returned unchanged. Both reads pinned.
4. **Note.** New Pipe and Edit Pipe are the same window type, so they share one remembered spot. Expected, not a fault.

### PR #2004, B-185 BUG-1018: enabler "not loaded" answer is not kept for the session. GO

1. **What changes.** `CeCvlObjectsBridge.IsAvailable` keeps a "yes" and keeps an "old version" answer. A "not loaded" answer (DllNotFound, EntryPointNotFound, BadImageFormat) is now looked at again, at most once a second. One log line when it later loads.
2. **Switch.** `options.pipeObjectEnablerRetryWhenNotLoaded`, ON. OFF returns the first cached answer, exactly as before. Both reads pinned. A settings read that throws counts as ON.
3. **NOT proven, and it matters here.** The tests replace the native version call with a stand-in. Whether .NET really tries the DLL again after a first "not found" can only be shown in AutoCAD 2027. I believe it does (a failed native lookup is not cached), but I have not proven it. The robot case `B185_enabler_late_load` in the PR log is the real check.
4. **Small note.** The log entry was added at the BOTTOM of `REGRESSION_LOG.md` (after line 47712), not the top like the other five. The file has other entries at the bottom, so not a blocker. Moving it to the top would match.

### PR #2005, B-186 BUG-1046: office windows open on a layout sheet and during REFEDIT. FIX FIRST

1. **What changes.** `Services/DrawingSafetyService.cs`: a new list `OpenAnywhereCommands` (head line 62-63) of CDPARTS, CDLABELSTYLE, CDDIAG, CDDASHBOARD. For those, with `options.officeEditorsOpenAnywhere` ON, the REFEDIT refusal (line 94) and the paper-space refusal (line 120) are skipped. Every placing command keeps both.
2. **CDPARTS and CDLABELSTYLE are safe.** Neither window places anything. Label styles save to `label_styles.json`; the parts dialog has no insert or place action. This is exactly BUG-1046 as carparked ("CDPARTS and CDLABELSTYLE refuse to open on a layout sheet or during REFEDIT").
3. **CDDIAG is safe.** It is a stub that prints two lines. It was already allowed during REFEDIT.
4. **The fault: CDDASHBOARD on a layout sheet.** CDDASHBOARD was already allowed during REFEDIT (base `ReadOnlyCommands`), so the only new thing is paper space. The dashboard's "Show in drawing" and row click go through `CeZoomHighlightService` to `DrawingService.ZoomToEntityWithPadding`, which zooms to the pit's model coordinates with no check for paper space. On a layout with no viewport active, the sheet's own view jumps to, say, E 320000 N 5810000: the title block disappears and the drafter sees a blank sheet. "Back" fixes it, but it looks broken. This was not in BUG-1046.
5. **Fix (two minutes).** At `Modules/Drainage/Services/DrawingSafetyService.cs` line 63, remove `"CDDASHBOARD"` from `OpenAnywhereCommands`. In `Modules/Drainage.Tests/Services/Bug1046OfficeEditorsOpenAnywhereTests.cs` line 26, drop `[TestCase("CDDASHBOARD")]` (or move it to the "still refused on a sheet" cases). Update the summary in `UserSettings.cs` and the log heading to name three windows. Then GO. Letting the dashboard open on a sheet can come back later as its own item, once "Show in drawing" knows about layouts.
6. **Switch.** ON; OFF = the old refusals exactly. Both reads pinned.

---

## SKIPPED, AND WHY

1. **B-180 (w658, BUG-658):** no PR. The fix is the existing draft #1972 (B-119), already inside both candidate builds, not inside 3.0.89. Not a new look from this batch.
2. **B-181:** no job, PR or report uses this number.
3. **Building and running the tests:** the order forbids it. Every test count above is the PR author's claim.
4. **Real AutoCAD checks:** none run. The checklists in each PR's log entry stand; I did not run them.
5. **Clock note:** the six commits carry times of 08:28 to 09:42 on Tue 3 Nov (+11:00), ahead of this PC's clock (Mon 2 Nov, about 11 pm). Recorded only; it does not change any verdict.
