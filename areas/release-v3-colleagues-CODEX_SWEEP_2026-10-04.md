# CE_ACAD — sweep-1 read-only review — 4 October 2026

1. **Lists used:** REVIEWLANE_LOG entry **622**, Sunday 4 October 2026, 20:17 as recorded; newest READINESS LISTS entry at review.
2. **C-21 — Civil and Manager (28):** #658, #666, #671, #669, #590, #667, #670, #687, #681, #685, #683, #695, #696, #701, #677, #684, #679, #691, #680, #682, #693, #698, #699, #694, #689, #697, #703, #705.
3. **S-22 — Structural (15):** #672, #662, #674, #675, #688, #630, #686, #678, #673, #665, #692, #704, #702, #700, #709.
4. **Scope:** PR descriptions, changed-file lists and diffs read with gh; six requested categories only, lines refer to each PR's new-side diff; OK is not build or AutoCAD acceptance, and CHECK includes unfinished features that remain switched off; no builds, tests or AutoCAD run.

#658 | OK | Modules/Drainage/Services/PitScheduleStatusService.cs:212 | The schedule names cells left out of date without bypassing their layer protection.

#666 | OK | Modules/Drainage/Commands/RulesCommand.cs:179 | Older pipe records are measured using drawing units rather than an assumed millimetre scale.

#671 | OK | Modules/Drainage/Services/BlockService.cs:678 | The temporary quiet setting is restored after block insertion without changing layer or Xref protection.

#669 | OK | Modules/Manager/Commands/PluginManagerCommands.cs:207 | The update advice uses plain words and introduces no new refusal.

#590 | OK | REGRESSION_LOG.md:3 | This records an ARRAY repair proposal and changes no working code.

#667 | OK | Modules/Drainage/Commands/SourceDestinationCommand.cs:47 | The affected commands read the current drawing's record rather than another drawing's pits.

#670 | CHECK | Modules/Drainage/Services/ScheduleLinkService.cs:3301 | Typing C 2 beside C2 is newly refused by treating spaces as irrelevant, although that choice remains unanswered and is not an allowed hard block.

#687 | CHECK | Modules/Drainage/Services/LinkService.LinkedTextEdits.cs:640 | Typing p5 over P5 now restores P5, refusing a capitals-only edit despite Tim's instruction to keep pit numbers as typed.

#681 | CHECK | Modules/Manager/Services/CeDiagnosticsService.cs:186 | Manager repair advice is bundled with an unrelated Pit Schedule Undo wording change, so the two fixes should be reviewed separately.

#685 | OK | Modules/Drainage/Services/RelinkedPipeRecordWriter.cs:152 | The pipe keeps its hand-typed end-level flags when its direction cannot be established.

#683 | OK | Modules/Drainage/Rules/CurrentLayerRepairRule.cs:30 | A valid current layer is left alone and the repair does not unlock protected layers.

#695 | OK | Modules/Drainage/Rules/RecoverInvertsCertaintyRule.cs:35 | Invert recovery removes the assumed 150 mm diameter and avoids guessing which pipe end is upstream.

#696 | OK | Modules/Drainage/Rules/RulebookValues.cs:165 | The council's recorded minimum velocity takes precedence while the office fallback is identified.

#701 | OK | Modules/Drainage/Rules/SurveyContourIntervalCheck.cs:29 | An unreadable contour interval stays unknown and the council check only warns.

#677 | OK | Modules/Manager/CE_SUITE_MANAGER.csproj:293 | The added checks concern the files prepared for an update and add no drafting refusal.

#684 | OK | Modules/Manager/Assets/Config/command-registry.json:11 | The command registration repair retains the typed commands and uses plain descriptions.

#679 | CHECK | Modules/Drainage/Services/Proposals/LevelsProposalDrawingReader.cs:160 | An unreadable pipe length becomes 0 in the proposal request instead of remaining Unknown.

#691 | CHECK | Modules/Drainage/Services/Proposals/LevelsProposalWriteStep.cs:46 | When enabled, any shortfall stops the whole run before its preview, leaving no way to choose the remedy promised by UX-L3-06.

#680 | OK | Modules/Drainage/Services/Proposals/SourcesProposalEngine.cs:45 | Missing report destinations stay Unknown for the drafter to choose.

