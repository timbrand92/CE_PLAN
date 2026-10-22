# Opus review of the overnight Codex draft PRs, Group B: engineering and fix briefs (Fri 23 Oct 2026, Melbourne)

**Who and how.** Opus 5.5 (claude-opus-5-5), read-only, Fri 23 Oct about 04:00 to 04:50 Melbourne. I read every diff with `git` against its base, read each Codex report, the engineering audits, `FIX_BRIEFS_9NOV_2026-10-23.md`, the brief texts in `desk_jobs/make_cx_eng_builds.ps1` and `make_cx_fb.ps1`, and the Codex preamble (`_CODEX_RUNNER/cx_b01_automation_ids.txt` and `common.txt`). I re-worked every audit number by hand. Clash checks used `git merge-tree` (objects only, no refs changed). Nothing was built, tested, installed, commented on or merged. AutoCAD and Codex were not started.

**Bases (ls-remote, 04:30):** Civil/Manager `claude/rel-20261022m` = `40ee0a36` (installed Civil 3.0.70). Structural `claude/rel-20261022s2` = `2c9a9694`. Every PR head below equals the head in its Codex report, and every merge-base equals its base.

---

## ANSWER FIRST

1. **#1549 eng-small @ 23d6f3da:** MERGE-WITH-FIXES. HIGH 0, MEDIUM 1, LOW 2.
2. **#1530 eng-real-length @ afc45df8:** MERGE-WITH-FIXES. HIGH 0, MEDIUM 1, LOW 3. The MEDIUM is a correction to the robot check text, not to the code.
3. **#1537 eng-pipe-material @ c23b59c9:** HOLD. HIGH 0, MEDIUM 2, LOW 2. The final head was never built or tested.
4. **#1531 eng-pit-floor @ 4a438d26:** MERGE-WITH-FIXES. HIGH 0, MEDIUM 2, LOW 1.
5. **#1551 eng-move-pit-grade @ 356ca792:** HOLD. HIGH 0, MEDIUM 1, LOW 0. The sums are right but nothing calls them yet: the protected wiring still needs a Claude builder.
6. **#1538 eng-twl-units @ 9821c80c:** MERGE-WITH-FIXES. HIGH 0, MEDIUM 1, LOW 1.
7. **#1533 xclmtxt-s41 (Structural) @ 40c9a977:** MERGE. HIGH 0, MEDIUM 0, LOW 2.
8. **#1539 FB-01 @ 23db8940:** HOLD. HIGH 0, MEDIUM 1, LOW 0. It holds a helper only, and Codex itself shows the helper cannot settle the brief's own test drawing.
9. **#1541 FB-02 @ 96ca953a:** REJECT as a PR (no code, only notes). Keep its analysis. HIGH 0, MEDIUM 1, LOW 0.
10. **#1540 FB-03 @ 07010c09:** MERGE (switch OFF). HIGH 0, MEDIUM 1, LOW 2.
11. **#1542 FB-04 @ 0c5a40b6:** REJECT as a PR (no code, only notes). HIGH 0, MEDIUM 1, LOW 0.
12. **#1544 FB-05 @ b2f24d0c:** REJECT as a PR (no code, only notes). Keep its analysis. HIGH 0, MEDIUM 1, LOW 0.
13. **#1550 FB-06 @ 6c2e90f5:** HOLD. HIGH 0, MEDIUM 1, LOW 0. It holds a pure rule only; Codex was still writing its report at 04:30.
14. **#1543 FB-07 @ 1bbf01f6:** REJECT as a PR (no code, only notes). HIGH 0, MEDIUM 1, LOW 0.
15. **#1546 FB-08 @ 6f0423d7:** MERGE. HIGH 0, MEDIUM 0, LOW 1.
16. **FB-09: no PR and no branch exist.** Lane 16 runs FB-03, then FB-06, then FB-09; it had reached FB-06 at 04:30. FB-09 is not built yet.
17. **#1545 FB-10 @ fba3f674:** MERGE. HIGH 0, MEDIUM 0, LOW 3.
18. **"Already fixed":** none. Every report checked the cause at `40ee0a36` first and found the bug still present, and I agree from the code I read.
19. **Nothing here must wait for Tim.** No PR answers any of the four engineering questions in `QUESTIONS_FOR_MONDAY.md`: the rainfall curve note, pipe-wall cover, obvert matching and the minimum-grade ladder. One extension needs only Tim's veto: the pit-floor rule, which he can switch off by default (Monday item 4).
20. **Merge order:**
    - **C-61 (Civil only):** #1549 (after its fix), #1530, #1531 (after its fixes), #1538 (after its fix), #1546, #1545, #1540.
    - **C-62:** #1537 (after validation), the Claude-built wiring for FB-01, 02, 04, 05, 06 and 07 and for move-pit, and FB-09 once it is built.
    - **S-42:** #1533.
    - **Manager:** no Group B PR touches Manager or Shared, so Manager only needs its version re-stamped.

### Two desk faults found by this review (said first, RULES 2.8)

