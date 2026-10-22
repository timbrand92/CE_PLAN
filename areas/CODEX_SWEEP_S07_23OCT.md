1. **ANSWER FIRST — HIGH: 1; MEDIUM: 2; LOW: 0.** The most important fault is that a Blue Factor report's garden and lawn areas are added to **Roof and paved area**. A 1000 m² site with only 500 m² of roof and paving can enter Design as 1000 m² of roof and paving.

2. **Other findings.** Find says an existing pit such as P1A is absent. Design can also say “Nothing has changed since the design was agreed” after a changed orifice head has been saved.

3. **Confidence and limits.** All three findings are **verified-by-reading**, including their AutoCAD command or window callers. The tests below are instructions for a later native check; none was run. All 113 requested files were read. No build, test, AutoCAD session, installation, code edit or sub-agent was used.

---

4. **Audit basis.** S07, 23 October 2026, Melbourne date. Repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. Ref: `origin/claude/rel-20261022m`, pinned after fetch to `40ee0a36f7960145743954b39859eb6c3af92869` (Civil 3.0.70 / Manager 1.1.70). All source locations below refer to that revision, with paths relative to the repository. Reads used Git objects, including additional callers needed to establish reachability. The largest requested files were read first. The specified C58/C60/S40/S41 audit and available CODEX_AUDIT reports were read before the sweep; existing hunt/sweep reports were also checked for overlap. Previously reported faults are excluded. No suspected-only finding is counted. R-00 and R-27 were respected: these findings do not propose new hard blocks or new engineering defaults.

5. **S07-01 — HIGH — Garden and lawn are imported as roof and paving. Status: verified-by-reading.**

   **Primary location:** `Modules/Drainage/Rules/BlueFactorReport.cs:112`; accepted surface types at `BlueFactorReport.cs:39`.

   **In AutoCAD:** A drafter accepts the job's rating report in CDDESIGN. CE overstates roof and paving by including the garden and lawn. The resulting number is offered as an ordinary engineering input and fills the Design window. The drafter need not make any arithmetic mistake.

   **Exact failure scenario:** A recognised Blue Factor report contains separate roof, paved, garden and lawn catchments. Their combined area is no greater than the site area, and the drawing does not already supply a competing roof-and-paved figure. The parser accepts all four surface types, but writes every catchment's full area into `ImperviousAreaM2`. Surface type survives only as `TreatmentAsWritten`; it does not control the sum.

   **Proof and reachability:** `BlueFactorReport.cs:39–41` accepts Garden and Lawn as well as Roof and Paved; `:100–115` gives them identical area treatment. `Modules/Drainage/Rules/StormReport.cs:76` sums every row into `TotalImperviousM2`; `:97–100` derives pervious area by subtracting that total from site area. `Modules/Drainage/Rules/StormReportOffer.cs:105–109` labels the total “Roof and paved area”. `Modules/Drainage/Services/StormReportReader.cs:172–195` feeds extracted PDF text through the rating-report parser. `Modules/Drainage/Commands/CivilDesignCommand.cs:499–514` builds, prints and applies the offer; `:563–571` assigns the bad total to `state.ImperviousAreaM2`. The plausibility check at `:502` does not reject a roof-and-paved total equal to site area. This is a reachable input error, not just an unused parser result. Subsequent engineering calculations receive the wrong area split; a precise storage error is not claimed without a particular council and rainfall fixture.

   **DETERMINISTIC TEST — fixture:** Use AutoCAD 2027 with the pinned Civil build, an isolated synthetic job folder named `26-901_AUDIT`, and an empty saved Civil model-space drawing under its `Civil` folder. The drawing must have no CDCALC areas and no saved site/roof area overrides. Put exactly one searchable-text PDF under `Civil\STORM Report - WSUD`. Its extracted text must contain these separate lines, with plain ASCII `m2`:

   ```text
   Blue Factor
   Site area 1000 m2
   ROOF TO WT1 Roof, 400m2
   DRIVE TO LPD Paved, 100m2
   GARDEN TO LPD Garden, 300m2
   LAWN TO LPD Lawn, 200m2
   100%
   SCORE
   ```

   **Typed/click steps:** Type `CDDESIGN`. Answer Yes to the question asking to look through the job's folders for its rating report and offer the site and roof areas. Complete any independent job/council questions without supplying an area. Open **Areas and route**.

   **Assertions:** Whole site area must be 1000 m² and Roof and paved area must be 500 m². At this revision, the code prints `Roof and paved area: 1000 m2 (from the STORM report)` and fills the latter window field with 1000. Its report facts consequently give zero pervious area instead of 500 m². The command-line and window values are the native-test assertions; no debugger is needed. Control: repeat in a fresh drawing with only the garden/lawn rows removed. The offered roof-and-paved value becomes 500, proving that those two rows cause the excess.

