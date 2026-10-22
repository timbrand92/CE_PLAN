# Structural Services S13 — independent findings, 23 October 2026 (Melbourne)

1. **ANSWER FIRST — HIGH 3 / MEDIUM 1 / LOW 0.** Four new faults are verified-by-reading. The most important: the older Sheets window's **Preview drawing updates** button immediately changes drawings, including saving closed drawings to disk. There is no preview decision before the write.

2. **What a drafter can meet.** Exchanging two sheet drawing names can point both sheet rows at one drawing and move the other into Superseded. Updating a title Xref can freeze layers belonging to a different Xref. Saving the sheet list can also make an unscanned drawing change appear up to date.

3. **Review status — partial full-file coverage, not a completed exhaustive sweep.** All 189 requested Git files were retrieved and indexed, largest first; detailed reading followed the paths below. I have not completed a full-body reading of all 65,986 source lines. Do not record this report as satisfying that part of the brief or as clearance of the remaining services.

4. **Nothing was tested or changed in AutoCAD.** These are code-proven paths, not native reproductions. The tests below are pending work for an AI tester on synthetic copies. No build, test, AutoCAD launch, installation, source edit, branch or sub-agent was used. Only this findings file is authored.

---

1. **Source and scope.** Code repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. Fetched origin; source references below are pinned to `origin/claude/rel-20261022s2`, commit `2c9a96942a024888a5ab520600f2d5025de83036`. The brief identifies it as Structural 1.0.121; installed binaries were not inspected. Supplementary UI/command reads establish that the service paths are reachable. No Civil or Manager finding is added.

2. **Earlier findings excluded.** Consulted `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_CIVIL_22OCT.md` and `CODEX_AUDIT_GATE_22OCT.md`. This report does not recount their CEMEMBER units, UCS, hidden-layer, fallback-scale, hatch repair, Settings recovery, command-outcome or Civil preview/Ignore findings. The Structural Sheets preview writer below is a different caller and drawing operation.

3. **Coverage accounting.** The requested set contains 112 files directly under Services, 74 under ConnectedDesign, two under Checklist and one under DrawingIntelligence: 189 files, 2,796,668 Git-blob bytes. Each was obtained with `git show` at the pinned ref. Declarations, document access, writes, erases, file operations and exception sites were indexed for triage. Complete detailed reads included `CeSheetsSyncService`, `CeSheetsIssueService`, `CeSheetsUpdateService`, `CeTitleBlockWriter`, `CeTitleBlockFieldMap`, `CeSheetsManifestService`, `CeSheetsReconciliationService` and `AsyncCommandService`; selected regions of the larger text, bracing, beam, mapping, structure and connected-host services were then inspected. Other indexed files have not all had their bodies read in full. Retrieval and indexing are expressly not claimed as full reading.

4. **How to interpret severity.** HIGH means an unrequested persistent drawing change or a wrong association capable of affecting drawing output. MEDIUM means the sheet-management status is materially misleading. Every counted finding is verified-by-reading; no suspected-only finding is counted. All deterministic tests below are **NOT RUN**. Use millimetre drawings and repeat on AutoCAD 2024/net48 and 2027/net10 when the test lane executes them.

## Numbered findings

