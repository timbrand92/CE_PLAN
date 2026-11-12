# Re-review: draft PR 2042, `claude/trust04-b1276-unsaved-civil` (BUG-1276 Civil, card TRUST-04), head `5f44223c`

**Reviewer:** lane trust-review (seventh run), Fri 13 Nov 2026, 02:16 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO is evidence for testing on copies, never acceptance.
**What was read:** the one new commit `5f44223c` (01:21, fast-forward from `c8044744`; 4 files), checked against my review `reviews\claude-trust04-b1276-unsaved-civil.md`; the Civil `DrawingSafetyService` skip reasons at the same head; card TRUST-04 decision 3 and `PENDING_TESTS.md` section "TRUST-04 core safety fixes" on `main`.

---

# FOR TIM

1. **Both faults from the last review are fixed:** the "backup copy not made" line now stays silent when both new switches are off and gives its reason in plain words, and CE now says once on screen when it cannot keep copies of unsaved work (for example when AutoCAD's automatic save is off).
2. **Copies of unsaved work now go to one folder for Civil and Structural,** so after a crash there is one place to look.
3. **CE still never saves your drawing and writes nothing beside it.**

**Verdict: GO** for the robot and Codex on copies. Built yes (by its lane). Tested: unit tests only, by its lane (not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **The "backup copy not made" line ignored the switches and used software words: FIXED.** It prints only when the reminder or the copies are switched on (`DrawingBackupService.cs` 323-327), and the reason goes through `UnsavedWorkPlanner.PlainBackupSkipReason` (planner 141-155). Every reason Civil's safety check can give is covered (`DrawingSafetyService.cs` 142-247: document and database reasons, "drawing path unavailable", both automatic-save copies, "non-DWG drawing", "template drawing"). Test: `TheBackupNotMadeLine_IsSilentWithBothNewSwitchesOff_AndUsesTheDraftingWords` (test 534).
2. **Nothing on screen when copies cannot be kept: FIXED.** One line per AutoCAD session from the skip step (`DrawingBackupService.cs` 641-649): at once when AutoCAD's automatic save is off ("CE cannot keep copies of unsaved work: AutoCAD's automatic save is off (OPTIONS, Open and Save tab, Automatic save). CE will still remind you to save."), and when automatic save is on but no automatic-save file has appeared after twice AutoCAD's interval plus two minutes (planner 162-171). The skip step runs only when the copies switch is on (`TryTakeUnsavedCopy`, 578-585). Tests 550 and 581.

## 2. Also changed

1. **One folder for copies of unsaved work:** `%APPDATA%\TIM_CE_CADTOOLS\AutoSaveBackups\UnsavedWork\<drawing name>_<code>` (`DrawingBackupService.cs` 896-901; planner 132-135), the same folder and the same drawing code as the Structural half at PR 2048's new head (both use the same 8-character code of the drawing's path). Old copies are trimmed in the new folder (705). Saved-file backups stay where they were. This closes my first review's item 6 for unsaved copies.
2. **The robot step in the change log now names the new folder** (REGRESSION_LOG item 5); `PENDING_TESTS.md` row 3 in "TRUST-04 core safety fixes" should say the same folder.

## 3. Worth knowing (not blocking)

1. **A reason not on the list reads "CE could not read the drawing file"** (planner 154). Civil has no such reason today; if one is added later, that fallback will be wrong words. A test that every reason in the safety check has its own plain words would guard it.
2. **"Once per AutoCAD session":** after the line has shown once, a second drawing in the same session that also cannot be copied gets no line. Acceptable; the reminder still runs.
3. Still open from the first review, not blocking: twelve copies of a large automatic-save file per drawing, not measured; the background copy writes its results without the lock (tidy only).
4. No client name, job number, street or suburb in the change.

## 4. Not checked

1. Did not build or run tests.
2. Nothing seen in AutoCAD: the lines as drawn, the automatic-save file on 2027, the copy time.
3. Why Tim's PC had no automatic-save files on 4 Nov (still unexplained; this fix now says so on screen when it happens).