1. **Six of the ten fix briefs could never be built by Codex.** FB-01, 02, 04, 05, 06 and 07 all need files on the old 25 Sep "must not edit" list in `_CODEX_RUNNER/common.txt` (`LinkService*`, `PipeEditCommand*`, `PitEditCommand*`, the save/undo handlers). No brief carried an EXCEPTION line. **Cost:** about six Codex runs, roughly a night of one lane, and four notes-only PRs. **Fix:** route these to a Sonnet builder on Team with Opus review, as the fix-brief file already says ("Sonnet builds; Opus reviews").
2. **The Codex preamble contradicts the fix-brief rule on switch defaults.** The preamble in `cx_b01_automation_ids.txt` says "any NEW behaviour ... ships behind a Settings switch OFF". Fix-brief rule 5 says that when the old behaviour is the bug, the switch starts ON. Codex obeyed the preamble, so FB-03, CDTWL units and pipe material all arrived OFF. If merged as they are, **they fix nothing for a colleague on 9 Nov.** The desk should state the rule once in the preamble: OFF for new features, ON for bug fixes.

### Desk safety note (not about any one PR)

1. **What the logs show:** Tim's live `TIM_CE_CADTOOLS\CD_Settings.json` swapped between two versions overnight.
   - The two hashes are `2D23331F...` and `ACD64E79...`. The file keeps a 4 Oct timestamp either way.
   - Seven reports record the swap; two saw it flip back.
   - No report could name the writer.
2. **Why it matters:** this is the "tests can touch Tim's real files" hazard again. Treat Settings safety as unproven until the writer is found.

---

## Entries (one per PR)

### 1. #1549 `cx/eng-small-c60` @ 23d6f3da: MERGE-WITH-FIXES (HIGH 0, MEDIUM 1, LOW 2)

1. **What it does (read in the diff):**
   - **Audit finding 16:** the GE 24-115 and GE 23-129 back-tests now use the issued sheets' soft-ground C 0.35 and their permitted discharges (5.87 and 11.94 L/s). The 30 per cent band is unchanged.
   - **Finding 23:** the CDDESIGN Setup page shows the soft C the sum actually uses.
   - **Finding 21:** the R-03 grade text keeps its decimals.
   - **Finding 19 (Casey rounding):** correctly held back. It needs an issued Casey sheet or Tim's ruling on halves. It is not one of the four Monday questions, so it goes on the evidence list, not into code.
2. **Numbers re-worked by me:** GE 24-115 on the office curve with C 0.35 and 5.87 L/s gives 2.123 m3. Against 2.58 m3 that is 17.7 per cent, which passes the 30 per cent band (audit item 16). The test asserts 2.123 ± 0.002 and 17.7 ± 0.1. The window value comes from `_draft.PostDevSoftGroundC ?? Settings`, the same expression as `CivilDesignService.cs:156`, so what the drafter sees is what the sum uses.
3. **MEDIUM (fix before merge):** R-03 now prints the grade with up to six decimals on every row.
   - **On the drawing check list:** a 1 in 170 pipe reads "actual 1:169.705627".
   - **After #1530:** almost every pipe gets a fractional length, so almost every R-03 row will look like that.
   - **Fix:** print one decimal (`0.#`). When the one-decimal text equals the minimum and the row still warns, add the word "just" ("actual 1:200.0 is just flatter than the minimum 1:200"). Change the 20000.04 test case to match. The minimum figure stays as it is.
4. **LOW 1:** all five back-tests now take the discharge as given, so nothing tests the engine's own Glen Eira (Swinburne) discharge sum any more. GE 24-115 was the only job that did: 6.54 against 5.87 L/s. **Fix:** add one discharge-only case for GE 24-115 with no given discharge, checked against the 20 per cent band.
5. **LOW 2:** the test name "BackTest_GlenEira24115_Computed_WithinTolerance" now says "Computed" while the discharge is given. Rename it when convenient.
6. **What Tim will see:**
   - CDDESIGN > Setup reads "Soft area runoff coefficient: 0.30 (Settings; council records 0.35)".
   - CDRULES R-03 reads "actual 1:200.4" (one decimal after the fix).
   - No computed number, drawing or default changes.
7. **Switches:** none added.
8. **Redo safety:** not touched; this is window text and rule text only.
9. **Tests:** red-first is real (eight new cases failed on the base). Full Civil net10 is 19,162 total with 0 failed. **This removes the one standing red test,** so it should go first in the train: later PRs then start from a clean zero-failure line.
10. **Clashes:**
    - #1530 also edits `RulebookEngine.cs`, in different places; the dry merge is clean.
    - Group A's #1534 (wording) edits `RulebookEngine.cs` and `RulebookEngineTests.cs`; also clean.
    - Only `REGRESSION_LOG.md` clashes: keep all entries.
11. **Risk on 9 Nov:** low. Do not mark BUG-866 or the back-test fixed until a robot or Codex pass.

### 2. #1530 `cx/eng-real-length-c60` @ afc45df8: MERGE-WITH-FIXES (HIGH 0, MEDIUM 1, LOW 3)

