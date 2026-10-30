# Structural "already fixed?" check, batches S-2 to S-16 (Sat 31 Oct 2026, about 00:30 Melbourne)

Read-only job (key v1). Checked on `origin/claude/rel-20261026s`, head `204dfad2` = installed Structural 1.0.125, in a detached worktree `C:\ce-fx\v1`. No build, no test, no AutoCAD, no edit to code, no PR. BUG_CARPARK.md not touched. Nothing under %APPDATA% was touched.

## ANSWER FIRST

1. **Unlike S-1, the S-2 to S-16 queue is mostly still real.** Of 40 entries, I read the fixing code for 3. 36 are still there. 1 I cannot tell.
2. **Counts per verdict:**
   1. **ALREADY FIXED:** 3 (BUG-470, BUG-473, BUG-611).
   2. **STILL THERE:** 36 (this includes BUG-536, which is part fixed: 3 of its 8 parts are done, 1 is half done, 4 are still there).
   3. **CANNOT TELL:** 1 (BUG-579).
   4. **NEEDS TIM OR AUTOCAD:** 0 as a verdict. BUG-611 and BUG-1132 carry a note about what a look or a decision would add.
3. **Why the S-1 result did not repeat:** the three fixed entries all carry a HUNT-S marker or a PR number in their own carpark text (HUNT-S-05, HUNT-S-08, PR 1262). The other 36 have no matching commit, no matching REGRESSION_LOG line and no matching code on the train line. I searched the whole git history of the ref for each BUG number and found no fixing commit for any of the 36. This train names its fixes by HUNT-S number, PR number or S-nn, so I also read the current code path for every entry. I did not rely on the missing commit alone.
4. **Nobody should drop a batch from the queue because of this check.** Drop only BUG-470 and BUG-473, and BUG-611 once a Codex look confirms the window wording. Rework BUG-536 to its four open parts only.

## FOR TIM

1. **Three of the 40 are already in your installed Structural 1.0.125.**
   1. **Footing centre line (BUG-470):** run FSF and pick an existing footing's outline. CE now refuses with "That is the outline CE drew for [footing]. Pick or draw a centre line instead. Nothing was drawn." It also refuses another footing's centre line and a raft edge.
   2. **Locked layers (BUG-473):** BT1, C1, TS1, AB, BB and BTX now stop with one plain line if their layer is locked, and draw nothing. BTX leaves locked text alone and counts it. Nothing is ever unlocked.
   3. **Timber picker wording (BUG-611):** in SBEAM, choosing Timber no longer says "No local steel sections match that search". The code is in. Nobody has looked at the window since, so it needs a Codex look before it counts as accepted.
2. **One entry is part fixed (BUG-536, eight commands that ignore a Settings value).**
   1. **Now fixed:** SCREWPILE offers the Settings diameter. REBAR starts from the Settings bar size, spacing and count. Beam shorten reads its choices from Settings.
   2. **Half done:** BP (bored pier) reads the Settings default diameter. It still always uses the 450 block.
   3. **Still fixed numbers:** label height read by only two commands, member schedule sizes, footing schedule column widths, and the load-path round-up to 50 mm and the 450 mm pier.
3. **36 are still real.** Examples of what a drafter still sees today:
   1. **THCL:** two new drawings from one template share one footing-size memory (BUG-1146). Escape at the centre prompt still saves size 81 as 600 x 600 (BUG-1200).
   2. **SBEAM:** typing 6000 as the length shows 192000 kg (BUG-1131). 40x40x3 EA shows Ix 0 (BUG-1126). Typing 410UB59 finds nothing (BUG-1122).
   3. **XCLMTXT:** "TOP PL & BOT PL" prints "TOP PLATE & BOT PL" (BUG-1128). An office UB spelling row is skipped (BUG-1123).
   4. **CSTAGBEARERS:** it still adds a second line on top of a hand-drawn bearer (BUG-1185). It still writes labels into a locked layer (BUG-1186).
   5. **Moving marks:** MOVE of an FFL triangle, a section cut line, or an RC beam outline still leaves the rest behind (BUG-627, 631, 613).
