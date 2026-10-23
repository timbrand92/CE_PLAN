1. **ANSWER FIRST — 11 new findings: HIGH 2 / MEDIUM 8 / LOW 1.** All eleven are SURE, verified-by-reading at the release references below. None is an AutoCAD reproduction. Known findings are excluded from these counts.

2. **Most important — keeping a hand-entered pipe level can stop the whole cascade.** CE offers Keep, then refuses every proposed change if that choice makes one pipe flat or uphill. Its way out tells the drafter to change the level or choose Overwrite. R-27 requires a warning and a way to continue with the drafter's decision.

3. **Second — one sheet problem stops an entire drawing-set update.** The older Sheets panel refuses all updates when a scan skipped one drawing, the project has changed since scanning, or one shared title drawing is not ready. Unaffected sheets do not proceed.

4. **Third — two independent drawings both having P1 stops their combined Pit Schedule.** CE clears the proposed rows and demands renaming in a source drawing. The two pits already have separate drawing identities; the drafter should be able to keep both with their source names and a warning.

5. **Action for the release team.** Fix these refusals without inventing missing levels, overwriting hand-entered levels, changing protected source objects or discarding unresolved work. The tests below are for a later AI test lane. No testing is requested of Tim. Civil + Manager delivery remains 9 November; Manager administrator work remains parked.

---

1. **Source and authority.** Read Tim's RULES and ROUTER, CE_PLAN START_HERE and MASTER_PLAN, ENGINEERING_RULEBOOK R-27, BUG_CARPARK, AUDIT_C58_C60_S40_S41_2026-10-22 and the Civil, Structural and Gate CODEX_AUDIT reports dated 22 October. This report applies the brief's two exceptions: deleting spine identities and pushing an update after a failed build. It does not treat an engineering check as a third exception.

2. **Pinned releases.** After fetching origin, inspected Civil + Manager at `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, source versions 3.0.72 / 1.1.72. Structural is separately pinned at `origin/claude/rel-20261023s`, commit `e6d597c0fbc25e78118760887a70810e0890c9a9`, source version **1.0.122**. The latter is what the requested reference actually contains. Installed DLLs were not inspected. All Structural line numbers refer to that Structural commit, not the Structural folder on the Civil branch.

3. **Method and interpretation.** Used Git searches and Git object reads in detached review worktrees `C:\ce-cx\rd03` and `C:\ce-cx\rd03s`. Traced refusal conditions into commands or enabled-state bindings; a class containing the word Blocked was insufficient evidence. Findings count distinct refusal families, not every caller. SURE means the refusal follows from the stated inputs in source; native rendering and host behaviour remain untested. All proposed tests are NOT RUN.

4. **Test conventions.** Use isolated settings and synthetic metric drawings, with no client information. Civil fixtures use millimetre drawing units and levels in metres AHD unless stated otherwise. Preserve and restore test settings. Each test gives both the current failure oracle and the desired result. A disabled button is an observable refusal even when CE prints no command-line explanation.

**Numbered findings, ranked**

1. **RD03-01 — HIGH — keeping one manual level vetoes the whole cascade. SURE; verified-by-reading.**

   **For Tim:** CE can offer to keep your level, accept that answer, then refuse the whole run. For example, keeping P1 at RL 10.20 while raising downstream P2 to RL 10.30 stops every change instead of reporting the backfall and carrying on with your decision.

   **File:line:** `Modules/Drainage/Services/LinkService.RepairAudit.InvertPropagation.cs:587`, `:673`, `:686`; `Models/PropagationPlan.cs:167`; `ViewModels/PropagationPreviewViewModel.cs:198`; live call at `Commands/LinkCommands.cs:611` and `:626`.

   **Exact refusal:** `[CDPROPAGATE] Apply blocked - keeping the level typed by hand on P1 → P2 would leave the pipe flat or running backwards. Nothing was changed. Check that pipe's level, or run CDPROPAGATE and choose Overwrite when it asks about levels set by hand.` The shared writer also returns before any cascade writes when `plan.CanApply` is false, with `[CDPROPAGATE] Apply blocked - flat/negative grade or error in plan.` The preview independently disables Apply with `❌ 1 pipe(s) would have flat/negative grade — Apply blocked. Set an override grade on the affected pipe(s) to continue.` Downstream Edit Pipe cascade uses the same writer, with prefix `[CDEDIT-CASCADE]`.

   **Exact failure:** the first gate rejects proposed flat/negative rows; a second gate rejects the effective levels after Keep. Both stop the whole plan. This finding is the refusal policy, not an allegation that the old wrong-end calculation is still present.

   **DETERMINISTIC TEST:** fixture: a straight 20 m P1-to-P2 pipe, correct flow/end mapping, stored grade 1 in 100, old levels 10.20/10.00; only P1's end is manually pinned. Add an unpinned upstream branch to demonstrate the whole-run effect. Type `CDPROPAGATE`, pick P2, enter `10.30`, click Apply in the cascade preview, then type `Keep`. Assert the current command line contains the full refusal above and the unpinned branch also remains unchanged. Desired: show and record the backfall warning, retain P1 at 10.20, and allow the accepted work to proceed; no automatic Overwrite. Separately feed a plan with a finite flat row into the real preview model and assert Apply is available with a warning rather than disabled.

   **Smallest fix:** turn both grade vetoes into warnings, using the actual kept/written levels consistently in preview and application. Keep genuinely uncomputable values Unknown; do not manufacture a fall to make the warning disappear.