1. **What it does:** CDRULES and CDCHECKS now take R-01, 02, 03, 06, 30, 31 and 32 on the pipe object's own length.
   - **Where the length comes from:** a new read-only `RulebookPipeLengthReader`, which uses the same length rule as Edit Pipe and the size review (`PipeEditCommand.DevelopedLengthMetres`). That covers bends, same-plan breaks and linked halves.
   - **When the length cannot be read:** the check falls back to the old straight pit-centre distance, says so in the row, and logs it.
   - **No switch:** the brief said the old behaviour is the bug.
2. **Numbers re-worked by me (DN225 UPVC, n 0.010):**
   - **Bent pipe:** route 24 m, fall 0.10 m gives 1 in 240. Speed V = (1/0.010) x 0.05625^(2/3) x (1/240)^0.5 = 0.948 m/s, Q = 37.7 L/s; R-03 warns against 1 in 200. The straight distance of 16.97 m gives 1 in 170, 1.127 m/s and 44.8 L/s, which passed before.
   - **Same-plan break:** 50 m with a 0.20 m fall gives 1 in 250 and warns.
   - **All three match the audit.**
3. **Engineering assumption Codex did not state (checked in the code):**
   - **The pipe object runs inside pit wall to inside pit wall, not centre to centre.** CD moves both ends onto the inside wall face before drawing (`CdCommand.cs:404`, `LinkService.SnapNewPipeEndsToPitWalls`), and its label and levels use that same length (`CdCommand.cs:437`). So CDCHECKS now judges the barrel length between the walls, the same figure the label shows. That is correct practice and follows design rule 1.
   - **Consequence on straight pipes:** they read slightly steeper than before. Example: a 20 m run between two 600 pits is 19.4 m wall to wall, so 1 in 200 becomes 1 in 194. A pipe that just warned before can now pass. That is the true barrel grade, not a loss of safety, and it does not need Tim's word. It should be in the PR text and the REGRESSION_LOG.
4. **MEDIUM (fix the robot check text before it goes to the test pack):**
   - **The problem:** the report and the REGRESSION_LOG tell the robot to expect "Pipe object length used: 24 m." In real AutoCAD the CD ends snap to the inside pit walls, so the drawn pipe is about 24 m less two inside half-widths (for example about 23.4 m with 600 pits).
   - **Effect:** the robot would mark a correct build as FAIL.
   - **Fix:** assert R-03 Warn, and assert that the length shown equals the pipe's own polyline length read with `vlax-curve-getDistAtParam`, not the figure 24. The same-plan case can still assert 50 m, because the typed real length governs.
5. **LOW 1:** in rows where no read was ever tried (the provisional cached check, and pure callers), the fallback says "the pipe object length is missing or invalid", which sounds like a fault. **Fix:** "the drawing was not read for this check".
6. **LOW 2:** one CE log warning per unreadable pipe on every Checks refresh can flood the log on a big drawing. Log once per pipe per drawing.
7. **LOW 3:** `RulebookLevelsCheck` still uses the straight distance. Nothing calls it yet (its own comment says so); align it before it gets a caller.
8. **What Tim will see:**
   - A bent or same-plan-break pipe that is too flat now warns in CDCHECKS.
   - Each grade or speed row ends "Pipe object length used: 23.4 m." (or the straight-distance reason).
   - Earlier check results show as Stale once, because the rulebook version changed.
   - No drawing, label or level is changed.
9. **Redo safety:** the reader is ForRead only, inside the caller's existing transaction. The existing guard `EveryHookBetweenCommands_IsRedoSafe_OrReviewed` passed in Codex's full run, which I did not re-run. Nothing writes.
10. **Tests:** 22 calculation tests failed before the change and pass after.
    - **Six existing assertions were changed:** five only add the new length sentence, and one pinned fingerprint changes because the rulebook version moved. That is justified, and the criteria pin is unchanged.
    - **Full Civil net10:** 1 failed, the Glen Eira test that #1549 fixes.
11. **Clashes:** with #1549 in `RulebookEngine.cs` (clean) and with group A #1534 (clean). Only `REGRESSION_LOG.md` clashes.
12. **Risk on 9 Nov:** low to medium. A drafter will see new warnings on bent pipes; that is the intended correction.

### 3. #1537 `cx/eng-pipe-material-c60` @ c23b59c9: HOLD (HIGH 0, MEDIUM 2, LOW 2)

1. **What it does:** CDRUNSOLVE, the network redesign and the size-writing proposals use each pipe's recorded material through the existing Settings Manning table, behind a new switch `networkUsesPipeMaterial`.
   - The switch defaults OFF and has a row in CDS > Design (two pages).
   - Unknown material is calculated as UPVC and the row says so.
   - The proposal Reason column wraps when it shows material text.
2. **Numbers re-worked by me (DN375, full bore, 1 in 130):**
   - **Concrete (n 0.013):** V = (1/0.013) x 0.09375^(2/3) x (1/130)^0.5 = 1.392 m/s, Q = 153.8 L/s.
   - **UPVC (n 0.010):** Q = 199.9 L/s.
   - **Grade concrete needs for 200 L/s:** S = (1.811 x 0.013 / 0.2064)^2 = 0.01301, which is 1 in 76.9.
   - **All three match the audit and the report.**
