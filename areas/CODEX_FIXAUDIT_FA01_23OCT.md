1. **ANSWER FIRST — three code fixes and one partial fix are in draft PR #1720; final validation is running.** Branch `cx4/fa01-inspection`, head `50fd12eb5ea89bba0b92dda154ca84c4c6f03c54`, against `claude/rel-20261023m`. [Draft PR #1720](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1720). Nothing installed or accepted in AutoCAD.

2. **RD03-01 — HIGH — skipped: protected cascade writer.** Both plan eligibility and effective Keep-level checks still veto the cascade in `LinkService.RepairAudit.InvertPropagation.cs`. `LinkService*` is protected. Route both vetoes to warnings using actual kept/written levels; keep manual levels and do not force Overwrite. No code change for this finding.

3. **RD03-02 — HIGH — skipped: Structural is protected in this Civil job.** `CeSharedTitleMappingService.BuildSyncBlockers` and both `CeSheetsSyncService` entry points still return before independently usable sheets. Route a scoped evidence refresh and per-drawing/field skips; retain unresolved pending changes. Removing the stale-evidence check alone would be unsafe.

4. **RD03-03 — MEDIUM — code fix in PR #1720, head `50fd12eb`.** Unknown pit cover now warns and permits placement or independent edits. Four added rule/real-model cases failed before and pass after; four render cases show New Pit/Edit Pit in both themes. Existing writers preserve blank cover strings and the formatter omits blank cover; no protected writer or pit view model was edited.

5. **RD03-04 — MEDIUM — skipped: protected pipe writer is required.** Readiness rejects blank inverts, and `PipeEditCommand.Update.cs` separately refuses a missing held end during Work out other invert. Readiness alone would still refuse Save. Route warning/continue together with deferred calculations and preservation of Unknown in the protected writer. No invented zero or fall.

6. **RD03-05 — MEDIUM — skipped for Tim's printed-schedule wording decision.** The duplicate check still clears all rows and returns. Option A: print source-qualified wording such as A / P1 and B / P1. Option B: separate source groups retaining each P1 label. Recommend A because every printed row stays identifiable. Keep drawing-qualified identities; do not rename source pits. No layout or wording format was guessed.

7. **RD03-06 — MEDIUM — partial code fix in PR #1720, head `50fd12eb`.** Civil office editors bypass drawing-write preflight, including the read-only refusal. Five shared route/policy cases and four parts-window renders cover this slice. CDDIAG/CDDASHBOARD still initialise ProjectData; the dashboard calls protected LinkService. Those need detached reads. Structural inspection remains protected/routed. This finding is not claimed fully corrected.

8. **RD03-07 — MEDIUM — office-editor code fix in PR #1720, head `50fd12eb`.** CDPARTS/CDLABELSTYLE open from layouts and REFEDIT without drawing initialisation. Apply to drawing retains the existing drawing checks, with plain-English Apply label styles wording. The five route/policy cases are shared with RD03-06; pictures include every office-editor tab and theme. Related diagnostic routes remain as stated in RD03-06.

9. **RD03-08 — MEDIUM — skipped: CE Blocks is protected.** `CeBlocksInsertService` still checks locked OR frozen before prompting and during insertion. Route a warning for frozen-only output without silently thawing it. Do not bypass protection of locked existing objects.

10. **RD03-09 — MEDIUM — skipped: Structural is protected.** `HatchUpgradeCommands.cs` is absent from the Civil base; the refusal was verified on the audit's separate `origin/claude/rel-20261023s` reference. CEHATCHCHANGE returns for the whole selection on an unsupported background clear. Route selection partitioning; keep/name unsupported hatches and do not force the unproven native operation.

11. **RD03-10 — MEDIUM — skipped: protected batch view model/caller.** `CeBatchEditViewModel` vetoes a ticked blank although BuildPlan already omits it. Route a warning naming omitted fields in the existing impact band while preserving an independent valid plan. This shared Edit Pipe/Edit Pit batch model and its protected pipe caller were not edited.

