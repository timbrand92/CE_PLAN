# Opus review of the PR pile, batch 7 (class E, positions 67 to 78), Sat 24 Oct 2026

Headless job, desk plan/03, Team (Opus 5.5). Started 06:05 Melbourne time. Read only: no build, no test run, no AutoCAD, nothing pushed to a PR branch, nothing merged, closed or labelled. My own copy of the repo was the bare `C:\ce-tr\b7.git` (borrows objects from the triage copy; the local clone was not touched).

Input: `areas/PR_PILE_TRIAGE_2026-10-24.md`, class E, items 67 to 78: #1554, #1559, #1560, #1561, #1563, #1564, #1565, #1566, #1568, #1569, #1572, #1573.

**Skipped, already reviewed by Opus:** #1554 (`REVIEW_PILE_B3_24OCT.md`), #1561 and #1573 (`REVIEW_PILE_B2_24OCT.md`), #1565 and #1569 (`REVIEW_PILE_B1_24OCT.md`).

Compared against: installed Civil 3.0.72 / Manager 1.1.72 = `claude/rel-20261023m` f7f7d551; installed Structural 1.0.122 = `claude/rel-20261023s` e6d597c0; planned C-63 = `claude/rel-20261024m` 28987b73; S-43 = PRs #1695 to #1699. I checked all three branch tips on GitHub at 06:07. All 7 PRs are open drafts and their heads match what I reviewed.

## ANSWER FIRST

1. **Counts (7 reviewed, 5 skipped):** 5 MERGE, 2 MERGE-WITH-FIXES, 0 HOLD, 0 REJECT.
   1. **MERGE:** #1559 (Civil CDJOINT, train C-64); #1563, #1564, #1566, #1568 (Structural, train S-44).
   2. **MERGE-WITH-FIXES:** #1560 (Structural notes file, S-44), #1572 (Structural sheet preview, S-44).

2. **Top faults:**
   1. **#1560 refuses the note without telling the drafter.** If the notes file cannot be read, the new note is no longer saved over it. That part is right. But the Notes window says nothing, so the drafter types a note, clicks OK, and the note is silently gone. The only trace is a line in the CE log. Small fix: add a message box where the window adds the note (`NotesBrowserDialog.xaml.cs` about line 1061): "Note not saved. The notes file could not be read, so saving now would wipe your earlier notes. Your note text: …".
   2. **#1560's twin bug is not fixed and has no bug number.** The shared project tags file (`SharedNotesManager.cs`, `LoadProjectTagsData` and `SaveProjectTagsForGroup`) works the same way. If it cannot be read, it loads as empty and the next tag save wipes every other job's tags. **This needs a new carpark entry.** I am not allowed to edit the carpark.
   3. **#1572: the Sheets palette opens its new preview the plain way.** It does not use the house helper `AutoCadWindowHostHelper.ShowPaletteModalDialog` that the other palettes use, so the preview may open behind AutoCAD or in the wrong place. One-line fix. It is a window, so it needs a Codex look in AutoCAD.
   4. **#1566 means a second AutoCAD now runs all Structural services.** That is what BUG-978 asks for. But until now two AutoCADs never ran the job timer, the settings saves or the notes cache side by side, and nobody has tested that. I did not prove whether two timers count the same hour twice. The AutoCAD check must cover it.

3. **Safe to merge today:**
   1. **Civil, train C-64:** #1559.
   2. **Structural, train S-44, in this order:** #1568, #1564, #1563, #1566.
   3. **After their small fixes:** #1560, then #1572. Put #1572 after #1568, because both touch the sheet sync file. My trial merge shows the two combine cleanly.
   4. **Clashes:** each PR clashes only in `REGRESSION_LOG.md` (keep both entries). This holds on the installed lines, on C-63, and against S-43. No S-43 PR touches the same code files.

4. **Risk checks, all seven PRs:**
   1. **CE_SHARED, installer and signed-update files:** none touched.
   2. **New hard blocks:** none. #1560's refusal stops only a note save over an unreadable notes file; drawing work goes on. #1572 adds an Apply / Cancel question, not a block.
   3. **Bug-fix switches:** none of the seven adds a switch. None of them needs one, because each fix only puts back what the drafter expects.
   4. **Hard-coded engineering values:** none new. The 260 mm label-search distance in #1564 was already there before this PR.
   5. **Redo safety:** nothing writes between a U and its REDO. Each write happens only when the drafter runs the command or clicks Apply. #1566 runs once, when AutoCAD starts.
   6. **Locked layers, Xrefs, REFEDIT:** no new bypass. In #1559 CDJOINT still erases the old joints the same way; it only moves the erase later.

5. **C-63 and S-43:** none of these seven bugs (BUG-972, 973, 975, 976, 977, 978, 979) is fixed in installed code, C-63 or S-43. The triage list shows no second PR for any of them.

---

## Per PR

