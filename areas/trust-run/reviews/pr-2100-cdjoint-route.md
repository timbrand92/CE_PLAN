# Review: PR 2100 `claude/bug-1456e-outside-record-guard` (BUG-1456: a guard on routines outside the record service; CDJOINT), head `364ccc4e`

**Reviewer:** lane trust-review. **Written:** Fri 13 Nov 2026, 17:46 PC clock. **Base:** on PR 2090 (`8ecfece7`), which sits on 2089 and 2083. 2089 and 2090 are not on the installed build (`9714ffdd`, trial A = 2073 + 2083). Draft. Read only: no build, no test run, no AutoCAD.

**Verdict: FIX FIRST** (four items). The code change is safe, but the fault it was written for does not exist on the installed build, and the robot case written for it would look for a refusal that never comes.

---

# FOR TIM

1. **The CDJOINT fault is not real as described.** CDJOINT switches CE to the drawing in front at its very first step, before it asks anything. So when it is the first CE tool in job B, it works on job B's own pits-and-pipes record, and job A is left alone. That is true on the build installed today.
2. **The change is harmless and slightly useful.** It only matters if you click across to another drawing in the middle of CDJOINT's questions, run a CE tool there, then come back and finish CDJOINT. CE now leaves the other job alone and says so. In ordinary work CDJOINT is unchanged.
3. **The new automatic check (the guard) is worth keeping.** It lists every place outside CE's record keeper that edits or saves the record. Its reviewed list misread two commands for the same reason, both on the safe side.
4. **Nothing for you to do.** The fixes are wording, one robot test row, and one sister command (CDSLABEREGEN) brought into line.

---

# Findings (file and line at `364ccc4e` unless marked `9714ffdd`)

## 1. The fault claim: refuted by reading

1. **Where CDJOINT attaches:** `CdJointCommand.cs:34` calls `InitServicesFull(doc)` before the first question. At `9714ffdd`, `CeCommandBase.cs:43-47` runs `InitServices(doc)` and then `ProjectDataService.SyncWithDrawing(doc.Database)`; `InitServices` (`:30-37`) calls `ProjectDataService.SetDrawingPath(doc.Name, doc.Database)`.
2. **SetDrawingPath switches the record:** `ProjectDataService.Mutations.cs:151-189` at `9714ffdd`. When the record in memory is another drawing's, it saves that record into its own drawing (`:176-182`), then `LoadCurrentForDrawingLocked` (`:194-212`) makes this drawing's stored record the record in memory and points it at this drawing.
3. **SyncWithDrawing binds again and reloads the slab list:** `ProjectDataService.cs:264-270` at `9714ffdd` calls `EnsureDrawingDataCurrent(db, force: true)`. That first calls `BindRecordToOpenDrawing(db)` (`:615`) and at its end sets the record's slab list from this drawing's own slab store (`:699-716`).
4. **So at line 134 on the installed build** the record in memory is B's and already holds B's slabs; `Current.Slabs = allSlabs` puts B's slabs into B's record. Job A is untouched. The PR's statement "CDJOINT never attaches CE's record to its drawing" (code comment, test comment, REGRESSION_LOG, PR body) is wrong.
5. **2073 and 2083 do not change this:** neither touches `SetDrawingPath`, the bind routines or `InitServicesFull` (checked with `git diff 9573b97a^1 9714ffdd`). 2089 and 2090 do not either.
6. **Why it was missed:** the guard reads only each routine's own body. CDJOINT's attach is one call deeper, inside the shared start-up helper. The same blind spot made the reviewed list say "CDTIDYLABELS does not attach" (baseline line 62), but `TidyLabelsCommand.cs:35` calls `InitServices(doc)`, which attaches. The list's own line for CDSLABEREGEN (line 26) accepts exactly the pattern CDJOINT has.
7. **The one route left (narrow, not verified):** between the attach at `:34` and the slab set at `:137`, CDJOINT asks up to four questions (boundary, regenerate, slab type, custom spacing). If AutoCAD lets the drafter switch to job A while CDJOINT waits, run a CE tool there (which attaches A), then come back and answer, line 134 at `9714ffdd` would put B's slabs on A's record. I have not verified that AutoCAD allows a CE command to run in A while CDJOINT waits in B. The same window, if it exists, would let `BuildPitExclusions` (`:105`) cut B's joints around A's pits (a read only, already there, not in this PR's scope).

## 2. The change

1. **What it does:** `CdJointCommand.cs:137` now calls `ProjectDataService.SetSlabsOf(doc.Database, allSlabs)`. `ProjectDataService.RecordChangeDoor.cs:102-114` asks 2083's `RefusesChangeFor(db, ...)` first, then sets the list under the lock. No save is asked for, as before.
2. **Does it close the route?** The plain route needs no closing (section 1). The mid-question switch route in 1.7 is closed for CDJOINT: B is named, B is not the record's drawing, so `RecordOwnerRule.ChangeIsRefused` (`RecordOwnerRule.cs:82-83`) refuses.
3. **Respects 2073 and 2083, no duplicate:** it reuses 2083's check, and 2090's command-line line comes through that check. No second rule is added.
4. **Cancel and Escape:** the changed line is reached only after every question is answered and the joints are drawn. Every Escape or No return is earlier (`:42, :54, :73, :90, :94, :102, :113`). The PR adds no write on Cancel or Escape. (Already there and unchanged: `InitServicesFull` at the start writes the Civil mark and, when it switches, saves the records, before the first question.)
5. **Normal one-drawing use:** after `InitServicesFull` the record is this drawing's, so the check allows the change and the list is set exactly as before. The only other difference: if the record were ever empty (null), the old line threw (caught as "[CE] Error") and the new one returns quietly; it is never null after start-up. No risk found.
6. **When it does refuse:** CDJOINT ignores the answer and still says "CDJOINT complete: N SC joint(s) placed" straight after the refusal line. The joints are drawn and kept in B's own slab store, and B's record reloads them from there next time, so the drawing is right. The wording is mildly confusing; optional to improve.
7. **One code path per behaviour:** CDSLABEREGEN (`SlabCommand.cs:1802` attaches, a question at `:1815`, then `:1843 ProjectDataService.Current.Slabs = committedSlabs`) has exactly the same shape and the same switch window, and is left on the direct set. The copy clean-up (`LinkService.Utilities.cs:35` binds, `:429` sets) has no question in between. So two ways now set the slab list from outside the service.
8. **Sister joint commands:** CDCJ and CDSC never set the slab list on the record in memory. They read the drawing's own stored record (`CaptureDrawingSnapshotOrExactEmpty`, `ProjectDataService.Persistence.cs:134-146` at `9714ffdd`) and adopt a prepared copy through the checked routine (2089's door). The other slab list writers (`SlabCommand.cs:1082`, `SlabEditDialog.xaml.cs:125`, `SlabManualJointPlacementService.cs:210`, `SlabService.cs:2187` and `:2336`, `SlabCompoundMoveAutoCadAdapter.cs:242`) all set it on prepared copies. No other direct writer was found.

