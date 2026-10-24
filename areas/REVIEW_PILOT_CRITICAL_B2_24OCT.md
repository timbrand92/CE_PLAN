# Independent review: pilot-critical batch 2 PRs, Sat 24 Oct 2026

Reviewer: Opus 5.5, independent (did not build these). Method as `REVIEW_PILOT_CRITICAL_24OCT.md` and `REVIEW_PILOT_CRITICAL_B2B3_24OCT.md`. Base `origin/claude/rel-20261024m` at `5467f705` (installed Civil 3.0.73 / Manager 1.1.73). Each PR read at its live head, not from its report: #1760 `13331b81`, #1758 `cb3245e4`, #1764 `c7da3e94`, #1763 `5645dd21`, #1765 `a5775b64`, #1767 `b275abd7`. All six are single commits sitting straight on the base (0 behind). C-64 compared at `origin/claude/rel-20261024n` tip `f73755ee` (its finalizer was mid-run during this review).

## ANSWER FIRST

1. **Counts:** MERGE 5, MERGE-WITH-FIXES 1, HOLD 0, REJECT 0 (six PRs).
2. **Safe to merge today (train C-65):** #1760 (BUG-1196, the HIGH wrong answer), #1758 (BUG-1150), #1764 (BUG-1198), #1763 (BUG-1140), #1765 (BUG-1145).
   - **#1767 (BUG-1149) after one small fix** (item 6): about five minutes of work.
