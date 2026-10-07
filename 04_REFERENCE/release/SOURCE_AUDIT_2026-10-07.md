# SOURCE AUDIT, 7 October 2026 (whole installed source, five patterns)

**Read-only audit.** Nothing was built, run or changed. Written for Tim; the "what it means" part comes first.

## 1. THE ANSWER FIRST

1. **Total: 49 findings. 2 HIGH, 28 MEDIUM, 19 LOW.** No finding is a crash; the two HIGH ones can change a drafter's drawing without being asked.
2. **Native protection is mostly very good.** Drainage checks locked layers, Xrefs and REFEDIT before it writes (one shared check, `IsSpineWritable`, at `LinkService.Spine.cs:735`). Manager's block insert refuses locked or frozen layers. The two exceptions are in section 5.
3. **Biggest weakness is Settings-first (R-00).** The Edit Pipe size strip, Civil Design (auto-design), the pump sizer, the reuse-credit rules and several Structural proposal tools still carry their own engineering numbers. Several of them use a quiet default when a value is missing instead of saying Unknown.
4. **Raw error text reaches drafters in about 150 places** (about 120 Structural, 25 Drainage, 4 Manager). Drainage has mostly been cleaned; Structural has not. No setting key names (like `FoundationProposal.Enabled`) appear in drafter text; they only appear in code comments.

**What was audited.** Drainage, Manager and CE_SHARED in `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\c19asm` (branch claude/rel-20261007c, Civil 3.0.33 and Manager 1.1.33, head d2575455). Structural in `...\worktrees\s20asm` (branch claude/rel-20261007s, Structural 1.0.103, head 6f2e9763). Tests, obj and bin folders were excluded. None of the findings below repeats the three Codex sweeps (I searched them for these files and topics first: no overlap).

**How "reachable" was decided.** Drainage and Structural call paths were followed in the source. Only `CDIMPORTXCIVIL` was confirmed on the Civil ribbon (`CeCvlRibbonContributor.cs:158`). Where I did not check the ribbon, I say "yes by call path".

---

## 2. PATTERN 1: ENGINEERING OR COUNCIL NUMBERS HARD-CODED (12 findings: 11 MEDIUM, 1 LOW)

1. **Velocity, cover and grade tables built into the code. MEDIUM. Reachable: yes.**
   `Drainage/Services/MaterialVelocityLimits.cs:37-60` holds the scour speeds (3, 6, 4, 6 m/s), the 0.6 m/s self-cleansing speed, the 600 mm cover and the 1:100 / 1:200 minimum grades. The file itself says "PLACEHOLDER, Tim to confirm". The Edit Pipe size strip uses them directly (`PipeEditCommand.GradeSuggestion.cs:249` calls the one-argument `Advise`, which uses `BuildStandards`). Project Review reads Settings instead, so the same pipe can get two different answers.
2. **Office default standards used by several tools. MEDIUM. Reachable: yes.**
   `Drainage/Models/PipeSizingModels.cs:55,69,111-122` (`CreateDefault`: 0.6 m/s, 6.0 m/s, AS3500 grade ladder, 600 mm cover, 100-750 mm sizes). Used by `CdCommand.GradeSuggestion.cs:380`, `MarkupToChangePlanService.cs:92`, `AutoDesignOrchestrator.cs:206`, `AutoDesignService.cs:530` and `NetworkDesignService.cs:97`. Cover is overridden from the rulebook in some of these, but speed and grade ladders are not.
3. **Pump sizer constants. MEDIUM. Reachable: yes (Civil Design to auto-design: `CivilDesignService.cs:167`, `AutoDesignOrchestrator.cs:172`).**
   `Drainage/Services/PumpSizingService.cs:75-145`: runoff C of 0.90 and 0.30, 30 minute emptying, the pump duty ladder 1-12 L/s, the 5 L/s rising main switch (50 mm or 80 mm), 0.10 m top working level, 1% catchment term, 1-in-100 and 5 minute ramp check.
4. **Bayside rule written into the code. MEDIUM. Reachable: yes (same path).**
   `PumpSizingService.cs:122-125,295-306`: if the council is "bayside" the design ARI is changed to 20 years. It is recorded in a note, but the council value should live in the council profile.