1. **S13-01 — HIGH — “Preview drawing updates” writes and saves drawings immediately. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeSheetsUpdateService.cs:124`, `:135`; `Modules/Structural/Services/CeSheetsSyncService.cs:835`, `:838`, `:883`, `:886`, `:890`; `Modules/Structural/Services/CeTitleBlockWriter.cs:71`, `:116`, `:190`.

   **Reachable doorway:** `Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml:191` labels the button **Preview drawing updates**. Its handler at `CeSheetsManagerWindow.xaml.cs:505` calls `UpdateAllDrawings` at `:516` and only afterwards shows **CE Sheets - Update Complete**. `Modules/Structural/Commands/SheetsCommands.cs:39` exposes the window through `CESHEETSCLASSIC`; `UI/Palette/SheetsPanel.xaml.cs:94` constructs it. This does not claim that the normal `CESHEETS` window uses the same caption.

   **What happens in AutoCAD:** A drafter asks to see proposed changes and has already changed title-block properties and layout names before seeing the answer. A closed sheet drawing is saved to disk; closing the window cannot cancel it. For example, merely previewing revision B can replace revision A in a closed drawing.

   **Exact failure scenario:** A managed, writable closed DWG has custom property `REVISION=A`; its sheet row is edited to B. The handler applies the form, immediately calls the writer, assigns `db.SummaryInfo`, commits and calls `SaveAs`. There is no dry-run mode or confirmation between the button and that save. The classic handler also omits `outcome.Notice` from its displayed result: it finishes with **Use QSAVE to save the open drawing**, even though closed drawings have already been saved. That notice exists in the service but is only added to the result's notes, which this handler does not show.

   **Second live caller:** `UI/Palette/SheetsPanel.xaml:52` uses the same **Preview drawing updates** caption. `SheetsPanel.xaml.cs:183` directly calls `SyncManifest`, which writes attributes, register text and title-Xref state. It also does not call `BuildSyncPreview`. Its warning display is better, but occurs after the changes. These two preview-labelled entry points are one finding.

   **DETERMINISTIC TEST — fixture:** A synthetic project with two managed DWGs, A open and B closed, both saved in millimetres. Each has custom property `REVISION=A`; the manifest has complete scan diagnostics, correct paths and no shared-title mappings. Ensure the manifest is newer than the baseline DWGs. Record B's SHA-256 and read its `REVISION` before opening the window. Use no client or site information.

   **Typed/click steps:** Type `CESHEETSCLASSIC`. In the closed B row, change **Revision** to B and leave the cell to commit the edit. Click **Preview drawing updates** once. Record the resulting window text; dismiss it and close the manager without any further action. Open B and type `DWGPROPS`; inspect the Custom tab's `REVISION` value.

   **Assertion:** A preview must leave B's bytes and custom property at the baseline and offer a separate apply decision. Current source predicts B's property is B and its saved bytes have changed before the result window appears. Also assert that no layout tab changed during preview. Independent palette variant: use a title block with mapped `REV` attribute A and saved sheet revision B; close the manager and click the Sheets palette's identically named button. Assert the attribute stays A until an apply decision. The current palette handler writes B.

   **Correction direction:** Route preview-labelled actions through a read-only change plan; apply only after the drafter accepts that concrete plan. Preserve and display the distinction between an open drawing change and a closed drawing already saved to disk. Do not address this by adding a blanket hard block.

2. **S13-02 — HIGH — exchanging two drawing names collapses their sheet records and archives one of the renamed drawings. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeSheetsSyncService.cs:449`, `:455`, `:499`, `:512`, `:517`, `:524`, `:533`, `:696`, `:714`, `:718`, `:733`; follow-up reconciliation: `Modules/Structural/Services/CeSheetsReconciliationService.cs:133`, `:135`, `:159`.

   **What happens in AutoCAD:** After exchanging sheet numbers S01 and S02, both sheet rows can point at S01.dwg. The other drawing is moved into Superseded as supposedly unused. A later sheet operation can therefore open or issue the wrong drawing. The contents are moved, not deleted; this remains a serious wrong-drawing association.

   **Exact failure scenario:** The rename planner explicitly allows a target that is another source in the same plan. Both source files are first moved to temporary names. When finalising S01.dwg to S02.dwg, the code changes every matching sheet path and historical issue path from S01 to S02. When finalising S02.dwg to S01.dwg, it searches the already-mutated collection, so both rows and both historical paths now become S01. There is no snapshot of original row-to-file assignments.

   **Why the window's later reconciliation does not rescue this case:** `CeSheetsManagerWindow.xaml.cs:1124` calls `ApplyRenamePlan`, then calls reconciliation at `:1125`. Inside `ApplyRenamePlan`, `ArchiveUnusedProjectDrawings` has already run at `:533`. It sees no remaining reference to S02.dwg, recognises its sheet token and moves it into Superseded. Reconciliation searches root DWGs and cannot recover the now-archived S02 file. This is a successful two-file rename case; no file-lock race or injected exception is needed.

   **DETERMINISTIC TEST — fixture:** Synthetic project, blank project job-number/address fields so preferred names are exactly `S01.dwg` and `S02.dwg`. Each contains one paper layout named `SHEET` and distinct visible text: `ORIGINAL_ONE` in S01, `ORIGINAL_TWO` in S02. Both rows are managed and single-sheet drawings; row order is S01 then S02. Include one historical issue snapshot for each row, with distinct sheet IDs. Both files are closed; launch AutoCAD on a separate scratch DWG. Start with correct paths/numbers and a complete saved manifest so opening the manager does not need a rescan.

   **Typed/click steps:** Type `CESHEETSCLASSIC`; use **Browse...** to load the synthetic project if needed. Change the first row's **Sheet No** from S01 to S02 and the second from S02 to S01; leave each cell. Click **Preview Renames** and check the plan shows both exchanges. Click **Apply Renames**, then **Yes**. Record **CE Sheets - Rename Complete**, each grid **Drawing Path**, and the saved `.ce_struc/sheet_manager.json`. Open each surviving root DWG and inspect its marker text.

   **Assertion:** There must be two distinct root drawing paths: the first row points to S02.dwg containing `ORIGINAL_ONE`, the second to S01.dwg containing `ORIGINAL_TWO`. Historical issue snapshots retain their corresponding drawing identities. No successfully renamed file is archived. Current code instead makes both row paths S01 and archives S02. Assert these exact associations and the absence of an archive move, rather than only the reported rename count of two.

   **Correction direction:** Capture the original row and issue-snapshot membership for every source path before modifying any path. Apply the mapping to those captured objects once. Decide unused-file archiving from the validated final assignment set, and restore metadata as well as filenames if a rename fails.

