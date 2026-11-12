# Review: draft PR 2053, `claude/trust04-cancel-guards` (TRUST-04 queue item 5: a guard that cancelling CD leaves CE's record as it was; tests only)

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:12 PC clock. Read only: nothing built, installed or merged by this lane.
**What was read:** PR 2053's description; its one commit `9ffbeccb` on base `cf059dcf` (confirmed by ancestry); `CdCommand.cs` at `cf059dcf` from the start of CD to its end; what CD calls before its questions; what AutoCAD's end of command makes CE do (`LinkService.Reactors.cs`, `ProjectDataService.Persistence.cs`); queue item 5 in `QUEUES.md`; `TRUST_PROBES_13NOV.md` section 9; the CDHELP and CDS tool notes.

---

# FOR TIM

1. **What it is:** a test only. It checks that CD's own instructions, from the start to the Cancel, contain none of the six ways CE rewrites its record, and that CD attaches the record to the drawing without writing before its first question. That is true today, and the test would catch a later change that put the early update back.
2. **But "Cancel in CD leaves CE's record exactly as it was" is not true today, by reading, and this test cannot see why.** CD is one of 16 command names after which CE writes its whole record into the drawing at the end of the command, even when nothing changed and even after Esc or Cancel. The robot saw the same kind of write after a cancelled PIT, which is on the same list. Help (CDHELP) and CD Settings (CDS) are on that list too and never attach the record to the drawing first, so in a second drawing they can write the first drawing's pits and pipes into it (by reading; not yet seen).
3. **Verdict: FIX FIRST** (section 2). It also covers CD only, and only up to the New Pipe window, not every question of every core tool as queue item 5 asks. Built: no product code (test build compiled, lane). Tested unit only (lane: 10 of 10; broken twin 2 of 10 fail). Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **What it guards:** the text of `CdCommand.CivilDrainage` from its start to the line `LoggingService.Info("CD command cancelled by user")` (`Trust04CdCancelLeavesRecordTests.cs` 27-35) must not contain `InitServicesFull(`, `ProjectDataService.SetDrawingPath(`, `EnsureDrawingDataCurrent(`, `SyncWithDrawing(`, `SyncActiveDocument(` or `SaveProjectData(`, and must bind the record without saving before the draw-first point pick and before the New Pipe window. For CD only.
2. **Is "Cancel leaves CE's record exactly as it was" really tested at every question, through the real code path? NO.**
   1. **Not the real path:** it reads one method's text. It does not follow what that method calls, and it cannot see what CE does when AutoCAD ends the command (section 2, item 1), which is where CD's cancel writes.
   2. **Not every question:** in window-first mode the pipe's points are asked after the window, inside `ExecutePipeDrawing`; Esc there ("Pipe drawing cancelled", `CdCommand.cs` 216-219) is outside the guarded text. The draw-first direction question (`TryResolveDrawFirstDirectionDecision`) is a helper the text check does not open.
   3. **Not every tool:** queue item 5 says "for each core tool, at every prompt". This PR is CD alone. PR 2055 adds the first question of CDTG, CDSL and CDWT. Still without any guard: PIT, Edit Pit, Edit Pipe, the Pit Schedule, CDFW (its leftover is seen in AutoCAD), DP, IO, OF, FO, GIO and the generic source.
