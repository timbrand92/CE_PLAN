# Pilot-critical batch 2: positions 8 to 20 of the triage's 60 (Sat 24 Oct 2026)

Job: desk plan/03 headless "TEAM FIX PILOT-CRITICAL BATCH 2". Run 11:51 to 15:40 Melbourne time.
Base: `origin/claude/rel-20261024m` @ `5467f7053a2e9275cb450409c142ef9aa26dad53` (Civil 3.0.73 / Manager 1.1.73, fetched 11:52).
Input: `areas/BUG_REGISTER_TRIAGE_2026-10-24.md` section (C), positions 8 to 20.

## ANSWER FIRST

**6 draft PRs opened, 7 skipped.** All six PRs are built and unit-tested only. Nobody has opened any of them in AutoCAD. None is marked FIXED, and each needs its Opus review.

1. **BUG-1196 (HIGH, WRONG ANSWER): fixed in draft PR #1760, head `13331b81`.**
   - **What Tim will see:** after a pit edit, the drawn Pit Schedule depth and the "With Step Irons" note match the window when a pit has a lower second outgoing pipe. P2 no longer drops from 1.10 to 0.80 and loses its note.
   - **Switch:** `linking.pitScheduleRefreshCountsAllConnectedPipes`, ON.
   - **Tests:**
     - 7 new tests; 3 failed with the rule forced off.
     - 882 Pit Schedule and BUG-785 tests passed.
     - Civil net10 full run: 19,813 total, 19,791 passed, 22 skipped, 0 failed.
     - net48 plugin and test builds: 0 errors.
   - **Real-AutoCAD check:**
     1. Make pits P2, P3 and P4. Set P2's cover at RL 11.00 and its floor at RL 10.20.
     2. Draw pipe P2 to P3 leaving P2 at RL 10.40, and make it the outlet. Draw pipe P2 to P4 leaving P2 at RL 9.90.
     3. Leave the pit-floor depth setting ON and step irons at 900 mm.
     4. Run PITSCHEDULE and place the schedule. Right looks like: P2 reads 1.10 and "With Step Irons".
     5. Run PITEDIT, pick P2, change only Plan length from 600 to 900, and save.
     6. Read P2's drawn cells and reopen PITSCHEDULE. Right looks like: 1.10 and "With Step Irons" in both places.
     7. Control: make the lower pipe flow INTO P2 instead and repeat. Right looks like: 1.10 before and after.
   - **Not tested:**
     - Some pipes are dropped only by checks that need the drawing open (display children, a rising-main continuation half). Those are still dropped by the window only.
     - The refresh now also skips pipes marked out of the schedule, as the window does. This is flagged in the PR for review.

2. **BUG-1150 (DATA LOSS): fixed in draft PR #1758, head `cb3245e4`.**
   - **What Tim will see:**
     1. A network pasted into a new drawing and saved without CDREPAIR now wakes Civil when the drawing is reopened.
     2. MOVE of a pit then takes its pipes, labels and cover text with it.
   - **How it works:**
     1. When a drawing opens and its job record is empty, CE now asks AutoCAD for the pit blocks and stops at the first pit it finds in model space.
     2. Nothing is written to the drawing.
     3. A drawing with no CE pit costs only a few block-table lookups.
   - **Switch:** `linking.civilWakesForPitsWithoutRecord`, ON.
   - **Tests:**
     - 11 new tests; 2 failed on the base (the two source guards).
     - The old `Bug203QuietRecordTests` "known gap" test was rewritten on purpose, because it pinned the hard-coded "no CE objects".
     - Civil net10 full run: 19,817 total, 19,795 passed, 22 skipped, 0 failed. This ran at 13:44, before the commit at 14:15.
     - The net48 builds (0 errors) ran on the committed code at 14:21.
   - **Real-AutoCAD check:**
     1. Copy a CE network and paste it into a new drawing saved as "Synthetic site A.dwg".
     2. Ignore the CDREPAIR advice. Save, close and reopen.
     3. MOVE pit P3 a short way. Right looks like: its pipes, labels and cover text follow.
     4. Open an ordinary non-CE drawing. Right looks like: it opens exactly as before, with no CE message.
   - **Not tested:**
     - The block lookup has been read in the code only: dynamic-block copies, a pit on a layout only, a pit inside an Xref.
     - A pit on a layout only is deliberately not counted.
     - A pasted pipe with no pit is not looked for.

