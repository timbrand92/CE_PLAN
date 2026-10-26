1. **ANSWER FIRST — BUG-1178: DONE for build and unit tests.** Draft PR [#1802](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1802). Awaiting real AutoCAD checks and Opus review. Not installed or accepted in AutoCAD.
2. **Branch head:** cx5/bug-1178-shared-mismatch-colleague-words at d2ca1677b8f64fec2566b4b5e6178ea57e279a77. Pushed successfully; leak-scan clean.
3. **Base head used:** origin/claude/rel-20261026u at 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. The brief's head was also 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. A second fetch found the same head; merge reported already up to date. No rebase.
4. **Tests added, red then green:** SharedCopyCheck_Bug1178_NonAdministrator_IsToldToAskTheAdministrator failed first: `Expected: "...s PC are from different releases: ask your CE administrator."` / `But was: "...s PC are from different releases: run the CE installer again."` It then passed. SharedCopyCheck_Bug1178_Administrator_StillToldToRunInstaller and SharedCopyCheck_Bug1178_SwitchTrue_RestoresOldLineForEveryone passed in both runs. Red: 3 total, 2 passed, 1 failed. Green: 3 total, 3 passed, 0 failed.
5. **Full Manager suite:** before 1,041 total, 1,040 passed, 1 skipped, 0 failed; after 1,066 total, 1,065 passed, 1 skipped, 0 failed. Failure names before: none. Failure names after: none. Skipped in both: PaletteTile_UsesTheSameCancelFirstPathAsRibbon.
6. **What Tim will see:** a colleague on a hand-installed PC starts AutoCAD while an older CE plugin loads first: the start-up line now says to ask the CE administrator instead of telling them to run an installer they do not have. The CE administrator keeps the existing installer words.
7. **Exact real-AutoCAD check:** use a spare Windows login with a CE non-administrator profile, copied test bundles and a COPY drawing. Load the older CE plugin first, then this Manager with different shared-file bytes. Press F2. The required line is `CE Manager and another CE plugin on this PC are from different releases: ask your CE administrator.` Repeat with a CE administrator profile: the line must end `run the CE installer again.` Keep Tim's live bundles and settings untouched. These are the carpark's mismatch-on-a-standard-login steps, made specific; they have not been run.
8. **Not run and known limit:** AutoCAD, the Manager window on screen, installation, deployment and Opus review. Offline checks prove the words and comparison rules; they do not prove the older-plugin-first load in real AutoCAD. No real-AutoCAD acceptance is claimed.
9. **Builds:** Manager Release net48, net8.0-windows and net10.0-windows each finished with 0 warnings and 0 errors. No placeholder ARX or AutoCAD PATH change was needed. All commands used the required safe flags and reference parameters.

---

1. **Recorded:** 26 October 2026, Melbourne time. This report covers BUG-1178 only. Drive C: was checked before setup: 45,159,047,168 bytes free (45.2 GB), above the 8 GB minimum.
2. **Owned working copy:** C:\ce-cx\bd19, created from the fetched release branch. The main code checkout had other chats' untracked files; they were not staged, committed or altered. The specified release base superseded the appended master instruction.
3. **Cause rechecked:** CeSharedCopyCheck.Evaluate always returned the installer ending for mismatched hashes. CurrentWarning calls Evaluate; Plugin's start-up mismatch reporter calls CurrentWarning. No caller change was needed.
4. **Existing administrator decision reused:** CeInstallWords.IsAdministrator is the existing shared input for Manager installer wording. Its default calls CeAdminPolicyService.IsCurrentUserAdmin(), the same decision used by CEMANAGER's administrator pages. Evaluate now reads that one input and treats an unreadable decision as false. No administrator item or window was opened, and no second definition was introduced.
5. **Small change:** the internal static MismatchInstruction(bool isAdministrator) chooses the last clause. The first half, module-name fallback, blank/missing/same-file checks, hash comparison and outer try/catch returning null remain unchanged. Existing tests still cover matching bytes, same file, blank/missing paths and locked files.
6. **Inverse switch:** sharedMismatchAlwaysSaysRunInstaller uses CeManagerSwitches and its existing strict reader. Missing key/file, false, empty/broken/unreadable/oversize file mean OFF: the new colleague wording is active. Only a plain true brings back the old installer line for everyone. It was added to the sibling key constants and strict true/false validation list; no new switch mechanism was made. A colleague's choice reads the switch file once through the existing reader.
7. **Switch privacy:** no command read or wrote Tim's real manager-switches.json. The namespace-wide ManagerTestSwitchSandbox sets CeManagerSwitches.TestPathOverride before tests. New switch cases read/write that throw-away default path and remove their files afterwards. Administrator test input is supplied through the existing CeInstallWords seam, so the new tests need no profile or AutoCAD.
8. **Coverage added:** 25 cases: 3 required mismatch cases, 2 bool-helper cases, 1 unreadable-administrator case, 1 source guard, 14 strict switch/default cases, 1 locked/oversize-file case and 3 sibling broken-file/log checks. The source guard checks that the existing administrator input is used and that no drawing or settings-writing calls are added to the check.
9. **Safety:** CE_SHARED source and all protected files are unchanged. No installer, signing or staged-update file changed. This changes only the words of one start-up line and writes nothing to a drawing: REDO safety (nothing writes between U and REDO), locked layers, Xrefs and REFEDIT protection are unaffected. The start-up try/catch remains, so a check error returns null instead of stopping plugin load. No ApplicationPlugins or ProgramData write was made by these commands.
10. **Window references:** the requested one-page window/theme and UX reference documents were consulted. No window was changed, so no new window resources, layouts or pictures were needed.
11. **Files changed:** Modules/Manager/Services/CeSharedCopyCheck.cs; Modules/Manager/Services/CeOneGlanceStatus.cs; Modules/Manager.Tests/Services/CeSharedCopyCheckTests.cs; Modules/Manager.Tests/UI/ManagerSwitchFileTests.cs; REGRESSION_LOG.md. The new regression entry is at the very top and the existing log is retained. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md were not edited.
12. **Undo:** revert commit d2ca1677b8f64fec2566b4b5e6178ea57e279a77. For the wording alone, a plain true for sharedMismatchAlwaysSaysRunInstaller restores the old line. Tim's real switch file was left alone.

**Red evidence — product code unchanged; only the test file differed**

```text
Passed SharedCopyCheck_Bug1178_Administrator_StillToldToRunInstaller
Failed SharedCopyCheck_Bug1178_NonAdministrator_IsToldToAskTheAdministrator
Expected: "...s PC are from different releases: ask your CE administrator."
But was:  "...s PC are from different releases: run the CE installer again."
Passed SharedCopyCheck_Bug1178_SwitchTrue_RestoresOldLineForEveryone
Total tests: 3; Passed: 2; Failed: 1
```

**Green evidence**

```text
Passed SharedCopyCheck_Bug1178_Administrator_StillToldToRunInstaller
Passed SharedCopyCheck_Bug1178_NonAdministrator_IsToldToAskTheAdministrator
Passed SharedCopyCheck_Bug1178_SwitchTrue_RestoresOldLineForEveryone
Test Run Successful. Total tests: 3; Passed: 3
```

**Full suite evidence**

```text
Before: Passed! - Failed: 0, Passed: 1040, Skipped: 1, Total: 1041, Duration: 2 m 33 s
After:  Passed! - Failed: 0, Passed: 1065, Skipped: 1, Total: 1066, Duration: 2 m 50 s
```

1. **Raw evidence retained outside the working copy:** C:\ce-cx\bd19-evidence\base.log and base.trx; red.log and red.trx; green.log and green.trx; after.log and after.trx; build-net48.log; build-net8.0-windows.log; build-net10.0-windows.log. The report quotes the decisive lines; the raw logs retain timing and full commands' results.
2. **Full-suite command:** `dotnet test C:\ce-cx\bd19\Modules\Manager.Tests\CE_SUITE_MANAGER.Tests.csproj -f net10.0-windows -c Release` with every safe/reference flag below, and TRX output to C:\ce-cx\bd19-evidence. The red and green runs add `--filter "FullyQualifiedName~Bug1178"` and normal console verbosity.
3. **Build command:** `dotnet build C:\ce-cx\bd19\Modules\Manager\CE_SUITE_MANAGER.csproj -f <target> -c Release` with every safe/reference flag below, once each for net48, net8.0-windows and net10.0-windows. All ran in the foreground, sequentially.

```text
-p:SkipDevBundle=true -nr:false --disable-build-servers
-p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
-p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
-p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"
```

1. **Further spare-login checks:** with the same mismatch, plain true for sharedMismatchAlwaysSaysRunInstaller must give the installer ending on both profiles. Remove the key and the colleague must again see the administrator ending. With matching shared-file bytes there should be no mismatch line. Repeat the load check in AutoCAD 2027 and 2024/net48 when a test runner is assigned; neither was run here.
2. **Delivery:** draft PR #1802 targets claude/rel-20261026u and remains a draft. The report is staged by its own name in C:\CE_PLAN, merged with origin/main and pushed through the normal leak-scan hook. After both pushes, remove only this job's C:\ce-cx\bd19 working copy; retain the raw evidence folder beside it.
3. **Parked:** no additional bug or feature work was undertaken. The carpark entry remains for the desk to update.