3. **Why HOLD: the final head was never built or tested.** The shared build lock was held all night. Three of the 23 new tests have never run, the 18 window pictures predate the last wording change, and there are no net48, net8 or net10 build results. **Fix:** one Sonnet validation run (builds, the 23 cases, the full Civil suite, pictures re-rendered and inspected), then re-review.
4. **MEDIUM 1 (default):** OFF means the HIGH audit finding stays live for every colleague. Proposals are reviewed before Apply, and the switch only makes CE read Tim's own roughness table, so this is not an engineering judgement. **Recommendation:** flip to ON in the same validation round (fix-brief rule 5: the old behaviour is the bug).
5. **MEDIUM 2 (two answers for the same Unknown pipe, design rule 1):**
   - **In this PR:** Unknown or unrecognised material is sized as UPVC, the smoothest pipe. That over-states capacity, the unsafe direction.
   - **On the other screen:** the pipe-size review refuses to size an Unknown material.
   - **Recommendation:** refuse an Unknown-material pipe here too ("material Unknown: set it in Edit Pipe"), or size it with the roughest material in the table. If the desk wants Tim's view, it is a one-line add to his Monday list. It is not one of the four questions.
6. **LOW 1:** the material note is passed between services by matching the text "Material:". It works, but a wording change would silently drop the note.
7. **LOW 2:** Codex found that typed CDRUNSOLVE feeds zero catchment flow to every node, so it cannot produce a 200 L/s proposal unaided. That is a separate defect: log it as its own bug.
8. **What Tim will see after the fixes:** a concrete 375 carrying 200 L/s is proposed at about 1 in 77 or as a 450, not at 1 in 130. Each proposal row says "Material: RCP; Manning n 0.013."
9. **Redo safety:** only the solver and proposal text change. Apply, Undo and LinkService are untouched.
10. **Clashes:**
    - Clean against the other Group B PRs except `REGRESSION_LOG.md`. It shares `UserSettings.cs`, `AdvancedSettingsDialog.xaml`, `CivilSettingsView.xaml`, `AdvancedSettingsViewModel.cs` and `SettingsValueCatalog.cs` with #1531, all additive.
    - Clean against group A's #1526 and #1534.
11. **Risk on 9 Nov:** none while held. After the fixes it goes in C-62.

### 4. #1531 `cx/eng-pit-floor-c60` @ 4a438d26: MERGE-WITH-FIXES (HIGH 0, MEDIUM 2, LOW 1)

1. **What it does:** Pit Schedule depth becomes cover level minus the pit's own recorded floor (`PitData.InvertLevel`), with a new switch `pitScheduleUsesPitFloor`.
   - The switch defaults ON and has a row under Settings > Fixes.
   - The new rule reaches the window, the drawn cells, the CDSYNC comparison, the redesign review and the CSV/Excel export.
   - Older drawn cells keep the old rule until the drafter runs Placement > Update existing schedule.
   - The heading becomes "PIT DEPTH (m)".
2. **Numbers re-worked by me:** cover 11.00, outlet 10.15, floor 10.05 gives 0.95 m. That is deeper than the 900 mm Settings figure, so "With Step Irons" appears. It matches the audit and now agrees with CDRULES R-29 for this pit.
3. **Switch and ruling:** Tim's 20 Oct item 13 was "pit floor", given for imported schedules (BUG-737). Applying it to the Pit Schedule is the audit's reading of that ruling, and Monday item 4 tells Tim he can switch it off. So ON is the right default.
4. **MEDIUM 1 (fix before merge): with the switch ON, a pit with no recorded floor loses two existing rules.**
   - **Pump station with no floor:** the old rule (BUG-785) took the deeper of cover minus inlet and cover minus outlet. The new `DepthText(..., pitFloor, true)` uses the outlet only. The rising-main outlet sits high, so a deep pump well would read shallow and could lose its step-iron note.
   - **Ordinary pit with no outlet level and no floor:** it went back to the inlet; now it is blank.
   - **Codex's own code comment:** it says "including BUG-785's inlet fallback", which the code does not do.
   - **Fix (one line in `PitScheduleDepthRule.DepthText`):** when the floor is not a number, `return DepthText(isSps, cover, inlet, outlet);`. Add two tests, one for an SPS with no floor and one for a pit with an inlet only.
5. **MEDIUM 2 (fix before merge): a pipe recorded below the floor.** Codex lets the floor win even when a pipe invert is lower. That is a record error, but then the schedule and CDRULES R-29 (lowest of the floor and every pipe) still disagree on step irons, which is the very disagreement audit finding 8 is about. **Fix:** depth = cover minus the lowest of the floor and the pipe inverts at that pit, the same as R-29. Log it as an interpretation of Tim's "pit floor": deeper is the safe direction for step irons. It needs no new question.
6. **LOW:** the PR adds `settings-dark-8-fixes.png` and `settings-light-8-fixes.png`, and group A's #1526 adds the same two file names (add/add clash). Keep one set and re-render after both are merged.
7. **What Tim will see:**
   - PITSCHEDULE shows PIT DEPTH 0.95 and "With Step Irons" for the audit pit.
   - A drawn schedule changes only when the drafter chooses Update existing schedule.
   - Opening PITSCHEDULE alone writes nothing.
