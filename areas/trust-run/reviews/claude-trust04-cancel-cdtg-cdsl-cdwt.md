# Review: draft PR 2055, `claude/trust04-cancel-cdtg-cdsl-cdwt` (BUG-1285: Esc at the first question of CDTG, CDSL or CDWT)

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:05 PC clock. Read only: nothing built, installed or merged by this lane.
**What was read:** PR 2055's description; its one commit `2629343d` on base `cf059dcf` (installed Civil 3.0.90, confirmed by ancestry); the three command files on the branch; the code each calls before its first question; CDFW at `cf059dcf` and the source placing code it calls; the end-of-command record write; BUG-1285's carpark entry; `EVIDENCE_STALE_BUGS.md` FOR TIM item 1.1; `PENDING_TESTS.md` row 12.

---

# FOR TIM

1. **What it does:** trench grate, spot level and water tank no longer force CE's whole record update before their first question, so pressing Esc at the first point (or Cancel in the tank window) should leave CE's stored levels alone. Its tests fail on today's code and pass on the branch (checked).
2. **CDFW's leftover has a different cause and is not in these three:** CDFW quietly fills in an identity on every pipe in its placing step before the first pick; trench grate, spot level and water tank do not run that step before their first question. But two smaller leftovers remain: all three still mark the drawing as Civil before asking anything (a drawing change, and on a drawing with no CE data it creates CE's store), and spot level still runs the whole update after the point is picked although it never uses CE's record, so Esc at the level question, and every spot level placed, can still rewrite stored levels.
3. **Verdict: FIX FIRST** (three items in section 2). Built yes (lane, net48 and net10 0 errors). Tested unit only (lane: 5 of 5 new; related filter 1,969 of 1,976 passed, 2 failing tests named and said to fail on `cf059dcf` too, not re-checked by me). Installed no. Accepted no.

---

## 1. The question asked: does it have CDFW's leftover?

1. **Where CDFW's leftover comes from (by reading `cf059dcf`).** CDFW already binds the record without writing (`FloorWasteCommand.cs` 44-45). Its first pick is asked inside the source placing code, which first runs `PitSpineRowBackfillService.Backfill` (`SourcePlacementService.cs` 146). That copies the identity already on each drawn pipe into CE's record in memory and asks for a save (`PitSpineRowBackfillService.cs` 52-53, `ProjectDataService.Spine.cs` 23-38). The save writes the record in today's format. That matches the evidence exactly: format 2.2 to 2.3 and an identity added to each of the 49 pipes (the open had given all 49 their identity on the drawing objects only), no level changed.
2. **The three tools in this PR do not reach that step before their first question.** CDTG asks `ed.GetPoint` directly (`SourceBlockInsertCommands.cs` 161); CDSL asks through `BlockService.TryPreparePromptedBlockPlacement` with no source preview (`SpotLevelCommand.cs` 78); CDWT opens its window first (`WaterTankCommand.cs` 98) and only reads the drawing's record (open-close read, line 71) and adopts it in memory (line 73, `ProjectDataService.Mutations.cs` 1238-1264). None of the three is on the list of commands that write CE's record at their end (`LinkService.cs` 61-81). The helpers between the bind and the first question (layer check, trench grate defaults from Settings, the width, style, class and cover questions) read no record.
3. **So the CDFW leftover itself: NO, by reading.** The leftovers that remain are items 2.1 and 2.2 below.
4. **For the controller:** the same backfill runs before the first pick of every tool on the source placing code: DP, IO, OF, FO, GIO and the generic source (`SourceBlockInsertCommands.cs` 548 and 884, `SourceBlockGenericCommand.cs` 77). They will show the same quiet rewrite as CDFW. The tagged source route also still calls `SetDrawingPath` before its first pick (`SourceBlockInsertCommands.cs` 438-439), which saves when CE switches drawings.

## 2. FIX FIRST

