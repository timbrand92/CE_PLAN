# BUGFIX fx1885: PR #1885 (BUG-625 Level Update, Structural) tag written every time

Saturday 31 October 2026. Branch claude/bug-625-level-update-ce-mark-only-s1026, new head 529155aa (was 044cf047).

## FOR TIM

1. **What changed:** every level mark CE draws (FFL, RL, SSL, NGL) now carries the invisible CE_LEVELMARK tag, whether the Settings tick box "Level Update only changes CE level marks" is on or off. Before, with the box off, new marks had no tag and Level Update could not find them later.
2. **What the box still controls:** only Level Update (LMU). On = LMU changes only text that is the value of a CE level mark and leaves other notes alone. Off = LMU rewrites every text you pick, exactly as the old version did. Drawing a mark is the same either way, apart from the invisible tag (you cannot see it).
3. **What to try in AutoCAD (for the robot or Codex):** with the box off, draw an RL mark, tick the box on, run LMU and pick that mark's value text: it should be accepted and changed. Then pick an ordinary note: it should be left alone.
4. **Tested:** one new check fails on the old head and passes now; the 17 level-mark checks in Structural pass (net10).
5. **NOT tested:** nothing was drawn or run in AutoCAD. The tag write is inside the drawing command, so the check reads the source, it does not draw a mark. net48 was not built. Preview and Apply for LMU is still not built, so BUG-625 can only be partly fixed.

---

## Technical

1. **Code:** Modules/Structural/Commands/LevelMarkCommands.cs, the "if switch" around the tag write on the new value label was removed; the tag is always written.
2. **Test:** LevelMarkRecognitionTests.NewLevelMark_TagIsWrittenWhateverTheSwitchSays (reads the command source, asserts no switch reference between the label creation and `label.XData = tag`). Run on the old head: 1 failed, 16 passed. After: 17 of 17 passed. Command: dotnet test on CE_STRUC_SUITE.Tests net10.0-windows, filter LevelMarkRecognitionTests, with SkipDevBundle, scratch env vars set to C:\CE_WORK\scratch\fx1885.
3. **REGRESSION_LOG.md:** one entry added at the top.
4. **Not done (reviewer's other note):** recording the older-mark position fallback against the BUG-625 carpark wording is for CE 00; BUG_CARPARK.md untouched.