8. **Redo safety:** Codex caught and removed a geometry read on the automatic-refresh path, and the existing between-commands redo guard passed in its full run. The drawn-cell writes stay on the explicit placement and update path.
9. **Tests:** 33 added. The audit-number test failed on the base (0.85 instead of 0.95). Full Civil net10 has 1 failed, the known Glen Eira test.
10. **Clashes:** see the LOW. Settings files are shared additively with #1537, #1538, #1540 and group A's #1526 and #1528.
11. **Risk on 9 Nov:** medium until MEDIUM 1 is fixed: pump stations are a daily item in this office. Low after.

### 5. #1551 `cx/eng-move-pit-grade-c60` @ 356ca792: HOLD (HIGH 0, MEDIUM 1, LOW 0)

1. **What it does:** a new `HeldGradeLevelCalculator` that rounds the fall UP, reusing CD's rule `MathHelper.ApplyCalculatedInvertRule`. Nothing calls it, because the call site is in `LinkService.Utilities.cs`, which Codex may not edit.
2. **Numbers re-worked by me:**
   - **Audit case:** top 10.00, length 15.30 m, held at 1 in 100. Raw fall 0.153, rounded up to 0.16, gives bottom 9.84 and a label of 1 in 96. Today's nearest rounding gives 9.85 and 1 in 102.
   - **Exact case:** 10 m at 1 in 100 stays at a 0.10 fall; the noise guard works.
   - **Top level with extra decimals (10.005):** 9.84, a fall of 0.165, still never flatter.
   - **Rounding direction:** correct. The pipe is never flatter than the held grade.
3. **MEDIUM:** Codex says the future switch "must remain OFF by default". It should be ON: the audit and CD's own rule show nearest rounding is the bug. The effect is that a moved pit's bottom level can drop by up to 10 mm.
4. **Route:** a Sonnet builder (Team) wires `ComputeGradeLockLevels` to the helper behind `linking.heldGradeRoundsSafe` (ON), with a test on `FlatPipeRepairPolicy` too, then Opus review. Keep this PR's helper and its 18 tests; that PR replaces this one.
5. **What Tim will see:** nothing until it is wired.
6. **Risk on 9 Nov:** none while held.

### 6. #1538 `cx/eng-twl-units-c60` @ 9821c80c: MERGE-WITH-FIXES (HIGH 0, MEDIUM 1, LOW 1)

1. **What it does:** CDTWL converts the pit-to-pit distance with the drawing's recorded units, through the shared `DrawingAreaUnits` and `RecordedPositionUnits`, behind a new switch `detention.twlUsesDrawingUnits`.
   - The switch defaults OFF and has no Settings row.
   - Levels (metres) and sizes (millimetres) are untouched.
   - The wall-to-wall trim is now subtracted after the conversion, which also mends the wall-to-wall option on metre drawings.
2. **Numbers re-worked by me:**
   - **Pipe:** a 20 m DN300 full holds pi x 0.3^2 / 4 x 20 = 1.414 m3 = 1,414 L.
   - **Pits:** two 600 x 600 pits from floor 10.00 to TWL 10.60 hold 2 x 0.216 = 432 L.
   - **Totals:** 1,846 L in total; wall to wall, 19.4 m of pipe holds 1,371 L.
   - **Before the fix:** the metre drawing gave 1.4 L.
   - **All match the report.**
3. **Finding 9 (double count and sump):** correctly left alone. Codex proved the sizes (48 L and 54 L) but the record has no reliable orifice level, so it stays parked.
4. **MEDIUM (fix before merge): flip the default to ON.**
   - **Millimetre drawings:** unchanged by construction (units 4 gives a factor of 1).
   - **Unitless or mismatched records:** keep the millimetre reading, as before.
   - **Metre drawings:** the only ones that change, and today they read 1,000 times too little.
   - **If left OFF:** no colleague ever gets the fix, and with no row nobody can turn it on.
5. **LOW:** a Settings row is owed (Codex window lane), the same as the other row-less switches listed in REVIEWLANE_LOG entry 1596.
6. **What Tim will see after the fix:** CDTWL on a metre drawing gives the same storage and top water level as the same network drawn in millimetres. Millimetre jobs see no change.
7. **Redo safety:** a pure calculation; no write.
8. **Tests:** 17 tests, 7 of which failed on the base and pass now. Full Civil net10 has 1 failed, the known Glen Eira test.
9. **Clashes:** only `UserSettings.cs` (additive) and `REGRESSION_LOG.md`.
10. **Risk on 9 Nov:** low.

### 7. #1533 `cx/xclmtxt-s41` (Structural) @ 40c9a977: MERGE (HIGH 0, MEDIUM 0, LOW 2)

