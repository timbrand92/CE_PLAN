# ANSWER FIRST — CE automation IDs (22 October brief; completed 23 October 2026, Melbourne)

1. **DONE — draft PR #1527:** https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1527. It remains DRAFT, against `claude/rel-20261022m` as requested.
2. **Branch and final head:** `cx/automation-ids-c60` at `235e0c33acaa8685bc48c6b2893713c593b715bf`. Code was tested at `db729cd6ddf2f9747ea5b7dc8e6d8979d556578b`; the final commit only records the results in REGRESSION_LOG.md. Fetched base `40ee0a36f7960145743954b39859eb6c3af92869`; ancestry checked and final merge reports already up to date. No master merge or rebase.
3. **What Tim will see:** the same windows, words, colours, layout and actions. A robot can find the buttons, tabs and inputs by their IDs and English names. No existing switch default changed. Nothing installed or deployed.
4. **Built:** Release net48, net8.0-windows and net10.0-windows all passed with **0 errors**. Final warning counts: 242 / 210 / 208. Times: 25.11 s / 33.20 s / 36.71 s.
5. **Tested:** final Civil net10 console totals **19,180 total — 19,160 passed, 19 skipped, 1 failed**. The failed test is `BackTest_GlenEira24115_Computed_WithinTolerance`; the untouched release base independently repeats the same failed name and message (34 focused cases: 33 passed, 1 failed). Manager: **853/853 passed**. **26 new checks passed** inside the full Civil run; the focused check including two existing Help render cases passed **28/28**. No new failure remains.
6. **Pictures:** **70 real-window frames committed and inspected**, 58 WPF plus 12 real Help browser/WPF composites, at 96 dpi in the 1920×1080 desktop envelope. Paths are listed below and in the PR. About's existing unshown render clips lower rows, has a pale header and retains its light appearance in both Civil theme contexts; this is recorded for its owner because this brief forbids layout/colour changes. Drawing-dependent previews show their existing placeholders.
7. **Acceptance boundary:** built and unit-tested. AutoCAD and accoreconsole were not started; no live settings were changed. Not installed, not native-accepted. The exact real-AutoCAD check below is for the release/test owner on a disposable copy, after a separately approved installation.

---