2. **RD03-02 — HIGH — one incomplete or stale sheet check vetoes every sheet update. SURE; verified-by-reading.**

   **For Tim:** a harmless edit saved after the last project scan can stop every title update. A missing title drawing on one sheet also stops otherwise usable sheets.

   **File:line:** `Modules/Structural/Services/CeSharedTitleMappingService.cs:114`, `:124`, `:132`, `:477`; `Services/CeSheetsSyncService.cs:115`, `:229`; `Services/CeSheetsManifestService.cs:98`; `UI/Palette/SheetsPanel.xaml.cs:183`; button at `UI/Palette/SheetsPanel.xaml:52`.

   **Exact refusal:** panel text `Sync blocked. Open CE Sheets Manager to review project health.`; window title `CE Sheets - Sync Blocked`. Reasons include `The project scan found root DWGs with zero sheet rows. Fix the drawings or rescan before syncing.`, `The project scan skipped one or more drawings. Rescan after resolving the DWG errors.`, `The manifest does not cover every root DWG or sheet token in the project.`, `The manifest contains duplicate sheet numbers.`, and `Project drawings changed after the last scan. Rescan to pick up new or removed layouts/DWGs.` An incompatible shared title gives `Shared title xref '<file>' is not sync-ready: <reason>`.

   **Exact failure:** both BuildSyncPreview and SyncManifest return for any blocker before iterating the usable sheets. The older palette's Preview drawing updates button still reaches SyncManifest. This report concerns its all-sheet refusal, not its already-audited preview behaviour.

   **DETERMINISTIC TEST:** fixture: a synthetic project with two managed sheets S01/S02, valid local title attribute bindings, a complete saved scan, and a pending Title change from `OLD` to `NEW` for S01. Save a harmless new line in S02 after the recorded scan time; change no layout, title field or identity. Open `CESHEETSCLASSIC`, close the manager window to expose the Sheets palette, then click `Preview drawing updates`. Current assertion: the exact stale-project reason above appears and S01's title attribute remains `OLD`. Desired: refresh/recheck the affected evidence, show the warning, and offer/apply the still-valid S01 update. Repeat with one skipped drawing recorded in LastScanDiagnostics and one good S01 binding: the good sheet must remain actionable. In a service fixture, assert both BuildSyncPreview and SyncManifest do not globally veto that good sheet.

   **Smallest fix:** scope check failures to affected drawings/fields, retain their pending changes, and continue with independently verified sheets. Refresh stale evidence before writing it; do not merely remove the guard and apply stale mappings blindly.

