# Opus pre-review Q: PR #1880 (B-059, BUG-1240, the Inspector reads the saved drawing record), head 3f7ed338, Fri 30 Oct 2026 21:27 (Melbourne)

Independent read-only review. Brief: `C:\CE_PLAN\desk_jobs\REVIEW_BRIEF_1880_BUG1240.txt`. No build, no test, no AutoCAD, no repository file changed, no settings file read. Only read-only `git fetch`, `git show`, `git diff`, `gh pr view` and `git merge-tree` trial merges.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, train C-79 (FULL).** C-78 is already finalised on this base, so the next train is C-79. The fix only reads; it writes nothing to the drawing.
2. **What you will see:** reopen a drawing (or Save As), pick pit P2, look at the CE Inspector before typing any CE command. Before: "This pit is not in CE's recorded project data yet. Values below are Unknown" until CDSYNC. After: Number P2, type, size, cover level, invert level and connections straight away. With nothing picked, the Inspector's Pits and Pipes counts now show too.
3. **Switch:** `linking.inspectorReadsSavedRecordWhenNotLoaded`, ON, documented "Default: on." Set it to false and the Inspector goes back to exactly what it does today. It is settings file only, with no tick box on the Settings page (the page is at its height limit).
4. **Two rare cases can show slightly old values, not wrong ones from another drawing.** (a) With two drawings open, if CE could not save a change into a drawing before you switched away, the Inspector shows that drawing's last saved values until a CE command runs there. (b) An Undo that goes back past a drawing's very first CE save can keep CE's list instead of clearing it. Both already apply to CDCHECK since #1866, which uses the same reader. Neither blocks this fix. Both should get a small follow-up card.
5. **Not proven:** I built nothing and ran nothing. The author reports 444 of 444 focused tests and 21,542 of 21,576 in the full Civil suite, with 2 failures he did not compare against the base. Nobody has opened it in AutoCAD, and the speed on a big drawing has not been measured.
6. **Robot test after the train is built:** N39_inspector_reopen, with switch-off control C39, plus one extra leg for a drawing saved by an older CE (steps in DETAIL item 7).

---

## DETAIL

### 1. Before and after, the switch, Settings page

1. **Where:** the CE Inspector palette, in its default workshop layout. Code: `Modules/Drainage/Services/InspectorPaletteService.cs`, `RefreshCivilProperties`, lines 904 to 1030 at 3f7ed338.
2. **Before:** the list came only from CE's memory (`ProjectDataService.TryPeekCurrent`, `InspectorPaletteService.cs:921`). CE's memory list is attached only when a CE command runs. In a freshly opened or Save-As drawing, `data` was empty, so a pit pick gave the subtitle "This pit is not in CE's recorded project data yet. Values below are Unknown." (`ViewModels/InspectorViewModel.cs:159-160`). For a pipe the text is the same (`:128-129`). With nothing picked, it read "Drawing records are not loaded" (`InspectorPaletteService.cs:948`).
3. **After:** `InspectorPaletteService.cs:926-937`. When the rule says StoredRecord, the Inspector reads the list saved in the drawing through `ProjectDataService.TryReadProjectWithoutChanging`. The subtitle becomes the existing "Recorded values — block and label values may differ" (`InspectorViewModel.cs:161`). That covers pits and pipes, connections and junction rows (`:999-1003`), and the Pits and Pipes counts on the empty-pick summary (`:945-946`).
4. **"Open existing" unchanged:** it is still decided from CE's memory list only, before the new read (`InspectorPaletteService.cs:923-924`). The Edit button still hands over to CDEDIT, which loads the record its own normal way (`:1222-1232`). Nothing acts on the copy the Inspector read.
5. **Switch:** `Models/UserSettings.cs:692-700`, in the `linking` group, key `inspectorReadsSavedRecordWhenNotLoaded`, `= true`, with "Default: on." at line 697. A missing file or group reads ON (`Rules/InspectorProjectSourceRule.cs:27`).
6. **What OFF restores:** `InspectorProjectSourceRule.Choose` (`:29-34`) returns Live or None, exactly as today, and ignores the closed-drawing flag. So no read happens. I confirmed this by reading the code, not by running it.
7. **Settings page: FILE-ONLY.** The key appears nowhere in `.xaml` or `ViewModels/` (I searched the whole tree at 3f7ed338). This follows the neighbouring `linking` fix switches (`reopenedDrawingLoadsItsOwnRecord`, `inspectorPickWaitsAfterUndo`), which also have no row.

