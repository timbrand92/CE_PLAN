1. **ANSWER FIRST — HIGH 1 / MEDIUM 3 / LOW 0.** Four findings, all verified-by-reading at the requested Civil ref. No finding has been reproduced in AutoCAD in this hunt.

2. **Most important — the new sheet can belong to the wrong job.** Open New job drawing from job A, then choose job B's folder: CE still fills the new drawing from job A's record. Changing the destination does not change the details it will write.

3. **Other faults a drafter will meet.** The schedule refuses direct editing of Remarks cells; clicking a pit from an attached drawing can highlight an unrelated host object; the job timer counts part of an idle break twice if the drafter accepts the offered time.

4. **Outcome.** Read all 154 requested files, including window bindings and their handlers, largest and central files first. Only this findings file was authored. No source edit, build, test, AutoCAD launch, installation, branch, worktree or sub-agent. The tests below are instructions for the later tester, not claimed passes. No engineering judgement or Manager administrator work was undertaken.

---

1. **Scope and evidence.** CODE SWEEP S10, 23 October 2026, Melbourne. Source repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. Read through `git show` / `git grep` after fetching origin. Every code citation below is at `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869` (the brief's Civil 3.0.70 / Manager 1.1.70 baseline). This does not independently certify the installed DLL. Structural's release was not audited in this Civil slice.

2. **Prior findings excluded.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the present `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`. The known Ignore/Tidy writes, ignored-check identity, logging outcomes, REDO investigation, downpipe double-click, installer gates and Structural findings are not repeated.

3. **Meaning of status.** Verified-by-reading means the actual control, its handler and the relevant downstream path establish the failure. It does not mean a native AutoCAD reproduction, screenshot or acceptance. Suspected candidates were not included in the four counts. No style-only finding or new hard-block proposal is included; R-27 and R-00 remain the governing rulings.

4. **Test isolation.** All fixtures below are synthetic and belong outside repositories. Use only job numbers, no identifying job details. Tests are for a separate later authorised AutoCAD pass against the pinned build. Preserve the fixture copies and captured window text, drawing values and CE log lines.

---

1. **S10-01 — HIGH — Changing the New job drawing folder retains the previous job's title-block data. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.cs:61`, `:93`, `:121`, `:128`, `:198`, `:202`.

   **What happens in AutoCAD:** A drafter working in job A opens New job drawing to make a sheet for job B. The sheet is created in B's folder, but its job number and any other populated title-block fields come from A. Starting from an unsaved drawing has the opposite failure: choosing a folder with an existing record can still say no record exists.

   **Exact failure scenario:** The constructor stores one readonly `_jobRecord`. Browse only changes `jobFolderBox.Text`. RefreshPlan reads the new folder's filenames but continues to prefer `_jobRecord.JobNumber` and passes that same old record into the plan builder. Create returns the new folder together with the old record's `TitleBlockUpdates`. This is not just an inaccurate preview.

   **Downstream proof:** `Modules/Drainage/Commands/NewJobDrawingCommand.cs:51`–`:56` loads the starting folder's record once. Its `:73`, `:92`–`:98` copies to the chosen folder and applies the dialog's unchanged updates. `Shared/CE_SHARED/Services/NewJobDrawingPlanBuilder.cs:108`–`:109` builds title-block updates from the supplied record; `JobRecordTitleBlockFieldMap.cs:45` maps JobNumber to `REF NO`. `CeDwgPropsCustomProperties.cs:56` writes those values into the new drawing's SummaryInfo.

   **DETERMINISTIC TEST — fixture:** Synthetic folders `26-901` and `26-902`, each with a `CE_JobRecord.json`: respectively `{"JobNumber":"26-901"}` and `{"JobNumber":"26-902"}`. Leave all other job fields empty. A saved blank drawing `26-901\seed.dwg`. An isolated office template folder containing only `Civil A3.dwg`, a valid DWG with a blank `REF NO` custom property; a FIELD displaying that property is optional. Point the test profile's Office templates folder to it.

   **Typed steps:** Open seed.dwg; type `CDNEWDWG`; set Job folder to the synthetic `26-902` folder; leave Civil and A3 selected. Read “Title block will show”. Click **Create and open**. In the new drawing type `DWGPROPS` and inspect the **Custom** tab's `REF NO`.

   **Assertion:** The preview and the new drawing must show `REF NO = 26-902`. The current path supplies `26-901` to both. Confirm the new file is in 26-902, so the test proves mixed job ownership rather than merely opening the wrong file. The command's “Title block filled” line must not be treated as proof of the correct job.

   **Correction direction:** Resolve the record from the currently chosen folder whenever the plan is refreshed; keep the chosen folder, record and final write together. Do not carry the starting drawing's record into a different job.

2. **S10-02 — MEDIUM — The Pit Schedule's Remarks cell cannot enter edit mode, and its cell actions cannot resolve it. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs:180`–`:184`, `:328`–`:332`, `:346`–`:364`; `Modules/Drainage/Dialogs/PitScheduleDialog.xaml:844`, `:894`.

   **What happens in AutoCAD:** A drafter double-clicks a Remarks cell to change a schedule note. CE refuses it with “This cell cannot be edited.” This affects ordinary current-drawing rows and manual rows. The separate CUSTOM REMARKS box is a possible alternative; it does not make the offered grid editor work.

   **Exact failure scenario:** REMARKS is a DataGridTemplateColumn, with an explicit TextBox editing template. The column-to-property resolver recognises only DEPTH and OVERRIDE REASON among template columns. REMARKS falls through to an empty property name. BeginningEdit passes that empty name to `BeginCellEdit`, which cancels the edit. The same resolver is used by Restore Cell, so its handler returns without action for the Remarks column.

   **Downstream proof:** `Modules/Drainage/ViewModels/PitScheduleViewModel.cs:133`–`:142` rejects an empty property name before the ordinary row permission checks. Its `:1054`–`:1059` sets the refusal text. The dialog's `:294`–`:310` uses the same failed lookup for Restore Cell. This is distinct from the intentional prohibition on editing Xref engineering rows.

   **DETERMINISTIC TEST — fixture:** A synthetic millimetre model drawing with one current-drawing scheduled CE pit P3 and an editable primary row. Give it a simple existing remark `CHECK A`. Source is Current drawing; grid is not read-only. No locked layer or Xref is involved.

   **Typed steps:** Type `PITSCHEDULE`; open **Rows** and select **Lid and remarks**. Double-click P3's **REMARKS** cell; type `CHECK B`, then Tab. Repeat on a new manual row. For the Restore check, use a second fixture with a persisted Remarks override on P3. Single-click its Remarks cell, then right-click it and choose **Restore Cell**.

   **Assertion:** Double-click must open the cell editor; the grid must retain `CHECK B` after Tab and reopening the schedule. Current code cancels before the TextBox is created, leaves `CHECK A` unchanged and shows “This cell cannot be edited.” Restore Cell must restore the linked note in the override fixture; the current handler returns before invoking its command. Read the footer and row value, not a view-model-only edit test.

   **Correction direction:** Resolve REMARKS to `PitScheduleRow.Remarks` and exercise the real WPF BeginningEdit and context-menu paths.

3. **S10-03 — MEDIUM — Clicking an Xref pit schedule row resolves its handle in the host drawing. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs:246`–`:265`.

   **What happens in AutoCAD:** A drafter clicks P3 in a schedule built from an attached drainage drawing. CE may zoom to and select an unrelated object in the host drawing, or say P3 is not in this drawing. It does not use the attached drawing's identity or insertion position to find P3.

   **Exact failure scenario:** External schedule rows contain the pit's original handle from the source DWG. The row-click and Enter-key routes send only `SourcePitHandle` and `PitNo` to the zoom service. That service resolves the handle against the active host database. Handles are local to a drawing, so an identical handle in a different DWG can identify a different object.

   **Downstream proof:** `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:812` stores `pit.EntityHandle`; `:818`–`:823` separately stores source drawing identity/path and `IsExternalSource=true`. The dialog discards those distinctions. `Modules/Drainage/Services/CeZoomHighlightService.cs:69`–`:85` resolves against MdiActiveDocument.Database; `:119`–`:124` selects and zooms the resolved host object. No Xref transform is supplied. This finding concerns navigation, not a proven engineering-data write.

   **DETERMINISTIC TEST — fixture:** Two synthetic millimetre DWGs with distinct CE drawing identities. Source `S10_SOURCE.dwg` contains scheduled pit P3 centred at World (0,0), with an inlet/outlet so its schedule row exists. Record its handle H. Host `S10_HOST.dwg` contains an unrelated visible entity with the same handle H, centred at World (20000,0). Require this handle collision as a checked fixture precondition. Attach S10_SOURCE once at (100000,0), scale 1, rotation 0. Use World UCS and a plan view; both layers are visible and unlocked.

   **Typed steps:** In S10_HOST type `PITSCHEDULE`; choose **Source > Drainage XREFs**, tick S10_SOURCE, and open **Rows**. Single-click its P3 row. Repeat using Enter on that selected row.

   **Assertion:** The selected/highlighted location must be source P3 at host World X=100000 mm, or the window must explicitly explain that this navigation is unavailable. It must not select the unrelated host entity at X=20000 mm. Capture the actual implied-selection database/handle and view centre immediately in the later tester's observer, plus the screen. Current code resolves host handle H. With a second fixture having no live host object at H, the current command-line assertion is `[CE] P3 is not in this drawing.`, despite P3 being visible in the attached drawing.

   **Correction direction:** Carry drawing identity and attachment ownership into navigation. Resolve an external row through its actual source and host transform, or give an explicit unavailable action rather than attempting a host-only handle lookup.

4. **S10-04 — MEDIUM — Idle time offered for restoration includes minutes already counted as work. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Core/JobTime/JobTimeTracker.cs:314`–`:340`, `:367`–`:374`, `:464`–`:471`; `Modules/Drainage/Core/JobTime/JobTimeSession.cs:202`–`:212`.

   **What happens in AutoCAD:** With the default five-minute idle threshold, a six-minute break first adds roughly five minutes to recorded work. On return, CE offers to count the whole six minutes. Clicking that offer adds six more: roughly eleven minutes are counted for a six-minute interval. Ignoring the offer still leaves the first five minutes counted.

   **Exact failure scenario:** Each timer tick increments TrackedSeconds until the idle threshold is reached. The idle transition sets IsPaused but does not remove the time since the last input. The detector measures idle duration from that last input, including the threshold interval. Return adds the full duration to IdleSeconds without subtracting any previously counted time; RestoreIdleTime then adds the full duration to both work counters. The displayed/billed value is TrackedSeconds, not TrackedSeconds minus IdleSeconds.

   **Downstream proof:** `Modules/Drainage/Services/JobTimeIdleDetector.cs:62`–`:72` captures last-input time as the start; `:78`–`:88` returns the full interval. `JobTimeSession.cs:223` uses TrackedSeconds directly. `Modules/Drainage/UI/JobTimerToast.xaml.cs:35`–`:37` offers “Click to count that time”; `:130`–`:137` invokes the full-duration restore callback. `Modules/Drainage/Services/JobTimeCsvLogger.cs:141`–`:142` writes the same billed figure and the separate idle figure. Default threshold is five minutes in `Modules/Drainage/Models/UserSettings.cs:265`.

   **DETERMINISTIC TEST — fixture:** Fresh synthetic `26-903\idle-check.dwg`, no resumed session, isolated timer settings with IdleTimeoutMinutes=5 and ShowStatusBarTimer=true. Keep AutoCAD responsive and on this one drawing. No other keyboard/mouse input on the PC during the idle interval. Use the later tester's passive clock/log observation, not repeated commands that reset activity.

   **Typed steps:** Type `_.REGEN`; note time and the current CE TIMER count. Leave all input untouched for six minutes. Move the mouse once and click the **CE Timer** toast “Click to count that time” within its six-second display. Keep input active briefly, then type `_.CLOSE` so the session is written. Repeat on a fresh fixture but let the toast disappear without clicking.

   **Assertion:** For the accept case, the time-log CSV's Duration must not exceed elapsed time between Session Start and Session End by more than five seconds. The current arithmetic adds about five extra minutes; the CE log should show the auto-pause, auto-resume and `JobTime: restored ...s of idle time` sequence. For the ignore case, Duration must exclude the six-minute interval it labels as idle; current code retains approximately the five-minute threshold portion. The CSV is under the test profile's configured data folder, `Time Logs\users\<user>_YYYY-MM.csv`. Capture Session ID to match the row. Allow only normal tick rounding, not a five-minute tolerance.

   **Correction direction:** Define one non-overlapping accounted interval. Either remove already-counted pre-pause seconds when the interval is classified idle, or offer restoration only for time actually excluded. Keep the pane, toast and CSV consistent.

---

1. **Coverage and limitations.** The manifest below is the exact 154-file requested slice, sorted by repository path for handoff. Each was fetched individually using `git show origin/claude/rel-20261022m:<path>` and read; relevant callers outside the slice were followed to verify the four findings. Reading alone does not certify native event order, layout appearance, Undo/REDO or performance.

2. **Candidates deliberately not counted.** The job timer's missing SAVEAS re-key path needs a native document-event trace before claiming the exact user-visible lifetime failure. Manual Pause also auto-resumes in the idle path, but no Civil UI/command caller was found. Neither is included in the severity counts. Full-drawing preview performance concerns were not called defects without measured evidence.

3. **Read manifest — all paths are relative to the source repository.**

1. **Read** `Modules/Drainage/Controls/AccessibleNames.cs`
2. **Read** `Modules/Drainage/Controls/CdPlanPreviewControl.cs`
3. **Read** `Modules/Drainage/Controls/CeAssistantControl.xaml`
4. **Read** `Modules/Drainage/Controls/CeAssistantControl.xaml.cs`
5. **Read** `Modules/Drainage/Controls/CeAssistantRequestWatchdog.cs`
6. **Read** `Modules/Drainage/Controls/CeAssistantStatusMapper.cs`
7. **Read** `Modules/Drainage/Controls/CeEditorShell.xaml`
8. **Read** `Modules/Drainage/Controls/CeEditorShell.xaml.cs`
9. **Read** `Modules/Drainage/Controls/CeFieldRow.xaml`
10. **Read** `Modules/Drainage/Controls/CeFieldRow.xaml.cs`
11. **Read** `Modules/Drainage/Controls/CePipePreviewControl.xaml`
12. **Read** `Modules/Drainage/Controls/CePipePreviewControl.xaml.cs`
13. **Read** `Modules/Drainage/Controls/CePitPreviewControl.xaml`
14. **Read** `Modules/Drainage/Controls/CePitPreviewControl.xaml.cs`
15. **Read** `Modules/Drainage/Controls/CeProvenanceChip.xaml`
16. **Read** `Modules/Drainage/Controls/CeProvenanceChip.xaml.cs`
17. **Read** `Modules/Drainage/Controls/CeSuggestionStrip.xaml`
18. **Read** `Modules/Drainage/Controls/CeSuggestionStrip.xaml.cs`
19. **Read** `Modules/Drainage/Controls/ChecksListControl.xaml`
20. **Read** `Modules/Drainage/Controls/ChecksListControl.xaml.cs`
21. **Read** `Modules/Drainage/Controls/DarkTitleBarBehavior.cs`
22. **Read** `Modules/Drainage/Controls/DesignImpactHubPage.xaml`
23. **Read** `Modules/Drainage/Controls/DesignImpactHubPage.xaml.cs`
24. **Read** `Modules/Drainage/Controls/DetentionRowPager.cs`
25. **Read** `Modules/Drainage/Controls/DrawingCheckPanelControl.xaml`
26. **Read** `Modules/Drainage/Controls/DrawingCheckPanelControl.xaml.cs`
27. **Read** `Modules/Drainage/Controls/InspectorPanelControl.xaml`
28. **Read** `Modules/Drainage/Controls/InspectorPanelControl.xaml.cs`
29. **Read** `Modules/Drainage/Controls/InspectorTextConverter.cs`
30. **Read** `Modules/Drainage/Controls/NetworkRedesignHubPage.xaml`
31. **Read** `Modules/Drainage/Controls/NetworkRedesignHubPage.xaml.cs`
32. **Read** `Modules/Drainage/Controls/PipePreviewControl.xaml`
33. **Read** `Modules/Drainage/Controls/PipePreviewControl.xaml.cs`
34. **Read** `Modules/Drainage/Controls/PitBlockPreviewControl.cs`
35. **Read** `Modules/Drainage/Controls/PitBlockPreviewRenderer.cs`
36. **Read** `Modules/Drainage/Controls/PitConnectionStubOverlay.cs`
37. **Read** `Modules/Drainage/Controls/PitCornerGuide.cs`
38. **Read** `Modules/Drainage/Controls/PitEntryOverlay.cs`
39. **Read** `Modules/Drainage/Controls/PitFootprintOverlay.cs`
40. **Read** `Modules/Drainage/Controls/PitPlanPreviewRenderer.cs`
41. **Read** `Modules/Drainage/Controls/PitPreviewRequest.cs`
42. **Read** `Modules/Drainage/Controls/PlanAreaRenderer.cs`
43. **Read** `Modules/Drainage/Controls/ScheduleCellTextConverter.cs`
44. **Read** `Modules/Drainage/Controls/SearchableComboBox.xaml`
45. **Read** `Modules/Drainage/Controls/SearchableComboBox.xaml.cs`
46. **Read** `Modules/Drainage/Controls/SelectAllBehavior.cs`
47. **Read** `Modules/Drainage/Controls/SlabSurfacePreviewControl.xaml`
48. **Read** `Modules/Drainage/Controls/SlabSurfacePreviewControl.xaml.cs`
49. **Read** `Modules/Drainage/Controls/StatusChip.xaml`
50. **Read** `Modules/Drainage/Controls/StatusChip.xaml.cs`
51. **Read** `Modules/Drainage/Core/JobTime/JobTimeSession.cs`
52. **Read** `Modules/Drainage/Core/JobTime/JobTimeStatusTextFormatter.cs`
53. **Read** `Modules/Drainage/Core/JobTime/JobTimeTracker.cs`
54. **Read** `Modules/Drainage/Core/Messages/CeMessage.cs`
55. **Read** `Modules/Drainage/Core/Messages/CeMessageCentre.cs`
56. **Read** `Modules/Drainage/Core/Messages/CeMessageFileStore.cs`
57. **Read** `Modules/Drainage/Core/Messages/CeMessageWorkQueue.cs`
58. **Read** `Modules/Drainage/Core/Messages/CeMessages.cs`
59. **Read** `Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml`
60. **Read** `Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml.cs`
61. **Read** `Modules/Drainage/Dialogs/BatchEditWorkshopDialog.xaml`
62. **Read** `Modules/Drainage/Dialogs/BatchEditWorkshopDialog.xaml.cs`
63. **Read** `Modules/Drainage/Dialogs/CalculationUnitTextConverter.cs`
64. **Read** `Modules/Drainage/Dialogs/CalculationsDialog.xaml`
65. **Read** `Modules/Drainage/Dialogs/CalculationsDialog.xaml.cs`
66. **Read** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml`
67. **Read** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml.cs`
68. **Read** `Modules/Drainage/Dialogs/CatchmentReportPickDialog.xaml`
69. **Read** `Modules/Drainage/Dialogs/CatchmentReportPickDialog.xaml.cs`
70. **Read** `Modules/Drainage/Dialogs/CdDialog.xaml`
71. **Read** `Modules/Drainage/Dialogs/CdDialog.xaml.cs`
72. **Read** `Modules/Drainage/Dialogs/CdHelpDialog.xaml`
73. **Read** `Modules/Drainage/Dialogs/CdHelpDialog.xaml.cs`
74. **Read** `Modules/Drainage/Dialogs/CdLinkDialog.xaml`
75. **Read** `Modules/Drainage/Dialogs/CdLinkDialog.xaml.cs`
76. **Read** `Modules/Drainage/Dialogs/CdRepairDialog.xaml`
77. **Read** `Modules/Drainage/Dialogs/CdRepairDialog.xaml.cs`
78. **Read** `Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml`
79. **Read** `Modules/Drainage/Dialogs/CheckDwgResultWindow.xaml.cs`
80. **Read** `Modules/Drainage/Dialogs/CivilDesignWindow.xaml`
81. **Read** `Modules/Drainage/Dialogs/CivilDesignWindow.xaml.cs`
82. **Read** `Modules/Drainage/Dialogs/CivilGeneralSettingsView.xaml`
83. **Read** `Modules/Drainage/Dialogs/CivilGeneralSettingsView.xaml.cs`
84. **Read** `Modules/Drainage/Dialogs/CivilHelpGuideView.xaml`
85. **Read** `Modules/Drainage/Dialogs/CivilHelpGuideView.xaml.cs`
86. **Read** `Modules/Drainage/Dialogs/CivilHubDialog.xaml`
87. **Read** `Modules/Drainage/Dialogs/CivilHubDialog.xaml.cs`
88. **Read** `Modules/Drainage/Dialogs/CivilImportWindow.xaml`
89. **Read** `Modules/Drainage/Dialogs/CivilImportWindow.xaml.cs`
90. **Read** `Modules/Drainage/Dialogs/CivilMoreOptions.cs`
91. **Read** `Modules/Drainage/Dialogs/CivilPreviewSelection.cs`
92. **Read** `Modules/Drainage/Dialogs/CivilSettingsView.xaml`
93. **Read** `Modules/Drainage/Dialogs/CivilSettingsView.xaml.cs`
94. **Read** `Modules/Drainage/Dialogs/CommandAliasEditorDialog.xaml`
95. **Read** `Modules/Drainage/Dialogs/CommandAliasEditorDialog.xaml.cs`
96. **Read** `Modules/Drainage/Dialogs/ContinueRisingMainDialog.xaml`
97. **Read** `Modules/Drainage/Dialogs/ContinueRisingMainDialog.xaml.cs`
98. **Read** `Modules/Drainage/Dialogs/CouncilSourceDialog.xaml`
99. **Read** `Modules/Drainage/Dialogs/CouncilSourceDialog.xaml.cs`
100. **Read** `Modules/Drainage/Dialogs/DesignCheckDashboardDialog.xaml`
101. **Read** `Modules/Drainage/Dialogs/DesignCheckDashboardDialog.xaml.cs`
102. **Read** `Modules/Drainage/Dialogs/DrawingStandardsResources.xaml`
103. **Read** `Modules/Drainage/Dialogs/EditPipePresentationLayout.cs`
104. **Read** `Modules/Drainage/Dialogs/EditorTextReviewWindow.cs`
105. **Read** `Modules/Drainage/Dialogs/FeedbackDialog.xaml`
106. **Read** `Modules/Drainage/Dialogs/FeedbackDialog.xaml.cs`
107. **Read** `Modules/Drainage/Dialogs/GradeMismatchDialog.xaml`
108. **Read** `Modules/Drainage/Dialogs/GradeMismatchDialog.xaml.cs`
109. **Read** `Modules/Drainage/Dialogs/HelpGuideWindow.xaml`
110. **Read** `Modules/Drainage/Dialogs/HelpGuideWindow.xaml.cs`
111. **Read** `Modules/Drainage/Dialogs/LabelStyleDialog.xaml`
112. **Read** `Modules/Drainage/Dialogs/LabelStyleDialog.xaml.cs`
113. **Read** `Modules/Drainage/Dialogs/LayerManagerDialog.xaml`
114. **Read** `Modules/Drainage/Dialogs/LayerManagerDialog.xaml.cs`
115. **Read** `Modules/Drainage/Dialogs/LinkedWordingPreviewConverter.cs`
116. **Read** `Modules/Drainage/Dialogs/LpdWindow.xaml`
117. **Read** `Modules/Drainage/Dialogs/LpdWindow.xaml.cs`
118. **Read** `Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml`
119. **Read** `Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.cs`
120. **Read** `Modules/Drainage/Dialogs/OsnapSettingsDialog.xaml`
121. **Read** `Modules/Drainage/Dialogs/OsnapSettingsDialog.xaml.cs`
122. **Read** `Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml`
123. **Read** `Modules/Drainage/Dialogs/PartsCatalogueDialog.xaml.cs`
124. **Read** `Modules/Drainage/Dialogs/PipeEditWorkshopDialog.xaml`
125. **Read** `Modules/Drainage/Dialogs/PipeEditWorkshopDialog.xaml.cs`
126. **Read** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs`
127. **Read** `Modules/Drainage/Dialogs/PipePreviewInteraction.cs`
128. **Read** `Modules/Drainage/Dialogs/PipeValidationWarningDialog.xaml`
129. **Read** `Modules/Drainage/Dialogs/PipeValidationWarningDialog.xaml.cs`
130. **Read** `Modules/Drainage/Dialogs/PipeWindowLayout.cs`
131. **Read** `Modules/Drainage/Dialogs/PitConnectionSelector.cs`
132. **Read** `Modules/Drainage/Dialogs/PitDetailsReview.cs`
133. **Read** `Modules/Drainage/Dialogs/PitDialog.xaml`
134. **Read** `Modules/Drainage/Dialogs/PitDialog.xaml.cs`
135. **Read** `Modules/Drainage/Dialogs/PitEditWorkshopDialog.xaml`
136. **Read** `Modules/Drainage/Dialogs/PitEditWorkshopDialog.xaml.cs`
137. **Read** `Modules/Drainage/Dialogs/PitOnePageLayout.cs`
138. **Read** `Modules/Drainage/Dialogs/PitReadinessPresentation.cs`
139. **Read** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml`
140. **Read** `Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs`
141. **Read** `Modules/Drainage/Dialogs/PitWindowLayout.cs`
142. **Read** `Modules/Drainage/Dialogs/ProjectReviewDraftingFixesDialog.xaml`
143. **Read** `Modules/Drainage/Dialogs/ProjectReviewDraftingFixesDialog.xaml.cs`
144. **Read** `Modules/Drainage/Dialogs/ProjectReviewProposalsDialog.xaml`
145. **Read** `Modules/Drainage/Dialogs/ProjectReviewProposalsDialog.xaml.cs`
146. **Read** `Modules/Drainage/Dialogs/PropagationPreviewDialog.xaml`
147. **Read** `Modules/Drainage/Dialogs/PropagationPreviewDialog.xaml.cs`
148. **Read** `Modules/Drainage/Dialogs/ProposalPreviewDialog.xaml`
149. **Read** `Modules/Drainage/Dialogs/ProposalPreviewDialog.xaml.cs`
150. **Read** `Modules/Drainage/Dialogs/RainfallWindow.xaml`
151. **Read** `Modules/Drainage/Dialogs/RainfallWindow.xaml.cs`
152. **Read** `Modules/Drainage/Dialogs/SettingsHistoryDialog.xaml`
153. **Read** `Modules/Drainage/Dialogs/SettingsHistoryDialog.xaml.cs`
154. **Read** `Modules/Drainage/Dialogs/SlabDialog.xaml`

---

1. **Summary.** Four code-proven faults: new drawings retain the previous job's record after a folder change; Remarks cells cannot enter edit mode; Xref schedule navigation uses host handles; idle-time restoration counts the threshold interval twice. Read all 154 requested files and traced relevant callers. Existing audit findings are excluded. Only this report was authored. No builds, tests or AutoCAD runs were performed; native acceptance remains pending.
