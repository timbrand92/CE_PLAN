# TEAM AUDIT T4 — Data integrity, adversarial — 24 October 2026 (Melbourne)

## ANSWER FIRST

1. **Counts: 30 new findings — HIGH 3 / MEDIUM 18 / LOW 9.** 19 are SURE (code path read end to end). 6 are SURE on CE's code but include one untested AutoCAD step. 5 are UNSURE. Nothing was run in AutoCAD, built or tested.
2. **Top 1 — an older CE quietly deletes newer job data (T4-01, HIGH).** A colleague whose CE is a few weeks behind edits one pit in your drawing. On the next save CE writes back only the parts of the job record that their version knows. Project Review approvals, ignored check findings, paused features and held-back plan labels are all lost, with no message. The "this drawing was saved by a newer CE" warning cannot fire, because the version marker has read "2.2" since 25 August.
3. **Top 2 — one damaged Structural footing record wipes the whole footing register (T4-02, HIGH).** If the footing register cannot be read, CE treats it as empty. The next PFC or THC then saves that empty register over it. Earlier footings stay on screen but stop updating, and the footing schedule loses their rows. Nothing is said.
4. **Top 3 — on older AutoCAD, one downpipe in a COPY cancels the copy clean-up for every pit and pipe in it (T4-03, HIGH).** Copy six pits, their pipes and one downpipe on AutoCAD 2022–2024. Every copy is left as a "twin" of its original: same pit number, no schedule row, and it still claims the original's labels. The error goes to the log only.
5. **Already-known bugs found again (not counted):** BUG-971, BUG-1070, BUG-788, BUG-1044, BUG-799, BUG-795, BUG-803, BUG-793, BUG-665, BUG-758. A note on BUG-665 is in "What I did not check".

---

## Scope and method

1. **Code read:** Civil 3.0.72 / Manager 1.1.72 at `origin/claude/rel-20261023m` commit `f7f7d551`. Structural 1.0.122 at `origin/claude/rel-20261023s` commit `e6d597c0`. Both were read in detached, read-only worktrees at `C:\ce-ta\t4m` and `C:\ce-ta\t4s`. All Civil paths below are under `Modules/Drainage/`; all Structural paths are under `Modules/Structural/`.
2. **Method:** six parallel read-only readers, each covering one area: pit/pipe records, copied objects, the design snapshot, Xrefs and DXF, Structural records, and CE pipes on PCs without the CE pipe-object add-on (the "enabler"). I re-read the key lines of every HIGH finding and of most MEDIUM ones myself.
3. **Duplicate check:** every finding was checked against `BUG_CARPARK.md` (up to BUG-1087), `CODEX_AUDIT2_RD01`–`RD22`, `CODEX_HUNT_RECORDS_22OCT.md` and the 22 Oct audits.
4. **Changes made:** none. I wrote only this report. There was no build, no test run, no AutoCAD and no deploy.

---

## Findings (ranked)

### HIGH

1. **T4-01 — An older CE silently deletes newer parts of the job record, and the "newer CE" warning can never fire. HIGH, SURE.**
   - **Where:**
     - `Models/ProjectData.cs:10`: the job record has no catch-all for unknown fields. Pits and pipes do have one (`Models/PitData.cs:260`, `:512`).
     - `Services/ProjectDataStorageContract.cs:12`: `CurrentSchemaVersion = "2.2"`, unchanged since commit `05e4be0d` (25 Aug).
     - Fields added since then without raising the version: `PlanLabelsHeldBackByLocks` (2 Oct, `7a47f825`), `IgnoredChecks` (9 Oct, `636952cf`), `PausedFeatures` (9 Oct, `9ea6d494`), and Project Review approvals (27 Sep).
     - The save writes the whole record from this build's own list of fields (`Services/ProjectDataService.Persistence.cs:1121-1124`).
     - `NormalizeProjectData` also stamps the version back to "2.2" (`Services/ProjectDataService.Mutations.cs:1967`). Even when a later version is bumped, the warning at `Persistence.cs:597-609` shows once and is then erased by the next save.
   - **What the office sees:** Tim ignores three CDCHECKS cover findings and approves the review on 3.0.72. A colleague on an older 3.0.6x build changes one pit's lid type and saves. Back on Tim's PC the three findings are back, the approval is gone and held-back labels are forgotten. Nobody is told at any point.
   - **Smallest fix:** add a catch-all for unknown fields to `ProjectData` and its nested lists. Bump the version marker whenever a field is added. Never write a lower version over a higher one, and hold the save the way BUG-971 intends.
   - **Not a duplicate:** BUG-971 covers a record that cannot be read. Here the record reads fine and still loses data.