12. **RD03-11 — LOW — code fix in PR #1720, head `50fd12eb`.** The last custom style can be deleted, Save remains available without a selected entry, and an empty saved catalogue stays empty after reopening. Existing built-in wording remains available for new labels. Four added behaviour/persistence cases failed before and pass after; eight style-window renders cover both tabs/themes, with and without the last style. Catalogue deletion/Save does not update existing drawing labels.

13. **What Tim would see after later release-lane installation.** Blank Cover level warns and still permits placement or a pit width change. Parts/style editors open from the drawing contexts above. Deleting the last custom style leaves Save available and explains the built-in wording. No Settings key or default changed; these correct existing workflows.

14. **Validation so far.** Net48: 0 errors, 242 warnings. Net8: 0 errors, 210 warnings. Net10: 0 errors, 208 warnings. Focused verification: **157 passed / 0 failed / 0 skipped**, including **29 added cases**. Full corrected Civil suite: **FULL_SUITE_PENDING**. Unchanged-release baseline: **19,548 total / 19,526 passed / 22 skipped / 0 failed**. The older brief's eleven failures do not describe this measured release.

15. **What was NOT run.** AutoCAD, accoreconsole, native drawing writes, native Undo/Redo, native transform execution, installation/deployment, Structural/Manager/Installer suites and net48/net8 test suites. WPF pictures do not prove the native pit preview; it displays No preview for this pit without AutoCAD. No bug is marked accepted or closed. Later checks below are for the AI lane; no testing is requested of Tim.

---

