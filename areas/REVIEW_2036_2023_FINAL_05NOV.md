# Final recheck: PR 2036 `772f37e4` and PR 2023 `7b3fe32b` (Thu 5 Nov 2026, Melbourne)

Opus reviewer, Max account. Read only: fetched origin and read the two commits (both are their branch tips). No build, no tests, no AutoCAD, nothing pushed.

## FOR TIM

1. **PR 2036 (Civil OFF): GO.** Yes then Cancel, Escape, a closed window or a refusal now leaves the drawing as it is: no pit block swap, no "current" stamp, and the question comes back next open.
2. **One window now.** The older-project question lists what Yes will change. Yes goes straight to Upgrade, with no second OK/Cancel window. Merge or Replace is still asked on the command line every time.
3. **Moving a pit in an OFF drawing** no longer drags its pipes and labels along, and pipe vertex grips show as normal.
4. **PR 2023 (Pit Schedule): GO.** An XREF schedule now shows the "read-only" header, the "edit in the source drawing using Open" line and the left-out line together.
5. **Not proven:** nothing has been run in AutoCAD. Most of the Yes-then-Cancel proof comes from checks that read the program text, not from a real drawing.
6. **Known limits** are listed at the end. None of them blocks a draft.

## PR 2036 CIVIL-OFF-ALL `772f37e4`: GO

1. **Priority 1, Yes then Cancel leaves the drawing as it is: PASS.**
   1. `UpgradeDrawingCommand.cs` lines 41 to 62: the command reads `IsUpgradeFromOpenQuestionQueued` when it starts. Its `finally` block calls `LeaveAsItIsAfterCancelledUpgrade` whenever `_upgradeFinished` is false, and `_upgradeFinished` becomes true only when the stamp is written (about line 195) or there is nothing to upgrade (about line 124). So every early return is covered: the switch is off, the drawing protections fail, the "cannot run" reasons, Cancel or Escape at Merge/Replace, no backup, a pipe refusal, and an exception.
   2. `OldProjectOpenPrompt.cs` `LeaveAsItIsAfterCancelledUpgrade` (about lines 169 to 179) does four things: `MarkLeftAsItIs`, then `CivilOffHeldUntilSave.Hold`, then `ReevaluateCivilActivity`, then the "left as it is" line. `DrawingDisciplineService.cs` about line 319 reads a held drawing as Off. That sets `state.CivilOff`, so `OldProjectStampStore.StampInRecordWrite` (line 117, the `LinkService.IsCivilOff(db)` check) returns before it writes anything. Pit swap: `WasLeftAsItIs` is now set, and `IsOpenPassPending` also covers `UpgradeQueued` (`PipeObjectUpgradeOnOpenService.cs` about line 118). So the swap waits from Yes until the command ends, which closes the earlier timing risk.
   3. If the command cannot be sent, `EndUpgradeFromOpenQuestion` runs in the catch (about line 226).
2. **Priority 2, one window: PASS.** `AskUser(doc)` (`OldProjectOpenPrompt.cs` about lines 200 to 212) shows `OpenQuestionText`: the backup name, the pipes that become objects, the pipes that get an identity, the pits in the record, the locked-layer and Xref note, and what each button does. It shows this only when both switches are on and the counts can be read. Otherwise it shows the short question. `RunUpgrade` skips `Show(preview, true)` when `fromOpenQuestion` is true (about line 130). Merge/Replace stays on the command line only.
3. **Priority 3, OFF pit move and grips: PASS.** `CompoundTransformOverrule.cs` line 74 has `if (LinkService.IsCivilOff(entity.Database)) return;` after the recursion guard. Since `base.TransformBy` runs first, the pit itself still moves. `CompoundGripOverrule.cs` lines 69 and 91: both `GetGripPoints` overloads fall through to `base` when the drawing is OFF.
4. **Priority 5, switches, BOM, CE_SHARED, net48: PASS.** No new switch was added. `pitSwapWaitsForOlderProjectAnswer` and `yesRunsWholeDrawingUpgrade` are still on by default. With either switch off, the old short question and the old route come back (the gate at about line 203). `Modules/Drainage/Models/UserSettings.cs` still starts with EF BB BF. No file under `Shared/` changed. The code is net48-safe: `ConditionalWeakTable.TryGetValue(out _)`, `Remove` and `Add` are all available there.
5. **The tests are mostly source-text guards.** In `CivilOffAllFixFirstTests.cs`, only two kinds of test check behaviour: the question-text test (`OpenQuestionText`) and the `ShouldLeaveAsItIsAfterUpgradeFlow` decision. The following tests only read program text with `File.ReadAllText`, so they prove the wiring is there, not what it does in a drawing:
   1. Yes skips the second window.
   2. `IsOpenPassPending` covers `UpgradeQueued`.
   3. The `finally` block marks the drawing left as it is.
   4. `LeaveAsItIsAfterCancelledUpgrade` holds the drawing OFF.
   5. `StampInRecordWrite` skips an OFF drawing.
   6. `TransformBy` returns early when OFF.
   7. Both grip overloads fall through when OFF.