3. **RD03-03 — MEDIUM — a missing cover level stops both New Pit and Edit Pit. SURE; verified-by-reading.**

   **For Tim:** you cannot place a pit before its cover is known, or save an unrelated width change on a pit whose cover is blank. CE asks for a number rather than leaving the level Unknown.

   **File:line:** `Modules/Drainage/Rules/PitStartReadiness.cs:124`, `:145`; `ViewModels/PitViewModel.cs:377`, `:982`, `:1116`; `Dialogs/PitEditWorkshopDialog.xaml:331`.

   **Exact words:** `Enter the cover level.` The primary Place/Save button is disabled. The rule runs in both modes; IsEditMode changes the success wording, not this check.

   **DETERMINISTIC TEST:** fixture: P1, 600 x 600 mm grated pit, valid number/type, blank cover, no drawing locks; create the blank-cover record in the synthetic fixture rather than inserting a false zero. Type `PITEDIT`, pick P1, change width to 900 mm. Assert `Enter the cover level.` is shown and Save cannot execute. Desired: save 900 mm, keep cover Unknown and warn. Separately type `PIT`, supply all non-level inputs, clear Cover level, and assert placement is available with the same Unknown warning. After placement, the stored cover must still be blank, not 0.000.

   **Smallest fix:** make absent cover a non-blocking readiness warning; preserve blank through the writer and suppress numerical cover/depth claims dependent on it.

4. **RD03-04 — MEDIUM — unknown pipe inverts stop the ordinary pipe workflow. SURE; verified-by-reading.**

   **For Tim:** an ordinary pipe cannot start/save with a required end level blank. Simple Pipe Only bypasses this, but changes the operation; it is not a warning-and-continue route for the ordinary pipe.

   **File:line:** `Modules/Drainage/Rules/PipeStartReadiness.cs:152`, `:163`, `:166`, `:247`; `ViewModels/CdViewModel.cs:185`; `ViewModels/CdViewModel.Commands.cs:32`, `:39`.

   **Exact words:** `Enter the invert level for the first end.` or `Enter the invert level for the second end.` These disable the primary action when SimplePipeOnly is false. Work out other invert also requires its known end to be nonblank.

   **DETERMINISTIC TEST:** fixture: a modern CE pipe between uniquely identified P1/P2 with valid label ownership, diameter 300 mm/material UPVC, first-end level blank, second-end 10.00, both end inputs enabled, no fixed-outlet restriction. Open it with `CDEDIT`, keep Simple Pipe Only unticked and Work out other invert off, clear the first-end field if opening proposed a value, then change diameter to 375 mm. Assert the first-end sentence appears and Save is disabled. Desired: allow the diameter change, leave the first level Unknown, and make no calculated-grade claim. Repeat clearing only the second field and with Work out other invert enabled but its known level blank. Rule-level fixture must exercise these exact input flags, not an unrelated no-endpoints refusal.

   **Smallest fix:** warn for absent engineering levels, accept independent known fields, and defer computations requiring the missing end. Keep the missing value distinct from zero.

5. **RD03-05 — MEDIUM — duplicate display pit numbers in separate Xrefs stop the whole combined schedule. SURE; verified-by-reading.**

   **For Tim:** two independently drawn stages can each have P1. Selecting both for a schedule gives no rows, including the non-conflicting pits, and tells you to rename another drawing.

   **File:line:** `Modules/Drainage/Services/PitScheduleSourceSelectionService.cs:32`, `:76`; `ViewModels/PitScheduleViewModel.Data.cs:628`, `:636`, `:653`.

   **Exact words:** `XREF source conflict — schedule placement blocked`; `Cannot combine sources: Pit P1 appears in A and B. Rename it in a source drawing.` Here A/B are the fixture source display names; production substitutes the actual names.

   **Exact failure:** the duplicate check groups displayed pit numbers across different drawing GUIDs. LoadFromSelectedXrefs clears Rows and returns before appending any source rows. The service already has drawing-qualified identities; this is not deletion of a spine identity.

   **DETERMINISTIC TEST:** fixture: two independently created source drawings displayed as A/B, with different drawing GUIDs and unique spine IDs; A contains scheduled P1/P2 and B contains scheduled P1/P3. Attach both to a synthetic host. Type `PITSCHEDULE`, choose the Xref source option and select both. Assert the exact conflict headline and zero proposed rows. Desired: show all four pits, identify A/P1 separately from B/P1, warn and permit schedule output. Assert neither source pit is renamed and no IDs are removed.

   **Smallest fix:** retain drawing-qualified row identity and disambiguate duplicate display labels by source; change the all-row return to a visible warning.