5. **Council reuse-credit rules written into the code. MEDIUM. Reachable: yes (`AutoDesignOrchestrator.cs:153`).**
   `Drainage/Services/ReuseCreditService.cs:60-62` and the rules below it: Manningham 2000 L, 50 m2 and 0.25 factor; Kingston 500 L per 2000 L block; Casey fraction; 3000 L maximum tank. Any other council gets "no reuse-credit rule".
6. **Casey orifice formula written into the code. MEDIUM. Reachable: yes.**
   `Drainage/Services/AutoDesignService.cs:329-331` (`id == "casey"` then `SizeCaseyDiameterMm`, d = 21.9 times root of PSD over root of head).
7. **Quiet 5 minute time of concentration. MEDIUM. Reachable: yes.**
   `Drainage/Services/RationalFlowService.cs:57-60` (`DefaultTcMinutes = 5`, small lot 1000 m2). Used whenever the council has no Tc: `AgreedDesignRules.cs:105`, `AutoDesignService.cs:297`, `DetentionSizingService.cs:216-218`. No warning is shown that a default was used.
8. **Survey intake tolerances. MEDIUM. Reachable: yes (CDSURVEY).**
   `Drainage/Services/SurveyIntakeSanityService.cs:28-49`: spot against surface 0.10 m, duplicate 0.05 m and 0.01 m, RMS 0.25 m, 50% surface coverage. These decide whether an intake can be approved, and none is in Settings.
9. **Plausible grade range for marked-up changes. MEDIUM. Reachable: yes by call path.**
   `Drainage/Services/MarkupToChangePlanService.cs:58-59,274`: a read grade outside 1:10 to 1:2000 is dropped as "likely a misread".
10. **Structural proposal engines carry their own numbers. MEDIUM. Reachable: yes (CEAUTOSUPPORT draws preview markers only: `AutoSupportCommands.cs:59`).**
    `Structural.DesignCore/BeamProposalEngine.cs:74-104` (span 1000-9000 mm, gaps, merge tolerances), `WallPairingService.cs:22-34` (wall pair gap 70-350 mm, stud 70-120, masonry 200-350), `SupportPlacementEngine.cs:42,88-89` (4000 mm column beam, gap 50-600), `MinedDefaults.cs:15-54` (bearing 300, pad spacing 1140, column 1450, generic 1660). The code comment in `StructuralComputationOptions.cs` says the engine "never holds an engineering value of its own"; this is not true for these files.
11. **Brace maximum length 2700 mm, and the brace is shortened without asking. MEDIUM. Reachable: yes.**
    `Structural/Commands/BracingCommands.cs:50-53`: "Length exceeds maximum of 2700 units. Setting to maximum." The drafter's picked length is silently cut. Same number at `BracingService.cs:1472`. This is also a stop beyond the allowed ones (R-27).
12. **Pit sump depth 0.30 m in the long section. LOW (not traced to the drawing). Reachable: yes by call path.**
    `Drainage/Services/LongitudinalSectionService.cs:314`.

**Looked at and left out (not engineering):** text and dimension offsets, layout gaps, clearances in detail drawings, array sizes, iteration limits, unit conversions, `PitCommand.cs:27-28` (text corner offsets), `ColumnDetailCommands.cs:20` and `SectionDetailCommands.cs:20` (`DefaultCover = 40` is declared but never used).

---

## 3. PATTERN 2: HARD BLOCKS BEYOND THE ALLOWED ONES (7 findings: 4 MEDIUM, 3 LOW)

Refusals for locked layer, Xref, REFEDIT, read-only drawing and Paper Space were treated as native protection (allowed) and are not listed. There are about 40 such lines and they all read correctly ("Nothing was changed").

1. **Civil Design refuses the whole design on engineering conditions. MEDIUM. Reachable: yes.**
   `Drainage/Services/AutoDesignOrchestrator.cs:53-67,95-120,145,177`: site area not above zero, impervious area outside 0 to site area, no council picked, zero orifice head, roof from Xref "not machine-readable", site type not supported, no pump or soakage inputs. Per R-27 these should warn and carry on where a figure can be left Unknown.
2. **Survey intake blocked. MEDIUM. Reachable: yes.**
   `Drainage/Commands/CdSurveyCommand.cs:178-181`: "Intake blocked - suspect or conflicting evidence ... cannot be activated". Nothing is stored. I did not find a ruling by Tim for this block.
