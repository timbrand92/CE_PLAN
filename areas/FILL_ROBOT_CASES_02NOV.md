# Queue filler report: fixes with no robot case yet (Mon 2 Nov 2026, Melbourne, Sonnet, read-only)

**What this is.** CE 00 asked for every fix on or heading for the Civil/Manager line (`origin/claude/rel-20261102a`) and the Structural line (`origin/claude/rel-20261026s`) that has no robot case, grouped into sets of 4 to 6, with one queued job per set. Nothing was built, run or opened in AutoCAD. The only files written are this report and 24 job files in `C:\CE_PLAN\desk_jobs\team_queue`.

---

## FOR TIM

1. **24 robot-case jobs are queued, covering 137 fixes.** Each job drafts up to five robot cases on paper, each with a deliberately wrong copy that must fail. Nothing for you to test or decide.
2. **Pilot-critical work is first.** The jobs run in number order, 300 to 323. Pipe levels and warnings, cover and checks, the Inspector record family, the council rules rows, detention, import and labels come first. The Structural sets come after the Civil ones.
3. **Expect a lot of "Codex only".** The robot cannot press Export, type into a table cell, use a file picker or place a drawn Pit Schedule. Each job writes a numbered Codex look for any fix it cannot prove, instead of a weak case.
4. **Example.** Job 300 covers the Edit Pipe warning that used to print the same grade figure twice (BUG-1235). The robot case types the pipe, reads the command line, and its wrong copy turns the fix switch off and must fail.
5. **What I could not check.** I matched bug numbers as text against the case files. I did not run anything and did not read any fix's code. A fix may already have a case under a case number that never names the bug; each job re-checks the ledger before drafting.
6. **Not queued (about 90 older fixes).** Mostly Help wording, Manager text, tests-only and document-only changes, plus drafts marked "not built". A second batch can pick up any you want. The list is in section 4.

---

## 1. How the list was made

1. **Sources read.** `C:\TimOS\RULES.md`; the existing jobs in `team_queue` and `team_queue_started`; `C:\CE_PLAN\desk_jobs\team_fix_cs1.txt` and `team_fix_rv19.txt`; the first 3,000 and last 9,000 characters of the BUILD REGISTER; `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (head and headings) and the headings of `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`; the file lists of `C:\Lisp Files\_ACAD_DRIVER\cases` (including the `drafts_*` and `variants` folders) and of `C:\CE_PLAN\areas`.
2. **Fix list.** `gh pr list --state open --limit 300` on Mon 2 Nov: 300 open PRs came back. I checked numbers 1700 to 1988 (the full list was cut off at about #1700 by the 300 limit, so older and already-closed PRs were not checked).
3. **The "has a case" test.** For each PR's bug number I searched all case files and drafts under the cases folder, and the `ROBOT_CASE_DRAFTS_*.md` files in `areas`, for `BUG-<number>`. This is a text match only. It can miss a case that proves a fix but never names the bug (for example N36 proves BUG-1228), and it can count a mention that only says "not drafted".
4. **Already covered, so not queued.** W1246 (#1891), W1892 (#1892), W1952 (#1952) and W658 (#1972) are drafted in `cases\drafts_c79b1_01nov`. S467 cases cover #1921. W1034 and W873 cover #1975 and #1977 (wave-1 draft). Setups exist for #1940 and #1943 (SETUP-DMG-OUTLETROLES and SETUP-DMG-LPD). The cs1 wave-1 bugs 246, 312, 573, 779, 783, 785, 786, 744 and 746 were left to that file.
5. **Left to wave-1's own verdict.** #1976, #1978, #1979 and #1980 (wave-1 says they need a prepared drawing the robot cannot build, notes K1_12 to K1_14, and #1980 is guarded by R16). #1983 (BUG-1268) is Codex-only, note K1_02b. Not repeated here.
6. **Tests-only and docs-only, no robot case possible:** #1884, #1917, #1922, #1840, #1828.

**Count.** In the range 1700 to 1988, 137 older PRs (1700 to 1878) and about 80 newer ones (1879 to 1988) showed no case by name. I queued 137 fix lines in 24 sets. A few lines carry two PRs (for example #1897 with #1920, and #1941 with #1942).

---

## 2. The sets and the files queued

All files are in `C:\CE_PLAN\desk_jobs\team_queue`, all `# MODEL: sonnet`. None needs Opus to run (they only draft). Each job names the ones that need an Opus review before the case itself is run (Undo, REDO, locked layer, Xref). Output files are in `C:\CE_PLAN\areas`, named `ROBOT_CASE_DRAFTS_<SET>_02NOV.md`. Order numbers are 700 to 939, ten per set, clear of wave 1 (600 to 605).

