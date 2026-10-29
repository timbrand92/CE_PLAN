# Opus code-read pre-review, group B: the guidebook stack (Thu 29 Oct 2026, build B-043a)

Read-only. I read every diff in full (PR heads: #1841 `78fda55b`, #1842 `e7ab72eb`, #1843 `f0bc12a9`, #1849 `0e7ee62b`, #1850 `fab2cc6c`, and #1848 `3261cf8f` for the clashes), the B lines in the build register, the regression-log entries and the Sonnet pre-review sections, and I read the surrounding code on each PR branch. I tested the merge order with `git merge-tree` dry runs (nothing checked out, nothing written to any branch). No build, no test run, no AutoCAD, nothing posted on GitHub, no PR touched.

## FOR TIM

1. **Answer:** two of the five need something before they go into a train. The other three are fine to merge with a note.
2. **#1850 (cover by surface) needs one answer from you.** It lets a pipe under a concrete driveway pass with 100 mm cover, measured from the top of the driveway. The standard's 100 mm (75 mm for reinforced concrete) is measured **below the underside of the slab**, not from the top.
   1. Example: a 125 mm driveway slab with a pipe 120 mm down. The top of the pipe is inside the slab, and CDRULES says OK. Under the standard's measure it needs about 225 mm from the top.
   2. Your "Keep as built" confirmed the numbers. The question you were asked did not say the paved rows are measured below the slab. So I am asking, not deciding.
   3. **My recommendation:** keep 100 / 75, and add one Settings value for slab thickness (start it at 100 mm). CE then judges the driveway and footpath rows from the top as 100 + slab.
3. **#1850 also has a smaller question.** In Frankston the council's 250 mm replaces the whole table, so a pipe under a **road** there passes with 300 mm, not 600.
   1. **My recommendation:** use whichever figure is bigger, the council's or the table's. Frankston's 250 then works as a floor, which is how their page reads.
4. **#1843 (lid class) needs a one-row fix first.** If a drafter types the surface instead of picking it, "driveway for larger vehicles" gets a **Class B** lid. Picked from the list it gets C, which is right.
   1. The fix is one extra row in the lid chart: "larger vehicles" = C.
5. **#1841 (falls 1 in 100) is OK to merge as you ruled. It does not fix BUG-1091**, even though the register lists it as that fix.
   1. Once someone types a figure for 450 mm and larger pipes, Edit Pipe and CDRULES will use it. Civil Design, auto-design and network redesign still will not.
   2. Example: you set 1 in 200 for big pipes. A 450 carrying 30 L/s is held to 1 in 200 on the Edit Pipe strip, but redesign still proposes about 1 in 890. That is the exact BUG-1091 symptom.
   3. Today nobody has typed a figure, so all the screens agree for now. BUG-1091 stays open.
6. **#1841: the "Stale once" marker misses one case.** If your office ever edited the grade list by hand, old saved CDRULES runs do not turn Stale, even though some answers changed. The fix is one line.
7. **#1841: expect every saved CDRULES run on the robot's test copies to show Stale once.** Re-run CDRULES on those copies before the timing cases, or they will be counted as failures.
8. **#1842 (pit size table) changes nothing a drafter sees.** I checked every depth band: same pit size as today.
9. **#1849 (pipes under garages):** fine to merge, with three notes.
   1. Every job shows two "not checked" rows until the office types its garage and dwelling layer names.
   2. Outlines inside an architect's Xref are not read. On most real jobs, that is where the house outline lives.
   3. The older-AutoCAD (net48) build still has to be run once before it goes into a train.
10. **Merge order:** #1842, then #1843, then #1849 is right, and those three merge with no clash.
    1. #1841 clashes with them in three files. #1848 and #1850 clash with them in one file.
    2. Every clash is two additions at the same spot. Keep both sides; no code has to be chosen between.
    3. One trap: #1843 points at #1842's branch, not the release branch. Merging #1843 on its own puts it into #1842's branch. Merge #1849's branch, which already holds all three, or have the base changed first.
11. **Safety:** none of the five makes a new drawing change, regen, view change or system-variable change, and none unlocks or writes to anything. #1849 only reads polylines.
12. **My own mistakes:** none that cost a test run. The GitHub tool was not on the shell's path, which cost a minute. I did not build or run any test, so everything here comes from reading the code, not from running it.

---

## How each check was done

1. **OFF returns old behaviour:** none of the five has an ON/OFF switch. #1841 and #1843 have none by your ruling (decision 26 point 4; decision 24 item 5). #1842 changes no answer. #1849 does nothing until its layers are named. #1850 has no switch, but an empty table `{}` in Settings gives exactly the old single-300 answer (see #1850 finding 4).
2. **REDO safety:** I searched every added line of all five diffs for `StartTransaction`, `StartOpenCloseTransaction`, `SetSystemVariable`, `SendStringToExecute`, `Regen`, `UpdateScreen`, `LockDocument`, `Application.Idle`, event `+=`, `OpenMode.ForWrite`, `UpgradeOpen`, `IsLocked` and Xref calls. **Zero hits in all five.** The only drawing access is #1849's `BuildingOutlineReader.Read`, which opens model space and entities `ForRead` inside the transaction it is handed.
3. **Locked layer / Xref / REFEDIT:** nothing in the five writes to the drawing, so nothing can go around a lock. #1849 skips outlines inside blocks and Xrefs and says so; it does not open them.
4. **Warnings never block (R-27):** every new finding is a Warn, Pass or Unknown row. No command stops.

---

## #1841 B-042, GB-01 slice 1: falls 1 in 100, a separate blank row for DN450 and up, detention 1 in 200 in four councils (no switch, by Tim's ruling)

**What I verified:**

1. **The stray build file Sonnet found is gone.** Commit `78fda55b` removes `CE_CVL_SUITE_*_wpftmp.csproj`. The head is now `78fda55b`, not the register's `bf2dd0c4`.
2. **The saved-ladder move is real and correct for files that hold exactly the old ladder.**
   1. `SettingsService.cs:286` calls `ResolveRetiredMinGradeLadder` inside `LoadSettings`.
   2. The settings read uses `ObjectCreationHandling.Replace` (`SettingsService.cs:755`, `:767`), so the stored dictionary arrives whole, never merged with the new seed.
   3. A file holding the 11-row old ladder (the only ladder ever shipped: `git log -S` shows one seed, `363484fa`, 4 Sep) has count 11 and equal values, so it moves.
   4. The two other readers (`WithRememberedValues`, `TrySerializeDetached`) round-trip settings that have already been moved, so they need no move of their own.
3. **The Stale once works for the ordinary case.** The criteria fingerprint serialises the whole stored `office` object (`RulebookValues.cs:320-331`). A moved ladder changes it once, and it stays stable afterwards. The new council field `detentionGuideGradeN` is inside the fingerprinted `council`, so only the four councils move. Blank new keys are `NullValueHandling.Ignore`, so they are not written.
4. **REDO and layers:** no drawing access in any changed file.

**Findings:**

1. **MEDIUM: BUG-1091 is not fixed; the big-pipe figure never reaches Civil Design, auto-design or redesign.**
   1. **Where:** `Services/SettingsSizingStandards.cs:103`. `ForEveryMaterial` passes `GradeLadder(office, StandardGradeSizesMm)`, and `StandardGradeSizesMm` (`:32-33`) is the keys of `CreateAs3500MinGradeByDiameter()`, which are 90 to 375 only. `EffectiveMinGradeLadder()` adds 450 and up once `largeGravityMinGradeN` is typed, but the filter drops those rows.
   2. **The test does not catch it:** `WhenTheLargePipeRowIsFilled_EveryScreenSeesIt` checks `ForMaterial` and `RulebookValues` only, not `ForEveryMaterial`.
   3. **Drafter consequence:** after the office types 200 for big pipes, the Edit Pipe strip and CDRULES hold a DN450 to 1 in 200. Network redesign still proposes about 1 in 893 for a DN450 carrying 30 L/s (concrete roughness), which is the BUG-1091 carpark symptom. While the row is blank, all screens agree (none checks), so nothing is wrong today.
   4. **Fix:** in `ForEveryMaterial`, let through every key of `EffectiveMinGradeLadder()` at or above `office.LargeGravityFromMm` as well as the standard sizes, and add `ForEveryMaterial` to that test. The register should not call this the BUG-1091 fix.
2. **MEDIUM: "Stale once" is missed by an office that has ever edited its ladder.**
   1. **Where:** `Rules/RulebookValues.cs:320-331`. The fingerprint holds the raw stored ladder, not the ladder actually used.
   2. **Example:** an office whose ladder was edited (say DN300 = 1 in 180) runs a job in Kingston. A DN450 gravity pipe at 1 in 300 used to Warn ("flatter than 1:200"); now it is Unknown ("no minimum fall set"). R-32 rows vanish in every council except the four.
   3. The stored ladder did not change, the council profile did not change, and the retired every-council setting was never fingerprinted. So the saved run is not marked Stale, while a fresh run answers differently.
   4. **Fix (one line):** add a fixed marker to both fingerprint objects, for example `criteriaRevision = "gb01-slice1"`. Every saved run then goes Stale once, whatever the office ladder holds.
3. **LOW: the "one-time" move runs at every start, and is announced only in the CE log.**
   1. **Where:** `SettingsService.cs:286`. Nothing gates it the way BUG-825 gates the other moves (`firstOldValueMove`). An engineer who deliberately types back exactly the old 11 rows has them moved again at every AutoCAD start.
   2. The step-iron move tells the drafter on the command line (`QueueWarning`); this one writes `LoggingService.Info` only.
   3. **Fix:** a new once-only flag in `Options`, and one `QueueWarning`.
4. **LOW (confirms Sonnet's finding 2): typed big-pipe rows in an edited ladder are kept in the file but ignored.**
   1. **Where:** `UserSettings.cs`, `EffectiveMinGradeLadder` (`dn >= from` → `continue`).
   2. Not tested.
   3. **Fix:** when an edited ladder holds rows from 450 up and the big-pipe row is blank, say so once in the R-03 settings line printed by CDRULES.
5. **LOW: a size between 375 and 450 (for example a pipe recorded as DN400) now has no minimum anywhere.**
   1. `RulebookValues.MinGradeFor` and `PipeGradeAdvisorService.LookupMinGradeForDiameter` take the next larger entry. There is none now; before, it was the 450 row at 1 in 200. CDRULES says "no minimum grade in the rulebook ladder for DN400".
   2. **Fix:** below `LargeGravityFromMm`, fall back to `OrdinaryMinGradeN()`.
6. **LOW: in the four councils, a detention pipe of 225 and up returns R-03 Pass before the project's drafting-warning grade is checked** (`RulebookEngine.cs`, the new `isDetention` branch). A project drafting warning of, say, 1 in 150 is never raised for those pipes.
   1. **Fix:** apply the `DraftingFlatGradeN` check before returning the R-32 hand-over Pass.
7. **LOW (consequence, by ruling):**
   1. Auto-design and Civil Design now lay DN225 to DN375 at 1 in 100 instead of 1 in 200 to 1 in 300. On a 30 m run that doubles the fall from 150 mm to 300 mm, so downstream pits come out deeper on every auto-designed job.
   2. The "ladder confirmed" tick is cleared with the move, so the ladder rows read Assumed until someone ticks them again.
   3. Every saved CDRULES run in the robot's test copies shows Stale once; re-run CDRULES there first.
8. **LOW (cosmetic, after merge with #1849):** the `RuleDetentionGuideGrade` summary at `RulebookEngine.cs:36` still says "CE's own design guide ... 1 in 200" for every council.

**REGRESSION_LOG:** honest about the ruling, the Stale once and the Edit Pipe gap. It does not mention finding 1 or finding 2.

**Proof case:** N41_gb_fall300. On a copy, draw a DN300, 18 m, 90 mm fall (1 in 200); run CDRULES and read the R-03 row "flatter than 1:100" (Warn). Control in the same case: a DN300 at 1 in 90 reads Pass. Then a DN600 at 1 in 300 reads Unknown "no minimum fall set for this size".

**Verdict: KEEP-WITH-NOTE.** Merge as Tim ruled. Finding 2's marker is a one-line follow-up worth folding in before the train. Finding 1 must be fixed before anyone types a big-pipe figure. BUG-1091 stays open.

---

## #1842 B-044, GB-01 slice 5: pit size by depth moves to Settings (no switch; no answer moves)

**What I verified:**

1. **Every shipped answer is unchanged.**
   1. The governing size is now chosen by plan area instead of tier number. With the shipped table, area order equals the old tier order (122,500 < 202,500 < 360,000 < 540,000 < 810,000 mm²), so the bigger of pipe-fit and depth gives the same size.
   2. A tie gives the same size.
   3. The notes ("Pipe-fit governs / Depth governs / agree"), the step-iron start (area ≥ 600 x 900), the not-positive-depth guard and `MaxDepthForSizeM` all match the old code.
2. **The fallback is never half-used.** An unusable table falls back to the shipped table, with one plain note.
3. **The fingerprint does not move:** a blank table is not written and adds nothing to it.
4. **One code path:** `PitSelector.Select` is the only reader (the R-29 area of `RulebookEngine.cs:278`, `PitSetupAdvisorService.cs:125`). There is no other copy of the depth table in product code.

**Findings:**

1. **LOW: `RulebookValues.Resolve` now reads the global `SettingsService.Current`** (the fingerprint tail, `RulebookValues.cs` at the end of `Resolve`).
   1. Until now this method used only what it was handed. A caller that passes a different office still gets the current user's pit table in the fingerprint. #1849 repeats the pattern for `draftingChecks`.
   2. **Fix (later):** pass the pit settings in, as `office` is.
2. **LOW (agree with Sonnet):** the step-iron start and the pipe-fit table are still in code. A saved table that equals the shipped one still moves the fingerprint once, harmlessly.
3. **LOW (disclosed):** there is no Settings page row.

**REGRESSION_LOG:** honest.

**Proof case:** C42_pit_depth_edges. Using the pit advice on five copies of one pit at depths 0.45, 0.46, 0.91, 1.20 and 1.21 m with a DN100 pipe, read the sizes 350x350, 450x450, 600x900, 600x900 and 900x900. That matches today's answers, so no control is needed.

**Verdict: KEEP.**

---

## #1843 B-045, GB-01 slice 4: lid class, driveway B and larger vehicles C (stacked on #1842; no switch, by Tim's ruling)

**What I verified:**

1. The Pit window quick pick and the pit advice now answer an exact quick-pick name from the one table, `pit.lidClassBySurface`. Driveway = B, "Driveway (larger vehicles)" = C.
2. The saved-table move only fires on exactly the four old rows (`SettingsService.ResolveRetiredLidClassBySurface`).
3. No CDRULES rule reads the lid class (`git grep` in `Rules/`: none), so leaving the fingerprint alone is right.
4. Existing pits keep their stored lid. The UX-LID-02 check flags only a heavier suggestion, so an existing driveway pit with Class C is never flagged.

**Findings:**

1. **MEDIUM: a typed surface with "driveway" in it now gets Class B unless it also contains one of the four heavy words.**
   1. **Where:** `Services/LidClassChart.cs:20-29` (the shipped words chart). It has "driveway" = B, but no row for "larger vehicles", Tim's own words.
   2. **Example:** surface typed "Driveway for larger vehicles" or "Commercial driveway" gives Class B. Picked from the list as "Driveway (larger vehicles)" it gives Class C. Before this PR every driveway was C.
   3. **Drafter consequence:** a lighter lid is advised where vans and trucks drive.
   4. **Fix:** add the row `{ Use = "larger vehicles", LidClass = "C" }`. Heaviest wins, so it overrides "driveway". Whether "commercial" and "industrial" should also be C is a question for Tim, not added here.
2. **LOW (confirms Sonnet's finding 1):** "heaviest wins" changes two mixed-word answers, both to the heavier, safe side. "Landscaped pedestrian path" goes A to B; "trafficable residential" goes B to C.
3. **LOW:** the saved-table move runs at every start with no once-only flag, and is logged only (same pattern as #1841 finding 3).
   1. An engineer who deletes the new row and sets Driveway back to C gets it moved to B again at every start.
4. **LOW (disclosed):** two vocabularies, and no Settings page row for the words chart.

**REGRESSION_LOG:** honest.

**Proof case:** C43_lid_driveway. In the Pit window on a copy, set Surface = Driveway and read the suggested lid "Class B". Set Surface = "Driveway (larger vehicles)" and read "Class C". Then type the surface "Driveway for larger vehicles" and read Class C (it reads B today, before the fix).

**Verdict: FIX-FIRST** (finding 1, one row and one test).

---

## #1849 B-048, GB-01 slice 4: pipes under garages, R-33 (stacked on #1843; no switch; dormant until the layers are named)

**What I verified:**

1. **Read-only and REDO-safe.**
   1. `BuildingOutlineReader.Read` walks model space `ForRead` inside the caller's transaction: `ProjectDataService.RulebookDrawing.cs:233`, and through `ReadRulebookLiveSnapshotInTransaction` also inside Proposal Apply (`ProposalApplyService.cs:250`). Reads only.
   2. With no layer named it returns before touching the drawing.
2. **The fingerprint does not move** while the group is blank: `"{}"` is not appended. An unread drawing serialises exactly as before (`RulebookDrawingSnapshot.cs`).
3. **The pipe route is read for the one-piece pipe object as well,** through `PipeGeometrySeam.TryOpenPipeForRead`, so pipe objects are not skipped.
4. **Material words match real CE names:** CE's own catalogue label is "UPVC SN8" (`CatalogueService.cs:108`), so the shipped words match.

**Findings:**

1. **MEDIUM (agree with Sonnet's finding 1):** two Unknown R-33 rows on every job until the office types layer names. There is no Settings page box (`UserSettings.cs`, `DraftingChecksSettings`).
2. **MEDIUM (process):** net48 compile not run, by the PR's own log. It must compile on net48 before any train.
3. **LOW: on most real jobs the dwelling and garage outline arrives in the architect's Xref.** Those are not read, so R-33 stays Unknown there.
   1. **Fix (later, reviewed workflow):** read closed polylines inside Xrefs read-only, by layer `XREF|name`. That needs Tim's word under the native-protection rule.
4. **LOW: the material test needs the text to contain both "UPVC" and "SN8"** (`RulebookEngine.cs`, `PipeUnderBuildingRules`).
   1. A pipe recorded "PVC-U SN8", or "UPVC" with the class elsewhere, warns even when it is the right pipe.
   2. **Fix:** add "PVC-U" as an allowed spelling, or let the words be alternatives.
5. **LOW:** a pipe running exactly along a wall or touching a corner is not "under". Strict crossing is used in `PipeBuildingOverlap.SegmentsCross`.
6. **LOW:** once layers are named, the whole model space is walked on every Checks refresh and on every Proposal Apply. It is not measured on a big drawing.

**REGRESSION_LOG:** honest. It says the drawing reader was never run in AutoCAD and net48 was not built.

**Proof case:** C49_garage_r33. On a copy with a closed polyline on the garage layer named in Settings, draw a DN100 UPVC pipe crossing it. CDRULES R-33 reads Warn "only 150 UPVC SN8 may go under a garage". Control: the same pipe changed to DN150 "UPVC SN8" reads Pass. With the layer name cleared, the case reads one Unknown row "No garage outline layer is named".

**Verdict: KEEP-WITH-NOTE** (net48 compile before the train).

---

## #1850 GB-01 slice 2: minimum cover by the pit's Surface (stacked on #1848; no switch)

**What I verified:**

1. A council figure or a project override wins (`RulebookValues.MinCoverFor`).
2. No surface, or a surface not in the table, keeps the single office minimum.
3. The fingerprint moves only for a job that has a surface on any pit (`RulebookEngine.cs`, `input["coverTable"]`), which is right because only those answers change.
4. No drawing access at all.

**Findings:**

1. **HIGH (engineering, needs Tim's word before it ships): the paved rows are measured from the wrong level.**
   1. **Where:** `UserSettings.cs`, `ShippedMinCoverBySurfaceMm` (Footpath 100, Driveway 100). `RulebookEngine.CoverRules` measures from the pit cover level (finished surface) to the outside top of the pipe.
   2. **The standard:** Table 6.2.5's paved rows are "below the underside of the pavement". CE_PLAN's own notes say so: `02_COUNCIL_RULES/COUNCIL_FRANKSTON_DEV_GUIDELINES.md:82` "100 below underside of pavement"; the GB-01 card item 3 and `GUIDEBOOK_V1_3_VS_CE_AUDIT_2026-10-29.md:46` "100 or 75 below reinforced or plain concrete".
   3. **Example:** the PR's own test `ThePaverDrivewayExample_APipeUnderAConcreteDriveway_At120Cover_NowPasses` passes a pipe 120 mm below the finished surface of a concrete driveway. With a 125 mm slab, the top of the pipe is inside the slab.
   4. Under the standard's measure, unreinforced concrete needs about 225 mm from the top (100 + 125) and reinforced about 200 mm (75 + 125).
   5. Tim's "Keep as built" confirmed the numbers. The question he answered did not say the paved rows are measured below the slab, so this is an open question, not a decision.
   6. **Fix (after Tim answers):** a Settings value "pavement thickness under driveway and footpath, mm" (start 100), with the paved rows judged as row + thickness. Or Tim restates the rows as finished-surface figures.
2. **MEDIUM (Tim's call): a council figure replaces the whole table, even where the table is stricter.**
   1. **Where:** `RulebookValues.MinCoverFor` (`officeOnly` false → return the council figure).
   2. **Example:** a Frankston pit with Surface = Road and a pipe at 300 mm cover passes against Frankston's 250. The Road row of 600 is never looked at. Frankston's page reads "all pipes min 250", which is a floor.
   3. **Fix (if Tim agrees):** use the larger of the council figure and the table row. The test `ACouncilFigureStillWins_EvenOverARoadRow` would then flip.
3. **LOW: the "Driveway (larger vehicles)" row can only be reached once #1843 has merged,** because that quick-pick name is added by #1843, not by #1848 or #1850. Merge #1843 before #1850.
4. **LOW: there is no switch, but an empty table `{}` in Settings returns exactly the old single-300 answer.** `EffectiveMinCoverBySurfaceMm` returns no rows, so `MinCoverFor` falls back. It is untested.
   1. **Fix:** one test pinning `{}` = the old answer, so the office has a known way back.
5. **LOW (disclosed):** the Edit Pipe strip, Civil Design, auto-design and the pit editor still use the single office number (B-022 / BUG-903).

**REGRESSION_LOG:** honest about the source and the screens it does not reach. It does not mention that the paved rows are measured from the finished surface.

**Proof case:** C50_cover_driveway. On a copy, a pit with Surface = Driveway and a DN150 at 150 mm cover to the outside top: CDRULES R-04 reads Pass "(Driveway surface, office cover table)". Control: the same pit with the surface cleared reads Warn "below 300 mm". This proves the code, not the engineering; finding 1 needs Tim first.

**Verdict: FIX-FIRST.** Hold it out of the train until Tim answers finding 1; finding 2 goes in the same question.

---

## Merge order and clashes (tested with `git merge-tree`, base `origin/claude/rel-20261026z`)

1. **#1842 → #1843 → #1849 is right.** #1849's head contains all three and merges onto the release branch with **no conflict at all**.
2. **Base trap:** #1843's base is `claude/gb01-slice5-pit-sizes` and #1849's is `claude/gb01-slice4-lid-class`. Merging #1843 or #1849 on GitHub as they stand puts them into the branch below, not the release branch.
   1. The finalizer must either merge #1849's branch (all three) into the train, or have the bases changed. Under D6 this review does neither.
3. **#1841 against the stack (either order): `RulebookEngine.cs`, `RulebookValues.cs`, `SettingsService.cs`, plus `REGRESSION_LOG.md`.** Every hunk is two additions at the same spot. Keep both sides in each:
   1. `RulebookEngine.cs`: #1849's two R-33 methods and #1841's `CouncilGuideWords`.
   2. `RulebookValues.cs`: #1849's four garage properties and #1841's `OrdinaryGradeN` / `LargeGravityFromMm`.
   3. `SettingsService.cs`: both one-time moves, and both `Resolve...` helpers.
4. **#1848 against the stack: `RulebookValues.cs` and `REGRESSION_LOG.md`.** #1848 adds a two-line comment where #1849 adds the drafting block and #1842 the pit-table tail. Keep all three.
   1. No side reassigns `CriteriaFingerprint` (all use `+=`), so no fingerprint tail is lost.
5. **#1848 against #1841:** `REGRESSION_LOG.md` only.
6. **#1850 against the stack:** `RulebookValues.cs` (keep both). **#1850 against #1841:** `UserSettings.cs` (both add to `DesignStandards`; keep both).
7. **Recommended order:** #1842, #1843, #1849 (one merge of #1849's branch), then #1841 (hand-merge three files, keep both), then #1848. Then #1850, only after Tim's answer and after #1843.
   1. If #1841 rides C-77 alone and the stack comes in C-78, the same three-file hand merge falls to the C-78 finalizer.
   2. `REGRESSION_LOG.md` clashes on every pair; keep every entry.