1. **CDSL: drop the update altogether.** CDSL never reads or writes CE's record: after the update at `SpotLevelCommand.cs` 89-90 nothing in the command uses `ProjectDataService` (lines 91-165 place a block and set its level). The update is pure side effect, the full rebuild that overwrote typed levels (BUG-290) and wiped inverts (BUG-650). With it moved after the pick:
   1. Esc at "Enter proposed spot level (m)" (line 124, which prints "Nothing was placed.") still rewrites CE's record. BUG-1285's expected behaviour is "Esc at any question leaves the record exactly as it was".
   2. Every spot level placed still rewrites stored levels from plan text. `PENDING_TESTS.md` row 12 even describes this as right ("only then does the stored level follow the plan text").
   3. The test `TheRefreshStillRuns_AfterThePick_BeforeTheRecordIsRead` pins this rewrite in place for CDSL; its end marker `double insertX = placement.WorldPosition.X;` is not a record read. Remove the CDSL case (or turn it into "CDSL never updates the record").
2. **All three still write CE's store before the first question:** `ProjectDataService.MarkDrawingActive` at `SourceBlockInsertCommands.cs` 147, `SpotLevelCommand.cs` 41 and `WaterTankCommand.cs` 61. It opens CE's dictionary for writing in a normal transaction and rewrites the "Civil active" mark every time, even when it is already set (`ProjectDataService.Persistence.cs` 903-929; `WriteXrecordString` 1610-1629 always rewrites). So Esc at the first question leaves an Undo step and the drawing marked changed, and on a drawing with no CE data (a standard detail, a blank drawing) it creates CE's store and marks the drawing Civil. CDFW, the model this PR copies, does not call it. Move it to the point of placement (CDFW's pattern) and add `MarkDrawingActive(` to the test's writer list. (It is CE's "active" mark, not the job record, so the robot's record-text comparison will not see it; the drawing-object watch now in PR 2050 would.)
3. **CDWT: a record CE kept for this drawing is now lost without a word.** The new bind (`WaterTankCommand.cs` 62) takes a record CE kept for this drawing (unsaved changes left when the drafter switched drawings before CE could write them: `ProjectDataService.KeptRecords.cs` 185-196) into memory with its save waiting (`ProjectDataService.Mutations.cs` 194-212, line 202). CDWT then reads the drawing's stored record (line 71) and adopts it (line 73), which replaces the kept one and clears the waiting save; nothing is logged because the kept record was already taken. Before, `InitServicesFull` wrote it first, so it was kept. Rare, but a silent loss. Fix: start the snapshot from the kept record when there is one, or write it first as before (it is earlier work, not this command's), and log it either way.

## 3. Worth knowing

1. **Do the tests fail without the change? YES, all five.** The two tests are pure source-text checks; I ran their exact logic by script on the three files at `cf059dcf` and on the branch: all five cases fail on `cf059dcf` (CDTG and CDSL hold `SetDrawingPath` and `SyncWithDrawing` before the first question, CDWT holds `InitServicesFull`; no bind; no update after the pick) and pass on the branch. The lane's broken twin (CDWT's `InitServicesFull` put back, 1 of 5 fails) agrees.
2. **The guards read each command's own text only.** A write moved into a helper passes them, exactly as CDFW's leftover sits inside the source placing code. The robot case (row 12) checks one stored cover level in Edit Pit; it should compare the whole stored record text before and after, as the evidence lane does, so a format or identity rewrite shows.
3. **A save already owed to the drawing is still written at the end of any command** (`LinkService.Reactors.cs` 2047-2067 when a save is waiting). The robot must start from a freshly opened copy with no edits, or it will see a change that is not these commands'.
4. **CDTG's outlet question:** the update now runs just before it (`SourceBlockInsertCommands.cs` 245-246), so Esc at the outlet pick still rewrites. The PR says so honestly. BUG-1285 asks for any question, so the carpark entry stays open for that part (not FIXED on this PR). A detached read for the outlet picker would close it.
5. **Locked layers, Xrefs, REFEDIT:** the start-up checks are unchanged and run first; the CDSL locked-layer refusal is untouched.
6. **No client name, job number, street or suburb** in the diff.

## 4. Not checked

1. Not built or run by me. Nothing seen in AutoCAD.
2. CDWT's Apply on a drawing whose record is behind (it now starts from the stored record without the update folded in; the REGRESSION_LOG says so).
3. The 2022 to 2024 lane.