6. **RD03-06 — MEDIUM — a drawing opened read-only also loses inspection tools. SURE; verified-by-reading.**

   **For Tim:** opening a drawing read-only to investigate a fault can prevent CE from inspecting it. This blocks reading, not just saving over the file.

   **File:line:** Civil `Modules/Drainage/Services/DrawingSafetyService.cs:70`, `Commands/DiagnosticsCommand.cs:26`, `Commands/DashboardCommands.cs:28`, `Commands/PartsCatalogueCommands.cs:33`; Structural `Modules/Structural/Services/DrawingSafetyService.cs:35`, `Commands/InspectCommands.cs:21`, `Commands/UtilityCommands.cs:204`.

   **Exact words:** `[CE] CDDIAG cannot run - drawing is read-only.`; `[CE] CDDASHBOARD cannot run - drawing is read-only.`; `[CE] CDPARTS cannot run - drawing is read-only.`; `[CE_STRUC] CE_INSPECT: the drawing is read-only. Save a copy you can edit first.`; `[CE_STRUC] CEEXPORTNOTES: the drawing is read-only. Save a copy you can edit first.`

   **Exact failure:** common preflight rejects Document.IsReadOnly before selection, inspection or opening the catalogue. Civil's ReadOnlyCommands list exempts REFEDIT only, not this check. CE_INSPECT's subsequent entity access is ForRead and its output is a separate report.

   **DETERMINISTIC TEST:** fixture: synthetic DWG with one LINE in a writable test folder, opened with AutoCAD's Open Read-Only option. Type `CE_INSPECT`: current assertion is its exact refusal before `Select entities to inspect:`. Desired: select the line and obtain a one-entity report while the DWG bytes remain unchanged. Repeat `CDPARTS`: the parts window should open. For CDDIAG/CDDASHBOARD, require detached reads rather than an initialisation path that saves drawing data. No command may silently overwrite the read-only original.

   **Smallest fix:** separate inspection/window preflight from drawing-write preflight. Permit reading and catalogue editing; use a writable chosen destination for exports and defer any actual DWG save decision to the appropriate operation.

7. **RD03-07 — MEDIUM — sheet space and REFEDIT unnecessarily stop office editors. SURE; verified-by-reading.**

   **For Tim:** while working on a layout, you cannot even open the parts catalogue or label-style editor. During a reference edit those two windows are also refused, although opening them does not require changing that reference.

   **File:line:** `Modules/Drainage/Services/DrawingSafetyService.cs:33`, `:51`, `:106`; `Commands/PartsCatalogueCommands.cs:33`; `Commands/LabelStyleCommands.cs:28`; related diagnostic callers at `Commands/DiagnosticsCommand.cs:26` and `Commands/DashboardCommands.cs:28`.

   **Exact words:** `[CE] CDPARTS cannot run in Paper Space. Please switch to the Model tab.` The same sentence substitutes CDLABELSTYLE, CDDIAG or CDDASHBOARD for those callers. During REFEDIT: `[CE] CDPARTS cannot run while a reference is being edited in place (REFEDIT). Finish or close it (REFCLOSE) first. Nothing was changed.` CDLABELSTYLE gets the same refusal; the diagnostic names are exempt from that particular REFEDIT check.

   **DETERMINISTIC TEST:** fixture: writable Civil DWG, Layout1, `PSPACE`, CVPORT 1. Type `CDPARTS`, then `CDLABELSTYLE`: assert both exact paper-space refusals and neither window opens. Desired: both editors open; closing them changes no drawing object. Second fixture: begin REFEDIT on a synthetic local block, repeat both commands, assert the reference-edit refusal. Desired: catalogue/style editing remains possible while any Apply to drawing action is separately routed and checked. Confirm no entities are added to the reference merely by opening/saving the catalogue.

   **Smallest fix:** move space/reference restrictions to the actual drawing operation; opening an office editor should not inherit entity-placement preflight.