1. **#1559 @ ab8980c8 (BUG-979, Civil CDJOINT keeps the old joints if you press Esc at "Select slab type"): MERGE, train C-64.**
   1. **The cause is real (I checked the installed code):** in `Modules/Drainage/Commands/CdJointCommand.cs` lines 77 to 96, answering Yes to "Clear and regenerate" erases the old joint lines and SC labels straight away (line 94). Only then does it ask for the slab type (line 99) and check that the grid makes joints (lines 105 to 111). Esc at the slab type, or a slab too small for one panel, therefore leaves the slab bare. The slab record still lists the erased joints. This file is the same in the installed code, in C-63 and at the PR's base.
   2. **The fix does only that:** Yes now just remembers the answer. The erase happens after the slab type is chosen and the grid is known to make joints, just before the new joints are drawn. Nothing else changes.
   3. **A test fails without the fix:** the source-order test `OldJointsAreErasedOnlyAfterSlabTypeAndGridAreKnown` would fail on the installed order (erase before the slab-type question). The second test, "only one erase", passes both before and after the fix; it only stops a second erase being added later.
   4. **LOW, not this PR's fault:** an old joint on a locked layer is skipped without a word, inside the erase step. That was true before this PR too.
   5. **AutoCAD check:** slab with joints, CDJOINT, Enter for Yes, Esc at "Select slab type": the old joints are still there. Again, Yes, pick a type: the old joints are replaced, and one U brings them back.

2. **#1560 @ 0aed87a3 (BUG-976, Structural CENOTES: an unreadable notes file is no longer overwritten by the next note): MERGE-WITH-FIXES, train S-44.**
   1. **The cause is real (I checked the installed code):** in `SharedNotesManager.cs`, both `LoadData` and `LoadDataForUser` return an empty list when the read fails (lines 1000 to 1020 and 1053 to 1085). `AddNote` then adds the one new note and `SaveData` writes the whole file, so every earlier note is lost. A notes file that OneDrive is holding for a moment triggers this too, not just a damaged one.
   2. **The fix does only that:** it remembers each notes file whose read failed and refuses to save over it until a later read succeeds. It covers both the current-user route and the other-user route (edit, import, delete, image), and both routes share one memory. One file name per notes file, so the two routes agree.
   3. **A test fails without the fix:** yes. `AddNote_WhenTheFileCannotBeRead_LeavesTheFileUntouchedAndSaysNo` checks that the file's bytes are unchanged; the old code overwrites them. A repaired file saves again, which a third test proves.
   4. **Fix needed (small):** the window must tell the drafter. Today `NotesBrowserDialog.xaml.cs` line 1061 does nothing when `AddNote` returns false, so the typed note just disappears. Add a message box in the else-branch that says why, with the note text, so it can be copied. The window's two `UpdateNote` calls (edit at line 940, resolve at line 966) are silent too. The Notes palette (`NotesPanel.xaml.cs` line 713) already shows a general "could not be resolved" message, so it can stay as it is. These are window changes, so Codex should look at them in AutoCAD.
   5. **LOW:** when the save is refused, `AddImageForUser` has already copied the picture into the images folder. It is left there unused. Harmless, but untidy.
   6. **Separate bug, not this PR:** the project tags file has the same wipe-on-unreadable pattern (see Answer First 2.2). It needs its own bug entry.

3. **#1563 @ c571e917 (BUG-977, Structural SBEAM picks follow the current UCS): MERGE, train S-44.**
   1. **The cause is real (I checked the installed code):** `SbeamCommandRunner.cs` turns each picked point straight into planner X and Y (`ToPoint2`, line 234), and `SbeamEditCommandRunner.cs` does the same. AutoCAD answers a pick in the current UCS, and the planner and writer work in World. With the UCS moved to 10000,20000, a beam picked from local 0,0 is therefore drawn at World 0,0.
   2. **The fix does only that:** one conversion, `ToWorldPoint2`, now handles all three SBEAM picks and all three SBEAMEDIT replacement picks (design rule 1). The rubber-band base point stays in the UCS, which is correct, because AutoCAD expects it there.
   3. **A test fails without the fix:** the new test does not compile on the old code, because the conversion did not exist. Its cases include the bug's own example (UCS origin 10000,20000) and a 90-degree UCS, and it checks that both runners call the conversion.
   4. **Not proven:** in a rotated UCS, the section and elevation are drawn square to World, not to the UCS. Only the position is fixed. Whether a drafter wants the beam turned with the UCS is a drawing question I cannot settle from the code. Put a rotated-UCS case in the AutoCAD check.
   5. **Clash check:** the installed Structural code added outcome-log lines to the same file since the PR's base. Git combines them cleanly.

4. **#1564 @ ada6c648 (BUG-975, Structural support switch leaves a neighbouring support's label alone): MERGE, train S-44.**
   1. **The cause is real (I checked the installed code):** `CaptureSupportSideTextLabels` takes every text within 260 mm of the switched support. Where supports sit 200 mm apart, the next support's DSL or DSR label gets moved and re-created as well.
   2. **The fix does only that:** a label now stays put if another support's centre is strictly nearer to it than the switched support's. A tie keeps today's behaviour. Both the switch and the rotate preview use the same rule. The switch changes the same block in place, so the switched support is never counted as its own neighbour.
   3. **A test fails without the fix:** the new test does not compile on the old code. It has five cases, including the bug's own layout.
   4. **LOW:** neighbours are measured from the centre of their outline box. The switched support is measured from its offset centre. A label sitting almost exactly halfway between two supports could go either way, and that is inherent in a "nearest support" rule.