**Civil and Manager, heading for rel-20261102a**

1. **300_robot_cases_set01_pipe_levels.txt:** #1887, #1947, #1967, #1969, #1970, #1927. New Pipe and Edit Pipe level wording and warnings. Reserve if one is already cased: #1919, #1858.
2. **301_robot_cases_set02_cover_and_checks.txt:** #1882, #1897 with #1920, #1949, #1962, #1890, #1889. Cover, pit drop and checking messages.
3. **302_robot_cases_set03_inspector_records.txt:** #1880, #1951, #1953, #1955, #1958. The Inspector reading the saved drawing record. Undo and two-drawing items flagged for Opus or Codex.
4. **303_robot_cases_set04_cdrules_council_rows.txt:** #1963, #1964, #1966, #1968, #1971, #1973. Council rows in CDRULES and Design Check.
5. **304_robot_cases_set05_detention_and_rainfall.txt:** #1950, #1948, #1960, #1965, #1984. #1950 touches Undo and REDO paths.
6. **305_robot_cases_set06_design_drafts_and_reuse.txt:** #1945, #1954, #1956, #1961. Mostly window and Save work, so expect Codex looks.
7. **306_robot_cases_set07_xcivil_import_and_xrefs.txt:** #1982, #1987, #1926, #1925, #1937, #1941 with #1942. Xref items flagged for Opus review.
8. **307_robot_cases_set08_labels_and_units.txt:** #1888, #1924, #1946, #1944, #1923, #1974. Labels, text angle, metre drawings, double-click on a pit label.
9. **308_robot_cases_set09_longsection_and_startup.txt:** #1938, #1939, #1879, #1957, #1959. #1957 and #1959 concern older AutoCAD versions the robot may not have.
10. **309_robot_cases_set10_manager.txt:** #1935, #1936, #1876, #1877, #1878, #1896. #1877 is an Export, so Codex.
11. **310_robot_cases_set11_pit_schedule.txt:** #1881, #1760, #1764, #1765, #1767, #1722. The wave-1 probe found the robot cannot place a drawn Pit Schedule, so most will be Codex looks.

**Civil, installed earlier, no case by bug number**

12. **311_robot_cases_set12_link_records_older.txt:** #1748, #1752, #1758, #1777, #1816, #1712. Pit and pipe link records.
13. **312_robot_cases_set13_checks_older.txt:** #1771, #1848, #1850, #1851, #1841, #1856. CDCHECK, CDRULES, cover and fall tables.
14. **313_robot_cases_set14_landxml_longsection_older.txt:** #1707, #1708, #1773, #1711, #1710, #1709. LandXML import and long section (file picker, so mostly Codex).
15. **314_robot_cases_set15_new_pipe_older.txt:** #1838, #1861, #1846, #1857, #1805, #1700.
16. **315_robot_cases_set16_detention_older.txt:** #1810, #1811, #1801, #1806, #1807, #1852.
17. **316_robot_cases_set17_raingarden_tidy_older.txt:** #1845, #1815, #1847, #1759, #1753, #1813.

**Structural, heading for rel-20261026s**

