# BUGFIX w609 report: BUG-609 (3 Nov 2026)

## FOR TIM

1. **What you will see:** close the last open drawing and the Structural Checklist tab shows "No Checklist" instead of the closed drawing's "0 of 3", Undo and tick boxes. Reopen a drawing and its own checklist loads as before.
2. **Switch:** General.ClearChecklistWhenLastDrawingCloses in CS_Settings.json. Default: on. Off gives the old behaviour exactly.
3. **My mistakes:** two wasted tool attempts (a sed edit that did not match the line endings, and test-runner arguments with a space in the path). No effect on files.
4. **NOT proven:** nothing was opened in AutoCAD. Event timing, and the template buttons being disabled with no drawing, are not proven. The template button was not changed (no window change made).
5. **Robot case to prove it (name proposed: N40_checklist_lastclose):** open a drawing with a checklist, type CLOSE with Enter, read the Checklist tab text: expect "No Checklist" and no "0 of". Control: set the switch false before launch, repeat, expect the old "0 of 3" still shown.

## Technical

1. **Fault confirmed on rel-20261102a:** MainPalette.xaml.cs subscribed only to DocumentActivated; no close listener existed, so nothing re-read the checklist when the last drawing closed. ChecklistPanel.LoadChecklist already shows "No Checklist" when MdiActiveDocument is null.
2. **Fix:** MainPalette.OnDocumentDestroyed (subscribed in the constructor, removed in DisposePalette); when DocumentManager.Count == 0 it calls RequestChecklistRefresh. PR 2006 (draft, base claude/rel-20261102a, one commit, branch claude/w609-checklist-clear). Not stacked on 1260.
3. **Tests:** Bug609ChecklistClearTests, 6 passed of 6 (net10, filter, count not 0). net48 compile 0 errors. REGRESSION_LOG entry added. CE_SHARED unchanged.
4. **Isolation:** CE_LOG_DIR_OVERRIDE, TEMP, TMP and CE_STRUC_SUITE_APPDATA_ROOT set to C:\CE_WORK\scratch\w609. Real AppData listings before and after are identical (36,509 lines each, diffed, no change). Listings in C:\CE_WORK\scratch\w609\before.txt and after.txt (removed with the scratch folder; the diff was empty).
5. **Note:** the base given was rel-20261102a, though rule 4 names rel-20261026s for Structural.