1. **What it does:** XCLMTXT keeps supplier decimals ("250UB25.7" stays "250 UB 25.7"; "310UB32.0" keeps its ".0"). It replaces the single hard-coded "150X100X10 = UA" exception with a catalogue lookup:
   - An angle found in the catalogue gets the catalogue's family, EA or UA.
   - An angle not in the catalogue gets EA for equal legs and UA for unequal legs.
   - UB and UC designations are protected from the abbreviation expander.
2. **Checked against the Structural audit:**
   - "150x90x10 L ]L LINTEL" becomes "150 x 90 x 10 UA LINTEL".
   - "100x75x6 L ]L" becomes UA; "100x100x8 L ]L" becomes EA; "150x100x10 L ]L" becomes UA.
   - "250UB25.7 BEAM" becomes "250 UB 25.7 BEAM", and "410UB59.7" becomes "410 UB 59.7".
   - All match audit findings 1 (HIGH) and 2 (MEDIUM).
3. **Does not answer a Tim question:** the catalogue fixes stay with BUG-818, and Tim's CEMEMBER questions (long-leg-flat angles, the corrected section list) are separate. No switch is needed: the old output names sections that do not exist or the wrong angle family.
4. **LOW 1:** an angle symbol that is not directly after a size (for example "L ]L 150x90x10") is now left as the raw characters "L ]L"; the old code turned it into EA. That order is probably rare; add one robot row for it.
5. **LOW 2:** the full test run rewrote 70 window PNGs, which Codex restored. No product effect.
6. **What Tim will see:** the member schedule reads "150 x 90 x 10 UA LINTEL" and "250 UB 25.7 BEAM".
7. **Tests:**
   - 445 focused tests, 32 of which failed on the base.
   - Structural net10: 5,650 pass.
   - Structural net48: 39 fail, the same 39 names as the base.
8. **Risk on 9 Nov:** low. Structural is not in the 9 Nov Civil + Manager release.
9. **Train:** S-42 on `rel-20261022s2` `2c9a9694`. Only `REGRESSION_LOG.md` is shared.

### 8. #1539 `cx/fb01-c60` @ 23db8940: HOLD (HIGH 0, MEDIUM 1, LOW 0)

1. **What it holds:** a pure `CalloutAnchorChoice` helper with 17 tests. The drawing fix needs `LinkService.PipeAttachmentUpdates.cs`, which is protected.
2. **MEDIUM: Codex shows the brief's rule fails the brief's own drawing.**
   - **The rule:** use the current arrow if it is on the moved pipe and the stored anchor is not.
   - **The drawing:** in FX-01 a straight pipe is moved 5 m along itself, so both points stay on the pipe. The rule keeps the old anchor, which is 5 m wrong.
   - **What the wiring needs instead:** evidence that the callout moved with its pipe in the same command, not position alone.
   - **Good catch;** add it to FB-01 in the brief file.
3. **Route:** a Sonnet builder with Opus review (reactor path, redo safety), switch `linking.calloutKeepsPlaceOnGroupMove` ON, as the brief says.
4. **Risk on 9 Nov:** none while held. BUG-668 stays open.

### 9. #1541 `cx/fb02-c60` @ 96ca953a: REJECT as a PR (HIGH 0, MEDIUM 1, LOW 0)

1. **Content:** a `REGRESSION_LOG.md` entry only. No code or tests.
2. **MEDIUM:** a log entry for a fix that does not exist would mislead every later reader. Close the PR.
3. **Keep the analysis.**
   - **Main point:** `SourceChangeDecisionPolicy.After` moves the far-end decision but does NOT split on-run records or re-measure their chainage. It also refuses decisions aimed at the main being split.
   - **Why that matters:** the brief's "just call the tracked policy" would not move the branch junction (the 14 m becomes 6 m part).
   - **Action:** copy that paragraph into the FB-02 section of the brief file before a Sonnet builder starts.

### 10. #1540 `cx/fb03-c60` @ 07010c09: MERGE, switch OFF (HIGH 0, MEDIUM 1, LOW 2)

1. **What it does:** every PIT BLOCK 3 refresh writes the SHA-256 of the shipped master DWG into an Xrecord on the block definition, in the same transaction as the redefine.
   - **With `pits.skipCurrentPitBlockRedefine` ON:** a drawing whose only pit block is PB3, with a matching stamp, is left alone (no write).
   - **Always:** CDREFRESHBLOCKS still forces a refresh. PB and PB2 migrations still run.
2. **Opus review of a first-open writer (owed by the brief), done here:**
   - **Same path as before:** the same Idle runner, the same `RedoWindowGuard.DeferWhileRedoOpen` deferral, the same document lock.
   - **The added write:** one Xrecord, inside the redefine transaction that already writes, so no new occasion to write.
   - **The skip path:** opens only a read transaction (`ReadStamp`, never committed) and returns before any write, so the drawing stays unchanged.
   - **A failed import:** never stamps old geometry.
   - **Holding the master file:** a read-only handle is kept open over the hash and the insert, so the stamp describes the very file inserted.
   - **Verdict:** I find no redo or protection risk.
