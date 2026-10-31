# BUGFIX n17 report: COUNCIL NUMBERS part 1 (BUG-95, 431, 538, 908, 1094), build B-131, 31 Oct 2026

## FOR TIM (read this part only)

1. **Two draft pull requests are open, built and unit-tested only. Nobody has opened either in AutoCAD.**
   - **#1961 (BUG-538 part):** Manningham's rainwater-tank reuse credit now sits on the Manningham council profile with its source beside it. Nothing changes on a job: still 0.25 x SSR x (roof connected / impervious area), at least 2000 L reuse and 50 m2 roof. A Manningham change is now a profile edit, not a new build. Source: Manningham OSD Guidelines v001.6, March 2021, PDF pp. 12-13 (printed pp. 9-10). I relied on our written note of that document, which says the formula matches "word for word". I did not open the council PDF.
   - **#1962 (BUG-1094):** a pipe flatter than the minimum grade now shows RED in the Inspector. Before, a pipe at 1 in 235 against a 1 in 200 minimum showed amber and only 1 in 241 and flatter showed red, while CDRULES failed both. Switch `grade.inspectorFlatterThanMinimumShowsRed`, ON; OFF gives the old amber band exactly.
2. **No PR for BUG-95, BUG-431 and BUG-908.** In plain words:
   - **BUG-95 (Glen Eira job 24-115 is 30 per cent off):** the sources disagree and I did not guess. Our guidebook note says Glen Eira uses Boyd's method with C 0.35, 1 in 5 storm, 5 min. The shipped Glen Eira profile says Swinburne (OSD4W), 1 in 10 storm. The test sheet quotes a Boyd's sheet. No Glen Eira council note exists in `02_COUNCIL_RULES`.
   - **BUG-431 (Kingston):** the figures the Team item asked for (commercial 1 in 10 storm, 7 min, pre-development C the lower of existing and 0.7) are ALREADY built and sourced on the profile (BUG-251, K02 page 14). What is left is a document-label conflict, not code: our note says "Issue 5, 2025" and AS/NZS 3500.3:2021; the Kingston file on disk is "Version 5, September 2018" and names 3500.3:2015. The profile records 3500.3:2021 as Sourced, for visibility only.
   - **BUG-908 (about 30 numbers in code):** the council ones are covered by BUG-538 below. The rest are not council numbers (pump station constants, sizing limits, orifice constant) and the entry says they need your values. The X-Civil level range (0 to 250 m) already has a fix behind `xcivilImport.levelRangeFollowsSettings`, which ships OFF ("needs Opus review"); I did not flip it.
3. **QUESTIONS FOR TIM (one line each, both sources named):**
   1. **Kingston tank credit:** our notes of Kingston Part A (the 2013 and the "2025" write-ups) say 500 L for a 2000 L tank and 1000 L for a tank of 2500 L or more; CE credits 500 L for each complete 2000 L block (your conservative reading, 10 Jun). A 3000 L tank gets 500 L in CE and 1000 L in the note. Which is right, and which Kingston edition do we cite (Version 5 Sept 2018 on disk, or the "Issue 5 2025" we cannot find)?
   2. **Casey tank credit one third and Casey orifice K 21.9:** no Casey council document is held in the office (only the growth-area guidebook group). Do you have one to cite, or do they stay as your office rule (engineer answers Q5 and Q6)?
   3. **Bayside pump station storm 1 in 20:** no Bayside document we hold says it. Cite a document, or keep it as an office rule?
   4. **Glen Eira 24-115:** which after-development C and which method does the job use, Boyd's (guidebook, sheet) or Swinburne (profile)?
   5. **Inspector grade colour:** should a pipe that passes but is within 20 per cent of the limit get an amber "near the limit" band? I did not invent one.
