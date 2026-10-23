# Opus review of fix wave 2, batches 1 to 3 (23 Oct 2026)

Fri 23 Oct, early afternoon (Melbourne). Opus 5.5 (claude-opus-5-5), read only: git and gh reads, `git merge-tree` dry runs (objects only, no refs), no build, no test run, no AutoCAD, no Codex, no PR comment or merge. Method as `REVIEW_CODEX_PRS_A_2026-10-23.md`. I read every diff myself and the code around it, not just the batch reports.

**Inputs:** `release-v3-colleagues-FIX_WAVE2_BATCH1_REPORT.md`, `..._BATCH2_REPORT.md`, `..._BATCH3_REPORT.md`, `FINDINGS_LEDGER_22OCT.md` (F-004 to F-161), carpark BUG-874 to BUG-971.

**Heads:** every PR head below equals the head in its batch report. Every PR is a DRAFT, open, one commit on its base.

**Base correction (check before you trust the brief):** the brief says the installed Civil is 3.0.70. It is not. The live bundle DLLs read just now: Civil `3.0.71+88bd62f7`, Manager `1.1.71+88bd62f7`. That is C-61, `claude/rel-20261023l` @ 88bd62f7. All 14 PRs were built on C-60 (`claude/rel-20261022m` @ 40ee0a36). Each one merges onto C-61 with only a REGRESSION_LOG.md clash (dry run). But C-61 brought in #1536's settings census, and that census will fail on five of these PRs (see the switch PRs). Structural S-42 is `claude/rel-20261023s` @ e6d597c0. None of these PRs touches Structural.

## ANSWER FIRST