3. **MEDIUM (desk decision, not code):** OFF means BUG-793 is not fixed for colleagues. **Recommendation:** merge OFF now, because drawings start collecting stamps either way. Run FX-03 at the next Codex look with the switch set ON before AutoCAD starts. On a PASS, flip it ON in its own small PR that records the pass, as the brief intended.
4. **LOW 1:** with the switch ON, a drafter's own BEDIT change to PB3 now survives opening, because the stamp still matches the master. Before, CE quietly put it back. That is arguably better, but it narrows the effect of Tim's June "automatic migration" ruling, so say so in the PR text.
5. **LOW 2:** no Settings row yet (Codex window lane).
6. **What Tim will see:** nothing while OFF. With ON, an untouched drawing opened a second time no longer asks "Save changes?".
7. **Tests:** 17 new, 109 of 109 net48 focused migration and redo tests. The full net10 base and head each show the same single failure.
8. **Clashes:** `UserSettings.cs` (additive) and `REGRESSION_LOG.md`.
9. **Risk on 9 Nov:** low while OFF.

### 11. #1542 `cx/fb04-c60` @ 0c5a40b6: REJECT as a PR (HIGH 0, MEDIUM 1, LOW 0)

1. **Content:** notes only, in `REGRESSION_LOG.md`. The fix lives in `PipeEditCommand.cs`, which is protected.
2. **MEDIUM:** same reason as FB-02: the log would claim work that did not happen. Close the PR.
3. **Keep the analysis.** Removing the sync line alone is not enough: `SetDrawingPath` can save as well (`ProjectDataService.Mutations.cs:176,179`). The read-only path must feed `GetPipeByHandle` too. Add this to FB-04 for the Sonnet builder.

### 12. #1544 `cx/fb05-c60` @ b2f24d0c: REJECT as a PR (HIGH 0, MEDIUM 1, LOW 0)

1. **Content:** notes only. No code.
2. **MEDIUM:** same reason. Close the PR.
3. **Keep the analysis.** It names both writers:
   - **First:** `PitScheduleDialog.xaml.cs:143-155` calls `FlushPendingSave()` on every Close.
   - **Second:** PITSCHEDULE is in `LinkService.RecordFlushCommands`, so the save also runs at command end even with nothing waiting.
   - **Consequence:** fixing only the Close leaves the extra Undo step. Add both writers to FB-05.

### 13. #1550 `cx/fb06-c60` @ 6c2e90f5: HOLD (HIGH 0, MEDIUM 1, LOW 0)

1. **What it holds:** a pure `PitRenameOwnership.TryRename` rule with 15 tests (ignores case, leaves other pits alone). It is correct as far as it goes.
2. **MEDIUM:** the drawing write (`LinkService.RenameExplicitPitOwnership`) and the Edit Pit call are protected and not built, so on its own the PR changes nothing.
3. **Status:** at 04:30 the Codex lane was still adding build results to its report (plan commit `23d0d109`); the head had not moved.
4. **Route:** a Sonnet builder adds the protected writer and caller as the report's items 7 and 8 describe. Keep the rule and its tests.

### 14. #1543 `cx/fb07-c60` @ 1bbf01f6: REJECT as a PR (HIGH 0, MEDIUM 1, LOW 0)

1. **Content:** `docs/verification/FB07_ROUTING.md` and a log entry. No code.
2. **MEDIUM:** close it, for the same reason as FB-02.
3. **Keep the analysis.** The curve check must look at every segment's bulge; today's `HasBulge` reads vertex 0 only. The pit-placement search must also find a true arc mid-point. FB-07 runs after FB-02, in the same lane.

### 15. #1546 `cx/fb08-c60` @ 6f0423d7: MERGE (HIGH 0, MEDIUM 0, LOW 1)

1. **What it does:** the Inspector reads the pipe type from the pipe's own record first (the existing `LinkService.ReadPipeType`, ForRead, inside the palette's existing transaction), then the old XData. No protected file was edited and no new transaction was added.
2. **Design rule 1:** CDRULES (`ProjectDataService.RulebookDrawing.cs:249`) and pipe-end repair already treat `ReadPipeType` as the authority, so record-first is consistent.
3. **LOW:** the record stores the type as a plain number whose default is 0, which means Stormwater. A record written without the type field would read Stormwater, not Unknown. `RegisterPipe` always writes the field, so the risk is small; note it in the code comment.
4. **What Tim will see:** clicking a new CE stormwater pipe shows "Stormwater Pipe" in the Inspector Type row, not "Unknown".
5. **Redo safety:** a read-only pick. The automatic-refresh no-write guard passed on net10 and net48.
6. **Tests:** 14 new. Full Civil net10 has 1 failed, the known test.
7. **Risk on 9 Nov:** low.

### 16. FB-09: not built

1. **Status:** no branch `cx/fb09-c60`, no PR and no report at 04:30. Lane 16 is still on FB-06 and FB-09 comes next.
2. **Expectation:** its file (`PitScheduleXrefDiscoveryService.cs`) is not on the protected list, so Codex should be able to build it. Review it when it lands.

