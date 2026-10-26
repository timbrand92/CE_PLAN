1. **ANSWER FIRST — BUG-1182: DONE for building and checks outside AutoCAD.** Draft PR [#1800](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1800), open and still a draft. Branch: `cx5/bug-1182-view-history-own-module`. Branch head: `a20ea384bc2a172f643bfa1db9fef80ffedb4ec2`. Base used at the first fetch: `270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1`. Release head at the final code fetch: the same. The brief's recorded head also matches. No rebase; the final merge check was already up to date.

2. **What Tim will see after an authorised installation.** CEMANAGER, a module's View History: Civil's history lists only Civil's release notes, so a colleague checking whether a fix is in their Civil release is no longer shown Manager's changes under Civil's name. Built and checked outside AutoCAD only; not installed or accepted in AutoCAD.

3. **Tests added — red first, then green.** The three exact tests were added under `Modules/Manager.Tests/Services/Bug1182ViewHistoryTests.cs`. With product code still unchanged, only those three were run using `--filter "FullyQualifiedName~Bug1182"`. Exact red lines:

```text
Failed ViewHistory_Bug1182_CivilFolder_IgnoresManagersNotesInTheParent [54 ms]
Expected: "CIVIL-ONLY-NOTE"
But was:  "MANAGER-ONLY-NOTE"
Passed ViewHistory_Bug1182_OwnNotesStillShown [13 ms]
Passed ViewHistory_Bug1182_SwitchTrue_RestoresOldBehaviour [3 ms]
Total tests: 3
Passed: 2
Failed: 1
```

   **Green lines after the change:**

```text
Passed ViewHistory_Bug1182_CivilFolder_IgnoresManagersNotesInTheParent [25 ms]
Passed ViewHistory_Bug1182_OwnNotesStillShown [3 ms]
Passed ViewHistory_Bug1182_SwitchTrue_RestoresOldBehaviour [5 ms]
Test Run Successful.
Total tests: 36
Passed: 36
```

   The 36 cases include exact names for each module, both shared ancestor folders, case differences, partial names, another module's notes inside a bundle, unnamed own notes, unknown bundles, unchanged order/headings/dates, the source guard, and default/broken/plain-true switch checks in `Modules/Manager.Tests/UI/ManagerSwitchFileTests.cs`.

4. **Full Manager suite — before and after.** Untouched base: **1041 total, 1040 passed, 1 skipped, 0 failed**. After the change: **1077 total, 1076 passed, 1 skipped, 0 failed**. Failure names before: none. Failure names after: none. The same skipped test in both runs is `PaletteTile_UsesTheSameCancelFirstPathAsRibbon`. Counts and names were checked in both result files. No placeholder ARX or AutoCAD 2027 PATH change was needed.

5. **All three Manager builds passed.** Release `net48`, `net8.0-windows` and `net10.0-windows` each finished with **0 warnings and 0 errors**. Every build and test used `-p:SkipDevBundle=true -nr:false --disable-build-servers` and all three reference paths supplied in the brief. No deployment.

6. **Exact real AutoCAD check still required.** On a COPY or spare login, prepare a Civil bundle with `Civil_Update_20261023.txt` containing `CIVIL-ONLY-NOTE` and `Manager_Update_20261023.txt` containing `MANAGER-ONLY-NOTE` in its parent. Type **CEMANAGER**, choose **Refresh**, **Module**, **Civil**, **View History**. Right looks like: **CIVIL-ONLY-NOTE only**. Repeat on AutoCAD 2027 and AutoCAD 2024 after an authorised installation. In the spare login only, plain true for `viewHistoryShowsAllModulesNotes` brings both notes back; removing it restores Civil-only history. Do not change Tim's own settings.

7. **Not run and known limit.** AutoCAD and the Manager window on screen were not run. No installation, deployment or on-screen acceptance. No window layout changed and no window pictures were added. Shared-folder notes must use one of the exact recognised prefixes. An unknown bundle name receives only unnamed notes inside its own bundle. No independent Opus review was performed in this job.

---

8. **Real names read before coding, 26 October 2026 evening, Melbourne.** C: had 46.9 GB free at setup, above the 8 GB stop point. No `*_Update_*.txt` files were found anywhere in the new working copy, including ignored folders, or recursively under the installed `ApplicationPlugins` folder. The installer source folder under the office IT Admin folder's `Software/CE CVL SUITE` contained these four matches:
   1. **Civil:** `CE_CVL_SUITE_Update_2026-03-06.txt`.
   2. **Civil:** `CE_CVL_SUITE_Update_2026-03-17.txt`.
   3. **Civil:** `CE_CVL_SUITE_Update_2026-03-18.txt`.
   4. **Civil:** `CE_CVL_SUITE_Update_2026-04-28.txt`.

   Each has the exact `CE_CVL_SUITE` module name before `_Update_`; CVL is Civil's existing module word. No Manager or Structural note files were found. The carpark explicitly provides `Civil_Update_20261023.txt` and `Manager_Update_20261023.txt` for its check. No naming convention was invented. The other recognised full prefixes follow the existing bundle names `CE_SUITE_MANAGER.bundle` and `CE_STRUC_SUITE.bundle`.

9. **Cause, change and overlap.** Re-reading the fetched base confirmed that `ReadUpdateNotes` imported every match from the bundle, parent and grandparent. In `CePluginInstallerService.cs` this job changes only `ReadUpdateNotes`. Exact module prefixes immediately before `_Update_` are compared ignoring case; a longer word cannot pass as Civil. Files without a module word stay only inside their own bundle. Existing folder order, newest-first order within each folder, parsing, headings, dates and wording are unchanged. PR #1445 touches the same file, changing version comparison and adding `CleanVersionText`; this job leaves those parts alone.

10. **Switch meaning and one reader.** Manager's existing `viewHistoryShowsAllModulesNotes` key is inverse: OFF or missing means the correction is active; plain true restores the previous selection. Its constant, single reader and strict-value check sit beside the existing Manager keys in `CeOneGlanceStatus.cs`. The reader is called once before searching folders. A source guard checks that the existing shared reader is used once and no separate switch file is introduced. Every test uses the throw-away switch path through `ManagerTestSwitchSandbox` / `CeManagerSwitches.TestPathOverride`. Tim's real `manager-switches.json` was never opened or written.

11. **Safety and ownership.** Only the two Manager service files, the two test files and the top `REGRESSION_LOG.md` entry changed. No CE_SHARED source, protected drawing files, Installer, signing, staged-update files or manifests edited. The main checkout's other people's untracked work was left alone; this job's working copy started clean. This only chooses text files to read: it writes nothing to a drawing and changes no manifest. Redo safety (nothing writes between U and REDO), locked layers, Xrefs and REFEDIT protection are unaffected. No writes under ApplicationPlugins or ProgramData, and no changes to Tim's settings.

12. **Commands and local evidence.** All .NET project paths were absolute, within `C:\ce-cx\bd18`. Builds used `C:\ce-cx\bd18\Modules\Manager\CE_SUITE_MANAGER.csproj`, `-c Release`, once for each of the three targets. Tests used `C:\ce-cx\bd18\Modules\Manager.Tests\CE_SUITE_MANAGER.Tests.csproj`, `-f net10.0-windows -c Release`. Every call also supplied:

```text
-p:SkipDevBundle=true -nr:false --disable-build-servers
-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
-p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
-p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

   Logs remain outside the working copy at `C:\ce-cx\bd18-base.log`, `bd18-red.log`, `bd18-green.log`, `bd18-after.log` and the three `bd18-build-<target>.log` files. Result files are `C:\ce-cx\bd18-evidence\bd18-base.trx`, `bd18-red.trx`, `bd18-green.trx` and `bd18-after.trx`. Evidence is not part of the code working copy's removal.

13. **Saved work and undo.** Code commits: `bc6c49306e9ee014620db7e846e00bd890041033` and `a20ea384bc2a172f643bfa1db9fef80ffedb4ec2`, both naming BUG-1182. The branch push passed the leak scan. The PR was checked as OPEN, draft, with the correct base and head. This report alone is staged by name in CE_PLAN after fetching and merging `origin/main`. The working copy is removed only after the draft PR and this report have been pushed. Undo: revert these two BUG-1182 commits, or use the inverse switch in an authorised test login. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited.
