# Re-review: draft PR 2048, `claude/trust04-s-b1276-unsaved-structural` (BUG-1276 Structural, card TRUST-04), head `7999b80a`

**Reviewer:** lane trust-review (seventh run), Fri 13 Nov 2026, 02:16 PC clock. Read only: nothing built, run, installed or merged by this lane. A GO is evidence for testing on copies, never acceptance.
**What was read:** the one new commit `7999b80a` (01:34, fast-forward from `2b5f9004`; 4 files; base still `8de95c34`, installed Structural 1.0.126), checked against my review `reviews\claude-trust04-s-b1276-unsaved-structural.md`; the Structural `DrawingSafetyService` skip reasons at the same head.

---

# FOR TIM

1. **Both on-screen faults from the last review are fixed:** CE now says once when it cannot keep copies (AutoCAD's automatic save off, or no automatic-save file appearing), and the "backup copy not made" line is plain and silent when switched off.
2. **One new wrong line:** saving a standard details drawing (or a temporary or recovery drawing) would print "CE: backup copy not made (CE could not read the drawing file)", which is untrue, and the reminder ships on, so colleagues would see it.
3. **Copies go to the same single folder as Civil's.**

**Verdict: FIX FIRST** (one small item, section 2). Built yes (by its lane). Tested: unit tests only, by its lane (not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **Nothing on screen when copies cannot be kept: FIXED.** Same rule and words as Civil (`UnsavedWorkPlanner.cs` 162-171; `DrawingAutoSaveService.UnsavedWork.cs` 320-327), once per AutoCAD session. A blank SAVEFILEPATH now falls back to the Windows temporary folder as Civil does (`UnsavedWork.cs` 445-448), so Structural no longer finds no files at all in that case.
2. **Software words in the "backup copy not made" line: FIXED for the reasons Civil has,** and the line now needs the reminder or the copies switched on (`UnsavedWork.cs` 510-521). But see section 2.
3. **Job-number-shaped folder name in the tests: FIXED** (now an obviously made-up number).

## 2. FIX FIRST

1. **Four Structural reasons fall through to a wrong plain reason.** Structural's safety check has reasons Civil's does not: "temporary recovery drawing", "temporary workspace drawing", "autosave workspace drawing" and "standard details drawing" (`DrawingSafetyService.cs` 230-248). `PlainBackupSkipReason` (planner 141-155, copied from Civil) has no words for them, so each gives "CE could not read the drawing file". Because the reminder ships on, a colleague saving a standard detail would read "CE: backup copy not made (CE could not read the drawing file)." That is untrue and alarming. My last review asked to decide whether standard details and templates need a line at all.
2. **Fix:** plain words for each ("this is a standard details drawing", "this is a temporary or recovery copy"), or no line for standard details and templates (DRAFT default, for Tim to confirm), and a test that every reason the safety check can give has its own words, so the fallback is never used for a known reason.

## 3. Worth knowing (not blocking)

1. **Same folder as Civil:** `%APPDATA%\TIM_CE_CADTOOLS\AutoSaveBackups\UnsavedWork\<drawing name>_<code>` (`UnsavedWork.cs` 532-538); the drawing code is the same 8 characters of the path in both suites, so one drawing's copies land in one sub-folder whichever suite made them. Each suite reads its own "Backup folder" Setting, so an office that sets it in one suite only would split them again.
2. **The Settings row "Every (minutes)"** is unchanged; "Copy unsaved work every (minutes)" would read better (last review, for Codex's look).
3. No client name, job number, street or suburb in the change.

## 4. Not checked

1. Did not build or run tests.
2. Nothing seen in AutoCAD; Structural has no headless harness here (`EVIDENCE_BRANCHES.md` section C).
