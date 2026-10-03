# Carpark audit, 4 Oct 2026 (review lane 01, headless run 74)

Read-only audit of `C:\CE_PLAN\BUG_CARPARK.md` (all 338 entries, as of 04:32 on 4 Oct). It lists the open entries a Team builder can fix with no ruling from Tim and no AutoCAD run (a fix plus unit or source tests is enough; Codex or Tim confirm later). The controller approved this audit. Three Opus readers each took a third of the file. Each one checked the release lines (`claude/rel-20261015e` @ 909f4bbd for Civil and Manager, `claude/rel-20261015v` @ 1fbf2f65 for Structural) and the open PRs for an existing fix. I re-checked two items myself (BUG-228 and BUG-388). Nothing was built or tested, and no entry in the carpark was changed.

Risk words: **safe wording** (text only), **small logic** (a contained code change), **careful** (saved data, calculations, reactors or release tests; needs an Opus review before merge).

## A. Builder can fix now (most useful first)

1. **BUG-322 item 2 + BUG-329 item 3**: the "copy the job record before applying" step drops pavement areas, spoon drains and review approvals. Where that copy is saved back, those records are lost, and the same-pipe break is refused on jobs that have them. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Services/NetworkRedesignProjectDataFreezeService.cs` (TryFreeze), `Modules/Drainage/Models/ProjectData.cs`. Risk: **small logic** (data safety, so it goes first).
2. **BUG-252 (material word matching only)**: any material containing "PIPE" matches "PE", so CONCRETE PIPE, RCP PIPE and EXISTING PIPE get plastic roughness 0.010. Use the whole-word match `MaterialVelocityLimits` already has. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/DesignValidationService.cs` (TryGetManningsN, about lines 170-187). Risk: **careful** (calculation). Leave "Unknown instead of 0.013" for Tim (section B).
3. **BUG-330 (Opus addendum)**: in metre drawings the CDCALC pre-fill and Design Review read pipe length 1000 times short, because they call the length helper without drawing units (the units version is used at InvertPropagation.cs:1142). The same call appears in RuleFixPlanner, RulebookEngine and MarkupToChangePlanService. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Services/CdCalcPrefillService.cs:104`, `Modules/Drainage/Services/DesignReviewService.cs:45`. Risk: **small logic**.
4. **BUG-231**: at AutoCAD shutdown, `Terminate` calls `FlushPendingSave()`, which forces a save even when nothing is waiting. This is the same crash risk class as BUG-224. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/PluginInitialization.cs` (about line 390), `Modules/Drainage/Services/ProjectDataService.Persistence.cs:396`. Risk: **careful**.
5. **BUG-244**: after a grip drag, MOVE or relink, a pipe between two open ends is re-resolved with the old `Resolve` rather than `ResolveWithLevels`, so it can quietly run uphill again. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/RelinkedPipeRecordWriter.cs:39`. Risk: **careful** (reactor).
6. **BUG-234**: with flat levels, a pipe moved onto two other pits keeps its old From/To. The `&& !storedNamesLeftTheEnds` condition is still missing at `if (hasStoredDirection)` (line 276). **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Helpers/ConnectedPipeFlowResolver.cs`. Risk: **small logic**.
7. **BUG-306 / BUG-320 item 4**: New Pit, CD and closing the Pit Schedule rewrite `CD_Settings.json` without a Settings save (still seen in the 3-4 Oct verify runs). The Opus design is recorded: a separate recent-values file, plus a guard that placing a pit leaves `CD_Settings.json` byte-identical. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Services/SettingsService.cs`, `Modules/Drainage/Models/UserSettings.cs`. Risk: **careful** (the entry says "Decide", but it is a design choice, not an engineering ruling).
8. **BUG-239**: CDRULES findings, review windows, Project QA and the CDAUTO report quote the raw internal source link (`CouncilRuleValues.cs:42` adds `provenance?.SourceLocator`). Route it through the existing `CouncilSourceWords`. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Rules/CouncilRuleValues.cs`, `Rules/RulebookEngine.cs`, `Rules/ReviewReading.cs`, `Services/CivilProjectQaContributor.cs`, `Services/DesignProposalReport.cs`. Risk: **small logic**.
9. **BUG-388**: the FDELETE question shows `[Yes/No] <No>` twice (CE types the hint and AutoCAD adds its own; checked at FoundationService.cs:1791 on 1015v). About 10 other Structural Yes/No prompts are built the same way: DiagnosticsCommands.cs:99, RebarCommands.cs:444, BracingService.cs:1720, FoundationService.cs:1559/1661/3774, FoundationService.LoadPath.cs:736, FoundationService.Marks.cs:86, NativeTimToolsService.cs:376, ReoBarService.cs:808. #605 (in 1015v) reworded the question but kept the double hint. **Structural**. Base: rel-20261015v. Risk: **safe wording**.
10. **BUG-365 other finding (d)**: Structural fault and usage reports carry the real Windows user and computer names (Civil hashes them with CePiiHash), and the report file name includes the user name. **Structural**. Base: rel-20261015v. File: `Modules/Structural/Services/AdminTelemetryService.cs` (lines 20-68, 185). Risk: **careful** (check what the Manager admin view reads first).
11. **BUG-228**: CDDIAG still prints "Full diagnostic dialog coming in v2.1 (PL-032)" (checked: DiagnosticsCommand.cs:42), and its tooltip promises an export that does not exist. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Commands/DiagnosticsCommand.cs:42`, `Modules/Drainage/Services/CeCvlRibbonContributor.cs`. Risk: **safe wording**.
12. **BUG-226**: the discipline button tooltip is a fixed "This drawing is Civil." and offers "Civil, Structural or Both", but the real prompt offers Civil / Structural / Clear. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/CeCvlRibbonContributor.cs:43`. Risk: **safe wording**.
13. **BUG-227**: the Settings tooltip promises "Personal, project and firm tiers" and pages that do not exist (CDMANAGER, CDLABELSTYLE, CDPARTS). **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/CeCvlRibbonContributor.cs:165`. Risk: **safe wording**.
14. **BUG-243**: surface overlay labels are a fixed 250 drawing units tall (250 m in a metre drawing). Use the existing `DrawingAreaUnits.MillimetresToDrawingUnits`. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/SurfaceOverlayTransientService.cs:24,102`. Risk: **small logic**.
15. **BUG-242**: the Inspector shows an old, wrongly saved raingarden or pavement area as "0.0 m²" with no note that it is out of date. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/InspectorPaletteService.cs:926, 2208`. Risk: **small logic**.
16. **BUG-253**: the safety checks before a pipe batch write exist twice (the size writer and the Edit Pipe batch). Fold them into one shared check (design rule 1) and add a source guard. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Commands/PipeEditCommand.SizeWrite.cs:324`, `Commands/PipeEditCommand.Batch.cs`, `Services/PipeSizeWriteService.cs:463`. Risk: **small logic**.
17. **BUG-331 item 4 remainder**: the long-section evidence keeps its own round-down grade copy (`Math.Floor`) instead of CD's one grade rule. **Civil**. Base: rel-20261015e. File: `Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:713`. Risk: **small logic**.
18. **BUG-176 (pass-18 message sub-item)**: when CDRG/GIO refuses a pick, the line always adds "Move the source and pick again", even when the reason is a drawing/project mismatch that moving cannot fix. **Civil**. Base: rel-20261015e. Files: `Modules/Drainage/Services/BlockService.cs` (about line 848), `Services/LinkService.SourceLanding.cs` (about line 306), and the test pinning the wording `Modules/Drainage.Tests/Commands/CdrgGioDiagnosticsTests.cs:97`. Risk: **small logic**.
19. **BUG-318 item 2**: test runs rewrite committed screenshots in `docs/image/V3_WINDOWS`; they should write to a temp folder unless asked. **Civil tests**. Base: rel-20261015e. Files: `Modules/Drainage.Tests/Dialogs/CivilHubWindowTests.cs:395`, `EditPipeWindowPresentationTests.cs:313`, `InspectorPaletteRenderTests.cs:217`, `Controls/DetentionLayoutTests.cs:170` and about 6 more. Risk: **safe**.
20. **BUG-318 item 1 / BUG-345 item 2**: `CalculationsWindowViewModelTests` fail after `CalculationsV2ViewModelTests` but pass alone (shared state between tests). **Civil tests**. Base: rel-20261015e. File: `Modules/Drainage.Tests/ViewModels/CalculationsWindowViewModelTests.cs`. Risk: **safe**.

