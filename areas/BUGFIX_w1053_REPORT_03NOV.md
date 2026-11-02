# BUGFIX w1053 — BUG-1053 LandXML levels converted to metres (3 Nov 2026)

## FOR TIM

1. **What you will see differently:** import a LandXML file that says millimetres, with a pit cover of 100200. CDIMPORTLANDXML now reads it as 100.20 m (it used to say "cover level 100200 m"). The pit's invert of 100000 now comes in as IL 100 (it used to be thrown out). A metre file gives the same numbers.
2. **If the file names a unit CE cannot convert:** the pit comes in with its levels Unknown and the import report says so. It never blocks.
3. **Draft PR:** #1995, "B-172 BUG-1053", against `claude/rel-20261102a`. One new Settings switch, `xcivilImport.landXmlLevelsConvertedToMetres`, ships ON. OFF gives the old behaviour exactly.
4. **My own mistakes first:** (a) I ran the tests once with `dotnet` missing from the tool PATH and once with my filter mangled by PowerShell. Both runs did nothing, about 10 minutes lost, no side effects. (b) My after-run check of your real settings folders found files that changed. See item 6.
5. **NOT proven:** nobody has opened this in AutoCAD. The tests read the LandXML parser only. I have not seen the review line ("cover level ... m") or an imported pit. The 100.20 comes from the parser; the review wording and the pit insertion read it.
6. **Real-folder check (rule 1):** the before/after listings differ. After my run, files changed in `%APPDATA%\TIM_CE_CADTOOLS` (CD_Settings.json 15270 to 15355 bytes at 05:06:10, CD_RecentValues.json at 05:10, many CE_Admin outbox usage files 04:59 to 05:04, sessions), `CE_CVL_SUITE\logs` and `telemetry`, `CE_STRUC_SUITE\logs`, `CE_CADTOOLS\CE_Admin` and the Manager menu file. My test run ended at 05:03:29. An `acad.exe` started at 05:06:15, so another job is driving AutoCAD against the real folders. CD_Settings.json was written after my run ended, and my tests never call Save. I judge these are not mine, but I cannot prove the 04:59 to 05:03 usage files were not, so I am saying it as the rule requires. Please have someone look at CD_Settings.json (size changed). The full differing lines (name|bytes|last-write; "<=" before, "=>" after) are in the appendix below.
7. **Question for Tim:** a file with no Units element at all is read as metres, as it is today. The carpark wording ("if the unit cannot be established, Unknown") could mean those files should be Unknown. Recommendation: keep metres. LandXML files from Civil 3D always carry Units, and the old tests and real files without them are metre files. Say if you want it stricter.

## Robot case that proves it

Name: **B172_landxml_mm_levels** (not written yet; no AutoCAD was started).
1. Make UNIT-RL-MM.xml: one grated pit P1, `elevRim="100200"`, `<Invert elev="100000"/>`, `<Metric linearUnit="millimeter"/>`. Fresh empty INSUNITS 4 drawing.
2. Type CDIMPORTLANDXML, choose the file, Read source. Check the review line contains "100.2" (cover level) and not "100200".
3. Import to a disposable copy and read P1's cover level: 100.2. Check P1's IL text reads "IL 100".
4. Same file with `linearUnit="meter"` and values 100.200 / 100.000: same cover and IL.
5. **Switch-off control:** before launch set `xcivilImport.landXmlLevelsConvertedToMetres` to false in the settings file (settings are read at AutoCAD start). Step 2 must read "100200" and no IL for P1: this is the old behaviour back.
6. Broken twin: a `linearUnit="furlong"` file must give a blank cover (Unknown) and an import report line "levels are Unknown".

## Technical detail

