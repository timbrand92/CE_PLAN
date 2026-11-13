# Review: PR 2089 `claude/bug-1456c-snapshot-write-door` (BUG-1456, the fourth door), head `e938d0d4`

**Reviewer:** lane trust-review (sixteenth run). **Written:** Fri 13 Nov 2026, 11:49 PC clock. **Base:** on PR 2083's head `8a6decef`, which sits on 2073's `1a28c3b3`, which sits on `cf059dcf` (all confirmed). Draft, auto-merge off. Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **It does what it says for the copy itself.** A tool's copy of another job's pits and pipes is no longer written into this drawing. A copy of this drawing's own data still goes in. In every route I traced, a real change in the right drawing is never stopped.
2. **But it does not close the one route it was written for.** When the copy is refused, the tool undoes its whole step. CE's clean-up after that undo then makes the other job's data this drawing's data in memory. So the mix-up returns at the next CE tool used in that drawing. This route needs pipe size proposals switched on, and they are off on your PC. It is also there without this change.
3. **It is not on your PC today, and need not be.** Today's trial is 2073 (and later 2083) only.

**Verdict: FIX FIRST** (two items, below). Not needed for tonight's State A.

---

# Findings (file and line at `e938d0d4`)

## 1. What it changes (only what it says, apart from item 3)

1. **Product files changed:**
   - `Rules/RecordOwnerRule.cs`: adds `CopyMayGoIntoThisDrawing`, lines 93-100.
   - `Services/ProjectDataService.SnapshotOwner.cs`: new, 132 lines.
   - `ProjectDataService.Mutations.cs`: note at `:25-26`; prepare at `:1247-1251`; adopt check at `:1272-1276`.
   - `ProjectDataService.Persistence.cs:1502-1505`: write check.
   - No switch, nothing on screen, one log line.
2. **Where a copy's source is written down:** in only two places:
   - `CloneCurrentProject` (`Mutations.cs:20-29`);
   - `PrepareCommittedSnapshot` when it is handed the live record itself; a copy of a copy carries its source (`:1247-1251`).
   - The source is the drawing the record is attached to at that moment, or "nobody's" when that drawing has closed (BUG-1225 switch, default ON).
   - Copies read from the drawing or rebuilt by a tool have no source and are written as before.

## 2. Can it refuse or drop a real change in the right drawing? No route found

1. **When it refuses:** only when the copy was taken while CE's record was attached to a DIFFERENT drawing, or left behind by a closed one. Two record fields could disagree with each other: the drawing the record is attached to (`_currentDatabase`) and the record itself (`_currentProject`). In every place the record is replaced, they are set together:
   - `LoadCurrentForDrawingLocked`, `Mutations.cs:196-214`;
   - `RestoreAfterFailedDrawingChange`, `:74-90`;
   - `TryAdopt`, `:1282-1283`;
   - `Persistence.cs:1201`, `:1286`.

   The same-name shortcut in `SetDrawingPath` (`:166-175`) re-points the drawing only.
2. **Callers whose copies carry a source** (I traced each one to where its copy is taken):
   1. **The batch edit** (`CeBatchEditApplyCoordinator.cs:174`, `:197`). Its callers:
      - CDEDIT pit and pipe batches, which attach through the Hub first (audit section D);
      - the Dashboard and CDRUNSOLVE proposals, which attach first;
      - the CE Assistant pipe-size apply, which does NOT attach (`AUDIT_OUTSIDE_SAVES_13NOV.md` D4).
   2. **The spine tools** (`PrepareSpineSnapshot`, `ProjectDataService.Spine.cs:70-77`). These throw unless the record is already this drawing's, so the source is always this drawing.
   3. **The slab tools** (`SlabCommand.cs:1079-1083`, `SlabService.cs:2333-2337`, `SlabEditDialog.xaml.cs:92-102`). These take the live record only through `TryPeekCurrent(db)`, which hands it over only when it is this drawing's (`ProjectDataService.cs:160-176`).
   4. **Edit Pipe, Edit Pit, the level cascade and the Pit Schedule** take copies only to put back after a failure (`RestoreProjectData`, `RestoreAfterFailedDrawingChange`). Neither is checked by this PR, and all four attach first.
3. **Callers whose copies have no source** (never refused, as before): CDAGI, CDSL, CDWT, the raingarden and source placing, CDCALC's workspace, X-Civil. These read the drawing in the transaction (`ReadDetachedSnapshotOrAdmittedInitialInTransaction`, `TryCaptureDrawingBoundInitialSnapshot`, `Persistence.cs:78-127`), and the tools attach first (for example CDAGI `SetDrawingPath`, `AgiCommand.cs:90`).
4. **For the controller (low, already in State A, not new here):**
   - `TryAdoptPreparedCommittedSnapshot` makes a record live but does not clear BUG-1225's closed mark (`Mutations.cs:1279-1285`).
   - So, after the record's drawing closes, a tool that adopts in another drawing without attaching first would leave that drawing's own adopted record looking like nobody's to 2073's doors, 2083's check and this PR, until the next attach.
   - Every tool I opened attaches first, so I found no way to reach it.