#682 | OK | Modules/Drainage/Services/Proposals/NetworkGapReader.cs:29 | An unreadable drawing record is reported as unchecked rather than a complete network.

#693 | OK | Modules/Drainage/Services/Proposals/NetworkLayoutProposalEngine.cs:36 | Offering no layout before enough learning follows Tim's specific 26 September ruling.

#698 | OK | Modules/Drainage/Commands/LayoutGapsCommand.cs:52 | The gap window reports missing information and locates items without changing the drawing.

#699 | CHECK | Modules/Drainage/Services/Proposals/SiteClashCheck.cs:130 | The drafter's warning exposes siteClash.councilDrainBandM instead of a readable Settings label.

#694 | CHECK | Modules/Drainage/Services/Proposals/DetentionOptionsEngine.cs:143 | The storage pass allows a hard-coded 0.005 m³ (5 L) shortfall, an engineering tolerance that belongs in Settings.

#689 | CHECK | Modules/Drainage/Services/ScheduleLinkService.cs:3289 | An older table with no recorded last-written number refuses and replaces the first valid rename, requiring the drafter to type it again.

#697 | CHECK | Modules/Drainage/Rules/RulebookLevelsCheck.cs:87 | The new drafter-facing check identifies a pipe by its raw handle or no handle instead of its drawing name.

#703 | CHECK | Modules/Drainage/Services/BackgroundDownpipeSymbolReader.cs:154 | The new downpipe note exposes downpipeDetection instead of the name of the Settings control.

#705 | OK | Modules/Drainage/Rules/NewPitCoverProposalRule.cs:16 | The undecided cover proposal switch preserves existing behaviour and keeps a missing cover blank.

#672 | OK | Modules/Structural.DesignCore/DrawingUnitRule.cs:354 | This changes the wording of an existing units refusal rather than adding a new restriction.

#662 | OK | Modules/Structural/Services/AdminTelemetryService.cs:20 | The reporting change removes readable user names without changing engineering or drafting behaviour.

#674 | OK | Modules/Structural/Services/LegacyToolCommon.cs:451 | An AutoCAD Undo-mark failure is recorded without adding a new drafting refusal.

#675 | OK | Modules/Structural/Commands/BatterCommands.cs:71 | The changed command messages use drawing terms and preserve their existing behaviour.

#688 | OK | Modules/Structural/Assets/Config/command-registry.json:2317 | The help now gives the choices AutoCAD actually accepts.

#630 | OK | Modules/Structural/Commands/BeamInsidePointCommands.cs:47 | The wording replaces software errors with plain drafting advice and retains native protection.

#686 | OK | Modules/Structural/Commands/BeamInsidePointCommands.cs:47 | The shared prompt change and included wording sweep add no engineering rule or protection bypass.

#678 | CHECK | Modules/Structural/Services/FoundationService.Proposal.cs:35 | The switched-off message shows FoundationProposal.Enabled to the drafter instead of a plain Settings name.

#673 | OK | Modules/Structural/Models/FoundationStatusWords.cs:201 | Re-link now respects locked layers, Xrefs and reference editing.

#665 | CHECK | Modules/Structural/Assets/Config/command-registry.json:2317 | Wind-class help is bundled with unrelated footing selection and grip-unit fixes, so those changes should be reviewed separately.

#692 | CHECK | Modules/Structural/Services/CeIssuePreviewBuilder.cs:142 | A blank new revision blocks the issue even when every sheet keeps its existing revision and date, adding a refusal beyond the allowed exceptions.

#704 | OK | Modules/Structural/Services/CeSheetIssueState.cs:24 | Preview and issue use the same revision decision without substituting zero for missing information.

#702 | CHECK | Modules/Structural/Services/CeIssueJobWidePdfService.cs:103 | A raw software error is copied into the warning shown during issue, so the drafter can receive technical error text.

#700 | OK | Modules/Structural/Services/CeIssueDwgSnapshotService.cs:45 | The drawing-copy feature stays off pending the recorded reissue choice and adds no finding in these six review categories.

#709 | OK | Modules/Structural.Tests/Bug318StructuralScreenshotFolderTests.cs:1 | Only test picture destinations change, with no new drafting or engineering behaviour.

**Count: 29 OK / 14 CHECK — 43 PRs.**