4. **One cannot be told from the code (BUG-579):** the FPFC depth lost after Undo and Redo. It needs an AutoCAD run or a closer trace.
5. **Mistakes of my own:**
   1. **Settings listings:** the job text asks for Settings file listings before and after any test. I ran no tests, and the task forbids touching %APPDATA%, so there are no listings.
   2. **First search:** my first git-history search for BUG numbers used a pattern that matched nothing, so it looked as if even BUG-529 had no commit. I rewrote it and read the code instead.
6. **Nothing for you to decide or do.**

---

## TECHNICAL DETAIL

Method for every entry: read the full carpark entry, find the named code on the ref (files and line numbers have moved), search `REGRESSION_LOG.md`, `git log` and the HUNT-S markers, read the current path. ALREADY FIXED is only written where I read the fixing code. Line numbers are on `204dfad2`. "No switch" means I found no Settings switch in the fix I read, not that none exists.

### BATCH S-2

1. **BUG-1146, STILL THERE.** `Services/CeTextService.cs:5574-5596` `GetDrawingKey` returns `db.Filename` first, and only falls back to `FingerprintGuid` for an unsaved drawing. The footing register uses `FoundationRegistryMemory.KeyFor(GetRawPointer(db), HasOpenDocument(db))` (`FoundationRegistryService.cs:414-419`). The size cache was not moved to it. Drafter sees: a second new drawing from the same template reuses the first drawing's THCL size.
2. **BUG-1147, STILL THERE.** `FoundationRegistryService.cs:347` `MigrateIfNeeded` only checks `SchemaVersion >= 2` (too old). There is no catch-all for unknown fields and no refusal on a newer version. `BeamLinkPersistenceCodec.cs` has no version. `FstMemoryService.cs:26,115` writes `SCHEMA_VERSION` ("3") and never reads it. Only CSPOINTLOAD refuses a newer record (`PointLoadMarkerService.cs:159`). An older build still strips newer data.
3. **BUG-1159, STILL THERE.** `FstMemoryService.cs:176-207` `ParseList` skips a non-matching entry with `continue`. `Save` (lines 80-123) writes `SerializeList(...)` for every list with no "fewer read than stored" guard. An emptied list is still erased on the next save.

### BATCH S-3

4. **BUG-1139, STILL THERE.** `Services/BeamLinkService.cs:60-90` `RegisterBeam`: when a record exists with a different `BeamHandle` it keeps `existing`, overwrites only `BeamHandle`, and keeps the attachments. `BeamLinkService.CopyRelink.cs` (UX-UNIT-01) fixes this only for CE's own unit copy (`UnitCopyService.cs:214`), not for a native COPY followed by a column placement. Drafter sees: the copied beam still takes over B3's label and column links.
5. **BUG-1204, STILL THERE.** `Services/LinkMigrationService.cs:22-23` `InitializedDocuments` is a file-name `HashSet`. It is cleared only in `Shutdown()` (line 40). There is no removal at document close and no failed-work handling. Reopening a discarded first-open conversion in the same session still skips it.
6. **BUG-1162, STILL THERE.** `Core/Roofs/RoofPointLoadMarkers.cs:64,73` defines `SkippedGroups`, and nothing reads it. `PointLoadMarkerService.cs:160-210` refuses only `WrittenByNewerBuild` and a locked layer, then writes `read.Loads` plus the new load. A damaged group is dropped on save and the new load is numbered from the readable ones.

### BATCH S-4

7. **BUG-578, STILL THERE.** `FoundationService.cs:4842-4855` `ResolveMemoryKeyFromText` turns a typed "PF1" into key "1". `FstMemoryData.Find` and `Upsert` (`Models/FstMemoryData.cs:91-98`) match the key as stored, ignoring case only. `NormalizeList` (`:193-208`) only trims. A library row keyed "PF1" is never found by the "1" lookup. HUNT-S-01 (`23a4f832`, `SizeMemoryKeyFor`) fixed a different thing: the typed mark against the placed mark. It does not touch the "PF1" against "1" split.
8. **BUG-613, STILL THERE.** `Commands/SectionDetailCommands.cs` `RunRcBeams` (line 33 on) draws separate entities. I found no group, compound identity or reactor for RC beam detail. `LinkService.cs` groups (`CE_LINK_`) are used only for text and line link pairs. MOVE of the outline still leaves the bars and labels.
9. **BUG-616, STILL THERE.** `Services/NativeXrefLayerService.cs` (249 lines) prints counts, then opens each reference for write and moves it (lines 70-104). I found no highlight, no Apply and no Escape-before-change step.

