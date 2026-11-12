# Review: PR 2073 `claude/bug-1456-record-own-drawing` (BUG-1456: CE's record is never written into a drawing it does not belong to, no switch)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:52 PC clock. Read only. **Head reviewed:** `1a28c3b3`, one own commit cut straight from installed Civil `cf059dcf` (ancestor, checked; base `claude/rel-20261108a`). It is NOT stacked on PR 2064 (2064's head `d64e9a72` is not an ancestor) and 2064 has not moved since its review at 05:04. **Read against:** `EVIDENCE_CROSS_DRAWING.md` (every sequence and control), my PR 2064 review (`reviews\claude-trust-09-cancel-writes-nothing.md`, FIX FIRST 1 and the "doors left open"), the installed record service at `C:\CE_WORK\scratch\audit_civil` (attach, switch, close, kept records, Undo reloads, every record writer) and `PENDING_TESTS.md` row BUG-1456. **Four states:** Built yes (lane: the plugin, net48 and net10, 0 errors; the headless proof project not yet compiled, per the PR). Tested unit only (lane: whole Civil project, Release net10, 22,222 ran, 0 failed; the core-console check written, not run). Installed no. Accepted no.

---

## FOR TIM

1. This is the cure for the job mix-up the robot saw on your installed build, and it has no switch: Help and CD Settings no longer write CE's record at all, and CE now refuses to write its record into any drawing that is not the one it belongs to. Each of the six sequences the robot saw is stopped twice over, by reading.
2. Nothing you draw is lost by it: a change still waiting for the other drawing is kept and written there at that drawing's next command or save; only a write nobody asked for is not made. You see nothing on screen; one line goes to the CE log.
3. It is proven by rules and by checks on the built plugin with deliberately broken copies, but not yet in AutoCAD with two drawings: the robot's six sequences on copies are the proof that matters. It stops new mix-ups only; a drawing already holding another job's record is not repaired.

**Verdict: GO** for the core-console check and the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## 1. Every seen sequence, with no switch (by reading)

Two independent locks, either of which alone stops each sequence:

1. **Help and CD Settings are off the end-of-command list for good** (`Services\LinkService.cs`, branch 61-66). Their end now writes only if a save is really waiting for that drawing (the unchanged `ShouldFlushRecordAtCommandEnd(false, saveWaiting)`), which in every seen sequence it was not.
2. **The writer refuses another drawing** (`Services\ProjectDataService.RecordOwner.cs`, new; called at `ProjectDataService.Persistence.cs` branch 347, 468 and 602).

Sequence by sequence (record of the first drawing in memory, its drawing still open, command run in the second, nothing waiting):