1. **Fault confirmed on `claude/rel-20261102a` (3fbb9da5)** before building. `Modules/Drainage/Helpers/LandXmlParser.cs` `ParseStruct`: `elevRim` went to `CoverLevel` as written, each `<Invert elev>` was range-checked as metres (`IsReasonableImportedLevel`, 0 to 250 m) and written as `IL {elevStr}`, and `elevSump` was read raw. Position scale (BUG-725) already used the Units element; levels did not.
2. **Fix:** new `DecideLevelFactor` (Units `Metric` or `Imperial` `linearUnit`): metre 1; millimetre 0.001; centimetre 0.01; foot 0.3048; USSurveyFoot 1200/3937; blank or no Units element 1 (as before); any other named unit NaN = Unknown (rim and sump blank, inverts skipped, one report line per pit through `ReportLines`). The factor is applied before the range check. Factor 1 keeps the old strings exactly (metre files byte-identical).
3. **Switch off:** `DecideLevelFactor` returns 1, so every path is the old one.
4. **Files:** `Helpers/LandXmlParser.cs`, `Models/UserSettings.cs`, `REGRESSION_LOG.md`, new `Drainage.Tests/Helpers/Bug1053LandXmlLevelUnitTests.cs` (8 tests: mm, metre, feet, sump, unknown unit, no Units, switch OFF, both start-up reads). CE_SHARED untouched.
5. **Open drafts touching the file** (`gh pr list --search LandXmlParser`): #771, #1708, #1241. I did not read them in full; #1708's scale work is already in the base. No stacking.
6. **Tests:** one project, `CE_CVL_SUITE.Tests` net10, filter `Bug1053|LandXml|Fb16|Fb17|Bug605|C78NewSwitch`: 155 total, 155 passed, 0 failed. AutoCAD 2027 on PATH, placeholder arx present. net48 build of the test project (builds the plugin): 0 errors. I did not add the key to a C-numbered new-switch-defaults file; the new test class pins both reads itself.
7. **Not run:** full suite, Manager tests, the other net8 target.
8. **Env:** TEMP, TMP, CE_LOG_DIR_OVERRIDE, CE_STRUC_SUITE_APPDATA_ROOT under `C:\CE_WORK\scratch\w1053`; at most one other top-level dotnet ran at once (count 0 before each run).

## Appendix: real-folder listing differences (before <=, after =>)