8. **RD03-08 — MEDIUM — CE Blocks refuses a frozen output layer. SURE; verified-by-reading.**

   **For Tim:** you cannot stamp a block onto its intended frozen layer, even if you deliberately want it hidden until later. CE stops before asking for the insertion point.

   **File:line:** `Modules/Manager/Services/CeBlocksInsertService.cs:57`, `:155`, `:248`, `:255`; entry `Modules/Manager/Commands/PluginManagerCommands.cs:16`.

   **Exact words:** `Layer AUDIT-BLOCKS is locked or frozen. No block was placed.` The fixture has a frozen but **unlocked** layer, separating this from changing locked existing objects. The same check exists before the prompt and again during placement.

   **DETERMINISTIC TEST:** isolated CE Blocks catalogue with a valid synced source block named AUDIT-BLOCK, palette item Audit block, layer AUDIT-BLOCKS and scale 1. In the host create that layer, leave CLAYER 0, and freeze AUDIT-BLOCKS without locking it. Type `CEBLOCKS` and click Audit block. Current assertion: exact line above; zero new inserts. Desired: warning that the block will be hidden, then normal point/scale prompts; place at `0,0`, Esc, thaw the layer and assert exactly one AUDIT-BLOCK insert at the picked point. The layer must not be silently thawed.

   **Smallest fix:** separate frozen visibility from locked-object protection in both checks; warn and continue placement for the frozen-only case.

9. **RD03-09 — MEDIUM — one coloured hatch background vetoes changes to every selected hatch. SURE; verified-by-reading.**

   **For Tim:** select two hatches to change their preset: one is ordinary, the other has a background colour. CE refuses both. The ordinary hatch could have been changed while preserving and naming the difficult one.

   **File:line:** `Modules/Structural/Commands/HatchUpgradeCommands.cs:225`, `:229`, `:233`; `Commands/HatchPersistencePolicy.cs:139`; preset background requirements at `Commands/HatchCommands.cs:308`.

   **Exact words for one problematic hatch:** `*** [CEHATCHCHANGE] REFUSED: 1 selected patterned hatch(es) do not have a proven saved Background None state. AutoCAD 2027 cannot reliably clear an existing hatch background through the managed API. Nothing was changed. Recreate those hatches with the required CE preset, or remove the background in AutoCAD and confirm Properties shows None before retrying. ***`

   **Exact failure:** the count over the entire captured selection causes a return before ApplyPresetToExistingHatches. The refusal is broader than the hatch whose background cannot be cleared. The quoted sentence is CE's claim; this audit did not independently verify Autodesk internals.

   **DETERMINISTIC TEST:** fixture: two native patterned hatches H-A/H-B, each in its own closed rectangle; H-A has persisted Background None, H-B has persisted ACI 1. Use DIMSCALE 100/LTSCALE 1000, unlocked layers, and a target preset with Background None. Type `CEHATCHCHANGE`, select both, Enter, select `PT slab`, click `Apply preset`. Current assertion: exact refusal and neither hatch changes. Desired: H-A changes to ANSI31 on HATCH47 at scale 60, H-B remains intact and is named in a warning, and one U restores the accepted change. Repeat H-A alone as the control. Compare actual saved background properties, not just screen colour.

   **Smallest fix:** partition the selection by supported background operation and continue with the supported hatches; retain/name the others or offer a proven replacement route. Do not force the unproven background-clearing operation.

10. **RD03-10 — MEDIUM — one ticked blank field stops every valid batch change. SURE; verified-by-reading.**

   **For Tim:** tick Diameter and enter 375, then tick Material but leave it blank: CE disables Apply for the entire batch. It already promises blank does not erase anything; it could keep the old materials and apply the entered size.

   **File:line:** `Modules/Drainage/ViewModels/Shell/CeBatchField.cs:69`, `:259`; `ViewModels/Shell/CeBatchEditViewModel.cs:88`, `:274`, `:284`, `:313`; live pipe batch at `Commands/PipeEditCommand.Batch.cs:151`, field labels at `:618`, `:626`.

   **Exact words:** `Material — Pick a value first — leaving it blank never erases anything, so there is nothing to write.` The same shared rule blocks pit batches as well. Apply is disabled and its handler also returns when CanApply is false.

   **DETERMINISTIC TEST:** fixture: two fully readable 300 mm CE pipes with different materials, both on unlocked layers and with complete label ownership. Select both and type `CDEDIT`. Tick Diameter and enter `375`; tick the mixed Material field and leave its value empty. Assert the exact Material line and disabled Apply. Desired: warning naming the omitted Material field, both diameters become 375 mm, each original material remains unchanged. Repeat a pit batch with one valid ticked size change and one blank ticked field. One U must restore the applied values.

   **Smallest fix:** omit blank fields from the accepted batch plan, report them, and keep Apply available when any other effective change remains. Never translate a blank into deletion.