4. **Mistakes of my own, first:** (a) I ran one net48 compile without the build-slot count check. (b) The first test build failed on the missing empty placeholder `CE_TRANSFORM_2027.arx`; I created the empty file as the job allows. (c) My first two test runs found no tests because AutoCAD 2027 was not on the PATH; no harm, fixed.
5. **Two of your own settings files changed while my work ran:** `CD_Settings.json` (21:14) and `CD_RecentValues.json` (21:19) under `TIM_CE_CADTOOLS`. AutoCAD (acad.exe) was open on this PC and no test of mine was running at either time (my tests ended 21:08, 21:11, 21:17 and 21:18; the 21:14 write fell between builds, the 21:19 write came after my last test). I believe they are your own AutoCAD session, but I cannot prove it. Listings are at the end.
6. **What I did NOT test:** nothing was opened in AutoCAD, so the Inspector colour on a real pipe and CDDESIGN on a real Manningham job are unseen. The net48 test run was not done (net48 compile only). No full suite (focused classes only, per the job). I did not run `RuleSourceEvidenceTests` (it rewrites the profile file in the worktree and restores it). I did not open any council PDF.

---

## TECHNICAL DETAIL

### 1. Per-bug result

1. **BUG-95:** fault still exists. `Modules/Drainage.Tests/Services/AutoDesignBackTestTests.cs` (GE 24-115 fixture); shipped `glen-eira` profile in `Modules/Drainage/Assets/Config/council-profiles.json` line 159 onward: psdMethod swinburne, psdAri 10, storageAri 10, perviousC 0.35, tcMinutes 5. Guidebook note `02_COUNCIL_RULES/CE_DESIGN_GUIDEBOOK_RULESET.md` line 19 (Boyd's list) and line 80 (Glen Eira: Boyd's, C 0.35, 1 in 5, 5 min). Two sources disagree: NOT built. The Opus audit (finding 16, 22 Oct) says the engine is right and the fixture is out of date; that is a test-fixture change needing Tim's word, not a council number.
2. **BUG-431:** ALREADY BUILT for the Team item: profile lines 136-139 (`psdAriBySiteCase`, `tcMinutesBySiteCase`, `tcLotAreaLimitM2BySiteCase`, `preDevCCapBySiteCase`, Sourced, K02 page 14), pinned in `CouncilSweepParityTests.SourcedChanges`. The open part is `editionStatus` "AS/NZS 3500.3:2021" recorded as Sourced (profile lines 66-68) against the K02 file on disk citing 2015 (`04_REFERENCE/release/KINGSTON_K02_READ_2026-10-08.md`). Two sources disagree: NOT changed.
3. **BUG-538 (six items):**
   1. Bayside pump storm 1 in 20: `Services/PumpSizingService.cs` 156-159 and 336-366. The profile field already exists (`pumpStormAri`) but the shipped Bayside profile does not carry it. No Bayside document held states 1 in 20: NOT built (question 3).
   2. Rising main 5 L/s / 50 / 80 mm: ALREADY on Settings (`pumpStation.risingMainSplitLps`, `risingMainSmallMm`, `risingMainLargeMm`; `PumpSizingService.cs` 98-136); the 5/50/80 in code is only the fallback. Office habit, not a council number.
   3. Kingston 500 L per 2000 L: `Services/ReuseCreditService.cs` 31-32; the profile field `reuseCredit` is already supported. The two readings disagree (question 1): NOT built.
   4. Manningham 0.25 / 2000 L / 50 m2: BUILT, PR #1961.
   5. Casey one third: no Casey document: NOT built (question 2).
   6. Casey K 21.9: `Services/OrificeSizer.cs` 55 and `AutoDesignService.cs` 425-440; field `orificeFormulaK` already supported; no Casey document: NOT built (question 2). The 21.9 formula IS published by Frankston (`COUNCIL_FRANKSTON_OSD_2021.md`), a different council.
4. **BUG-908:** audit finding 15. Council parts: same as BUG-538. Non-council parts (pump constants, sizing limits, 0.6 m/s, 600 mm and so on) need Tim's values (entry). X-Civil range: `Services/XcivilLayerRecognition.cs` 89-100 and `Models/UserSettings.cs` 3652-3658, switch exists, default OFF. No PR.
5. **BUG-1094:** fault confirmed on the C-78 line (3fbb9da5): `Services/InspectorPaletteService.cs` about line 3418, `warningThreshold = minGradeDenom * 1.2`. BUILT, PR #1962.

### 2. Council figures and their sources