- => TIM_CE_CADTOOLS\CD_RecentValues.json|13197|2026-11-03T05:10:11.0551994+11:00
- => TIM_CE_CADTOOLS\CD_Settings.json|15355|2026-11-03T05:06:10.6984015+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json|544|2026-11-03T05:06:59.3592390+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json|480|2026-11-03T05:06:57.1316933+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_175919_519_11cbe9673eb143c0a3acf226bd3a499c.json|392|2026-11-03T04:59:19.5219052+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_175919_521_5db4e16d8145418cb73aed3c3c99b88f.json|388|2026-11-03T04:59:19.5254671+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_175919_856_8e4871e98d8145f7aab7d2f903de7c5d.json|394|2026-11-03T04:59:19.8570156+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180019_553_28c52cff0cfa40c0a0f590ab40aa50d6.json|388|2026-11-03T05:00:19.5540756+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180032_313_658b791b38eb46479451e59b23814356.json|388|2026-11-03T05:00:32.3144877+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180044_048_21339bd8c02542b9a13b185eb7c78b8b.json|388|2026-11-03T05:00:44.0486583+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180055_560_59ebd28d8204426f9196a46125194264.json|388|2026-11-03T05:00:55.5609698+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180204_731_39bfebea132a4f8a9d572af41239989b.json|392|2026-11-03T05:02:04.7342968+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180204_734_b43b15f26a874ac580b91f4bbc75c33d.json|388|2026-11-03T05:02:04.7373099+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180205_039_1d8b8f0e635f493b8ffd0401a1dc381c.json|394|2026-11-03T05:02:05.0400560+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180300_318_bd62fdf35759409bb0c105f1e243f129.json|389|2026-11-03T05:03:00.3193188+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180315_420_1bbcc5f4e5ba4f20a7932659c1376588.json|389|2026-11-03T05:03:15.4191615+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180327_025_b19b11f5b42d401bb0959c67281dd32d.json|392|2026-11-03T05:03:27.0266109+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180424_136_aa9998d451194fc89e2a1110d0878a70.json|392|2026-11-03T05:04:24.1401169+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180424_138_52253c0b89064630ade882c67f55a8f3.json|388|2026-11-03T05:04:24.1421157+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180424_432_e5dcda1d8dcc4aca9b0720053b002e10.json|394|2026-11-03T05:04:24.4329909+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180518_083_9a356fc6334e44ba985e07486b11d424.json|387|2026-11-03T05:05:18.0834752+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180637_347_34000d3db3234f609e188504c423af59.json|392|2026-11-03T05:06:37.3504654+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180637_349_950c961cf4974c5ead65269a32ee58ee.json|388|2026-11-03T05:06:37.3538279+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180637_634_dfa09bc1d5f8444cb8e5e1344e868380.json|394|2026-11-03T05:06:37.6351460+11:00
- => TIM_CE_CADTOOLS\CE_Admin\outbox\usage\2026-11-02\usage_20261102_180927_472_2ac608ee10b94fb19e9c40b44044eae6.json|388|2026-11-03T05:09:27.4726005+11:00
- => TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json|233|2026-11-03T05:06:29.0060934+11:00
- => TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json|235|2026-11-03T05:06:30.1987472+11:00
- => TIM_CE_CADTOOLS\logs\ce_struc_structured_20261103.log|319113|2026-11-03T05:05:44.3127147+11:00
- => CE_STRUC_SUITE\logs\ce_struc_suite.log|4743663|2026-11-03T05:09:06.2595332+11:00
- => CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261103.jsonl|37227|2026-11-03T05:06:48.4122950+11:00
- => CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json|885|2026-11-03T05:06:56.8566446+11:00
- => CE_CVL_SUITE\logs\ce_cvl_structured_20261103.log|1205669|2026-11-03T05:10:11.9508237+11:00
- => CE_CVL_SUITE\logs\CE_CVL_SUITE.log|3167964|2026-11-03T05:07:00.9349161+11:00
- => CE_CVL_SUITE\logs\native_grip_2027.log|185760|2026-11-03T05:06:28.8785289+11:00
- => CE_CVL_SUITE\telemetry\outbox.jsonl|3|2026-11-03T05:06:32.5864128+11:00
- => CE_CADTOOLS\CE_Admin\manager-menu-state.json|224|2026-11-03T05:06:50.5840025+11:00
- => CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json|228|2026-11-03T05:10:31.8814483+11:00
- => CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix|28808|2026-11-03T05:06:48.4950912+11:00
- <= TIM_CE_CADTOOLS\CD_RecentValues.json|13197|2026-11-03T04:47:23.4685295+11:00
- <= TIM_CE_CADTOOLS\CD_Settings.json|15270|2026-10-04T08:22:30.0000000+11:00
- <= TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_CVL_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json|521|2026-11-03T04:48:55.0325209+11:00
- <= TIM_CE_CADTOOLS\CE_Admin\outbox\machines\CE_STRUC_SUITE__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json|477|2026-11-03T04:48:55.3795093+11:00
- <= TIM_CE_CADTOOLS\CE_Admin\sessions\CE_CVL_SUITE.json|232|2026-11-03T04:48:55.0272632+11:00
- <= TIM_CE_CADTOOLS\CE_Admin\sessions\CE_STRUC_SUITE.json|234|2026-11-03T04:48:55.3606423+11:00
- <= TIM_CE_CADTOOLS\logs\ce_struc_structured_20261103.log|291898|2026-11-03T04:48:51.6252212+11:00
- <= CE_STRUC_SUITE\logs\ce_struc_suite.log|4735775|2026-11-03T04:48:55.1186308+11:00
- <= CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_20261103.jsonl|31022|2026-11-03T04:45:29.1344044+11:00
- <= CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json|885|2026-11-03T04:48:55.1693938+11:00
- <= CE_CVL_SUITE\logs\ce_cvl_structured_20261103.log|1072943|2026-11-03T04:48:55.1039283+11:00
- <= CE_CVL_SUITE\logs\CE_CVL_SUITE.log|3075643|2026-11-03T04:48:55.0999646+11:00
- <= CE_CVL_SUITE\logs\native_grip_2027.log|185328|2026-11-03T04:45:07.9838096+11:00
- <= CE_CVL_SUITE\telemetry\outbox.jsonl|3|2026-11-03T04:45:09.7611892+11:00
- <= CE_CADTOOLS\CE_Admin\manager-menu-state.json|224|2026-11-03T04:45:31.7957167+11:00
- <= CE_CADTOOLS\CE_Admin\outbox\machines\CE_SUITE_MANAGER__tvCFMY3LCa9j9SAX__sOkhYs-36_stPtHp.json|573|2026-11-03T04:48:55.3998642+11:00
- <= CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json|261|2026-11-03T04:48:55.3822780+11:00
- <= CE_CADTOOLS\CE_SUITE_MANAGER\CE_SUITE_MANAGER_MENU.cuix|28808|2026-11-03T04:45:29.2201536+11:00