18. **317_robot_cases_set18_struc_footings.txt:** #1893, #1894, #1898, #1909, #1930, #1988. #1988 touches Undo and OOPS.
19. **318_robot_cases_set19_struc_xclmtxt_sbeam.txt:** #1900, #1902, #1903, #1904, #1905, #1932.
20. **319_robot_cases_set20_struc_tags_layers.txt:** #1895, #1906, #1912, #1913, #1918, #1907. #1912 and #1918 are locked-layer protection items, flagged for Opus review.
21. **320_robot_cases_set21_struc_settings_schedules.txt:** #1886, #1910, #1911, #1986, #1914, #1916.
22. **321_robot_cases_set22_struc_marks_publish.txt:** #1885, #1899, #1901, #1929, #1931, #1908. #1901 is an Xref item.
23. **322_robot_cases_set23_struc_ffl_sm_startup.txt:** #1933, #1934, #1981, #1915. FFL and SM need a picture, so Codex for the visual part.
24. **323_robot_cases_set24_struc_rc_older.txt:** #1729, #1731, #1732, #1736, #1737, #1746. Installed earlier. #1736 is locked-layer and REFEDIT.

Every job: opens with the same safety paragraph as the earlier queue jobs (copied word for word and checked identical to `team_queue_started\010_weakcheck_N06v87.txt`), points at `README_CASES.md` and `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`, names its single output file, and ends "Final message: one line, file path and verdict."

---

## 3. Things worth knowing

1. **Structural may not run on the robot at all.** The only Structural command any robot run has typed is CSREOBAR (memory note, runs 43 to 47). The seven Structural jobs tell the drafter to say so plainly and mark BLOCKED-FOR-ROBOT rather than invent a first prompt.
2. **Two jobs depend on the robot AutoCAD version.** #1957 and #1959 are about AutoCAD 2022 to 2024. If the robot only has 2026 or 2027, they cannot be proven there.
3. **One path was damaged and repaired.** A text-edit step turned a backslash into a hidden control character in the twin-case path in all 24 files. I found it by reading the files back, replaced it, and checked no file still holds one. The path now reads `cases\variants\R09s_new_switch_off_broken.case.txt` (the file exists).
4. **File prefix.** The brief said prefix 3 and "three digits". I used 300 to 323, which sorts after the audit jobs (100 to 122) and before 990. Jobs 021 to 024 from the sibling fillers are untouched.

---

## 4. Not queued (about 90 older fixes), and why

1. **Range 1700 to 1878, no case by name, not queued:** #1701, #1702, #1703, #1704, #1705, #1706, #1713 to #1721, #1724 to #1728, #1738 to #1745, #1747, #1749, #1750, #1751, #1753 (queued), #1754 to #1757, #1761 to #1766, #1768 to #1776, #1781 to #1800, #1802 to #1804, #1808, #1809, #1812, #1814, #1819 to #1827, #1839, #1842 to #1844, #1849, #1854, #1855. Many are Help or wording, Manager, tests-only, "round 2" re-opens of PRs already merged, or stacked drafts. Some of the rest (for example #1704 invert-label sides, #1743 CDEDIT batch, #1717 redesign pit order, #1713 audits in metre drawings) are robot-provable and make a good second batch.
2. **Not examined at all:** open PRs below #1700, and closed or merged PRs. The BUILD REGISTER's items for the earliest trains (C-71 to C-75) have their own proof rows and were not re-read.
3. **Wave 1's own Codex-only list** stays with `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (notes K1_01 to K1_16 and K1_02b).

---

## 5. What was read, built, tested, installed, accepted

1. **Read:** the files listed in section 1, the open PR list and titles, the case-folder listings. No PR diff was read.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **Tim-accepted:** nothing.
3. **Not proven:** that any listed fix lacks a case (text match only); that any fix works; that any case in the queued jobs can be run by the robot.
4. **Housekeeping:** `gh` was not on this shell's PATH, so I added Git and GitHub CLI folders for my own shell only. I used a scratch folder under `C:\CE_WORK\scratch\fill3` for the PR list and a generator script, and deleted it at the end.