6. **S07-02 — MEDIUM — Find rejects valid pit names before looking for the pit or its pipe. Status: verified-by-reading.**

   **Primary locations:** `Modules/Drainage/Rules/CeFindQuery.cs:74–85` and `:98`.

   **In AutoCAD:** A drafter uses a legitimate pit number such as P1A. CEFIND says that pit is not in the drawing, even though it is visible and registered. Looking for its pipe by the two pit numbers fails too.

   **Exact failure scenario:** The current drawing contains registered pits P1A and P2, with a CE pipe recorded from P1A to P2. There are no duplicate numbers, erased entities or missing handles. The query parser recognises a pit only when its name is P followed entirely by digits. It requires that same restricted pattern at both ends of a pipe query. P1A therefore never reaches the recorded-pit search.

   **Proof and reachability:** `CeFindQuery.cs:54–70` classifies the query; `:74–85` rejects P1A, and `:96–102` rejects P1A-P2. P is not a source family, so the source-tag fallback does not rescue either query (`Modules/Drainage/Rules/SourceFamilies.cs:61–73`, `:211–222`). `Modules/Drainage/Commands/CeFindCommand.cs:80–110` dispatches this result directly to “is not in this drawing”, without searching pit records. In contrast, `Modules/Drainage/Rules/PitNumberAsTyped.cs:16–17` preserves typed identifiers, and `:30–42` permits a non-clashing new number; `Modules/Drainage/ViewModels/PitViewModel.cs:985` uses that acceptance rule. These are supported pit names, not malformed test data.

   **DETERMINISTIC TEST — fixture:** In one isolated Civil drawing, create ordinary CE pits named **P1A** and **P2** on unlocked layers in model space, plus a CE pipe from P1A to P2. Keep all three entities visible and registered, with valid handles. Confirm P1A in Edit Pit before starting; close the window without editing.

   **Typed steps:** Type `CEFIND`, enter `P1A`, then Enter. Repeat with `P1A-P2`. Run `CEFIND` with `P2` as the control.

   **Assertions:** P1A must be found and highlighted; P1A-P2 must find the connecting pipe. At this revision the first two commands instead print exactly `[CE] P1A is not in this drawing.` and `[CE] P1A-P2 is not in this drawing.`. P2 follows the normal find/highlight path. The false absence messages must not occur while these registered objects exist.