3. **BUG-1198: fixed in draft PR #1764, head `c7da3e94`.**
   - **What Tim will see:** Export CSV or Export Excel, then Cancel, no longer makes CLOSE ask "Save changes?". An export that finishes no longer writes into the drawing either.
   - **Switch:** `linking.pitScheduleExportWritesNothing`, ON.
     - It has no Settings page row: a row pushed the Fixes tab past its agreed 670 px height.
     - Adding a row needs a layout decision.
   - **Tests:**
     - 6 new tests; 2 failed on the base.
     - Civil net10 full run: 19,812 total, 19,790 passed, 22 skipped, 0 failed.
     - The first full run had 2 failures: one was the fixer's own missing "Default: on." note, now fixed; the other was the flaky PDF loader test.
     - net48 builds: 0 errors.
   - **Real-AutoCAD check:**
     1. Open a saved drawing with one pit, run PITSCHEDULE and edit nothing.
     2. Click Export CSV, then Cancel. Do the same with Export Excel.
     3. Close the window and type CLOSE. Right looks like: no "Save changes?" question.
     4. Export a CSV and save it. Right looks like: the same rows as the window, and the drawing still unchanged.
     5. Change a pit's remarks, close the window and type CLOSE. Right looks like: it DOES ask to save, and the remark is in the saved drawing.
   - **Not tested:** the real window, the file chooser, the Excel file contents and the save prompt. The guards read the code of the two export buttons.

