# B-031 (BUG-1228 follow-up): why PIT is slow. Read-only diagnosis and draft fix plan (Thu 29 Oct 2026, about 16:26 to 16:45 Melbourne)

Job: CE 01 Build, build number B-043a, register line **B-031**. Read only: no dotnet, no build, no worktree, no branch, no PR. Code read on `origin/claude/rel-20261026z` (Civil 3.0.85, `09126560`); line numbers are checked to be the same on the C-76 train `origin/claude/rel-20261029a` (Civil 3.0.86, `5888ee75`, which holds B-004 / PR #1837), except where two numbers are given. Evidence: Tim's CE log `%APPDATA%\CE_CVL_SUITE\logs\ce_cvl_structured_20261029.log` (read only), robot reports in `areas\runner-reports`, and the B-004 report `areas\release-v3-colleagues-BUG1228_FIX_REPORT.md`.

## ANSWER FIRST

**FOR TIM**

1. **What is slow:** after each pit goes in (straight after you place the cover text), CE re-checks every pipe in the drawing to see which pit or source sits at each end. That covers every pipe, not only the pipes near the new pit. For each pipe it looks through every object in the drawing six times.
2. **How long it takes, measured:** CE's own timer in your log says about 56 thousandths of a second per pipe.
   1. The robot's test drawing has 49 pipes, so about 3 seconds per pit.
   2. Your drawing this morning had 50 pipes: 3.2 seconds per pit (10:05).
   3. A real job with 150 pipes and a fuller drawing would take roughly ten times longer, so about 30 to 40 seconds per pit. That is my estimate from the arithmetic; nobody has measured it.
3. **Why the downpipe fix does not help PIT:** the DP fix (B-004, PR #1837, in the 3.0.86 build going in tonight) makes CE look at each object once. It only switches that on inside the downpipe's own reading step. PIT's pipe re-check runs the old way.
4. **Second cause, once per drawing:** the first PIT after a drawing's pit and pipe list has gone missing rebuilds it before the "Specify pit insertion point" prompt. That took **10.1 seconds** on your drawing at 10:00 this morning. It only happens once; the PITs after it skip it.
5. **Third cause, DP and the other sources:** after a downpipe, overflow or other source is placed, CE runs the same whole-drawing pipe re-check. B-004 does not cover that either, so a downpipe on 3.0.86 may still take about 3 seconds more than it needs to.
6. **What is NOT slow (checked in your log):**
   1. the New Pit window opening, about 1 to 2 seconds on your drawing;
   2. the check for a pipe under the pit;
   3. the label and cover text;
   4. the Pit Schedule refresh, 0.1 to 0.2 seconds.
7. **The robot's "PIT took 50 to 60 seconds" is mostly the robot waiting.** Your own pits this morning took 16 to 17 seconds each from typing PIT to the end, including your own clicks. About 4 to 5 seconds of that was CE working.
8. **My recommended fix (planned, not built):** give the pipe re-check the same "look at each object once" memory that B-004 gave the downpipe. It sits behind a new Settings switch, ON by default. The pit and pipe joins come out exactly the same; only the time changes. I expect about 3 seconds to drop below 1 second, but that is not measured. Full plan below.
9. **My mistake, first:** I first counted the robot's 28-second gap between the label prompt and the pipe check as CE time. Your own runs show the same gap is about 5 seconds including your two clicks, so most of it is the robot. I corrected this before writing; it cost about 10 minutes and no runs.
10. **Not proven:** nothing here has been run in AutoCAD. The 56 thousandths of a second per pipe and the 3 seconds are measured from your log. The cause comes from reading the code. How much the fix saves is an estimate.
11. **Robot case to prove the fix:** N41_pit_time, with a switch-off twin C41_pit_time_switch_off. CE 02 confirms the free number. Details in section 5.

---

## 1. Where the time goes in one PIT (log timeline)

1. **Robot run, robot test drawing (49 pipes, about 1,083 objects), Civil 3.0.85, 06:02 to 06:03 (`Command outcome: PIT completed 56873 ms`):**
   1. 06:02:02.485: `EnsureDrawingDataCurrent: 29.0 ms ran fully` (before the point prompt).
   2. 02.841 to 24.798: point pick, New Pit window, robot presses Save (two block-file resolves at 02.841 and 19.215; the 16 s between them is the robot filling the window).
   3. 24.838 to 24.886: pit block inserted, `Pit added: P8`, identity given, PIT LABEL block loaded. All in about 50 ms.
   4. 24.886 to 52.751: label prompt (robot Esc), cover text prompt (robot Esc), then the pipe split check (`PIT auto inline split (0) ... considered=49`). Mostly robot (see item 2.3).
   5. **52.751 to 55.699: the pipe re-check, 2.95 s.** It logs `Pipe endpoints updated` for 28 pipes and `Project data saved to DWG` about every fifth pipe.
   6. 55.7 to 59.3: "Pick the next pit" prompt, robot Esc, command end.
2. **Tim's own PITs, his drawing (50 pipes), Civil 3.0.85:**
   1. 10:18:19.42: `EnsureDrawingDataCurrent: 51.2 ms ran fully`. Point pick, then the window at about 20.6. Save pressed, pit in at 24.04.
   2. 24.095 to 29.588 (5.5 s): his label click, cover text click and the split check.
   3. 29.588 to 36.871 (7.3 s): the pipe re-check (no ends changed, so no `updated` lines), the "Pick the next pit" prompt and his next click. **The re-check alone: 10:05:12.833 to 10:05:16.000 = 3.2 s for 50 pipes** (the 10:05 pit, where ends were rewritten).
   4. In the carry-on run the next New Pit window opened about 1.5 s after his click (36.87 to 38.33).
   5. `PIT completed 17504 ms` and `16016 ms`: about 4 to 5 s of each is CE.
3. **Per-pipe cost, measured by CE's own timer:** the same per-pipe step is timed when it runs at a command end, as `[PERF] LinkService.ApplyPipeUpdates.LinksFromGeometry`. It shows **54 to 66 ms per pipe** (01:07:22 to 01:07:24, 49 pipes, `ApplyPendingLinkUpdates.PipeUpdates: 2843.5 ms count=49`). It was seen again at 02:07 (3,067 ms), 06:20 (2,891 ms, 50 pipes) and 06:36 (2,908 ms).
4. **The 10-second first PIT:** 10:00:16.069 `ProjectDataService.EnsureDrawingDataCurrent.MergeMissingEntitiesFromDrawing: 10119.0 ms`, `Merged missing drawing entities into project data: pits=12, pipes=50`. Each pipe was relinked and the record saved after every pipe (09:59 to 10:00:09.9), then 6 s more to the end of the merge.

## 2. The cause, with file and line

**Cause 1 (main, every pit): PIT's whole-drawing pipe re-check reads every object six times per pipe, with no memory.**

1. `Modules/Drainage/Commands/PitCommand.cs` line 583. After every pit, `InsertAndLinkPit` runs `LinkService.RelinkAllPipeEndpoints(relinkTr)` in one transaction. The PERF-003 comment at lines 573 to 580 already notes this costs about 1.85 s for 49 pipes. That figure dates from before the B-004-era owner checks; it is about 3 s now.
2. `Modules/Drainage/Services/LinkService.Geometry.cs` lines 930 to 966: `RelinkPipeEndpoints(tr, null)` calls `UpdatePipeLinksFromGeometry(db, pipeId, tr)` (line 216) for **every** pipe in the record.
3. Per pipe (`UpdatePipeLinksFromGeometry`, lines 216 to 330), with `context == null`:
   1. `ResolvePipeEndpointOwners` (line 231) leads to `ResolveOwnerAtEndpoint` and then `FindOwnerAtPoint` (line 1217) for **each end**. Each call walks all of model space twice:
      1. `FindBestPitOwnerAtPoint` (line 1265, `model.Cast<ObjectId>()` at about line 1274). For each object: `TryGetBlockReference`, `IsPitBlock` (the effective-name read, a dynamic block's definition opened), and for a pit `ReadPitOutline` (dynamic properties) plus `WasPitLinkedToPipeEnd` (parses the pit's link JSON).
      2. `FindBestTaggedOwnerAtPoint` (line 1358 on 3.0.85, 1385 on 3.0.86). For each object: the source tag, `RequireSourcePitAssociation`, the saved connection, and `GeometricExtents` when the end is outside the circle.
   2. `TryApplySamePitEndpointFix` (line 1086): two more source walks, only when both ends land on the same pit.
   3. `RemovePipeLinksFromAllOwners` (line 1501 on 3.0.85, 1575 on 3.0.86), called twice (lines 250 and 251, once per end). Each call walks all of model space again. Every block is opened, `IsPitBlock` and `SourceTagService.HasTag` are run, and the link record is read with `ReadPitLinkDataForScan`. The record is then written back with `WritePitLinkData` when this pipe was listed, which is every pit or source the pipe is joined to, on every pit placement.
   4. So one pipe is 6 whole-drawing walks: 49 pipes x 6 x about 1,083 objects, about 320,000 object opens per pit. That is consistent with the measured 56 ms per pipe.
4. **Why B-004 does not reach it:** on 3.0.86 the walks take their memo from the read context: `context?.PitWalk ?? new OwnerScanMemo<...>(false)` (Geometry.cs lines 1285 and 1403 on `rel-20261029a`). The memo is switched on only by `BuildCompleteSourceLandingIndex` and `CaptureSourceChangeDrawing`, and a test pins that those two are the only callers. PIT's re-check passes `context == null`, so its memo is always OFF, and `RemovePipeLinksFromAllOwners` has no memo at all.

**Cause 2 (second, once per drawing): the first PIT rebuilds a missing pit and pipe list before the point prompt.**

1. `PitCommand.cs` line 111: `ProjectDataService.EnsureDrawingDataCurrent(doc.Database)`.
2. `ProjectDataService.cs` line 664: `MergeMissingEntitiesFromDrawing(db)`. When pits or pipes are missing from the record, line 772 runs `LinkService.RelinkAllPipesToPits(db)` and then `UpdatePipeEndpointsFromProjectData(db)`. That relinks each pipe through the same owner walks and saves the record after each pipe. 10.1 s for 50 pipes this morning.
3. It runs once: the next PITs on the same drawing are 30 to 70 ms (`ran fully`) or 0.1 ms (`short-circuited`). It is not why every pit feels slow, but it is why the first one can feel very slow.

**Cause 3 (third, the same walk in other places): the same per-pipe re-check after sources and at some command ends.**

1. `SourcePlacementService.cs` lines 1308, 1453 and 1488 (3.0.86) call `LinkService.RelinkAllPipeEndpoints()`. This is the public form, with one transaction per pipe and no memo. So DP, OF and the other sources pay about 3 s on top of the four landing reads B-004 sped up. When N36 measures DP on 3.0.86, part of what remains will be this.
2. `SourceBlockInsertCommands.cs` line 397, `SourceTagCommand.cs` lines 386 and 481, and `XcivilImportService.cs` lines 1270 and 1375 also call the full re-check.
3. Command-end catch-up: `LinkService.PipeUpdates.cs` line 178 times `UpdatePipeLinksFromGeometry` per queued pipe (the 2.8 to 3.1 s `PipeUpdates count=49/50` lines). PIT's own command end was 7.9 ms at 10:18, so this is not on PIT's path today.

**Checked and NOT the cause:**

1. The pipe split check, `LinkService.Split.cs` `TryFindInlineSplitCandidate`, line 272: one model walk per pit, not per pipe.
2. The hitbox overlap check at `PitCommand.cs` line 320.
3. The pit and label block reloads (about 10 to 20 ms each in the log).
4. `ProjectDataService.SaveToDrawing`: 2 to 25 ms.
5. `ScheduleLinkService.RefreshLinkedCells`: 87 to 175 ms.
6. The New Pit window and its plan preview: about 1 to 2 s from the click on Tim's drawing. That is not measured inside CE; there is no timer line for it.
7. PITSCHEDULE's 25 to 31 s in the robot runs is the robot working the schedule window, not PIT.

## 3. Does the #1837 memo approach apply?

**Yes, with one difference the plan must handle.**

1. B-004's safety argument was that "the read only reads". The pipe re-check also **writes** between walks: it takes this pipe off each pit or source record, then adds it back (`RemovePipeLinksFromAllOwners`, `AddPipeLinkToBlock`, and `RefreshFlowArrowFromResolvedDirection`, which may write the flow arrow).
2. So the memo for the re-check may remember **only facts the re-check itself never changes**:
   1. the object is not a live block (lines, text, polylines and hatches stay that way; this is most of the 1,083 objects);
   2. the block is not a pit (its effective name);
   3. a pit's outline, from its dynamic properties and position, which the re-check never moves;
   4. a block with no source tag.
3. These must **never** be remembered:
   1. any link record: `WasPitLinkedToPipeEnd` and `ReadPitLinkDataForScan` must be read fresh every time (B-004 already leaves `WasPitLinkedToPipeEnd` un-memoised);
   2. the source-to-pit association, unless the builder proves the re-check never writes it (to check first: `RequireSourcePitAssociation` and its record);
   3. extents, which are point-free but cheap to leave out of the first version.
4. A new object made during the pass (a flow arrow) has no memo entry, so it is read in full. Same answer.
5. The walks keep the same `foreach` over the same model-space order, so the nearest owner, the counts and the ambiguity flags stay the same. This is the B-004 rule.

## 4. DRAFT FIX PLAN (not built)

1. **Base:** `origin/claude/rel-20261029a` (C-76, Civil 3.0.86), because it already holds `OwnerScanMemo` (#1837). Branch suggestion `fb/b031-pit-relink-speed`; worktree `C:\ce-fx\b031`.
2. **Switches** (`Modules/Drainage/Models/UserSettings.cs`, linking group, next to `sourceLandingReadsEachObjectOnce` at line 648):
   1. `linking.pitRelinkReadsEachObjectOnce`, **ON**, documented "Default: on.". OFF means every walk reads every object in full, exactly as 3.0.86.
   2. `linking.pitRelinkTimingLog`, **OFF**, documented "Default: off.". Log only: one line per re-check, `[BUG-1228] Pipe re-check read N pipes in N ms (reads each object once: on|off)`, plus the full-read and passed-over counts. It changes nothing in the drawing.
   3. Neither goes on the Settings page, the same as B-004's switches.
3. **Code change (one code path, design rule 1):**
   1. A small private `RelinkWalkMemos` holder with three memos: the pit walk, the source walk, and a "not a live block" set for `RemovePipeLinksFromAllOwners`.
   2. It is made once at the top of `RelinkPipeEndpoints(Transaction, IReadOnlyCollection<string>)` (Geometry.cs line 937) from the switch.
   3. It is passed down as an optional parameter (default null = today's behaviour), not a static or thread field: `UpdatePipeLinksFromGeometry`, `ResolvePipeEndpointOwnersCore`, `ResolveOwnerAtEndpoint`, `FindOwnerAtPoint`, `TryApplySamePitEndpointFix`, the two walks and `RemovePipeLinksFromAllOwners`.
   4. In the walks: `context?.PitWalk ?? memos?.PitWalk ?? off`, the same for sources.
   5. In `RemovePipeLinksFromAllOwners`: pass over only ids proven not to be a live block. Everything else, including the link record read and write, runs as today.
   6. The memo dies with the pass. Nothing is kept between pits or commands.
   7. This covers PIT (PitCommand line 583) and the CDPROPAGATE route (`LinkService.RepairAudit.InvertPropagation.cs` line 982). Both use `RelinkPipeEndpoints(tr, …)`.
4. **Second step, same switch, only if the reviewer agrees:** give the public `RelinkAllPipeEndpoints()` (Geometry.cs line 19) one memo across its per-pipe transactions. Safe only for facts that stay true across transactions within one command (not a block, not a pit, not tagged). This covers the DP, OF, source and xcivil calls in cause 3. I recommend keeping it out of the first PR and measuring PIT first.
5. **Not in this plan (would change behaviour, needs review or a Tim ruling):**
   1. limiting PIT's re-check to the pipes near the new pit (the BUG-656 `onlyHandles` route exists);
   2. skipping the rewrite of unchanged pit link records;
   3. the once-per-drawing merge in cause 2, which needs its own measurement first (the per-pipe save after each pipe looks like the larger part).
6. **Safety:**
   1. No new write, command, regen, view or system variable change (REDO-safe, BUG-861 rule).
   2. Locked layers, Xrefs and REFEDIT are handled as today, because the same writes run.
   3. CE_SHARED is not touched.
   4. Warnings never block.
7. **Tests (headless, `Bug1228PitRelinkSpeedTests`):**
   1. Both switches through `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`: an empty file, a C-76-shaped file and a partial linking group. Each typed value changes only itself; `sourceLandingReadsEachObjectOnce` stays ON. Pin both in `C75NewSwitchDefaultsTests` (or its C-76 successor) and in the documented-default guard (`C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault`; B-004 tripped it once).
   2. A made-up drawing of about 500 objects and about 50 pipes, walked as the re-check walks. **Between pipes, the test rewrites link records**, the way Remove and Add do. ON must give the same owners, distances, counts, ambiguity flags and link records as OFF, after every pipe.
   3. A pit whose link record changes mid-pass is seen fresh by `WasPitLinkedToPipeEnd`. An object added mid-pass is read in full. An unreadable object is read again every walk.
   4. Full reads drop from about 50 x 6 x 500 to about 500 x 3.
   5. Source guards:
      1. `RelinkPipeEndpoints` makes the memo from the switch;
      2. `RemovePipeLinksFromAllOwners` remembers only "not a live block";
      3. no memo call wraps `ReadPitLinkDataForScan` or `WasPitLinkedToPipeEnd`;
      4. the B-004 two-caller pin still passes.
   6. Switch OFF: no collections are made, and the walk order and calls are identical to 3.0.86 (the IL guard style of B-004).
   7. Focused Civil net10 tests first, then the full suite once (0 failed, count not 0), then the net48 compile.
8. **REGRESSION_LOG.md entry:** BUG-1228 / B-031, PIT pipe re-check reads each object once, switch `linking.pitRelinkReadsEachObjectOnce`.

## 5. Robot case (proposal for CE 02; final numbers are CE 02's)

1. **N41_pit_time:**
   1. Fixture DRV1_B1, fresh copy. Settings overlay `linking.pitRelinkTimingLog` true.
   2. **Steps:**
      1. Type `PIT`, Enter, then type `150000,-80000`, Enter. The New Pit window opens.
      2. Set the cover level to 19.000 and press Continue placement.
      3. Esc at "Specify pit label insertion point", Esc at "Click to place cover text", then Esc at "Specify pit insertion point" (the next pit).
   3. **Checks:**
      1. History has "Pit placed successfully." and exactly one new STORMWATER PIT insert.
      2. Every new CE log line `[BUG-1228] Pipe re-check read N pipes in N ms` says "reads each object once: on", N pipes = 49, and N ms **under 800**.
      3. The pipe end owners are recorded: the `Pipe endpoints updated` lines name the same from and to as the switch-off control, line for line.
2. **Control C41_pit_time_switch_off:**
   1. The same steps with `linking.pitRelinkReadsEachObjectOnce` false.
   2. Expect "reads each object once: off" and about **2,500 to 3,500 ms**, which is today's 2.95 s.
   3. Expect the same placement line and the same `Pipe endpoints updated` lines.
   4. This is the failing broken twin for Claude-accepted.
3. **Do not judge on `Command outcome: PIT completed N ms`:** about 50 s of it is the robot's own waiting.
4. **Worth adding later:**
   1. a pit placed on a pipe (the split route), to show the same two halves and joins ON and OFF;
   2. the CDPROPAGATE route;
   3. a 150-pipe fixture, to show the time grows much more slowly than today.

## 6. Not proven, said plainly

1. Nothing ran in AutoCAD for this report. No dotnet was run.
2. Measured from Tim's log: about 56 ms per pipe for the per-pipe step, and about 3 s for PIT's re-check on 49 to 50 pipes. Two numbers are reasoned, not measured: the six walks per pipe (from the code) and the 150-pipe estimate.
3. Not measured inside CE: the New Pit window time, the split check alone, the label and cover steps alone. There are no timer lines for them; they fit in the gaps around Tim's clicks.
4. The expected gain (3 s down to under 1 s) is an estimate. Iterating the model-space list itself still costs a little per walk.
5. Whether `RequireSourcePitAssociation` reads anything the re-check writes is not yet checked; the builder must check it before remembering it.

## 7. Housekeeping

1. No worktree, branch, PR, build or test. Nothing deployed. Tim's settings, bundles and ProgramData were not touched.
2. DESK_LOG.md, the register and BUG_CARPARK.md were not edited.
3. No street, client or drawing name is written here. "Tim's drawing" is a 50-pipe drawing he worked on at 10:00 to 10:40.

**Summary (under 100 words):** B-031 diagnosis, no PR, nothing built. PIT is slow because, after every pit, `PitCommand.cs` line 583 re-checks every pipe through `LinkService.Geometry.cs` `RelinkPipeEndpoints` (line 937). Each pipe takes six whole-drawing walks (lines 1265, 1358/1385 and 1501/1575) with B-004's memo OFF (no read context), measured at about 56 ms per pipe, so about 3 s per pit at 50 pipes. The second cause is the once-per-drawing merge (`ProjectDataService.cs` 664/772, 10.1 s). The third is the same re-check after DP and the other sources (`SourcePlacementService.cs` 1308, 1453, 1488). The memo applies. Plan: switch `linking.pitRelinkReadsEachObjectOnce` (ON) and log switch `linking.pitRelinkTimingLog` (OFF); robot case N41_pit_time with twin C41_pit_time_switch_off.
