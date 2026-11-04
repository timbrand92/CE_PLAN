# Reading the BUG-1275 crash dump (SBEAM, Thu 5 Nov 2026 08:46)

Opus investigator, Max account, Thu 5 Nov 2026. Read only: no repo file changed, nothing built, no AutoCAD, nothing uploaded. The dump was read on Tim's PC with a throwaway Python reader. No client name, drawing name or drawing content is in this file.

## FOR TIM

1. **What happened:** AutoCAD closed during your second SBEAM run, at the moment CE asked AutoCAD to open the drawing space (model or layout) to draw the new beam section into.
2. **Where it broke:** inside AutoCAD's own drawing-database code, while it checked which drawing that space belongs to. The link it followed pointed at memory that was no longer valid, so AutoCAD crashed. It was not a "missing object" and not a blank (null) reference.
3. **What it means for PR #2024:** the guard in #2024 checks "is the object erased, is it in this drawing". That check would pass here and the crash would happen exactly as before. #2024 does not fix this crash.
4. **What we still do not know:** why the link was broken. The best candidates are a drawing reference (Xref) or another drawing changing underneath, or memory damaged earlier by other code. The small crash file does not hold enough to tell.
5. **How sure:** sure (high) of where and how it broke; not sure (low) of why.
6. **Next:** add a few lines of CE logging around SBEAM (listed below), and if you agree, switch Windows to keep a full crash file for AutoCAD so the next one can be read to the end. That switch is a Windows setting only you or IT can make.

## Findings

### A. What the dump file is

1. **Dump type:** a small Autodesk crash-report minidump (about 7 MB): thread list, module list, 3.6 MB of scattered memory (100,003 small pieces, almost no drawing heap), exception record, system information. No memory-info list, so the full heap cannot be walked.
2. **Process:** acad.exe 32.0.60.0 (AutoCAD 2027), 20 CPUs, Windows 10.0.26200. AutoCAD had been running for 24 h 01 min (started Wed 4 Nov 08:45:38, dump written Thu 5 Nov 08:46:48 Melbourne time).
3. **Which thread:** the faulting thread is the first thread, named "Main/UI", the AutoCAD main thread. It was not a background, timer, finalizer or log-writer thread.

### B. The fault itself (proven)