1. **Sequence 1 (older job B got A's 11 pits and 49 pipes): stopped.** Lock 1, and lock 2 at the forced write: not the same drawing, A still open, nothing waiting: dropped.
2. **R1: stopped** (same path).
3. **Sequence 2 (blank drawing gained A's job, changed counter 0 to 1): stopped;** nothing written, so the counter stays 0.
4. **R2: stopped.**
5. **R3, CD Settings alone: stopped** (both locks).
6. **C3, the other order (A got the second job's record): stopped** (the record is the second job's, its drawing open, A is not it).
7. **Controls:** a plain command first, then Help or Settings: nothing written now (not even the harmless path and format refresh the robot saw); a cancelled PIT and CD first: unchanged, those attach the record first. The controls stay correct; their expected results in the robot's sheet should drop the "path refreshed" note.
8. **Also closed by the same check, not seen:** a listed command ended by its window's Cancel in the second drawing before it attaches (PIT, CDMA and the rest) used to force the same write; now refused. And the startup drawing case: when the drawing CE first attached (for example an untouched Drawing1 that AutoCAD closes when a job is opened) has closed, its record is "nobody's" and is never written into the next drawing (with the BUG-1225 setting on, its default).

## 2. Both save routines, and every writer

1. **`SaveProjectData(drawing)`:** checked before a save is aimed (branch 345-348). **`FlushPendingSave(drawing)` with nothing waiting:** checked before a write is forced (466-469). **`PerformPendingSaveLocked`, the one write of the record in memory:** checked last, before `SaveToDrawing` (600-603), so every route, including a save whose drawing has gone and falls back to the active drawing (`ResolveUsableDatabase`, `Recovery.cs` 1057-1076, the BUG-385 fallback), is covered.
2. **No other writer of the record in memory:** `SaveToDrawing` has two callers, the one write and the kept-record writer (searched; the PR pins the same with a compiled-code walk). The kept-record writer writes a record kept for a drawing into that drawing only, and a closing drawing's kept record is dropped (`KeptRecords.cs` 281-294). The two other writers of the stored text (`ProjectDataService.AiAccessDrawing.cs` 97-117, `ProjectDataService.IgnoredChecks.cs` 49-59) merge into the target drawing's own stored record, never the one in memory.

## 3. How "belongs" is decided

The record belongs to the drawing it is attached to (`_currentDatabase`, compared by AutoCAD's own object identity, `LinkService.SameDatabase`), while that drawing is open; a record whose drawing has closed belongs to nobody; only when no drawing owns it at all does its stored file path count (`Rules\RecordOwnerRule.cs` 33-35). I checked that the record and "its drawing" are always set together: every place that replaces the record in memory for a drawing also sets that drawing and clears the closed mark (`Mutations.cs` 194-212 attach and switch, 72-88 failed edit, 1238-1256 committed snapshot; `Persistence.cs` 1180-1190 and 1265-1274 Undo reloads, all through `SettleKeptRecordsBeforeDrawingGoesLiveLocked`, `KeptRecords.cs` 228-238).

1. **A drawing never saved** (Drawing1): judged by identity, not name; the first CE tool that attaches it makes the record its own.
2. **Renamed by Save As:** the same drawing in memory, so still its own; the next attach refreshes the stored path.
3. **A copy of the same job open beside it:** a different drawing in memory, so refused, even though the content and folder look alike (the robot's control 5.3, where a copy hid the mix-up, now refuses too).
4. **A brand-new job whose record is still empty:** the first CE tool attaches it (`SetDrawingPath`), so the empty record is its own and is written as before (BUG-203's "never write an empty record into a Structural drawing" still applies first).

## 4. Could a real change be lost? (the worst outcome)

1. **No, in every case I followed.** A change that is waiting for the record's own drawing is re-aimed at that drawing and kept (`RecordOwner.cs` "LeaveForItsOwnDrawing"); it is written at that drawing's next command end or save, as kept records already are. It is dropped only when its drawing has closed, which the close handler already did (`KeptRecords.cs` 281-294, `DiscardPendingSaveFor`), or when CE never attached any drawing and the stored path does not name this one.
2. **If CE cannot list the open drawings** at that moment, the record is treated as not this drawing's (never written here) and a waiting change is kept, not dropped (`RecordOwner.cs` "ownDrawingMayBeOpen" uses memory only).
3. **A correct write is never stopped** by what I read: the record's own drawing always passes by identity before anything else is asked.

## 5. What the drafter sees

Nothing on screen; one line in the CE log, plain: "CE did not write its record into this drawing: the record CE is holding belongs to another drawing. Nothing was written here." (plus "The change that was waiting is kept for its own drawing." when one was kept). Right for the seen cases, where the drafter asked for nothing to be written.

## 6. The proof

1. **Rule tests** (`Drainage.Tests\Services\Bug1456RecordOwnDrawingTests.cs`): each seen sequence and control is a row of the rule with the state set by hand. Real functions, but the service's own reading of the state (`RecordMayBeWrittenIntoLocked`) is not run without AutoCAD.
2. **Compiled-plugin checks with deliberately broken copies:** the check comes before the write in all three places; three copies with the check taken out of one place each (today's writer) fail the guard; only two methods write the record. A good guard against the check being removed or moved later.
3. **Core console, `BUG-1456-CROSS-01` (`CEPROOFCROSSDRAWING`), written, not run, its project not yet compiled.** It drives the real writer through every route with a deliberately faulty version (the installed writer, which must be noticed) and a positive case (the drawing's own record still saved). Its one weakness: the "other drawing" is a database held in memory, not an open drawing, so it exercises the "record's drawing not open" branch of the check, not the seen state where the first job is still open. Both branches refuse, so it is a fair check of the writer; the seen state is the robot's.
4. **`PENDING_TESTS.md` has the row** (core console first, then the robot's two-drawing sequences on copies).

## Small (not blocking testing on copies)

1. **Run CROSS-01 before the robot** and keep its detail line: it is cheap and is the only real-code run so far.
2. **Name the drawing in the log line** when a save is re-aimed: it would show which tool asked to save into a drawing whose record CE was not holding (see "For the controller" 1).
3. **With the BUG-1225 setting turned off** (it is on by default), a closed drawing's record is judged by memory identity only, which AutoCAD can hand to the next drawing opened; the same limit BUG-1225 itself has.

## For the controller

1. **Residual door, not this PR:** a tool that changes CE's record in a drawing it never attached changes the OTHER drawing's record in memory; this PR then keeps that save for the other drawing (before it, the whole record went into this drawing). Neither is right, and no save-door check can undo a change already made in memory. The core tools I looked at attach first (PIT, CD, CDLPD, X-Civil import, `EnsureDrawingDataCurrent`), so this is rare; the cure would be a check at the record's change door. One place replaces the record without re-pairing it (`RestoreProjectData`, `Mutations.cs` 29-43), safe only because a command cannot change drawing between its snapshot and its restore.
2. **PR 2064 and this PR:** this PR does 2064's FIX FIRST 1 without a switch and more strictly (all three write doors). 2064 still lists CDHELP and CDS behind its switch and changes the same two files: expect conflicts in `LinkService.cs` and `ProjectDataService.Persistence.cs`; 2064's BUG-1456 half should go. 2064's other four FIX FIRST items (Esc leaves an owed Civil mark that the next command writes; with its switch on a real update after Esc lands in the next command's Undo step; its proof does not touch Esc, a second drawing or a positive case; its words overclaim) are untouched: head unchanged at `d64e9a72`.
3. **Drawings already contaminated** before this fix keep the other job's record. A read-only note (for example in the opening line or Check Current Drawing) when a drawing's stored record names a different file would help find them.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD: two drawings, the six sequences, Save As, a copy of the same job, a new job, closing and reopening.
3. Every caller of the record's change methods for whether it attaches first (I sampled the core tools above).
4. No client name, street, suburb or job number in the diff (checked; the core-console check uses a made-up path).