### BATCH S-5

10. **BUG-1121, STILL THERE.** `Structural.DesignCore/SteelSections/CeMemberPrompts.cs:101-117` `FindByName` still accepts a single `StartsWith` match, so "114.3x6" still finds 114.3x6.4CHS. The later change (AUDIT-STRUC-9, `4cff3d0a`) only adds the zero-decimal match ("310UB32.0" = "310UB32") and does not stop a digit continuing the prefix.
11. **BUG-1132, STILL THERE (latent).** `CeMemberReplanner.cs:45-52,126-130` `SameName` is a space-and-case compare. There is no old-names field. `section-catalogue.json` has no "310UB32.0" yet (the BUG-818 rename has not landed), so nothing fails today. It fails the day the list changes. Needs Tim's word only on timing with BUG-818.

### BATCH S-6

12. **BUG-611, ALREADY FIXED (code read; window not looked at).** `UI/Dialogs/SteelSectionPickerDialog.xaml.cs:450-453` shows "No local steel sections match that search." only when `options.Count == 0 && family != "Timber"`. Fix is PR #1262 (`0bae4ef8`, merged into train S-38 as `12786435`), REGRESSION_LOG "BUG-611" entry (about line 26117). Drafter sees: choosing Timber in SBEAM no longer shows the steel no-match line. Codex looked at rendered frames in the PR, not at AutoCAD. This still needs a Codex look in the installed build.
13. **BUG-1126, STILL THERE.** `SteelSectionPickerDialog.xaml.cs:655-656` `FormatDim` is `value.ToString("0.#")`. 0.04 shows 0, 1.12 shows 1.1.
14. **BUG-1131, STILL THERE.** `SteelSectionPickerDialog.xaml.cs:574-598` `TryParseMemberLength` accepts any positive number as metres. `SbeamSelectionPlanner.cs:122-137` multiplies it by kg/m with no over-100 rule. 6000 gives 192000 kg.

### BATCH S-7

15. **BUG-1122, STILL THERE.** `section-catalogue.json:114` still names "410UB60". `SbeamSelectionPlanner.cs:225-241` `MatchesSearch` is a substring test. There is no mass tolerance and no Lysaght Z/C name. `ZC150` is still the only name for it (`section-catalogue.json:3058`).
16. **BUG-1123, STILL THERE.** `Services/ExcelMTextService.cs:5745-5750` `ExpandMemberAbbreviation` protects explicit sizes first (`ProtectExplicitMemberSizes`), then runs the office mappings (`:5754-5775`), then unprotects. The lock still runs before the office list.
17. **BUG-1128, STILL THERE.** `ExcelMTextService.cs:5793-5794` replaces only `" PL "` (with spaces both sides) with `" PLATE "`. A trailing or leading PL is unchanged.

### BATCH S-8

18. **BUG-1185, STILL THERE.** `Services/TimberSubfloorService.cs:139-250` `ExecuteTagBearers` stores only start and end points. `DrawBearerLabel` (`:320-328`) appends a new `Line` on BEARERS - SUBFLOOR for every tagged member. There is no dedupe and no label-only writer. A hand-drawn bearer gets a second line and a bent polyline gets a straight chord.
19. **BUG-1193, STILL THERE.** `Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs:920-945` builds boundary segments only from consecutive vertex positions (`Line`, `Polyline`, `Polyline2d`, `Polyline3d`). Bulge and `Arc` are ignored. This is a Civil file; the Structural queue lists it by mistake (as the batch file already says).
20. **BUG-1200, STILL THERE.** `Services/CeTextService.cs:2181-2197` `TryGetOrPromptRectSize` runs `data.Upsert` and `SaveFstData` (line 2197) before the centre point is asked (`:1118-1121`). A cancel at the centre prompt still leaves the saved size. I did not trace the outline-before-text-prompt half; the saved-size half alone keeps it open.

### BATCH S-9