1. **The original fault:** an access violation (0xc0000005) **in acdb26.dll** (AutoCAD's drawing database, file version 26.0.60.0) at offset 0x4401c. It was a **READ** of address **0x1**. That is a near-zero but not zero address. It is a garbage value, not a null object.
2. **coreclr.dll was only the messenger:** the second record, at coreclr.dll+0x3596cf (the one in the Windows event log), is .NET 10.0.12 re-raising the same access violation as non-continuable while it ended the process. The real fault is the acdb26 one. This explains why the event log names coreclr.
3. **The faulting code (decoded from the acdb26.dll on disk):** a small AutoCAD routine that takes an object id and finds the drawing it belongs to. In order, it:
   1. reads a flag on the id's record;
   2. if flag 0x8000 is set, follows a forward link to a second record;
   3. rounds that address down to its 2 KB block;
   4. reads the block's owner pointer at +0x7a0;
   5. reads through that pointer.
   At the crash the block was at 0x13be066d000 and its owner pointer read **1**. So step 5 read address 1.
4. **The forward link was taken:** the id's own record was at 0x15c54242820. If the link had not been followed, the block would have been 0x15c54242800. The block was 0x13be066d000, so the id carried the 0x8000 "forwarded" flag, and its forward target sat in a block whose owner pointer was garbage. The forward target was freed and reused, or overwritten.
5. **Who called it (decoded):** the caller is the AutoCAD transaction "get object" routine (acdb26+0x705b8). It was called with a non-null id, open mode 0 (For Read), and the transaction's database pointer. Its next steps are "id's drawing must equal this transaction's drawing" and "this transaction must be the top transaction". The crash happened in the first of those checks, before any object was opened.
6. **Call path on the main thread (stack scan, bottom to top):** acad.exe message loop → user32 window message dispatch → AutoCAD managed command invoker → coreclr reflection call (+0x60a3c) → about ten managed frames (they line up with the event-log stack: DrawSteelBeamSection/Run → TryPlace → ExecutePlacement → lambda → TryStage → StageOwnedEntities → RecheckAdmission → Transaction.GetObject and its wrapper) → accore.dll+0x60a76 (document transaction) → acdb26+0xaee25 → acdb26+0x705b8 → fault.
7. **Not re-entrant:** there is no Editor.GetPoint, jig, idle, timer, palette or reactor frame between the command and the fault. The crash came from the SBEAM command itself, directly in the placement step, not from an event handler running inside it.
8. **The same id value is in RecheckAdmission's frame:** 0x15c54242820 is in the managed frames at the RecheckAdmission/GetObject level. The managed stack shows the 3-argument GetObject called straight from RecheckAdmission, which matches line 378 `transaction.GetObject(database.CurrentSpaceId, OpenMode.ForRead, false)`. It does not match the layer opens inside ReadLayerStates, which would show their own frame.

### C. Modules loaded (relevant ones)

1. **Installed CE Structural:** CE_STRUC_SUITE.dll 1.0.125.0. The bundle's ProductVersion is 1.0.125+204dfad2 (Legacy, Modern and Net8 lanes all match), which is exactly origin/claude/rel-20261026s tip 204dfad2. The source read below is the code that crashed.
2. **Other CE modules in the process:** CE_CVL_SUITE 3.0.90, CE_SHARED 1.1.0.0, CE_SUITE_MANAGER 1.1.89, CE.AI.Core, CE.Diagnostics, CE.AutoCADLink.AutoCAD2027, and **four CE native modules**: ce_struc_native_2027.arx, ce_transform_2027.arx, ce_cvl_native_grip_2027.arx and ce_cvl_objects_2027.dbx. Native modules can damage memory in a way that only crashes later. That is listed under "not proven".
3. **Runtime:** coreclr, clrjit and System.Private.CoreLib 10.0.12 (10.0.1226.42308); acdbmgd, acmgd and accoremgd 26.0.60.0.

### D. CE source on origin/claude/rel-20261026s (204dfad2)

1. **Order inside one SBEAM pick:**
   1. Run loop: `CanWrite(database, plan)`. This opens `database.CurrentSpaceId` For Read through an **open-close transaction** and checks the layers.
   2. On the first pick only: `TryStart` locks the document and starts the **run transaction**, which stays open across all later GetPoint picks until Escape.
   3. `TryPlace`: `CanWrite` again (open-close transaction, same id).
   4. `TryPlace`: a new **placement transaction**, nested inside the run transaction.
   5. `TryStage` → `StageOwnedEntities` → `RecheckAdmission`. This is the first open in that nested transaction, and it **crashed**.
2. **The same drawing space opened fine milliseconds earlier:** CanWrite opened `database.CurrentSpaceId` with no user input in between and got a normal, non-Xref block (otherwise it refuses with a message). Only the regular-transaction open, which runs AutoCAD's "which drawing is this id from" check, crashed. So the space object itself could be opened. What was broken was the id's forward link to its owning drawing.
3. **One Database throughout:** CanWrite, the run transaction, the placement transaction and RecheckAdmission all use the same `database` captured once at command start (`LegacyToolCommon.TryGetActive`). All of it runs on the main thread, under the document lock.
4. **No swallowed error before the crash in the same pick:** CanWrite returned true and TryStart/StartTransaction succeeded. TryStage's catch only applies after a managed exception, and none happened. A disposed or aborted transaction would raise an ordinary AutoCAD error, not this native read.
5. **Opus's earlier doubt holds and is now sharper:** the id at the crash point is read live from the drawing, is not erased, and is in the same drawing by every check CE can make from .NET. PR #2024's SbeamStoredIdGuard checks would pass, and then GetObject would fault the same way. Its catch cannot catch an access violation under .NET 10.

### E. Structural log before 08:46:35 (5 Nov, plus the end of 4 Nov)

1. **4 Nov 17:18:51:** a second drawing was opened in the same AutoCAD session (from the office standard details library, [drawing]). At 17:24 AutoCAD went idle and stayed idle overnight (911 minutes).
2. **5 Nov 08:30:59:** input resumed.
3. **08:45:28:** CEMEMBER cancelled (2.8 s).
4. **08:45:49:** **SBEAM completed (16.1 s)**, the first run that morning, which succeeded. One object was added and one modified.
5. **08:45:53:** one more command ended (name not logged).
6. **08:46:06:** one object was erased in the drawing (an erase or an undo; the log does not say which command).
7. **08:46:11:** a BeamLink "follow" update ran on a linked beam.
8. **08:46:32:** AutoSave idle tick. The crashing SBEAM run left no line of its own, because it never ended.
9. **Not in the log:** no layout or tab switch, no Xref load/reload, no document-activation line, no REFEDIT and no undo name. The Structural log does not record those events, so their absence proves nothing. There is no 5 Nov Structural commands log file.

## What this does NOT prove

1. **Which object id kind it was:** the 0x8000 forward flag and the owner pointer at +0x7a0 are read from AutoCAD's machine code without symbols. The meanings ("forwarded id", "owner of the 2 KB block") are my reading of the code shape, not Autodesk documentation.
2. **That the id was CurrentSpaceId and not a layer id:** the managed frame order and the id in RecheckAdmission's frame point strongly to line 378. A JIT-inlined ReadLayerStates cannot be fully excluded.
3. **Why the forward target was invalid.** The candidates are:
   1. an Xref or another drawing database reloaded or freed while the space id still forwarded into it;
   2. heap damage by any native code in the process (AutoCAD's or the four CE native modules);
   3. state left over from the earlier SBEAM run, the erase at 08:46:06 or the BeamLink follow at 08:46:11.
   The minidump has no heap at those addresses (0x15c54242820, 0x13be066d000 and the database at 0x15c78c49d00 are all not captured), so none of these can be checked.
4. **That a layout or space switch happened:** nothing in the dump or the log shows one. The stack shows no transparent command or nested prompt at the crash.
5. **That SBEAM's held-open run transaction caused it:** it is the unusual part of this design (a document lock plus a transaction held across user picks, over a 24-hour session with two drawings open), but nothing here ties the bad link to it.
6. **Reproduction:** not attempted (no AutoCAD in this job).

## Proposed next job

1. **Smallest extra logging (Structural, SBEAM only, no behaviour change):** at the start of every `TryPlace` and immediately before RecheckAdmission's first open, write one log line with:
   1. `database.CurrentSpaceId.Handle` and `CurrentSpaceId.OldIdPtr` (hex);
   2. the same two values saved when the run transaction started, and whether they still match;
   3. `MdiActiveDocument.Database == database`;
   4. `TransactionManager.NumberOfActiveTransactions`, and whether TopTransaction is still the run transaction;
   5. CTAB, TILEMODE and CVPORT;
   6. the number of loaded Xrefs.
   Do NOT call `id.Database` in the logging, because that is the call that crashes.
2. **Log the outside events during an open SBEAM run:** for the run's lifetime, subscribe to and log, with drawing names replaced by a short hash:
   1. Database XrefSubCommandStart/End and XrefAttached/Detached/Reloaded;
   2. DocumentManager DocumentActivated and DocumentToBeDestroyed;
   3. LayoutManager LayoutSwitched;
   4. CommandWillStart (transparent commands).
3. **Full crash file next time (Tim or IT only, it is a Windows setting):** a Windows Error Reporting "LocalDumps" entry for acad.exe with DumpType 2 (full memory), written to a local folder. That would let the next crash be read down to the broken record and its owning drawing. It may hold client drawing data, so it stays on Tim's PC.
4. **Design option for Tim's review (not a patch yet; needs the command review gate):** stop holding the run transaction and document lock open across GetPoint picks. Commit each placement in its own transaction and group the run for one U with an undo group mark. This removes the whole "something changed while the run was open" class. It is a change to SBEAM's Undo behaviour, so it needs Tim's word. CEMEMBER is the planned replacement for SBEAM (18 Oct); check whether CEMEMBER uses the same held-open pattern before spending on SBEAM.
5. **PR #2024:** keep it as a harmless safety check if wanted, but rename it and its regression-log line so neither claims to fix BUG-1275. BUG-1275 stays OPEN.

## Clean-up done

1. **Deleted:** the unzipped dump copy `...\15291ee7-...\scratchpad\crash0508\` (minidump.dmp and info.json) and my scratch output file that held register and stack values. The reader scripts held no dump bytes and were deleted too.
2. **Left untouched:** the original crash-report zip in the Autodesk CER folder.
3. **Nothing copied:** no dump bytes, client names or drawing names were copied into any repo or into C:\CE_PLAN.
