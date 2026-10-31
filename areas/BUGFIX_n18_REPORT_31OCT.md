# BUGFIX n18 report: COUNCIL NUMBERS part 2 (B-132), Sat 31 Oct 2026

## FOR TIM

1. **Answer first:** six draft PRs are open (all against claude/rel-20261102a, all titled B-132). Each puts a council's own published number into the council data with its source, warns and never blocks. Every new switch ships ON. Nothing is installed. Nothing has been opened in AutoCAD.
2. **What you will see, bug by bug:**
   1. **BUG-1059, PR 1963.** Maroondah job, DN150 drain at 1 in 100: CDRULES now warns "flatter than the council minimum 1:80" and shows the office ladder 1:100 beside it. Exactly 1 in 80 passes.
   2. **BUG-1058, PR 1964.** Darebin job: the Design Check (CDDASHBOARD) names a 40 m pipe against Darebin's 30 m between pits, with the source. 29 m and 30 m are fine. The office 80 m row now says it is an office figure.
   3. **BUG-1057, PR 1966.** Banyule: a DN225 RCP at 0.80 m/s warns against 1.0 m/s. Maroondah: a DN600 RCP at 5.27 m/s warns against 5.0 m/s. Frankston has its own band too. Builds on the older draft 696.
   4. **BUG-1056, PR 1968.** CDTWL, right after "That is enough.", adds a line for Frankston, Manningham, Banyule (300 mm) and Darebin (400 mm): "Habitable-floor freeboard not checked: no habitable floor level is recorded..." It cannot compare yet because no floor level is stored in a drawing.
   5. **BUG-1104, PR 1971.** CDRULES, Values shows "R-22 tank orifice minimum: 25 mm (Manningham...)" or "not checked". No command can warn on a 15 mm tank orifice yet, because CE stores no tank orifice size. The warning is built and unit-tested for when one exists.
   6. **BUG-1116, PR 1973.** A lot of 1000 m2 or more on the short 5 minute Tc gets one plain note. Flows and storage do not change.
3. **Council figures and where each came from.** I relied on our council notes in C:\CE_PLAN\02_COUNCIL_RULES. I did NOT re-read the council PDFs (they are not reachable from here). No page numbers are recorded except Frankston page 4 (from the Codex audit).
   1. Maroondah minimum grade: DN100 1 in 100, DN150 1 in 80. Maroondah Engineering Development Design Guidelines.
   2. Darebin maximum distance between pits: 30 m. Darebin Legal Point of Discharge Guidelines, June 2025.
   3. Banyule speed 1.0 to 6.0 m/s. Banyule Stormwater Drainage Requirements, 30 Sep 2019.
   4. Frankston speed 0.7 (half full or more), 1.0 (less than half full), 6.0 maximum. Frankston Subdivisional Guidelines, last updated 2005 (an old document).
   5. Maroondah speed 0.75, 1.00, 5.0 maximum. Maroondah Engineering Development Design Guidelines.
   6. Floor clearance: Frankston 300 (OSD Guidelines Sept 2021, page 4), Manningham 300 (OSD Guidelines March 2021), Banyule 300 (all finished floor levels, 2019), Darebin 400 (June 2025).
   7. Tank orifice minimum: Manningham 25 mm, Maroondah 20 mm (already in the data; I added the document name to their source notes).
   8. No two sources disagreed on any of these.
4. **Questions for Tim (not built until you answer):**
   1. **BUG-1060, AS/NZS 3500.3 edition.** Sources disagree: CE's rule R-24 and Kingston's 2025 document say 2021; Darebin's June 2025 document and the regulator page quoted in the audit say 2025 for work started from 20 Oct 2025. Which edition should a fresh profile show, and does an old job keep 2021? Recommendation: show "confirm the edition for this job" until you decide.
   2. **BUG-1056, floor level.** Which floor evidence may CE use: a level typed at the CDTWL prompt, a floor-level block or text, or a pit-schedule field? Recommendation: typed at the prompt.
   3. **BUG-1057, speed check.** CDRULES works out the speed of a full pipe, so I held it to the "half full or more" minimum (Frankston 0.7, Maroondah 0.75) and only showed the "less than half full" figure (1.0). OK? This reverses the earlier draft 696, which left those two blank.
   4. **BUG-1104, tank flows add up to no more than site PSD.** No council source exists in our notes. Which council states it, or is it a CE office rule? Not built.
   5. **BUG-1116.** Is a 5 minute Tc right for a 2,500 m2 residential lot? Only a note was added. Should the 1000 m2 limit become a Settings row?
   6. **BUG-1120, wording.** (a) STORM "None" note: should say "no water-quality treatment". (b) Bayside reuse formula: CE's R-10 text says a formula is known, but the Bayside 2026 note and the profile state none. Two sources disagree. What is the formula? (c) The 0.82 charged-downpipe comment "well-rounded pipe inlet" and the "NCC H2P1" citation are unverified. Nothing built.
   7. **BUG-1100, "ask on every job".** Needs a window (Codex-owned), the job store and an approved card first (review gate), and BUG-1096 first. Not built. Codex brief: after BUG-1096, when the council has no reuse rule (Monash, Bayside), CDDESIGN shows "Needs confirmation" with one question "How is the tank credited?", saves the answer on the job, shows it on reopen. The text now comes from ReuseCreditService.cs lines 61 to 63.
5. **Mistakes of my own:** (a) my first test run failed on a quoting slip in the AutoCAD path (about 10 minutes lost). (b) I ran an empty python command once; it hung for 2 minutes and wrote nothing. (c) The same six council hash pins in KingstonStormFrequencyTests will clash when several PRs merge: keep both sides and re-take each hash from the failing test.
6. **Not tested:** AutoCAD (none), net8, the full test suite, Manager, Structural, the net48 tests (compile only).

