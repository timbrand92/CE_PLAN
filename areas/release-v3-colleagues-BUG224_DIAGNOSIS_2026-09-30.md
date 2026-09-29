# BUG-224 diagnosis: crash closing a drawing after Save As (30 Sep 2026)

Opus diagnostician (claude-opus-5-5), 30 Sep 2026, read-only. No code changed. The dump was copied to the session scratchpad (SHA256 identical to the original, original untouched) and read offline: no symbol server, nothing sent anywhere.

## Verdict

**CE implicated: YES.** The crashing thread is running CE Civil code. When the drawing closed, CE Civil's close handler wrote the Civil project record into the closing drawing; that write called into AutoCAD, AutoCAD's own code hit an access violation, and .NET 10 then terminated AutoCAD (which is why Windows names `coreclr.dll`). Structural and Manager are not on the crashing stack.

## 1. Tool used

1. **Debugger found, nothing installed:** WinDbg (Store app `Microsoft.WinDbg 1.2603.20001.0`) was already on the PC; its console debugger `cdb.exe` and its bundled SOS (.NET) extension were used. The BUG-164 note "no debugger installed" is out of date. `dotnet-dump` is not installed (only dotnet-counters, dotnet-stack, dotnet-trace, dotnet-ef, ilspycmd).
2. **Offline only:** symbol path set to an empty local folder and the SOS symbol server disabled. AutoCAD frame names below are therefore the nearest EXPORTED names, not true function names: treat them as addresses, not as a description of what AutoCAD was doing.

## 2. DOCUMENTED FACT (read from the dump and the Windows log)

1. **Dump:** minidump of acad.exe PID 0x1018, written 07:55:13 30 Sep, process up 1 h 37 min. Installed versions read from the loaded DLLs: Civil `3.0.15+a6e0cc87`, Manager `1.1.15+a6e0cc87`, Structural `1.0.86+532f9550`, CE_SHARED `1.1.0+inspector-contract.1.a6e0cc87`, AutoCAD accore `26.0.60.0`, .NET `10.0.12` (coreclr 10.0.1226.42308).
2. **Original fault:** access violation reading address `0x2e` (a null pointer plus 0x2e) inside AutoCAD's `accore.dll`, on the main (UI) thread 0.
3. **Crashing stack, main thread, innermost first (managed frames exact, AutoCAD frames approximate):**
   1. AutoCAD `accore` (fault), then `acdb26 AcDbImpEntity::regenerate` / `AcDbQuickSpaceIterator::regenEntity`, then `accore generateQueuedGraphics` (approximate names).
   2. `acdbmgd` P/Invoke stub taking one pointer (the AutoCAD .NET wrapper calling native code).
   3. **`CE_CVL_SUITE ProjectDataService.SaveToDrawing(Database, ProjectData)`**
   4. **`CE_CVL_SUITE ProjectDataService.PerformPendingSaveLocked()`**
   5. **`CE_CVL_SUITE ProjectDataService.FlushPendingSave(Database)`**
   6. **`CE_CVL_SUITE LinkService.OnDocumentToBeDestroyed(object, DocumentCollectionEventArgs)`**
   7. `accoremgd DocumentCollection.FireDocumentToBeDestroyed`, then native `accore AcApDocManager::appContextCloseDocument` (approximate name).
   8. `acad` then `oleaut32 DispCallFunc`, `rpcrt4 NdrStubCall2`, `combase`: an incoming COM automation call dispatched from the main window's message loop. This is Codex's `Document.Close(false)`.
