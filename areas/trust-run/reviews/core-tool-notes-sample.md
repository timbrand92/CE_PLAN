# Review: a sample of the one-page tool notes (8 of 47)

**Reviewer:** lane trust-review (second run), 12 Nov 2026, about 23:50 PC clock. Read only.
**Sample:** `04_REFERENCE\core-tool-notes\` PIT, CD, CDEDIT, PITSCHEDULE, CDFW, CDRENUMBER, CDLPD, MR (written by lane trust-test-cases, 47 notes in about 25 minutes).
**Checked against:** the installed code copy `C:\CE_WORK\scratch\audit_civil` (commit cf059dcf). Paths below are under `Modules\Drainage\` unless they start with `Modules\`.
**How:** four read-only helper readers checked two notes each, line by line; I re-read the lines marked **(re-read)** myself. The other line numbers are as the readers reported them; I spot-checked about a dozen and found no reader error.

---

# FOR TIM

1. **All eight notes I checked have wrong lines.** Most often they repeat an old fault from the bug list where your installed build already has a fix, and say "not known" where the code gives the answer.
2. **The worst one:** the Floor Waste note says "do not use CDFW, it wipes pit inverts". The installed code already has that fixed (not yet seen working in AutoCAD). The Pit and Pipe notes say both work inside an in-place block edit unprotected; the code refuses.
3. **The other 39 notes were written the same way,** so treat all 47 as rough drafts until each line points to the code.

**Verdict: FIX FIRST.** Rewrite each note from the code, every factual line with a file and line; a bug with a fix in the code reads "fix in this build, not yet proven in AutoCAD"; check the 39 unsampled notes the same way before anyone relies on them.

---

## 1. The pattern

1. **Bug lines lag the code.** At least 14 bug lines describe faults whose fix is in the installed code, most switched on: BUG-650, 1255, 1043, 1049, 682, 675, 1226/1238, 331, 817, 1198, 965, 1022, 1237, 968, 1005, 1223, 458.
2. **"Not known" where the code answers.** Enter at each question, what else a tool changes, and how Undo works are answered in the code for every note in the sample.
3. **Both directions mislead.** Too gloomy (CDFW, REFEDIT, MR's protection) and too kind (CD's Enter default upsizes a pit and Cancel then leaves it upsized; Edit Pipe's Enter records a label). A note must say both.

## 2. Findings, note by note

### PIT.md
1. **L11 "a New Pit window has tabs":** WRONG. PIT always opens the one-page window (`Dialogs\WorkshopPitCreation.cs:9-16`, **re-read**); the tabbed window is only the small-screen fallback (`Services\DialogService.cs:90-97`, **re-read**).
2. **L14 "first it runs CE's quiet update":** CORRECT (`Commands\PitCommand.cs:111`, **re-read**).
3. **L14 "BUG-793: the pit block is swapped every time a drawing opens":** not PIT's doing and overstated. It is the open-time update, once per drawing, and only where the version 2 pit block exists (`CODE_FACTS_13NOV.md` I).
4. **L17 and L35 "runs inside REFEDIT with no protection (BUG-458)":** WRONG. PIT refuses during REFEDIT (`Services\DrawingSafetyService.cs:78-90`, **re-read**). It also refuses read-only drawings, Paper Space, Structural drawings and locked pit, label, number or cover-text layers (`Commands\PitCommand.cs:341-361`). So L17 "not known" is answerable.
5. **L20 "the window, then the point":** WRONG order. The point comes first, then the window (`PitCommand.cs:113-115`, then `177`, **re-read**).
6. **L20 "what Enter means: not known":** ANSWERABLE. Insertion point: Enter is refused and it asks again. Window: Enter = Continue placement. Label point: Enter refused; Esc = no label. Cover text: Enter = the last corner (BR by default) (`PitCommand.cs:237-241, 479-558`; `Services\BlockService.cs:1612-1615`).
7. **L23 "fills Class C and applies the plastic rule from Settings":** PARTLY WRONG. Only for pits drawn with no record row (`Services\ProjectDataService.cs:826-856`). The lid letter is the last lid used, C by default (`ViewModels\PitViewModel.cs:1241`). The plastic rule is fixed in code (351 x 351 or smaller, or a PLASTIC type), not a Setting (`Services\ProjectDataService.Recovery.cs:115-148`).
8. **L26 "U once per pit":** CORRECT by design (one command per pit, record written inside it). The remembered window values file is not undone.
9. **Left out:** PIT splits a pipe it lands on and relinks pipe ends (`PitCommand.cs:566-585`); every Place makes its values the next defaults.

### CD.md
1. **L14 "first it runs CE's quiet update (the audit names CD)":** NOT FOUND. No update call in CD's own files (`Commands\CdCommand*.cs`, **re-read**: no InitServicesFull, SyncWithDrawing or EnsureDrawingDataCurrent). CD only binds the record without saving (`CdCommand.cs:68`). The audit's line reference is needed.
2. **L14 "6 of 46 pipes were converted on opening":** not CD. That is the open-time conversion (`Services\NativeObjects\PipeObjectUpgradeOnOpenService.cs`).
3. **L17 "refuses a pipe 1 m or shorter in a metre drawing (BUG-331)":** WRONG for this build: the limit is 1 mm in drawing units (`CdCommand.cs:1296-1317`).
4. **L17 "runs inside REFEDIT with no protection":** WRONG (`DrawingSafetyService.cs:78-90`, called from `CdCommand.cs:55`).
5. **L20 "Enter at the second point keeps a straight pipe":** WRONG as worded. Enter is refused at the first and second points (`Commands\CdCommand.ExistingLine.cs:80, 128`, **re-read**); Enter at the next-point question after the second point finishes a straight pipe (`CdCommand.cs:1260-1277`, **re-read**).
6. **L20 and L37 "recent-value buttons missing (BUG-1226, BUG-1238)":** WRONG for this build: a "Recent:" line shows by default (`Dialogs\PipeOnePageLayout.cs:82-85, 335-392`; `Models\UserSettings.cs:1747`).
7. **L23 "a pipe with no size is given 100 and UPVC without saying so":** WRONG for CD. Start Pipe stays blocked for a blank size or material (`Rules\PipeStartReadiness.cs:177-181`); 100 and UPVC are the window's visible starting values (`ViewModels\CdViewModel.Commands.cs:69-70`). The silent fills are elsewhere (CDUPGRADE `Commands\LinkCommands.cs:2127-2147`; Edit Pipe, clones and splits per `CODE_FACTS_13NOV.md` A.11, A.13).
8. **L26 and L33 BUG-682 "Esc leaves a drawn polyline":** the code has a fix, on by default, for the Uphill-box Cancel case (`UserSettings.cs:1061`; `CdCommand.cs:898-910`).
9. **L36 "BUG-1043: a blank invert refuses":** WRONG for this build (`UserSettings.cs:1633-1639`, **re-read**: blankInvertIsWarningNotBlock ON).
10. **L35 BUG-675:** the code has a fix (`Commands\CdCommand.PitFit.cs:64-66`).
11. **Enter at CD's other questions (missing):** window: Enter = Start Pipe. Pipe wider than a pit side: **Enter = Upsize the pit** (`CdCommand.PitFit.cs:75-98`). Uphill box: Enter = Yes, flips the levels. Which nearby pipe end to join: Enter = None.
12. **Left out, matters:** a later Cancel says "nothing was drawn" but leaves a pit upsized or moved by the earlier answer, until U (`CdCommand.cs:406, 427`).

### CDEDIT.md
1. **L11 "a Review changes step before Save":** WRONG. It is an optional button that opens a read-only list (`Dialogs\PipeOnePageLayout.cs:157-162`).
2. **L11 "Edit Pit has tabs":** WRONG. Same one-page window as New Pit (`Commands\PitEditCommand.cs:240-245`; `DialogService.cs:90-97`).
3. **L14 "runs the quiet update first":** CORRECT (`Commands\HubCommands.cs:135, 188`). Edit Pipe holds record writes only after that update, so Cancel can still leave the update's write (`Commands\PipeEditCommand.cs:58-59`).
4. **L14 "about 60 remembered values make results differ":** PARTLY WRONG. CDEDIT opens with the picked item's own values; Edit Pipe never writes remembered values (`ViewModels\CdViewModel.Settings.cs:248-251`); Edit Pit's Save does, and they become the next New Pit defaults (`PitViewModel.cs:989, 1229-1258`).
5. **L17 "one at a time or several: not known":** ANSWERABLE. A pick edits one; several pre-selected pits, or pipes, open the batch editor; a mixed selection is refused (`HubCommands.cs:100-105, 227-235, 275-292`).
6. **L20 "Enter: not known":** ANSWERABLE. Pick prompt: Enter ends with nothing changed. Window: Enter = Save (batch: Apply to Selected). "Recalculate downstream inverts?": Enter = Yes, then a preview (`Commands\PipeEditCommand.Update.cs:2061-2086`). Older-pipe label question: **Enter = Yes, which records the highlighted text as the pipe's label** (`Commands\PipeEditCommand.OlderPipeLabels.cs:414-430`).
7. **L23 and L32 "BUG-1043: a blank invert refuses Save":** WRONG for this build (`UserSettings.cs:1633-1639`, **re-read**).
8. **L23 and L33 "BUG-1049: one blank field blocks a batch Apply":** WRONG for this build (`UserSettings.cs:626-629`, **re-read**: batchBlankFieldIsLeftOut ON).
9. **L26 "Undo: not fully known":** ANSWERABLE. The edit, pipe-end re-snap, schedule refresh and record share one U (`HubCommands.cs:154-164`; `PitEditCommand.cs:424-458`); the batch is one transaction. Exception: a partly refused pit edit keeps its drawing changes until U (`PitEditCommand.cs:649-656`).
10. **Left out:** an Edit Pit Save also moves connected pipe ends, renames the pit in connected pipes' records and refreshes a drawn Pit Schedule (`PitEditCommand.cs:415-439, 618-627`).

### PITSCHEDULE.md
1. **L11 "Source and Rows tabs":** incomplete; four tabs: Source, Rows, Changes, Placement (`Dialogs\PitScheduleDialog.xaml:144, 386, 1030, 1137`).
2. **L14 "the relink button runs the same quiet update as CDSYNC":** WRONG. It is a different relink routine (`ViewModels\PitScheduleViewModel.Data.cs:996-999` against `Commands\LinkCommands.cs:148-190`).
3. **L14 and L35 "BUG-817: opening leaves its own undo step":** the code has a fix (`PitScheduleViewModel.Data.cs:212-215`; PITSCHEDULE removed from the record-flush list, `Services\LinkService.cs:69-70`, **re-read**). One write path remains: loading copies a drawn pipe size into the record when they differ (`Services\PitScheduleBuilder.cs:1085-1089`; `CODE_FACTS_13NOV.md` A.8 agrees).
4. **L14 and L34 "BUG-1198: a cancelled export still saves the row order":** WRONG for this build (`UserSettings.cs:1194-1196`, **re-read**: pitScheduleExportWritesNothing ON).
5. **L17 "350 x 350 and smaller is left out":** PARTLY WRONG. The schedule checks the plastic flag, not the size (`PitScheduleViewModel.Data.cs:851-858`); the size only guesses "plastic" for pits recovered without a record (`ProjectDataService.Recovery.cs:115`).
6. **L20 "with natural order off the order can read P1, P10, P2":** WRONG. The old order already sorts plain P numbers by number (`Helpers\PitIdComparer.cs:33-46`, **re-read**). The switch changes names like P1A and other prefixes only. "Off by default" is CORRECT (`UserSettings.cs:1142-1143`).
7. **L20 "Enter: not known":** ANSWERABLE. The window has no default button; Enter on a row zooms to that pit (`Dialogs\PitScheduleDialog.xaml.cs:262-267`); at the insertion point Enter is not accepted (`ViewModels\PitScheduleViewModel.Schedule.cs:819`).
8. **L23 "a blank pipe size shows ?":** WRONG for the cells: a blank shows blank (`PitScheduleBuilder.cs:1102-1120`); "?" appears only in the picked pipe's description line (`ViewModels\PitScheduleViewModel.cs:1353, 1511`).
9. **L23 and L31 BUG-965:** the code has a fix, on (`UserSettings.cs:1162-1167`). **L33 BUG-1022:** fix, on (`UserSettings.cs:1249-1255`). **L38 BUG-1035:** now the Setting shallowPitDepthMm, default 300 (`UserSettings.cs:1185-1187`).
10. **L26 "Undo: not known":** ANSWERABLE in part: the window runs inside one PITSCHEDULE command (`Commands\PitScheduleCommand.cs:45-49`).
11. **L30 "BUG-1255: no fix":** WRONG. A workaround is in the installed code, switch on (`UserSettings.cs:3643`, **re-read**; `PluginInitialization.cs:61`), with a plain line pointing to CSV if it still fails (`CODE_FACTS_13NOV.md` F agrees). Unproven in AutoCAD 2027.
12. **Left out, matters:** cell edits write level text and CHECK markers into the drawing, and a typed pit size resizes the pit (`PitScheduleCommand.cs:27`; `PitScheduleDialog.xaml.cs:225`). Placing a new schedule saves the row order before asking for the point, so Esc there leaves the order saved and nothing placed (`PitScheduleViewModel.Schedule.cs:816-820`).

### CDFW.md
1. **L7, L14, L20 and L29 "BUG-650: clears every pit's stored invert, even on a successful placement; do not use CDFW":** WRONG for this build. CDFW no longer runs the full refresh before the pick (`Commands\FloorWasteCommand.cs:41-45`, **re-read**), and the refresh no longer blanks an invert unless the pit's label shows an IL line (`Services\ProjectDataService.cs:964-992`, **re-read**). Should read "fix in this build, not yet proven in AutoCAD". The refresh can still switch a pit's "show invert" off (`ProjectDataService.cs:993-997`).
2. **L17 "will not do: not known":** ANSWERABLE. Refuses read-only, Paper Space, Structural and REFEDIT; refuses when the floor waste block file is missing; refuses a landing it cannot verify (`FloorWasteCommand.cs:49-54`; `Services\SourcePlacementService.cs:409-516`).
3. **L20 "the point":** CORRECT; Enter has no default; anything but a point ends with "nothing was placed" (`BlockService.cs:1612-1615`).
4. **L26 "U once restores the inverts":** UNSUPPORTED (no inverts are cleared in this build). Placement is one transaction in one command (`SourcePlacementService.cs:1042-1091`), so one U is likely.
5. **L30 BUG-1223:** the code has a fix, on (`Rules\SourcePickPipeRecordRule.cs:5-19`; `UserSettings.cs:775`).
6. **Left out:** one floor waste per command (no carry-on); placed on a pipe it can split the pipe or record a junction (`FloorWasteCommand.cs:72-74`).

### CDRENUMBER.md
1. **L11 "lists every old and new number":** PARTLY. Only pits whose number changes (`Commands\PitRenumberCommand.cs:86, 94-99`).
2. **L14 "everything else it touches: not known":** ANSWERABLE. After Yes: pit numbers and pipe From/To names in CE's record (`Services\ProjectDataService.Mutations.cs:1615-1627`), the number on the pit label block (`Services\ScheduleLinkService.cs:3237`), linked cells of a placed Pit Schedule (`Services\PitRenumberApplyService.cs:164-166`). Before writing it refuses if a pit, label or cover text is on a locked layer or in an Xref (`PitRenumberApplyService.cs:36-83`).
3. **L17 "what counts as plain: not known":** ANSWERABLE: "P" followed by digits only (`Rules\PitRenumberPlanner.cs:266-277`).
4. **L17 "the same drawing can number differently on another day":** UNSUPPORTED. The working is fixed; it changes only if a different outlet is chosen. "Forgets the outlet" is CORRECT (`PitRenumberCommand.cs:134-135`).
5. **L20 "asks which pit is the outlet, then Yes or No":** WRONG. It asks only when more than one pit drains out of the network (`PitRenumberCommand.cs:51-61`, **re-read**).
6. **L20 "Enter means No (Help)":** CORRECT from the code (`PitRenumberCommand.cs:104-116`, **re-read**), not from Help.
7. **L23 "with no inverts it says not available":** UNSUPPORTED (not found).
8. **L23 and L29 "BUG-1237: stops with no help":** WRONG for this build: it says to draw the last pipe out to an open end, switch on (`Rules\PitRenumberOutletWordsRule.cs:22-27`; `UserSettings.cs:1273`). It still stops.
9. **L30 BUG-968 and L31 BUG-1005:** the code has fixes (`PitRenumberCommand.cs:71-79`; `PitRenumberPlanner.cs:150-152`; `UserSettings.cs:1264`).
10. **Left out:** it refuses outright when two pits share a number; pits with no number are skipped.

### CDLPD.md
1. **L11 "guides you to place its pipe end":** WRONG. It finds an existing pipe end near what you pick (`Commands\LpdCommand.cs:56-142`).
2. **L14 "marks the pipe end":** PARTLY. Only the arrow of a standard note points at it (`LpdCommand.cs:204, 456-510`); the "LPD" word is on a non-plotting layer (`Services\LpdService.cs:381-422`).
3. **L14 "two records, each refuses while the other exists":** CORRECT (`Services\LpdService.ReadCompatibility.cs:357-407`; `LpdService.cs:228-229`). When blocked the drafter sees only "Error during CDLPD - see CE log" (`LpdCommand.cs:257-261`).
4. **L14 left out:** CDLPD writes "LPD" into the pipe's blank From or To in CE's record (`LpdCommand.cs:210-229`).
5. **L17 "does not tell the other tools where the start point is":** WRONG as written. The Pit Schedule, the redesign reader, CDDEST and linking read the stored LPD (`Services\PitScheduleBuilder.cs:1276, 1296`; `Services\NetworkRedesignCurrentDrawingReader.cs:621, 878`; `Commands\SourceDestinationCommand.cs:179`; `Services\LinkService.Geometry.cs:1097`). True for CDRUNSOLVE and CDRENUMBER only (`Commands\RunSolveCommand.cs:239-247`).
6. **L20 "Enter: not known":** ANSWERABLE. Window: no default button; Esc draws nothing. "Select pipe/pit/block ... or press Enter to pick point": Enter goes to the point. Point: Enter refused. Label location: Enter puts the label at the pipe end (`LpdCommand.cs:50-54, 123-159`).
7. **L23 "not known":** ANSWERABLE, and a trust gap: an unknown invert is silently left out of the note, never shown as Unknown (`Rules\SourceFamilies.cs:285-301`).
8. **L26 "Undo: not known":** ANSWERABLE, unproven: all writes are inside the one CDLPD command and the record is written at its end (`LinkService.cs:61-81`, **re-read**).

### MR.md
1. **L14 "what it does to CE's record: not known":** ANSWERABLE. MR writes nothing to the record itself; CE's move clean-up runs at MR's end in a Civil drawing (`Services\ExternalMutationCommandPolicy.cs:20`; `Services\LinkService.Reactors.cs:1739-1759`).
2. **L17 "it stops when a raingarden is selected":** CORRECT but far too narrow. On 2027 MR accepts only eight plain object types by exact type (`Modules\Shared.Transform.Native2027\TransformCommands.cpp:157-167`, **re-read**). It refuses hatches (so raingardens), the CE pipe object, pipe outlines, callouts and dimensions: it cannot move a pipe.
3. **L17 "locked layers, Xrefs, REFEDIT: not checked":** WRONG. The 2027 transform refuses REFEDIT (and fails closed if it cannot tell), any object or attribute on a locked layer, Xref and overlay blocks, and anything outside the current space; it unlocks nothing (`TransformCommands.cpp:140-175`, **re-read**). Not proven in AutoCAD.
4. **L20 "Enter: not known":** ANSWERABLE. Selection: Enter with nothing ends. Base point: Enter ends with no change. Destination: Enter refused. Rotation angle <0>: **Enter = 0, the objects are moved without rotation and the move is kept** (`TransformCommands.cpp:113-127, 205-215, 288`).
5. **L23 "prints a code word":** PARTLY. First line "CE transform stopped (eNotApplicable). Drawing changes rolled back.", then a plain second line (`TransformCommands.cpp:327-332`).
6. **L26 "Undo: not known":** ANSWERABLE: one transaction committed once; Esc before the end writes nothing (`TransformCommands.cpp:269, 294, 322`).
7. **L32 "2022 to 2024: not known":** ANSWERABLE: other years run the bundled LISP move-rotate by default, with no type limit and no undo grouping (`Commands\CopyRotateCommands.cs:117-126, 399-420`).

## 3. For the controller

1. **BUG-650 (CDFW) looks already fixed in the installed build** (finding CDFW 1). Step 4's queue lists it as a fix to lift; it may need AutoCAD proof, not new code.
2. **PR 2038's two fault tooltips** (CDFW and Pit Schedule) repeat the stale note lines.
3. **The tool-note format needs one more field per line: the source** (file and line, or record and date). Without it, the next fast pass will repeat this.

## 4. Not checked

1. The other 39 notes.
2. Section 7 bug lines that the code neither confirms nor contradicts (left as written).
3. Nothing was run in AutoCAD; every "fix in the code" above is unproven there.
4. Help-text claims were checked only where a reader met them.