## 3. FIX FIRST item 1: the route it was written for is not closed (the undo's clean-up re-attaches the other job's data)

1. **When the copy is refused, the batch's own check throws.** In the batch edit the copy is refused at `Persistence.cs:1504`, and the write returns quietly. Then the check after it reads the drawing's stored record back and compares it with the copy (`CeBatchEditApplyCoordinator.cs:222-228`). The two differ, so it throws "The saved CE project data differs from the accepted batch." The whole step is rolled back (`ExecuteAttempt`, `:66-110`).
2. **The clean-up then makes the other job's data this drawing's.** After the rollback the coordinator calls `RestoreAfterFailedDrawingChange(before, document.Name, database)` (`:262-265`, the call at `:264`). `before` is the copy taken at `:174`, which is the OTHER drawing's record. That routine sets the drawing to this one and the record to `before`, with this drawing's file name (`Mutations.cs:74-90`), and checks nothing.
3. **The next write therefore passes.** From then on CE holds the other job's data as this drawing's own. 2073's doors see "same drawing" (`RecordOwner.cs:24-27`), and 2083's check sees "the record's own drawing". So the next forced write at a listed command's end, or the next change, writes it in. That is the BUG-1456 mix-up, one step later.
4. **How it is reached:**
   - The CE Assistant applies a pipe-size proposal as the first CE action in a second drawing, and one object number happens to name a pipe in both jobs (audit D4). Pipe size proposals must be switched on.
   - **On Tim's PC they are off** (`"pipeSizeProposalsEnabled": false` in his CD_Settings.json, read 11:42).
   - **The same end state exists with 2073 and 2083 alone (State A).** 2083 refuses the per-pipe change, so the size check after the write fails, and the same clean-up runs. So 2089 does not make State A worse; it just does not close it.
5. **Fix (small):**
   - In `RestoreAfterFailedDrawingChange`, apply the same copy rule. If `snapshot` was taken from another drawing's record, leave the record and its drawing as they are; the record was never changed, because 2083 refused the change. Log the one line.
   - Add a case: a batch run in a second drawing with the other job's record in memory leaves CE holding the other job's record, still attached to the other drawing.

## 4. FIX FIRST item 2: words that are not true

1. **The PR's "Nothing is thrown (warn, never block): the tool's own drawing changes still go in"** is untrue for the batch edit, the one route where a copy carries a source and could be refused. There the refusal makes the whole step roll back.
2. **What the drafter would see:**
   - CDEDIT pipe batch: "[CE] The pipe batch was refused and rolled back. Nothing was changed. The saved CE project data differs from the accepted batch." (`PipeEditCommand.Batch.cs:1113`). The last sentence is in software words.
   - The CE Assistant gets "Nothing was changed. " plus a reason (`PipeSizeWriteService.cs:499`).
   - Safe direction (nothing written), but say it as it is.
3. **The test name overclaims:** `NothingIsThrown_TheToolsOwnDrawingChangesStillGoIn` (`Bug1456CopyWriteDoorTests.cs:167-178`) only searches the two routines' text. It cannot see what the callers do next.
4. **To fix:** correct the PR text and the REGRESSION_LOG entry, and rename the test.

## 5. Sound

1. **Rule and tests:** the rule is pure, and the installed build ("any copy goes anywhere") is caught by a named case (`Bug1456CopyWriteDoorTests.cs:46-59`). On the compiled plugin, both places ask first, and a copy with the question taken out is caught (`:121-142`).
2. **Never stops a write on a guess:** if the source cannot be read, the copy is written as before (`SnapshotOwner.cs:124-129`).
3. **Same drawing test as 2073:** it compares drawings by the same native pointer that 2073's `LinkService.SameDatabase` uses (`LinkService.PipeAttachmentGrip.cs:485-500`).
4. **Core console:** `CEPROOFCROSSCOPY` PASS at this head, plus the two earlier checks (`EVIDENCE_CROSS_DRAWING.md`, 09:35).

# What I did not check

1. No build, no test run, no AutoCAD, no core console.
2. About eight whole-record writers the audit lists as untraced. I traced every caller of the two checked routines whose copy carries a source; for callers with unknown-source copies I traced only where the copy comes from.
3. Whether the CE Assistant panel checks the pipe-size switch before it applies (the audit says proposals are off by default; I read Tim's value only).