3. **Slab boundary edits refused. MEDIUM. Reachable: yes.**
   `Drainage/Services/SlabBoundaryEditPlan.cs:176,187`: a boundary point with source or spot-level evidence "cannot be removed", and a level "cannot change source" without an explicit Manual confirmation.
4. **Water tank split hides the numbers when volume exceeds tank height. MEDIUM. Reachable: yes.**
   `Drainage/Services/WaterTankZoneSplit.cs:81-86`: reuse and detention volumes are replaced with Unknown when the total is taller than the tank. A warning with the numbers still shown would meet R-27.
5. **Joint shorter than 50 units cancels the command. LOW. Reachable: yes.**
   `Structural/Services/JointDraftingService.cs:44-47` and `BeamDraftingStandards.cs:73`.
6. **SBEAM refuses on drawing-scale problems. LOW. Reachable: yes.**
   `Structural/Commands/SbeamCommandRunner.cs:49,93,103` ("SBEAM refused: DIMSCALE does not provide a usable text height").
7. **Export path rule. LOW. Reachable: unknown (looks like a developer export).**
   `Drainage/Commands/ExportEntitiesCommand.cs:64`.

---

## 4. PATTERN 3: UNKNOWN TURNED INTO ZERO OR A QUIET DEFAULT (18 findings: 13 MEDIUM, 5 LOW)

The `?? 0` search had about 460 hits. Almost all are counts. These are the ones on engineering or drawing values.

1. **Unknown ground level becomes RL 0 in pipe sizing. MEDIUM. Reachable: yes (Edit Pipe strip).**
   `Drainage/Services/PipeFlowSizingAdvisorService.cs:176-177` (`UpstreamSurfaceRl ?? 0`). The Project Review path guards this (`PipeSizeNetworkReviewService.cs:479-511`); the Edit Pipe path does not.
2. **Unknown cover level becomes RL 0 in network design. MEDIUM. Reachable: yes (Civil Design).**
   `Drainage/Services/NetworkDesignService.cs:517-518` (`CoverLevelM ?? 0.0`).
3. **Council-provided PSD with nothing typed becomes 0 L/s. MEDIUM. Reachable: yes.**
   `Drainage/Services/DetentionSizingService.cs:191`.
4. **Missing Settings minimum cover becomes 0. MEDIUM. Reachable: yes.**
   `Drainage/Commands/PitEditCommand.cs:1024` and `Drainage/AI/SmartifyPitTool.cs:235` (`MinimumCoverDepth ?? 0`): no minimum is applied and nothing says so.
5. **Rulebook with no cover quietly gets 600 mm. MEDIUM. Reachable: yes.**
   `Drainage/Models/PipeSizingModels.cs:63-66` (`ResolveMinCoverMm`, "ASSUMPTION ... 600"), used at `PipeFlowSizingAdvisorService.cs:85,106`. It is a default standing in for Unknown.
6. **Reversing a pipe writes 0.00 into the stored levels when a level is blank. MEDIUM (not run, worth a Codex test). Reachable: yes.**
   `Drainage/Services/LinkService.NetworkEdits.cs:313-315` (`TryParseDouble(...) ? first : 0.0`).
7. **X-Civil pit with no coordinates is imported at the drawing origin. MEDIUM. Reachable: yes.**
   `Drainage/Helpers/LandXmlParser.cs:143-146,452` (missing northing or easting reads as 0.0).
8. **Schedule read from the PDF turns missing widths, depth and diameter into 0. MEDIUM. Reachable: yes by call path.**
   `Drainage/Services/XcivilVisionScheduleParser.cs:113-136`.
9. **Water tank with no library entry gets 0 length, width and height. MEDIUM. Reachable: yes.**
   `Drainage/Commands/WaterTankCommand.Apply.cs:352-354`.
10. **Council minimum orifice unknown becomes 0, so no minimum is applied. MEDIUM. Reachable: yes (CDCALC Detention page).**
    `Drainage/ViewModels/DetentionSystemViewModel.cs:966,997`.
11. **Unknown section size is drawn as a zero-size section. MEDIUM. Reachable: yes (SBEAM).**
    `Structural/Services/SbeamAtomicPlacementWriter.cs:300-310`.