1. **Pinned source and date.** Work done 24 October 2026, Melbourne time. Fetched origin before creating `C:\ce-cx\fa01` from `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Project files read as Civil 3.0.72 / Manager 1.1.72. The release base was rechecked unchanged before pushing. Installed binaries were not inspected; these versions describe source.

2. **Duplicate checks.** Ran `gh pr list --state all --search` for RD03 and every finding family, then precise DrawingSafetyService, LabelStyleDialogViewModel, PitScheduleSourceSelectionService, CeBatchEditViewModel and last style searches. Repeated exact RD03-03/07/11 searches before publication: none. BUG_CARPARK was read, never edited. Related #599 (wording), #538 (batch schedule cells), #731 (blank proposed cover) and #643 (grade warning) do not supply these fixes. No competing PR imported. Notion Inbox had no New items.

3. **Why the pit fix needs no protected edit.** `PitCommand.cs:842` and `PitEditCommand.cs:1805` store `vm.CoverLevel` unchanged. PitAnnotationTextFormatter omits blank cover; PitViewModel suppresses dependent depth. The initial cautious skip was superseded after tracing these paths. Only the unprotected readiness rule changed.

4. **Scope and resources.** Five Civil production files changed: DrawingSafetyService, PitStartReadiness, LabelStyleDialogViewModel, LabelStyleService and the Save binding in LabelStyleDialog.xaml. Reused PitEditWorkshopDialog/PitWindowLayout, CivilEditorShellTheme, DrawingStandardsResources and dark/light themes. No protected production file, CE_SHARED source, source identity or switch default changed. REGRESSION_LOG entry is at the top; previous entries are intact. Undo: revert `50fd12eb`.

5. **Before/after evidence.** `rd03-before.trx`: 9 added office/style cases failed on unchanged production code. `pit-before.trx`: 4 added rule/real-model cases failed before the readiness fix. `rd03-verified.trx`: final focused 157/157 pass. Added cases counted from TRX: 16 render, 4 pit cover, 5 office preflight and 4 style persistence. Seven existing cases now assert the corrected behaviour.

6. **Build/test method.** Every command foreground, Release, with `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Civil builds: net48, net8.0-windows and net10.0-windows. C-57 references: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`; `_AcadRefNet10` and `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref` (2027 despite its folder name). AutoCAD 2027 on PATH for test DLL loading; no AutoCAD process launched.

7. **Build-only native placeholder.** The first compile stopped on missing CE_TRANSFORM_2027.arx. The C-57 zero-byte placeholder was created only inside this worktree's ignored output. It resolved the copy error; it supplies no native functionality and was not committed or deployed.

8. **Evidence and pictures.** Raw logs/TRX remain local at `C:\ce-cx\fa01-evidence`; they are not pushed. Sixteen inspected real WPF captures are committed under `docs/image/V3_WINDOWS/rd03-*.png`, individually listed in PR #1720. Local copies: `C:\ce-cx\fa01-evidence\images`. STA/RenderTargetBitmap, 1920 x 1080, 96 DPI, no stretching. Final bounds checks visit laid-out buttons; catalogue caches are restored after each rendering case.

9. **Exact later AI AutoCAD check — setup.** Use synthetic millimetre drawings and a separate test Windows account with its own settings/catalogues, after release-lane installation. Prepare a grated 600 x 600 mm pit with blank cover and one isolated custom style AUDIT-OLD. Record screenshots and drawing hashes. This is a future acceptance specification; this task does not install or start AutoCAD.

10. **Read-only office catalogues.** Open the synthetic DWG using Open Read-Only. Type CDPARTS and close without Save; type CDLABELSTYLE and close without Save. Both must open. Original DWG bytes stay unchanged. CDDIAG/CDDASHBOARD/Structural inspection are excluded because their fixes are routed.

11. **Layout and reference edit.** Open a writable copy, activate Layout1 and PSPACE (CVPORT 1), then open/save/close each office editor. Repeat during REFEDIT of a synthetic local block. Catalogue saving stays available; opening/saving adds no drawing object. Apply to drawing retains its current restriction and explains that labels were not changed. Finish REFCLOSE without adding CE objects to the reference.

12. **Last style persistence.** With only AUDIT-OLD in the isolated catalogue, open CDLABELSTYLE. Delete style, Save, close and reopen: AUDIT-OLD stays absent, Save is available, and Add style works. Existing drawing labels stay unchanged by these catalogue actions. New labels use valid built-in wording when no custom style remains.

13. **Unknown cover and width.** Type PIT, choose a 600 x 600 mm grated pit, leave Cover level blank and place it. Expect the warning with placement available. Type PITEDIT, pick it, change width to 900 mm and Save. Expect blank Cover level, no 0.000 cover or invented depth, and the width retained.

14. **Undo, REDO and reopening.** Press U once: width returns to 600 mm; REDO restores 900 mm. Repeat U, open/close CDPARTS and CDLABELSTYLE without saving a catalogue, then REDO: width still returns to 900 mm. Save/reopen; PITEDIT must still show blank Cover level and 900 mm width. Record the native result before any acceptance claim.

15. **Hygiene and shared-index incident.** Original code-checkout changes belonged to other sessions and were not taken over or committed. In CE_PLAN, report commit `ef5c4095` also picked up another session's staged `areas/V3_RECOUNT_2026-10-24.md`; its bytes were preserved and not authored/edited here. No history rewrite. Later report commits use `git commit --only` with this exact report path. No BUG_CARPARK, DESK_LOG or QUEUE edit. Source push passed the global leak scan.

16. **Storage and cleanup.** Free space checked before every build/test: initial 26.38 GB, latest check 22.59 GB, always above 14 GB. Tests use isolated settings/logs. Settings-hash comparison and removal of this session's worktree are pending final validation. No other worktree will be removed; evidence/images remain outside it.

17. **Summary.** Three findings have code fixes and the office-editor part of RD03-06 is corrected in draft PR #1720. Seven findings are routed for protected code or a printed-schedule wording decision. Twenty-nine cases were added; 157 focused checks pass. All three builds have zero errors; full corrected Civil totals remain pending. Nothing installed or accepted in AutoCAD.