5. **#1566 @ 753d90bd (BUG-978, Structural starts up in a second AutoCAD): MERGE, train S-44.**
   1. **The cause is real (I checked the installed code):** `Plugin.cs` line 76 uses one fixed start-up guard name, `Local\CE_STRUC_SUITE.PluginRuntime`. "Local" names are shared by every program on the same Windows login, so a second AutoCAD finds the guard taken and skips all of Structural.
   2. **The fix does only that:** the guard name now ends in the AutoCAD process number. A double load inside one AutoCAD is still refused. The unified host's own guard (`CE.Host/Plugin.cs`, `Local\CE_ACAD_PLUGIN.PluginRuntime`) is untouched.
   3. **A test fails without the fix:** the new test does not compile on the old code. Its five cases use real named guards.
   4. **MEDIUM, not checked (see Answer First 2.4):** two AutoCADs will now both run the job timer, the CS_Settings saves and the notes cache. I did not trace whether the timer counts the same hour twice, or whether two settings saves overwrite each other. The bug asked for exactly this behaviour, so I have not held the PR. The AutoCAD check must open two AutoCADs, use each for a few minutes and read the job time.
   5. **LOW:** `Process.GetCurrentProcess()` is not disposed. It runs once at start-up, so it does no harm.

6. **#1568 @ 59623e91 (BUG-973, Structural CESHEETSCLASSIC: a sheet number swap keeps each row on its own drawing): MERGE, train S-44.**
   1. **The cause is real (I checked the installed code):** `CeSheetsSyncService.ApplyRenamePlan` repoints rows one move at a time and finds them by their old drawing path. In a swap, S01 to S02 moves its row to S02.dwg. The S02 to S01 move then finds both rows on S02.dwg and moves both. Both rows end on one drawing, and `ArchiveUnusedProjectDrawings` then archives the other drawing as unused.
   2. **The fix does only that:** each move's rows and issue snapshots are listed before any row is repointed. The file moves and the rollback are unchanged.
   3. **A test fails without the fix:** yes. The swap test checks each row's drawing, that nothing is archived, and the file contents. The PR says the old code fails because it goes on to archive. A plain rename and a three-way rotation are covered too.
   4. **LOW, not this PR's fault:** if a file move fails part-way, the files are rolled back, but rows already repointed in memory are not. That can be saved to the sheet list. This was true before this PR too.

7. **#1572 @ 2829c47a (BUG-972, Structural "Preview drawing updates" now previews before it writes): MERGE-WITH-FIXES, train S-44, after #1568.**
   1. **The cause is real (I checked the installed code):** the button labelled "Preview drawing updates" in the CESHEETSCLASSIC window (`BtnSyncDrawings_Click`) and the button with the same label in the Sheets palette (`BtnSync_Click`) both write to the closed drawings and save them at once, with no preview.
   2. **The fix does only that:**
      1. **Window button:** builds a read-only list straight from the sheet list, without opening any drawing, and shows it in the existing preview window (Apply / Cancel). The write runs only after Apply.
      2. **Palette button:** shows the existing sync preview first. A preview blocked by the pre-checks goes straight to the sync, which writes nothing and reports the blockers, as before.
   3. **A test fails without the fix:** the new test does not compile on the old code. It checks that the drawing's bytes and saved time are unchanged after a preview, and that both buttons ask before they write.
   4. **Fix needed (one line):** `SheetsPanel.xaml.cs` line 188 calls `previewWindow.ShowDialog()` with no owner. Use `AutoCadWindowHostHelper.ShowPaletteModalDialog(previewWindow)`, as the Checklist palette does, so the preview opens in front of AutoCAD and in the right place.
   5. **LOW:** the preview lists every title-block value it will write, not just the ones that differ, so an unchanged CLIENT still shows. The existing sync preview already works this way, and the window says so.
   6. **Window:** both buttons now open a window, so this needs a Codex look in AutoCAD before it counts as accepted.

---

## What I did NOT check

1. **No build and no test run.** Every PR says net48 was not built, and I did not build either. Compile errors on net48 are possible, though I saw no language feature that the files I read do not already use. I took the RED-before and pass counts from the PR text; I did not re-run them.
2. **Nothing was opened in AutoCAD.** Every item still needs its AutoCAD check. Most important: #1566 with two AutoCADs open, #1563 in a rotated UCS, and #1572's two preview windows (a Codex look).
3. **#1566:** whether two Structural copies running side by side double-count job time or overwrite each other's settings saves.
4. **#1560:** the other callers of the other-user route (the notes import service and the legacy tag migration) were read only far enough to see that they go through the guarded save.
5. **The tests:** I read the tests for #1559, #1560 and #1568 in full. For #1563, #1564, #1566 and #1572 I read only the PR's description of them.
6. **Trial merges** used `git merge-tree` onto the installed lines and C-63. For S-43 I compared the files each PR touches, because S-43's own PRs clash with each other in `REGRESSION_LOG.md` and could not be stacked automatically.