12. **Legacy brace with no stored length gets 2700. MEDIUM. Reachable: yes.**
    `Structural/Services/BracingService.cs:2127`.
13. **Computations sheet can say "short by 0 L" when the shortfall is unknown. MEDIUM. Reachable: yes.**
    `Drainage/Rules/ComputationsSheetV3.cs:265` (`shortBy ?? 0`). The printed sheet would show a wrong number.
14. **Pit width 0 passed to the pit advisor when the field cannot be read. LOW.** `Drainage/Commands/PitEditCommand.cs:1034-1035`.
15. **Pipe diameter 0 when text cannot be read. LOW.** `Drainage/Services/ProposalApplyService.PlanBuilders.cs:197`.
16. **Flat-pipe repair: missing steepest grade or longest run becomes 0. LOW.** `Drainage/Services/LinkService.FlatPipeRepair.cs:35-36`.
17. **Suggested size ?? 0 in the pipe size review. LOW (not traced).** `Drainage/Services/PipeSizeNetworkReviewService.cs:687,827,850`.
18. **Computations tolerance defaults to 0. LOW. Reachable: no** (documented "nothing calls it from a command yet" and switched off by default). `Structural/Services/StructuralComputationOptions.cs:22-23`.

**Checked and clean:** `GetValueOrDefault()` appears only 3 times, none on an engineering value. `double.Parse` and `Convert.ToDouble` on engineering values are in try/catch or on checked data.

---

## 5. PATTERN 4: NATIVE PROTECTION BYPASSES (6 findings: 2 HIGH, 4 LOW)

1. **X-Civil import unlocks the drafter's locked layers. HIGH. Reachable: yes (X-Civil button on the Civil ribbon).**
   `Drainage/Services/XcivilImportService.cs:1474-1501` sets `IsLocked = false` on 13 named layers plus every pipe layer (pit, labels, arrows, GUIDELINES, 18CONT, RETAINING WALL, HATCH 31, RAINWATER TANK and more), called at `:235` and `:1826`. It relocks afterwards (`:1522-1553`, in a `finally`). In between, `ClearPreviousXcivilImportArtifacts` (`XcivilImportReportService.cs:602`) erases earlier imported pits, pipes and labels. No preview, no question, only a debug line records it. On a drawing where a drafter locked those layers on purpose, a re-import erases and rewrites them. This is the one place that breaks the "never silently unlock" rule.
2. **Starting any strip footing command quietly re-layers objects across the whole drawing. HIGH. Reachable: yes (SF, BSF, STRIPLAYERSMERGE).**
   `Structural/Services/CeTextService.cs:4301-4380`, called at `:549,1046,1399,1457`. It walks every block definition in the drawing, opens each object "for write" (`:4346`), moves it to the canonical strip footing layer, and then erases the old alias layers when empty and unlocked. Failures are swallowed (`catch { // keep going }`), so locked ones are skipped quietly and the drafter is never told. The drafter asked to draw a footing, not to tidy layers.
3. **Marker clean-up force-opens an object on a locked layer. LOW. Reachable: yes.**
   `Drainage/Services/NativeInteractionProjectionService.cs:134-148` (forced open of the extension dictionary, best effort, hidden marker only).
