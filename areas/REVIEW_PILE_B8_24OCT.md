# Opus review of the best unreviewed PRs, batch 8 (Sat 24 Oct 2026, about 05:15 to 05:35 Melbourne)

Headless job from desk plan/03 (Team, Opus 5.5). Input: `C:\CE_PLAN\areas\PR_PILE_TRIAGE_2026-10-24.md`, class E items 79 to 90 (counted within class E only).

I read the code at each PR's exact head, fetched into my own bare copy `C:\ce-tr\b8.git` (heads re-checked against GitHub at 05:24; none had moved). I compared each one with the installed lines: Structural 1.0.122 (`claude/rel-20261023s` @ e6d597c0) and Civil 3.0.72 (`claude/rel-20261023m` @ f7f7d551), and with the assembled C-63 train (`claude/rel-20261024m` @ 28987b73) and the S-43 list (#1695 to #1699), using in-memory trial merges. Read-only: nothing built, tested, merged, installed or pushed to a PR branch. AutoCAD and Codex were not started.

## ANSWER FIRST

1. **Counts (12 PRs in the slot, 11 reviewed):**
   1. **MERGE:** 8 (#1574, #1575, #1577, #1580, #1581, #1582, #1583, #1585).
   2. **MERGE-WITH-FIXES:** 3 (#1584, #1587, #1579).
   3. **HOLD:** 0. **REJECT:** 0.
   4. **Skipped, already has an Opus review:** #1578 (BUG-1012), reviewed in `REVIEW_PILE_B1_24OCT.md` item 8.
   5. **#1577 was reviewed here.** `REVIEW_CODEX_LF_A_23OCT.md` only names it under "Not checked", so it had no Opus review.

2. **Top faults found:**
   1. **#1584 (Sheets "Save sheet list") fixes the old window, not the one CESHEETS opens.** The fix is on the classic window's "Save sheet list" button (palette and CESHEETSCLASSIC). CESHEETS opens the newer CE Sheets window. Its own **Save** button still records "scanned just now". Example: a colleague adds layout S05 to a drawing, you change one sheet title in CESHEETS and click Save. The window then says the list matches the drawings, and S05 stays out of the list and out of issuing.
   2. **#1579 (CEMARKUPUNDO) claims more than it does.** The real fix works: CE now refuses to undo in drawing B a markup step that was run in drawing A. But the comment and test say the step "is only taken off the history once AutoCAD has undone it". That is not true. CE only queues the U and carries on. It has not run yet when CE takes the step off its list. Only the wording needs to change.
   3. **#1587 (CSREOBAR on a layout) clashes with #1581 (CSREOBAR at two heights).** Both add a new rule at the same spot in the reo bar rules file. Keep both. The clash is small and needs no other change.
   4. **#1577 (hatch audit) only fixes the default setting.** With "Follow any drawing scale" ON (the default), DIMSCALE 50 with LTSCALE 1 now leaves a correct 1:50 hatch alone and says why. With that switch OFF, the audit still falls back to the 1:20 scale, as it did before. That is the switch's stated "as before" behaviour, so it does not block the merge.

3. **Safe to merge today:**
   1. **Structural, into S-44 (after S-43), in this order:** #1574, #1575, #1577, #1582, #1585, #1581. Then #1587 (keep both rules in `ReoBarCore.cs`), #1584 and #1579 once their fixes are pushed.
   2. **Civil, into C-64 (after C-63, after the C-64 lists from batches 1 and 2):** #1580, #1583.

4. **Rules checks across the batch:**
   1. **Redo (nothing writes between a U and its REDO):** no PR adds a drawing write after a U. #1579 still saves the markup plan list (a side file, not the drawing) after it queues the U. That is the same as before.
   2. **Locked layers, Xrefs, REFEDIT:** no bypass. #1585 puts a picked line back on its own layer. It never unlocks anything, and its test checks that. #1574 makes the sheet update freeze fewer Xref layers, never more.
   3. **Switches:** none of the 11 adds a bug-fix switch. That matches the carpark, which says "no switch" for each one. #1577 uses the existing "Follow any drawing scale" switch, which starts ON.
   4. **CE_SHARED, installer, signed-update files:** none touched. Every file is under `Modules/Structural`, `Modules/Drainage`, their test folders, or `REGRESSION_LOG.md`.
   5. **Hard-coded engineering values:** none new. #1575 uses a 0.01 drawing-unit gap between an arc and its short straight pieces. That is a drawing tolerance, not an engineering value. #1577's message repeats the office rule "LTSCALE = 10 x DIMSCALE", which CEHATCH already prints.
   6. **Hard blocks:** none new. #1579 and #1585 add refusals that leave the drawing as it was. Neither is a hard block.
   7. **C-63 and S-43:** no PR touches a file that C-63 or S-43 changes. All 11 clash only on `REGRESSION_LOG.md` (the usual clash: keep both entries).

## One item per PR

1. **#1574 BUG-983 (Structural): the sheet update freezes only the title Xref's own layers.** Head f41f68dd, base `claude/rel-20261022s2`.
   1. **Cause real?** Yes. `CeSheetsSyncService.IsTitleXrefLayerMatch` (installed line 2222) matched a layer when its Xref name was equal to the title Xref name, contained it, or was inside it. So with title Xref TITLE, the layers of an unrelated Xref TITLE_DETAIL were frozen too, and its linework disappeared.
   2. **Fix does only what it says?** Yes. One line: only an exact name match counts (spaces, dashes and underscores still ignored). The names come from the title Xref's own name and its file name, so the real title Xref still matches.
   3. **Test fails without it?** Yes. The method was private before, so the new tests would not even compile. The "TITLE vs CEA3TITLESHEET" case would return the wrong answer on the old code.
   4. **Risk:** an office that attached its title sheet under a changed name (for example TB-A1 attached as TB-A1(2)) used to be caught by the "contains" match and now will not be. CE's own title Xref names come from the Xref itself, so this should not happen on CE sheets. Worth one check in AutoCAD.
   5. **Verdict: MERGE, train S-44.**

2. **#1575 BUG-985 (Structural): BEXTEND follows an arc segment of the boundary.** Head bd37c02a.
   1. **Cause real?** Yes. The boundary reader added each polyline segment as one straight line between its two ends and ignored the bulge (the arc). A beam extended to a curved wall stopped on that straight line, up to the full arc depth short.
   2. **Fix does only what it says?** Yes. Each arc segment is now read as a run of short straight pieces along the arc, each within 0.01 drawing units of the true curve. I checked the arc-centre maths by hand for the carpark case (bulge 1 from 5000,-2000 to 5000,2000): it turns through 7000,0, which is correct. A polyline tilted out of plan keeps the old straight-line reading. The beam-extending code itself is unchanged. It was only moved into a separate method so it can be tested.
   3. **Test fails without it?** Yes. The carpark case (beam end at 7000,0) and an arc bulging the other way are tested, plus checks that every point lies on the true arc. The new methods did not exist before.
   4. **Pinned file fingerprint:** re-pinned in `Stage3ConnectedDesignBoundaryTests` with a dated note. `BeamExtendCommands.cs` has not changed between the PR's base and installed 1.0.122, so the new pin still holds.
   5. **Verdict: MERGE, train S-44.**

3. **#1577 BUG-881 (Structural): CEHATCHAUDIT Repair keeps a hatch's scale when DIMSCALE and LTSCALE disagree.** Head 8564a300.
   1. **Cause real?** Yes. `AuditScale` (installed line 584) falls back to the 1:20 value when the scale pair is not usable. Repair then "repaired" a correct 1:50 hatch back to 20.
   2. **Fix does only what it says?** Yes. When the pair is not usable and "Follow any drawing scale" is ON, the audit expects the hatch's own scale, so it changes nothing. It also prints one line: "DIMSCALE and LTSCALE do not match, so the pattern scale of N hatch(es) was not checked and no scale was changed."
   3. **Test fails without it?** Yes. The new `AuditScaleIfUsable` rule did not exist before. The tests cover 50/1, a mixed pair, the office pairs and switch OFF.
   4. **Small leftovers (not blocking):**
      1. With the switch OFF, the old fallback stays. This is intended.
      2. Choosing the nearest preset still uses the 1:20 fallback scale. On a layer with two presets of the same pattern, the wrong one could be picked. The scale it then expects is still the hatch's own, so nothing is rescaled.
   5. **Merges cleanly** with the installed command-outcome lines added to the same file.
   6. **Verdict: MERGE, train S-44.**

4. **#1579 BUG-984 (Structural): CEMARKUPUNDO only undoes a step in the drawing it was run in.** Head d7299d1e.
   1. **Cause real?** Yes. `UndoLastGroup` took the last batch off CE's list and sent U to whichever drawing was active. A batch run in A and undone from B cost B its last step, left A's note, and marked A's batch as undone.
   2. **Fix does what it says?** The main part, yes. Each batch now records its drawing. CEMARKUPUNDO refuses in any other drawing ("The last markup step was run in A.dwg. Switch to that drawing and run CEMARKUPUNDO there. Nothing was undone."). Older batches with no drawing recorded are not refused.
   3. **Claim that is not true:** the comment, the test name and the log say the batch "is only taken off the history once AutoCAD has undone it". `MarkupAIExecutionService.UndoLastGroup` queues `_.U` (it sends it to the command line) and returns at once. So CE takes the batch off its list before the U has run. Moving the line was harmless, but the claim is wrong.
   4. **Test fails without it?** Yes for the drawing check (the method is new). The order check only looks at the order of the lines in the source.
   5. **Not covered (outside this bug):** if you draw something in A after the markup run, CEMARKUPUNDO in A still undoes your drawing, not the markup. That is a separate bug if Tim wants it fixed.
   6. **Verdict: MERGE-WITH-FIXES, train S-44.** Exact fix: reword the code comment, the test name and the REGRESSION_LOG line to say "taken off the history after the U is sent (U runs when the command ends)". No code change needed.

5. **#1580 BUG-1010 (Civil): "Click to count that time" adds the break once, not twice.** Head b3ee3ea3, base `claude/rel-20261022m`.
   1. **Cause real?** Yes. In `JobTimeTracker.OnIdleStateChanged` the break is measured from your last activity (6 min), but the timer kept counting until the idle limit paused it (5 min). Accepting the offer added all 6 minutes on top, so 11 in total.
   2. **Fix does only what it says?** Yes. The toast now offers back only the time from the pause to your return (1 min), never more than the break, never negative. With no pause time known it offers the whole break, as before. The billing question (should the first 5 idle minutes count at all) is left for Tim, as the carpark says.
   3. **Test fails without it?** Yes. The new rule did not exist. The session test shows 360 s tracked, not 660.
   4. **Small leftover (not blocking, existing before):** the idle figure in the time-log file still records the full 6 minutes as idle, while 5 of them are also counted as worked. After accepting, it shows 5 minutes idle instead of 0. A one-line follow-up: record the same offered amount as idle.
   5. **Verdict: MERGE, train C-64.**

6. **#1581 BUG-986 (Structural): CSREOBAR preview, note and schedule agree for picks at different heights.** Head a99df168.
   1. **Cause real?** Yes. The preview measured the sloping distance between the picks (5000 for 0,0,0 to 3000,0,4000). The bar is drawn as a flat polyline at the first pick's height, so the note and the schedule said 3000.
   2. **Fix does only what it says?** Yes. The second pick is taken to the first pick's height before anything is measured. So the preview, note, drawn bar and schedule all say 3000. One plain line tells you it measured along the plan. It warns, it never blocks. This matches the carpark's "stated plan-length rule with matching preview".
   3. **Test fails without it?** Partly. The wording rule is new, so its test fails without the fix. The order check only reads the source. An AutoCAD check is owed.
   4. **Verdict: MERGE, train S-44.** It clashes with #1587 (see item 11).

7. **#1582 BUG-1016 (Structural): saving checklist templates keeps the waiting suggestions.** Head 555bd7ef.
   1. **Cause real?** Yes. `SaveAllTemplates` deleted every `*.json` in the Templates folder. That included `pending_changes.json`, where colleagues' suggestions wait (installed lines 1328, 1366, 1392 and 1438 all read that file from the same folder).
   2. **Fix does only what it says?** Yes. That one file is skipped. Old template files are still replaced.
   3. **Test fails without it?** Yes. A real temporary folder is used, and the suggestions file would be deleted on the old code.
   4. **Tidy-up (not blocking):** the new file-name constant is not used by the four existing readers, which still spell out the name.
   5. **Verdict: MERGE, train S-44.**

8. **#1583 BUG-993 (Civil): CDCHECK adds a FALL symbol's own rotation to its arrow direction.** Head 0fd88b48.
   1. **Cause real?** Yes. `FallArrowDirectionReviewService` read the arrow from the block's Angle1 and Flip State only. A FALL symbol turned 180 degrees with ROTATE was still seen as aimed at its pit.
   2. **Fix does only what it says?** Yes. The block's rotation is added. With rotation 0 the answer is exactly as before, and a test proves it. Every CE route that places a FALL symbol (CDFALL, CDSLAB, the fall suggestion, the pit insertion) places it at rotation 0. So CE's own symbols are not counted twice.
   3. **Test fails without it?** Yes. The carpark case (rotated half a turn) is tested, and the new method did not exist before.
   4. **Not covered:** a FALL symbol flipped with MIRROR (negative X scale) is still read the wrong way round. That is a separate, smaller case.
   5. **Verdict: MERGE, train C-64.**

9. **#1584 BUG-1013 (Structural): "Save sheet list" no longer hides changes since the last scan.** Head b1ea7a87.
   1. **Cause real?** Yes. `CeSheetsManifestService.Save` always set "last scanned" to now. `IsStale` compares each drawing's saved time with that, so a drawing changed after the real scan looked up to date.
   2. **Fix does what it says?** For one window only. `Save` gains a "record a scan" option that defaults to yes, so the scan and CE's drawing writes behave as before. Only the classic window's "Save sheet list" button (`CeSheetsManagerWindow`, opened from the palette and CESHEETSCLASSIC) passes "no".
   3. **Missed button:** CESHEETS (and CESHEETSMANAGER) open `CeSheetsWindow`. Its "Save" button (`BtnSave_Click`, installed `CeSheetsWindow.xaml.cs` about line 736) only saves your edits, yet still records "scanned now". The carpark names both windows.
   4. **Test fails without it?** Yes for the service (the option is new). The window check reads source.
   5. **Verdict: MERGE-WITH-FIXES, train S-44.** Exact fix:
      1. In `CeSheetsWindow.xaml.cs` `BtnSave_Click`, change `CeSheetsManifestService.Save(_manifest);` to `CeSheetsManifestService.Save(_manifest, stampScanned: false);`.
      2. Add the same source check for that button to `CeSheetsManifestSaveStaleTests`.
      3. Optional: the classic window's "Map title block" save (about line 1039) only saves mapping edits too.

10. **#1585 BUG-1015 (Structural): a refused RIB or REB leaves the line as it was.** Head 5a8feaec.
    1. **Cause real?** Yes. `ExecuteCreatePathElement` moved your picked line onto the footing layer (or drew a new line) before it checked for a slab. When the check failed it said "No slab perimeter contains the selected point" and left the change in the drawing.
    2. **Fix does only what it says?** Yes. The picked line's layer is remembered before it is moved. Both refusal exits after the pick (no slab, no foundation system) put it back, or erase the line CE drew. Nothing is unlocked. I checked that there is no other early exit after the pick.
    3. **Approach:** the carpark asked to check first, then change. This PR changes and then puts back. You see the same result in the drawing, and it stays inside the same command, so one U still covers it. Acceptable.
    4. **Test fails without it?** Yes, but the tests only read the source. They cannot open a drawing. The carpark test (line on AUDIT-CENTRELINE stays there after the refusal) is owed in AutoCAD.
    5. **Verdict: MERGE, train S-44.**

11. **#1587 BUG-1025 (Structural): CSREOBAR lengths on a layout are in millimetres as drawn.** Head b8026c89.
    1. **Cause real?** Yes. Placing and refreshing a bar converted its length with the drawing's model units (INSUNITS). In a metre drawing, a 100 mm bar on a layout read "100000".
    2. **Fix does only what it says?** Yes. A bar on a layout uses 1 unit = 1 mm. A bar in model space (including one drawn through a layout viewport) is converted as before. This is the same rule the footing schedule already uses (`onLayout ? 1.0 : ...`), and `ReoBarService.cs` is already on the allowed list for reading units.
    3. **Test fails without it?** Yes. The new rule did not exist, and the source check makes sure the old model-units read is gone.
    4. **Clash with #1581:** both add a rule at the same spot in `Core/Rebar/ReoBarCore.cs`. Keep both. `ReoBarService.cs` merges on its own, and #1581's source check still finds its line.
    5. **Small leftover:** the schedule refresh still prints "This drawing's units are metres..." even when every bar is on a layout.
    6. **Verdict: MERGE-WITH-FIXES, train S-44, after #1581.** The only fix is to rebase it on #1581, keeping both new rules.

## What I did NOT check

1. **No build and no test run.** About 35 build and test processes from other jobs and an AutoCAD session were running, so I relied on reading the code and on in-memory trial merges. Nobody has compiled any of the 11 PRs on top of 1.0.122 or C-63 in this review. The PR authors' own test claims were not re-run.
2. **Nothing was opened in AutoCAD.** Owed AutoCAD checks:
   1. **#1585:** RIB refused with no slab, line keeps its layer.
   2. **#1581 and #1587:** a bar picked at two heights, and a bar on a metre-drawing layout.
   3. **#1575:** a beam extended to a polyline arc.
   4. **#1574:** a title Xref beside an Xref with a similar name.
3. **net48 build:** not checked for any PR.
4. **The source-text tests** (#1575, #1577, #1579, #1581, #1584, #1585, #1587) only prove that a line is in the file, not what AutoCAD does.
5. **#1578** was skipped: it already has an Opus review in batch 1.
6. **Train order inside S-44** against the earlier S-44 list (#1142, #1212) was not trial-merged. Only the clashes with installed 1.0.122, S-43 and with each other were checked.