4. **BUG-1140: fixed in draft PR #1763, head `5645dd21`.**
   - **What Tim will see:**
     1. A pasted downpipe no longer takes the original's label at CDREPAIR, and no longer drags some unrelated object on MOVE.
     2. The pasted copy has no label until one is made.
   - **How it works:** a label is accepted only if it is text (a circle for the hitbox) and its owner note is blank, names this downpipe, or names nothing that still exists.
   - **Also changed:** CE's own COPY-with-label step now writes the copy's owner note just before the link is stored. The end result is the same as before.
   - **Switch:** `linking.sourceLabelOwnerCheck`, ON.
   - **Tests:**
     - 10 new tests; 3 failed on the base.
     - Civil net10 full run: 19,816 total, 19,793 passed, 22 skipped, **1 failed**. The failure is `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (the PDF loader, under load), unrelated to this fix. Its class passed 15 of 15 when run alone.
     - The full run was not repeated, so this PR has no clean 0-failed total.
     - net48 builds: 0 errors.
   - **Real-AutoCAD check:**
     1. Place DP1 with its label and MOVE it. Right looks like: the label follows.
     2. Ctrl+C and Ctrl+V DP1 (the downpipe only) to a clear spot, then run CDREPAIR.
     3. MOVE the original. Right looks like: its label follows.
     4. MOVE the copy. Right looks like: the original's label stays put.
     5. Paste a downpipe from another drawing and MOVE it. Right looks like: nothing else moves.
     6. In an old drawing whose labels have no owner note, MOVE a downpipe. Right looks like: the label follows.
     7. COPY a downpipe together with its label. Right looks like: the copy gets its own label and tag as before.
   - **Not tested:**
     - The MOVE trigger is confirmed from the code only.
     - The COPY-with-label change is covered by a source-order guard only.

5. **BUG-1145: fixed in draft PR #1765, head `a5775b64`.**
   - **What Tim will see:** a schedule on a sheet stays CURRENT after an ignored CDCHECKS finding, a saved CDCALC draft or a rainfall-curve change in the stage drawing. It still goes OUT OF DATE when a pit, pipe, manual row, outlet override or row order changes.
   - **How it works:**
     1. Each schedule source carries a second fingerprint (a check value) covering only what the schedule draws, next to the old one for the whole job record.
     2. A schedule placed on an older build has no new check value. It is compared the old way until it is next placed or refreshed, so no sheet flips to OUT OF DATE after the update.
   - **Switch:** `linking.pitScheduleFingerprintScopedToSchedule`, ON.
   - **Tests:**
     - 23 new tests; 8 failed with the new comparison turned off.
     - Civil net10 full run: 19,829 total, 19,807 passed, 22 skipped, 0 failed.
     - net48 builds: 0 errors.
   - **Real-AutoCAD check:**
     1. Use a stage drawing Xref'd into a sheet with a placed Pit Schedule, and save both.
     2. In the stage drawing, ignore one CDCHECKS finding and save.
     3. Reload the Xref on the sheet. Right looks like: CURRENT, and no Project QA schedule fail.
     4. In the stage drawing, change a pit from 900 to 1200 and save. Reload. Right looks like: OUT OF DATE, naming the stage drawing.
     5. Open a sheet whose schedule was placed on 3.0.73. Right looks like: CURRENT when nothing changed.
   - **Not tested:**
     - Nothing was opened in AutoCAD, including the upgrade case.
     - A separate Project QA check, `ProjectQaOutputCurrencyPolicy`, still compares the whole-record revision on purpose (profiles depend on it). It may still note a revision difference after an ignored finding. That remainder is not fixed.

6. **BUG-1149: fixed in draft PR #1767, head `b275abd7`.**
   - **What Tim will see:**
     1. After BIND of the stage Xref, the schedule no longer shows a permanent SOURCE MISSING with a QA Fail.
     2. It now reads SOURCE NOT FOUND: "If you bound the Xref, the schedule is frozen as placed."
     3. QA shows the same sentence as a warning (Unknown).
     4. The placed schedule is never rewritten.
   - **Switch:** `linking.pitScheduleBoundSourceFrozen`, ON.
   - **Tests:**
     - 10 new tests; 4 failed on the base stub.
     - Civil net10 full run: 19,816 total, 19,794 passed, 22 skipped, 0 failed.
     - net48 builds: 0 errors.
   - **Real-AutoCAD check:**
     1. Open a sheet with a CE Xref and a placed linked Pit Schedule. Right looks like: CURRENT.
     2. Run XREF, then Bind (try both Bind and Insert), and save.
     3. Run PITSCHEDULE. Right looks like: SOURCE NOT FOUND with the "frozen as placed" sentence, the schedule unchanged, and no Update offered.
     4. Run project QA. Right looks like: a warning, not a Fail.
     5. In a copy, rename the Xref file on disk instead of binding, then reload. Right looks like: still SOURCE MISSING and a Fail.
   - **Points for review:**
     1. This is a judgement call, flagged for Opus and Tim: the code cannot tell a BIND from an accidental detach, so both now warn instead of failing.
     2. "Unknown" still counts as "not proven" in the project QA gate.
     3. It overlaps #1765 in `PitScheduleStatusService.cs`. The change is small and local.
   - **Not tested:** what AutoCAD's Xref list holds after BIND was not observed (RULES 12.5).

7. **BUG-540: skipped, already fixed on the base.**
   - **Checked by:** reading the code myself.
   - **Where:** the Pit Schedule window, the after-command refresh (`ScheduleLinkService.cs` lines 2932 and 2965) and the pit advice (`PitSetupAdvisorService.cs` line 71) all read the Settings step-iron depth through `PitScheduleDepthRule`.
   - **Old draft:** PR #1192 was rightly rejected as a second copy of that rule (Opus round 11, superseded by #914).
   - **Remaining problem:** the leftover wrong depth on a pit with two outlets is BUG-1196, fixed in #1760 above.

8. **BUG-1049: skipped, a real fix already exists in draft PR #1743.**
   - **PR:** branch `fb/b7-bug1049-batch-blank-field`, head `7afad0d4`, based on rel-20261023m.
   - **Action:** I commented on #1743. It needs review and a train.

9. **BUG-1148: skipped, needs Tim's design word.**
   - **The carpark's suggested fix cannot work:**
     1. After Save As, the sister drawing's pits carry the same identity.
     2. AutoCAD's copy map says "from another drawing" for every paste, even within one drawing, because a paste goes through the clipboard drawing.
     3. Nothing stored on a pit says which drawing made it.
   - **Options:**
     - **(1) Recommended:** stamp each pit with a "made in this drawing" token that Save As re-issues. This is exact, but it is a new identity scheme and needs a workflow card.
     - **(2)** Treat a paste as foreign when its own values differ from the local pit's. This is cheaper, and it needs Tim's tolerances.
     - **(3)** A "[CE]" warning line only.
     - **(4)** Leave it as a known limit.
   - **Branch:** an empty local branch `fb/pc2-BUG-1148-sister-paste-keeps-source` (no commits) is kept.

10. **BUG-857: skipped, needs Tim's call.**
    - **The open question:** in the Grade mismatch box, should the corner X cancel the pipe, or should the box say what X does? The carpark records this as a window-behaviour question for Tim.
    - **Last seen:** still happening at Codex W4-02 on 3.0.70.

11. **BUG-685: skipped, needs Tim's ruling.**
    - **The conflict:** two of Tim's rules disagree. "A typed level is never moved" against "inverts to 2 dp, nearest 10 mm".
    - **Example:** a typed 10.125 becomes 10.13. The carpark says do not change it before his ruling.

12. **BUG-855: skipped, cause not pinned from the code.**
    - **Best candidate:** the first CDSYNC creates a stored record for a pipe that was drawn but never recorded (the P8 open-end pipe). The schedule's check then counts that pipe's blank invert or its non-pit end name for the first time. That would be a real issue, not a defect.
    - **Where:** `LinkService.RepairAudit.Linking.cs` line 191, and `MergeMissingEntitiesFromDrawing` in `ProjectDataService.cs`.
    - **Runner case to settle it:**
      1. On a copy with P8 and its open-end pipe, run PITSCHEDULE, open the "Drawing check" details and save the text.
      2. Run CDSYNC.
      3. Run PITSCHEDULE again and save the same details.
      4. Compare the two by kind and row. The new row names the cause.
      5. Check the CE log for "Merged missing drawing entities into project data: pits=N, pipes=N".
    - **Recommendation:** if the new row is legitimate, record BUG-855 as by design, and have the robot compare the row lists rather than the bare count.

13. **BUG-587: skipped, needs Tim's design word.**
    - **Cause:** every drawn schedule row is a fixed 750 drawing units tall (`PitScheduleContinuationLayout.cs` line 25). The remarks cell holds about two lines, so a third line crosses the divider. The same 750 sets the template block stretch and the continuation-sheet offsets.
    - **PR #1286:** it does not touch the row height.
    - **Options:**
      - **(A)** Widen the remarks column.
      - **(B)** Make every row taller, e.g. 1000. This is the smallest change but makes every schedule longer.
      - **(C) Recommended:** a row grows only when its remark needs more than 2 lines. Ordinary rows stay 750, so existing schedules do not move. It would ship behind a switch, ON. Tim must first say that variable row heights are fine for the office template.
      - **(D)** Smaller text. Not recommended, because it breaks his "readable text" requirement.

### What this batch did NOT test (RULES 5.9)

1. **AutoCAD:** none of the six fixes has been opened in AutoCAD by anyone, and no runner case was written.
2. **Window looks:** no window or drawn schedule was looked at.
3. **Settings page:** none of the six switches has a Settings page row; each is a settings-file key, as `keepUnreadableDrawingRecord` is. The rows are owed to the Codex window lane.
4. **Cross-PR merge:** the six PRs were not merged with each other. #1765 and #1767 both edit `PitScheduleStatusService.cs`, and #1760 and #1764 both touch the Pit Schedule area. A train assembly must dry-run them together.
5. **Manager and Structural:** these suites were not run, since no file there changed.
6. **net48 tests:** the net48 test lanes were compiled (0 errors) but not run; they do not load on this PC.

### Process notes

1. **Build lock:** while waiting in a long queue, the BUG-1150 fixer deleted `C:\CE_PLAN\desk_jobs\build.lock`. It judged the lock stale: an empty file, 11 minutes old, with no dotnet running. If another job lost its lock around 13:20 to 13:30, that is the cause. The brief was then tightened: never delete a lock you do not hold.
2. **Main checkout:** untracked items appeared in `C:\Lisp Files\CE_ACAD_PLUGIN` during the run: `.codex/`, `tmp/`, `Modules/Structural.Tests/Models/BracingLengthSettingsTests.cs`, `release-v3-colleagues-TEAMLANE4_LOG.md` and an oddly named folder. None came from this job. They are not removed.
3. **Clean-up:** all pc2 worktrees are removed and the pushed branches are kept. Two empty local branches (BUG-1148, BUG-587) are kept (D6). Scratch is in `C:\ce-fx\pc2` (brief, helper, logs, PR bodies).
4. **Disk:** C: free space went from 21 GB at the start to 17 GB at 15:22. The helper checks it before every build.