## 3. The tests

1. **Would they fail without the fix?** `Cdjoint_SetsTheSlabListOnlyThroughTheCheckedRoutine_AndTheUncheckedBuildIsCaught` (`RecordTouchedOutsideTheServiceGuardTests.cs:214-246`) fails on the old body (no `SetSlabsOf` call, a raw slab set present). So yes, but it checks the shape of the compiled code, not behaviour.
2. **No behaviour test of the refusal:** `RefusesChangeFor` never refuses without AutoCAD (`RecordChangeDoor.cs:39-40`), so the refusal cannot be run headless. Only AutoCAD can prove it.
3. **The broken twin proves the guard, not the fault:** putting a raw slab set back into CDJOINT (`:231-244`) shows the guard flags that pattern. Its comment and message call that "the installed build" setting "the slab list on whatever record CE holds", which is untrue.
4. **The guard tests themselves are sound:** a fresh read of the compiled plugin in each test (no shared state), real counts asserted (at least 25 routines, at least 20 saves), twins for a new routine and for a routine that does more, and a line with no reason is not a review. The Explicit list writer writes only to %TEMP%.

## 4. Robot cases

1. **Row 11 as written will not reproduce on either build** (`C:\CE_PLAN\PENDING_TESTS.md:37`). On `9714ffdd`, CDJOINT run first in B attaches B, so A's slab list stays A's (the "broken" half does not break). With 2100, no refusal line appears (the "right" half fails). A robot run would report a FAIL that is a fault in the test, or invite someone to "fix" CDJOINT so it stops attaching.
2. **Row 12 is fine.**

---

# FIX FIRST

1. **Correct the claim everywhere:** `Modules/Drainage/Commands/CdJointCommand.cs:134-136`; `Modules/Drainage.Tests/Services/RecordTouchedOutsideTheServiceGuardTests.cs:212-213`, the comment at `:231` and the message at `:244`; `REGRESSION_LOG.md:8` (item 4) and `:11` (item 7); the PR body. Say instead: CDJOINT attaches at its start (`InitServicesFull`: `SetDrawingPath`, then `SyncWithDrawing`); the checked routine covers only a drawing switch while CDJOINT waits at a question; no fault was found on the installed build for the plain route.
2. **Rewrite or drop row 11** in `C:\CE_PLAN\PENDING_TESTS.md:37`. If kept: start CDJOINT in B, at the slab type question switch to A and run a CE tool, come back to B and answer; right = A's record unchanged and the refusal line shown once in B. First prove the broken twin on `9714ffdd` (that AutoCAD allows the switch and that A's record really changes there). If it does not, drop row 11 and say why.
3. **One code path for the slab list:** `Modules/Drainage/Commands/SlabCommand.cs:1843` becomes `ProjectDataService.SetSlabsOf(doc.Database, committedSlabs);`, and take out baseline line 26 (`SlabCommand.RegenSlab`), or the guard will report it STALE. (Optional, the same change: `Modules/Drainage/Services/LinkService.Utilities.cs:429` becomes `SetSlabsOf(db, SlabService.LoadSlabs(db))`, and take out baseline line 57.)
4. **Close the blind spot in the reviewed list:** `Modules/Drainage.Tests/Services/RecordTouchedOutsideTheService.baseline.txt:5-6`: "Attaches" must include a call through `CeCommandBase.InitServices` or `InitServicesFull` (the guard sees only a routine's own body, so the reader must follow the shared start-up). Correct line 62 (`LinkService.TidyPitCoverTexts`): CDTIDYLABELS does attach (`TidyLabelsCommand.cs:35`). Re-read any other line that says a command "does not attach" with that in mind.

---

# Not verified

1. **The one route left:** whether AutoCAD lets a CE tool run in another drawing while CDJOINT waits at a question.
2. **Build and test figures:** the build and the 22,261 test count are the lane's; I did not build or run tests.
3. **The other baseline reasons:** not each re-read. Only CDJOINT, CDSLABEREGEN, the copy clean-up and CDTIDYLABELS were checked.
4. **AutoCAD:** nothing was run in AutoCAD or accoreconsole.

**Four states:** Built yes (lane, `364ccc4e`); Tested unit only (lane); Installed no; Accepted no.
