# Queue filler report: workflow and command cards (Mon 2 Nov 2026, CE 05 job 022)

## FOR TIM

1. **Answer first:** none of the commands changed by the C-79a, C-79b and C-79c trains or the C-80 candidates has a change-specific card. I queued 15 jobs (500 to 514) that draft those cards from the code, the carpark and the Opus reviews. Every card is marked DRAFT FOR TIM: nothing is approved.
2. **What "has a card" means here:** about a dozen of the commands sit inside an older family card (July to September 2026, in the repo's `docs\CARDS` and `docs\workflows`). Examples: Pit Schedule (PS-01), CDIMPORTXCIVIL (CV-07), CDDESIGN (CDDESIGN_WINDOW_CONTRACT), Inspector and CDCHECK (QA-01), long section (CV-06), Edit Pipe (C2 editor tabs), CDASK (C6 Ask CE). All of those were written before the October changes, so they do not describe what the trains changed.
3. **No card at all that I could find:** Tidy labels, the Grade mismatch window, Recall Last, CDRENUMBER, CDMENU and Repair, CESUPPORT, Updates & Rollback, CE Tools Refresh, the Manager start-up line. The only Structural cards I found (the nine in `C:\CE_PLAN\areas\cards`) are for CEMEMBER, CESETTINGS, CH, DSET, the section mark and the installer, none of them from these trains.
4. **Commands listed:** 75 cards to write in 15 jobs of 5 cards: 60 Civil and Manager (jobs 500 to 511) and 15 Structural (jobs 512 to 514). Many cards cover two or three related PRs, so the PR count is well over 100. The count comes from reading the train lists, not from a code search.
5. **What is NOT proven:** I read the train lists, the Opus pre-reviews, the build register, the old card folders and a file-name and keyword search. I did not read every card in full and I did not read the code for each command, so "no change-specific card" means "none found by name and keyword". Nothing was built, tested or opened in AutoCAD.
6. **Next step for you:** nothing. Team picks the jobs up in order. The cards will come back as drafts for you to approve one batch at a time, about five per sitting, as the review gate asks.

---

## TECHNICAL

### What I read

1. `C:\TimOS\RULES.md` (top section).
2. `C:\CE_PLAN\areas\TRAIN_C79A_PR_LIST_2026-10-31.md` (24 PRs), `TRAIN_C79B_PR_LISTS_2026-11-01.md` (18 in b1, 16 in b2, the c-list), `release-v3-colleagues-TRAIN_C79C_ASSEMBLY_REPORT_2026-11-01.md` (9 PRs).
3. `release-v3-colleagues-BUILD_REGISTER.md`, the C-79 and C-80 plan lines (C-80 is the last FULL train, install Mon 9 Nov; C-81 is hotfix only).
4. The Opus pre-reviews, headline lines: `OPUS_PREREVIEW_BACKLOG_R1` to `R8` (01 Nov), `BACKLOG2_R1`, `R2` (02 Nov), `1981_1983_GROUP`, `1984_1988_GROUP`.
5. Repo `docs\CARDS`, `docs\workflows`, `COMMAND_WORKFLOW_INVENTORY.md` and `CARDS\COMMAND_TO_CARD_COVERAGE.md` on `origin/claude/rel-20261102a` (listing and keyword search only), and `C:\CE_PLAN\areas\cards`.
6. `gh` was not available in the shell, so I did not run `gh pr list`. PR titles come from the train lists and the reviews. I did not check live PR heads.

### Commands by train (as grouped in the jobs)

1. **C-79a (Civil and Manager, 24 PRs):** #1884, #1922 (test isolation, no command); #1882, #1887 (level entry checks); #1888 (label angle in a turned UCS); #1889, #1890 (CDRENUMBER and "Not saved" wording); #1896 (Help pages); #1857 and #1875 (After-MOVE tidy row); #1876, #1936, #1935 (Manager); #1877 (WSUD export); #1878 (CESUPPORT); #1923 (pit label double-click, default must be OFF); #1925 (two Save As Xrefs); #1926 (CHECK THE SCALE); #1947, #1949 (New Pipe notes); #1962 (Inspector red pipe); #1959, #1957 (CDASK From file, CDMENU and Repair); #1928 (New Pipe starting settings). Cards: jobs 502, 503, 504, 505, 510, 511.
2. **C-79b1 (18 PRs):** #1868, #1891, #1892, #1940, #1943, #1945, #1950, #1952, #1880, #1951, #1953, #1955, #1958, #1969, #1970, #1972, #1923. Cards: jobs 502, 504, 505, 506, 507, 509.
3. **C-79b2 (16 PRs):** #1946, #1944, #1960, #1965, #1967, #1874, #1954, #1956, #1897, #1920, #1919, #1927, #1937, #1938, #1939, #1974. Cards: jobs 502, 503, 504, 506, 507, 509, 510.
4. **C-79c (9 PRs):** #1941, #1942, #1881, #1975 to #1980. Cards: jobs 500, 501, 502.
5. **C-80 candidates and older backlog drafts:** #1983, #1984, #1985, #1987, #1982 (held for Tim), #1805, #1806, #1807, #1808, #1809, #1815, #1816, #1423, #1593, #987, #988, #989, #1047, #941, #1799, #1691 (Civil and Manager); #1986, #1988, #1893, #1894, #1886, #1008, #1011, #1012, #1013, #1014, #1457, #1560, #1572, #1579, #1584, #1587, #1596, #1731, #1737 (Structural). The guidebook slices (B-042 and later) and declutter slices B-043d and B-043e are not built yet, so no card can be drafted from code; they need a card before code starts (the gate says so). Cards: jobs 500 to 514.

### Already have a card (family level, history only)

1. Pit Schedule: `docs\CARDS\PS-01_PIT_SCHEDULES.md`, `docs\workflows\C4_*PIT_SCHEDULE*`.
2. CDIMPORTXCIVIL and survey import: `docs\CARDS\CV-07_SURVEY_IMPORT.md`, `C5_C1_READ_ONLY_IMPORT_COMPARISON`, `C5_IMPORT_DECISION_EXAMPLES`.
3. CDDESIGN: `docs\workflows\CDDESIGN_WINDOW_CONTRACT.md`, `CE_DESIGN_GUIDEBOOK_RULESET.md`, `docs\CARDS\CV-02_HYDRAULIC_DESIGN.md`.
4. Inspector, CDCHECK, project review: `docs\CARDS\QA-01_*`, `C1_RULECHECK_GEOMETRY`, `C7_PIPE_LINKAGE_MODEL`.
5. Edit Pipe and label editing: `C2_EDITOR_TABS`, `C2_EXACT_PIPE_LABEL_PREVIEW`, `C0_EXACT_DBTEXT_DOUBLE_CLICK`.
6. Long section: `docs\CARDS\CV-06_*`, `C4_CDPROFILE_*`.
7. CDASK: `AI-01_ASK_CE_MCP_AUTOMATION.md`, `C6_SHARED_CANONICAL_ASK_CE`.
8. CDRULES: `C6_A1_APPROVED_R03_R04_PROPOSALS`, `ES01_SAVED_RULE_SOURCES`.
9. Structural family cards `ST-02`, `ST-03`, `ST-06`, `ST-07`, `ST-09`, and the draft section-mark card (so #1981 is not redrafted).

### Queued jobs (all `# MODEL: sonnet`, read-only, each names its own output file in `C:\CE_PLAN\areas`)

1. `500_cards_import_survey.txt` to `CARD_DRAFTS_IMPORT_SURVEY_02NOV.md`: CDIMPORTXCIVIL results and cancel, CDIMPORTXCIVIL reading the table, Survey Intake, LandXML import.
2. `501_cards_pit_schedule.txt` to `CARD_DRAFTS_PIT_SCHEDULE_02NOV.md`: Pit Schedule row growth, typed cover and two Xrefs, exports and cancel, CDTWL, Edit Pit tank and PP text.
3. `502_cards_labels.txt` to `CARD_DRAFTS_LABELS_02NOV.md`: Tidy labels, After-MOVE tidy row, pit label double-click, label angle and units, copied pit and downpipe tags.
4. `503_cards_new_pipe.txt` to `CARD_DRAFTS_NEW_PIPE_02NOV.md`: Grade mismatch window, Recall Last, starting settings, 10 mm note, outlet-above-inlet and speed table.
5. `504_cards_edit_pipe.txt` to `CARD_DRAFTS_EDIT_PIPE_02NOV.md`: Edit Pipe typed level, could-not-write note, downstream recalculation, lid at RL 0.000, 1 mm uphill and flat warning.
6. `505_cards_inspector_checks.txt` to `CARD_DRAFTS_INSPECTOR_CHECKS_02NOV.md`: Inspector saved record, Inspector colours and units, CDCHECK, saved links and Undo, raingarden outlet.
7. `506_cards_cover_rules.txt` to `CARD_DRAFTS_COVER_RULES_02NOV.md`: one cover figure, Project Review pipe sizes, CDRENUMBER and Not-saved wording, CDRULES roughness, speed table and large-pipe fall.
8. `507_cards_cddesign.txt` to `CARD_DRAFTS_CDDESIGN_02NOV.md`: reuse and Kingston credit, Save Draft, outlet warnings, STORM note, Pump and Rational C.
9. `508_cards_cdcalc_cdwt.txt` to `CARD_DRAFTS_CDCALC_CDWT_02NOV.md`: CDCALC XLSX export, Pipe Flows warnings, Charged System mm warning, CDWT pictures, CDWT typed 0.
10. `509_cards_longsection_misc.txt` to `CARD_DRAFTS_LONGSECTION_MISC_02NOV.md`: long section curve, long section ground line, SOURCE RECREATED, twin detention pipe, CDSL and CDTRENCHGRATEAUDIT wording.
11. `510_cards_civil_startup_help.txt` to `CARD_DRAFTS_CIVIL_STARTUP_HELP_02NOV.md`: CDMENU and Repair, CDASK From file, WSUD export, Help pages, two Save As Xrefs.
12. `511_cards_manager.txt` to `CARD_DRAFTS_MANAGER_02NOV.md`: Updates & Rollback, CE Tools Refresh and start-up line, CESUPPORT zip, Restart disable, CEHEALTH.
13. `512_cards_struc_footings_schedules.txt` to `CARD_DRAFTS_STRUC_FOOTINGS_SCHEDULES_02NOV.md`: footing register, THCL Undo, pier schedule SYNC, STRSCHEDCREATE and REFRESH, subfloor grid and bracing.
14. `513_cards_struc_tags_layouts.txt` to `CARD_DRAFTS_STRUC_TAGS_LAYOUTS_02NOV.md`: tag size on paper, CSREOBAR, Reset Defaults, RC bar count, BP pier warning.
15. `514_cards_struc_sheets_markup.txt` to `CARD_DRAFTS_STRUC_SHEETS_MARKUP_02NOV.md`: Preview drawing updates, CEMARKUPUNDO and OOPS, Notes browser, Save sheet list and title update, C1 and C2 two sizes.

All sit in `C:\CE_PLAN\desk_jobs\team_queue`, sort after 409 and before 990, and none duplicates a file already in `areas` (I listed the folder first; no `CARD_DRAFTS_*` file existed, and each job refuses to overwrite).

### Limits and honest notes

1. **Safety paragraph:** I copied the safety wording from the existing queue-filler job (the same one 100_audit_chunk01 uses), with the extra rules `team_fix_cs1.txt` states. The cs1 text has no separate safety paragraph; its read-only limits are the same ones.
2. **Job 501** has one gap I left in the text: the plastic-pit "PP" PR #1047 has no BUG number in my notes, and the job tells the writer to find it.
3. **Job 509** says the long section command is "CDPROFILE or the long section window (confirm on the line)". I did not confirm it.
4. **Opus model:** none of the 15 jobs is a review of an Undo, locked-layer, Xref or protected-file change, so all are Sonnet. Jobs 502, 504, 505 and 509 ask the writer to state plainly what is written to protected records and Xrefs.
5. **Guidebook (B-042) and declutter (B-043d, e) slices:** no job, because no code or PR exists to draft from. They need Tim's card first.
6. **Not done:** I did not touch any file outside `C:\CE_PLAN\desk_jobs\team_queue` and this report. No git write, no push, no build, no test, no AutoCAD, no robot, no agents.