21. **BUG-626, STILL THERE.** `Commands/LevelMarkCommands.cs:166-190` FFL asks point, then side keyword, then value, and draws. No source/Manual choice and no following preview (the only `GetPoint`/`GetKeywords`/`GetString` calls, no jig).
22. **BUG-627, STILL THERE.** `LevelMarkCommands.cs` has no group, link or reactor reference (searched for group/Link/Identity/Reactor: none). The triangle, tail and value are separate entities.

### BATCH S-10

23. **BUG-630, STILL THERE.** `Commands/SectionMarkCommands.cs:37-67` asks start mode, points and direction; the identifier and sheet come after (`:239,257`), and the entities are appended at `:100-120` with no final preview step.
24. **BUG-631, STILL THERE.** `SectionMarkCommands.cs` and `Services/SectionMarkRegistry.cs` use no group or compound. `SectionMarkRegistry.WriteTag` only writes an invisible tag on the cut line.

### BATCH S-11

25. **BUG-634, STILL THERE.** `Commands/DimensionCommands.cs:361-470` DSET1 selects, then converts every dimension whose `LinearScaleFactor` is 1.0. No style recognition, preview or Apply. Fixes already in this file are different bugs (BUG-633 any kind of dimension, 635 redraw readback, 638 locked layers).
26. **BUG-640, STILL THERE.** `DimensionCommands.cs:126-170` RD asks "Dimension arc type [Length/Radius/Diameter/?]" first (`:136`) and only then starts the native pick (`StartInteractiveDimensionCommand`).

### BATCH S-12

27. **BUG-579, CANNOT TELL.** The depth is held as `FoundationElementData.Depth` (`Models/FoundationModels.cs:101`), set at placement and read back by FEDIT (`FoundationService.cs:1942-1948`) and the schedule (`FoundationScheduleBuilder.cs:160-204`). The fault is a loss after Undo/Redo of the registry record, which I could not follow to a line from reading. No commit or REGRESSION_LOG line names it. It needs an AutoCAD run (place with depth 350, U, REDO, FEDIT) or a trace of the registry write timing. I did not read the registry write order, so I will not guess.
28. **BUG-615, STILL THERE.** `Commands/HatchCommands.cs` CH (`:214`) builds the hatch directly (`:484-519`). The only "preview" in the file is the BUG-614 scale rule (`:1661`). No live result and no Apply.
29. **BUG-1129, STILL THERE.** `Services/StandardsService.cs:83` has N20 at 2.47 kg/m. `Assets/Config/rebar-catalogue.json:8` has 2.466. Two tables remain.

### BATCH S-13

