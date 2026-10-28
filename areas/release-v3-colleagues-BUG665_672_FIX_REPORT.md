# BUG-665 and BUG-672 fix report: ROTATE Copy of a pit with no label or cover text, and the wrong "no label" line (Wed 28 Oct 2026, Team Opus, desk plan/03)

## ANSWER FIRST

### FOR TIM

1. **Mistakes of my own first.**
   1. My first full test run had 1 failure: an older check still insisted on the exact "same rotation only" line that causes the fault. I fixed the check and re-ran. Cost: about 10 minutes of test time, no harm.
   2. I could not find the installed Civil file on disk to re-read its time stamp. Every build ran with the "do not install" flag, so nothing was installed, but I did not see that with my own eyes.
2. **The cause, BUG-665 (ROTATE Copy gives a pit with no label and no cover text).** When CE completes a copied pit, it copies the label and cover text across only if the new pit sits at the same angle as the original. ROTATE Copy turns the pit, so CE quietly skipped both, but still said "1 pit copied and numbered as new". A second cause: with the Settings tick "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" off (your file, and everyone else's), CE treats ROTATE Copy and SCALE Copy as plain moves. So SCALE Copy was missing the label and cover text too.
3. **The cause, BUG-672 (the wrong "no label" message).** When a layer is locked during a copy, CE always printed "got their own number but no label or cover text", even when the number label WAS drawn and only the cover text was missing.
4. **The fix: draft PR #1831** (not merged, not installed).
5. **What changes for a drafter.**
   1. ROTATE a pit with C (Copy) by 90: the new pit now gets its own number label and cover text, sitting beside it just as a COPY places them, still upright and readable.
   2. SCALE a pit with C (Copy): the same.
   3. The grip Ctrl-drag copy is not changed. It still follows the old tick, which stays off, because no robot case drives it yet.
   4. Lock 25TEXT and COPY a pit: the line now reads "1 copied pit(s) got their own number but no cover text: layer 25TEXT is locked ... Undo (U), unlock layer 25TEXT, then copy again." It says "no label" only when the label really is missing.
   5. A locked layer still stops CE drawing on it. Nothing is unlocked, and REDO is not touched.
   6. Two new Settings switches, both ON, because they fix faults (rule R-27, and the recommended answer to Monday question 8). Turning either one off gives back the old behaviour for that one fault.
6. **Which robot cases prove it, once it is installed.**
   1. R34, R34s and R34so (BUG-665) fail today and should turn to PASS.
   2. R33m (BUG-672 message) fails today and should turn to PASS.
   3. R34a (plain COPY) and R34sn (copy numbers) should still pass.
   4. One twin needs a one-line change: R34s_OFF_BROKEN must also switch the new rotate setting off, or it will pass when it should fail.
7. **Built and unit-tested only.** Nobody has opened this in AutoCAD. Both bugs stay open until the robot passes them twice on an installed build.

---

## Detail

1. **Start point.** `claude/rel-20261026y` at 94f521cc (Civil 3.0.84, C-74), read with `git ls-remote origin` (the remote here is called `origin`, not `github`). Branch `fb/bug665-672-rotate-copy-label`, commit 6f7736c5, draft PR #1831 against `claude/rel-20261026y`.
2. **Cause, with file and line (at 94f521cc).**
   1. BUG-665 main: `Modules/Drainage/Services/LinkService.CloneRegeneration.cs` lines 280-285, `ClonePitAttachmentsByDisplacement`: `Math.Abs(source.Rotation - clone.Rotation) > 1e-6` returns 0 (comment at 224-225: "Only pure translations ... a rotated copy is left for the editor"). No line is printed.
   2. BUG-665 second suspect, confirmed: `Modules/Drainage/Services/ExternalMutationCommandPolicy.cs` lines 98-106, `CanCreateClones`: ROTATE and SCALE are copy-capable only with `linking.cleanUpGripRotateScaleCopies`, which is false at `Models/UserSettings.cs` line 817.
   3. BUG-672: `Modules/Drainage/Services/CloneCleanupMessages.cs` line 139, `PitLabelCopySkips.Line`, fixed words "no label or cover text"; `Add` also counted each skipped annotation as a pit.
3. **Fix.**
   1. New `Rules/RotateScaleCopyRule.cs` (AutoCAD-free): `CommandCanCopy` (ROTATE, SCALE), `CopiesPitAnnotationsAcross` (same rotation always; switch on, a turned copy too; a copy mirrored against its original keeps the old rule), `MissingWords`.
   2. `linking.rotateScaleCopyLikeCopy` (ON): `CanCreateClones` adds ROTATE and SCALE. A plain ROTATE or SCALE appends nothing, so it still does no clone work. Labels are moved by the pit's displacement, the same code path a COPY uses.
   3. `linking.pitCopyLineNamesOnlyWhatIsMissing` (ON): `PitLabelCopySkips.Add` gets the pit handle and the kind (PIT LABEL block, or cover text); the line names only what was left out and counts each pit once. With `copyCleanUpKeepsEveryPiece` off (nothing copied) it still says "label or cover text".
   4. Nothing unlocks a layer; no command, regen, view or system variable change is added (source guard in the tests).
4. **Tests.** New `Bug665672RotateCopyLabelTests` (34): both keys ON through both start-up reads, typed false turns off only itself; each fault reproduced with its switch OFF and fixed ON; R33m's exact sentence; grips and other transforms unchanged; source guards. Existing guards changed: `LinkServiceCommandPerformanceContractTests` (ROTATE removed from the "never a copy" list), `CopyOfAPitOrPipeKeepsNoIdentityTests`, `C4CopyPasteMirrorOopsTests`, `OvernightLabelDoubleClickAndCopyTests`. Focused 297 passed; Civil net10 full suite 20721 passed, 0 failed, 32 skipped (the PDF page test passed in the full run, so no re-run alone was needed); net48 compile 0 errors. Every build passed `-p:SkipDevBundle=true -nr:false --disable-build-servers` with the C-62 refs.
5. **Not done or not tested.** No AutoCAD run. The grip Ctrl-drag half of BUG-665 is not changed. A mirrored pit copy is not changed. A pit whose label lands on another object after a turn is not checked (the label keeps the original's offset, exactly as after a COPY). CE_SHARED is not changed.
6. **Housekeeping.** Worktree `C:\ce-fx\b665` and scratch `C:\ce-fx\b665x` removed at the end. DESK_LOG.md and BUG_CARPARK.md were not edited.

Summary: BUG-665 came from a "same angle only" check in CE's pit-copy step, plus ROTATE and SCALE sitting behind an OFF tick. BUG-672 came from a fixed sentence. Draft PR #1831 fixes both behind two ON switches. 20721 tests pass. R34, R34s, R34so and R33m should turn to PASS once it is installed.
