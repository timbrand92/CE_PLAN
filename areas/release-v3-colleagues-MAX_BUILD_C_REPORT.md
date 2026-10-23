# Max build C report: fixes for faults Codex found inside installed Civil 3.0.72 / Manager 1.1.72

Friday 23 October 2026, Melbourne, about 22:20. Builder: Claude Sonnet 5.5 (Max meter). Base for every fix: `origin/claude/rel-20261023m` at `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (fetched before starting; it did not move).

Built and unit-tested only. Nobody has opened any of this in AutoCAD. Nothing installed or deployed. No PR closed, no branch deleted, no bug marked FIXED, CE_SHARED and Installer untouched, Tim's settings files untouched. All six PRs are DRAFT against `claude/rel-20261023m`.

## ANSWER FIRST

1. **Six fixes built, six draft PRs open:** #1660 (item 8, Pit Schedule), #1676 (item 9, downpipe double-click), #1687 (item 16, Blue Factor), #1689 (item 19, CDCALC cover), #1692 (item 18, CDNEWDWG), #1694 (item 12, Manager logs). Each cause was checked in the code at the base first and was real. One item skipped: item 17 (#1617), because its fault is the same Pit Schedule heading fault fixed by #1660.
2. **No other open PR already fixed any of these.** I searched open PRs for each bug number. The look-alikes (#1630 for BUG-969, #1622 for BUG-1019) are the weaker duplicates the Opus review already named, and neither handles the failed-read case or the trench-grate placeholder.
3. **Every fix has a unit test that fails without the fix, a REGRESSION_LOG entry at the top of `REGRESSION_LOG.md`, and no new switch.** All six sit inside existing behaviour or are plain bug fixes, so there is no switch to start ON or OFF. None adds a hard block: where something is wrong the drafter gets a plain message and the command carries on (R-27).
4. **Merge note for the assembler:** every PR adds one entry at the very top of `REGRESSION_LOG.md`, so they will clash on that file. Keep every entry; no product file is touched by two of the six PRs.
5. **Not done, needs a decision or real AutoCAD proof:** a private copy of the schedule frame per schedule (item 8, second half). Options are in section 1.

## Per item

### 1. Item 8, #1531 Pit Schedule step irons and shared heading. PR #1660

1. **PR and head:** #1660, branch `fb/max-c-pit-depth`, head `ca83afd017c0bfde172086fbf395152dd2900d37`.
2. **Cause verified at the base:** yes, both. With "depth uses the pit floor" ON the step-iron decision read the PIT DEPTH cell, which is rounded to two decimals and can be typed over; and the heading rename wrote into the frame's block definition that every other schedule drawn from the frame shares.
3. **What changed:**
   1. The "With Step Irons" note now follows the pit's recorded levels, unrounded: cover minus the lowest of the pit floor and its pipe inverts. 904 mm gets the note, exactly 900 mm does not, a smaller typed depth never removes it, a deeper typed depth still adds it. The same rule is used by the window and by the after-command refresh of a drawn table (which had the same rounding fault).
   2. The depth heading is renamed only when every reference to the frame (and to any block nested in it) belongs to the schedule being updated: its own block and its continuation blocks. If anything else draws from the frame, the heading is left as drawn and the command line and CE log say so in plain words. The schedule still updates. Warning, not a block.
4. **Tests and totals:** Civil net10 **19,567 total, 19,544 passed, 22 skipped, 1 failed**. The one failure is `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`, which timed out at 15 s under machine load and passes alone (1 of 1). 19 new tests; 3 of them fail on the base with the product change reverted (the 904 mm window case, the drawn-table case and the typed-smaller-depth case). net48 build 0 errors. The Pit Schedule filter alone: 869 of 869.
5. **Real-AutoCAD check:**
   1. Pit with cover 11.000 and floor and pipe inverts all 10.096: the PIT DEPTH cell reads 0.90 and Remarks still end "With Step Irons".
   2. Pit 1.20 m deep: turn Auto-calculate depth off and type 0.50 in the PIT DEPTH cell. The note and the orange badge stay.
   3. Place a schedule, then place or update a second one drawn from the same frame: the first schedule's heading is unchanged and the command line says the heading was left as drawn.
   4. A schedule that is the only user of its frame still gets PIT DEPTH (m). One U after Update puts the schedule back as before.
6. **Skipped, needs Tim or real AutoCAD:** giving each schedule its own copy of the frame so the heading can change without touching the other. That means cloning a block definition (dynamic frames included) and I would not build it blind. Options: (a) as built, a schedule placed into a drawing that already holds one from the same frame keeps the old "DEPTH TO OUTLET" heading while its figures are to the pit floor, and the message tells the drafter to retype it; (b) build the private copy and prove it with Codex on a dynamic and a static frame; (c) add a small instance-owned heading text over the frame. My recommendation is (b) once a Codex slot is free.
7. **Not tested:** AutoCAD; the real `GetBlockReferenceIds` sharing check (the decision is a tested pure function, the AutoCAD call around it is not); a dynamic-block frame; net48 tests (compile only).

### 2. Item 9, #1522 downpipe double-click. PR #1676

1. **PR and head:** #1676, branch `fb/max-c-dp-dblclick`, head `dee2744f3f11e1556e822e66867fce397fd2a6e7`.
2. **Cause verified at the base:** yes. Every visible block whose outline rectangle holds the pointer counted, so a border, title block or Xref plan around DP1 made it "two blocks, ambiguous".
3. **What changed:** when exactly one CE-tagged block is under the pointer and every other block there is untagged, not a pit, and completely surrounds it (strictly outside on all four sides), the tagged block is the one. Two tagged blocks, a pit, any block that only overlaps or sits inside it, stay ambiguous (AutoCAD's own editor runs). A downpipe that is itself Xref content stays protected.
4. **Tests and totals:** Civil net10 **19,561 total, 19,538 passed, 22 skipped, 1 failed**. The failure is `RealCivilWindowRendersEverySectionWithFixedHeaderAndFooter("Light")`, a window-render test that timed out at 30 s under load; it passes alone (2 of 2). 13 new tests; 6 fail on the base. net48 build 0 errors.
5. **Real-AutoCAD check:** on a copy in millimetres make a block REVIEW_FRAME from a rectangle 90000,190000 to 110000,210000, place DP1 at 100000,200000, clear the selection and double-click the DP1 circle: the Edit source window opens. Repeat with the frame as an Xref. Erase the frame and repeat as the positive control. Put a second small symbol on top of DP1: AutoCAD's own editor runs (negative control).
6. **Skipped:** a hit test on the drawn lines instead of rectangles. **Not tested:** AutoCAD; the pixel versus drawing-point reading of the click position (untouched); Xrefs with odd extents.

### 3. Item 16, #1553 Blue Factor garden and lawn. PR #1687

1. **PR and head:** #1687, branch `fb/max-c-bluefactor`, head `ddb583d9d3b0a609dbf7cc2ca8ef7e00a917c373`.
2. **Cause verified at the base:** yes, both. Only "listed is less than the site" produced a note; and a newest report with only garden and lawn rows and no readable score counted as "nothing read".
3. **What changed:**
   1. Listed areas more than the site now add a plain note: "The catchments total 1300 m2 against a site of 1000 m2, which is 300 m2 more than the site. Check the report for an overlap or a typing error before using these areas." Warn only. Garden and lawn are still never counted as roof or paved.
   2. A report that lists garden or lawn now counts as read, so the newest report is no longer skipped for an older roof figure.
4. **Tests and totals:** Civil net10 **19,559 total, 19,537 passed, 22 skipped, 0 failed**. 11 new tests; 5 fail with the product change reverted. net48 build 0 errors. (A first full run of this branch reported only 18,797 total after I let it run past the tool time limit; it was an incomplete run and I discarded it. The clean re-run is the figure above.)
5. **Real-AutoCAD check:** in a scratch job's Civil\STORM Report - WSUD folder put two text PDFs. Newest: `Bluefactor report`, `Site area 1000 m2`, `FRONT GARDEN Garden, 600m2`, `BACK LAWN Lawn, 400m2` (no score line). Older: same header with `ROOF TO LPD Roof, 300m2`. CDDESIGN, Yes to the report search: it uses the newest report and does not offer 300 m2. Then one PDF with site 1000, roof 800, garden 500, `100%`, `SCORE`: the offer notes say the catchments total 1300 m2, 300 m2 more than the site.
6. **Skipped:** saying "zero roof and paved" instead of "not in the report" on the all-garden offer line (the note beside it already says no roof or paved catchments were found). **Not tested:** a real PDF through the real reader, AutoCAD.

### 4. Item 19, #1625 CDCALC trench-grate cover. PR #1689

1. **PR and head:** #1689, branch `fb/max-c-cdcalc-cover`, head `324bec7cf6ee36ec52cd2cf52733958a196af427`.
2. **Cause verified at the base:** yes. `CoverLevelKnown = IsRecordedLevel(pit.CoverLevel)` treated an older trench grate's "0.000" placeholder as a real RL 0.00.
3. **What changed:** one line, `CoverLevelKnown = pit.KnownCoverLevelRl().HasValue`. A TG at exactly 0.000 is unknown (no invented warning); a real 0.000 on any other pit, and negative levels on any pit, still count.
4. **Tests and totals:** Civil net10 **19,553 total, 19,531 passed, 22 skipped, 0 failed**. 5 new tests; 2 fail on the base (the TG placeholder case and the source guard). net48 build 0 errors.
5. **Real-AutoCAD check:** TG1 as a trench grate with cover text exactly 0.000, connected to a DN300 detention pipe with inverts -0.200 and -0.300. CDCALC, Detention, pick TG1 as the orifice pit, keep the water level 0.10: no "cover level of TG1 (0.00)" warning. Control: make TG1 an ordinary pit with a genuine 0.000 cover: the warning appears (Max TWL -0.15 m, reduce by 250 mm).
6. **Not tested:** AutoCAD; the whole CDCALC window.

### 5. Item 18, #1619 CDNEWDWG failed read. PR #1692

1. **PR and head:** #1692, branch `fb/max-c-newdwg`, head `3fb83e9d66f60424caa0c66e4ede15f09ef1af4f`.
2. **Cause verified at the base:** yes. A failed read (locked file, OneDrive file still downloading, damaged file) was remembered as a blank record for that folder and never retried.
3. **What changed:** a failed read now shows the details blank with a plain preview line ("CE found a job record in this folder but could not read it just now ... Change the sheet size or retype the folder to read it again; nothing is lost."), is not remembered, and is read again the next time the window looks at that folder. A folder with truly no record, and half-typed folder text, behave as before. Uses the existing `JobRecordService.TryLoad` and `Exists`; CE_SHARED not changed.
4. **Tests and totals:** Civil net10 **19,556 total, 19,534 passed, 22 skipped, 0 failed**. 8 new tests using real files (a damaged record later repaired, a record locked by another program later released); 3 fail with the failed-read handling reverted. net48 build 0 errors.
5. **Real-AutoCAD check:** keep a copy's CE_JobRecord.json open with exclusive access (or use a cloud-only file); CDNEWDWG, choose that folder: preview says it could not read the record and REF NO is blank. Release the file, change the sheet size and back: REF NO, client and address appear. A folder with no CE_JobRecord.json says no job record exists yet, as before.
6. **Not tested:** a real OneDrive placeholder download; AutoCAD.

### 6. Item 12, #1535 Manager Open logs. PR #1694

1. **PR and head:** #1694, branch `fb/max-c-mgrlogs`, head `c9585bc8170e0841d599487b020bb958f8573fe4`. Manager only; CE_SHARED not changed. Rated LOW by the review.
2. **Cause verified at the base:** yes. The warnings point at the CE log but write to `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`; `LogFoldersToOpen` listed only Civil's folder (plus Structural's two).
3. **What changed:** CEMANAGERLOGS also opens the Manager's own folder (last in the list; never listed twice; a redirected folder still wins alone, as in tests).
4. **Tests and totals:** Manager net10 **938 total, 937 passed, 1 skipped, 0 failed** (Manager's suite is in the hundreds, not thousands; the Civil suite is not touched by this change and was not run on this branch). 6 new tests; 2 fail with the new folder left out. Manager net48 build 0 errors.
5. **Real-AutoCAD check:** with Civil and Manager loaded type CEMANAGERLOGS: two Explorer windows open, one ending `\CE_CVL_SUITE\logs` and one ending `\CE_SUITE_MANAGER` holding crash_trace.log.
6. **Not tested:** AutoCAD; Manager net48 tests (compile only).

### 7. Item 17, #1617 CDRUNSOLVE message: skipped, nothing to build

1. **Why:** the review says the only fault Codex raised on #1617 is the shared depth-heading problem inherited from C-61 (same as item 8). The solver message itself is fine. #1660 fixes the heading path, so there is no separate change for #1617.
2. **Worth knowing:** I changed that heading function, so the Codex fixture on #1617 (a second schedule from the same frame keeping its heading) is covered by the same Real-AutoCAD check as item 8.

## What I did NOT test, across all six

1. **Nothing was opened in AutoCAD or accoreconsole.** No Codex run, no installed bundle read or touched.
2. **net48 was compiled only.** The four Drainage branches and the Manager branch build with 0 errors on net48; no net48 tests were run.
3. **Structural and the Installer** were not touched and not run.
4. **Environment notes, mistakes first:** the machine was heavily loaded by other builders. Two tests are flaky under load and passed alone (the PDF page render at 15 s, the Light window render at 30 s). One full run of the Blue Factor branch reported a short total (18,797) after I let a run outlive the tool time limit; I re-ran it clean (19,559) and use only the clean figure. The `obj` folder of one worktree and the shared log folder disappeared once mid-run (probably another builder's tidy-up; I did not confirm), so I restored and re-ran; no result in this report comes from that interrupted run.

## Hygiene

1. **Worktrees `C:\ce-mx\c1` to `c6` removed**, local branches deleted; the remote branches `fb/max-c-pit-depth`, `fb/max-c-dp-dblclick`, `fb/max-c-bluefactor`, `fb/max-c-cdcalc-cover`, `fb/max-c-newdwg` and `fb/max-c-mgrlogs` stay for the PRs.
2. **Free space on C: stayed at or above 14 GB at the start of every build** (lowest 14 GB; a step would have stopped under 14).
3. **Leak scan** ran on every push and was clean.
4. **My throwaway runner** `C:\ce-mx\runc.sh` and its `logs\c_*` files were deleted at the end.

Four words: **built and unit-tested. Not installed. Nobody has opened it in AutoCAD. None Tim-accepted or Codex-accepted.**