30. **BUG-526, STILL THERE.** `UI/Dialogs/CeSettingsDialog.xaml.cs` (610 lines) and `SettingsDialog.xaml.cs` and `BeamSettingsDialog.xaml.cs` refer to none of the 29 named groups except `CeSheets`. I searched each group name as `.Group`. `UserSettings.cs` still declares the groups (54 group properties in the file).
31. **BUG-533, STILL THERE.** `Models/UserSettings.cs:811` `RequiredNorthSouthMm` (and the East-West twin) is still a PC-wide setting; `Commands/BracingPanelCommands.cs:95-125` reads and writes it there.
32. **BUG-535, STILL THERE.** No `StripWidthMm`, `BeamWidthMm` or `BraceLength` reference in `Modules/Structural/UI`. (I did not check each of the six values separately; the entry's own desk note says the list is not exact.)

### BATCH S-14

33. **BUG-470, ALREADY FIXED.** HUNT-S-05, PR #899 (`987ca9dd`, merged into S-31 as `1907fd78`). `Services/FoundationService.cs:3911-3918` calls `RefuseCentrelinePick(TryResolveFootingEntity(...))`. `FoundationService.Identity.cs:89-114` returns the sentence for CE's own outline, a raft edge or another footing's centre line, and the line is left alone ("Nothing was drawn"). It is a native-protection refusal, and I found no Settings switch. Pinned by `HuntS05CentrelinePickTests`. Drafter sees: picking an existing footing's outline in FSF gives a plain refusal and no strip is lost.
34. **BUG-536, STILL THERE (part fixed).** Part by part on the ref:
   1. **SCREWPILE:** fixed. `FoundationScrewPileService.cs:172` offers `FoundationService.ScrewPileOfferedMmSetting()` (commit `9e8ad52e`, default 300, unchanged).
   2. **BP bored pier:** half. `FoundationService.cs:2075` reads `BoredPierPlan.DefaultDiameterMm`. The block is still the fixed `450DIABPV2` (`:2107`).
   3. **REBAR:** fixed. `NativeTimToolsService.cs:955-957` read `DefaultSize`, `DefaultSpacing`, `DefaultBarCount`.
   4. **Beam shorten:** fixed. `BeamPlacementCommands.cs:1428-1438` uses `BeamDistanceChoices` from Settings.
   5. **Label height:** still two commands only (two files use `LabelPlotHeightMm`). Tied to BUG-531.
   6. **Member schedule:** still fixed constants (`ExcelMTextService.cs:37-53`).
   7. **Footing schedule:** still fixed base widths 3600 and 1800 (`FoundationScheduleService.cs:32-33`) and the ScheduleService constants.
   8. **CSLOADPATH:** still built-in round-up to 50 mm (`LoadPathEngine.cs:214`) and pier counted as 450 (`:138`).

### BATCH S-15

35. **BUG-473, ALREADY FIXED.** HUNT-S-08 (`06af5e65`, Opus round `a12ec15a`; part of the HUNT-S train into S-30/S-31). `Commands/BracingCommands.cs:19,135,250` (`FirstLockedLayer` then `LockedLayerLine`, return before any draw) cover AB, BB and BT1. `SupportBlockCommands.cs:223-229` covers C1 and TS1. `BeamTextConvertCommands.cs:77,236-240` covers BTX (locked text is counted and skipped, one plain line). Pinned by `HuntS08LockedLayerTests`. No unlock anywhere. No Settings switch (native protection). Drafter sees: with the layer locked, the command says so in one line and draws nothing.
36. **BUG-1186, STILL THERE.** `Services/TimberSubfloorService.cs` has no locked-layer check (searched `locked`, `FirstLockedLayer`: none). `LegacyToolCommon.EnsureLayer` (`:228-243`) deliberately keeps an existing layer's lock and never refuses. Tagging still writes into a locked 25TEXT and prints "Tagged".
37. **BUG-1187, STILL THERE.** `UI/LayerManagerWindow.xaml.cs:366-367` `ToSnapshot` still sets `LineWeight.ByLineWeightDefault` when `TryParseLineweight` fails, with no field error.

### BATCH S-16

38. **BUG-1134, STILL THERE.** `Core/Schedules/MemberScheduleFromPlan.cs:215-216` uses `Distinct(StringComparer.OrdinalIgnoreCase)` on `SizeText`, which is only trimmed (`:35`). "310UB32" and "310 UB 32" still count as two sizes. (Command is off by default.)
39. **BUG-1203, STILL THERE.** `Plugin.cs:156` runs `XclmTxtCorpusIndexService.Initialize()` at start-up. `XclmTxtCorpusIndexService.cs:48` calls `RequestRefreshIfStale()` unconditionally. `BackgroundRefreshEnabled` (`UserSettings.cs:1137`) is read only in `XclmTxtService.cs:33`, after the first initialisation.
40. **BUG-1219, STILL THERE.** `Assets/Config/command-registry.json:2078-2082` (Beam Settings, command "8") still lists prompts "Start point / End point / Text/suffix options", and `:2672-2686` (RJSET) still lists "Direction selection / Extent selection / Tag text". Both commands open CE Settings.

### Notes for whoever builds next
1. **Safe to drop from the queue:** BUG-470, BUG-473. BUG-611 after one Codex look.
2. **Cheapest real fixes, by reading:** BUG-1126 (format), BUG-1128 (whole-word PL), BUG-1131 (over-100 as mm), BUG-1219 (help text), BUG-1187 (refuse a bad lineweight), BUG-1134 (strip spaces before compare), BUG-1129 (one table). Each is a single-file change.
3. **Needs a decision before building:** BUG-1132 (wait for BUG-818 or build the old-names field now), BUG-613/627/631 (compound-move design, ST-08 cards not approved).
4. **What I did not check:** I did not run the code. I did not open AutoCAD. For BUG-1200 I did not trace the outline-before-text half. For BUG-535 I did not check each of the six values one by one. For BUG-579 I could not trace the cause.