### 17. #1545 `cx/fb10-c60` @ fba3f674: MERGE (HIGH 0, MEDIUM 0, LOW 3)

1. **What it does:** CDSURVEY compares the loaded Xref's last-save time and version stamp with the file on disk, read through a read-only side database.
   - **If they differ, or cannot be read:** the fingerprint is left empty, the revision becomes Unknown, and the plain line appears: "The survey XREF file changed on disk after it was loaded. Reload it and run CDSURVEY again."
   - **This is advice, not a block (R-27):** the drafter may still store.
   - **Second replacement:** the disk hash is kept separately, so a second replacement during review is still caught.
2. **LOW 1:** CDSURVEY now reads the survey DWG from disk once more. A 50 MB survey can add a few seconds; note it in the Codex look.
3. **LOW 2:** if the header read fails for any reason, every CDSURVEY shows "could not be checked". That is safe but noisy. FX-10's reload step (a known fingerprint after reload) proves the normal case; also watch one ordinary unchanged survey in the Codex look.
4. **LOW 3:** a survey stored with an Unknown fingerprint is reported later as "changed on disk since review" once the Xref is reloaded. That is the right nudge but the wrong words; reword when convenient.
5. **What Tim will see:** after a surveyor's Rev B replaces Rev A on disk without a reload, CDSURVEY says to reload and stores "fingerprint Unknown" instead of quietly calling the old levels current.
6. **Redo safety:** a read-only review. The Apply path is unchanged.
7. **Tests:**
   - 14 new tests.
   - Full net10: base and head show the same single failure.
   - net48: one native test fails the same way on the base, so it is not caused by this PR.
8. **Risk on 9 Nov:** low.

---

## Merge order

### C-61 (Civil only; Manager not touched by Group B, re-stamp only)

1. **#1549** after its MEDIUM fix (one-decimal grade text). First, because it clears the only red test.
2. **#1530** as it is. Correct the robot check text in its REGRESSION_LOG entry and in the test pack (the pipe is not 24 m once the ends snap to the pit walls).
3. **#1531** after MEDIUM 1 and 2 (no-floor fallback; lowest of floor and pipes). If group A's #1526 is in the same train, keep one set of the `settings-*-8-fixes.png` pictures and re-render.
4. **#1538** after flipping `twlUsesDrawingUnits` to ON.
5. **#1546** as it is.
6. **#1545** as it is.
7. **#1540** with the switch OFF. Flip it ON in a later small PR after a Codex FX-03 pass.
8. **Clash note:** every step clashes in `REGRESSION_LOG.md`: keep every entry. The code files (`UserSettings.cs`, `RulebookEngine.cs`, the Settings XAML and view model) merged clean in my dry merge chain. Only `REGRESSION_LOG.md` conflicted.

### C-62 (Wed 28 Oct, the fix-brief train)

1. **#1537**, after the validation run, the default flipped ON and the Unknown-material decision.
2. **New Sonnet-built PRs for the protected work**, each with Opus review:
   - FB-02 then FB-07 (same lane);
   - FB-01;
   - FB-04;
   - FB-05;
   - FB-06 (on #1550's rule);
   - move-pit wiring (on #1551's helper).
3. **FB-09** once Codex builds it.

### S-42 (Structural)

1. **#1533** as it is.

### Close, then rebuild by a Claude builder

1. **Close these PRs:** #1541, #1542, #1543 and #1544 (notes only).
2. **Copy their analysis** into the FB sections of `FIX_BRIEFS_9NOV_2026-10-23.md`.
3. **Leave #1539, #1550 and #1551 open as draft** until the PRs that replace them land.

### Must wait for Tim

1. **Nothing in Group B.** No PR pre-empts the four engineering questions.
2. **Optional items for his Monday list:**
   - Casey's half-millimetre rounding: needs an issued Casey sheet or his ruling.
   - Sizing an Unknown-material pipe: refuse, or assume the roughest material.
   - The pit-floor default: veto only.

### Not checked by me

1. No build, test, AutoCAD, accoreconsole or Codex run. Every test count above is Codex's, not mine.
2. My merge-tree chain shows text clashes only; it does not prove the merged train compiles.
3. I did not open the committed window pictures.
4. Every bug named here: built and unit-tested at most, not installed, and nobody has opened it in AutoCAD. Do not mark any of them FIXED.

---

**Summary (under 120 words):** I reviewed 16 Group B draft PRs and confirmed FB-09 has not been built. Ready for C-61 once the small fixes are made: #1549, #1530, #1531, #1538, #1546, #1545 and #1540 (switch OFF). #1533 is ready for S-42. #1537 is on hold because its final version was never built. Six fix briefs could not be built by Codex because they need files Codex may not touch. The four notes-only PRs should be closed and the three helper-only PRs held; that work goes to Sonnet builders for C-62. Every audit number I re-worked matched. Two engineering corrections: pump stations with no recorded floor lose their depth rule, and the real-length robot check expects 24 m where the snapped pipe is shorter. Nothing pre-empts Tim's four questions.
