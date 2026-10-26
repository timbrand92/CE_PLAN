1. **ANSWER FIRST — BUG-1182: IN PROGRESS.** PR: not opened yet. Branch: cx5/bug-1182-view-history-own-module. Base used and fetched release head: 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1. Branch head at setup: the same. Full Manager base suite is running before edits; red and green checks are pending.

2. **What Tim will see.** CEMANAGER, a module's View History: Civil's history lists only Civil's release notes, so a colleague checking whether a fix is in their Civil release is no longer shown Manager's changes under Civil's name. Not yet built, installed or checked in AutoCAD.

3. **Names checked before coding, 26 October 2026 evening, Melbourne.** No *_Update_*.txt files were found anywhere in this new working copy (including ignored folders), or recursively under the installed ApplicationPlugins folder. The installer source folder, under the office IT Admin folder's Software/CE CVL SUITE, contains exactly these four matches:
   1. **Civil:** CE_CVL_SUITE_Update_2026-03-06.txt.
   2. **Civil:** CE_CVL_SUITE_Update_2026-03-17.txt.
   3. **Civil:** CE_CVL_SUITE_Update_2026-03-18.txt.
   4. **Civil:** CE_CVL_SUITE_Update_2026-04-28.txt.
   Each carries the exact CE_CVL_SUITE module name before _Update_. CVL is Civil's existing module word. No Manager or Structural notes were found. The carpark also explicitly supplies Civil_Update_20261023.txt and Manager_Update_20261023.txt as its check; those spell Civil and Manager before _Update_. No new naming convention is needed.

4. **Scope and overlap.** The cause is still present at the fetched base: ReadUpdateNotes reads every match from the bundle, parent and grandparent. PR #1445 changes CompareVersions and adds CleanVersionText in the same CePluginInstallerService.cs file. This job will keep its change to that file inside ReadUpdateNotes. CE_SHARED, protected drawing files, Installer, signing, manifests and staged-update files will not be edited. The main checkout has other people's untracked work; it was left alone and the new working copy started clean.

5. **Safety.** This only chooses text files to read. It writes nothing to a drawing and changes no manifest. Redo safety (nothing writes between U and REDO), locked layers, Xrefs and REFEDIT protection are unaffected. No real manager-switches.json will be opened or changed. Tests use the existing throw-away switch path.

6. **Real AutoCAD check still required.** On a COPY or spare login, prepare a Civil bundle with Civil_Update_20261023.txt containing CIVIL-ONLY-NOTE and Manager_Update_20261023.txt containing MANAGER-ONLY-NOTE in its parent. Use CEMANAGER, Refresh, Module, Civil, View History. Right looks like CIVIL-ONLY-NOTE only. Repeat in AutoCAD 2027 and 2024 after an authorised installation. In the spare login only, plain true for viewHistoryShowsAllModulesNotes restores both notes; remove it to restore Civil-only history. Do not change Tim's own settings.

7. **Not run and limits.** AutoCAD and the Manager window on screen have not been run. No deployment. No layout changes or pictures are needed for this text-reading correction. Unknown bundle names will not be given another module's ancestor notes. Remaining evidence will be added to this report.

8. **Untouched base suite completed.** Total 1041, passed 1040, skipped 1, failed 0. Failure names: none. Skipped: PaletteTile_UsesTheSameCancelFirstPathAsRibbon. No placeholder ARX or PATH change was needed. All safe build flags and all three reference paths from the brief were supplied. Evidence: C:\ce-cx\bd18-base.log and C:\ce-cx\bd18-evidence\bd18-base.trx. The three named tests have now been added, with product code still unchanged, for the red run.

9. **Red proof before product changes.** Only the three named tests were run with --filter "FullyQualifiedName~Bug1182", with the product files unchanged. Exact lines:

```text
Failed ViewHistory_Bug1182_CivilFolder_IgnoresManagersNotesInTheParent [54 ms]
Expected: "CIVIL-ONLY-NOTE"
But was:  "MANAGER-ONLY-NOTE"
Passed ViewHistory_Bug1182_OwnNotesStillShown [13 ms]
Passed ViewHistory_Bug1182_SwitchTrue_RestoresOldBehaviour [3 ms]
Total tests: 3; Passed: 2; Failed: 1
```

10. **Change now under test.** Only ReadUpdateNotes changes in CePluginInstallerService.cs. Exact prefixes CE_CVL_SUITE or Civil, CE_SUITE_MANAGER or Manager, CE_STRUC_SUITE or Structural must immediately precede _Update_, ignoring case. A longer word cannot pass as Civil. Unnamed notes remain allowed inside their own bundle. Shared ancestors require the matching name. Existing folder order, newest-first order within each folder, parsing, headings and words are unchanged. The inverse viewHistoryShowsAllModulesNotes key uses the same strict Manager reader once per history lookup. Missing or broken means OFF, with the correction active; plain true restores the previous selection. No switch file is created by reading it. Added checks cover the other modules, both ancestors, case, partial names, unnamed notes, order/headings, one shared reader, absent and broken switch files and plain true.

11. **Focused green proof.** All 36 BUG-1182 cases passed, no skips or failures. Exact required passing lines:

```text
Passed ViewHistory_Bug1182_CivilFolder_IgnoresManagersNotesInTheParent [25 ms]
Passed ViewHistory_Bug1182_OwnNotesStillShown [3 ms]
Passed ViewHistory_Bug1182_SwitchTrue_RestoresOldBehaviour [5 ms]
Test Run Successful.
Total tests: 36
Passed: 36
```

Evidence: C:\ce-cx\bd18-green.log and C:\ce-cx\bd18-evidence\bd18-green.trx. Product and tests saved at bc6c4930. Manager's net48, net8.0-windows and net10.0-windows builds are running sequentially with all required safe flags and reference paths. No deploy, no new build script and no changes to CE_SHARED source.

12. **Build checks so far.** Manager Release net48: build succeeded, 0 warnings, 0 errors. Manager Release net8.0-windows: build succeeded, 0 warnings, 0 errors. The net10.0-windows build is underway. Evidence remains outside the working copy at C:\ce-cx\bd18-build-net48.log and C:\ce-cx\bd18-build-net8.0-windows.log. The release head was fetched again and remains 270215aa2ba9540d5b75233acb1d0a0a2a5fc1a1; no merge was needed.