1. **#1552 BUG-966 CDSPOON ByLayer (04fae248):** MERGE. 0 HIGH, 1 MEDIUM, 1 LOW. The same fault is in CDRG (raingarden). It is not fixed here.
2. **#1553 BUG-967 Blue Factor garden and lawn (39ca847c):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW. One note now contradicts the new one.
3. **#1555 BUG-964 redesign pit level (ed39ede2):** HOLD. 0 HIGH, 1 MEDIUM, 2 LOW. The fix is right, but it sits on #1537, which is on HOLD.
4. **#1556 BUG-970 CDTWL two schedule sets (2fb1ff7c):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW. With plain-number pit marks, row 2 cannot be picked.
5. **#1557 BUG-876 Replace keeps the old pit (73bc8264):** MERGE. 0 HIGH, 0 MEDIUM, 2 LOW.
6. **#1558 BUG-877 import review file change (91d8c39d):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW.
7. **#1562 BUG-874 Esc keeps the CD callout link (cda22fb9):** MERGE-WITH-FIXES. 0 HIGH, 2 MEDIUM, 2 LOW. I confirm the redo-safety design. AutoCAD proof is still owed.
8. **#1567 BUG-963 CDPROPAGATE single IL text (14006793):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 2 LOW.
9. **#1570 BUG-965 Refresh twin and trench text (c732d63e):** MERGE-WITH-FIXES. 0 HIGH, 1 MEDIUM, 1 LOW.
10. **#1576 BUG-971 unreadable record kept (bae50a7b):** HOLD. 1 HIGH, 2 MEDIUM, 1 LOW. About ten other routes still save over the record.
11. **#1586 BUG-878 named level outranks the shortcut (fca3e025):** MERGE. 0 HIGH, 0 MEDIUM, 1 LOW.
12. **#1591 BUG-968 CDRENUMBER loop guard (ffd8e500):** MERGE. 0 HIGH, 0 MEDIUM, 2 LOW.
13. **#1594 BUG-946 CEHEALTH not loaded (fc12426c):** MERGE. 0 HIGH, 0 MEDIUM, 1 LOW.
14. **#1595 BUG-948 Updates button for a colleague (a388870b):** MERGE. 0 HIGH, 0 MEDIUM, 2 LOW.
15. **BUG-885 (installer seal):** no PR. The skip was right: it needs Tim's word (Monday batch). I agree with the recommended option 1 ("seal only" mode in the existing script).
16. **Totals:** 14 PRs. 6 MERGE, 6 MERGE-WITH-FIXES, 2 HOLD, 0 REJECT. HIGH 1, MEDIUM 11, LOW 23.
17. **Train:** all 14 go to **C-62** (Civil + Manager), cut from C-61 @ 88bd62f7. **S-43:** none of them. Manager must ship in C-62 (#1594 and #1595). No PR touches `Shared/`, so CE_SHARED stays byte-identical.
18. **One fix needed in five PRs:** #1558, #1562, #1567, #1570 and #1576 each add a switch whose note has no "Default:" line. On C-61, `NewSettingsKeys_NeedADocumentedDefault` then fails. Fix: add `/// Default: on.` to each.
19. **New finding, not filed:** CDRG has the same ByLayer readback fault as CDSPOON. From the code, every raingarden placement is rolled back on 3.0.70 and 3.0.71. Details under "Also seen".

---

## 1. #1552 @ 04fae248: MERGE, 0 HIGH, 1 MEDIUM, 1 LOW

1. **What it says:** CDSPOON drew the spoon ByLayer, but its own check afterwards wanted colour 2 and 35. So every spoon was rolled back.
2. **What the diff does (checked):**
   1. Both colour comparisons in `RequireSpoonGeometry` now accept only ByLayer (256), through one helper.
   2. I checked the writer: both the boundary and the hatch are written `ColorIndex = ByLayerColourIndex` (`SlabService.cs` 2264 and 2279).
   3. The layer, location, normal, associativity and SOLID checks are unchanged.
3. **What Tim will see:** CDSPOON leaves a closed outline and a solid hatch on the spoon layers. One U removes both. Before, nothing stayed and the command line said "failed exact readback".
4. **Defaults / Settings:** no switch. That is correct, because the old check could never pass.
5. **Redo-safe / locked layers / Xrefs:** only the after-check changed. The locked-layer and Xref refusals are untouched.
6. **Tests:** two new tests, one on the helper and one source pin. The pin fails on the old code. Neither test drives the readback itself (LOW).
7. **MEDIUM, the same fault in CDRG:**
   1. Card 5.3 (commit 8f743e93) made the raingarden outline and hatch ByLayer in the same commit.
   2. But `RaingardenPlacementPlan.RequireExactAuthoredAppearance` still wants colours 3 and 113. Its callers are `SourcePlacementService.cs` 658 and 783, inside the verify step.
   3. So from the code, every CDRG placement throws "The raingarden boundary or hatch appearance changed during placement." and is aborted. C-61 still has this.
   4. `RaingardenAtomicPlacementTests` 196 to 203 still feed it 3 and 113, so the test encodes the stale expectation.
   5. **Fix:** the same one-line change (accept ByLayer), plus that test changed to 256. Do it in this PR before C-62, or as its own Codex fix. Either way, carpark it.
8. **LOW:** no test exercises `RequireSpoonGeometry` with a real ByLayer entity. The AutoCAD check below covers that.
9. **Clashes:** REGRESSION_LOG.md only.
10. **Deterministic AutoCAD check (runner / Codex, copy of a fresh mm drawing):**
    1. Type `CDSPOON`, pick 10000,10000 / 12000,10000 / 12000,11000 / 10000,11000, then Close.
    2. **Expect:** the command line says "CDSPOON complete". `LIST` on the outline shows layer SLAB PERIMETER and Color BYLAYER, and on the hatch shows SOLID and Color BYLAYER.
    3. Press `U` once. **Expect:** both are gone.
    4. If the CDRG fix is included: `CDRG` with a 4 x 2 m outline. **Expect:** the outline and hatch stay, and there is no "appearance changed" message.

## 2. #1553 @ 39ca847c: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** CDDESIGN's rating-report offer counted garden and lawn as roof and paved.
2. **What the diff does (checked):**
   1. A "Garden" or "Lawn" catchment line is now kept out of the rows. It is counted once by name and listed in a note.
   2. "Other" is still counted, and a note says so. Leaving that to Tim is right; it goes in the Monday batch.
3. **What Tim will see:** the 1000 m2 example (400 roof, 100 drive, 300 garden, 200 lawn) is offered as "Roof and paved area 500 m2". A note reads "Garden and lawn (500 m2) are treated as pervious, not as roof or paved."
4. **Defaults / Settings:** no switch. The old total was simply wrong. The offer can still be declined or typed over.
5. **Redo / layers:** none (a pure reader).
6. **Tests:** two tests, both red on the old reader. They use the ledger's own fixture.
7. **MEDIUM, a contradictory note:**
   1. `AddNotes` still says "The catchments total 500 m2 against a site of 1000 m2, so 500 m2 is not in any catchment." The 500 m2 *is* in catchments: the garden and lawn ones.
   2. A drafter reading both notes in CDDESIGN gets two different stories about the same 500 m2.
   3. **Fix:** in the not-in-any-catchment note, compare the site with `TotalImperviousM2 + perviousListedM2`, and print it only when that sum is short of the site area. Add one assertion to `Bug967_GardenAndLawnAreNotRoofAndPaved` that this note is absent.
8. **LOW:** a report that lists only garden and lawn now says "No catchments could be read". Better: "No roof or paved catchments were found".
9. **LOW:** how to treat "Other" is still Tim's open question. Keep the note until he answers.
10. **Clashes:** REGRESSION_LOG.md only.
11. **Deterministic AutoCAD check:**
    1. Put a text copy of the 4-line fixture report in a test job folder.
    2. On a copy drawing in that job, run `CDDESIGN` and answer Yes to the folder search.
    3. **Expect:** "Roof and paved area 500", the garden-and-lawn note, and no "not in any catchment" line (after the fix).

## 3. #1555 @ ed39ede2: HOLD, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** the network redesign stored each pit's level as the far end of its outgoing pipe. So the incoming pipe arrived below the outlet.
2. **What the diff does (checked):**
   1. Step 4 of `NetworkDesignService.Design` now stores the outgoing pipe's upstream level. The output check now compares a pit with the start of its outgoing pipe.
   2. I walked the outfall-first loop:
      1. Pipe U to D ends at `pitInvert[D] + drop` (or at the outfall level).
      2. It rises by length divided by grade.
      3. `pitInvert[U]` is now that upstream end.
   3. That matches the ledger test (B 10.200, A to B arriving at 10.230).
   4. The apply ticket writes `pit.InvertLevel = ProposedInvertM`. A pit's level is therefore its outlet invert, which is also what C-61's pit-floor depth (#1531) reads. That is consistent.
3. **What Tim will see:** in a redesign preview, upstream inverts come out higher and pits shallower than on C-60. The four design pictures moved by 40 to 490 mm. One test pit (PIT_B) now shows a 0 mm cover warning where it showed 100 mm. That warning is honest; the old design buried pipes below their own pits.
4. **Defaults:** no switch. Correct, because no old behaviour is worth keeping.
5. **Redo / layers:** levels only. Apply is unchanged.
6. **Tests:**
   1. One new chain test, red on the old code.
   2. Four picture files re-recorded. I read the differences: only inverts, depths and the cover note moved.
   3. The fixed-level test now uses the solved level instead of `1`. That is correct under the new rule, and it still proves a matching fixed level completes.
7. **MEDIUM, the base:**
   1. This is stacked on #1537, which group B put on HOLD ("final head never built or tested").
   2. This PR's own run had 12 failures, all of them #1537's.
   3. **It cannot go to C-62 unless #1537 goes too.** Merge order: #1537 (after its validation), then this PR.
8. **LOW:** the Step 4 header comment (`NetworkDesignService.cs` around 305 to 320) still describes the old rule: "pitInvert[U] = downstream IL of the pipe flowing OUT of U". Rewrite it to match the line it explains.
9. **LOW:** CDRUNSOLVE and auto-design use the same service and will move the same way. The builder says this was not traced. The C-62 finalizer should run the CDRUNSOLVE and auto-design suites by name and read any picture change.
10. **Clashes:** REGRESSION_LOG.md. On C-61 it also brings #1537's commits with it.
11. **Deterministic AutoCAD check:**
    1. On a copy, draw a three-pit chain A, B, C, 20 m apart, with outlet C at IL 10.000.
    2. Open `CDHUB` > Network redesign and preview.
    3. **Expect:** B to C starts at 10.200, A to B ends at 10.230, and pit B reads 10.200.
    4. Apply, then U. **Expect:** all levels return.

## 4. #1556 @ 2fb1ff7c: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** CDTWL merged two schedule sets that both use P1 and P2.
2. **What the diff does (checked):**
   1. The outlets become (pit mark, schedule set) pairs. Only when the same mark appears in more than one set does CDTWL list numbered rows ("1 = pit P2 in schedule set A") and ask for a row number.
   2. The branch walk is then filtered to that set's pits and pipes.
   3. A drawing whose marks are all different is read exactly as before. The test `WithoutAScheduleSet_TheOldReadingIsUnchanged` pins this.
   4. "Main" as the default set matches `PitData.ScheduleSet`.
3. **What Tim will see:** two systems, each P1 to P2: CDTWL lists two rows. Answer 1 and it counts set A's one pipe at set A's length. A single-set drawing asks nothing new.
4. **Defaults:** no switch. Correct: the question only appears where the old silent answer was wrong.
5. **Redo / layers:** CDTWL reading only. This PR changes no write.
6. **Tests:** five tests that do not compile on the base. One records the old two-pipe result.
7. **MEDIUM, plain-number pit marks:**
   1. `ResolveOutletAnswer` treats a typed number as a row *only if no detention outlet has that mark*.
   2. CE allows plain-number marks ("a typed 8"). Say detention pit "2" is in sets A and B. The rows are 1 and 2. Typing `2` matches the mark "2" twice, so the answer is refused. Row 2 can never be chosen.
   3. **Fix:** when the marks repeat (the numbered list is showing), read the answer as a row number first. Add a test with marks "2"/"2".
8. **LOW:** with repeated marks, a pipe recorded in one set but joined to the other set's pit drops out of the walk. That case is ambiguous anyway; say it in the notes when a pipe is left out for its set.
9. **LOW:** C-61 turned `detention.twlUsesDrawingUnits` ON (bf311924), after this PR was built on 9821c80c. Re-run `Bug970TwlSeparateSetsTests` on the merged train. The 10000 and 20000 mm lengths depend on the recorded-units path. The CDCALC default-volume-by-mark item stays parked, as the builder says.
10. **Clashes:** none in code against C-61 (#1538 is already in C-61 at bf311924). Retarget to the C-62 base.
11. **Deterministic AutoCAD check:**
    1. On a copy, make two schedule sets, A and B, each P1 to P2, DN300, with P2 as a detention pit. Set A is 10 m long, set B 20 m.
    2. Run `CDTWL`, enter 2500 L, answer 1. **Expect:** one pipe run of 10.0 m.
    3. Run it again and answer 2. **Expect:** one run of 20.0 m.
    4. Rename both P2s to "2" and answer 2. **Expect:** set B (after the fix).
    5. On a single-set drawing. **Expect:** no row list.

## 5. #1557 @ 73bc8264: MERGE, 0 HIGH, 0 MEDIUM, 2 LOW

1. **What it says:** Replace erased the old imported pit before finding out that the new one could not be drawn.
2. **What the diff does (checked):**
   1. Before `ClearPreviousXcivilImportArtifacts`, both import paths note every new pit that needs a locked layer, by pit number.
   2. The clean-up then keeps the earlier pit with that number. It uses the existing BUG-417 "kept" route, so the draw loop's `LeaveOutBecauseEarlierPitKept` stops a second copy.
   3. I compared the label rule each path uses: X-Civil `!IsPlasticPit`, LandXML without. Each matches its own draw loop exactly.
   4. Nothing is unlocked.
3. **What Tim will see:** with 25TEXT locked and P4's cover level changed in the file, Replace leaves the old P4 whole. The report reads "did not draw 1 pit and left 1 earlier pit in place".
4. **Defaults:** no switch (it only keeps what the drafter had).
5. **Locked layers / Xrefs:** respected. Handles resolve in this drawing only.
6. **Tests:** five, including two source-order pins (note before clear; keep before the first `Erase()`).
7. **LOW:** the new method's `<summary>` was inserted between the old `<summary>` of `ContinueXcivilImportAfterPreflight` and that method. Now one method has two summaries and the other has none. Move it.
8. **LOW:**
   1. Imported **pipes** still have erase-first (the builder says so). Carpark it.
   2. A kept old P4 stays at its old position, while new pipes to "P4" are drawn from the file. This is the existing BUG-417 behaviour, so the report line should tell the drafter to re-run after unlocking.
9. **Clashes:** REGRESSION_LOG.md only.
10. **Deterministic AutoCAD check:**
    1. On a copy, import a LandXML with P4 (cover 12.000).
    2. Edit the file to cover 12.500. LOCK 25TEXT. Import again with Replace.
    3. **Expect:** P4 still reads 12.000, the report names 25TEXT, and the other pits are replaced.
    4. UNLOCK and import again. **Expect:** P4 reads 12.500.

## 6. #1558 @ 91d8c39d: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW

1. **What it says:** choosing another file on the review page and clicking Read source drew the first file.
2. **What the diff does (checked):**
   1. Both review callbacks (X-Civil and LandXML) compare the file that was read with the file now chosen. They compare case-blind and ignore a trailing slash.
   2. On a mismatch they return "do not proceed", with a plain message.
   3. I checked the caller: the gate sits before Phase 7, so "Nothing was drawn" is true.
3. **What Tim will see:** "CDIMPORTLANDXML: you chose a different file (B.xml) after CE had read A.xml. Nothing was drawn ... Run CDIMPORTLANDXML again."
4. **Defaults:** new switch `xcivilImport.importReviewRefusesChangedSource`, ON. That is correct for a bug-fix switch.
5. **Redo / layers:** nothing is written on the refused path.
6. **Tests:** seven, covering the pure rule, the message, the default and a source pin on both commands.
7. **MEDIUM, the settings census on C-61:**
   1. The switch's note has no "Default:" text.
   2. `C60AuditSourcePinGuardTests.NewSettingsKeys_NeedADocumentedDefault` (merged in C-61 from #1536) fails with "XcivilImportSettings.importReviewRefusesChangedSource needs 'Default: <value>'".
   3. **Fix:** add `/// Default: on.` to the summary.
8. **LOW:** no CDS row for the switch (R-00). Batch it with the four other new switches into one Codex window job (see "Train").
9. **LOW:** after the refusal, the command's own "declined at pre-flight" message may also print. Check the AutoCAD run for a doubled line.
10. **Clashes:** REGRESSION_LOG.md only.
11. **Deterministic AutoCAD check:**
    1. On a copy, run `CDIMPORTLANDXML`, pick A.xml, Continue.
    2. On the review page choose B.xml, then Read source. **Expect:** the message names both files. `DBMOD` is unchanged (read it before and after) and no new objects exist.
    3. Repeat without changing the file. **Expect:** it imports as before.

## 7. #1562 @ cda22fb9: MERGE-WITH-FIXES, 0 HIGH, 2 MEDIUM, 2 LOW (protected file, redo review)

1. **What it says:** Esc after a placed CD pipe with a callout threw away the callout's link.
2. **What the diff does (checked):**
   1. `OnCommandCancelled` now passes `cancelled: true`. `OnCommandFailed` is unchanged.
   2. In `HandleCommandInterrupted`, the queued registrations are written once, before the queue is cleared, only when all of these hold:
      1. the switch is on;
      2. the command was cancelled;
      3. a CE editor had set the resume flag;
      4. something is queued;
      5. `RedoHistoryCommandEndRule.MayWriteAtCommandEnd(command, RedoWindowGuard.IsOpen(db))` allows it.
3. **Redo-safety (the review asked for):** I compared it with the normal end (`LinkService.Reactors.cs` about 832 to 856).
   1. The normal end writes the same registrations on `!IsHistoryCommand && WriteRegistrationsAtCommandEnd`. The new rule is stricter, because it also refuses while REDO is available.
   2. U, UNDO, REDO and MREDO never write, and a failed command never writes.
   3. There is a precedent for writing inside the cancelled path: COPY Multiple's TRAIN FIX A2 (same method, about line 1600) under the same rule.
   4. So the design keeps REDO safe. What unit tests cannot show is whether AutoCAD puts a write made at the Cancelled event into CD's own Undo step (MEDIUM 2).
4. **What Tim will see:** CD, Callout label, place one pipe, Esc at the next pipe. The label is now linked: ERASE the pipe and the label goes with it. One U brings both back.
5. **Defaults:** new switch `linking.escKeepsPlacedCalloutLinks`, ON.
6. **Locked layers:** the same writer as the normal end, with no new layer route.
7. **Tests:**
   1. Eight new: the pure rule, including U/UNDO/REDO/MREDO and the redo window, plus a source-order pin.
   2. Three old guards were re-pinned. I read each one: they say "one guarded write" now, not "no write". That is not a weakening, because the count is pinned at exactly one.
   3. The baseline file adds five lines under each handler. The failed-handler lines are documented as unreachable.
8. **MEDIUM 1, the settings census:** `LinkingSettings.escKeepsPlacedCalloutLinks` has no "Default:" text. Add `/// Default: on.`
9. **MEDIUM 2, AutoCAD proof owed:** "one U takes the pipe, label and link back together" and "REDO survives" must be driven. Keep BUG-874 open until the check below passes.
10. **LOW:** listing the write under `OnCommandFailed` in the reviewed-hooks baseline means a real future write on the failed path would pass the scan silently. Add a source pin that `OnCommandFailed` never passes `cancelled: true`. The new test checks only the next 500 characters; pin the whole method instead.
11. **LOW:** no CDS row for the switch.
12. **Clashes:**
    1. `UserSettings.cs` with #1567 and #1576: all three add a block at the top of `LinkingSettings`. Keep all three.
    2. C-61 also edited `RedoSafeReviewedHooks.baseline.txt`. The merge is clean, but re-run `EveryHookBetweenCommands_IsRedoSafe_OrReviewed` on the merged train.
13. **Deterministic AutoCAD check:**
    1. On a copy, run `CD` route-first with a callout label. Place one pipe. Esc at the next-pipe prompt.
    2. ERASE the pipe. **Expect:** the callout goes too.
    3. U. **Expect:** the pipe and callout are back.
    4. REDO. **Expect:** both are gone again.
    5. U again, then run `CDCHECKCURRENT`. **Expect:** no "callout not linked" finding.

## 8. #1567 @ 14006793: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 2 LOW (protected file)

1. **What it says:** CDPROPAGATE gave the only IL text left the first end's level, whichever end it belonged to.
2. **What the diff does (checked):**
   1. With exactly one IL text and the switch on, it reads that text's recorded end (`LinkedField` or `SemanticRole`) and writes that end's level.
   2. If no end is recorded, it returns false. I checked the caller (about line 799). On false the pipe goes to "could not write", and its record and link data are **not** written (`continue` before `WritePipeLinkData`). So drawing and record stay in step.
   3. Two-text pipes are unchanged.
3. **What Tim will see:** with the upstream IL hidden, CDPROPAGATE 9.50 at the downstream pit puts "IL 9.50" in the text beside P2. Before, it was "IL 9.60".
4. **Defaults:** new switch `linking.propagateWritesSingleIlToItsOwnEnd`, ON.
5. **Locked layers:** still all-or-none through `IlTextWriteGate.WriteAllOrNone` and `CanWriteIlAttachment`.
6. **Tests:** six, covering the end rule and a source pin. No drawing-level test (left to the checklist).
7. **MEDIUM, the settings census:** add `/// Default: on.`
8. **LOW:** in an older drawing whose single IL text has no recorded end, the old code was often right (when the hidden text was the downstream one). The new code now leaves it and reports it. That is safe, but the drafter gets more "could not be updated" pipes. Consider the text's nearer pit as a second clue, reported as such.
9. **LOW:** the existing summary warning says the text "could not be rewritten - most often a locked layer". For this case the reason is "its end is not recorded". Pass the reason through so the drafter is not sent hunting for a locked layer.
10. **Clashes:** `UserSettings.cs` with #1562 and #1576 (keep all).
11. **Deterministic AutoCAD check:**
    1. On a copy, draw P1 to P2, 10 m, IL 10.00/9.90. In Edit Pipe, hide the first IL.
    2. `CDPROPAGATE` from P2 at 9.50. **Expect:** the one text reads "IL 9.50", and the Pit Schedule matches.
    3. Repeat with both ILs shown. **Expect:** both change as before.

## 9. #1570 @ c732d63e: MERGE-WITH-FIXES, 0 HIGH, 1 MEDIUM, 1 LOW

1. **What it says:** Refresh rewrote "2/375" as "375" and a trench grate "3000" as "300 x 300".
2. **What the diff does (checked):**
   1. Refresh now uses the window's own formatters (`PitScheduleBuilder.BuildPitSize`, `FormatScheduleDiameter`).
   2. I compared `BuildPitSize` with the old `BuildPitSizeText` line by line. They are identical except for the trench grate (TG) branch and the pump-pit branch. So ordinary and detention pits really are unchanged.
   3. C-61's pit-floor work (#1531) touched the depth and remarks cells, not the size cells.
3. **What Tim will see:** Refresh keeps "2/375" and "3000", and a pump pit stays blank instead of "0 x 0".
4. **Defaults:** new switch `linking.scheduleRefreshKeepsTwinAndTrenchText`, ON.
5. **Locked layers:** the existing cell writer is unchanged.
6. **Tests:** seven, including OFF (old text) and the default. They change `SettingsService.Current` in memory only and restore it in TearDown (`NonParallelizable`). Nothing is saved.
7. **MEDIUM, the settings census:** add `/// Default: on.`
8. **LOW:** no CDS row.
9. **Clashes:** REGRESSION_LOG.md only. C-61's ScheduleLinkService changes merge cleanly.
10. **Deterministic AutoCAD check:**
    1. On a copy, place a Pit Schedule with a twin 375 detention pipe, a TG pit (3000 long, 300 x 300) and a 600 x 600 pit. Refresh.
    2. **Expect:** cells read "2/375", "3000" and "600 x 600".

## 10. #1576 @ bae50a7b: HOLD, 1 HIGH, 2 MEDIUM, 1 LOW (save path, protected file)

1. **What it says:** a CE record that exists but cannot be read is never saved over.
2. **What the diff does (checked):**
   1. The normal load now reports whether the record exists and had text.
   2. A record that has text but fails to read puts that drawing (by native pointer) on hold, with one command-line notice.
   3. `PerformPendingSaveLocked` and `SaveToDrawing` refuse while the drawing is held.
   4. No new transaction or write is added.
3. **HIGH, other routes still save over the record:**
   1. `ProjectDataService.WriteSnapshotInTransaction` writes the whole record inside a command's own transaction, and it does not ask the hold. Neither does its preflight, which only checks that the stored object is an Xrecord.
   2. It is called from about ten places:
      1. native MOVE/STRETCH edits (`LinkService.NativeEdits.cs` 391);
      2. Batch edit Apply;
      3. CDREPAIR apply (`LinkService.RepairAudit.Apply.cs` 135);
      4. CDAGI, strip drain and CDTANK apply;
      5. the calculation workspace;
      6. network edits;
      7. the spine upgrade.
   3. In a held drawing the current project is the rebuilt one, so any of these overwrites the unreadable record. The message the PR prints ("CE will not save over it, so the original schedule rows and remarks stay in the drawing") is then untrue.
   4. **Fix:** make `WriteSnapshotInTransaction` (and its preflight) skip the record write, with one log line, while the drawing is held. Add a source guard listing every writer of `ProjectDataStorageContract.DataKey`, so a new writer must ask the hold.
   5. Do not throw. A throw would roll back the drafter's MOVE (R-27).
   6. The two JSON-patch writers (rulebook metadata and AI access) keep the raw text, so they are lower risk. Include them in the guard anyway.
4. **MEDIUM, the hold can stick to the wrong drawing:**
   1. The note says "a record that read fine, *or is absent*, takes the hold off". The code releases only on `readSucceeded`. An absent record returns false with `recordExists = false`, so it neither holds nor releases.
   2. Nothing releases the hold when a held drawing closes. A later drawing whose database gets the same native address would inherit the hold: a new blank drawing whose CE record silently never saves (log only, no notice).
   3. **Fix:** release when `!recordExists`, and release on the document's close (the same place `_embeddedRecordDatabase` is cleared). Add a test for the absent case.
5. **MEDIUM, the settings census:** add `/// Default: on.` to `keepUnreadableDrawingRecord`.
6. **LOW:** no CDS row. BUG-988 (F-179) was rightly left for its own change.
7. **What Tim would see (once fixed):** one command-line notice on opening a drawing with a damaged record. Drafting carries on, and the original record is still there after any command and QSAVE.
8. **Redo-safe:** the read stays open-close, and no write is added.
9. **Clashes:** `UserSettings.cs` with #1562 and #1567 (keep all).
10. **Must wait:** the HIGH and the first MEDIUM, then a re-review of the save path.
11. **Deterministic AutoCAD check (after the fix):**
    1. On a copy drawing with a pit, a manual schedule row and a remark, damage the record (lastPitNumber = "BROKEN").
    2. Open it. **Expect:** the notice.
    3. MOVE a pipe end, run CDSYNC, then QSAVE, close and reopen.
    4. **Expect:** the damaged record text is byte-identical (compare an export of the record before and after).
    5. Open a new blank drawing in the same session and draw one pit. **Expect:** its record saves.

## 11. #1586 @ fca3e025: MERGE, 0 HIGH, 0 MEDIUM, 1 LOW

1. **What it says:** a pit with one level that the file names for a different pipe gave that level to the one pipe joined there.
2. **What the diff does (checked):** the one-level, one-pipe shortcut now applies only when the level names no pipe, or names this pipe. Otherwise the end falls through to the existing named rules, which mark it Unknown with `no-level-names-this-pipe`.
3. **What Tim will see:** after the import that pipe end reads Unknown instead of another pipe's 9.75. Normal files import as before.
4. **Defaults:** no switch (a matching fix inside the import). Fine.
5. **Tests:** one new test, red on the base. All Bug605 named-invert tests are green.
6. **LOW:** it relies on the request's `PipeName` matching the file's `refPipe` text exactly (case-blind, trimmed). The BUG-605 rules already rely on this, so it is consistent.
7. **Clashes:** REGRESSION_LOG.md only.
8. **Deterministic AutoCAD check:**
    1. On a copy, import a LandXML where pit P2 has one `<Invert refPipe="P99">` and only pipe PIN joins P2.
    2. **Expect:** PIN's P2 end reads Unknown and the import log says no-level-names-this-pipe.

## 12. #1591 @ ffd8e500: MERGE, 0 HIGH, 0 MEDIUM, 2 LOW

1. **What it says:** CDRENUMBER closed AutoCAD on a looped pipe record (a stack overflow).
2. **What the diff does (checked):**
   1. An on-path set in `LongestUpstreamPathLength` stops the recursion going round a loop.
   2. A new `FindLoopedPits` names the loop, and the command prints one plain line before the usual list. Nothing is blocked (R-27).
   3. The numbering walk itself was already iterative with a visited set. The network builder has no recursion.
   4. The message points to `CDCHECK`, which exists.
3. **What Tim will see:** AutoCAD stays open, then "The pipe records loop back on themselves at P11, P12 ... Check the pipes between them with CDCHECK.", then the normal list and Yes/No.
4. **Tests:** three. With the guard removed, the run aborts on a stack overflow, which is the real red.
5. **LOW:** F-202 (the main line can get the shorter branch's numbers) was not included, though the ledger asked for it in the same pass. It stays open.
6. **LOW:** inside a loop, the cached path length depends on which pit was entered first, so the numbering order inside the looped part can vary between runs. It is harmless, but the AutoCAD check should not expect a fixed order there.
7. **Clashes:** REGRESSION_LOG.md only.
8. **Deterministic AutoCAD check:**
    1. On a copy, make pits P10 to P13 with pipes P12 to P10, P13 to P10, P11 to P12 and P12 to P11 (records).
    2. Run `CDRENUMBER`. **Expect:** AutoCAD stays open, the loop line names P11 and P12, and the list appears. Answer No: nothing changes.

## 13. #1594 @ fc12426c: MERGE, 0 HIGH, 0 MEDIUM, 1 LOW (Manager)

1. **What it says:** CEHEALTH printed "[OK] CE Civil Suite" when Civil was installed but not loaded.
2. **What the diff does (checked):**
   1. There is a new `NotLoaded` branch before the OK line: a warning that counts as an issue.
   2. I checked how the status is worked out. `NotLoaded` means set to start with AutoCAD but no assembly with that name prefix is loaded.
   3. Structural's assembly is `CE_STRUC_SUITE_<timestamp>`, so the prefix test finds it.
   4. Ghost (not installed) and legacy StrucPlus descriptors have no bundle folder, so CEHEALTH skips them as before.
3. **What Tim will see:** "[WARN] CE Civil Suite: installed, but not loaded in this AutoCAD session ... Restart AutoCAD", and "1 issue(s) found".
4. **Tests:** the line helper and a source-order pin. The pin fails on the base.
5. **LOW:** the tests do not run the status-to-line route end to end. The AutoCAD check covers it.
6. **Clashes:** `PluginManagerCommands.cs` with #1595 and with C-61's #1548. Both merge cleanly.
7. **Deterministic AutoCAD check:**
    1. Start AutoCAD 2027 with the Civil bundle's startup turned off (CEMANAGER).
    2. Run `CEHEALTH`. **Expect:** a [WARN] line for Civil and no "All checks passed".
    3. Restore startup and restart AutoCAD. **Expect:** "[OK] CE Civil Suite v3.0.7x".

## 14. #1595 @ a388870b: MERGE, 0 HIGH, 0 MEDIUM, 2 LOW (Manager)

1. **What it says:** the CE Tools "Updates & Rollback" button refused an ordinary colleague and opened nothing.
2. **What the diff does (checked):**
   1. For a non-administrator, `CEMANAGERUPDATES` opens (or brings back) the Manager window and selects its own Updates tab. It copies the CESURVEYREVIEW pattern exactly.
   2. Administrators still get `ShowAdminWindow("Updates")`.
   3. No role is granted.
   4. The ribbon button really sends `CEMANAGERUPDATES` (`CeToolsRibbonDefinitionService.cs` 27).
3. **What Tim will see:** Max clicks Updates & Rollback and the CE Manager window opens on the Updates tab. There is no "not an administrator" message.
4. **Tests:** two source pins (both red on the base). The window-reopen count was raised from 2 to 3, on purpose.
5. **LOW:** this is the third copy of "open or bring back the Manager window, then pick a page" (CEMANAGER, CESURVEYREVIEW, CEMANAGERUPDATES). Design rule 1 says one code path, so fold them into one helper at the next touch.
6. **LOW:** no window-level test or picture shows the Updates tab actually selected after a fresh open.
7. **Clashes:** see #1594.
8. **Deterministic AutoCAD check:**
    1. Log in as a non-administrator test profile.
    2. Click CE Tools > Updates > Updates & Rollback. **Expect:** the Manager window opens with the Updates tab selected.
    3. Minimise it and click again. **Expect:** it is restored on Updates.
    4. On an administrator profile. **Expect:** the administrator window opens on Updates.

---

## Clash map (beyond REGRESSION_LOG.md)

Checked with `git merge-tree` pairwise (91 pairs) and each PR against C-61 @ 88bd62f7. Every PR clashes with every other in REGRESSION_LOG.md: keep every entry, newest on top in merge order.

1. **#1562 x #1567 x #1576:** `Modules/Drainage/Models/UserSettings.cs`. All three insert a switch at the top of `LinkingSettings`. Keep all three blocks.
2. **#1594 x #1595:** the same file, but it merges cleanly.
3. **#1562 x C-61:** `RedoSafeReviewedHooks.baseline.txt` merges cleanly. Re-run the redo-safety call-graph test on the merged train.
4. **#1555:** clean in text, but it brings #1537's unvalidated commits with it.
5. **#1556:** its base (#1538) is already in C-61, so it merges cleanly onto C-61.
6. **Census (not a text clash):** #1558, #1562, #1567, #1570 and #1576 go red on C-61's settings census until each gains a "Default:" line.

## Recommended train and merge order

1. **C-62, Civil + Manager, base `claude/rel-20261023l` @ 88bd62f7 (C-61, installed now):**
   1. #1552 (with the CDRG one-liner if it is back in time).
   2. #1553 after the note fix.
   3. #1586.
   4. #1591.
   5. #1557.
   6. #1558, plus its "Default:" line.
   7. #1570, plus its "Default:" line.
   8. #1567, plus its "Default:" line (UserSettings: keep all).
   9. #1562, plus its "Default:" line. Then re-run the redo baseline test.
   10. #1556 after the row-number fix. Re-run its tests with units ON.
   11. #1594.
   12. #1595.
2. **The assembler may add the five "Default: on." lines itself.** It is a doc-only change. Also add the five new switches to a C-62 copy of `C61NewSwitchDefaultsTests` (an old settings file loads them ON).
3. **Finalizer musts:**
   1. Build net48. Batches 2 and 3 never built it.
   2. Run the full Civil and Manager suites. The only expected red is the GlenEira back-test.
   3. Run the CDRUNSOLVE and auto-design suites by name, if #1555 goes.
4. **One Codex window job after C-62:** five CDS rows for the new switches, then the 150% fit at no more than 670 px.
5. **S-43:** nothing from these batches.
6. **Must wait:**
   1. **#1576:** the HIGH and the first MEDIUM, then a re-review.
   2. **#1555:** behind #1537's validation; then merge #1537, then #1555.
   3. **BUG-885:** Tim's Monday answer.

## Also seen (for the desk, not a PR item)

1. **New finding: CDRG rolls back every raingarden (HIGH, code reading only).**
   1. The same commit that made the spoon ByLayer (8f743e93, 9 Oct) made the raingarden outline and hatch ByLayer.
   2. But `RaingardenPlacementPlan.RequireExactAuthoredAppearance` (line 276) still demands colours 3 and 113. Its callers are both CDRG routes (`SourcePlacementService.cs` 658 and 783).
   3. I have not seen it fail in AutoCAD. One CDRG on a copy settles it.
   4. **Carpark it under the next free BUG number.** The fix and its test are in #1552's entry, item 7.
2. **Base drift:** the brief and the three batch reports name C-60 / 3.0.70 as installed. The bundle reads 3.0.71+88bd62f7 (C-61). The C-62 assembler must start from C-61, not from `claude/rel-20261022m`.
3. **Not checked by me:**
   1. No build, no test run, no AutoCAD and no picture. I did not re-run any red-before claim.
   2. The test totals are the builders' own figures.
   3. Built and unit-tested by the builders where stated. Not installed. Nobody has opened any of these in AutoCAD. Not Tim-accepted.