7. **S07-03 — MEDIUM — Saved orifice-head changes are invisible to the agreed-design check. Status: verified-by-reading.**

   **Primary locations:** `Modules/Drainage/Rules/AgreedDesignRules.cs:67–83` and `:221–233`.

   **In AutoCAD:** A colleague changes the head on the orifice, saves the draft and later reopens Design. During can still say “Nothing has changed since the design was agreed.” That assurance is false: a saved input used for orifice sizing differs from the agreed design.

   **Exact failure scenario:** Agree a design with head 0.45 m. Later change only that head to 0.60 m and choose Save Draft, without agreeing the design again. Reopen with the council, areas, rainfall, outlets and runoff settings unchanged and readable. The saved head is restored correctly, but neither the old nor the new head exists in the agreement comparison. The same omission affects the saved Detention is required choice.

   **Proof and reachability:** `AgreedDesignRules.cs:67–83` captures council, areas, rainfall, outlets and effective inputs. Its effective-input copy at `:110–114` contains only two runoff coefficients and time of concentration. `:221–233` never compares head or detention; `:157–158` consequently returns unchanged, and `:49` supplies the assurance text. `Modules/Drainage/ViewModels/CivilDesignWindowViewModel.cs:141–164` is the real snapshot caller. `:515–520` agrees the snapshot on Confirm setup, whereas `:562–585` saves head and detention in SetupInputs on Save Draft without refreshing the agreement. `Modules/Drainage/Services/CivilDesignService.cs:104–105` restores those saved inputs on the next opening. `Modules/Drainage/Dialogs/CivilDesignWindow.xaml:208`, `:241` and `:336` expose the editable head, During message and Save Draft button. The head is a working calculation input: `Modules/Drainage/Services/AutoDesignOrchestrator.cs:128` passes it through and `Modules/Drainage/Services/AutoDesignService.cs:227` uses it for orifice sizing.

   **DETERMINISTIC TEST — fixture:** Use an isolated Civil drawing with a valid selected council, unchanged positive site and roof/paved areas, readable outlet records and fixed runoff settings. Choose **From markup** so Confirm setup is available. Use a fresh agreement made by this installed revision, avoiding older incomplete agreement records. Keep any existing rainfall record unchanged.

   **Typed/click steps:** Type `CDDESIGN`; in **Areas and route**, tick **Detention is required**, enter `0.45` in **Head on the orifice (m)** and click **Confirm setup**. Reopen CDDESIGN and establish the control: During says `Nothing has changed since the design was agreed.`. In Areas and route change only head to `0.60`, then click **Save Draft**. Reopen CDDESIGN. Inspect both Areas and route and During; do not click Confirm setup again.

   **Assertions:** The saved head field must show 0.60 m. During must report that head changed from 0.45 m to 0.60 m and must not show the unchanged assurance. At this revision the new head is present but During still reports `Nothing has changed since the design was agreed.`. Optional second case, from a fresh agreed fixture: untick Detention is required, Save Draft and reopen. The false unchanged assurance also persists for that saved decision.

8. **Reading coverage — 113 of 113 requested files.** Every basename below is under `Modules/Drainage/Rules/` at the pinned ref. The list is ordered by file size, matching the largest-first reading pass. Additional caller reads are cited in the findings. “Read” means reviewed from Git, not executed, and is not a claim that every possible defect was excluded.

9. **Read 1–8:** `CloneOriginRule.cs`, `CouncilRuleValues.cs`, `FlatPipeRepairPolicy.cs`, `LockedLayerRecordWriteRule.cs`, `AgreedDesignRules.cs`, `BranchJunctionDisplay.cs`, `ComputationsSheetV3.cs`, `PipeSystems.cs`.

10. **Read 9–16:** `PitChildOwnershipRule.cs`, `ComputationsRecord.cs`, `CivilDesignWorkflow.cs`, `CopiedPipeDirectionRepairPolicy.cs`, `DetentionBranchCollector.cs`, `NativeEditEndpointOwnerRule.cs`, `DuplicateSourceTagPolicy.cs`, `OlderPipeLabelRule.cs`.

11. **Read 17–24:** `ClonePlacementProtectionRule.cs`, `ComputationsSheet.cs`, `CouncilRfi.cs`, `FigureProvenance.cs`, `GradeLockInvertWritePlan.cs`, `PipeEndClassification.cs`, `PitBlockScale.cs`, `PipeStartReadiness.cs`.

12. **Read 25–32:** `PipePitFitRule.cs`, `PipeEndJoinRules.cs`, `PipeBatchReadRule.cs`, `OopsBackSummary.cs`, `CivilNetworkTraversal.cs`, `EditGhostPlan.cs`, `DetentionTwlSolver.cs`, `LabelPlacementRule.cs`.