4. **Pasting an Xref copies lock, freeze and off onto the pasted layers. LOW. Reachable: yes.**
   `Structural/Services/NativeCopyPasteXrefService.cs:263-284` (the copied state, applied to the new Xref's layers only). `:160` also swallows an Xref reload failure (`catch { }`).
5. **Layer Manager "Apply standards" sets lock state from the standard. LOW. Reachable: yes (drafter presses the button).**
   `Structural/Services/LayerService.cs:492-505`.
6. **Line style command thaws and turns on the chosen layer. LOW. Reachable: yes.**
   `Structural/Commands/LineStyleCommands.cs:179-180`.

**Checked and clean:** every force-open in Drainage (`GetObject(..., ForWrite, false, true)`: `LinkService.CloneRegeneration.cs:316`, `PipeMoveHelpers.cs:743`, `InvertPropagation.cs:1253`, `LongitudinalSectionService.cs:2428`, `WaterTankCommand.Apply.cs:288`) is either on an object the same command just made, or is preceded by `IsSpineWritable` or the section writer's own protection test. `Explode` is used only on blocks the plugin just placed or in memory only (`OnSiteDetentionCriteriaService.cs:225`, `CeBlocksInsertService.cs:175`, `ExcelMTextService.cs:5019`, `FoundationService.LoadTrace.cs:207`). No Xref detach or bind exists anywhere.

---

## 6. PATTERN 5: RAW ERROR TEXT OR SOFTWARE WORDS SHOWN TO THE DRAFTER (6 groups, all LOW, but wide)

1. **Structural's central error handlers print the raw error for every command. LOW (wide). Reachable: yes.**
   `Structural/Commands/CeStrucCommandBase.cs:136`, `Commands/Base/BaseStructuralCommand.cs:35`, `Services/CommandSafetyService.cs:64`. Any failure in any Structural command shows `[CE_STRUC] <command> error: <raw message>`.
2. **Manager. LOW. Reachable: yes.**
   `Manager/Commands/PluginManagerCommands.cs:250`, `Services/CeBlocksInsertService.cs:196`, `CeBlocksPaletteService.cs:26`, `CeSuiteManagerMenuService.cs:149`.
3. **Drainage (about 25 sites). LOW. Reachable: yes.**
   `Commands/CdCommand.SamePlanBreak.Atomic.cs:147`, `CdCommand.SamePlanBreak.cs:187`, `CivilDesignCommand.cs:180`, `CopyRotateCommands.cs:60,176,255,466`, `FeedbackCommand.cs:69`, `HubCommands.cs:797`, `NativePipeObjectCommands.cs:117,182`, `PipeEditCommand.cs:253`, `PipeEditCommand.SizeWrite.cs:276`, `PitEditCommand.cs:637`, `StripDrainCommand.cs:406`, `WaterTankCommand.cs:399`, `WaterTankCommand.Window.cs:189`, `Services/CalculationDraftCloseGuard.cs:29`, `Controls/CeAssistantControl.xaml.cs:246,785`. Test-runner lines (`CdTestRunnerCommand.cs:98,117`) are developer-only.
4. **Structural windows (about 70 sites). LOW. Reachable: yes.**
   `UI/Dialogs/CeSheetsWindow.xaml.cs` (9), `CeSheetsManagerWindow.xaml.cs` (22), `UI/Palette/SheetsPanel.xaml.cs:152,201`, `UI/LayerManagerWindow.xaml.cs:151-265` (5), `XclmTxtDialog.xaml.cs:677-808` (4), `ReportsDialog.xaml.cs:169,402,426`, `SettingsDialog.xaml.cs:144`, `TemplateEditorDialog.xaml.cs:481,530`, `ChecklistPanel.xaml.cs:788,931,961`, `MainPalette.xaml.cs:2274,2302`, `NotesPanel.xaml.cs:1135`, `CeIssuePublishDialog.xaml.cs:320`, `TimeEntryBrowserWindow.xaml.cs:50,226`. Some even say "check the log file" inside the same box.
5. **Structural commands and services (about 50 sites). LOW. Reachable: yes.**
   `Commands/MarkupAICommands.cs` (10), `Services/NativeTimToolsService.cs` (8), `NotesSymbolsPlacementService.cs` (5), `UtilityCommands.cs:58,87,121,239`, `DimensionCommands.cs:445,463,505`, `SupportBlockCommands.cs:311,516,803`, `NativeCopyPasteXrefService.cs:107,169`, `NativeXrefLayerService.cs:108,139`, `ExcelMTextService.cs:546,3781`, `TimberSubfloorService.cs:131,234,410`, `HatchUpgradeCommands.cs:271,420`.
6. **Software words in drafter text. LOW. Reachable: yes by call path.**
   "failed the spine gate; see the CE log" (`Drainage/Commands/SpineCheckCommand.cs:132`), "Xrecord cross-validation" and "Xrecord audit error" (`LinkCommands.cs:409,421`), "has no ProjectData record" (`RunSolveCommand.cs:288,467`), file names `ground_truth.json`, `source_meta.json`, `entity_dump_ce_final.json` (`LinkCommands.ImportXcivil.cs:497,539,575`), "Beam handle" (`Structural/Commands/BeamLinkDebugCommand.cs:52-53`, a debug command).

**Clean:** setting key names in drafter text, "NullReference", "Exception" and `ToString()` of exceptions: none found in message strings.

---

## 7. COUNTS

**Per pattern**
1. **Pattern 1, hard-coded numbers:** 12
2. **Pattern 2, extra hard blocks:** 7
3. **Pattern 3, Unknown turned into 0:** 18
4. **Pattern 4, native protection bypass:** 6
5. **Pattern 5, raw error text and software words:** 6 groups (about 150 sites)

**Per severity**
1. **HIGH:** 2 (both Pattern 4)
2. **MEDIUM:** 28 (P1 11, P2 4, P3 13)
3. **LOW:** 19 (P1 1, P2 3, P3 5, P4 4, P5 6)
4. **Total:** 49

**Per area**
1. **Drainage (Civil):** 30
2. **Structural:** 17
3. **Manager:** 1 group inside Pattern 5
4. **CE_SHARED:** 0 (only the Help store reads `?? 0` on a scroll position)

---

## 8. THE FIVE MOST IMPORTANT FINDINGS

1. **X-Civil import silently unlocks locked layers and erases earlier import objects** (P4-1, HIGH). `XcivilImportService.cs:1474-1501` with `XcivilImportReportService.cs:602`. Fix: refuse or warn on any locked target layer and ask, never unlock.
2. **Strip footing commands re-layer objects in every block and erase layers without telling the drafter** (P4-2, HIGH). `CeTextService.cs:4301-4380`. Fix: make it an explicit, previewed command; skip silently-failed objects no longer.
3. **Built-in speed, cover, grade and Tc numbers sit behind the Edit Pipe strip and Civil Design, and Unknown cover quietly becomes 600 mm** (P1-1, P1-2, P1-7, P3-5, MEDIUM). `MaterialVelocityLimits.cs`, `PipeSizingModels.cs:55-122`, `RationalFlowService.cs:57-60`. The Project Review list already reads Settings, so two screens can disagree on the same pipe.
4. **Unknown ground level, cover level or council minimum orifice becomes 0** (P3-1, P3-2, P3-10, MEDIUM). `PipeFlowSizingAdvisorService.cs:176-177`, `NetworkDesignService.cs:517-518`, `DetentionSystemViewModel.cs:966,997`. Breaks "Unknown stays Unknown" in sizing results the drafter will trust.
5. **Council rules and the pump rules are written into the code** (P1-3 to P1-6, MEDIUM). Bayside 1-in-20, Manningham, Kingston and Casey reuse rules, the Casey orifice formula, pump runoff C and duty ladder. They belong on the Settings page and in the council profiles (R-00).

**Next on the list:** Structural's central error handlers (P5-1) because they show raw text for every Structural command, and the 2700 mm brace clamp (P1-11).

---

## 9. NOT AUDITED

1. **Manager update delivery, signing and publish paths.** Not checked for the two allowed hard blocks (spine ID deletion, push on failed build) or for any extra stops.
2. **Shared/CE.Spine, CE.Release, CE.Diagnostics and the native C++ projects.** Not read.
3. **Whether each number has a Settings key.** Pattern 1 lists numbers in code; I did not open the Settings page to see which are already mirrored there (the code says velocity and cover tables exist as R-01 values but are not used by every screen).
4. **Every individual `OpenMode.ForWrite` site.** There are 351 in Structural and many hundreds in Drainage. I traced every force-open on a locked layer and the Structural files that edit existing objects most (CeTextService, NativeTimTools, Bracing, Notes, Layer, Xref); the rest were not traced one by one.
5. **Message text built in helper classes** (`*Words`, `CommandLineText`, `*Rule` classes, resource strings and XAML text). Only strings passed straight to WriteMessage, MessageBox and alert boxes were searched.
6. **Numeric literals inside method bodies** that are not named constants. The search covered named `const` and `static readonly` values.
7. **Ribbon, OFF-switch and hidden-command status** for each reachable command, except CDIMPORTXCIVIL.
8. **The s20asm copies of Drainage and Manager.** Only the c19asm copies were read for those two; I did not diff them against s20asm.
9. **Developer and harness commands** (CDTEST, debug commands) were noted but not judged.
10. **Nothing was run in AutoCAD.** All findings are from reading source; finding P3-6 in particular needs a real Reverse Flow test before anyone relies on it.