2. **T4-02 — Structural: a damaged footing register is read as empty, then saved over by the next footing command. HIGH, SURE (code path).**
   - **Where:** `Services/FoundationRegistryService.cs:336-339`: `catch { return new FoundationRegistryData(); }`. Any failure to read becomes "no footings". That empty register is cached (`:30`) and written back by any of the 17 `Save` callers, for example `FoundationService.cs:1270`. The write is `FoundationRegistryService.cs:409`.
   - **What the drafter sees:** a slab plan with 40 pad footings has its register damaged (see T4-20 for one possible cause). The next THC places footing 41. Footings 1–40 still show on screen, but no longer follow edits and drop out of the footing schedule. No message.
   - **Smallest fix:** keep "no register" separate from "unreadable register". When it is unreadable, refuse every footing save with one plain line and leave the stored register untouched.
   - **Not a duplicate:** CODEX_HUNT_RECORDS R-02 / BUG-971 is the same pattern in Civil only.

3. **T4-03 — On older AutoCAD, one downpipe in a COPY cancels the copy clean-up for every pit and pipe in that COPY. HIGH, SURE in code (MIRROR case UNSURE).**
   - **Where:**
     - `Services/LinkService.Utilities.cs:340`: every copied downpipe goes through `RemapCloneSourceInTransaction`, inside the same single write as all copied pits and pipes.
     - That routine throws "Source COPY requires one exact AutoCAD placement map" when AutoCAD's copy map is missing (`Services/LinkService.SpineClones.cs:24-27`). It also throws "not a qualified translation" when rotation or scale differ (`:31-34`).
     - The copy map only exists in the 2027 build: `Services/SourceCloneMapNativeBridge.cs` is compiled under `#if NET10_0_OR_GREATER` and returns null otherwise.
     - The whole write is caught at `LinkService.Utilities.cs:529-531` and logged as "inner pass failed". Nothing is committed and nothing is shown.
   - **What the drafter sees:** on AutoCAD 2022–2024 (CE's older build), COPY P1–P6 with their pipes and DP1. Every copied pit keeps its original's number, has no schedule row and still claims the original's labels. These are the BUG-665 symptoms, and the "levels to check" line never prints. On 2027 the same thing happens if the downpipe's label layer is locked, and possibly for MIRROR (UNSURE: not traced whether MIRROR reaches this pass).
   - **Smallest fix:** check each downpipe before the shared write and leave out the ones that would fail, with one plain line. Do not let one downpipe abort the pits and pipes.

### MEDIUM

4. **T4-04 — On a PC without the CE pipe-object enabler, CDSYNC and every relink empty all pits' pipe lists, with no warning anywhere. MEDIUM, SURE.**
   - **Where:** `Commands/LinkCommands.cs:154-172`: every pit gets `ClearPitPipeLinks` (`Services/LinkService.Registration.cs:561`, `pitData.Pipes.Clear()`), but only `ent is Polyline` pipes are registered back. On a PC without the enabler the CE pipe objects are proxy objects (stand-ins AutoCAD shows for unknown objects), not polylines.
   - **Same pattern:** `RelinkAllPipesToPits` (`Services/LinkService.RepairAudit.Relink.cs:502`, `:526`) does the same. It is reached from CDREBUILDLINKS, the Pit Schedule's "Relink and recalc" and "Restore hidden links", CDUPGRADE, and the automatic merge in `ProjectDataService.cs:852`.
   - **No guard exists:** "ProxyEntity" appears only in the X-Civil import code. CDGRAPH reports "Floating node (no pipes)" (`Services/LinkService.RepairAudit.Graph.cs:103`). CDCHECK leaves the pipes out (`Services/LinkService.Spine.cs:666-669`).
   - **What the office sees:** a colleague on AutoCAD 2024 runs CDSYNC on Tim's drawing. It reports "Pits relinked: 40, Pipes relinked: 3" and says nothing about the 50 CE pipes it skipped. Back on 2027, moving a pit leaves those pipes behind until someone happens to run CDSYNC. The pipes' own records survive, so the damage can be repaired, but nobody is told it is needed.
   - **Smallest fix:** one shared check that sees CE pipe proxies (`ProxyEntity.OriginalDxfName == "CE_CVL_PIPE_OBJECT"`). These commands then refuse with one plain line, and a one-line notice appears at open.

5. **T4-05 — Structural: placing a column at the end of a natively COPYed beam makes the copy take over the original beam's links. MEDIUM, SURE (label movement UNSURE).**
   - **Where:** `Services/BeamLinkService.cs:74-82`: `BeamLinkData data = existing ?? new BeamLinkData(); data.BeamHandle = handle;`. This keeps the original's attachments and only renames the owner. It is reached from `RegisterBeam` (`:419`) after every C1/C2/DS placement (`Commands/SupportBlockCommands.cs:410`).
   - **What the drafter sees:** COPY beam B3 to the next bay, then place a column under the copy. The copy now "owns" B3's label and B3's other column. A later CE "beams follow" edit can plan B3's label as the copy's (`ConnectedFollowApply.cs:349`), so moving the copy may drag B3's label across.
   - **Smallest fix:** in `RegisterBeam` and `RegisterAttachment`, treat a record whose stored owner is a different beam as a copy, and start it empty.

6. **T4-06 — A pasted downpipe keeps a link to the original's label, so MOVE or CDREPAIR acts on the wrong object. MEDIUM, mostly SURE (the MOVE trigger is UNSURE).**
   - **Where:** downpipe label and hitbox links are stored as plain handle text (`Services/SourceTagService.cs:858`, `:922`). `TryGetLabelId` (`:781-830`) accepts whatever object has that handle, without checking its type or its owner. A same-drawing paste of a downpipe is not cleaned up (`LinkService.Utilities.cs:1335-1339`, refusal near `:676-688`). CDREPAIR then re-owns that label to the copy (`RepairAudit.Relink.cs:169` → `Registration.cs:770-791`).
   - **What the drafter sees:** Ctrl+C / Ctrl+V of DP1 gives two DP1s. Running CDREPAIR, as CE advises after a paste, moves ownership of the original DP1 text to the pasted copy. Pasted from another job, the stored handle can name any object in this drawing, and MOVE of the downpipe moves that object (`LinkService.SourceMoves.cs:112-162`).
   - **Smallest fix:** accept a label only if it is text or a circle whose owner note names this downpipe. Never overwrite an owner note that names another live downpipe.

7. **T4-07 — One unreadable pit record stops CE remembering any pit's links after open or Undo. MEDIUM, SURE.**
   - **Where:** `ReadPitLinkData` throws on bad JSON (`Services/LinkService.Persistence.cs:759`, no catch). `RebuildRuntimeCaches` first clears all of CE's link memory (`Services/LinkService.Cache.cs:876-888`), then scans pits with no per-pit catch (`:527-555`, read at `:574`). The pipe scan aborts in the same way (`:744`).
   - **What the drafter sees:** one damaged pit record (for example from a truncated DXF, see T4-20). After opening the drawing, or after U, MOVE of most pits no longer drags their pipes. Nothing appears on the command line.
   - **Smallest fix:** catch per object in the three scans, skip the bad record and print one plain line naming the pit.

8. **T4-08 — One unreadable pit record stops new pipes linking to any pit, drawing-wide, while the pipe still looks saved. MEDIUM, SURE.**
   - **Where:** `RemovePipeLinksFromAllOwners` reads every pit's record (`Services/LinkService.Geometry.cs:1507-1515`). One bad record aborts `LinkPipeEndpointsToPits` (`Services/LinkService.RepairAudit.Linking.cs:297-398`). `RegisterPipe` has already saved the pipe's own record in a separate transaction and only logs the failure (`Services/LinkService.Registration.cs:578-624`).
   - **What the drafter sees:** new CD pipes and Edit Pipe saves look normal. Later, moving the pit leaves those pipes behind.
   - **Smallest fix:** skip and name unreadable records during the scan. Do not half-register a pipe.

9. **T4-09 — A damaged Design draft (CDDESIGN) is replaced by the next Save Draft, losing the agreed design for good. MEDIUM, SURE.**
   - **Where:** `Services/CivilProjectStartDraftStorage.cs:36-41` catches any read error and returns nothing. `Commands/CivilDesignCommand.cs:51-52` prints "could not be read. Starting a fresh draft." Save Draft or Confirm setup (`:226`, `:233`) then overwrites the same stored record (`CivilProjectStartDraftStorage.cs:88-99`).
   - **What the drafter sees:** one command-line line, which reads as harmless. The agreed outlet, head and detention answers are then overwritten by a blank draft with no further warning.
   - **Smallest fix:** while the draft is unreadable, copy the old record to a backup key before any save, or ask before overwriting.

10. **T4-10 — A damaged outlet-roles record quietly switches off the redesign outlet check, and Apply then overwrites it. MEDIUM, SURE.**
    - **Where:** `Services/NetworkRedesignOutletRoleService.cs:44-62` returns nothing on bad JSON. `NetworkRedesignApplyTicketService.cs:873-875`: `if (stored == null) return;` skips the check. Apply always rewrites the record (`NetworkRedesignApplyCoordinator.cs:203-206`).
    - **What the drafter sees:** Redesign Apply runs without the "outlets do not match the last saved outlet roles" protection, and the evidence that something was wrong is overwritten. No message.
    - **Smallest fix:** read as missing / readable / damaged, and block Apply with a plain line when the record is damaged.

11. **T4-11 — An Xref'd Pit Schedule shows "OUT OF DATE" and fails Project QA when nothing on the schedule changed. MEDIUM, SURE.**
    - **Where:** `Services/ProjectDataFingerprintService.cs:17-38` fingerprints the whole job record (only `drawingPath` is removed). `PitScheduleStatusService.cs:141-147`, `:185` compares it, and `PitScheduleQaService.cs:309-315` turns it into a QA Fail. The record also holds ignored checks, paused features, the CDCALC draft, review approvals and the rainfall curve, none of which appear on the schedule. The current-drawing mode does the same (`ViewModels/PitScheduleViewModel.Data.cs:246-248`, `:1455`).
    - **What the drafter sees:** in the stage drawing, ignore one CDCHECKS finding or save a CDCALC draft. The sheet that Xrefs it then says "Civil data changed in …", and final QA fails although no pit or pipe changed.
    - **Smallest fix:** fingerprint only what the schedule uses (pits, pipes, manual rows, outlet overrides and row order).

12. **T4-12 — Structural: two new drawings from the same template share one footing-size memory. MEDIUM, SURE on code (the template-name behaviour comes from the repo's own comment).**
    - **Where:** `Services/CeTextService.cs:5574-5583` keys the footing-size cache on `db.Filename`. The footing register was moved off this key on 1 Oct because "two new drawings from one template report the same file name" (`FoundationRegistryService.cs:19-20`). This cache was not moved.
    - **What the drafter sees:** Drawing1: THCL size 81 = 600×600. Drawing2, new from the same template: THCL 81 silently reuses 600×600, and the next new size writes Drawing1's whole size list into Drawing2.
    - **Smallest fix:** key the cache by the drawing's native pointer, as `FoundationRegistryMemory` does.
    - **Related:** RD18-01 is the same cache, but covers Undo and close only.

13. **T4-13 — Older Structural builds strip newer footing and beam data, with no "newer drawing" refusal. MEDIUM, SURE.**
    - **Where:** the footing register checks only for "too old" (`FoundationRegistryService.cs:347`). `FoundationRegistryData` (`Models/FoundationModels.cs:227-250`) has no catch-all for unknown fields. `BeamLinkData` has no version at all (`BeamLinkPersistenceCodec.cs:24`). The footing-size library writes a `SCHEMA_VERSION` that is never read (`FstMemoryService.cs:115`). By contrast, CSPOINTLOAD and level carry do refuse newer records.
    - **What the office sees:** the same as T4-01, on the Structural side.
    - **Smallest fix:** add a catch-all for unknown fields, and refuse to save over a newer version.

14. **T4-14 — Pasting a pit from a "Save As" sister drawing gives it this drawing's pit values. MEDIUM, SURE logic (how often it happens is UNSURE).**
    - **Where:** `Rules/CloneOriginRule.cs:81-103` counts a paste as "made here" when the handle it names belongs to a pit here with the same identity, or when neither has one. The row then comes from the local pit (`ForkPit`, `Services/ProjectDataService.Mutations.cs:462-475`). Labels are copied from whatever sits at the stored handles (`Services/LinkService.CloneRegeneration.cs:227-341`).
    - **What the drafter sees:** Stage 2 was made by Save As of Stage 1. Pasting Stage 2's P4 into Stage 1 gives it Stage 1's P4 size, type and levels, and extra labels can appear beside it.
    - **Smallest fix:** when AutoCAD's copy map says "from another drawing", require a matching, non-blank identity before treating the paste as local. Copy only labels whose owner note names the source pit.

15. **T4-15 — After BIND of a CE Xref, the placed schedule says "SOURCE MISSING" and QA fails permanently. MEDIUM, code SURE (AutoCAD's Xref list after BIND is UNSURE).**
    - **Where:** `PitScheduleStatusService.cs:89-110` matches on the stored drawing identity, then only on unloaded paths. Line 165 shows "could not be found", and `PitScheduleQaService.cs:297-307` gives a permanent Fail.
    - **What the drafter sees:** binding Xrefs to issue a set makes final QA fail, although the data is now inside the drawing.
    - **Smallest fix:** recognise a bound source and show "source bound, schedule frozen".
    - **Not a duplicate:** BUG-799 covers unloaded Xrefs only.

16. **T4-16 — CE network pasted into a new drawing goes "quiet" after reopening: pits move without their pipes. MEDIUM, SURE on code.**
    - **Where:** at open, Civil is switched on only if the drawing is tagged Civil, its file name carries the Civil token, or the job record has content (`Services/LinkService.cs:1603-1617`). `ProjectDataService.HasCivilContent` passes `ceObjectPresent: false`, hard-coded (`Services/ProjectDataService.Persistence.cs:706-707`). A paste from another drawing gives each pit its own identity but "no record" (`Services/LinkService.ForeignClones.cs:462`) and advises CDREPAIR. The paste wakes Civil for this session only; no tag is written.
    - **What the drafter sees:** paste the drainage network into a new base "Lot 12.dwg", skip the CDREPAIR advice, then save and close. After reopening, MOVE of P3 leaves its pipes, labels and cover text behind, and the pit's stored links go stale. There is no message, because quiet mode only writes a performance line to the log (`Services/LinkService.Reactors.cs:96-98`).
    - **Smallest fix:** let `HasCivilContent` count CE pit and pipe records in model space (the `ceObjectPresent` input already exists), or tag the drawing Civil when a paste wakes Civil.

17. **T4-17 — On 2022–2024, moving a pit leaves CE pipe-object ends behind with no message. MEDIUM, CE side SURE (AutoCAD's proxy MOVE UNSURE).**
    - **Where:** `OpenPipeForShapeChange` returns nothing for a proxy (`Services/LinkService.PipeWriteSeam.cs:31-49`). Then `if (pipe == null) continue;` (`PitMoves.cs:157-158`). Unlike the locked-layer case, nothing is named.
    - **What the drafter sees:** the pit moves and the pipe stays put, with no explanation.
    - **Smallest fix:** use the same proxy check as T4-04, and name the pipes that could not follow.

18. **T4-18 — Twin detention pipes can be left half-upgraded when the pipe-object upgrade is refused. MEDIUM, SURE on the order (aftermath UNSURE).**
    - **Where:** `Services/LinkService.PipeObjectUpgrade.cs:142-151`, `:282-299` commits the barrel-to-centreline rewrite before `UpgradePipeInPlace` (`:160-164`). `DetentionCenterlineRoot` is set only on success (`:325-329`).
    - **What the drafter sees:** after a refused upgrade on open, the twin pipe's main line has become the centreline, but its record still calls it a barrel. The next redraw may place the barrels wrongly.
    - **Smallest fix:** do both steps in one transaction, or put the old vertices back on refusal.

19. **T4-19 — The fixed-outlet (CDLPD) protection in Redesign is skipped when the LPD record cannot be read as exactly one outlet. MEDIUM, UNSURE.**
    - **Where:** `Services/NetworkRedesignCurrentDrawingReader.cs:868-871` ignores the result of `TryGetLpdData`. `NetworkRedesignApplyTicketService.cs:829-830` runs the "existing CDLPD is Fixed" check only `if (lpd != null)`.
    - **Unverified:** whether the outlet pit is still protected another way (its fixed invert, or the owner name). It is not proven that the outlet level actually moves.
    - **Smallest fix:** treat "LPD record present but not complete" as a reason to block Apply.

20. **T4-20 — Some large records are saved as one long text value, unlike the rest of CE. MEDIUM, UNSURE.**
    - **Where:**
      - **Structural, one value:** the footing register (`FoundationRegistryService.cs:409`), footing-size lists (`FstMemoryService.cs:173`) and the schedule map (`ScheduleService.cs:677`, `:807`).
      - **Civil, one value:** CDPROFILE section metadata (`Services/LongitudinalSectionService.cs:3325`), whose reader rejects anything other than exactly one value (`:3218`, `:3274`).
      - **Split by CE elsewhere:** CE's own Civil writer splits at 255 characters with the comment "DXF Text values have a 255 character limit" (`Services/ProjectDataService.Persistence.cs:1294`).
    - **Unverified:** whether AutoCAD actually cuts or splits long Xrecord strings through DXFOUT/DXFIN or older DWG formats.
    - **If it does:** a large job's footing register comes back unreadable, which feeds T4-02 and wipes it. A long section reads "not a CE longitudinal section block".
    - **Smallest fix:** use the existing 255-character splitter for these records.

21. **T4-21 — A loaded Xref whose source was rebuilt is reported "SOURCE MISSING". MEDIUM, UNSURE (AutoCAD behaviour).**
    - **Where:** matching is on the drawing's internal identity (`PitScheduleXrefDiscoveryService.cs:252`). Only unloaded Xrefs fall back to the path (`PitScheduleStatusService.cs:89-110`).
    - **When it happens:** the source is recreated (for example `WBLOCK *`) and gets a new identity. The Xref is visibly loaded with the same pits, yet QA fails.
    - **Smallest fix:** when a loaded Xref is at the stored path with a new identity, say "source drawing was recreated, re-place the schedule".

### LOW

22. **T4-22 — An older CE wipes newer agreed-design answers from the Design draft. LOW, SURE (code).**
    - **Where:** the draft has no version and no catch-all for unknown fields (`Services/CivilProjectStartDraftStorage.cs:53`). `CopyDraft` rebuilds only the fields that build knows (`CivilDesignWindowViewModel.cs:612-633`).
    - **What the drafter sees:** the orifice head and "detention required" answers agreed on 3.0.72 disappear after a colleague on an older build presses Save Draft. Back on 3.0.72, the check then says "could not be checked".
    - **Smallest fix:** add a catch-all for unknown fields and carry it through `CopyDraft`.

23. **T4-23 — Edit Pipe saves the level in a separate write that fails silently. LOW, SURE (only bites when the pipe record is unreadable).**
    - **Where:** `Commands/PipeEditCommand.Update.cs:1873`, `:1880`, `:1888`. `StorePipeInverts` catches everything and only logs (`Services/LinkService.Persistence.cs:257-299`).
    - **What the drafter sees:** the schedule shows the new IL, but the level stored on the pipe stays old. That stored level is what CE falls back to when the IL text is deleted.
    - **Smallest fix:** return saved / not saved, and print "not saved".

24. **T4-24 — "Same drawing" checks use AutoCAD's drawing identity, which a Save As copy keeps. LOW, UNSURE.**
    - **Where:** `LpdCommand.cs:357`, `MultiLpdDrawingAuthorityReader.cs:135-145`.
    - **What the drafter sees:** a new job started by Save As of an old one can load the old job's approved outlets as approved in CDDESIGN (`CivilDesignCommand.cs:106-109`).
    - **Smallest fix:** add the drawing path and a CE-written job identity to the check.

25. **T4-25 — Structural: footing-size entries that do not match the expected pattern are dropped and erased on the next save. LOW, SURE (code).**
    - **Where:** `FstMemoryService.cs:70` (`catch { }`) and `:176-207` skip them; `:151-157` erases a list that is now empty.
    - **Smallest fix:** if fewer entries read back than are stored, do not rewrite that list.

26. **T4-26 — No drawing records which CE version last wrote it. LOW, SURE.**
    - **Where:** `Services/DrawingDisciplineService.cs:21-24`, `:441` stores only "CVL" or "STR".
    - **Effect:** T4-01 and T4-13 cannot be detected or diagnosed afterwards.
    - **Smallest fix:** store "last written by" and "highest version ever written" in the job record.

27. **T4-27 — Moving or flipping a pipe label forgets its kept wording (for example "APPROX."). LOW, SURE on the omission (visible effect UNSURE).**
    - **Where:** `BuildAttachmentData` copies every field except `LinkedDisplayPrefix` and `LinkedDisplaySuffix` (`Services/LinkService.SegmentAnalysis.cs:259-281`). The split path does copy them (`Split.cs:2604`).
    - **Smallest fix:** copy both fields from the previous entry.

28. **T4-28 — CSPOINTLOAD deletes damaged load groups it says it "never repairs". LOW, SURE (the command is hidden and off by default).**
    - **Where:** `Core/Roofs/RoofPointLoadMarkers.cs:108-150` skips them, and `PointLoadMarkerService.cs:208-209` writes back only the readable loads. `SkippedGroups` is never checked.
    - **What the drafter sees:** earlier loads vanish, and the new load is numbered P1 again.
    - **Smallest fix:** refuse to save when any group was skipped.

29. **T4-29 — DXFOUT may leave out a CE record still waiting to be saved. LOW, UNSURE (AutoCAD event).**
    - **Where:** waiting records are written only on QSAVE, SAVE or SAVEAS (`Services/LinkService.Reactors.cs:2173`, `Services/LinkService.cs:1247`).
    - **Smallest fix:** also write waiting records when a DXF export starts.

30. **T4-30 — On a PC set to comma decimals, Edit Pipe stores levels as typed ("18,14"). LOW, SURE (Australian-region PCs not affected).**
    - **Where:** `Commands/PipeEditCommand.cs:574-578`; the raw text is stored at `Commands/PipeEditCommand.Update.cs:1775`. Later readers treat it as missing, and CDAUDIT reads it as 1814 (`RepairAudit.AuditPasses.cs:194-196`).
    - **Smallest fix:** store the parsed number, written with a "." decimal point.

---

## Questions asked, with no new fault found

1. **Half-written saves in the design snapshot:** none. Each store writes all its pieces into one stored record in one transaction, and Redesign Apply writes all its records in one transaction (`NetworkRedesignApplyCoordinator.cs:153-213`).
2. **Number format in saved JSON:** always written with "." as the decimal point. Every parser I saw uses the standard format. The one exception is T4-30.
3. **Pit and pipe records on an older CE:** these keep unknown fields (catch-all present in `Services/LinkService.State.cs` and `Models/PitData.cs`). Only the job record (T4-01) and the Design draft (T4-22) lose them.
4. **Xref pits treated as host objects:** not found. The paste clean-up refuses Xref and REFEDIT objects (`Services/LinkService.ForeignClones.cs:283-303`).
5. **Path change or Xref reload:** neither changes the identity or the fingerprint.
6. **Undo/OOPS of a copy:** the clean-up refuses to run after U/REDO. No defect found beyond BUG-1070.

---

## What I did NOT check

1. **Nothing was run in AutoCAD.** In particular, these AutoCAD behaviours are untested:
   - how proxies behave under EXPLODE, AUDIT, COPY and MOVE;
   - whether WBLOCK or DXFIN keep handles and the drawing identity;
   - Xrecord string limits through DXF (T4-20);
   - the Xref list after BIND (T4-15);
   - whether MIRROR reaches the copy clean-up (T4-03).
2. **Structural stores read only lightly:** the SBEAM store (BUG-612 area), the CEMEMBER writers, and the Wall, Lintel, Hatch, Checklist and FoundationSchedule stores.
3. **Other Civil records not read in depth:** the Pit Schedule's own stored copy (`PitScheduleHostInstanceService`), `ProjectQaSnapshotService`, the CDCALC workspace store and the continuation-pair journals (no command calls them yet).
4. **EXPLODE paths:** EXPLODE of an inserted or bound CE drawing was not traced end to end.
5. **Nested overlays and circular Xrefs** were not checked.
6. **Note on BUG-665 (known, not counted):** its "fixed in 3.0.70" depends on a setting that is off by default (`Models/UserSettings.cs:671`, `CleanUpGripRotateScaleCopies = false`). On a default install, grip-Ctrl copy, ROTATE Copy and SCALE Copy still make twins. Whoever owns BUG-665 should confirm its status.
7. **The damaged-record safeguard (BUG-971) is not in 3.0.72.** It exists at PR #1658, where it covers the job record only. Pit and pipe records and label notes are outside it, so T4-07 and T4-08 remain after it lands.

---

## Summary

30 new data-integrity faults: HIGH 3 / MEDIUM 18 / LOW 9, with 19 fully SURE by reading. Three are the most serious. An older CE silently strips newer job data, and its version guard cannot fire. One unreadable Structural footing register is wiped by the next footing command. On AutoCAD 2022–2024, one downpipe in a COPY leaves every copied pit as an unrenamed twin. Other themes: CE pipes become invisible to CE on PCs without the enabler and get unlinked, damaged records are treated as empty and saved over, and copies keep the original's links. Nothing was tested in AutoCAD, built or changed.