3. **S13-03 — HIGH — title-Xref synchronisation can freeze another Xref's layers because its name contains the title name. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeSheetsSyncService.cs:2156`, `:2167`, `:2168`, `:2196`, `:2214`, `:2227`, `:2237`, `:2239`, `:2240`, `:2241`, `:2282`, `:2296`.

   **What happens in AutoCAD:** Updating the title block can hide unrelated referenced drawing content. A managed title Xref called TITLE also matches another Xref called TITLE_DETAIL. If the sheet is revision A, the latter's `REV_B` layer can be frozen even though that reference is not the managed title block.

   **Exact failure scenario:** The service builds prefixes from the managed title binding's block/file names, then scans the host's entire layer table. `IsTitleXrefLayerMatch` accepts equality **or either string containing the other**, for any ancestor segment before `|`. TITLE therefore matches TITLE_DETAIL. A leaf layer `REV_B` is considered manageable; revision A makes it invisible; `SetLayerFrozenState` writes `IsFrozen=true`. No comparison with the bound Xref's actual object identity occurs on this layer-selection path. The affected unrelated Xref can be in model space while the managed title is on a paper layout.

   **Live route and precondition:** The Sheets palette's **Preview drawing updates** button calls `SyncManifest`. The fixture must have a complete current scan and a compatible mapping for the actual title source, so this finding reaches layer sync rather than stopping at the existing preflight. It is independent of S13-01: even an explicitly accepted update should not change an unrelated Xref's visibility.

   **DETERMINISTIC TEST — fixture:** Millimetre host `S01.dwg`, managed sheet S01, discipline STR, current revision A. Attach `TITLE.dwg` as TITLE on the paper layout and give it a compatible saved title mapping. Attach `TITLE_DETAIL.dwg` as TITLE_DETAIL in model space; it is not a managed title binding. In TITLE_DETAIL put a visible line from (0,0) to (1000,0) on `REV_B`. Both `TITLE|REV_B` and `TITLE_DETAIL|REV_B` start thawed. Save all drawings, then the complete manifest. Keep the source Xrefs in an ignored Xrefs folder so they are not mistaken for root sheet drawings.

   **Typed/click steps:** Open the host. Type `CESHEETSCLASSIC`, close the manager, and use the underlying Sheets palette's **Preview drawing updates** button. Ensure no **Sync Blocked** message appears. Type `-LAYER`, `?`, `TITLE_DETAIL|REV_B`, Enter; also inspect the Freeze column in Layer Properties and the model-space line. Record the same properties for `TITLE|REV_B` as the intended-update control.

   **Assertion:** TITLE_DETAIL's layer remains thawed and its line remains visible; only the actual title binding's applicable layer changes. Current source freezes both revision-B layers. Repeat with a wholly different unrelated Xref name as the negative control; its layer must stay unchanged. Also repeat the exact-prefix case with nested references, recording the full layer name.

   **Correction direction:** Resolve layer ownership against the bound Xref and its actual reference hierarchy. Normalised substring similarity is not identity. Limit writes to the verified title reference's layer namespace.

