# BUGFIX x3 report, 31 Oct 2026 (B-102, cover under a concrete driveway)

## FOR TIM
1. **ALREADY BUILT. No PR opened.** The slab-thickness setting you asked for (item 154, "7yes") has been in Civil since 29 Oct, and it is in the C-78 line (claude/rel-20261102a).
2. **What it does now.** Settings holds `minCoverPavedSlabMm` (blank = 100 mm). Footpath and Driveway rows are the table figure (100) plus the slab, so a driveway needs 200 mm from the top of the slab to the top of the pipe. Garden (300), Driveway larger vehicles (450) and Road (600) get no slab added.
3. **Worked example (from the existing tests).** Driveway pit, pipe top about 120 mm below the surface: CDRULES warns. About 220 mm below: passes, and the line reads "plus 100 mm slab". Slab 0 gives the old result (120 mm passes). Slab 150 needs 250 mm.
4. **Which surfaces count as paved** is also a Settings list (`minCoverPavedSurfaces`, default Footpath and Driveway).
5. **Not there:** a Settings page box (file-only, belongs on the Switches tab, brief CODEX_BRIEF_SWITCHES_TAB_31OCT.md) and a separate 75 mm row for reinforced concrete (nobody built one; today it is the single 100 row). Say if you want either built.
6. **Robot case (if you want one):** set `minCoverPavedSlabMm` to 0 and 100 in turn, place a pit with Surface = Driveway with the pipe top 150 mm below the surface, run CDRULES, read the R-04 line: warns at 100, passes at 0 (control).

## Technical
- Code: Modules/Drainage/Models/UserSettings.cs (~2676-2696: MinCoverPavedSlabMm, MinCoverPavedSurfaces, EffectiveMinCoverPavedSlabMm); Modules/Drainage/Rules/RulebookValues.cs (MinCoverFor ~111-135, PavedSlabMm line 141, resolve at 309-310); fingerprint in RulebookEngine.cs 336-337.
- Introduced by commit 8f2d61cd (29 Oct, GB-01 slice 2). Tests: Modules/Drainage.Tests/Rules/Gb01Slice2CoverTableTests.cs (ThePavedRows..., TheSlabThickness_IsASettingsValue_ZeroGivesTheFirstBuild, OnlyThePavedSurfacesGetTheSlab...).
- Checked: #1920 (branch fb/bug903-measure-to-pipe-top-b096) sits on #1897 and does not touch this; #1919/#1924/#1925/#1927/#1928 not read in detail since no UserSettings change was made.
- Mistake of mine: none that cost anything. I did not check the installed 3.0.85 DLL; I only confirmed the code is in origin/claude/rel-20261102a.

## NOT tested
No build, no tests, no AutoCAD run (nothing to change). Real settings folders were not listed because no test ran. C: free space was 43.97 GB at start and untouched; the worktree was removed and scratch deleted. Finished Sat 31 Oct 2026, about 5:25 PM Melbourne-clock of the PC.