1. **Manningham reuse credit:** factor 0.25; minimum reuse 2000 L; minimum roof 50 m2. Source: Manningham OSD Guidelines v001.6 (March 2021), PDF pp. 12-13, printed pp. 9-10 (evidence ID MA02). Reliance: our note `02_COUNCIL_RULES/COUNCIL_MANNINGHAM_OSD_2021.md` line 31 ("exactly, word for word"). Original PDF not opened.
2. **Inspector minimum grade (BUG-1094):** office Settings value (Design Standards minimum pipe grade), not a council figure. The 1.2 band was an office habit with no source.

### 3. Switches, shared files, clashes

1. **New switch:** `grade.inspectorFlatterThanMinimumShowsRed` (`GradeSettings.InspectorFlatterThanMinimumShowsRed`), default ON, "Default: on.", pinned through both start-up reads in `B131Bug1094InspectorGradeTests`. No Settings page row (neighbouring grade switches have none). BUG-538 adds no switch (same numbers; removing the profile line returns the old built-in rule).
2. **Shared files touched:** `Modules/Drainage/Models/UserSettings.cs` (#1962, one property), `REGRESSION_LOG.md` (both PRs, new entry at the top), `council-profiles.json` and `Rules/RulebookValues.cs` (#1961: the CDRULES fingerprint now leaves out the source entries of the four fields CDRULES never reads). **CE_SHARED: not touched.** No Settings-engine or loader change; #1961 does touch the CDRULES fingerprint code, so run the area re-test plus N91 for it.
3. **Open-draft clashes seen** (`gh pr list --state open --search <file>`; full-text search, so line overlap is not proven): council-profiles.json: #1855, #1841, #629, #413, #427, #773, #433; UserSettings.cs: #1918, #1927, #1904, #1842, #1938, #1901, #1908, #1909; REGRESSION_LOG.md: many (#1941, #1842, #1938, #1901 and others); InspectorPaletteService.cs: #1880, #1953, #1958 (other code, saved-record reads), #635, #642, #487, #479, #470. Both PRs are based on `claude/rel-20261102a` and not stacked; on a REGRESSION_LOG.md conflict keep both sides.
4. **Guards changed on purpose (#1961):** `CouncilSweepParityTests.SourcedChanges` gains `manningham/reuseCredit`; the `KingstonStormFrequencyTests` Manningham hash goes from EF2BEE6D...D801 to 6085A13A...2B12; the `ReuseCreditProfileRuleTests` shipped-file test now expects Manningham only.

### 4. Tests

1. **#1961 branch:** Civil net10 focused (reuse credit service and profile rule, sweep parity, Kingston guard, profile service, source words, sheet sources, storm frequency, computations record, GB-01 falls, C4, C75/C78 switch defaults, auto-design service, Inspector palette): 357 run, 0 failed. net48 compile of `Modules/Drainage/CE_CVL_SUITE.csproj`: 0 errors.
2. **#1962 branch (rebuilt on its own):** 279 run, 0 failed, plus 59 settings and guard tests, 0 failed. The net48 compile was run on the combined tree before the split (0 errors).
3. **New cases:** `B131Bug1094InspectorGradeTests` (reproduction with switch OFF showing amber, the fix, the old band exactly, switch defaults through both start-up reads, source guard); in `ReuseCreditProfileRuleTests`: the shipped Manningham rule equals the old numbers and gives the same credit, the source is recorded, the profile number really drives the credit, the CDRULES fingerprint is unmoved.
4. Every test command named one csproj and a --filter, ran with the isolation variables set and printed first, with `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:2`, below-normal priority. No Manager tests, no full suite.

### 5. Robot cases (proposed)

1. **N17_insp_grade_red (switch-off control N17_insp_grade_red_off):** draw a 20.000 m pipe with levels 10.000 and 9.915 (fall 0.085 m, 1 in 235), minimum grade 1 in 200; select it; read the Inspector Grade line. Expect "Grade: 1:235 ... (min 1:200)" with the red cross. Control: Settings `grade.inspectorFlatterThanMinimumShowsRed` false, same pipe: amber triangle. A 20 m pipe with 0.105 m fall (1 in 190) is a green tick in both.
2. **N17_manningham_reuse (control: profile line removed):** CDDESIGN, Manningham, SSR 3.0 m3, 5000 L tank plumbed for reuse, roof 80 m2, impervious 160 m2: credit line = 0.25 x 3.0 x 80/160 = 0.375 m3, identical to 3.0.88.

### 6. C: space and timing

1. C: free: about 30 GB at the start (df); 29.6 GB at the first build; 28.93 GB just before cleaning; 29.38 GB after removing the worktree. Other jobs were building at the same time, so the net figure is noisy: removing my worktree and build output moved about +0.45 GB.
2. Worktree `C:\CE_WORK\build\n17` cleaned (`git clean -fdXq`, `git worktree remove`) at 21:20 Melbourne. Scratch `C:\CE_WORK\scratch\n17` removed after this report was written. Local branches kept (pushed): `claude/b131-bug538-manningham-reuse`, `claude/b131-bug1094-inspector-grade-red`, `claude/b131-n17-base`.
3. Finished: 31 Oct 2026, about 21:25 Melbourne (clock read with `date`).

### 7. Real settings folders, before (20:57) and after (21:20): names, sizes, times only

Differences only (all other lines identical); full before and after listings follow in section 8.

1. `TIM_CE_CADTOOLS/CD_RecentValues.json`: 12220 bytes 20:39, then 12241 bytes 21:19.
2. `TIM_CE_CADTOOLS/CD_Settings.json`: 15404 bytes 20:47, then 15350 bytes 21:14.
3. Folder times only: `CE_CADTOOLS/CE_Admin`, `CE_CADTOOLS/CE_SUITE_MANAGER`, `CE_CVL_SUITE/telemetry` (20:48 to 21:14-21:15). `CE_STRUC_SUITE`: unchanged (`CS_Settings.json` 35613 bytes 30 Oct 19:54).

### 8. Full listings

Before (20:57):

```
C:\Users\TimothyBrand\AppData\Roaming/CE_CADTOOLS:
total 17
drwxr-xr-x 1  4096  0 Aug 19 16:17 .
drwxr-xr-x 1  4096  0 Oct 23 18:00 ..
drwxr-xr-x 1  4096  0 Oct 31 20:48 CE_Admin
drwxr-xr-x 1  4096  0 Oct 31 20:48 CE_SUITE_MANAGER
-rw-r--r-- 1  4096 32 Aug 19 16:17 install-id.txt

C:\Users\TimothyBrand\AppData\Roaming/CE_CVL_SUITE:
total 150
drwxr-xr-x 1  4096   0 Sep 16 11:55 .
drwxr-xr-x 1  4096   0 Oct 23 18:00 ..
drwxr-xr-x 1  4096   0 May 12 09:46 feedback
-rw-r--r-- 1  4096   3 Sep  4 15:10 grip-glyph-trial.txt
-rw-r--r-- 1  4096   7 Sep 24 09:34 grip-route.txt
drwxr-xr-x 1  4096   0 Sep 30 14:59 ledger
drwxr-xr-x 1  4096   0 Oct 31 18:47 logs
-rw-r--r-- 1  4096 672 Sep 16 11:55 settings.PRE_WORKSHOP_20260916.json.bak
-rw-r--r-- 1  4096 672 Sep 16 12:13 settings.json
drwxr-xr-x 1  4096   0 Sep 14 16:45 spine-rollback
drwxr-xr-x 1  4096   0 Oct 31 20:48 telemetry

C:\Users\TimothyBrand\AppData\Roaming/CE_STRUC_SUITE:
total 96
drwxr-xr-x 1  4096     0 Oct 30 19:54 .
drwxr-xr-x 1  4096     0 Oct 23 18:00 ..
drwxr-xr-x 1  4096     0 Mar 31  2026 AutoSaveBackups
-rw-r--r-- 1  4096 35613 Oct 30 19:54 CS_Settings.json
-rw-r--r-- 1  4096 34858 Oct 18 10:00 CS_Settings.json.PRE_TIM_YES_20261020.bak
drwxr-xr-x 1  4096     0 Sep 29 14:42 Caches
drwxr-xr-x 1  4096     0 May 14 11:44 ExcelMTextSessions
drwxr-xr-x 1  4096     0 Sep 24 06:33 MarkupAI
drwxr-xr-x 1  4096     0 Oct 21 06:41 logs
drwxr-xr-x 1  4096     0 Oct 14 09:28 projects
drwxr-xr-x 1  4096     0 Jul  8 15:01 telemetry

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS:
total 523
drwxr-xr-x 1  4096      0 Oct 31 20:39 .
drwxr-xr-x 1  4096      0 Oct 23 18:00 ..
drwxr-xr-x 1  4096      0 Mar 18  2026 AutoSaveBackups
drwxr-xr-x 1  4096      0 Mar 13  2026 BeamLearning
-rw-r--r-- 1  4096   8278 Jan 27  2026 CD_ProjectData.json
-rw-r--r-- 1  4096  12220 Oct 31 20:39 CD_RecentValues.json
-rw-r--r-- 1  4096  15404 Oct 31 20:47 CD_Settings.json
-rw-r--r-- 1  4096   8795 Sep 16 09:32 CD_Settings.json.PRE_WORKSHOP_20260916_121735.bak
-rw-r--r-- 1  4096   6944 Jun 12 10:04 CD_Settings.json.bak-2026-06-12
drwxr-xr-x 1  4096      0 Jul  3 12:46 CE_Admin
drwxr-xr-x 1  4096      0 Apr 27  2026 CE_SUITE_MANAGER
-rw-r--r-- 1  4096 351713 Mar 31  2026 CS_Settings.json
drwxr-xr-x 1  4096      0 Jun 22 16:28 Caches
drwxr-xr-x 1  4096      0 Mar 19  2026 ExcelMTextSessions
drwxr-xr-x 1  4096      0 Mar 11  2026 MarkupAI
drwxr-xr-x 1  4096      0 Jan 14  2026 exports
drwxr-xr-x 1  4096      0 May 11 16:13 feedback
-rw-r--r-- 1  4096     32 May 12 14:52 install_salt.bin
-rw-r--r-- 1  4096    314 Jan 14  2026 jobtime_resume.json
-rw-r--r-- 1  4096    526 Apr 28  2026 label_styles.json
-rw-r--r-- 1  4096      6 Oct 31 07:12 last_version.txt
drwxr-xr-x 1  4096      0 Oct 31 06:01 logs
-rw-r--r-- 1  4096   5910 Sep 15 15:33 parts_catalogue.json
drwxr-xr-x 1  4096      0 Feb 19  2026 projects
-rw-r--r-- 1  4096   1390 Dec 19  2025 theme.json
C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin:
total 21
drwxr-xr-x 1  4096   0 Jul  3 12:46 .
drwxr-xr-x 1  4096   0 Oct 31 20:39 ..
drwxr-xr-x 1  4096   0 Apr 20  2026 logs
-rw-r--r-- 1  4096 204 Apr 28  2026 manager-menu-state.json
drwxr-xr-x 1  4096   0 Apr 28  2026 outbox
drwxr-xr-x 1  4096   0 Apr 20  2026 policies
-rw-r--r-- 1  4096 772 Jul  3 12:46 seat_tokens.txt
drwxr-xr-x 1  4096   0 Apr 20  2026 sessions

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/logs:
total 4
drwxr-xr-x 1  4096 0 Apr 20  2026 .
drwxr-xr-x 1  4096 0 Jul  3 12:46 ..

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/outbox:
total 136
drwxr-xr-x 1  4096 0 Apr 28  2026 .
drwxr-xr-x 1  4096 0 Jul  3 12:46 ..
drwxr-xr-x 1  4096 0 Oct 31 14:17 failures
drwxr-xr-x 1  4096 0 Oct  8 06:34 machines
drwxr-xr-x 1  4096 0 Apr 28  2026 support-bundles
drwxr-xr-x 1  4096 0 Oct 31 11:01 usage

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/outbox/failures:
total 1308
drwxr-xr-x 1  4096 0 Oct 31 14:17 .
drwxr-xr-x 1  4096 0 Apr 28  2026 ..
drwxr-xr-x 1  4096 0 Apr 21  2026 2026-04-20
drwxr-xr-x 1  4096 0 Apr 21  2026 2026-04-21
drwxr-xr-x 1  4096 0 Apr 27  2026 2026-04-26
drwxr-xr-x 1  4096 0 Apr 28  2026 2026-04-27
drwxr-xr-x 1  4096 0 Apr 28  2026 2026-04-28
drwxr-xr-x 1  4096 0 May  1  2026 2026-04-30
drwxr-xr-x 1  4096 0 May  1  2026 2026-05-01
drwxr-xr-x 1  4096 0 May  4 08:58 2026-05-03
drwxr-xr-x 1  4096 0 May  5 09:27 2026-05-04
drwxr-xr-x 1  4096 0 May  6 08:46 2026-05-05
drwxr-xr-x 1  4096 0 May  7 09:59 2026-05-06
```

After (21:20):

```
C:\Users\TimothyBrand\AppData\Roaming/CE_CADTOOLS:
total 17
drwxr-xr-x 1  4096  0 Aug 19 16:17 .
drwxr-xr-x 1  4096  0 Oct 23 18:00 ..
drwxr-xr-x 1  4096  0 Oct 31 21:15 CE_Admin
drwxr-xr-x 1  4096  0 Oct 31 21:15 CE_SUITE_MANAGER
-rw-r--r-- 1  4096 32 Aug 19 16:17 install-id.txt

C:\Users\TimothyBrand\AppData\Roaming/CE_CVL_SUITE:
total 150
drwxr-xr-x 1  4096   0 Sep 16 11:55 .
drwxr-xr-x 1  4096   0 Oct 23 18:00 ..
drwxr-xr-x 1  4096   0 May 12 09:46 feedback
-rw-r--r-- 1  4096   3 Sep  4 15:10 grip-glyph-trial.txt
-rw-r--r-- 1  4096   7 Sep 24 09:34 grip-route.txt
drwxr-xr-x 1  4096   0 Sep 30 14:59 ledger
drwxr-xr-x 1  4096   0 Oct 31 18:47 logs
-rw-r--r-- 1  4096 672 Sep 16 11:55 settings.PRE_WORKSHOP_20260916.json.bak
-rw-r--r-- 1  4096 672 Sep 16 12:13 settings.json
drwxr-xr-x 1  4096   0 Sep 14 16:45 spine-rollback
drwxr-xr-x 1  4096   0 Oct 31 21:14 telemetry

C:\Users\TimothyBrand\AppData\Roaming/CE_STRUC_SUITE:
total 96
drwxr-xr-x 1  4096     0 Oct 30 19:54 .
drwxr-xr-x 1  4096     0 Oct 23 18:00 ..
drwxr-xr-x 1  4096     0 Mar 31  2026 AutoSaveBackups
-rw-r--r-- 1  4096 35613 Oct 30 19:54 CS_Settings.json
-rw-r--r-- 1  4096 34858 Oct 18 10:00 CS_Settings.json.PRE_TIM_YES_20261020.bak
drwxr-xr-x 1  4096     0 Sep 29 14:42 Caches
drwxr-xr-x 1  4096     0 May 14 11:44 ExcelMTextSessions
drwxr-xr-x 1  4096     0 Sep 24 06:33 MarkupAI
drwxr-xr-x 1  4096     0 Oct 21 06:41 logs
drwxr-xr-x 1  4096     0 Oct 14 09:28 projects
drwxr-xr-x 1  4096     0 Jul  8 15:01 telemetry

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS:
total 523
drwxr-xr-x 1  4096      0 Oct 31 21:19 .
drwxr-xr-x 1  4096      0 Oct 23 18:00 ..
drwxr-xr-x 1  4096      0 Mar 18  2026 AutoSaveBackups
drwxr-xr-x 1  4096      0 Mar 13  2026 BeamLearning
-rw-r--r-- 1  4096   8278 Jan 27  2026 CD_ProjectData.json
-rw-r--r-- 1  4096  12241 Oct 31 21:19 CD_RecentValues.json
-rw-r--r-- 1  4096  15350 Oct 31 21:14 CD_Settings.json
-rw-r--r-- 1  4096   8795 Sep 16 09:32 CD_Settings.json.PRE_WORKSHOP_20260916_121735.bak
-rw-r--r-- 1  4096   6944 Jun 12 10:04 CD_Settings.json.bak-2026-06-12
drwxr-xr-x 1  4096      0 Jul  3 12:46 CE_Admin
drwxr-xr-x 1  4096      0 Apr 27  2026 CE_SUITE_MANAGER
-rw-r--r-- 1  4096 351713 Mar 31  2026 CS_Settings.json
drwxr-xr-x 1  4096      0 Jun 22 16:28 Caches
drwxr-xr-x 1  4096      0 Mar 19  2026 ExcelMTextSessions
drwxr-xr-x 1  4096      0 Mar 11  2026 MarkupAI
drwxr-xr-x 1  4096      0 Jan 14  2026 exports
drwxr-xr-x 1  4096      0 May 11 16:13 feedback
-rw-r--r-- 1  4096     32 May 12 14:52 install_salt.bin
-rw-r--r-- 1  4096    314 Jan 14  2026 jobtime_resume.json
-rw-r--r-- 1  4096    526 Apr 28  2026 label_styles.json
-rw-r--r-- 1  4096      6 Oct 31 07:12 last_version.txt
drwxr-xr-x 1  4096      0 Oct 31 06:01 logs
-rw-r--r-- 1  4096   5910 Sep 15 15:33 parts_catalogue.json
drwxr-xr-x 1  4096      0 Feb 19  2026 projects
-rw-r--r-- 1  4096   1390 Dec 19  2025 theme.json
C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin:
total 21
drwxr-xr-x 1  4096   0 Jul  3 12:46 .
drwxr-xr-x 1  4096   0 Oct 31 21:19 ..
drwxr-xr-x 1  4096   0 Apr 20  2026 logs
-rw-r--r-- 1  4096 204 Apr 28  2026 manager-menu-state.json
drwxr-xr-x 1  4096   0 Apr 28  2026 outbox
drwxr-xr-x 1  4096   0 Apr 20  2026 policies
-rw-r--r-- 1  4096 772 Jul  3 12:46 seat_tokens.txt
drwxr-xr-x 1  4096   0 Apr 20  2026 sessions

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/logs:
total 4
drwxr-xr-x 1  4096 0 Apr 20  2026 .
drwxr-xr-x 1  4096 0 Jul  3 12:46 ..

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/outbox:
total 136
drwxr-xr-x 1  4096 0 Apr 28  2026 .
drwxr-xr-x 1  4096 0 Jul  3 12:46 ..
drwxr-xr-x 1  4096 0 Oct 31 14:17 failures
drwxr-xr-x 1  4096 0 Oct  8 06:34 machines
drwxr-xr-x 1  4096 0 Apr 28  2026 support-bundles
drwxr-xr-x 1  4096 0 Oct 31 11:01 usage

C:\Users\TimothyBrand\AppData\Roaming/TIM_CE_CADTOOLS/CE_Admin/outbox/failures:
total 1312
drwxr-xr-x 1  4096 0 Oct 31 14:17 .
drwxr-xr-x 1  4096 0 Apr 28  2026 ..
drwxr-xr-x 1  4096 0 Apr 21  2026 2026-04-20
drwxr-xr-x 1  4096 0 Apr 21  2026 2026-04-21
drwxr-xr-x 1  4096 0 Apr 27  2026 2026-04-26
drwxr-xr-x 1  4096 0 Apr 28  2026 2026-04-27
drwxr-xr-x 1  4096 0 Apr 28  2026 2026-04-28
drwxr-xr-x 1  4096 0 May  1  2026 2026-04-30
drwxr-xr-x 1  4096 0 May  1  2026 2026-05-01
drwxr-xr-x 1  4096 0 May  4 08:58 2026-05-03
drwxr-xr-x 1  4096 0 May  5 09:27 2026-05-04
drwxr-xr-x 1  4096 0 May  6 08:46 2026-05-05
drwxr-xr-x 1  4096 0 May  7 09:59 2026-05-06
```