3. **Top fault found (#1767):** on a sheet whose Pit Schedule comes from TWO stage drawings, if one Xref is bound (or detached) and the other stage drawing has really changed, the schedule shows only "SOURCE NOT FOUND" and Project QA drops from a Fail to a warning. The real "OUT OF DATE" (or "SOURCE UNLOADED") of the second drawing is hidden.
   - **On a job:** a two-stage sheet could look "only a warning" while half its schedule is out of date.
   - **Fix:** give the warning only when nothing else is wrong (exact line in item 6).
4. **One question for Tim (#1767, plain English):** after this change CE cannot tell "you BOUND the stage Xref on purpose" from "someone DETACHED it by mistake". Both now show "SOURCE NOT FOUND ... if you bound the Xref, the schedule is frozen as placed" and a yellow warning instead of a red Fail.
   - **My recommendation:** keep it. The schedule on the sheet is never changed either way, the sentence tells the drafter what happened, and the warning still stops the sheet reading "all clear" in QA.
   - **If Tim wants otherwise:** keep the red Fail and only change the wording. That is a one-line change.
5. **Hand check of the HIGH wrong-answer fix (#1760), with the PR's own example:** pit P2, cover RL 11.00, floor RL 10.20, chosen outlet to P3 leaving at RL 10.40, a second pipe to P4 leaving at RL 9.90, step irons at 900 mm.
   - **Window (unchanged):** lowest of floor 10.20, outlet 10.40 and other pipe 9.90 = 9.90. Depth = 11.00 - 9.90 = **1.10 m**. 1.10 is deeper than 0.90, so "With Step Irons".
   - **Drawn table after a pit edit, before the fix:** the refresh only counted pipes flowing INTO P2 (none), so lowest = floor 10.20. Depth = 11.00 - 10.20 = **0.80 m**, and 0.80 is not deeper than 0.90, so the note was dropped. That is the bug.
   - **After the fix:** the refresh counts every pipe at the pit except the chosen outlet, like the window: **1.10 m and "With Step Irons"**. The new numbers are right.
6. **Protected files:** CE_SHARED, Installer, Manager, signing, deploy and PackageContents files are untouched by all six (checked per PR from the merge base).
7. **No new hard block, nothing hard-coded:** every change warns and carries on or only changes what is shown. No new engineering number: #1760 reuses the Settings step-iron depth; #1758's only list is the three CE pit block names.
8. **Switches:** all six new switches are ON, an older settings file loads each one ON (tested per PR). None has a Settings page row (the window is at its 670 px limit; owed to the window lane, as with C-64).
9. **What my checks rest on:** reading at each PR head plus one build in which C-64 and all six together compiled with 0 code errors. **No test ran in this review** (the build stopped at a missing empty placeholder file before the tests project; one build was my limit). The C-65 assembler's test run is the first independent run.
10. **Batch 2 report claims checked (RULES 6.1):** test counts are right (7, 11, 6, 10, 23, 10). Protected files untouched, as claimed. The report's "cross-PR merge not done" warning was real: the six clash with each other in `UserSettings.cs` (neighbouring switches only) as well as the log (details below). No other claim found wrong.

## Checks I ran

1. **Combined trees (local only, nothing pushed; both worktrees removed at the end):**
   - **Base plus all six** (`C:\ce-rv7\m`): they clash with each other in `REGRESSION_LOG.md` and, for #1763, #1765 and #1767, in `UserSettings.cs`. Every settings clash is two switches added at the same spot: keep both, each with its own `/// <summary>` line. No product code clashes; #1765 and #1767 both change `PitScheduleStatusService.cs` and merge by themselves.
   - **C-64 plus all six** (`C:\ce-rv7\n`, on `rel-20261024n` `f73755ee`): each PR alone and all six together clash only in the log and in `UserSettings.cs`, beside C-64's `otherUsersFoldersFollowThisPc` and `shallowPitDepthMm`. No switch name repeats; all six new switches are present after resolving.
2. **One build (my cap), NOT a clean result:** Civil tests project, net10, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, shared build lock taken 16:03 and released at the end, 17 GB free before.
   - **What it proved:** the Civil plugin itself (C-64 plus all six) compiled with 0 code errors (`CE_CVL_SUITE.dll` written to `obj`).
   - **What failed:** the copy step stopped on a missing placeholder file (`CE_TRANSFORM_2027.arx`, which the train assemblers create as an empty file in their worktree; I did not). So the tests project was not built and **no tests ran**. I did not build again, because the brief allowed one build.
   - **Nothing deployed,** no bundle written (SkipDevBundle), AutoCAD not started.
3. **Tests by reading instead:** for each PR I read the new tests against the base code. Each has a switch-off test that reproduces the old behaviour, and/or a source guard that asserts text the base does not have (or forbids text it does have). Each would fail on the base. The builder's own runs (19,812 to 19,829 tests, 0 real failures; #1763 had one unrelated PDF loader failure) were not re-run.
4. **Reading checks done:** cause traced in the base code for all six; every new drawing read checked for a new transaction (none: all reuse the caller's) and every new write checked for locked-layer handling (only #1763's, which skips locked layers); Pit Schedule record scope for #1765; QA mapping for #1767.

## One item per PR

1. **#1760 BUG-1196 (HIGH, WRONG ANSWER): the drawn Pit Schedule depth and "With Step Irons" note after a pit edit match the window when a pit has a lower second outgoing pipe. Verdict MERGE. Train C-65.**
   - **Cause is real:** on the base, `ScheduleLinkService.LowestInletInvertText` (used by the after-edit refresh for both the depth cell and the step-iron note) counted only pipes whose TO end is the pit. The window (`PitScheduleBuilder.DeterminePitConnections`) counts every connected pipe except the chosen outlet. A second pipe LEAVING the pit was therefore seen by the window and not by the refresh.
   - **The fix:** one pure rule, `PitScheduleDepthRule.ConnectedPipesExceptOutlet`, now used by both window loops and by the refresh (design rule 1). The refresh also leaves out pipes marked "not in schedule", as the window does.
   - **Hand check:** ANSWER FIRST item 5.
   - **Tests:** the switch-off test proves the old 0.80 and no note; the switch-on test gives 1.10 and the note; a window-versus-refresh test (net10 only) gives the same 1.10 both ways, with the lower pipe leaving or arriving.
   - **Switch:** `linking.pitScheduleRefreshCountsAllConnectedPipes`, ON.
   - **Redo, locked layers, Xrefs:** no new drawing read or write; the refresh reads the job record only, as before.
   - **Limits (not faults):**
     - **Schedule sets:** the window also keeps only pipes of the same schedule set; the refresh still does not. A pit whose pipes sit in two schedule sets can still differ between window and table.
     - **Window-only drops:** display-child pipes and the rising-main continuation half are still dropped by the window only (the report says so).
     - **Same-handle copy:** the window now also treats a second record with the outlet's drawing handle as the outlet. That is a duplicate record of the same pipe, so leaving it out is correct.
     - **Cosmetic:** the switch's note ends "Default: on. Default: on." (said twice). No change needed for the merge.

2. **#1758 BUG-1150 (DATA LOSS): a pasted CE network saved without CDREPAIR wakes Civil when the drawing is reopened. Verdict MERGE. Train C-65.**
   - **Cause is real:** both open-time readers (`ProjectDataService.HasCivilContent` and `HasCivilContentReadOnly`) passed a hard-coded `ceObjectPresent: false`, so a drawing with CE pits but an empty record opened quiet and MOVE left pipes and labels behind.
   - **The fix:** only when the record holds nothing (and the switch is on), CE asks each CE pit block definition ("PIT BLOCK", "PIT BLOCK 2", "PIT BLOCK 3", plus their dynamic copies) for its own list of uses and stops at the first one sitting in model space. No walk through model space, read-only, inside the transaction the reader already had (no new transaction, so nothing new between U and REDO). Any failure counts as "none found" and is logged.
   - **Cost:** a drawing with a CE record never pays for the look; a non-CE drawing pays a few block-table lookups once per session (the answer is cached per drawing).
   - **Switch:** `linking.civilWakesForPitsWithoutRecord`, ON.
   - **Old test rewritten on purpose:** `Bug203QuietRecordTests` pinned the hard-coded false; it now pins the new value. That guard encoded the bug, so rewriting it is right.
   - **Limits (not faults):**
     - **Structural drawings:** a `_STR_` drawing with a pasted CE pit in model space now wakes Civil too. That follows the existing rule ("a Structural drawing with Civil content is active").
     - **Same block name:** a non-CE drawing that happens to use a block called "PIT BLOCK" also wakes Civil (the name test CE already uses everywhere).
     - **Not counted:** a pit only on a layout, or only inside another block, and a pasted pipe with no pit.
     - **Stale comment:** `LinkService.Utilities.cs` still says "No ModelSpace fallback is permitted here"; the read-only reader behind it now does the block-list look. Comment only.

3. **#1764 BUG-1198: Export CSV or Export Excel, then Cancel, no longer leaves the drawing changed. Verdict MERGE. Train C-65.**
   - **Cause is real:** both export buttons called `PersistManualRows()` and `FlushPendingSave()` BEFORE the file chooser, writing the row order and record into the drawing even on Cancel.
   - **The fix:** with the switch ON the two exports only read the rows on screen. I checked edits are not lost: every edit path already calls `PersistManualRows`, and the window writes any waiting record when it closes (`PitScheduleDialog.OnClosed`, BUG-817 rule). The rows exported are the same ones (`GetRowsForPlacement`).
   - **Switch:** `linking.pitScheduleExportWritesNothing`, ON.
   - **Redo:** removes a write; nothing new.
   - **Limit:** checked by source guards only; the file chooser and the "Save changes?" prompt were not seen.

4. **#1763 BUG-1140: a pasted downpipe no longer moves, or takes over, its original's label. Verdict MERGE. Train C-65.**
   - **Cause is real:** a downpipe stores its label's handle as plain text (not translated on paste), and `SourceTagService.TryGetLabelId` / `TryGetHitboxId` took ANY object with that handle.
   - **The fix:** a label link is accepted only if the object is a text (a circle for the hitbox) AND its owner note is blank, names this downpipe, or names nothing still in the drawing. I checked the owner note is real for downpipe labels: `RegisterSourceVisualAttachment` writes it when a label is registered.
   - **CE's own copy-with-label step:** it now writes the copy's owner note just before reading the label back. Without that, the new check would refuse the copy's own label and the copy step would throw; the builder caught this. The write is on the newly made copy inside CE's own copy step, and skips a locked layer (`GetOrCreateLinkDictionary` returns nothing there).
   - **Switch:** `linking.sourceLabelOwnerCheck`, ON.
   - **Redo, Xrefs:** the check only reads, in the caller's transaction.
   - **Limits:**
     - **Older drawings:** a label with no owner note is still accepted, so a pasted downpipe in a drawing made before owner notes were written still behaves the old way.
     - **When a label is refused,** callers that "make sure a label exists" (for example a later tag change) will draw a NEW label for the copy. That is the intended result ("the copy has no label until one is made").

5. **#1765 BUG-1145: a placed Pit Schedule goes OUT OF DATE only when something it draws changes. Verdict MERGE. Train C-65.**
   - **Cause is real:** the status compared a fingerprint of the WHOLE job record, so ignoring a CDCHECKS finding or saving a CDCALC draft flagged every sheet that Xrefs the stage drawing.
   - **The fix:** a second fingerprint of only pits, pipes, manual rows, outlet overrides and row order, stored with newly placed or refreshed schedules and compared when both sides have it. Old schedules keep the old comparison, so nothing flips at the update.
   - **I checked the scope is complete:** the schedule code (builder, refresh, window) reads only those five parts of the record. The "inlet from" names strip downpipe numbers, so the "Number sources" setting does not change what is drawn. A missed part would give a false CURRENT, so this was the key check.
   - **Switch:** `linking.pitScheduleFingerprintScopedToSchedule`, ON. OFF stores nothing new and compares the old way.
   - **Redo:** status and placement record only; no new drawing write path.
   - **Limits:** `ProjectQaOutputCurrencyPolicy` still compares the whole record (the report says so); `PitScheduleSnapshotBuilder` (the redesign snapshot) does not carry the new fingerprint, which does not affect the status badge.

6. **#1767 BUG-1149: after BIND of the stage Xref, the schedule reads SOURCE NOT FOUND ("frozen as placed") and QA warns instead of failing. Verdict MERGE-WITH-FIXES. Train C-65.**
   - **Cause is real:** a stored source with no matching Xref by identity or path was always "SOURCE MISSING" with a QA Fail, so a bound sheet failed forever.
   - **The fix:** a source with nothing in the Xref list at its identity OR its path is now "gone, maybe bound": headline SOURCE NOT FOUND, QA Unknown (yellow). A source still listed but unreadable, or a different file at the same path, keeps SOURCE MISSING and the Fail. The placed schedule is never rewritten and no Update is offered.
   - **The fault (must fix):** in `PitScheduleStatusService.Evaluate` the new "gone" result is returned BEFORE the "unloaded" and "changed" checks. With two sources, one gone and one changed, the status says SOURCE NOT FOUND and QA becomes a warning, hiding an OUT OF DATE that is a Fail today. Same for an unloaded second source.
   - **Exact fix (one line, keeps the headline order so no Update is offered while a source is gone):** replace `gone.SourceGoneMaybeBound = true;` with `gone.SourceGoneMaybeBound = unloaded.Count == 0 && changed.Count == 0;` and add a test with two sources (one gone, one with a changed fingerprint) expecting QA `Fail`. Optional: append the other source names to the detail text so the drafter sees them.
   - **Switch:** `linking.pitScheduleBoundSourceFrozen`, ON.
   - **Redo, locked layers:** status text only.
   - **Question for Tim:** ANSWER FIRST item 4 (bind and detach look the same).
   - **Overlap with #1765:** both edit `PitScheduleStatusService.cs`; they merge by themselves and both changes are present in the combined tree.

## Train

1. **C-65 for all six** (#1767 once its fix is pushed and re-read), one install (RULES 8.5).
2. **Merge clashes to expect:** `REGRESSION_LOG.md` every time; `UserSettings.cs` neighbouring additions (keep all; each needs its own `/// <summary>` line). Against C-64 (`rel-20261024n`) the same: log plus neighbouring switches beside `otherUsersFoldersFollowThisPc` and `shallowPitDepthMm`. No switch name repeats.
3. **New-switch defaults test for C-65:** pin ON `linking.pitScheduleRefreshCountsAllConnectedPipes`, `linking.civilWakesForPitsWithoutRecord`, `linking.pitScheduleExportWritesNothing`, `linking.sourceLabelOwnerCheck`, `linking.pitScheduleFingerprintScopedToSchedule`, `linking.pitScheduleBoundSourceFrozen` (plus batch 3's three).
4. **Batch 3 together with batch 2:** not trial-merged together in this review (batch 3's review says its PRs clash with #1758 and #1760 only in the log).

## What I did NOT check (RULES 5.9)

1. **AutoCAD:** nothing was opened in AutoCAD. No pasted network, downpipe, export Cancel, Xref BIND, schedule status or pit edit was tried there. Built and unit-tested only; nobody has seen any of these work in AutoCAD.
2. **No test was run by me:** my one build compiled the plugin but stopped before the tests project (missing empty ARX placeholder), so even the focused tests did not run. RED was checked by reading each PR's tests against the base code, not by running them. **The C-65 assembler must run the six new test classes and the full suite on the combined tree.**
3. **Other projects:** net48, Manager and Structural were not built or tested.
4. **Batch 3 with batch 2:** not merged together here.
5. **Semantic fit with C-64:** checked by trial merge and by reading the Pit Schedule overlaps (#1554 SOURCE UNLOADED, #1614, #1722); no test was run on the combined tree.
6. **The seven skipped batch 2 bugs** (BUG-540, BUG-1049, BUG-1148, BUG-857, BUG-685, BUG-855, BUG-587) have no PR and were not reviewed.