4. **S13-04 — MEDIUM — saving the sheet list falsely advances the last drawing-scan time. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeSheetsManifestService.cs:36`, `:47`, `:61`, `:66`, `:90`, `:96`; caller `Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml.cs:486`, `:493`, `:497`, `:270`, `:285`.

   **What happens in AutoCAD:** A drafter can save changes to the sheet list and be told it matches the drawing files, although another drawing acquired a new layout after the last scan. The added sheet is absent from the list and can be omitted from the issue selection.

   **Exact failure scenario:** Scan completes at T0. A covered DWG is saved with a new layout at T1. While the manager still holds the T0 list, **Save sheet list** runs at T2. Every manifest save sets `LastScannedUtc=DateTime.UtcNow`, regardless of whether a scan took place. `IsStale` subsequently compares DWG modification time to T2, not T0. Its coverage check compares root paths and filename sheet tokens, not the layouts inside an unchanged filename. With unchanged root files/tokens and previously complete diagnostics, it returns false. The health panel prints **Manifest coverage matches the current project DWGs.** Reopening can also skip scanning because `LoadProject` consults that same stale check (`:67` to `:69`).

   **DETERMINISTIC TEST — fixture:** One synthetic managed root DWG `S01.dwg`, initially one paper layout named S01, complete saved scan and no Xrefs. Record its manifest `LastScannedUtc` as T0. Open `CESHEETSCLASSIC` in the first AutoCAD process and leave the manager open with its one-row list. Use a separate scratch drawing as that process's active DWG so S01.dwg is closed there.

   **Typed/click steps:** In a second test AutoCAD process, open S01.dwg. Type `-LAYOUT`, `New`, `S02`; `QSAVE`; close it, recording file time T1 greater than T0. Back in the first process's still-open manager, click **Save sheet list**, then inspect its **Summary** health text and the JSON scan time T2. Do not click either scan button. Close/reopen the manager as a second check.

   **Assertion:** Saving the list alone must retain T0 and report that the drawings changed after the last scan; it must not claim current coverage while omitting S02. Current code advances the scan time to T2 and clears that warning without reading S02. For a clock-independent service regression later, supply timestamps T0<T1<T2 and verify that ordinary Save cannot change the completed-scan timestamp. No such test was executed here.

   **Correction direction:** Keep the completed-scan timestamp separate from the manifest-save timestamp. Advance it only after the corresponding successful scan; retain per-drawing scan evidence when scans are partial. Warn and permit the drafter's next decision in accordance with R-27.

## Handoff and limits

1. **Next audit work.** Finish the full-body reading of the remaining indexed files, beginning with the unread portions of CeTextService, BracingService, CuiMenuGeneratorService, CeSheetsScannerService, DrawingAutoSaveService, BeamTextPlacementService and the ConnectedDesign host/commit family. The four findings above do not establish that those families are sound. Index-only coverage must not be promoted to a completed review.

2. **Next test work.** Execute the four stated synthetic AutoCAD scenarios; capture exact property values, sheet-to-file associations, layer states and window text. No source fix, passing test, installation or acceptance is claimed. Manager administrator work remains parked; the colleague release remains Civil + Manager on 9 November.

3. **Repository boundary.** Only this file may be staged and committed in CE_PLAN. Unrelated existing checkout changes belong to other sessions. No code-repository commit or PR is part of this hunt. Revert the report's own commit to undo this documentation change.

## Summary

1. **Summary.** Four new findings: three HIGH and one MEDIUM. Preview-labelled Sheets actions save drawings, exchanging drawing names can collapse sheet associations and archive the other file, title-Xref matching can freeze unrelated layers, and saving the sheet list can hide the need to rescan. All are verified-by-reading; native tests remain unrun. All 189 files were retrieved and indexed, but full-body reading remains incomplete. Only this report was authored; no code, drawing, installation or Settings was changed.
