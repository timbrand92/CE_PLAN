# BUGFIX x4 report, B-103: Frankston cover uses the bigger figure (31 Oct 2026)

## FOR TIM

1. **Answer: ALREADY DONE. No PR opened.** The rule "Frankston cover is whichever is bigger, the council's 250 mm or the table figure for the surface" is already in the Civil line rel-20261102a (Civil 3.0.88), built by the commit 8f2d61cd ("GB-01 slice 2", QUESTIONS 60, the same commit the driveway slab job x3 found).
2. **What a drafter sees now (built, unit-tested, not yet seen in AutoCAD).** In a Frankston job, a pipe end in a pit under a Road is checked against 600 mm, not 250. A Garden is checked against 300. A Driveway whose table figure plus slab is only 200 mm is checked against the council's 250 mm. In every case you get a warning, never a block.
3. **Council value.** The 250 mm is a council value. It lives in council data, not in code: Modules/Drainage/Assets/Config/council-profiles.json line 379 (Frankston, minCoverMm 250.0, recorded as "Tim R-04, 2026-09-04"). It is not hard-coded.
4. **Switch.** Settings value "minCoverCouncilFigureIsFloor" (blank means ON). OFF returns the old behaviour exactly: the council figure always replaces the table, so a Road in Frankston passes at 250.
5. **Needs you.** Please confirm the 250 mm against the Frankston council document. The profile's own warning text says "All pipes to have min 250mm cover" but the record is an office rule from your R-04 answer, not read from the council PDF in this job.

## Technical detail

1. **Where it lives (checked on origin/claude/rel-20261102a).**
   - Floor logic: Modules/Drainage/Rules/RulebookValues.cs, method MinCoverFor, lines 127 to 138 (the branch "Source == Council && CouncilFigureIsFloor" returns the bigger of table and council figure); property CouncilFigureIsFloor line 147; read from Settings at line 311.
   - Switch: Modules/Drainage/Models/UserSettings.cs lines 2688 to 2697 (MinCoverCouncilFigureIsFloor, CouncilCoverFigureIsFloor() returns true when blank); kept in the Settings reader at RulebookValues.cs line 485; passed to the engine at RulebookEngine.cs line 338.
   - A project override (MinCoverMmOverride) still beats both, as Tim ruled.
2. **Tests that already cover the asked cases** (Modules/Drainage.Tests/Rules/Gb01Slice2CoverTableTests.cs, around lines 129 to 155, and Gb01Slice3PitDepthTests.cs line 127):
   - table above 250 gives the table figure: Road 600 and Garden 300 under Frankston.
   - table below 250 gives 250: Driveway 100 + 100 slab = 200, council 250 applies.
   - switch OFF returns the old behaviour: Road passes at 250.
   - default blank = ON is asserted.
   - Other councils unchanged: the floor branch only applies when the figure's source is Council; no other council profile was altered.
3. **Overlap check.** No change made, so no clash with draft PRs #1897, #1920, #1919, #1924, #1925, #1927, #1928.
4. **Worked example.** Frankston, pit in a Road, pipe crown 346 mm below finished surface. Old behaviour: 346 is at least 250, pass. Now: 346 is below 600, warning "below 600 mm". Same pit in a Driveway with 200 mm of cover below the slab: warning "below 250 mm".
5. **Robot case suggestion (not built here).** Name F103_frankston_cover_floor. Open a Frankston test job, set a pit surface to Road, set a pipe end with 346 mm cover, run the rulebook check, expect the line "below 600 mm"; control: set minCoverCouncilFigureIsFloor to false in Settings, rerun, expect pass with no "office cover table" text.

## What I did NOT test

1. I ran no build and no tests this job (no code change was needed), so there was no real-files before/after listing to make.
2. I did not run the tests above myself; I read them. Their result on rel-20261102a is whatever the earlier build lanes recorded.
3. Nothing was looked at in AutoCAD.
4. I did not check the 250 mm against the Frankston council document.

## Housekeeping

1. No worktree was created and no bin/obj built; the scratch folder C:\CE_WORK\scratch\x4 held only three empty folders and is removed.
2. C: free space: 43.74 GB at start, 43.67 GB at the end (about 0.07 GB moved, other activity on the PC).
3. Finished Sat 31 Oct 2026, about 5:25 pm Melbourne time (system clock read 5:18 pm at start).