3. **Does the test fail without the change?** It adds no change; it passes on today's code. The lane's broken twin (CD's bind swapped for `SetDrawingPath`) fails both tests, which is right by reading.

## 2. FIX FIRST

1. **CD writes CE's whole record at the end of every CD, Esc and Cancel included (by reading `cf059dcf`).**
   1. CD is on CE's list of commands after which the record is written before the command finishes (`LinkService.cs` 61-81: CD, CDS, CDHELP, CDMA, PIT, PITEDIT, PIPEEDIT, PIPEINFO, CDLPD, CDLPDRESET, CDTAG, CDUPGRADE, CDPIPEOVERRIDE, CDPIPEOVERRIDECLEAR, CDCALC, CDCALCOLD).
   2. CD's Esc and Cancel paths print their line and return normally (`CdCommand.cs` 97-101 and 186-198), so AutoCAD ends the command normally and CE's end-of-command handler runs `FlushProjectDataIfTriggerCommand` (`LinkService.Reactors.cs` 591, 1011, 1021; body 2047-2067). For a listed command it always flushes (`OutsideCommandUndoPolicy.cs` 94-97).
   3. `FlushPendingSave` then marks a save waiting even when none was (`ProjectDataService.Persistence.cs` 446-462) and writes the record with `SaveToDrawing` (1376 onward), which has no "nothing changed" check: it stamps the position units and writes the record in today's format in a normal transaction.
   4. On the standard test copy, whose stored record is format 2.2 (the CDFW evidence), the stored text will change on a cancelled CD. On an up-to-date record the text may come out the same, but the drawing is still marked changed and an Undo step is added.
   5. **Real AutoCAD agrees for PIT, which is on the same list:** PIT cancelled at its first question changed the stored record (600,382 to 600,234 characters) with nothing drawn (`TRUST_PROBES_13NOV.md` section 9, U-D).
   6. **Fix, one of:** (a) product change: at a command's end, write only when a save is really waiting for this drawing (the list exists so a CE edit lands in its own Undo step; with nothing waiting there is nothing to land); or (b) keep the PR tests-only but retitle it to what it proves ("no update before CD's first question") and add the robot case: fresh copy, CD, Esc at the first point, then Cancel in the window; compare the whole stored record text and the drawing's object count.
2. **A write the guard's list misses, before CD's first question:** `ProjectDataService.MarkDrawingActive` (`CdCommand.cs` 64) opens CE's dictionary for writing in a normal transaction and rewrites the "Civil active" mark every time (`ProjectDataService.Persistence.cs` 903-929, 1610-1629). Not the job record, but a drawing change and an Undo step on every cancelled CD, and on a drawing with no CE data it creates CE's store. Add it to the list, or move it to the placement as CDFW does.

## 3. For the controller (new, found while checking item 2.1; by reading, not seen)

1. **Help and CD Settings can write one drawing's record into another.** CDHELP (`CdCommand.cs` 1575-1581) and CDS (1558-1566) never attach CE's record to the drawing they run in. CE does not re-attach it when the drafter changes drawing either (`LinkService.cs` 1199-1210; the note at `ProjectDataService.Spine.cs` 109-113 confirms the record in memory is still the previous drawing's at the first open of a job).
2. At their end, `FlushPendingSave` picks the drawing the command ran in (`ProjectDataService.Recovery.cs` 1057-1076 returns that drawing whenever it is open) and writes CE's record in memory into it; nothing compares the record's own drawing with the target (`ProjectDataService.Persistence.cs` 548-600, 1376 onward). The only guard stops an EMPTY record going into a drawing with no Civil content (`DrawingDisciplinePolicy.cs` 290-291). The quiet-drawing branch still runs the flush (`LinkService.Reactors.cs` 586-591).
3. **So:** open job A and use any CE tool; open drawing B (a blank drawing, a standard detail, another job); press Help (CDHELP) or open CD Settings (CDS) before any other CE tool in B. By reading, A's whole pit and pipe record is written into B, and B is then treated as holding A's pits. This is the BUG-385 class (one drawing's record saved into another).
4. **The tool notes say the opposite:** `04_REFERENCE\core-tool-notes\CDHELP.md` line 16 ("Nothing in the drawing or CE's record") and `CDS.md` lines 17-18. They read only the command method.
5. **One robot run settles it:** two copies; CE tool in the first; open the second; CDHELP, close help; read the second drawing's CE dictionary. Needs a carpark entry (the controller files it; this lane writes no bug file).

## 4. Worth knowing

1. **I grepped the New Pipe window and its view model files** for the six writer names: none. The window itself does not refresh the record.
2. **PIPEINFO is on the list but is not a Civil command** at `cf059dcf` (harmless).
3. **No client name, job number, street or suburb** in the diff.

## 5. Not checked

1. Not built or run by me. Nothing seen in AutoCAD.
2. The other listed commands (CDMA, CDLPD, CDTAG, CDUPGRADE, CDCALC and the rest): whether each attaches the record before its end. Only CD, CDHELP and CDS were read.
3. Whether an AutoCAD of 2022 to 2024 ends a cancelled CD the same way (it should: the command returns normally on every year).