## TECHNICAL DETAIL

1. **PRs and heads.**
   1. 1963 BUG-1059 head 9c246a1c, switch checks.councilMinGradeBySize.
   2. 1964 BUG-1058 head 4c845162, switch checks.councilMaxPitSpacing.
   3. 1966 BUG-1057 head 9fa33113, switch checks.councilSpeedBands. Carries the four commits of draft 696 (cherry-picked, conflicts in CouncilProfileModels, RulebookValues, REGRESSION_LOG resolved by keeping both sides).
   4. 1968 BUG-1056 head adc9dbb8, switch checks.councilHabitableFloorFreeboard.
   5. 1971 BUG-1104 head a3c1c6df, switch checks.councilTankOrificeMinimum.
   6. 1973 BUG-1116 head b01bc2c1, switch checks.largeLotTcNote.
   7. PR 1715 (the earlier BLOCKED draft) is open but docs-only, on base rel-20261023m, with no code: I did not build on it.
2. **Tests (net10, focused, never the full suite, one project, with a filter, count not zero).** 1059: 459 of 459, earlier 1104 run had 2 failures of my own, fixed. 1058: 29 of 29 (earlier 414 run, 1 hash pin, fixed). 1057: 1260 of 1260. 1056: 1102 of 1102. 1104: 12 of 12 (first run 1375 of 1376, one wrong assertion of mine, fixed). 1116: 2606 of 2606; two older tests that asserted "no notes at all" now ignore the one new sentence. net48 compile: 0 errors on all six.
3. **Switch defaults** are pinned through DeserializeSettings and DeserializeSettingsTolerant in each PR's own test class, with the OFF case returning the old behaviour.
4. **Protected files for Opus review:** RulebookEngine.cs and RulebookValues.cs (1059, 1057, 1104), RulesCommand.cs (1057, 1104), DetentionTwlService.Describe (1056, two optional parameters; the solver is untouched).
5. **Shared files touched:** UserSettings.cs (one switch each, all six), REGRESSION_LOG.md (all six), council-profiles.json (five). CE_SHARED not touched. No Settings-engine or loader change (new keys in the existing Checks group only), so no N91 needed.
6. **Open drafts on the same files, same base:** UserSettings.cs: 1938, 1939, 1941, 1962. RulebookEngine.cs: 1949. None carries the same change. Older-base drafts 1841, 1848, 1869, 696 (included), 1863 noted.
7. **Robot cases proposed (switch-off control in each):**
   1. N18_grade_maroondah_dn150: CDRULEBOOK Council maroondah, CDRULES All on DN150 20 m inverts 10.200 and 10.000; expect R-03 Warn containing "council minimum 1:80". Control: checks.councilMinGradeBySize false gives Pass "ladder minimum 1:100".
   2. N18_pitspacing_darebin: council darebin, CDDASHBOARD on P1 (0,0) to P2 (40000,0); expect a RUN_LENGTH_COUNCIL row "40.0 m ... 30 m". Control: switch false, no such row.
   3. N18_speed_banyule_min and N18_speed_maroondah_max: DN225 RCP 20 m fall 0.100 (expect "full-bore 0.80 m/s is below the Banyule minimum 1.0"), DN600 RCP 17 m fall 1.000 (expect "5.27 m/s exceeds the Maroondah maximum 5.0"). Control: checks.councilSpeedBands false, both pass.
   4. N18_twl_floor_frankston: council frankston, CDTWL volume 0.5, level 10.10; expect the line after "That is enough." starting "Habitable-floor freeboard not checked". Control: switch false, line absent.
   5. N18_r22_tank_manningham: council manningham, CDRULES Values; expect "R-22 tank orifice minimum: 25 mm (Manningham". Control: switch false, line absent.
   6. N18_tc_lot2500: CDDESIGN on a 2,500 m2 lot; expect "Tc 5 min used for this 2500 m2 lot". Control: checks.largeLotTcNote false, absent.
8. **Things deliberately left:** CDDASHBOARD and pipe-size speed rows still use office speeds; the CDRULES fix planner and New Pipe prefill still use the office grade ladder; Yarra's notes give the same grades and minimum speeds as Maroondah (not filled); garage-floor figures (Manningham 150, Darebin 200) not built.
9. **Real-files compare (names, sizes, last-write; listings kept in the removed scratch folder).** Before: 33,560 lines across TIM_CE_CADTOOLS, CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS and CE_SUITE; after: 33,595. All settings files unchanged: TIM_CE_CADTOOLS\CD_Settings.json 15270 bytes 4 Oct 08:22:30; TIM_CE_CADTOOLS\CS_Settings.json 351713 bytes 31 Mar 13:18:00; CE_STRUC_SUITE\CS_Settings.json 35613 bytes 30 Oct 19:54:14; CE_CVL_SUITE\settings.json 672 bytes 16 Sep 12:13:17. Other files that moved (logs, ledger\suggestions.jsonl, CD_RecentValues.json, CE_Admin outbox usage, sessions, manager-menu-state.json, the manager menu CUIX) changed at 21:50 to 22:10, and acad.exe (process 33700) started at 21:57:34 during my window, with a CE session start in every log at 21:57 to 21:58. My tests ran with CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP and TMP under C:\CE_WORK\scratch\n18 (printed before every run). I believe those changes are from that AutoCAD session, not my runs, but I cannot prove it. CD_RecentValues.json (21:55:15) is the one non-log file to ask CE 05 about.
10. **Cleanup:** worktree C:\CE_WORK\build\n18 removed (the first removal failed because a stray background shell of mine held a folder; stopped and retried). C: free 29.7 GB at start, 29.2 GB after cleaning (others were building too). Finished 22:20 Melbourne.
