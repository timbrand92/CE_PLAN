BLOCKED

1. **ANSWER FIRST — BUG-1115:** the CDWT change is built and unit-tested, but the full-suite comparison is blocked by one additional PDF failure. That PDF case also failed alone. No unrelated PDF code was changed. Nothing installed, no AutoCAD pass, and the bug register remains for the desk to mark.

2. **Draft PR:** [#1807 — keep a typed zero for CDWT detention](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1807). Verified OPEN and DRAFT, against `claude/rel-20261026u`. Branch: `cx5/bug-1115-cdwt-typed-zero-detention`.

3. **Heads:** branch pushed at `446980a0747f2440804ad427b4c1163005650681`. Runtime code built and tested at `f3896665d13309b2fd435891faaa0f30a85d87ec`; the last commit updates only REGRESSION_LOG.md. Base used: `origin/claude/rel-20261026u` = `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`, unchanged at the final fetch. Preceding release `origin/claude/rel-20261026t` = `d3f9c5dfc6241815d587f335a7ae49ca603c58fa`; its ancestry into the used base was checked. No master base or rebase.

4. **Tests added and red first:** 11 cases in `Modules/Drainage.Tests/Commands/Bug1115WaterTankDetentionTests.cs`. First, the small method was extracted with the old behaviour unchanged, in commit d2b87228. The three requested tests then gave these lines:

```text
Passed WaterTank_Bug1115_EnterAlone_UsesLibraryFigure
Passed WaterTank_Bug1115_TypedFigure_IsKept
Failed WaterTank_Bug1115_TypedZeroDetention_IsKept
Expected: 0
But was: 1000.0d
Total tests: 3; Passed: 2; Failed: 1
```

5. **Green lines:** after the change, all 11 new cases pass, including in the full run. The final focused run also includes the unchanged prompt-bracket guard: 12 passed, 0 failed.

```text
Passed WaterTank_Bug1115_EnterAlone_UsesLibraryFigure
Passed WaterTank_Bug1115_TypedFigure_IsKept
Passed WaterTank_Bug1115_TypedZeroDetention_IsKept
Passed KeywordPromptMessages_CarryNoBracketTagThatIsNotARealKeyword
Test Run Successful. Total tests: 12; Passed: 12
```

6. **Full-suite totals:** untouched base, before source edits: **20,539 total; 20,505 passed; 32 skipped; 2 failed**, 50 min 9 s. Final code: **20,550 total; 20,515 passed; 32 skipped; 3 failed**, 53 min 13 s. All 11 new cases passed in that full run. The extra PDF failure means the required comparison gate is unmet; it is not presented as a passing suite.

7. **What Tim will see after a separately authorised installation — expected, not seen in AutoCAD:** CDWT on AutoCAD 2022–2026, command-line route: choose a library tank carrying 1,000 L detention, then type 0 at the detention question. It is recorded as all reuse, with 0 L detention, instead of quietly using 1,000 L. Enter alone keeps the library figure. The question text is unchanged. Every shipped tank currently carries 0 L detention, so its result stays as before.

8. **Exact real-AutoCAD check — NOT RUN:** use an Example Job drawing copy in AutoCAD 2024 and a library test tank with **5,000 L total and 1,000 L detention**. Run CDWT, choose that library entry through the normal command-line choices, and at `Detention volume (litres) <1000>:` type `0`. Finish usual placement. Right: **0 L detention, 5,000 L reuse**, with the assigned WT number and the existing callout `5000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE`.

9. **Default and positive checks in real AutoCAD — NOT RUN:** repeat that same tank and press Enter alone at the detention question: right is **1,000 L detention / 4,000 L reuse**. Repeat with typed `400`: right is **400 L detention / 4,600 L reuse**. A non-zero-detention library test tank is a prerequisite; no library was changed for this job.

10. **What was not run / installed:** AutoCAD was not started. No real Settings window, real settings file or real drawing was tested. No installation, deployment, ApplicationPlugins or ProgramData write. No native acceptance is claimed. Only synthetic settings and generated test data were used for the new checks.

11. **Known Settings limit:** the switch `linking.cdwtTypedZeroDetentionIsKept` starts **ON**; OFF returns the older typed-zero reading. A row beside its sibling switches raised the measured page requirement from **670 px to 689 px in both themes**, above **673 px**. Under the brief's explicit exception the row and its supporting changes were removed, with no layout squeezed. No window or new picture changes ship. The flag remains in the settings model and is tested in memory.

---

12. **Failure names, compared from the actual result files:** both base and after fail `CE_CVL_SUITE.Tests.Rules.ScaledPitRecordTests.Timing_ARelinkOf300PipesAgainst300ScaledPits_MeasuresEachPitOnce` and `CE_CVL_SUITE.Tests.Services.LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile`. Both runs also report their temporary CE_CVL_SUITE.log still in use during SettingsIsolationSetup cleanup.

13. **Additional after-run failure:** `CE_CVL_SUITE.Tests.Services.MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`. Base result: **Passed**, 26.2945369 s. After-run: the renderer returned only a blank page, 1 of 1. Isolated repeat on the same checked build: **1 total / 1 failed**, 22.7067 s, same blank-page message. Cause is not established. No full-suite repeat started after that isolated failure. PDF source and its test are unchanged; this failure is not called pre-existing or blamed on the detention change without proof. A separate PDF-rendering check is needed to clear the comparison gate.

14. **Three Release builds, final code f3896665:** net48 **0 errors / 242 warnings**, 2 min 48.63 s; net8.0-windows **0 errors / 216 warnings**, 8 min 43.22 s; net10.0-windows **0 errors / 214 warnings**, 6 min 23.75 s. All exit 0. All three file product versions were read back as `3.0.80+f3896665d13309b2fd435891faaa0f30a85d87ec`.

15. **Safe route:** builds and tests ran in the foreground with `-p:SkipDevBundle=true -nr:false --disable-build-servers`. References were `_AcadRef48=C:\TimOS\refs\autocad\autocad-2024-ref`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\Program Files\Autodesk\AutoCAD 2027`. Civil full suites were Release net10.0-windows. The isolated PDF repeat used the already checked build with `--no-build` and the same safe flags. AutoCAD 2027 was added only to the test process PATH for assembly loading, never launched.

16. **Native build placeholder:** the first untouched-base attempt stopped before tests because the existing copy item could not find CE_TRANSFORM_2027.arx. An ignored, zero-byte placeholder was created only at `C:\ce-cx\bd17\Modules\Shared.Transform.Native2027\bin\x64\Release\CE_TRANSFORM_2027.arx`, then the untouched base was run fully. It is build-only, is not committed, must not ship and proves no native transform behaviour. C: had 48,525,901,824 bytes free at setup, above 8 GB.

17. **Scope and safety:** exactly five branch files: WaterTankCommand.cs, WaterTankCommand.TypedDetention.cs, UserSettings.cs, Bug1115WaterTankDetentionTests.cs and REGRESSION_LOG.md. The main command changes only the original library detention question around lines 498–501; BUG-1174's other work in that file is untouched. No library, TryResolveCapacity, other prompt, tank placement, block or label change. No CE_SHARED source, Structural or protected-file change. Existing placement and drawing-write paths are untouched, so nothing is added between U and REDO, and locked-layer, Xref and REFEDIT protections follow their existing paths. This is source evidence, not an AutoCAD pass.

18. **Why the status is read directly:** the existing PromptPositiveDouble returns true and zero for both Enter alone and typed 0. Removing only its final zero fallback would lose the shown library default. This one question now reads the returned status and uses one internal static ResolveTypedDetention method. Negative numbers remain refused by the same options. The optional switch parameter reads Current settings when omitted; tests provide it directly or use the existing in-memory scope. That scope was inspected: it assigns the supplied object and path without opening or saving the settings file. Autodesk documents separate [Enter-alone and zero controls](https://help.autodesk.com/cloudhelp/2026/ENU/OARX-ManagedRefGuide/files/OARX-ManagedRefGuide-__MEMBERTYPE_Properties_Autodesk_AutoCAD_EditorInput_PromptNumericalOptions.html); the original prompt options and wording are retained.

19. **Settings coverage:** default true; missing root and missing key load true through SettingsService.DeserializeSettings; saved false remains false; both values round-trip without changing any other key; the default parameter reads the in-memory Current switch; switch off returns 1,000 L for typed 0; Enter and typed 400 remain as before; shipped-zero library tanks remain unchanged in both modes.

20. **Validation history retained:** an exploratory render test first had a wrong constant name, corrected before measurement. The attempted Settings row then exceeded the height limit and was omitted. A full run also caught an introduced [CE] prompt tag; it was stopped, the existing question wording restored, all three builds repeated, and the unchanged guard passed in the final 12-case gate. The stopped run is not counted as a full result. No test was weakened or ignored.

21. **Counts note and evidence:** console totals are quoted above. Base TRX has 20,567 results, including 60 NotExecuted; after TRX has 20,578, including 60 NotExecuted. The console reports 32 skipped in both. Raw files: `C:\Temp\bd17-evidence\bd17-base.trx`, `bd17-red.trx`, `bd17-green.trx`, `bd17-final-focused.trx`, `bd17-after-first.trx` and `bd17-pdf-isolated.trx`. Logs: `C:\Temp\bd17-base.log`, `bd17-red.log`, `bd17-green.log`, `bd17-final-focused.log`, `bd17-after-first.log`, `bd17-pdf-isolated.log` and `bd17-build-<target>.log`. Height evidence: `bd17-row-over-height.log` and its TRX. The interrupted prompt-tag run is `bd17-after-interrupted-prefix.log`.

22. **Saved state and undo:** code pushed with a clean leak scan; draft PR remains open and unmerged. Earlier regression-log entries were preserved, with no deletions from the base log. Only this report file is added from C:\CE_PLAN. Undo is to revert this branch's BUG-1115 commits; no installed file has changed. No BUG_CARPARK.md, DESK_LOG.md or QUEUE.md edit.