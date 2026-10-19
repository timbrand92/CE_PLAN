# HUNT: data loss, save/close crash and silent failures (read-only audit, run 20 Oct 2026)

**Job:** Team usage governor, desk plan/03, headless, Opus. Read-only: nothing edited, built, run or opened in AutoCAD.
**Code audited (installed lineage only, never master):**
1. **Civil / Manager:** `origin/claude/rel-20261019b` (Civil 3.0.57 / Manager 1.1.57), commit 0bbf4882.
2. **Structural:** `origin/claude/rel-20261017s` (Structural 1.0.118).
Line numbers are in those commits. Private worktrees `C:\ce-hunt\dataloss-civil` and `C:\ce-hunt\dataloss-struc`, removed at the end.

**Status words:** CONFIRMED = the code path was read end to end. PLAUSIBLE = the code is wrong but the trigger (or AutoCAD's behaviour) is inferred. Nothing here has been seen in AutoCAD. No BUG numbers filed (the controller does that). Every finding was checked against `BUG_CARPARK.md` (titles and full text, by class and command name) and the earlier HUNT / AUDIT / R00 files; known ones were dropped.

**BUG-224 (the close crash):** fixed in Civil 3.0.57. `LinkService.OnDocumentToBeDestroyed` (`Modules/Drainage/Services/LinkService.cs` ~1527) no longer writes; it only drops a waiting save. About 28 other Civil close handlers and about 15 Structural ones were read: none writes to the closing drawing. One borderline handler is DS-19 (Drawing Check overlay asks the closing drawing's screen to redraw).

---

## FOR TIM: the 10 worst, in plain English

1. **Civil writes one job's pit records into another drawing.** Open job A, run PIT. Open job B, go to a layout tab and type PIT (it refuses: "cannot run in Paper Space"). On the way out CE saves A's pit and pipe records into B. Same with CDS, CDHELP, or CDMA then Esc in B. (DS-01)
2. **Civil wipes a drawing's pit records it can't read.** If the record in a drawing is damaged or was saved by a newer CE, the next PIT or PITEDIT treats it as "no record" and saves an empty one over it. Every pit level and lid in that drawing's record is gone. (DS-02)
3. **Civil brings back changes you threw away.** Change a pit cover level, close the drawing and answer No, reopen it, run PIT: the discarded level comes back and is saved. If a colleague edited the drawing meanwhile, their pit data is overwritten with your old copy. (DS-03)
4. **FASTSAVE in a new drawing can overwrite the office template.** QNEW, draw, FASTSAVE: CE saves over the .dwt the drawing came from, so every new drawing afterwards starts with that work in it. Needs one AutoCAD 2027 check to confirm. (DS-04)
5. **Structural can delete its own files while saving them.** Job record, Job Notes, office project tags, checklists, time logs: CE deletes the real file, then moves the new copy in. If OneDrive or antivirus holds the new copy at that moment, both copies are gone. (DS-05)
6. **CDJOINT: Esc deletes every joint on the slab.** Run CDJOINT on a slab with joints, Yes to "Clear and regenerate", then Esc at "Select slab type": all joint lines and SC labels vanish, nothing is redrawn, nothing is said. (DS-06)
7. **Structural Job Notes and the office project tags are wiped after one bad read.** If the notes file is half-synced, adding one note saves a file holding only that note. The office-wide project tags file goes the same way. (DS-07)
8. **ABSWITCH erases old braces, then says it left them alone.** When the BRACING block can't be found, each old brace is erased, the new one fails, and the message says "It was left as it was". The braces are gone from the plan and the schedule. (DS-08)
9. **CSBSMTWALL saves into the wrong job file.** Run it first in a fresh session and it wipes that job's wind class and soil report. Run CSWINDCLASS in drawing A, then CSBSMTWALL in drawing B, and B's answer lands in A's job file. (DS-09)
10. **Structural footings: one bad read empties the footing record.** If the footing data can't be read, the next PFC, FEDIT or schedule update saves just the one footing it touched; every other footing's size and mark is gone from the record. (DS-10)

---

## A. Civil: drawing record, save and close (Civil 3.0.57)

### DS-01. A refused or cancelled CE command writes another drawing's pit record into this drawing
1. **Severity / confidence:** HIGH (data loss, wrong data on a drawing). CONFIRMED by reading.
2. **Where:** `Modules/Drainage/Services/ProjectDataService.Persistence.cs` 435-451 (`FlushPendingSave`) and 548-570 (`PerformPendingSaveLocked`); called from `Modules/Drainage/Services/LinkService.Reactors.cs` 2028-2043 (`FlushProjectDataIfTriggerCommand`) for every command in `RecordFlushCommands` (`LinkService.cs` 61-80: CD, CDS, CDHELP, CDMA, PIT, PITEDIT, PITSCHEDULE, CDTAG, CDCALC ...).
3. **The fault:** when nothing is waiting, `FlushPendingSave(db)` sets up a save anyway and writes CE's in-memory record into `db`:
   ```
   if (!_pendingSave) { Database preferredDb = db ?? _currentDatabase ?? ...;
       ... _pendingSave = true; _pendingSaveDatabase = targetDb; }
   PerformPendingSaveLocked();
   ```
   `PerformPendingSaveLocked` then runs `SaveToDrawing(targetDb, _currentProject)`. Nothing checks that `_currentProject` belongs to `targetDb`. Switching drawing tabs does not switch the record (`OnDocumentActivated`, `LinkService.cs` 1198, memory only). The switch (`SetDrawingPath`) is only reached inside commands that get past their checks: PIT and PP return at `DrawingSafetyService.CommandPreFlight` (`Commands/PitCommand.cs` 92-93) before `SetDrawingPath` at line 101; CDTAG returns at its pre-flight (`Commands/SourceTagCommand.cs` 116-117); CDS and CDHELP never switch (`Commands/CdCommand.cs` 1537-1561); CDMA never switches, even on Esc (`Commands/CdCommand.Arrows.cs` 239-269).
4. **AutoCAD steps:** open job A, run PIT once. Open job B (Civil or Structural), click a layout tab, type PIT (refused). Or in B run CDS, CDHELP, or CDMA then Esc. Then PITSCHEDULE in B.
5. **Wrong vs right:** B's record is replaced by A's. Pit and pipe handles are small numbers that repeat between drawings, so A's records attach to unrelated objects in B. A Structural drawing gets a Civil record and Civil switches on. The BUG-203 "empty record" gate does not stop it because A's record is not empty. Right: a command that did not switch the record, or a record from another drawing, writes nothing.
6. **Fix idea:** in `FlushPendingSave`, when nothing is waiting, write only if `_currentDatabase` is the same drawing as `db`; also drop the last "active document" fallback in `ResolveUsableDatabase` (`ProjectDataService.Recovery.cs` 1075).
7. **Unit test RED:** yes. Source-contract test that the forced-save branch checks same-drawing; or pull the decision into a pure function and test "record bound to A, flush asked for B gives no write".

### DS-02. A record CE cannot read is treated as "no record" and overwritten at the next Civil command
1. **Severity / confidence:** HIGH (data loss). Code path CONFIRMED, trigger PLAUSIBLE.
2. **Where:** `ProjectDataService.Persistence.cs` 205-215, 276-278, 883, 889-893; overwrite in `ProjectDataService.Mutations.cs` 178-179 (`LoadCurrentForDrawingLocked(normalized, targetDb); SaveProjectData(targetDb, immediate: true);`).
3. **The fault:** `TryLoadFromDrawing` already tells "missing" from "unreadable", but `LoadProjectData` throws that away (`dwgData = LoadFromDrawing(targetDb)` gives null, then `return empty;`). The Undo path does this correctly (`OutsideCommandUndoPolicy.DecideHistoryReload` retries and never wipes); drawing open and drawing switch do not.
4. **AutoCAD steps:** open a drawing whose CE record will not parse (saved by a colleague on a newer CE after a field changed type, damaged by AUDIT/RECOVER, or cut short), then run PIT, PITEDIT or PITSCHEDULE.
5. **Wrong vs right:** an empty record is written over the damaged one at the start of the command, then the command saves a record holding only the new pit. All earlier levels, lids and manual rows in the record are gone. Right: "CE could not read this drawing's pit records; nothing was changed", and never save over a record that exists but could not be read.
6. **Fix idea:** give `LoadProjectData` the same read outcomes as the Undo path; keep a "do not save" flag on that drawing until a real read succeeds.
7. **Unit test RED:** yes (source contract on `LoadProjectData`, or a pure load-decision test: "record exists, parse failed, refuse").

### DS-03. Close without saving, reopen: the discarded record comes back (or overwrites a colleague's newer one)
1. **Severity / confidence:** HIGH (wrong data on a drawing). CONFIRMED by reading.
2. **Where:** `ProjectDataService.Mutations.cs` 163-167:
   ```
   if (string.Equals(Current.DrawingPath ?? string.Empty, normalized, ...)) { if (targetDb != null) _currentDatabase = targetDb; return; }
   ```
   and `LinkService.cs` ~1529 (`OnDocumentToBeDestroyed`) only drops a waiting save; the in-memory record and its path are never cleared.
3. **AutoCAD steps:** open A, PITEDIT P3 cover 20.90 to 21.50. Close A, answer No. Reopen A, run PIT or PITSCHEDULE. Variant: close A, a colleague edits and saves A on the server, reopen A, run any Civil command.
4. **Wrong vs right:** same path, so CE keeps its old in-memory record instead of reading the reopened drawing: 21.50 comes back and is saved; in the variant the colleague's pit data is overwritten. Right: once a drawing closes, the next use of that path reads fresh from the drawing.
5. **Fix idea:** in the close handler, when the closing drawing is the record's drawing, forget the in-memory record (memory only, no drawing calls).
6. **Unit test RED:** yes (source contract that the close path clears the record; or a pure "closed then reopened, reload" decision test).

### DS-11. Old AppData project files are written straight into the drawing, past the Structural and BUG-203 guards
1. **Severity / confidence:** MEDIUM. Code path CONFIRMED; trigger needs a drawing at its original path.
2. **Where:** `ProjectDataService.Persistence.cs` 210-261: when the drawing's record has no pits, pipes or manual rows, CE reads `%APPDATA%\TIM_CE_CADTOOLS\projects\CD_ProjectData_<name>_<hash>.json` and calls `SaveToDrawing(targetDb, data)` directly, skipping `PerformPendingSaveLocked`'s gates. Nothing writes these files any more, but Tim's PC has 15 from Jan-Feb 2026 (e.g. the Stockdale Ave P1 file, 11 KB, with pits).
3. **AutoCAD steps:** open that P1 drawing at its original path after its pits were deleted, or while its record holds only raingardens/slabs/rulebook entries; run PIT or PITSCHEDULE.
4. **Wrong vs right:** the February record replaces the drawing's record; raingardens, rainfall, council and rulebook entries are lost and old handle-less pits return. Right: never auto-migrate over an existing record; only into a drawing with no record, after asking.
5. **Fix idea:** remove the fallback, or limit it to "no record at all", route it through the normal gates and rename the file once used.
6. **Unit test RED:** yes (source contract: `LoadProjectData` never calls `SaveToDrawing` directly).

### DS-19. Drawing Check close handler redraws the screen of the closing drawing
1. **Severity / confidence:** LOW. PLAUSIBLE (could crash; not proven).
2. **Where:** `Modules/Drainage/Services/DrawingCheckPaletteService.cs` 293-301 calls `HideSurfaceOverlay`, reaching `SurfaceOverlayTransientService.Hide`: `TransientManager.CurrentTransientManager.EraseTransient(...)` then `_document?.Editor.UpdateScreen()`, both native calls on a dying document (an access violation there cannot be caught in .NET 10, the BUG-224 class).
3. **AutoCAD steps:** show the surface overlay in the Drawing Check palette, close that drawing with the tab X.
4. **Fix idea:** a memory-only `Forget()` for the close path.
5. **Unit test RED:** yes (source contract: close path never reaches `UpdateScreen` or `EraseTransient`).

---

## B. Civil: commands that leave half an edit or report success wrongly (Civil 3.0.57)

### DS-06. CDJOINT: Esc at the slab type question deletes every joint
1. **Severity / confidence:** HIGH (wrong output on a drawing, silent). CONFIRMED.
2. **Where:** `Modules/Drainage/Commands/CdJointCommand.cs` 76-101: `EraseJoints(doc, slab.JointSegments); slab.JointSegments.Clear();` runs before `PromptSlabTypeSpacing`; Esc there returns 0 (line ~223) and `if (spacingMm <= 0) return;` exits with no message. Same at "No SC joints generated" (101-105).
3. **AutoCAD steps:** slab with joints, CDJOINT, Enter (Yes) at "Clear and regenerate?", Esc at "Select slab type".
4. **Wrong vs right:** every joint line and SC label is gone, nothing redrawn, nothing said; the slab record still lists the erased handles (`StoreSlabs` never reached). Only an immediate U recovers. Right: erase nothing until the new grid is ready, then erase and draw in one transaction.
5. **Fix idea:** ask spacing and build the grid first; erase and draw together.
6. **Unit test RED:** no (needs AutoCAD); a source guard can check the prompt comes before the erase.

### DS-12. CDJOINT "Clear and regenerate" also deletes hand-drawn construction joints
1. **Severity / confidence:** MEDIUM-HIGH. CONFIRMED.
2. **Where:** CDCJ/CDSC joints go into the same list (`Services/SlabManualJointPlacementPlan.cs` 133-136); CDJOINT erases the whole list (`CdJointCommand.cs` 89-90) and redraws SC only.
3. **AutoCAD steps:** CDCJ against a slab, then CDJOINT, Enter at Yes.
4. **Wrong vs right:** the CJs are deleted; the prompt only says "N joint(s) already exist". Right: clear SC joints only, or say what will go.
5. **Fix idea:** filter on `Type == SC`.
6. **Unit test RED:** yes, once the clearing choice is a pure helper.

### DS-13. CDFALL / CDFALLSUGGEST: locked layer or older FALL block leaves a wrongly pointing arrow
1. **Severity / confidence:** HIGH (wrong output on a drawing). CONFIRMED by reading.
2. **Where:** `Commands/FallCommand.cs` 120-146, `Commands/FallSuggestCommand.cs` 139-158. `InsertBlock` commits first; `ApplyFallBlockOrientation` then calls `SetDynamicProperty`, which opens the block for write (`Services/BlockService.cs` 1675) and throws on a locked layer. No locked-layer check (CDSL has one). If the FALL block has no "Angle1" property, the failures are only logged (`BlockService.cs` 1928-1935) and the command prints "Fall placed. Grade: 1:80".
3. **AutoCAD steps:** lock 25CONT, CDFALL, pick point and direction, type 80.
4. **Wrong vs right:** a FALL block at its default angle, maybe a blank grade, and only "Error during CDFALL - see CE log"; or "Fall placed" over an unrotated arrow. Right: refuse before inserting; never report success when the turn failed.
5. **Fix idea:** insert, attributes and orientation in one transaction; refuse a locked layer up front; check both results.
6. **Unit test RED:** no.

### DS-14. CD: "mirror the text" leaves the pipe label unlinked
1. **Severity / confidence:** MEDIUM-HIGH (stale labels later). CONFIRMED.
2. **Where:** `Commands/CdCommand.cs` 774-779 registers the text, then `MirrorService.PromptAndMirrorText`; `Services/MirrorService.cs` 133-143 clones, adds the clone and erases the original. The clone is never registered and the return value is ignored.
3. **AutoCAD steps:** Quick Mode pipe text off, draw a pipe with CD, place text by hand, Yes to "mirror the text?", pick a mirror line. Then change the pipe size in CDEDIT.
4. **Wrong vs right:** the visible label belongs to no pipe; the pipe's link list names an erased object; later edits leave e.g. "225 DIA" on a 300 pipe. Right: the mirrored text stays the pipe's label.
5. **Fix idea:** transform the original in place, or register the new text and drop the old handle.
6. **Unit test RED:** no; a source guard can catch clone-and-erase without re-registering.

### DS-15. CDTG: a locked TRENCH GRATE layer leaves a bare grate block
1. **Severity / confidence:** MEDIUM. CONFIRMED.
2. **Where:** `Commands/SourceBlockInsertCommands.cs` 253-293: insert commits, then line 290 opens for write and throws; catch at 410-414 prints only "Error during TG".
3. **AutoCAD steps:** lock the trench grate layer, CDTG, answer every prompt.
4. **Wrong vs right:** a grate block with no tag, hitbox, label, record or pipe split; Pit Schedule never sees it. Right: refuse before inserting.
5. **Fix idea:** check the layer before the first write, or one transaction.
6. **Unit test RED:** no.

### DS-16. CDLPDRESET says "LPD cleared" but leaves the LPD note and the pipe's LPD end
1. **Severity / confidence:** MEDIUM (wrong output on a drawing). CONFIRMED.
2. **Where:** `Services/LpdService.cs` 246-296 (`ClearLpdData`) erases only the label and removes the note handle from the record; the callout is not erased; the pipe From/To "LPD" set by CDLPD (`Commands/LpdCommand.cs` 206-222) is not reverted.
3. **AutoCAD steps:** CDLPD on a pipe end, CDLPDRESET Yes, CDLPD again.
4. **Wrong vs right:** the old "LPD - CONNECT TO COUNCIL PIPE ... IL 11.97" note stays and prints; after the re-run there are two; the schedule still shows LPD. Right: all three cleared together.
5. **Fix idea:** erase the callout and restore the pipe end in the same transaction.
6. **Unit test RED:** no.

### DS-17. PITEDIT: a size edit that fails partway says "Nothing was changed"
1. **Severity / confidence:** MEDIUM. CONFIRMED by reading; trigger needs AutoCAD.
2. **Where:** `Commands/PitEditCommand.cs` 1237-1265: `UpdatePitBlock` commits the visibility state, then one dynamic property at a time, each in its own transaction. A false on any marks the step failed with no "completed" entry (616-621); `CeEditStepLedger.AnyCompleted` is false; `CeEditRetryPolicy.cs` 61-64 and 96-100 print "Nothing was changed. Your entries have been kept".
3. **AutoCAD steps:** an older pit block missing one size property, or a pit-type switch whose second size write fails.
4. **Wrong vs right:** drawing keeps the new visibility and first size; record goes back to the old size; plan and record disagree with no Undo hint. Right: report "partly applied" (or write all sizes in one transaction).
5. **Unit test RED:** partly (step-ledger test: failed-after-first-write must count as a change).

### DS-18. CDRENUMBER: a failed label refresh can leave a pit named "CDRENUMBER-TEMP-..."
1. **Severity / confidence:** MEDIUM. PLAUSIBLE (rare trigger).
2. **Where:** `Services/PitRenumberApplyService.cs` 142-161 renames the record, then `SyncPitToPlanByHandle`; if that throws the writer returns false; `TryWrite` (196-202) only remembers successes, so rollback never restores that pit, while the message says "Restored N of N".
3. **Fix idea:** the writer undoes its own rename before returning false, or always joins the rollback list.
4. **Unit test RED:** yes (fake writer: rename applied then false; assert old numbers back).

### DS-20. CDTIDYLABELS counts cover-text moves it never made
1. **Severity / confidence:** LOW (option off by default). CONFIRMED.
2. **Where:** `Services/LinkService.TidyPitText.cs` 113-121 counts at planning; refused moves at 66-75 are only logged; `Commands/TidyLabelsCommand.cs` 107 prints the planned total.
3. **Fix idea:** count successful moves. **Unit test RED:** yes.

### DS-21. COPYTOLAYER and ARRAYCLASSIC copies are not treated as copies
1. **Severity / confidence:** LOW-MEDIUM. PLAUSIBLE.
2. **Where:** `Services/ExternalMutationCommandPolicy.cs` 31-44: neither command is in the copy lists, so a pit copied this way may keep the original's number and links (same family as BUG-665, different commands).
3. **Fix idea:** add both. **Unit test RED:** yes (`CanCreateClones("COPYTOLAYER")` is false today).

---

## C. Structural (1.0.118)

### DS-04. FASTSAVE in a new, never-saved drawing can overwrite its template
1. **Severity / confidence:** HIGH (destroys a file outside the drawing). PLAUSIBLE: depends on AutoCAD 2027 still giving a new drawing's `Database.Filename` as the template path (long-standing AutoCAD behaviour, not measured on 2027).
2. **Where:** `Modules/Structural/Services/CleanPipelineService.cs` 166 calls `DrawingAutoSaveService.TrySaveNow`; `DrawingAutoSaveService.cs` 142-143 uses `TryGetNormalProjectDrawing`, which (`DrawingSafetyService.cs` 172-190) refuses only `.sv$` and `.ac$`; the `.dwg`-only check is in the idle-autosave variant (193-202) only. `ResolveDrawingPath` (318-348) prefers `Database.Filename`. Save at `DrawingAutoSaveService.cs` ~198: `db.SaveAs(drawingPath, true, DwgVersion.Current, db.SecurityParameters);`.
3. **AutoCAD steps:** QNEW from the office template (or a writable acad.dwt), draw something, FASTSAVE.
4. **Wrong vs right:** CE saves over the .dwt and prints "saved 'acad.dwt'"; Drawing1 stays unsaved; every later new drawing contains this work. Right: a never-saved drawing goes to AutoCAD's own QSAVE (Save As box).
5. **Fix idea:** in `TryGetNormalProjectDrawing`, refuse when DWGTITLED is 0 or the extension is not `.dwg`.
6. **Unit test RED:** no; accoreconsole probe: QNEW, FASTSAVE, compare template checksum before and after.

### DS-05. CloudFileHelper deletes the real file before moving the new copy in, then can delete the new copy too
1. **Severity / confidence:** HIGH (file loss). CONFIRMED.
2. **Where:** `Modules/Structural/Services/CloudFileHelper.cs` 150-198:
   ```
   File.WriteAllText(tempFile, content);
   if (File.Exists(filePath)) { File.Delete(filePath); }
   File.Move(tempFile, filePath);
   ... catch (IOException ex) { ... try { File.Delete(filePath + ".tmp"); } catch { } ...
   ```
   Used for the job record, Job Notes, office project tags, checklist templates, time CSVs and time-entry files, reports, MarkupAI files.
3. **Trigger:** OneDrive or antivirus holds the new `.tmp` for a moment during a save (common on synced folders).
4. **Wrong vs right:** if the move fails, the error handler deletes `.tmp`; after three failures neither copy exists. Even when a retry succeeds the file is missing for up to 1.5 s, and a read in that gap gives "no file", i.e. a blank record that the next save writes. User sees at most "could not be saved". Right: `File.Replace` (or move the old file aside), and never delete `.tmp` once the original is gone.
5. **Unit test RED:** yes, with a seam that makes the move fail; assert the original or `.tmp` still exists.

### DS-07. Job Notes and office project tags: one failed read, then the next save wipes the file
1. **Severity / confidence:** HIGH (data loss, shared office file). CONFIRMED.
2. **Where:** `Modules/Structural/Core/Notes/SharedNotesManager.cs` 1053-1085 (any read error gives an empty list); `AddNote` 350-369; project tags 928-955 and `SaveProjectTagsForGroup` 113-132.
3. **AutoCAD steps:** notes file half-synced, a OneDrive conflict, or cloud-only while offline; add one note (or save a project's tags).
4. **Wrong vs right:** the user's notes file holds only the new note; `Job Notes\shared_project_tags.json` (whole office) is cut the same way; error only in the log. Right: refuse to save after a failed read, one plain line.
5. **Unit test RED:** yes (broken notes_data.json, AddNote, assert old notes survive).

### DS-08. ABSWITCH erases older brace blocks, then says "It was left as it was"
1. **Severity / confidence:** HIGH (wrong output on a drawing, misleading message). CONFIRMED.
2. **Where:** `Modules/Structural/Commands/BracingCommands.cs` 395-398 and 484-499; `Services/BracingService.cs` 2169-2174 commits the erase, then 2176-2191 inserts and fails at 1669-1673 ("Block 'BRACING' not found").
3. **AutoCAD steps:** drawing with old "A - BRACING LEFT" / "B - BRACING" blocks, on a PC where CE cannot find the BRACING block file; ABSWITCH, pick the old braces.
4. **Wrong vs right:** it warns "legacy conversion may fail", carries on, erases each brace, fails to insert, and says "Could not convert one older bracing block. It was left as it was." The braces are gone from plan and schedule; one U brings them back but the message says nothing changed. Right: stop before erasing when BRACING is not loaded; insert before erase, in one transaction (AB NORMALIZE, `BracingDiagnosticsService.cs` 246, already stops when the block is missing).
5. **Unit test RED:** no; a source guard can check insert comes before erase.

### DS-09. CSBSMTWALL saves the job record without first loading this drawing's record
1. **Severity / confidence:** HIGH (data loss, wrong job). CONFIRMED. (Different from the carpark's CSBSMTWALL "Method not found / not completed" message entry.)
2. **Where:** `Modules/Structural/Services/BasementWallService.cs` 62-68; `Services/ProjectDataService.cs` 160-174, carry-over 230-313 (line 241).
3. **AutoCAD steps:** (a) start AutoCAD, open drawing B that has wind class N2 and a soil report, run CSBSMTWALL first. (b) CSWINDCLASS in drawing A, switch to B, CSBSMTWALL.
4. **Wrong vs right:** (a) an empty record plus the basement choice is saved over B's job file: wind class, soil values and unit choices gone. (b) B's basement choice is written into A's job file, B untouched, and the bracing panel rescan shows A's wind and soil for B. Right: load the active drawing's job record first, as every other job-record command does.
5. **Unit test RED:** yes (temp settings folder: load A, save as CSBSMTWALL does with B active, assert B's file unchanged / A's not written).

### DS-10. Footing record: a failed read becomes an empty record, and the next footing command saves it
1. **Severity / confidence:** HIGH (drawing data loss). Code CONFIRMED, trigger PLAUSIBLE.
2. **Where:** `Modules/Structural/Services/FoundationRegistryService.cs` 290-339: `catch { return new FoundationRegistryData(); }`, kept in memory; written back by `NoteScheduleOutOfDate` (108-115) and `SaveCore` (367-404).
3. **AutoCAD steps:** footing data that will not parse (newer CE with a changed field, damaged data), then PFC, FEDIT or a footing schedule update.
4. **Wrong vs right:** every other footing's size, mark and links in the record are replaced by the one footing touched, silently. Right: refuse footing commands with one plain line; never save over an unreadable record.
5. **Unit test RED:** partly (memory can be faked; full path needs accoreconsole with a broken record).

### DS-22. Structural job record: a read error is treated as "no record"
1. **Severity / confidence:** MEDIUM-HIGH. CONFIRMED. Structural twin of Civil BUG-827.
2. **Where:** `Modules/Structural/Services/ProjectDataService.cs` 33-57: error to Trace only, then `_current = new ProjectData();`.
3. **AutoCAD steps:** job file locked or half-synced for a moment; CSWINDCLASS, CSSOILREPORT, CSUNITTAGS or CSUNITTOOLS, answer one question.
4. **Wrong vs right:** save writes standard values for everything else: soil report, wind class, lintel rules, schedule placements lost. Right: "can't read" stops and says so.
5. **Unit test RED:** yes.

### DS-23. Checklist templates: if every read fails, the standard templates overwrite the office's edited ones
1. **Severity / confidence:** MEDIUM. CONFIRMED.
2. **Where:** `Modules/Structural/Core/Checklist/TemplateManager.cs` 58-104 (`if (_templates.Count == 0)` at 94 then `CreateDefaultTemplates` with fixed IDs "civil_xref", "res_single" ...); `SaveAllTemplates` 1290-1316 deletes every template file before writing any back.
3. **AutoCAD steps:** OneDrive Templates folder cloud-only while offline, open the Checklist palette.
4. **Fix idea:** create defaults only when the folder has no .json; write new files before deleting old ones.
5. **Unit test RED:** yes.

### DS-24. FASTSAVE's fallback QSAVE is counted as saved without checking
1. **Severity / confidence:** MEDIUM. PLAUSIBLE.
2. **Where:** `CleanPipelineService.cs` 173-177 and 299-303. Also: on a `.dxf` drawing CE's own save writes DWG format into the .dxf name (only the .bak survives readable); and `DrawingAutoSaveService.cs` 627-631 never sets the unsaved-changes flag for drawings named "_CVL_", so `CeSheetsIssueService.cs` 222-234 never warns for them.
3. **AutoCAD steps:** FASTSAVE on a read-only drawing, cancel the Save As box: CE marks it clean and Publish Issue no longer warns about unsaved changes.
4. **Fix idea:** decide from DBMOD after the save; send non-.dwg drawings to AutoCAD's QSAVE.
5. **Unit test RED:** no.

### DS-25. Checklist note text with a backslash is mangled; a failed read shows "No Checklist"
1. **Severity / confidence:** LOW-MEDIUM. CONFIRMED.
2. **Where:** `Core/Checklist/ChecklistItem.cs` 167-183 (unescape in the wrong order: "S:\road\new" comes back with line breaks, saved that way on the next tick); `Core/Checklist/ChecklistStorage.cs` 98-102 (any read error returns "no checklist"; picking a template then overwrites the drawing's ticked checklist).
3. **Unit test RED:** yes (save and re-read one item).

---

## D. Settings and other files on disk (Civil 3.0.57 / Manager 1.1.57)

### DS-26. A second AutoCAD's routine save puts Civil Settings back to old values (Civil twin of BUG-840)
1. **Severity / confidence:** MEDIUM-HIGH. CONFIRMED.
2. **Where:** `Modules/Drainage/Services/SettingsService.cs` 576-579 (`if (core != null && core == _writtenCore && File.Exists(_settingsFilePath)) return;` compares only with this session's last write). Routine saves from `Commands/CdJointCommand.cs` 232-234, 254-256, 266-268; `ViewModels/Shell/CeEditorShellStateStore.cs` 101-102; `Services/UsageTipService.cs` 45-46; `FasterWayAdviceService.cs` 43.
3. **AutoCAD steps:** AutoCAD A and B open. In A, CDS, max pipe velocity 3.0, save. In B, run CDJOINT and pick a slab type (or open/close a section in a CE edit window, or a first-use tip).
4. **Wrong vs right:** B writes its whole old copy; next start reads 6.0, silently. Right: reload before a routine save and apply only the changed values.
5. **Unit test RED:** yes (two instances on one temp file).

### DS-27. Parts catalogue: an unreadable file silently becomes standard values; the next CDPARTS save writes them over the engineer's catalogue
1. **Severity / confidence:** MEDIUM-HIGH. CONFIRMED.
2. **Where:** `Modules/Drainage/Services/PartsCatalogueService.cs` 39-50 (`LoggingService.Info(... "Failed to load catalogue — seeding defaults" ...)`, `_catalogue = BuildDefaults();`) and 141 (`File.WriteAllText(_cataloguePath, json);` in place); `ViewModels/PartsCatalogueViewModel.cs` 90-95, 201.
3. **AutoCAD steps:** `parts_catalogue.json` locked or half-written; CDPARTS shows the standard list; add one pit, Save.
4. **Wrong vs right:** every custom pit and pipe entry gone, no message; a second AutoCAD's save also reverts the first. Right: warn, keep a ".bad" copy, refuse to save until read; temp-and-swap write.
5. **Unit test RED:** yes.

### DS-28. CDLABELSTYLE: unreadable label-style file overwritten with defaults on open; Save says "Saved." when it failed
1. **Severity / confidence:** MEDIUM. CONFIRMED.
2. **Where:** `Modules/Drainage/Services/LabelStyleService.cs` 287-300, 333-344 (`// File missing or corrupt — seed defaults and write them out`), 254-270 (Save failure only logged); `ViewModels/LabelStyleDialogViewModel.cs` 216, 248-250 (`StatusText = "Saved.";`).
3. **AutoCAD steps:** corrupt or briefly locked `label_styles.json`, run CDLABELSTYLE (custom styles replaced on disk at open). Or make it read-only, edit a template, Save or "Apply to all".
4. **Wrong vs right:** "Saved." then the old file reloads; "Apply to all" rewrites pit cover/IL text in the drawing with the old style. Right: never seed over an existing file; Save reports failure.
5. **Unit test RED:** yes.

### DS-29. Civil monthly time log rewritten in place with a lock that covers one AutoCAD only: hours lost or counted twice
1. **Severity / confidence:** MEDIUM-HIGH. Path CONFIRMED, triggers PLAUSIBLE.
2. **Where:** `Modules/Drainage/Services/JobTimeCsvLogger.cs` 22 (`private static readonly object Lock`), 97-124, 209-210, 227 (`File.WriteAllText(path, string.Join(...))`; on failure "will append instead" adds a second row with the same Session ID); `JobTimeWeeklyExportService.cs` 50, 146-147, 161-168 (sums every row, never removes duplicates; a locked file is skipped by `catch (IOException) { continue; }` but the week's marker is still written).
3. **Wrong results:** two AutoCADs both rewrite and one session's row disappears; a crash mid-rewrite truncates the month; a brief OneDrive lock duplicates a row and the weekly export doubles those hours; CSV open in Excel at close loses the last minutes; a skipped person is missing from that week's export for good. Right: Structural's lease and session merge (`TimeEntryFileService`), temp-and-swap, and no marker when a file was skipped.
4. **Unit test RED:** yes (fail the rewrite once, assert one row per Session ID; or feed the export two rows with one ID).

### DS-30. CDXREFCOMPARE fails on every run after the first when the background Xref is read-only
1. **Severity / confidence:** MEDIUM. Path CONFIRMED, trigger PLAUSIBLE.
2. **Where:** `Modules/Drainage/Services/BackgroundXrefSnapshotCacheService.cs` 47 (`File.Copy(sourcePath, snapshotPath, overwrite: true);` keeps the read-only mark, and Windows refuses to overwrite a read-only target); `Commands/BackgroundXrefCompareCommand.cs` 70, 88, 113.
3. **Wrong vs right:** second run throws "access denied"; other Xrefs are never compared and the baseline is never refreshed. Right: clear the read-only mark after copying.
4. **Unit test RED:** yes.

### DS-31. CDNEWDWG makes a read-only job drawing when the office template is read-only
1. **Severity / confidence:** MEDIUM. Path CONFIRMED, trigger PLAUSIBLE.
2. **Where:** `Modules/Drainage/Commands/NewJobDrawingCommand.cs` 92-94 (`File.Copy(sourcePath, destinationPath);` then `DocumentManager.Open(destinationPath, false)`).
3. **Wrong vs right:** the new job drawing opens write-protected, title block filled, QSAVE refuses, and the drafter is told to "save it when you are ready". Right: clear the read-only mark on the copy.
4. **Unit test RED:** yes (copy step).

### DS-32. Civil Settings change history wiped when its file is damaged, despite the comment
1. **Severity / confidence:** LOW-MEDIUM. CONFIRMED.
2. **Where:** `Modules/Drainage/Services/SettingsHistoryService.cs` 58, 72, 118-123 (comment: "The damaged file is left on disk for support to look at"; the next change runs `File.WriteAllText` over the same path, in place).
3. **Fix idea:** move the damaged file aside first; temp-and-swap. **Unit test RED:** yes.

### DS-33. Export failures not reported in plain words
1. **Severity / confidence:** LOW-MEDIUM. CDDASHBOARD CONFIRMED; Pit Schedule PLAUSIBLE.
2. **Where:** `ViewModels/DesignCheckDashboardViewModel.cs` 644-650 (CSV export catch only logs; with the file open in Excel nothing appears, same as success). `ViewModels/PitScheduleViewModel.Schedule.cs` 68 (`new StreamWriter(dialog.FileName)`, no catch) reaches `DialogService.cs` 185-199: "[CE] Pit Schedule rendering error — see CE log".
3. **Right:** "Could not save: the file may be open in Excel. Close it and try again." (as the Excel export at 128-137 already does).
4. **Unit test RED:** partly (needs the export split from the dialog).

### Small notes (LOW, not numbered)
1. `Learning/LearningService.cs` 497-501 deletes the file before moving the new one in; a second session reading in that gap starts with nothing learned and its next save keeps only its own.
2. The Civil job-time resume cache and window-position file: last AutoCAD to save wins.
3. The weekly export file name is the same for every person in the shared folder; one shared marker decides which PC generates it.

---

## Checked and clean (so nobody re-hunts them)
1. **Close handlers:** no Civil or Structural `DocumentToBeDestroyed` handler writes to the drawing (BUG-224 fix holds); DS-19 is the only native screen call.
2. **Civil side drawings:** every `ReadDwgFile` side drawing is read-only; no Civil code saves a side database or Save As copy.
3. **Record size:** largest real Civil record in Tim's logs 252 KB against the 4 MB read limit.
4. **Idle and REDO:** Civil Idle transactions are open-close or wait for the REDO window; Structural Idle handlers read open-close or only start a command.
5. **Core Civil link / record / Undo code:** checks before writing, rolls the record back on a failed edit, reloads after U.
6. **Structural grip previews and SBEAM edits:** previews draw from copies; SBEAM writes in one go with a check after.
7. **Files that already write safely:** `CeMessageFileStore`, `HelpStateStore`, `CeDiagnosticRunFileStore`, the Civil remembered-values file, Manager `CeJsonService` (temp and swap); `FeedbackService` reports failure; `CeSupportBundleService` lists what failed; CDCHECKDWG reports fall back to the CE folder then Temp; CDCALC XLSX export shows an error; CDSPINEUPGRADE rollback file checked against the drawing fingerprint; `JobRecordService.Save` has no callers.

---

## Summary
Read-only audit of the installed lineage (Civil 3.0.57 / Manager 1.1.57 on `claude/rel-20261019b`, Structural 1.0.118 on `claude/rel-20261017s`), with four of the worst claims (DS-01, DS-04, DS-05, DS-06) re-read in the source by the controller session. The BUG-224 close crash is fixed and no other close handler writes to a dying drawing, but the hunt found 33 new defects. The most dangerous group is Civil's in-drawing pit record: a forced save at the end of many commands writes whatever record CE holds in memory into the current drawing without checking whose it is (DS-01), an unreadable record is replaced by an empty one (DS-02), and a reopened drawing gets the discarded in-memory record back (DS-03). All three can silently overwrite pit levels and lids, and source-contract unit tests can show each RED. The second group is "a failed read becomes defaults, then the next save writes them": Structural job record, footing record, Job Notes, office project tags, checklist templates, Civil parts catalogue and label styles. Structural's shared file writer also deletes the real file before the new one is in place (DS-05). The third group is half-done drawing edits that report success or say nothing: CDJOINT Esc deletes every joint (DS-06), ABSWITCH erases braces and says it left them (DS-08), CDFALL and CDTG on locked layers, CD mirror-text unlinking the label. One finding needs an AutoCAD 2027 check before fixing: FASTSAVE on a never-saved drawing overwriting its template (DS-04). Nothing here has been seen in AutoCAD; no BUG numbers were filed.
