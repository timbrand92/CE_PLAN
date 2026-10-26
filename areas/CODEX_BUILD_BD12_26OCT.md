BLOCKED — BUG-1111 full-suite comparison

1. **ANSWER FIRST — BUG-1111: full-suite comparison blocked.** The wording change is built and automated-tested. All 13 added cases passed in the first full after-run. The PDF test passed on the base and alone, but failed in both full after-runs. No unrelated PDF change or test weakening has been made. The extra repeat was stopped after that failure returned. The required failing-name comparison has not passed.

2. **Draft PR:** [#1801](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1801), against `claude/rel-20261025r`. Branch: `cx4/bug-1111-predev-c-working-text`.

3. **Branch head:** `efa2fc2bde63a78ec6d36ac2d0050989f5203e99`.

4. **Base head used:** `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. This was the head fetched from `origin/claude/rel-20261025r`, and it matches the head named in the brief. The later fetched head was the same.

5. **Tests added and red first:** 13 cases: nine working-text/switch cases, two dark/light Settings render cases, one Settings row guard and one Settings round-trip case. With product code unchanged, the two core tests ran and both failed. After the change, all 179 focused cases passed, including every requested council test group.

```text
RED: CouncilRuleValues_Bug1111_PreDevWorkingText_ShowsTheNumbersActuallyUsed_ForEveryShippedProfile
  glen-eira uses pervious C 0.35; printed working: (0.3*pervious + 0.9*impervious)/site
  Expected: String containing "0.35 x pervious"
  But was: "(0.3*pervious + 0.9*impervious)/site"
RED: CouncilRuleValues_Bug1111_Whitehorse_WorkingShows035
  Whitehorse uses pervious C 0.35; printed working: (0.3*pervious + 0.9*impervious)/site
  Expected: "(0.35 x pervious + 0.9 x impervious) / site"
  But was: "(0.3*pervious + 0.9*impervious)/site"
GREEN: Passed CouncilRuleValues_Bug1111_PreDevWorkingText_ShowsTheNumbersActuallyUsed_ForEveryShippedProfile
GREEN: Passed CouncilRuleValues_Bug1111_Whitehorse_WorkingShows035
GREEN: Passed CouncilRuleValues_Bug1111_NonStandardFormulaText_IsLeftAsWritten
GREEN: Passed CouncilRuleValues_Bug1111_SwitchOff_KeepsTheStoredText
```

6. **Full suite before:** console total 20,380; 20,347 passed, 1 failed, 32 skipped. The untouched base failed `LoggingServiceThroughputTests.Diagnostic_MessagesReachTheLogFile`: “Queued diagnostic never reached the log file.”

7. **First full suite after:** console total 20,393; 20,359 passed, 2 failed, 32 skipped. All 13 added cases passed. The baseline log failure repeated. The additional failure was `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`, which returned a blank rendered page. That one PDF case then passed in a fresh test process: 1 ran, 1 passed. No PDF code or test was edited.

8. **Final repeated full suite:** Additional verification only; PARTIAL, STOPPED after the extra PDF failure reproduced. The error was “PDF rendering failed: The requested resource is in use. (0x800700AA)”. No full-suite total is claimed for that partial repeat. The complete after-run in point 7 remains the after result: 20,393 console total, 20,359 passed, 2 failed, 32 skipped. The required failing-name comparison is BLOCKED; the cause of the PDF failure has not been established. Investigating or changing that PDF path belongs to a separate bug brief.

9. **What Tim will see on a build containing this change:** CDRULEBOOK on a Whitehorse job, open the before-development C source: the working now reads `(0.35 x pervious + 0.9 x impervious) / site`, matching the 0.35 at zero existing impervious area, instead of 0.3. This is the expected AutoCAD result; it has not been observed on screen.

10. **Exact real-AutoCAD check still required:** CDRULEBOOK on a Whitehorse test copy, open the before-development C source. Right looks like: the working shows 0.35. Also untick Settings > Newer tools > “Council working shows the numbers used” and repeat: the older stored working returns, while the C result stays the same.

11. **How many profiles change their printed working:** 15 of the 22 on the weighted before-development C evidence path. Fourteen replace the wrong 0.3 with 0.35; Maroondah gets spacing only. Five profiles return a fixed C and two weighted profiles keep their descriptive wording.

12. **What was not run:** AutoCAD, the source viewer on screen, installation and deployment. This work is not an AutoCAD acceptance result. The dark/light Settings pictures are off-screen renders of the real Settings markup.

---

1. **Change and shared guard.** `CouncilRuleValues.PreDevelopmentC` passes its optional switch to one internal static `PreDevelopmentWorkingText` helper. Only standard `(a*pervious + b*impervious)/site` working is rebuilt, with InvariantCulture and no forced trailing zeros. Trailing notes are retained exactly. Other wording is unchanged. The numeric result, fixed-C path and fraction cap lines are unchanged.

   The repository search found the used formula leaf in CouncilRuleValues; CouncilSourceViewModel and AutoDesignService only name the field. A source guard pins the used leaf to the helper and permits only one stored-formula read in that class. Neither the council JSON nor CouncilProfileModels.cs was edited.

2. **Switch and Settings.** `detention.councilWorkingTextUsesNumbersInUse` starts on. A missing key loads on; a typed off is retained. The comment includes “Default: on.” Explicit switch parameters and in-memory settings scopes isolate the new rule tests. Settings round-trip checks use the existing synthetic test-owned settings file route; no real settings file is used by the new tests.

   The row uses the existing Newer tools layout, SettingsTickTextStyle, change marking, search, reset and candidate writer. The dark and light tallest-tab measurement is 670 px, within 673 px and the existing stricter 670 px check. All 16 pictures were inspected: no clipping, overlap, scrolling or blank page.

3. **Shipped profile recount.** There are 22 profiles, 18 standard stored strings and 16 of those hold pervious C 0.35. Three of the 18 standard strings belong to fixed-C profiles, so 15 reach weighted working. Seventeen profiles use weighted C in total. The LPD note is on Mornington Peninsula, rather than generic-default as the brief suggested; it is preserved. Banyule still reads 0.3 in its weighted working helper, and its actual fixed-C result remains unchanged.

   The new checks cover weighted endpoints 0 and 1, with the existing cap applied, plus all 22 profiles at fractions 0, 0.35 and 1 with the switch on and off. No numeric disagreement with a council source was identified by these checks. No engineering number was changed.

4. **Builds.** All Release builds passed: net48, net8.0-windows and net10.0-windows, zero errors each. Existing warnings remain. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and these references:

```text
-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
-p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
-p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

   Builds used the absolute project path `C:\ce-cx\bd12\Modules\Drainage\CE_CVL_SUITE.csproj`. Tests used `C:\ce-cx\bd12\Modules\Drainage.Tests\CE_CVL_SUITE.Tests.csproj`, net10.0-windows, Release. After an initial parallel build stalled, later commands used `-m:1`. No new build or deployment script was created.

5. **Focused groups.** CouncilRuleSourceWordsTests, CouncilProfileServiceTests, RuleSourceEvidenceTests and C4ContinuationTests all passed within the 179-case focused run. No old council assertion was changed to accept the old 0.3 text. Existing Settings coverage was extended only for the new row and key; the expected page-field list gained that row.

6. **Result-count detail.** The console omits 28 additional NotExecuted records held in the result files. The untouched base file records 20,408 cases: 20,347 passed, 1 failed, 60 NotExecuted. The first after file records 20,421: 20,359 passed, 2 failed, 60 NotExecuted. The console totals and skipped counts above are copied from the actual final console lines. No zero-test or partial-discovery run is presented as a full result.

7. **Setup corrections.** C: had 50,917,572,608 bytes free at the first check (50.9 GB). The own worktree was created at `C:\ce-cx\bd12` from the required fetched release branch. Other chats’ unsaved files in the main checkout were left alone.

   The first baseline build stopped before tests because the fresh worktree lacked `CE_TRANSFORM_2027.arx`; the main checkout’s copy was zero bytes. I read the existing installed 75,264-byte ARX and copied it only to the ignored worktree build folder. SHA-256: `6438979A92BD4D3C63B4D6DB737AB9C368007A8CB9DE080A4E0BEAD24618FE81`. No installed file was written and no native source was edited.

   The next attempt discovered zero tests because the test process lacked AutoCAD’s DLL folder on PATH. I added `C:\Program Files\Autodesk\AutoCAD 2027` to that process’s PATH and ran the untouched full baseline. The setup failure and zero-test attempt are excluded from all full-suite totals.

8. **Drawing and file safety.** Display only: nothing is written to a drawing, so Redo safety and locked layers, Xrefs and REFEDIT protection are unaffected. No tracked CE_SHARED or protected-file change; nothing under Modules/Structural changed. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited. The council JSON, engineering values and calculation results are unchanged. No install, deploy or AutoCAD start was performed.

9. **Evidence locations.** Raw local results are `C:\ce-cx\bd12-evidence\base.trx`, `red.trx`, `green.trx`, `after.trx`, `pdf-recheck.trx` plus `C:\ce-cx\bd12-after-repeat.log` from the stopped partial repeat. Local console/build logs are `C:\ce-cx\bd12-*.log`. Only this named report is staged in CE_PLAN.

   Committed pictures are `docs/image/V3_WINDOWS/bug1111-settings-dark-1.png` through `bug1111-settings-dark-8.png`, and `bug1111-settings-light-1.png` through `bug1111-settings-light-8.png`. Tabs are Drafting, Pipes & Pits, Design, Survey, Display, Advanced, Newer tools and Fixes. Every individual picture path is listed in PR #1801. The new row is tab 7.

10. **Delivery and undo.** The branch and draft PR are pushed. Manual and hook leak scans passed, with the private terms file present. The final report is committed and pushed by name from CE_PLAN. Delivery ends by removing only the own code worktree `C:\ce-cx\bd12` after the report push. PR #1801 remains open and a draft; it has not been merged, closed or marked ready. Undo the wording change by unticking its comparison switch, or revert the BUG-1111 commit.