**Next ones down (not in the 20):**
1. BUG-318 item 3 / BUG-247: Manager release-payload tests are permanently red (`Installer.Tests/BuildSafetyTargetTests.cs:589, 737-755`). Align them to the real build; add no build steps without Tim. Careful.
2. BUG-093 tidy-up: delete the dead `PipeAttachmentFlipGripOverrule.cs` and its tests. Careful.
3. BUG-061: join straight XCIVIL pipe runs that have no pit between them. Careful; it needs a test drawing.
4. BUG-251: Kingston commercial PSD storm and Tc only. Careful; check the K02 PDF first.
5. BUG-246: a schedule cell skipped on a locked layer is not marked out of date. Careful; it touches saved data.
6. BUG-221 / BUG-222: Manager window layout. These are window items, so they belong to Codex.

**Not carpark entries, from today's reviews (wanted before the next Civil install):**
1. #617 review HIGH: `BindToDrawingWithoutSaving` drops a failed pending save of the other drawing. This is #604's path and is already in 3.0.28. Base: claude/bug-385-revert-row-drop or 1015e. Careful.
2. #618 review LOW 1: a Pit Schedule reload puts back the set, pit type and group filters saved at the last close. Small logic.

## B. Needs Tim (a ruling or a drawing first)

1. **BUG-386**: should Revert Row Override put the original cover back (18.74), or only stop tracking the typed 18.80?
2. **BUG-380 / BUG-355 item 1**: should FEDIT treat a click on a footing outline as picking that pad or strip?
3. **BUG-351 (a)**: should a typed pit number like C2 stay as typed (not become PC2)?
4. **BUG-351 (b) / BUG-353 item 2**: a level typed in the Pit Schedule on a fixed-grade pipe changes that end only, or moves the far end to keep the grade?
5. **BUG-287 / BUG-338 item 4**: are there office UNITS-Metres templates or mm-pit job drawings, and what should CE draw in a true metre drawing?
6. **BUG-366 FAIL 2 / BUG-342 part 1**: does pasting CE pits or pipes into a drawing with no drainage wake Civil? (#567 is on HOLD for this.)
7. **BUG-365 (a)**: is it OK that Enter in a Settings number box saves the whole window?
8. **BUG-315 (1)**: with DIMSCALE 0, should schedule text stay 2.5 units or use a 1:100 sheet height?
9. **BUG-311**: when CDRUNSOLVE or CDPROPAGATE is cancelled, a palette edit is undone too. Accept that, or make palette edits wait?
10. **BUG-307**: Glen Eira back-test 35% off. Is the test wrong (soft ground 0.30 vs 0.35) or the engine?
11. **BUG-308 (d)**: Save Draft and Confirm only on the Start tab. Is that intended?
12. **BUG-283**: CDIMPORTXCIVIL unlocks about 20 layers. Skip and warn, or a Yes/No that names the layers?
13. **BUG-333 item 3**: CSLOADPATH in a metre drawing: measure nothing, or convert the stored widths?
14. **BUG-245**: pit to open end where drawn order and levels disagree: which wins?
15. **BUG-249**: the fixed Boyds intensity rows need a command card.
16. **BUG-251 (C part) / BUG-252 (rest)**: the Kingston commercial pre-development C rule; Stormpro and CMP roughness values.
17. **BUG-230**: what units do the office templates use?
18. **BUG-240 / BUG-354**: cleaning Tim's live AutoCAD profile (repeated trusted folders, old start-up LISP) needs his yes.
19. **BUG-302**: the code cites "Tim's ruling for #457", but no such ruling is recorded.
20. **BUG-080 / BUG-095**: UPVC maximum velocity (3.0 or 6.0 m/s); GE24-115 storage basis (1.80 or 2.58 m³).
21. **BUG-054, BUG-063, BUG-066, BUG-068, BUG-069, BUG-099 (part 2), BUG-103, BUG-172 (artwork)**: each needs a drawing, a screenshot or artwork from Tim.

## C. Code landed but the carpark still says OPEN (status lines to update after Tim or Codex confirm; not new work)

1. **Lines 54-1438:** BUG-279, 340 (items 1-6), 342 (1, 2, 5, 6), 334 (3-4), 272, 273, 274, 299, 300 (probably), 312, 313, 323, 325, 289-292, 285, 286, 288, 298, 281, 282, 293, 296, 297, 338 (1-3), 343 (1, 4), 349, 352 (1, 3), 353 (1), 381, 384, 385 (+ open #610 #612 #617), 367, 369, 370, 372, 376.
2. **Lines 1439-2864:** BUG-265, 264, 263, 262, 261, 260, 259, 258 (and probably 248), 257, 255, 254, 237, 236, 233, 232, 230, 224, 223, 210, 209, 205, 201, 200, 197.
3. **Lines 2865-5820:** BUG-012, 062, 064, 065, 067, 158, 167, 171, 172 (icons), 176 (main fix), 177, 160, 049 (probably), 011, 076, 003, 098, 099, 093 (superseded in code).

**Not checked:** no builds and no tests were run, nothing was run in AutoCAD, and only two claims were re-checked by hand. The open-PR search is a loose text match, so a PR that fixes one of these without naming its BUG number could be missed. Several "landed" commits come from the readers' `git log --grep` and are not individually verified.