1. **Implementation and ownership:** `CivilAutomation.cs` attaches metadata through the existing ThemeService setup for the named Civil windows and palette controls. Existing editor IDs are retained; duplicate framework template IDs are qualified. Names stay distinct after the real editor Ready step copies a combo name into its editable text part. Edit source has only five one-line attribute additions. Civil Help has direct attributes so the same controls work standalone and hosted in Manager. About CE has direct attributes. No protected Edit Pipe, Edit Pit, Edit 2 Pipes or New Pit window/view-model file was edited; no commands, save/undo handlers, C7 code, CE Blocks palette, Structural or Shared source changed.
2. **Purely additive proof:** for SourceEditDialog.xaml, CivilHelpGuideView.xaml and CeVersionWindow.xaml, removing AutomationProperties.AutomationId/Name from base and final XML produces identical XML. The existing one-page pipe/pit composition, CivilEditorShellTheme.xaml and the unchanged dark/light dictionaries are reused. No new style, layout or visible wording.
3. **New test contract:** 24 window/theme cases cover the eleven requested window modes plus the retained Pit fallback, all tabs twice, hidden/disabled controls, template parts, unique/non-empty IDs and names, IDs published by WPF peers and ID stability between themes. The editor Ready step is exercised without creating a native AutoCAD owner. A Loaded-window test invokes Close through WPF UI Automation and checks the import action keeps its ID while its caption changes. An embedded Help test checks direct metadata without a standalone shell. A SHA-256 guard proves Civil's output command registry matches Civil's source when loading Manager's real About DLL.
4. **Raw count detail:** the dotnet console operational totals above are the same convention as the train reports. Civil's TRX contains 19,208 records: 19,161 executed (19,160 passed/1 failed), plus 47 NotExecuted records; the console reports 19,180 total and 19 skipped. No pass is claimed for the additional unexecuted records. The 26 new cases were independently counted in the final TRX and all passed.
5. **Runner corrections, preserved honestly:** the first full Civil run had 33 failures because Manager's transitive content replaced Civil's test command registry; 32 were harness-induced. Manager is now a compile-only reference with its DLL copied explicitly, plus its existing diagnostics dependency. The registry hash guard passes, and the final full run has only the reproduced base failure. Eight initial Manager hygiene failures came from my log redirect being outside TEMP; the final run uses fresh TEMP/TMP with logs inside it and passes 853/853. All paths used were this session's own evidence/temp folders, not live settings or the office folder. Failed-run evidence is retained as civil-registry-collision.* and manager-wrong-temp.*.
6. **Build/test environment:** every command was foreground, with `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Reference parameters: `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRefNet10=C:\TimOS\refs\autocad\autocad-net8-ref`, `_AcadRef100=C:\TimOS\refs\autocad\autocad-net8-ref`, `_AcadRef80=C:\Program Files\Autodesk\AutoCAD 2027`. The misleading autocad-net8-ref directory is the 2027/net10 reference path. AutoCAD 2027 was on PATH; the compile-only native ARX placeholder stayed inside this session's build output. The shared build lock was honoured. No new build/deploy script was created.
7. **Evidence:** `C:\ce-ai60-evidence\final-build-<tfm>.log`, `civil-final-full.log/.trx`, `manager-final-full.log/.trx`, `base-focused.log/.trx`, and `automation-ready-final.log/.trx`. Shipping worktree `C:\ce-ai60`; untouched release verification worktree `C:\ce-ai60-base`. Installed Civil was read at 00:31 on 23 October and reported `3.0.70+40ee0a36f7960145743954b39859eb6c3af92869`, matching the requested base. The Notion Inbox check found no New Work items. Other chats' unsaved work was neither taken over nor staged.
8. **Undo:** revert this branch's additive metadata/test/picture commits. No drawing data or settings migration needs reversing.

---

1. **Exact real-AutoCAD check — preparation:** the release/test owner installs an approved payload containing PR #1527 under its separate authority. Use a new anonymous drawing copy containing two CE 375 mm pipes (P1–P2 and P2–P3), a CE pit P2, and a tagged source DP2. Keep Tim's work drawings and settings files unchanged. Where a command is switched off, use the robot's isolated test settings/profile; do not turn on or save Tim's live switches for this check.
2. **Edit source:** open DP2 by the normal source-edit route. Find `SourceEdit.Tag`, `SourceEdit.ShowLabel`, `SourceEdit.RemoveTag`, `SourceEdit.OK` and `SourceEdit.Cancel` using UI Automation. Check each has its English Name. Put DP3 in the tag input using the value pattern, then invoke Cancel by ID; the drawing remains DP2.
3. **Pipe, pit and batch editors:** run CDEDIT on one pipe, on pit P2, and on both pipes together; run PIT for New Pit. After each window finishes opening, enumerate its WPF buttons, inputs, tabs, selectors and template parts. No AutomationId/Name may be blank; IDs and names must be unique within that window. Focus editable drop-downs and repeat the check after the editor's Ready step. Visit every tab/More page. Invoke Cancel by ID and confirm no drawing change.
4. **Settings CDS:** run CDS. Select Drafting, Pipes & Pits, Design, Survey, Display, Advanced, Newer tools and Fixes through the tab selection pattern. Find every checkbox/button/input by ID, including `AdvancedSettingsDialog.OkCommand` (Save) and `.CancelCommand`. Verify Save exposes its invoke pattern without invoking it. Invoke Cancel; no settings file changes.
5. **Checks:** run CDCHECKS in the isolated test profile. Select both tabs; find Show where, Check again and Close by ID. On a finding with a drawing target, invoke Show where and confirm it zooms to that item; invoke Check again and Close. No drawing item is changed by these actions.
6. **What CE Found:** run CDCHECKCURRENT in its legacy-view test setting. Visit Summary, Items, Attached and Surfaces, selecting a listed item where available. Check IDs/Names again after selection and after reopening. Invoke the visible show/check/close actions by ID; no image matching.
7. **X-Civil import:** run CDIMPORTXCIVIL. Select every tab via UI Automation. Invoke Choose DWG, choose an anonymous test DWG copy, then find and invoke Read source by ID. Verify the same action's ID (`CivilImportWindow.ContinueCaption`) remains stable when its Name/caption becomes Import to drawing. Import only into the disposable drawing if the native test proceeds that far; otherwise invoke Close by ID. Check the disabled controls also retain IDs/Names.
8. **About and Help Centre:** run CE_VERSION and invoke `AboutCE.Close`. Run CDHELP/F1; check `HelpCentre.Guide`, `HelpCentre.OpenInBrowser` and `HelpCentre.Close` both in the standalone Help shell and Manager-hosted Help. Select/read the Help pages and invoke Close by ID. The automated WPF contract covers the browser host and WPF controls; this session did not inspect the native browser's UI Automation subtree inside AutoCAD.
9. **Themes and evidence:** repeat in dark and light using isolated/staged theme preview, then Cancel. Reopen the windows and compare IDs against the first pass. Record the build/head, action, exact ID/Name, result and a screenshot from real AutoCAD; compare the drawing and settings with their starting state. The About render finding needs a native look and a separate layout/colour task if reproduced. No native acceptance is claimed by this report.

---

1. **Committed picture paths:** all 70 below were manually inspected; the native Help captures combine its actual browser surface with its WPF shell, following the existing render test. Files are unchanged screenshots, not mock-ups.
1. **Picture:** `docs/image/V3_WINDOWS/automation-about-dark-main.png`.
2. **Picture:** `docs/image/V3_WINDOWS/automation-about-light-main.png`.
3. **Picture:** `docs/image/V3_WINDOWS/automation-checks-dark-tab-0-0.png`.
4. **Picture:** `docs/image/V3_WINDOWS/automation-checks-dark-tab-0-1.png`.
5. **Picture:** `docs/image/V3_WINDOWS/automation-checks-light-tab-0-0.png`.
6. **Picture:** `docs/image/V3_WINDOWS/automation-checks-light-tab-0-1.png`.
7. **Picture:** `docs/image/V3_WINDOWS/automation-found-dark-tab-0-0.png`.
8. **Picture:** `docs/image/V3_WINDOWS/automation-found-dark-tab-0-1.png`.
9. **Picture:** `docs/image/V3_WINDOWS/automation-found-dark-tab-0-2.png`.
10. **Picture:** `docs/image/V3_WINDOWS/automation-found-dark-tab-0-3.png`.
11. **Picture:** `docs/image/V3_WINDOWS/automation-found-light-tab-0-0.png`.
12. **Picture:** `docs/image/V3_WINDOWS/automation-found-light-tab-0-1.png`.
13. **Picture:** `docs/image/V3_WINDOWS/automation-found-light-tab-0-2.png`.
14. **Picture:** `docs/image/V3_WINDOWS/automation-found-light-tab-0-3.png`.
15. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-cd.png`.
16. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-cdedit.png`.
17. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-design-review.png`.
18. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-import-settings.png`.
19. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-intro.png`.
20. **Picture:** `docs/image/V3_WINDOWS/automation-help-dark-start-draw.png`.
21. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-cd.png`.
22. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-cdedit.png`.
23. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-design-review.png`.
24. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-import-settings.png`.
25. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-intro.png`.
26. **Picture:** `docs/image/V3_WINDOWS/automation-help-light-start-draw.png`.
27. **Picture:** `docs/image/V3_WINDOWS/automation-import-dark-tab-0-0.png`.
28. **Picture:** `docs/image/V3_WINDOWS/automation-import-dark-tab-0-1.png`.
29. **Picture:** `docs/image/V3_WINDOWS/automation-import-dark-tab-0-2.png`.
30. **Picture:** `docs/image/V3_WINDOWS/automation-import-light-tab-0-0.png`.
31. **Picture:** `docs/image/V3_WINDOWS/automation-import-light-tab-0-1.png`.
32. **Picture:** `docs/image/V3_WINDOWS/automation-import-light-tab-0-2.png`.
33. **Picture:** `docs/image/V3_WINDOWS/automation-new-pit-dark-main.png`.
34. **Picture:** `docs/image/V3_WINDOWS/automation-new-pit-light-main.png`.
35. **Picture:** `docs/image/V3_WINDOWS/automation-pipe-dark-main.png`.
36. **Picture:** `docs/image/V3_WINDOWS/automation-pipe-light-main.png`.
37. **Picture:** `docs/image/V3_WINDOWS/automation-pit-dark-main.png`.
38. **Picture:** `docs/image/V3_WINDOWS/automation-pit-light-main.png`.
39. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-0.png`.
40. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-1.png`.
41. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-2.png`.
42. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-3.png`.
43. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-4.png`.
44. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-dark-tab-0-5.png`.
45. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-0.png`.
46. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-1.png`.
47. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-2.png`.
48. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-3.png`.
49. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-4.png`.
50. **Picture:** `docs/image/V3_WINDOWS/automation-retained-pit-light-tab-0-5.png`.
51. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-0.png`.
52. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-1.png`.
53. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-2.png`.
54. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-3.png`.
55. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-4.png`.
56. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-5.png`.
57. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-6.png`.
58. **Picture:** `docs/image/V3_WINDOWS/automation-settings-dark-tab-0-7.png`.
59. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-0.png`.
60. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-1.png`.
61. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-2.png`.
62. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-3.png`.
63. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-4.png`.
64. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-5.png`.
65. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-6.png`.
66. **Picture:** `docs/image/V3_WINDOWS/automation-settings-light-tab-0-7.png`.
67. **Picture:** `docs/image/V3_WINDOWS/automation-source-dark-main.png`.
68. **Picture:** `docs/image/V3_WINDOWS/automation-source-light-main.png`.
69. **Picture:** `docs/image/V3_WINDOWS/automation-two-pipes-dark-main.png`.
70. **Picture:** `docs/image/V3_WINDOWS/automation-two-pipes-light-main.png`.