13. **Read 33–40:** `CdCommandLineSpecRules.cs`, `BlueFactorReport.cs`, `PitMoveLockedPipeRule.cs`, `PipeOopsPolicy.cs`, `PitDropRule.cs`, `JobChecklistDrafter.cs`, `FallArrowGeometry.cs`, `LivePickFeedbackRules.cs`.

14. **Read 41–48:** `PipeCrossingSplitPolicy.cs`, `DetentionStorageMath.cs`, `CrossingServiceRule.cs`, `PipeWindowPrefill.cs`, `JobFolderFromDrawing.cs`, `FlatPipeRepairFlow.cs`, `PipeLabelRewordRule.cs`, `CouncilLetter.cs`.

15. **Read 49–56:** `PipeEndRepairFlow.cs`, `PipeGripMove.cs`, `PavementAreaPlan.cs`, `CriteriaBlockRows.cs`, `DetentionVolumeRequired.cs`, `PipeEditRefusal.cs`, `DetentionDrawingFigures.cs`, `LpdNotePlacement.cs`.

16. **Read 57–64:** `PipeGripWords.cs`, `EditGhostPlan.Levels.cs`, `CatchmentReportIntake.cs`, `LandXmlPitClashRule.cs`, `PitLineworkReadCache.cs`, `CouncilSourceWords.cs`, `PipeObjectEvidenceRule.cs`, `GenericSourceTypes.cs`.

17. **Read 65–72:** `LayerNameRule.cs`, `PipeEndWallSnap.cs`, `BranchHostLabelTidyRule.cs`, `CeFindQuery.cs`, `NotInMarkup.cs`, `JobCouncilOfferRule.cs`, `PitMoveRecordSideRule.cs`, `PipeAttachmentRecordRule.cs`.

18. **Read 73–80:** `PipeLevelRefreshRule.cs`, `CopyCleanUpCompletenessRule.cs`, `LastPipeChoiceRules.cs`, `LegacyDownpipeEvidence.cs`, `CeFindFlow.cs`, `DrafterNameRule.cs`, `CdRoutePromptRules.cs`, `PitAnnotationLockRule.cs`.

19. **Read 81–88:** `PitLabelReconcileRule.cs`, `ObjectStatusRule.cs`, `CriteriaBlockInsertOutcome.cs`, `PairedPipeSplitRule.cs`, `LpdConnectionInput.cs`, `MixedUnitsUserHoldRule.cs`, `FallRatio.cs`, `PitLabelOnEscRule.cs`.

20. **Read 89–96:** `CopiedLevelsRule.cs`, `DetentionPipeLimitsRule.cs`, `CriteriaBlockValue.cs`, `CurrentLayerRepairRule.cs`, `PitBatchRefusal.cs`, `KerbLinePlan.cs`, `PitListRestoreRule.cs`, `AdoptedLineRoutePolicy.cs`.

21. **Read 97–104:** `CheckEndSentences.cs`, `DesignKeptAreaRule.cs`, `DraftingWords.cs`, `DoubleClickWording.cs`, `DetentionFreeboardRule.cs`, `HandPlacedLabelRule.cs`, `NewPitCoverProposalRule.cs`, `ContextualTabOwnershipRule.cs`.

22. **Read 105–112:** `PitLabelMismatchRule.cs`, `PinnedEndMap.cs`, `PitIdentityReadinessRule.cs`, `InspectorEditDispatchPolicy.cs`, `LabelTextHeightRule.cs`, `PitCoverTextGapRule.cs`, `FreshSourceSpineIdentityRule.cs`, `EditPipeRetidyRule.cs`.

23. **Read 113–113:** `FallSuggestPromptRules.cs`.

24. **Summary.** Three new faults are established by source and caller tracing: garden/lawn inflate roof-and-paved area, valid pit names defeat Find, and saved head/detention changes escape the agreed-design check. The first can alter engineering inputs; the others give false absence or unchanged assurances. All 113 requested files were read. Native reproduction steps are supplied but were not executed. Only this findings file is authorised for commit and push.
