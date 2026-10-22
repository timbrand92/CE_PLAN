# CDS Settings rows — 22 October brief, completed 23 October 2026 (Melbourne)

1. **PR:** DRAFT [#1526](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1526), against `claude/rel-20261022m`.
2. **Head:** `cx/settings-rows-c60` at **`f1ab15898e1adef79277f5cfa9eb220497cb6a8d`**. Tested code: `a05fb8aef741bcf14c8f77068dfdb42577a3138e`; the final commit changes only the regression evidence. Base: `40ee0a36f7960145743954b39859eb6c3af92869`, also read from the installed Civil 3.0.70 DLL. Never master.
3. **Tests added:** **34**, all passing in the full Civil run. Final focused Settings: **109/109 net10**, **109/109 net48**. Separate final picture generation: **2/2**. All 16 pictures inspected.
4. **Full Civil net10 totals:** **19,188 total; 19,168 passed; 19 skipped; 1 failed**, the known `BackTest_GlenEira24115_Computed_WithinTolerance`. **Zero new failure names.** All three Release build lanes passed with **0 errors**. The exact existing **Settings fits 1920x1080 at 150% (dark)** test passed on both net10 and net48: tallest tab **673 px**, below **690 px** (base 670 px).
5. **Delivered:** six missing controls added; four requested existing controls retained once. Defaults unchanged. Saved and pushed, no deployment, no AutoCAD run by this task, no acceptance claimed. The existing layer colour/linetype check remains unconnected to the Checks list; the new row saves its existing choice and its tooltip says so.

---

## What Tim will see — existing keys, pages and unchanged defaults

1. **`layerChecks.wrongLayerRows` — Fixes > Drawing checks — Off.** “List CE objects on the wrong layer”. Existing wrong-layer findings can be included in Checks.
2. **`layerChecks.layerDiffersRows` — Fixes > Drawing checks — Off.** “List layers with a different colour or linetype”. Saves the existing choice. The model and pure rule exist, but no production caller reads this switch. The tooltip explains that the Checks list does not show these findings yet.
3. **`checks.showProgressWhenSlow` — Display > Drawing check progress — Off.** “Show progress while a drawing check is busy”. Uses the existing status-bar progress line and Esc cancellation.
4. **`checks.progressAfterSeconds` — Display > Drawing check progress — 1 second.** “Show progress after (seconds)”. Outside 0.5–30 seconds the existing rule uses 1 second. Finite figures save unchanged; blank, unreadable, NaN or infinite text warns and keeps the saved number. Nothing blocks Save (R-27).
5. **`checks.leaveOutRemovedPits` — Fixes > Drawing checks — Off.** “Leave out pits marked To be removed when checking fit and fall”. Existing pits are still checked.
6. **`linking.tidyLeaderOut` — Newer tools > Tidy labels — Off.** Existing row: “Tidy labels may move a label out with a leader”. `linking.tidyLeaderOut` is the exact existing key.
7. **`doubleClick.sourceEditWindow` — Newer tools > Double-click — On.** “Double-click a downpipe, inlet or overflow to open Edit”. For example DP1 opens its small Edit window. Off returns to the command-line questions; typed CDTAG keeps its questions either way.
8. **`doubleClick.opensEditWindow` — Newer tools > Double-click — Off.** Existing row: “Double-click also opens Edit for pit labels and the newer CE objects”. Kept separate from source Edit.
9. **`checks.allowIgnoreFinding` — Newer tools > Checks list — Off.** Existing row: “Allow a finding to be ignored, with your reason, name and date”. No behaviour change.
10. **`checks.checksCommandEnabled` — Newer tools > Checks list — Off.** Existing row: “Switch on the one Checks list”. Existing next-start ribbon behaviour is unchanged.

## How the window remains consistent

1. **Existing design reused:** CDS header, fixed footer, eight tabs, SettingsPageStyle, SettingsSectionStyle, SettingsLabelStyle, SettingsValueBoxStyle, SettingsTickTextStyle, GoldDividerStyle and the existing theme resources. Pipe/Pit/Batch editor reference and CivilEditorShellTheme read. No new colour, scrolling layout or expander.
2. **Existing machinery reused:** detached draft, change map and tab dots, search catalogue, history, candidate writer, Save, Cancel and Reset all tabs. Load and Reset read fresh instances of the existing model; UserSettings.cs and DoubleClickSettings.cs were not edited.
3. **Reset boundary:** the six new CDS-only values reset with Reset all tabs. Reset Civil on the separate Manager page leaves these unshown values alone. An untouched value changed elsewhere while CDS is open survives Save.
4. **Scope:** 23 changed files: four product UI/view-model files, two test files, REGRESSION_LOG and 16 images. No protected drawing command, drawing save/undo handler, placement service, C7 pipe object, Structural, Shared, Manager or installer source changed. Every prior regression entry retained: final diff against the base is 12 added lines, 0 removed.

## Verification and evidence

1. **Red first:** on the untouched release, the ten-row inventory gave 4 pass and exactly 6 missing-row failures. The four existing rows were not duplicated.
2. **New cases:** ten real bound controls/defaults; ten actual-control edit/save/exact-key/read-back/reopen/Reset cases; Cancel preserves bytes; seven unusual progress-delay cases; absent/null groups; Manager-page Reset; untouched concurrent settings; two real-page render cases. All 34 passed in the full run.
3. **Focused net10:** 109 passed, 0 failed, 0 skipped. This includes the existing 150% fit, strict binding inventory, search and lifecycle checks. One intermediate failure was the strict expected-name list lacking the six added controls; the list was extended, equality retained, and the entire focused group rerun green.
4. **Full net10 base:** 19,154 total, 19,133 passed, 19 skipped, 2 failed: Glen Eira and `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (blank PDF renderer output).
5. **Full net10 final:** 19,188 total, 19,168 passed, 19 skipped, 1 failed: Glen Eira only. The PDF case passed. Failure names compared directly from TRX: 0 new. Duration 6 min 30 s. Console-summary totals are used consistently with the train reports. TRX discovery additionally includes 28 not-run cases in both runs: base 19,182 / final 19,216 discovered; final 19,169 executed and 47 NotExecuted, of which the console reports 19 as skipped.
6. **Focused net48:** 109 passed, 0 failed, 0 skipped; includes all 34 new cases and the existing 150% fit. Full net48 and net8 tests were not run.
7. **Three foreground Release builds:** net48 0 errors / 242 warnings; net8.0-windows 0 errors / 210 warnings; net10.0-windows 0 errors / 208 warnings. Existing warnings left unchanged.
8. **Flags on every build/test:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`. C-57 refs: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`; `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`; `_AcadRefNet10` and `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`. AutoCAD 2027 on PATH for DLL resolution only. A zero-byte native ARX placeholder exists only in the worktree's ignored build output, as in C-57; it was never deployed.
9. **Local evidence:** `%TEMP%\ce-c60-evidence`: baseline-net10.trx, red-rows.trx, focused2-net10.trx, pictures-net10.trx, final-net10.trx, final-net48.trx; matching logs; three build logs; settings snapshots. Logs are outside both repositories. GitHub reported no hosted checks on this draft.
10. **Not tested:** AutoCAD behaviour, installed-window appearance, drawing Undo/Redo, full net48, net8 runtime, Manager/Structural/Installer suites. No install or acceptance claimed. The PR remains DRAFT as the specific brief requires.

## Real settings-file observation — no restoration by this task

1. **At 23 October 00:21:54 Melbourne, all four hashes matched the session-start values:** Civil CD_Settings `2d23331f1060`; the other three `622a246f7d3b`, `efe307c4fc74`, `2972ce70c514`.
2. **The Civil file did change temporarily:** it was observed at `acd64e79a33b`, then returned to `2d23331f1060`. Its timestamp changed. AutoCAD processes launched through Explorer were observed at 00:18:29 and 00:20:03. The writer was not proven; this task never launched AutoCAD and never edited/restored that file. The other three files retained both hash and timestamp.
3. **The new row tests write only fresh synthetic temporary settings files** using SettingsService.BeginTestScope and the existing production serializer/writer. No real settings contents were copied into the repository.

## Pictures inspected and committed

1. **Drafting:** `docs/image/V3_WINDOWS/settings-dark-1-drafting.png`; `docs/image/V3_WINDOWS/settings-light-1-drafting.png`.
2. **Pipes & Pits:** `docs/image/V3_WINDOWS/settings-dark-2-pipes-pits.png`; `docs/image/V3_WINDOWS/settings-light-2-pipes-pits.png`.
3. **Design:** `docs/image/V3_WINDOWS/settings-dark-3-design.png`; `docs/image/V3_WINDOWS/settings-light-3-design.png`.
4. **Survey:** `docs/image/V3_WINDOWS/settings-dark-4-survey.png`; `docs/image/V3_WINDOWS/settings-light-4-survey.png`.
5. **Display:** `docs/image/V3_WINDOWS/settings-dark-5-display.png`; `docs/image/V3_WINDOWS/settings-light-5-display.png`.
6. **Advanced:** `docs/image/V3_WINDOWS/settings-dark-6-advanced.png`; `docs/image/V3_WINDOWS/settings-light-6-advanced.png`.
7. **Newer tools:** `docs/image/V3_WINDOWS/settings-dark-7-newer tools.png`; `docs/image/V3_WINDOWS/settings-light-7-newer tools.png`.
8. **Fixes:** `docs/image/V3_WINDOWS/settings-dark-8-fixes.png`; `docs/image/V3_WINDOWS/settings-light-8-fixes.png`.

Real Settings source markup, real view model and themes, STA / RenderTargetBitmap, 1920x1080 scale 1. The capture wraps the untouched content so its outside margin and full footer are included. Every final image inspected; no clipped controls, overlap, scrolling layout or empty tab. Also inspected the changed three pages' 150% previews. These are off-screen WPF pictures, not AutoCAD screenshots.

## Coordination corrections, undo and remaining work

1. **First lock mistake:** the short red-first command continued after a failed lock acquisition and cleanup removed the shared lock. It overlapped another run for its one-second test duration. A coordination hold was restored; later commands stop on acquisition errors and clean up only a held lock.
2. **Queue mistake:** CreateNew could wait forever on an unlocked file another builder leaves behind. The private waiting shell alone was stopped before it ran any build/test. The replacement uses OpenOrCreate with exclusive sharing; all three builds and both final test lanes then ran in one held scope. No other process was stopped. This added avoidable waiting; it did not change code or live files.
3. **Undo:** revert the two commits on `cx/settings-rows-c60` (code `a05fb8ae`, evidence `f1ab1589`). Nothing installed. Worktree retained at `C:\ce-c60`.
4. **Parked existing limitation:** connect layer colour/linetype findings to the Checks list in a separate behaviour brief; the row and tooltip are complete here.
5. **Later robot check, after a separately authorised install:** on AutoCAD 2027 and 2024, open CDS at 1920x1080 and 150%; inspect Fixes, Display and Newer tools; toggle each choice, Save and reopen; Reset all tabs then Cancel must preserve the previous saved choices. No manual test request for Tim and no bug marked accepted.
6. **Tim's brief, 22 October:** “Your base is origin/claude/rel-20261022m”; “DEFAULTS DO NOT CHANGE”; “NEVER deploy”. Those specific instructions override the appended master-base and ready-for-review boilerplate.