11. **RD03-11 — LOW — the last custom label style cannot be deleted. SURE; verified-by-reading.**

   **For Tim:** if the catalogue contains only an obsolete custom style, Delete style is disabled. You must create another style just to remove it. Label styles are not spine identities.

   **File:line:** `Modules/Drainage/ViewModels/LabelStyleDialogViewModel.cs:22`, `:181`, `:194`; `Dialogs/LabelStyleDialog.xaml:48`; existing fallback `Services/LabelStyleService.cs:55`.

   **Exact visible words:** button `Delete style`, disabled. There is normally no refusal explanation because CanDeleteStyle prevents the handler running. The handler's additional guard would set `Cannot delete the last style.` if invoked directly; that is not claimed as a normally visible message.

   **DETERMINISTIC TEST:** isolated `label_styles.json` with exactly one active custom entry named AUDIT-OLD. Open `CDLABELSTYLE` in writable model space and select AUDIT-OLD. Assert Delete style is disabled and AUDIT-OLD remains. Desired: deletion is available, explains that built-in wording will be used, and after Save/reopen AUDIT-OLD is absent. Reading CurrentStyle must still return valid built-in templates. Existing drawing labels must not change merely from deleting the catalogue entry.

   **Smallest fix:** permit removing the last custom entry and persist that removal while using the existing built-in fallback; handle empty selection and Save explicitly instead of indexing the now-empty list.

**Known findings — identifiers only, not counted again**

1. **BUG-134; BUG-324; BUG-331; BUG-464; BUG-529; BUG-614; BUG-619; BUG-701; BUG-773; BUG-791; BUG-813; BUG-823; BUG-824; BUG-843; BUG-953; BUG-1033.**

**What I did not check**

1. **No execution.** No build, unit test, AutoCAD, accoreconsole, installation, settings change, drawing change or sub-agent. No actual window or command outcome was observed. Tests above are specifications, not passing results.

2. **No exhaustive host claim.** This is a traced inventory of new refusal families found by searching commands, window readiness, batch gates, schedule/sheet gates and their services. It is not proof that every possible refusal or exception in the three suites has been enumerated. Missing documents/objects, malformed geometry, every locked/Xref writer and every recovery failure were not individually certified. I have not classified an ordinary user Cancel or deliberately disabled feature as a new R-27 fault.

3. **Unproven leads excluded.** I did not count the schedule difference engine's unavailable-source flag as a new live failure: its window snapshot builder marks selected sources Available, so that flag alone does not prove a reachable window refusal. I did not count a helper without a production caller, or presume an AutoCAD transaction failure can simply be ignored.

4. **Parked and previously audited.** No renewed Manager administrator/installer redesign review, no re-report of the prior release-gate audit, and no certification of the two allowed hard blocks. No review of installed binaries, all supported AutoCAD years, performance, native Undo/Redo or real office drawings. The reports named by the brief were used to remove repeats, not as proof that their fixes passed.

5. **Changes authorised by this hunt.** Only this findings file is authored in CE_PLAN. No code branch, source commit, PR, BUG_CARPARK, DESK_LOG or QUEUE edit. Detached review worktrees are temporary and are removed at completion. Other sessions' unsaved files are left alone.

**Summary — under 100 words**

1. **Result.** Eleven new extra refusals are verified by reading: two HIGH, eight MEDIUM and one LOW. The largest problems are whole-cascade rejection after Keep and whole-sheet-set rejection after one failed check. Other cases block unknown levels, combined schedules, inspection, office editors, frozen-layer blocks, mixed hatch changes, useful batch edits and deletion of a custom style. Continue supported work with explicit warnings, preserve unresolved values and user choices, and test the real command routes. Nothing was built, run, installed or accepted in AutoCAD during this hunt.