4. **Termination:** .NET converted the uncatchable access violation into `System.ExecutionEngineException` on thread 0 and called `RaiseFailFastException`; that is the `coreclr.dll` "faulting module" in the Windows event.
5. **Windows .NET Runtime event 1026, 07:55:00**, independently lists the same managed stack: SaveToDrawing, PerformPendingSaveLocked, FlushPendingSave, LinkService.OnDocumentToBeDestroyed, FireDocumentToBeDestroyed.
6. **Other threads:** no other CE code was running. The CE log writer (CE_SHARED `CeLogWriter`) was idle with an empty queue (so the Civil log lost nothing queued); no CE timer or thread-pool work was active; no Structural or Manager managed frames on any thread. One thread was a Windows UI Automation call waiting on the main thread (a UI-inspection client, possibly Codex's), not CE.
7. **History:** the Windows Application log since 23 Sep 12:30 holds only this one acad.exe crash (event 1000/1026). No other close crash in 7 days of use.

## 3. CE code that runs at close (origin/claude/rel-20260929c a6e0cc87; -struc 532f9550)

1. **The crashing path, Civil `Modules/Drainage/Services/LinkService.cs` `OnDocumentToBeDestroyed`:** if the closing drawing is CE's current project drawing, it calls `ProjectDataService.FlushPendingSave(closingDb)`. It takes no document lock.
2. **`ProjectDataService.Persistence.cs` `FlushPendingSave`:** when NO save is pending it sets one up anyway (`_pendingSave = true`) and writes. So every close of the current Civil project drawing writes the project record, whether or not anything changed.
3. **`SaveToDrawing`:** opens the Named Objects Dictionary for write, writes the JSON Xrecord, commits. The one-pointer P/Invoke on the stack is most likely the transaction Commit (or its Dispose); the dump's JIT code pages are not saved, so this is not proven.
4. **CE's own comments already warn about this spot:** `OnDocumentToBeDestroyed` says a flush there on a plot-temp database "produces an ExecutionEngineException" (guarded only for that case); `SaveToDrawing` says a native call on a freed database in .NET 10 is uncatchable. The BUG-190 comment on `OnBeginDocumentClose` says a write in `OnDocumentToBeDestroyed` only updates the in-memory drawing that nothing saves afterwards: the close-time write has no data value.
5. **Other close handlers (not on the stack, listed for completeness):** Civil has about 15 more `DocumentToBeDestroyed` handlers (AdminTelemetry, CdHelp, CivilHelpHost, CivilJobTime, CivilOwnershipHighlight, CivilProjectQaAutomatic, CivilProjectQaRegistration, CivilDrawingRepairRegistration, CivilSelectionObserver, CeAssistantControl, CalculationsV2Dialog, SlabCommand) plus `OnBeginDocumentClose` (locks and flushes only when a save is waiting). Structural has about 10 (DimensionCommands, AdminTelemetry, CeToolsInitializer, BeamTransientDocumentLifetime, DrawingAutoSave, FoundationMonitor, RuntimeDiagnostics, StructuralFrameGripOverrule, JobTimeTracker) and Idle handlers (DrawingAutoSave, FoundationMonitor, RibbonCommandHub, StatusBarIndicator, StructuralGripEditQueue). None of these appear in the dump.

## 4. OBSERVED IN THE LOG

1. Civil log ends 07:52:38; the writer queue was empty at the crash, so Civil genuinely logged nothing from the Save As to the crash. The close-time write logs nothing before it runs, and its "Project data saved to DWG successfully" line comes after the commit that crashed.
2. Structural logged `BeamLink.ObjectModified: 132 call(s)` at 07:55:00.592, the same second as the .NET crash event (07:55:00). Which drawing those 132 events were on is Unknown.

## 5. HYPOTHESIS (not proven)

1. **Strongest:** committing a write into a drawing that is already being torn down makes AutoCAD refresh queued graphics for that drawing; its display state is already gone, so AutoCAD reads a null pointer. What AutoCAD does internally is closed and not claimed here; only "CE's write led into the AutoCAD code that faulted" is fact.
2. **Why user closes have not crashed (7 days, none logged):** the BUG-190 comment records that an X / CLOSE / QUIT close holds no document lock, so this same write normally fails with LockViolation (caught, harmless). The COM `Document.Close(false)` route evidently let the write through to the commit. Unproven: the lock state at the moment of the crash is not in the dump.

## 6. COM close against a user's close

1. **Fact:** the COM call ran the close synchronously inside the COM dispatch on the main thread and fired CE's `DocumentToBeDestroyed` handler from there.
2. **Untested:** whether Ctrl+S then X, CLOSE, CLOSEALL or QUIT reach the same commit, and whether any of them crash. The same CE handler runs on every route, so it cannot be ruled out for colleagues.

## 7. Relation to BUG-164 and to the Redo-after-Undo work (PR #408, BUG-192)

1. **BUG-164:** different code (palette `Shutdown` on QUIT, fixed and installed), same class of fault: CE managed code calling native AutoCAD during teardown, giving an uncatchable access violation that .NET 10 reports as a coreclr.dll crash. Not a return of BUG-164.
2. **BUG-192 / PR #408:** same family, not the same code. This is again "CE writes the project record outside a command". The five U / REDO steps are NOT needed for this write: `FlushPendingSave` writes on every close anyway. Whether the Undo/Redo left queued graphics that made the refresh fault: Unknown.

## 8. Suggested fix (for the fix chat; nothing done here)

1. **In `LinkService.OnDocumentToBeDestroyed`, stop writing to the closing drawing.** Drop the `FlushPendingSave` call and only clear CE's pending-save state for that drawing (and log it if a save was still owed). Writing there saves nothing to disk (the BUG-190 comment), and it is the crashing call.
2. The real safety net stays where it is: `OnBeginDocumentClose` (locks, flushes, sets DBMOD so AutoCAD asks to save) and `OnDatabaseBeginSave`.
3. Separately, review `FlushPendingSave`'s "write even when nothing is pending" for any other teardown caller.
4. Guard test: a source-contract test that `OnDocumentToBeDestroyed` never calls `FlushPendingSave` or `SaveToDrawing`.

## 9. Probe to confirm (Codex, on copies, full AutoCAD 2027)

1. **Before the fix (optional, to prove the route):** the C1 sequence (CleanBlank copy, CDDISCIPLINE Civil / Structural x5, five U, five REDO, set Civil, Save As a new copy, COM `Document.Close(false)`), three times. Then the same by the user route (Ctrl+S then X, and CLOSE), three times each. Record each crash, and read any new dump with the WinDbg `cdb.exe` already on the PC.
2. **After the fix:** the same runs; pass = no crash, no new `acad.exe.*.dmp`, no .NET Runtime event 1026, the saved copy reopens with Civil set.
3. accoreconsole is not a fair repro: it has no graphics display and no COM `Document.Close`, and the fault is in the graphics refresh.

## 10. For Tim, in AutoCAD terms

AutoCAD crashed because, as the drawing was closing, the Civil suite tried to write its project settings into that drawing one last time. By then AutoCAD had already started dismantling the drawing, and the write knocked it over. That last write has no value (nothing saves the drawing after that point), so the fix is to stop doing it. Your data is protected earlier: CE writes its settings before AutoCAD asks "save changes?".