### 2. Where the saved list comes from, edge cases, stale values, Rule 1

1. **Source: the drawing's own record, not a file in %APPDATA%.** `TryReadProjectWithoutChanging` (`Services/ProjectDataService.cs:184-201`) uses the live list when it belongs to this drawing. Otherwise it calls `TryLoadFromDrawingLight` (`Services/ProjectDataService.Persistence.cs:1038-1110`). That function opens the drawing's own named dictionary (CE's record stored inside the DWG) in an open-close read, ForRead only. It reads the text of the record and turns it back into the pit and pipe list.
2. **Record missing:** the read succeeds with no list. `TryReadProjectWithoutChanging` hands back an empty project (`ProjectDataService.cs:199`). So the pick finds no pit and shows the same honest "not in CE's recorded project data yet" text as today.
3. **Record unreadable** (written by a newer CE, or damaged): the read fails. `data` stays empty and the Inspector shows Unknown, as today. Two log lines are written on every pick: an Error "Failed to load project data from DWG" (`Persistence.cs:1107`) and the new `[Inspector]` warning (`InspectorPaletteService.cs:936`). That is log noise only. Unknown stays Unknown (rule 12.2).
4. **Record from an older CE:** this is the light read. It runs `NormalizeProjectData` but not CE's full load path. Fields an older record never carried read blank, so they show Unknown, not a made-up figure. Not proven on a real older drawing.
5. **Record from a different drawing:**
   1. **SAVEAS, or a DWG file copied in Explorer:** the record travels inside the DWG and its pit references (handles) still match the objects. The values are correct for that copy. The record's stored drawing name may still be the old file name, but the Inspector does not use it.
   2. **Copy-paste or INSERT from another drawing:** the pasted pits get new references, so they are not in this drawing's record and show "not in CE's recorded project data yet". That is correct. Whether AutoCAD ever brings the source drawing's dictionary across is Autodesk's own behaviour and I have not verified it (rule 12.5).
   3. **Xref and REFEDIT:** the Inspector reads only the host drawing's record (`_civilDatabase = doc.Database`, `InspectorPaletteService.cs:910`). An object picked inside an xref is not a host pit, so nothing comes from the xref's record.
   4. **Two drawings open:** today, drawing B showed Unknown while CE's memory held drawing A. Now B shows B's own saved list. It never shows A's values, because `TryPeekCurrent` compares the actual drawing, not the file name (`LinkService.PipeAttachmentGrip.cs:485-499`).
6. **Could it show a STALE value as if current? Yes, in two rare cases (KEEP-WITH-NOTE):**
   1. **(a) A save waiting in memory.** CE can hold a change for drawing A in memory when it could not write it into A before you switched to drawing B and ran a CE command there. Code: `ParkedRecordSaves`, `Services/ProjectDataService.KeptRecords.cs:13-75`, `KeepUnsavedRecordBeforeSwitchLocked` `:118`. Back in A, the Inspector reads A's saved list, which is older than the change waiting in memory. It shows the older values with the normal "Recorded values" subtitle and no hint. Today the same case showed Unknown. `TryReadProjectWithoutChanging` never looks at the waiting change, so CDCHECK (#1866) already has the same gap. **Follow-up:** have `TryReadProjectWithoutChanging` use the waiting change for this drawing first (`ParkedRecordSaves.TryPeek`).
   2. **(b) Values changed by plain AutoCAD commands** after CE last saved (ATTEDIT on a pit, for example). The saved list does not know about them until CDSYNC. But the live list behaves the same way, and the existing subtitle already warns "block and label values may differ". This is not new.
7. **A memory side effect, not a drawing write (note):** each successful read calls `NoteEmbeddedRecord(db)` (`Persistence.cs:1101`, `:1112-1118`). It keeps one global pointer that says which drawing last had a record read from it. That pointer decides what CE does after an Undo that removes the record (`WasRecordEmbeddedIn`, `:1125-1135`, used at `:1164` and `:1220`; `OutsideCommandUndoPolicy.DecideHistoryReload`, `Services/OutsideCommandUndoPolicy.cs:250-263`). The case: with A live, picking in drawing B moves the pointer to B. An Undo in A then goes back past A's very first CE save. CE now keeps its memory list instead of clearing it to match the drawing. This is narrow, and it already happens with CDCHECK, CDFIXPIPEENDS, CHECKIGNORE and the Checks list (same reader). But the Inspector reads far more often: every pick and every drawing switch. **Follow-up:** the Inspector read should not move that pointer (for example, a read variant without `NoteEmbeddedRecord`). Not a blocker: it touches no drawing, and the result is "keep", not "lose".
8. **Rule 1 (one code path per behaviour):** **same reader reused.** `TryReadProjectWithoutChanging` and `IsRecordDrawingClosed` are exactly what #1866 uses (`Services/Checks/ChecksResultReader.cs:91-100`). The #1866 files are unchanged in this PR: the diff touches only `UserSettings.cs`, `InspectorPaletteService.cs`, the new rule file, the new test file and `REGRESSION_LOG.md`. **But the decision rule is a near copy:** `Rules/InspectorProjectSourceRule.cs:29-34` repeats `Rules/CdCheckProjectSourceRule.cs:28-35` line for line, minus the Snapshot row. That is acceptable because each has its own switch, but it is two copies of one rule. **Follow-up:** one shared `Choose` with the switch passed in.
9. **Small text faults (no behaviour):**
   1. `InspectorProjectSourceRule.cs:20` names the switch `inspector.readsSavedRecordWhenNotLoaded`. The real key is `linking.inspectorReadsSavedRecordWhenNotLoaded`.
   2. `InspectorPaletteService.cs:902-903` still says the passive path reads "only ... already-loaded records". That comment is now out of date.
   3. The author's report says the base is "the C-78 line, Civil 3.0.85 train". I did not check the version number in the base.

### 3. CDRULES, CDCHECK, council, fingerprint, writes

1. **CDRULES, CDCHECK, council: unchanged.** No file of theirs is in the diff (`git diff --stat 91963bd0 3f7ed338`: 5 files, 203 lines added, 0 removed).
2. **Fingerprint and saved-run Stale: no effect.** The CDRULES criteria fingerprint is built from the office design standards and the council values (`Rules/RulebookValues.cs:236`, `:408-419`), not from the `linking` settings group. So the new key cannot turn a saved run Stale.
3. **Writes to the drawing: none.** The new code calls only `TryReadProjectWithoutChanging`. That is a clone of the live list, or an open-close read of the dictionary, ForRead, followed by `tr.Commit()` on an open-close read (`Persistence.cs:1056-1099`). It does not bind, sync, save or mark the drawing active. The author's guard test checks that `RefreshCivilProperties` holds no `SetDrawingPath(`, `EnsureDrawingDataCurrent(`, `SaveProjectData(`, `FlushPendingSave(` or `StartTransaction(` (`Bug1240InspectorReadsSavedRecordTests.cs:111-123`). The older guard `C2CivilPropertiesTests.cs:208-215` also forbids `ForWrite` and `ProjectDataService.Current` in that path. The only memory-side effect is item 2.7.
4. **REDO:** the read is the same open-close kind that CE measured to keep REDO (BUG-192 v2, `Persistence.cs:1025-1029`). Pick refreshes in the REDO window are still held back by the existing switch (`InspectorPaletteService.cs:713-728`). Not proven in AutoCAD for this path.

### 4. Native AutoCAD protection

1. **Reading only.** Nothing changes a layer, an Xref or a REFEDIT session. No unlock, detach or explode, and no regen, view or system-variable change. A locked layer or a drawing open read-only is read like any other. Confirmed from the code.

### 5. Test isolation

1. **The new tests touch no files except the repository's own source** (read-only `File.ReadAllText` of two `.cs` files) and parse JSON text in memory (`SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`, `Services/SettingsService.cs:771-830`, no disk). Nothing writes to %APPDATA%.
2. **The author's runner, `C:\ce-fx\p2_run.ps1`:** it sets TEMP, TMP and `CE_LOG_DIR_OVERRIDE` to a throw-away folder (`:13`). Per `Bug375NoLogOverrideIntoAutoCadTests.cs:12`, that variable also moves the Civil settings file. **It does NOT redirect APPDATA itself.** So the full 21,576-test run relied on each older test honouring that variable. That is the standing arrangement for every lane, not something this PR made worse. I did not check that every test in the suite honours it.

### 6. Clashes (read-only `git merge-tree`)

1. **Into `claude/rel-20261102a` (91963bd0): clean.** #1880 is exactly one commit on top of it, and GitHub reports MERGEABLE.
2. **With every listed PR (#1857, #1868, #1871 to #1879, #1881): only the usual `REGRESSION_LOG.md` line 1 clash.** Every PR adds its entry at the top. Keep both entries.
3. **Other conflicts the trial merge showed are NOT from #1880.** They come from those PRs being on older bases:
   1. `UserSettings.cs` near line 1468 with #1868 (BUG-1091, base `claude/gb01-slice1-falls`).
   2. `UserSettings.cs` near line 3042 with #1874 (BUG-1096, base `rel-20261026z`).
   3. `CouncilSweepParityTests.cs` and `KingstonStormFrequencyTests.cs` with #1872.
4. **Where #1880 sits:** its `UserSettings.cs` change is at lines 689-700, and it auto-merges with all of them. No open PR touches `InspectorPaletteService.cs`. #1857 touches `ProjectDataService.cs` only with the same #1866 lines already in the base, so there is no conflict.

### 7. NOT proven, and the robot scenario

1. **Not proven:**
   1. Nothing was driven in AutoCAD or accoreconsole.
   2. No timing: the read happens on every Inspector refresh, including empty picks and drawing switches, until a CE command runs. The whole saved list is read each time, with no caching. A big drawing could feel slow.
   3. The two full-suite failures (`FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision`, `RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure`) were not compared against the base. The author says the B-055 report lists the same names.
   4. net48 tests were not run, only compiled.
   5. The legacy (non-workshop) Inspector path is unchanged and not tested.
2. **Robot case N39_inspector_reopen (switch true):**
   1. Open the DRV1_B1 copy.
   2. Close it without saving.
   3. Reopen it (`reopen-copy -Force`).
   4. With no CE command typed, select pit P2.
   5. Expect: the Number row reads P2, the cover level is shown, and the header does not contain "not in CE's recorded project data yet".
   6. Expect: the CE log has no `Project data switched to` line before the pick.
3. **Extra legs for the same case:**
   1. **Save As:** SAVEAS the drawing to a new name, then pick P2. Expect the same as leg 2.
   2. **Two drawings:** open a second drawing and run CDSYNC there, switch back, pick P2. Expect P2's values from its own drawing, not the other drawing's.
   3. **Empty pick:** press Escape. Expect the Pits and Pipes counts to show numbers.
4. **Control C39 (switch false):** run the same steps. Expect "This pit is not in CE's recorded project data yet". This case must FAIL the N39 checks.
5. **Older-CE drawing leg:** open a copy of a drawing last saved by an older CE (any 3.0.6x job copy with a CE record), with no CE command, and pick a pit. Expect values or honest Unknowns, never a crash. The CE log must not show "Failed to load project data from DWG". If it does, the record could not be read and the Inspector must show Unknown.
6. **Not robot-checkable (needs a Codex look):** that the palette shows the rows correctly on screen. The values themselves are a palette read the robot already uses for other Inspector cases.

### 8. Verdict

**KEEP-WITH-NOTE, train C-79 (FULL).**

1. **Notes to carry into the merge:**
   1. Fix the wrong switch name in the comment at `InspectorProjectSourceRule.cs:20`.
   2. Update the out-of-date comment at `InspectorPaletteService.cs:902-903`.
2. **Follow-up cards** (shared reader, same exposure as #1866 CDCHECK):
   1. Use a waiting unsaved change before the drawing's saved copy (2.6a).
   2. The Inspector read should not move the after-Undo pointer (2.7).
   3. Merge the two near-identical source rules (2.8).
   4. Cut the per-pick log noise for an unreadable record (2.3).
3. **Train:** this change alone would be an AREA change (Inspector only, read-only). It can still ride C-79 because C-78's finaliser entry is already on this base. BUG-1240 stays open until N39 and C39 pass, per the Claude-accepted rule.

### Own mistake

1. **Two temporary files:** I copied two repository source files into `%TEMP%\r1880` and `/tmp` for reading, then deleted them straight away. The brief allows writing only this one file. No repository or settings file was touched. Cost: none.
