1. **ANSWER FIRST — BUG-1174 — BLOCKED at the full-suite gate.** The one-bug change is built and its focused tests pass. Draft PR [#1808](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1808) is open against `claude/rel-20261026u`. It is not ready for a train: the completed after-change suite has one extra failed name. No queue or PDF changes were made to conceal that result.

2. **Branch head.** `cx5/bug-1174-cdwt-says-why-no-window` — `39697c32bcab803ab30e7084f33d6dfce96cad8b`. Pushed, with the privacy hook passing. Only five files changed: the CDWT command, UserSettings, the new tests, the maintained existing Water Tank test and the top regression entry.

3. **Base heads.** The brief named `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`. The first fetch and the final fetch both found `origin/claude/rel-20261026u` at that same head; that is the base used. It did not move, so no merge was needed. Verified that the supplied earlier release head `d3f9c5dfc6241815d587f335a7ae49ca603c58fa` is its ancestor. No master base, rebase, force push or PR merge.

4. **Red and green.** Added the method returning the older null/no-line result first. The requested missing-folder and blank-setting tests failed on null; switch-off passed: 3 total, 2 failed, 1 passed. After implementation, all 12 new cases passed. The final focused run also included the maintained placement check: 13 total, 13 passed, 0 failed. Exact lines and names are below.

5. **Full-suite totals — console output.** Untouched base: **20,539 total; 20,506 passed; 1 failed; 32 skipped**. Completed after-change run: **20,551 total; 20,517 passed; 2 failed; 32 skipped**. Baseline failed `Diagnostic_MessagesReachTheLogFile`; after-change failed that name plus `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`. The extra PDF result means the brief's comparison gate is not met.

6. **What Tim will see once this change is installed.** With the Standard Details folder missing, CDWT will say `[CE] Tank pictures not shown: Standard Details folder not found at <the stored folder>.` once before asking whether to adopt a block already in the drawing or insert a plan block. A blank setting says no folder is set. An existing folder with no tank master drawing says that the master drawing was not found there. The picture window still needs its missing drawing; this change explains why it was skipped.

7. **Exact real-AutoCAD check — pending, for the testing desk.** After a separately authorised test installation, use a disposable Civil test drawing and isolated test settings on AutoCAD 2027 and 2024. Set the Civil Standard Details folder to `C:\Example Job\Missing Standard Details`, which must not exist, with the switch on. Type `CDWT`, then `F2`. Expect exactly one `[CE] Tank pictures not shown: Standard Details folder not found at C:\Example Job\Missing Standard Details.` line before `Water tank: Adopt a block already in the drawing, or Insert a plan block from the office master?`. Escape at that question must place nothing.

8. **Other three native cases.** With a blank folder setting, expect `[CE] Tank pictures not shown: no Standard Details folder is set.` With an existing empty `C:\Example Job\Standard Details` folder, expect `[CE] Tank pictures not shown: no tank master drawing found in Standard Details folder at C:\Example Job\Standard Details.` With the switch off, expect no extra explanation in all three cases and the older questions. Restore the disposable setup afterwards; these steps do not ask anyone to edit Tim's real settings.

9. **Not run and known limits.** No AutoCAD, real tank picture window or real tank master file was opened. Nothing installed, deployed or accepted in AutoCAD. The Settings row was left out under the brief's express exception: a normal row measured **725 px** in the real compiled Settings window in both themes, over the **673 px** limit. The row and all window changes were removed; no window or picture is shipped. The default-on switch remains in the saved settings. The attempted fit check stopped before capture, so there are no new pictures to list or inspect.

10. **Drawing safety and shared-file notice.** Only command-line text is added on the empty-master-path fallback. Other window-opening failures get no new line. The tank placement and existing questions are unchanged. No drawing writes were added: nothing new writes between U and REDO, and locked-layer, Xref and REFEDIT protection is unaffected. CE_SHARED and all protected files are untouched. BUG-1115 (cx_bd17) also touches WaterTankCommand.cs, near the later base-head point-pick section (about lines 498–501); BUG-1174 changes the opening fallback (about base lines 90–99).

---

11. **Implementation and Settings coverage.** `BuildNoTankPicturesLine` receives the stored folder, whether it exists, and an optional switch override. Its default reads `SettingsService.Current.Options.CdwtSaysWhyNoTankPictures`, falling back to on. It performs no folder lookup itself. The command captures the Settings folder once and uses it for both the existing master lookup and the explanation. Folder existence is checked using the same trimming as ResolveMasterPath; the printed value stays as stored, without adding a user name or expanding a relative path. ResolveMasterPath itself is unchanged: blank setting, missing folder and no recognised master all return an empty string.

    `options.cdwtSaysWhyNoTankPictures` has a true initializer and the required `Default: on.` comment. Tests use in-memory deserialisation and an isolated settings scope. Coverage includes fresh and older files, missing options group, empty options group, typed false, true/false round trips, preservation of every other saved key after deserialisation, switch-off for all three reasons, null/whitespace and a relative folder printed as stored. The row/persistence patterns were read; the permitted height exception is why no Settings-window row or view-model change remains.

12. **Tests added and maintained.** New file: `Modules/Drainage.Tests/Commands/WaterTankBug1174Tests.cs`, in `Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj`. Its 12 cases are the three requested tests, a folder-without-master case, three null/whitespace cases, a relative-folder case, the default/older-file/typed-off case, two round trips and the default switch-read case. The existing `Cdwt_IsWaterTanksOnly_AsksOneModeQuestion_AndAppliesThroughTheOneAtomicRunner` check now verifies both the captured Settings folder and the lookup using it; every placement-safety assertion remains.

    Red first, before adding the behaviour:

    ```text
    Failed WaterTank_Bug1174_BlankSetting_SaysNoFolderIsSet [31 ms]
    Expected: "[CE] Tank pictures not shown: no Standard Details folder is set."
    But was:  null
    Failed WaterTank_Bug1174_MissingFolder_LineNamesTheFolder [< 1 ms]
    Expected: "[CE] Tank pictures not shown: Standard Details folder not found at C:\Example Job\Standard Details."
    But was:  null
    Passed WaterTank_Bug1174_SwitchOff_NoLine [1 ms]
    Total tests: 3; Passed: 1; Failed: 2
    ```

    Final focused green, including the maintained existing check:

    ```text
    Passed Cdwt_IsWaterTanksOnly_AsksOneModeQuestion_AndAppliesThroughTheOneAtomicRunner [18 ms]
    Passed TheSwitch_ShipsOn_AnOlderFileLoadsItOn_AndATypedOffIsKept [6 ms]
    Passed WaterTank_Bug1174_BlankSetting_SaysNoFolderIsSet [2 ms]
    Passed WaterTank_Bug1174_FolderWithoutMasterDrawing_SaysWhatIsMissing [1 ms]
    Passed WaterTank_Bug1174_MissingFolder_LineNamesTheFolder [< 1 ms]
    Passed WaterTank_Bug1174_NoOverride_ReadsTheIsolatedSetting [1 ms]
    Passed WaterTank_Bug1174_NullOrWhiteSpaceSetting_SaysNoFolderIsSet(null) [< 1 ms]
    Passed WaterTank_Bug1174_NullOrWhiteSpaceSetting_SaysNoFolderIsSet(" ") [< 1 ms]
    Passed WaterTank_Bug1174_NullOrWhiteSpaceSetting_SaysNoFolderIsSet("\t") [< 1 ms]
    Passed WaterTank_Bug1174_RelativeFolder_IsPrintedAsStoredWithoutExpandingIt [< 1 ms]
    Passed WaterTank_Bug1174_SwitchOff_NoLine [< 1 ms]
    Passed WaterTank_Bug1174_SwitchRoundTrip_KeepsTheTypedChoice(True) [149 ms]
    Passed WaterTank_Bug1174_SwitchRoundTrip_KeepsTheTypedChoice(False) [4 ms]
    Test Run Successful.
    Total tests: 13
    ```

13. **Complete-run evidence and blocking names.** These are the two complete console summaries; stopped runs are not counted as full-suite results:

    ```text
    Untouched base:
    Failed! - Failed: 1, Passed: 20506, Skipped: 32, Total: 20539, Duration: 29 m 1 s
    After change:
    Failed! - Failed: 2, Passed: 20517, Skipped: 32, Total: 20551, Duration: 29 m 4 s
    ```

    Baseline failed name: `CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile`.

    After-change failed names: that same diagnostic test, plus `CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`.

    The outer `SettingsIsolationSetup` also reported that its temporary `CE_CVL_SUITE.log` could not be removed because it was still open, on both complete runs. Raw TRX records include 60 NotExecuted rows in each run, while the console reports 32 skipped. Raw result-row totals are 20,567 before and 20,579 after; the same 28-row difference exists on both sides. The headline totals above quote the console; all before/after comparisons use the same basis. No cause for that reporting difference is claimed.

14. **Rechecks and stopped runs, kept visible.** The PDF failure said `The requested resource is in use. (0x800700AA)`. Its unchanged isolated recheck passed, 1/1, in 21 seconds. A further unfiltered retry then failed `CE_CVL_SUITE.Tests.Core.Messages.CeMessageCentreTests.WorkQueue_DrainGivesUpAtTheTimeout` (expected false, got true), which passed on the base and first complete comparison. That retry was stopped: it could not satisfy the required matching-name gate. No full-suite total is claimed for it. No queue or PDF source/test was edited, excluded or weakened.

    An earlier after-change attempt was stopped after its old source-text assertion rejected the captured Settings variable. That assertion was maintained as described above and passed in the 13-case run and complete comparison. No total is claimed for the earlier stopped attempt either. The complete after-change result is not presented as passing merely because its PDF case passed in isolation.

15. **Builds and safe environment.** All three `Modules/Drainage/CE_CVL_SUITE.csproj` Release builds passed: net48, 0 errors, 6 minutes 46 seconds; net8.0-windows, 0 errors, 11 minutes 25 seconds; net10.0-windows, 0 errors, 7 minutes 50 seconds. Existing warnings remain. No production code changed after those builds; the later edit only maintained the existing source check.

    Every build/test used `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Release and all three reference parameters below. Completed runs also used `-m:1` (the first missing-placeholder build attempt did not):

    ```text
    -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
    -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
    -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
    ```

    Project arguments were absolute paths under `C:\ce-cx\bd20`. Full test runs used `-f net10.0-windows`; after the focused run built the current test assembly, complete comparisons used `--no-build` and no filter. The initial untouched-base build stopped because this fresh worktree lacked `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx`. Added an empty ignored test-only build placeholder at that exact path, as allowed by the brief; no project file changed. AutoCAD 2027 was on the test process PATH. The placeholder was not staged or deployed. No writes under ApplicationPlugins or ProgramData, and no AutoCAD process was started.

16. **Evidence and delivery.** Raw evidence remains in `%TEMP%\ce-bd20`: `baseline.log/.trx`, `red.log/.trx`, `green-final.log/.trx`, `green-guard.log/.trx`, `after-final.log/.trx`, `pdf-recheck.log/.trx`, `after-retry.log`, the three `build-<tfm>.log` files, and `green.log/.trx` for the omitted row's measured fit failure. The first disk check found 44,738,764,800 bytes free on C:. The worktree began clean; there was no takeover WIP to commit. The regression entry is at the very top with the old entries kept. The manual privacy scan and code push hook both passed; the draft's base, head and open/draft state were read back. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited. Undo the code change by reverting commit `39697c32bcab803ab30e7084f33d6dfce96cad8b`; nothing was installed to undo. Report finalised on 27 October 2026, Melbourne time.