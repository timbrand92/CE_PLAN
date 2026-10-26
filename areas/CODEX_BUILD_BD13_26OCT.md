1. **ANSWER FIRST — BUG-1103: DONE for this build brief.** Built and unit-tested only. The carpark and desk registers were not edited. No AutoCAD acceptance is claimed.

2. **Draft PR and branch:** [PR #1806](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1806), OPEN and draft, against `claude/rel-20261025r`. Branch: `cx4/bug-1103-charged-diameter-sense`. Branch head: `c68c5db4328a4104808546f6b8519fb27af22413`.

3. **Both base heads:** the head named in the brief was `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. The actual release head after the initial fetch, used for the untouched-base run, was also `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. The final fetch and merge check found that same head; Git reported “Already up to date.” No rebase was used.

4. **Red first:** product source was unchanged. The new file `Modules/Drainage.Tests/ViewModels/Bug1103ChargedDiameterSenseTests.cs` compiled against the old product, using reflection for the switch that did not yet exist. The Bug1103-only run executed 13 cases: 7 passed, 6 failed. Actual carpark failure:

   ```text
   Failed ChargedSystem_Bug1103_PipeDiameter150_WarnsItTakesMetres [3 ms]
   No diameter warning for 150; the box must say it takes metres.
   Expected: String containing "150" and containing "0.15" and containing "metres"
   But was: <string.Empty>
   ```

5. **Green lines and tests added:** 25 new BUG-1103 cases cover both boxes, the shipped sizes, exactly 2 m and just above it, invalid entries, unchanged results, the default-on switch, older settings, a saved OFF, wording in another language setting, shared warning wiring, Settings rows, round-trip/reset, and six off-screen pictures. All 79 focused checks passed, including the existing Charged System and head-warning tests. These passing lines are from the final focused run:

   ```text
   Passed ChargedSystem_Bug1103_PipeDiameter150_WarnsItTakesMetres
   Passed ChargedSystem_Bug1103_DownpipeDiameter100_WarnsItTakesMetres
   Passed ChargedSystem_Bug1103_ShippedStartingValues_AndTwoMetres_DoNotWarn
   Passed ChargedSystem_Bug1103_ItWarnsAndNeverBlocks_TheResultsStillShow
   Passed ChargedSystem_Bug1103_SwitchOff_NoWarning_AsBefore
   Passed TheSwitch_ShipsOn_AnOlderFileLoadsItOn_AndATypedOffIsKept
   Total tests: 79; Passed: 79
   ```

   A further run passed all 26 checks comprising the corrected existing Settings row-list check and all 25 new BUG-1103 cases. The project was `Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj`, Release, net10.0-windows.

6. **Full suite before and after:** console totals on the untouched base: **20,380 total; 20,345 passed; 3 failed; 32 skipped**. Final run: **20,405 total; 20,371 passed; 2 failed; 32 skipped**. The actual failing-name comparison returned **no new failures**.

   Before: `Diagnostic_MessagesReachTheLogFile`; `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`; `RetainedPaletteFollowsThemeAndDiscardWithoutLosingItsPage("found","light")`.

   After: `Diagnostic_MessagesReachTheLogFile`; `RetainedPaletteFollowsThemeAndDiscardWithoutLosingItsPage("found","light")`. The base PDF-render failure did not repeat. Both base and final runs also reported the same locked test-log error during teardown. This is not a claim of an entirely passing full suite.

7. **What Tim will see in AutoCAD:** on a build containing this change, CDCALC → Charged System → type 150 in Pipe diameter. The results, including 26.15 L/s, still show, with: **“Pipe diameter 150 m is over 2 m. This box takes metres: type 0.15 for a 150 mm pipe.”** Downpipe dia 100 gives: **“Downpipe diameter 100 m is over 2 m. This box takes metres: type 0.1 for a 100 mm downpipe.”** The boxes still take metres. The warning never stops the calculation.

8. **Exact real-AutoCAD check still required — not run:** on copies, check both the 2027 and 2024 lanes. Type `CDCALC`, choose **Charged System**, type **150** in **Pipe diameter (m)** and press **Tab**. Look for the exact pipe warning in item 7, with results still shown. Change the pipe to **0.15**, press Tab: no diameter warning. Leave the pipe at 0.15; type **100** in **Downpipe dia (m)**, press Tab and look for the downpipe warning. Restore **0.1**, press Tab: no diameter warning. The shipped sizes 0.15 and 0.1 and exactly 2 m must stay free of diameter warnings.

9. **The one number chosen for Tim:** **2 m**, from the audit suggestion, is a typing sense check, not an engineering limit. Tim can change `DiameterSenseLimitMetres` in `Modules/Drainage/ViewModels/ChargedSystemCalcViewModel.cs`. No engineering calculation or engineering value was changed.

10. **What was not run:** AutoCAD was never started; CDCALC and Settings were not opened on screen in AutoCAD. Nothing was installed or deployed. The six inspected pictures are real WPF windows rendered off-screen, not AutoCAD screenshots. An independent Opus review was not run in this builder session.

---

11. **Build evidence:** Release builds of `Modules/Drainage/CE_CVL_SUITE.csproj` for net48, net8.0-windows and net10.0-windows each finished with **0 errors**. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and all three reference parameters from the brief:

   ```text
   -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
   -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
   -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
   ```

   Absolute project paths were used. The final full run used the just-built test assembly with `--no-build --no-restore`, no test filter, and the same safe flags and references. AutoCAD's library folder was on the test process's PATH; this did not start AutoCAD.

12. **Settings switch and window fit:** `detention.chargedDiameterSenseWarning` / `ChargedDiameterSenseWarning` starts ON, including an older file with no key; a saved OFF is kept. It sits next to `ChargedMinHeadWarning` in the settings model. The new Design-page row uses the existing changes marks, search, reset and save. The measured tallest page remains **670 px**, below **673 px**. The Manager copy uses its existing row style. Only the required Settings rows changed in XAML; `CalculationsV2Dialog.xaml` is unchanged. The sibling head-warning switch has no Settings row at this base; no row for that separate bug was added.

13. **Tests and source guard:** added `Bug1103ChargedDiameterSenseTests.cs` and `Bug1103ChargedDiameterRenderTests.cs`. Extended `Bj32CivilSettingsRowsTests.cs`, `Bj32SettingsPersistenceTests.cs`, `SettingsWindowV3Tests.cs` and the C66/C67/C68 switch-default tests. The source guard checks both diameter calls use one helper and the metre labels remain. `ChargedUnknownDisplayTests`, `ChargedResultAvailabilityRegressionTests` and `ChargedSystemCalcViewModelTests` passed with their existing checks. New settings checks use synthetic settings in memory and a captured save candidate; no live settings file was read or written by them. The wider existing suite uses its own temporary test files.

14. **A missed check, corrected openly:** the first full run after the change reported 20,405 total, 20,371 passed, 2 failed, 32 skipped. Its second failure was NEW: `EveryBinding_NamesARealValue_SoNothingIsSilentlyUnbound`, because I had not extended the test's exact expected row list. I added the new row name without weakening the check; all 26 focused checks passed, then the entire suite was rerun. The final run in item 6 contains only the two base failures. Lesson: a lower failure count alone is insufficient; compare the actual names.

15. **Run-count cross-check:** console totals are used in item 6. The base TRX contains **20,408 result rows**, including **60 NotExecuted**; final TRX contains **20,433 result rows**, also **60 NotExecuted**. Their passed and failed counts agree with the console. The console reports 32 skipped in each. Both complete runs executed over 20,000 tests; no zero-test or small run was accepted.

16. **Fresh-worktree prerequisites:** initial C: free space was **50.6 GB**, above 8 GB. The first base build stopped at a missing native copy prerequisite, and a later attempt discovered zero tests; neither was counted as the baseline. I copied the existing 75,264-byte `CE_TRANSFORM_2027.arx` from the installed bundle, read-only, into this worktree's ignored native build-output folder. Copied SHA-256: `6438979A92BD4D3C63B4D6DB737AB9C368007A8CB9DE080A4E0BEAD24618FE81`. No native source was edited, no empty stand-in was used, and nothing was written to the installed bundle. Adding AutoCAD's library folder to the test process PATH gave the complete baseline in item 6.

17. **Drawing safety:** this is a warning in a calculator and writes nothing to a drawing. Nothing was added between U and REDO. Locked layers, Xrefs and REFEDIT protection are unaffected. CE_SHARED source, drawing save/undo handlers, all protected drawing-edit files and everything under Modules/Structural are unchanged. The arithmetic, initial values, metre labels and saved-draft format are unchanged.

18. **Pictures inspected and committed:** all six were viewed. The warning text, results, new Settings row and footer fit without clipping or overlap. They are the affected tab/page states at 1080p, scale 1:

   `docs/image/V3_WINDOWS/bug1103-cdcalc-dark-charged-pipe.png`

   `docs/image/V3_WINDOWS/bug1103-cdcalc-light-charged-pipe.png`

   `docs/image/V3_WINDOWS/bug1103-cdcalc-dark-charged-downpipe.png`

   `docs/image/V3_WINDOWS/bug1103-cdcalc-light-charged-downpipe.png`

   `docs/image/V3_WINDOWS/bug1103-settings-dark-design.png`

   `docs/image/V3_WINDOWS/bug1103-settings-light-design.png`

19. **Evidence and undo:** local logs and TRX files are retained under `C:\ce-cx\bd13-evidence`, outside the code worktree. `red.log`, `green-final.log`, `settings-list-green.log`, `base.log` and `after-final.log` hold the quoted results. The primary change is commit `243889c2`; the final test/list and evidence record is `c68c5db4`. To restore the old warning behaviour, CDS → Design → untick **Warn when a Charged System diameter is over 2 m**, Save, then reopen CDCALC. The code branch can also be reverted through its BUG-1103 commits.

20. **Save and privacy:** the code branch was pushed through the required leak-scan hook, which reported clean with the local terms file present (36 terms checked). Six pictures were also inspected by eye. The PR remains draft and open. This report is saved by its own filename only; other chats' files in CE_PLAN are left alone. Final check **26 October 2026, 22:45 AEDT (Melbourne)**.

21. **Cleanup verified:** after the draft PR and report were pushed, `git worktree remove C:\ce-cx\bd13` completed. A readback confirmed that the worktree no longer exists and this report still exists. PR #1806 was read back as OPEN and draft, with head `c68c5db4328a4104808546f6b8519fb27af22413` and base `claude/rel-20261025r`. Both repositories had zero unpushed commits. The report push also passed the leak-scan hook.