## PR 2023 B-1274 `7b3fe32b`: GO

1. **Priority 4, header and left-out line together: PASS.** `PitScheduleViewModel.Data.cs` lines 906 to 913: `ApplyLeftOutNoticeForSources` always puts the notice in front: `notice + " | " + headline` and `notice + "\n\n" + detail` (both are real escapes). When nothing is left out it returns early, so the XREF header is untouched.
2. **Switch: PASS.** `PitScheduleSaysWhatItLeavesOut` is `= true` (`UserSettings.cs` line 2704). When it is off, `BuildLeftOutNotice` returns empty, so nothing changes. `UserSettings.cs` is not touched and keeps its BOM. `Shared/` is not touched.
3. **The two new tests check behaviour, but through the test seam** `LoadPreFlightForTest`, not through `LoadFromSelectedXrefs` or the window. That is acceptable for a draft.

## KNOWN LIMITS (for the PR descriptions)

1. **2036:** nothing has been run in AutoCAD. Not yet seen in a real drawing: the focus of the message box at Idle, the order of the queued command and Idle, and how the longer question looks.
2. **2036:** a stopped upgrade can come after real changes. If the upgrade stops after the backup and the pipe step (for example the record step does not finish, or an error part-way through), the drawing has changed but is still marked "left as it is". The pipes may already be pipe objects and the backup is saved. Civil is held OFF and the question comes back next open, but the words "left as it is" are not strictly true in that case.
3. **2036:** a stamp could be written while Upgrade is queued. Between Yes and the moment the queued Upgrade starts, Civil is still active. If a CE record save happens in that short gap, it could stamp the drawing before a later Cancel. This was not traced. If the queued command never starts at all, the pit swap waits for the rest of the session, which is safe, but no OFF hold is set.
4. **2036:** with the "hold OFF until save" switch turned off, Yes then Cancel does not hold the drawing OFF. The next record save can then stamp it current. That is the old behaviour, which is what switching off is meant to restore.
5. **2036:** if the counts cannot be read, the short question is shown, and Yes still skips the second window, so the list was never seen. On an AutoCAD without the pipe-object part, Upgrade then refuses and the drawing is left as it is.
6. **2036:** Merge/Replace is asked every time, even when CE's record has no pits. Defaulting it to Merge from the open question is still Tim's call.
7. **2036:** the greyed ribbon and the toggle are not built (they need a CE_SHARED change). `LinkCommands.cs` still has no UTF-8 BOM, which is harmless. `InspectorPaletteService` writing into an OFF drawing from an Inspector that is already open has not been traced.
8. **2036:** the one net48 test that fails (`TheBannerSwitch_FollowsTheSetting_AndPutsItBack`) is very likely a fault in the AutoCAD test stub only. That has not been proven by running it on slice 3 alone. net10 and net8 have not been built.
9. **2023:** the tests go through the test seam, not the real XREF load or the window. The pit schedule header has not been rendered in the real window. A long list of non-consecutive pits in the header has no length limit. The XREF banner now shows as an issue whenever pits are left out.
